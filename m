From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/6] Negation magic pathspec
Date: Wed, 12 Oct 2011 09:44:37 +1100
Message-ID: <1318373083-13840-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 00:45:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDl4F-0006hH-SH
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 00:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525Ab1JKWoz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Oct 2011 18:44:55 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35345 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab1JKWoy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 18:44:54 -0400
Received: by vcbgb30 with SMTP id gb30so85726vcb.19
        for <git@vger.kernel.org>; Tue, 11 Oct 2011 15:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=tQBeVc1467bGAbFxayQekQsvgxk3pN6/rmRyAagWo7E=;
        b=NUmuwAPrF0ecu35Iyjn5BAB4NCPPqEz9UG6qv/VXRp/GPUEW6nsVhCHvSiucpUjv7L
         +kaRd4b/fcmoK8PQ18O11eAcM8IjQLt03zm5MTcdNQ4Z2/GDCerRW8pok02oyFe4u9ym
         YwpkpBLkkdOOPL8sR3tyDzbC6RAs3rumpo8ls=
Received: by 10.52.30.194 with SMTP id u2mr20674385vdh.13.1318373093505;
        Tue, 11 Oct 2011 15:44:53 -0700 (PDT)
Received: from pclouds@gmail.com (dektec3.lnk.telstra.net. [165.228.202.174])
        by mx.google.com with ESMTPS id bi11sm170059vdb.13.2011.10.11.15.44.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Oct 2011 15:44:52 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 12 Oct 2011 09:44:45 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183334>

After the last round toying with .gitignore mechanism as a way to
exclude paths, I have finally got back to the negative pathspec.

I'm still struggling with read_directory() rewrite so that struct
pathspec can be used throughout git, but now realized we can at least
enable magic for certain commands and die() on those that don't.
This may help move magic pathspec patches forward.

The nice thing about this series is that negative pathspec patch is
small and simple, much less headache to review than the previous
version (and as a consequence, not as powerful).

So here it is to gather comments whether we should go this way. Very
much WIP, I have not even run "make test".

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  Recognize magic pathspec as filenames
  Replace has_wildcard with PATHSPEC_NOGLOB
  Convert prefix_pathspec() to produce struct pathspec_item
  Implement parse_pathspec()
  Convert simple init_pathspec() cases to parse_pathspec()
  Implement negative pathspec

 Documentation/glossary-content.txt |    8 ++--
 builtin/grep.c                     |    4 +-
 builtin/ls-files.c                 |    2 +-
 builtin/ls-tree.c                  |    6 +-
 builtin/reset.c                    |    2 +-
 cache.h                            |   29 +++++++++++-
 dir.c                              |   85 +++++++++++++++++++++++++++-=
-------
 revision.c                         |    9 ++--
 setup.c                            |   56 +++++++++++-------------
 tree-walk.c                        |   44 ++++++++++++++++---
 10 files changed, 169 insertions(+), 76 deletions(-)

--=20
1.7.3.1.256.g2539c.dirty

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/8] en/object-list-with-pathspec v4
Date: Thu,  9 Sep 2010 01:50:15 +1000
Message-ID: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 05:22:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtXif-0000Am-30
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 05:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab0IIDWc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 23:22:32 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:56020 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587Ab0IIDWa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 23:22:30 -0400
Received: by pxi10 with SMTP id 10so316454pxi.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 20:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=HfSOtM2RoDoefZUYjczAEZKTq5UwyjXjKQf+ua6pMJo=;
        b=PI9OumeuiIhSVsLPyWW66UGAY21lHWu/2uPQAInNQeI/xrBx8MZfTwYIWn9Vc8AEvb
         JPFQWaIB7WCdUj5Mve5jp4EJ7nX8ROjgJKtqEmIqBv4KWxy0NkHmEt/wPA3D3A1Bm2Vq
         Yk03mpFECP1Lry/wXnsKiFeEX3DsejNNjTUH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=g+k5UacXNXWixDAWmQYHdFR74MwsWwGcH6WRMkA68rUUOfGyRQgje6HGrnBvtvy507
         rI+aQuwvRJrAM68WeRygXXVgqGrisnLKx5h+07jbCUgeiWZBwB/nZWsqlq4T2ZnV8qMI
         dvMPd8SF4T9zeMlLY4iI3TUBaFWkzHpNWPxe0=
Received: by 10.142.4.9 with SMTP id 9mr342401wfd.98.1284002550563;
        Wed, 08 Sep 2010 20:22:30 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id n34sm822986wfa.14.2010.09.08.20.22.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Sep 2010 20:22:29 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu,  9 Sep 2010 01:50:34 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g13aff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155829>

OK it's good enough now. I no longer use struct exclude_list.
Its name does not really match the semantics.

The last two patches implement tree exclusion and are not meant
for submission to en/object-list-with-pathspec. I wanted to see
if the new struct was extensible. And I need tree exclusion anyway
in my narrow clone.

Elijah Newren (2):
  Add testcases showing how pathspecs are ignored with rev-list --objec=
ts
  Make rev-list --objects work together with pathspecs

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  diff-no-index: use diff_tree_setup_paths()
  Introduce struct tree_pathspec_list
  tree_entry_interesting(): remove dependency on struct diff_options
  tree-walk: move tree_entry_interesting() from tree-diff.c
  setup_tree_pathspec(): interpret '^' as negative pathspec
  tree_entry_interesting(): support negative pathspec

 builtin/diff-files.c     |    2 +-
 builtin/diff.c           |    4 +-
 builtin/log.c            |    2 +-
 diff-lib.c               |    2 +-
 diff-no-index.c          |   13 ++--
 diff.h                   |    4 +-
 list-objects.c           |   23 ++++++
 revision.c               |   14 ++--
 revision.h               |    3 +-
 t/t6000-rev-list-misc.sh |   51 ++++++++++++
 t/t9999-test.sh          |   44 +++++++++++
 tree-diff.c              |  157 ++-----------------------------------
 tree-walk.c              |  191 ++++++++++++++++++++++++++++++++++++++=
++++++++
 tree-walk.h              |   16 ++++
 14 files changed, 356 insertions(+), 170 deletions(-)
 create mode 100755 t/t6000-rev-list-misc.sh
 create mode 100755 t/t9999-test.sh

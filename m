From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 0/5] repo-local env vars handling
Date: Wed, 24 Feb 2010 00:35:31 +0100
Message-ID: <1266968136-11129-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 00:35:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk4ID-0001BB-Qw
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 00:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733Ab0BWXfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 18:35:48 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43945 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506Ab0BWXfr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 18:35:47 -0500
Received: by wya21 with SMTP id 21so876637wya.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 15:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=bY1p5Kp+mygDWdCKsoU078xZisExQvqbG0FsnUw5TI0=;
        b=DwTKQJuLZZgh3HZKRzzmQE4Qug7OcMRCOouiOD4Gh9/E3vSTm7E7IbfQcCBu5Rs3Xk
         X0PUkx3vb3anx8WvKuRrnYJblayDDrdtNVDZ7gFpFBSEEQeV8njpUsPYfPKl62TJh1ca
         AQfKugxn3vok+FuMEMPLy3wN6Gu4QAs5LHHH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=SED1+qvjqmWwbMTIPmEMLcxWjm8hQeAtdkcsjy9oBVyk9Ho4SP2i27gefIyGDU48wN
         3BbyaVh8OqFeEhMO9VDLc0tRn7sDKnlC+BTVnuJrwdUjbKVuMZf6gm/c/Is0mA2duc5i
         7CNrlITGzNHX++F0ilf+69wyzsGkSZlw+KTDw=
Received: by 10.216.89.81 with SMTP id b59mr1173538wef.97.1266968145617;
        Tue, 23 Feb 2010 15:35:45 -0800 (PST)
Received: from localhost ([151.60.179.236])
        by mx.google.com with ESMTPS id i35sm20273720gve.25.2010.02.23.15.35.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 15:35:45 -0800 (PST)
X-Mailer: git-send-email 1.7.0.200.g5ba36.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140870>

Ok, the Git GUI + submodule fix is shaping up in a pretty much more
general thing. In this third iteration, the patch has been augmented by
two important patches:

* the first patch defines a static list (const char *const []) holding
  all the repo-local environment variables. The list is not used yet,
  just defined
* the third patch adds a rev-parse (I couldn't think of a better place)
  option to list these variables (just the names, not the values)

The connect and sh-setup patches have obviously been adapted to use
the new provided features. The last patch didn't change, which in
particular means that Jens Lehmann's C-side submodule fix is still
valid, although it might benefit from being reworked to exploit the
static list exposed by this patchset.

Giuseppe Bilotta (5):
  cache: static list of repo-local env vars
  connect: use static list of repo-local env vars
  rev-parse: --local-env-vars option
  shell setup: clear_local_git_env() function
  submodules: ensure clean environment when operating in a submodule

 Documentation/git-rev-parse.txt |    6 ++++++
 Makefile                        |    1 +
 builtin-rev-parse.c             |    8 ++++++++
 cache.c                         |   13 +++++++++++++
 cache.h                         |    2 ++
 connect.c                       |   13 +------------
 git-sh-setup.sh                 |    7 +++++++
 git-submodule.sh                |   20 ++++++++++----------
 8 files changed, 48 insertions(+), 22 deletions(-)
 create mode 100644 cache.c

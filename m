From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/16] nd/setup part two
Date: Thu, 11 Mar 2010 20:22:18 +0700
Message-ID: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 14:22:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpiLe-0000oj-2p
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 14:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409Ab0CKNWm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 08:22:42 -0500
Received: from mail-pz0-f194.google.com ([209.85.222.194]:40589 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932388Ab0CKNWl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 08:22:41 -0500
Received: by pzk32 with SMTP id 32so11276pzk.4
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 05:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=dHGyDlhN59gH+ZXBMNqE8JWMTacOTyZIZh2gAv7xAog=;
        b=F2cPMbS4Qg08qbxFeKCIsWnQ37TC3ME/VvpO0ueG2MBmsqqtibso+sjTjeTiBvC3aG
         8soJhCrTijQozq1zvyDsSn0I7YCa+3ZUq/CGWLwjgbs/j0mUfcbTDcFir2GnAZNri12y
         XGv4m+6ZdDiRVYMr8WtwIhOc5Ha04hZUuTyzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=au7v1rWEgpLF/dEOexw76t37UnkVmuaegJ7SUG3MSOFwU4juqfomlkyiF8CFjPMhDH
         CBsAc4j8rbTNqfSTe3gICFR9NpXnflQ8HEmsv+wMk6Zq9Y+ACoesjWvtUSiG7p0/hVIP
         7wweRFgVVbwqHY8e/f/tKU3BbVB/TlRHe2QTM=
Received: by 10.114.214.37 with SMTP id m37mr1337970wag.37.1268313760201;
        Thu, 11 Mar 2010 05:22:40 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.196.130])
        by mx.google.com with ESMTPS id 21sm8837230pzk.4.2010.03.11.05.22.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Mar 2010 05:22:38 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Mar 2010 20:22:34 +0700
X-Mailer: git-send-email 1.7.0.1.384.g6abcaa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141962>

While the first part is more of preventing faults. This part fixes the
remaining faults (or introduces more faults, who knows). I think I
have got it to a readable/testable state.

On top of nd/setup, obviously.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (16):
  Move enter_repo() to setup.c
  enter_repo(): initialize other variables as setup_git_directory_gentl=
y() does
  rev-parse --git-dir: print relative gitdir correctly
  worktree setup: call set_git_dir explicitly
  Add git_config_early()

    Preparation


  Use git_config_early() instead of git_config() during repo setup
  worktree setup: restore original state when things go wrong
  init/clone: turn on startup->have_repository properly

    Improve setup stuff


  git_config(): do not read .git/config if there is no repository
  Do not read .git/info/exclude if there is no repository
  Do not read .git/info/attributes if there is no repository
  apply: do not check sha1 when repository has not been found
  config: do not read .git/config if there is no repository

    Stop improper access to repo (and incorrectly set git_dir
    along the way)


  Allow to undo setup_git_directory_gently() gracefully (and fix alias =
code)
  alias: keep repository found while collecting aliases as long as poss=
ible

    Alias fix/improvement. I think I can add some tests for this.


  Guard unallowed access to repository when it's not set up

    The original patch [1] that has grown up to a 37-patch, 2-part seri=
es

[1] http://mid.gmane.org/1265370468-6147-1-git-send-email-pclouds@gmail=
=2Ecom

 attr.c                  |    5 +-
 builtin/apply.c         |    2 +-
 builtin/clone.c         |    3 +-
 builtin/config.c        |    9 ++-
 builtin/init-db.c       |   10 ++-
 builtin/rev-parse.c     |    8 ++
 cache.h                 |    6 ++-
 config.c                |   22 +++++--
 dir.c                   |    8 ++-
 environment.c           |   33 ++++++++-
 git.c                   |   22 ++++---
 path.c                  |   91 -----------------------
 setup.c                 |  184 +++++++++++++++++++++++++++++++++++++++=
+++++---
 t/t1300-repo-config.sh  |   14 ++++
 t/t1302-repo-version.sh |    2 +-
 t/t7002-grep.sh         |   24 ++++++
 16 files changed, 309 insertions(+), 134 deletions(-)

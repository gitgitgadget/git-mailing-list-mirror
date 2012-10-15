From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: nd/attr-match-more-optim, nd/wildmatch and as/check-ignore
Date: Mon, 15 Oct 2012 13:23:32 +0700
Message-ID: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Spiers <git@adamspiers.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:23:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNe5m-00053d-3V
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290Ab2JOGXq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:23:46 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:56066 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374Ab2JOGXp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:23:45 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so2429043dak.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=4donJ7Zi8DEJ5KBGtjeGdgH0zxLcJz5Q/VrLF3j5Du0=;
        b=g8cD46ujfrxpVTW+6cCc0CA9QJJ5TjmgmbCvwnqBJCyNIc0nQQCu4TbJ7tKeIuwzhe
         ImVb3CtMdu3gze9q9WJPbubOh9oDu/0HIQ33NEAfcHmQgyLD716NQZcG1A1K6W8Q10TP
         UHbckqyDOruGwFsKL4wXh9JOsuq7kKWLrqlVaXJT3Y1vB6PnRjGauJWBXpysVmQyigdK
         MtoUFjYzz9XgzHjKbs+WEj2XEJujmTsfDdMAjs6dvWx998W64QkeLxGAyfmxo6b1F1QO
         496nCyP2SPvF0pQH0jCTQC4gAGUeTgDRs71+TyO4xw+ayypZU/5HSMiaiH00ZPgHT1Nc
         zp/A==
Received: by 10.66.77.168 with SMTP id t8mr30307490paw.28.1350282225051;
        Sun, 14 Oct 2012 23:23:45 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id tw5sm8569904pbc.48.2012.10.14.23.23.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:23:42 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:23:33 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207692>

I promise I won't send anything dir.c-related till the end of this
month :) These three series all touch the same code in dir.c and cause
a bunch of conflicts. So I rebase nd/wildmatch and as/check-ignore
on top of nd/attr-match-more-optim and resolve all conflicts.

nd/attr-match-more-optim
------------------------

A lot of refactoring in dir.c leads to a cleaner last patch to port
many exclude optimizations to attr. We can extend EXC_FLAGS_ENDSWITH
optimization further, from "^*.[ch]" to "path/to/*.[ch]", but not in
this series.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  exclude: stricten a length check in EXC_FLAG_ENDSWITH case
  exclude: split basename matching code into a separate function
  exclude: fix a bug in prefix compare optimization
  exclude: split pathname matching code into a separate function
  gitignore: make pattern parsing code a separate function
  attr: more matching optimizations from .gitignore

 Documentation/gitattributes.txt    |   1 +
 attr.c                             |  52 ++++++----
 dir.c                              | 192 ++++++++++++++++++++++++-----=
--------
 dir.h                              |  13 ++-
 t/t0003-attributes.sh              |  10 ++
 t/t3001-ls-files-others-exclude.sh |   6 ++
 6 files changed, 186 insertions(+), 88 deletions(-)

nd/wildmatch
------------

new ctype patches that no longer introduce sane_ctype2[]. I also
re-indent wildmatch.c to follow Git's coding style with the intention
of making more changes in future (e.g. case insensitive support in
pathspec means we cannot rely on GNU extension FNM_CASEFOLD). Thanks
to nd/attr-match-more-optim we don't need to make any changes to
attr.c.

Depends on nd/attr-match-more-optim.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (13):
  ctype: make sane_ctype[] const array
  ctype: support iscntrl, ispunct, isxdigit and isprint
  Import wildmatch from rsync
  wildmatch: remove unnecessary functions
  wildmatch: follow Git's coding convention
  Integrate wildmatch to git
  t3070: disable unreliable fnmatch tests
  wildmatch: make wildmatch's return value compatible with fnmatch
  wildmatch: remove static variable force_lower_case
  wildmatch: fix case-insensitive matching
  wildmatch: adjust "**" behavior
  wildmatch: make /**/ match zero or more directories
  Support "**" wildcard in .gitignore and .gitattributes

 .gitignore                         |   1 +
 Documentation/gitignore.txt        |  19 +++
 Makefile                           |   3 +
 ctype.c                            |  15 ++-
 dir.c                              |   4 +-
 git-compat-util.h                  |  15 ++-
 t/t0003-attributes.sh              |  37 ++++++
 t/t3001-ls-files-others-exclude.sh |  18 +++
 t/t3070-wildmatch.sh               | 195 +++++++++++++++++++++++++++++=
++
 test-wildmatch.c                   |  14 +++
 wildmatch.c                        | 234 +++++++++++++++++++++++++++++=
++++++++
 wildmatch.h                        |   9 ++
 12 files changed, 556 insertions(+), 8 deletions(-)
 create mode 100755 t/t3070-wildmatch.sh
 create mode 100644 test-wildmatch.c
 create mode 100644 wildmatch.c
 create mode 100644 wildmatch.h

as/check-ignore
---------------

Conflict resolution and cleanups. A lot of matching code sharing
between exclude and attr means we might be able to bring check-ignore
functionality to check-attr. But let's leave it for now.

Depends on nd/attr-match-more-optim.

Adam Spiers (12):
  dir.c: rename cryptic 'which' variable to more consistent name
  dir.c: rename path_excluded() to is_path_excluded()
  dir.c: rename excluded_from_list() to is_excluded_from_list()
  dir.c: rename excluded() to is_excluded()
  dir.c: refactor is_excluded_from_list()
  dir.c: refactor is_excluded()
  dir.c: refactor is_path_excluded()
  dir.c: keep track of where patterns came from
  dir.c: refactor treat_gitlinks()
  pathspec.c: move reusable code from builtin/add.c
  dir.c: provide free_directory() for reclaiming dir_struct memory
  Add git-check-ignore sub-command

 .gitignore                                        |   1 +
 Documentation/git-check-ignore.txt                |  85 ++++
 Documentation/gitignore.txt                       |   6 +-
 Documentation/technical/api-directory-listing.txt |   2 +
 Makefile                                          |   3 +
 attr.c                                            |   2 +-
 builtin.h                                         |   1 +
 builtin/add.c                                     |  84 +---
 builtin/check-ignore.c                            | 170 +++++++
 builtin/clean.c                                   |   2 +-
 builtin/ls-files.c                                |   5 +-
 command-list.txt                                  |   1 +
 contrib/completion/git-completion.bash            |   1 +
 dir.c                                             | 185 +++++--
 dir.h                                             |  21 +-
 git.c                                             |   1 +
 pathspec.c                                        |  98 ++++
 pathspec.h                                        |   6 +
 t/t0007-ignores.sh                                | 587 ++++++++++++++=
++++++++
 unpack-trees.c                                    |  10 +-
 20 files changed, 1135 insertions(+), 136 deletions(-)
 create mode 100644 Documentation/git-check-ignore.txt
 create mode 100644 builtin/check-ignore.c
 create mode 100644 pathspec.c
 create mode 100644 pathspec.h
 create mode 100755 t/t0007-ignores.sh
--=20
1.8.0.rc0.29.g1fdd78f

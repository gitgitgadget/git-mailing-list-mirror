From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 00/25] list-files redesign
Date: Mon,  6 Apr 2015 20:52:09 +0700
Message-ID: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 1425896314-10941-1-git-send-email-pclouds@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:52:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7SB-0004Y4-Lx
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335AbbDFNwe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:52:34 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36805 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310AbbDFNwd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 09:52:33 -0400
Received: by pabsx10 with SMTP id sx10so45077100pab.3
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=5JWzAjmIHJP5b1l+6B9eJXRYcbyOdfDOB/7fQDkBFqY=;
        b=Vb9GYZROwDdHT3Ga+3o1tq+B12SLX/jbP4U4FQ8uNKuJPHGsjLElmo50pnVHUy3wJo
         c2/OLDiIVmCo1Bnu5C7ZI+XmN39jbHxCIlWmnvS9lo+86E72coxg81h6zlzmiXbjeiSw
         vQWL+/Q5VigtNvwL/Th5YGnPiyM+yrMEAOMgQ3T2dXbiA0NTW4d6gR3UsMc2rkuv4o2K
         9DC5Vo7/mgv0GcmG6ka5gffst/WTtmU+ttSnEze6KmhNoRQTZYS6rAYoxziB8kM6NJ02
         LVMb0KxZuFGQJcgFZcZnqi4yoKRsJDjfXBYkTES44E/89mSQNUbmhkqs2yMeD6GpvfBK
         fP2Q==
X-Received: by 10.68.94.37 with SMTP id cz5mr27418918pbb.70.1428328353470;
        Mon, 06 Apr 2015 06:52:33 -0700 (PDT)
Received: from lanh ([115.73.245.217])
        by mx.google.com with ESMTPSA id nt15sm4013962pdb.14.2015.04.06.06.52.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 06:52:32 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Apr 2015 20:52:44 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266845>

The UI part is the same (or nearly the same) with the last round. The
internal data structure is reorignized to avoid abusing string_list.
Tests and documentation are added back.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (25):
  ls_colors.c: add $LS_COLORS parsing code
  ls_colors.c: parse color.ls.* from config file
  ls_colors.c: add a function to color a file name
  ls_colors.c: highlight submodules like directories
  list-files: command skeleton
  list-files: show paths relative to cwd
  list-files: add tag to each entry, filter duplicate tags
  list-files: add --[no-]column, -C and -1
  list-files: add --max-depth, -R and default to --max-depth=3D0
  list-files: show directories as well as files
  list-files: add --color
  list-files: add -F/--classify
  list-files: new indicator '&' for submodules when -F is used
  list-files: add --cached and --others
  list-files: add --ignored
  list-files: add --unmerged
  list-files: add file modification options -[admADM]
  list-files: delete redundant cached entries
  list-files: make alias 'ls' default to 'list-files'
  list-files: preload index
  list-files: reduce match_pathspec calls in matched()
  list-files: only do diff that is actually useful
  pathspec: move getenv() code out of prefix_pathspec()
  list-files: make :(glob) pathspec default
  list-files: documentation

 .gitignore                             |   1 +
 Documentation/config.txt               |  12 +
 Documentation/git-list-files.txt (new) | 115 +++++++
 Makefile                               |   2 +
 builtin.h                              |   1 +
 builtin/list-files.c (new)             | 581 +++++++++++++++++++++++++=
++++++++
 color.h                                |  10 +
 config.c                               |   8 +
 git.c                                  |   1 +
 ls_colors.c (new)                      | 498 +++++++++++++++++++++++++=
+++
 pathspec.c                             |  59 ++--
 pathspec.h                             |   1 +
 t/t7013-list-files.sh (new +x)         | 335 +++++++++++++++++++
 wt-status.c                            |  16 +-
 wt-status.h                            |   3 +
 15 files changed, 1612 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/git-list-files.txt
 create mode 100644 builtin/list-files.c
 create mode 100644 ls_colors.c
 create mode 100755 t/t7013-list-files.sh

--=20
2.3.0.rc1.137.g477eb31

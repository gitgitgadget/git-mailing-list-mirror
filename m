From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 0/2] gitignore, re-inclusion fix
Date: Mon, 21 Sep 2015 16:56:13 +0700
Message-ID: <1442829375-1926-1-git-send-email-pclouds@gmail.com>
References: <1442106945-24080-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 21 11:56:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdxpJ-0005Yv-6w
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 11:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756401AbbIUJz5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Sep 2015 05:55:57 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34138 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681AbbIUJz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 05:55:56 -0400
Received: by padhy16 with SMTP id hy16so112430102pad.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 02:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=eRH4ai2BZ+/tNJHEkPnEpuUu8TbNJRUSOHbLvmV85xo=;
        b=Y0SNqi2LHzBbtAt50USeRn0XSz9bYXKtH0CY9BuEatT+0p5zeXwQk2NUmixAkxB90l
         VzYIg2m0GSGk5ovcZ80LQLdnBsFfVdoajRKE1oMn6KJThO6J3OmzU0FW4NlrHCZSAeO9
         gQd3/zV4rt7juxxq65UveBSjGP6PWaaw8IrqMTzj6uJSI54acHLOiufL3+qTtS6AviAb
         Q1aprWLE2J21KVtanedpbENK+P3TOO0h0kOS4vmgFa4gwH2pTyk6y+6QtexbXRlizozy
         LLT30v0hCgipC3nXqgvwqzwtISf940HAVxPLj+xtIJARwrj4AVJNWKTQwnOvNRtM4IlU
         Xw2w==
X-Received: by 10.68.231.5 with SMTP id tc5mr23856524pbc.54.1442829355770;
        Mon, 21 Sep 2015 02:55:55 -0700 (PDT)
Received: from lanh ([171.233.227.16])
        by smtp.gmail.com with ESMTPSA id uc1sm23593825pab.20.2015.09.21.02.55.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2015 02:55:55 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 21 Sep 2015 16:56:23 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1442106945-24080-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278292>

Changes since v2

-- 8< --
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 889a72a..79a1948 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -82,9 +82,12 @@ PATTERN FORMAT
=20
  - An optional prefix "`!`" which negates the pattern; any
    matching file excluded by a previous pattern will become
-   included again. It is possible to re-include a file if a parent
-   directory of that file is excluded, with restrictions. See section
-   NOTES for detail.
+   included again.
+   Put a backslash ("`\`") in front of the first "`!`" for patterns
+   that begin with a literal "`!`", for example, "`\!important!.txt`".
+   It is possible to re-include a file if a parent directory of that
+   file is excluded if certain conditions are met. See section NOTES
+   for detail.
=20
  - If the pattern ends with a slash, it is removed for the
    purpose of the following description, but it would only find
@@ -138,8 +141,11 @@ not tracked by Git remain untracked.
 To stop tracking a file that is currently tracked, use
 'git rm --cached'.
=20
-To re-include a file when its parent directory is excluded, the
-following conditions must be met:
+To re-include files or directories when their parent directory is
+excluded, the following conditions must be met:
+
+ - The rules to exclude a directory and re-include a subset back must
+   be in the same .gitignore file.
=20
  - The directory part in the re-include rules must be literal (i.e. no
    wildcards)
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-othe=
rs-exclude.sh
index 9de49a6..da257c0 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -310,9 +310,14 @@ test_expect_success 'negative patterns' '
 	(
 		cd reinclude &&
 		cat >.gitignore <<-\EOF &&
+		/fooo
 		/foo
 		!foo/bar/bar
 		EOF
+		mkdir fooo &&
+		cat >fooo/.gitignore <<-\EOF &&
+		!/*
+		EOF
 		mkdir -p foo/bar &&
 		touch abc foo/def foo/bar/ghi foo/bar/bar &&
 		git ls-files -o --exclude-standard >../actual &&
-- 8< --

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  dir.c: make last_exclude_matching_from_list() run til the end
  dir.c: don't exclude whole dir prematurely if neg pattern may match

 Documentation/gitignore.txt        | 23 ++++++++--
 dir.c                              | 89 ++++++++++++++++++++++++++++++=
+++++---
 t/t3001-ls-files-others-exclude.sh | 25 +++++++++++
 3 files changed, 127 insertions(+), 10 deletions(-)

--=20
2.3.0.rc1.137.g477eb31

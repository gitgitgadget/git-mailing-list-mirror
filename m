From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/19] list-files: add -R/--recursive short for --max-depth=-1
Date: Sun, 30 Nov 2014 15:55:59 +0700
Message-ID: <1417337767-4505-12-git-send-email-pclouds@gmail.com>
References: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:57:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xv0KF-00033V-EX
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbaK3I5r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:57:47 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:50402 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbaK3I5q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:57:46 -0500
Received: by mail-pd0-f174.google.com with SMTP id w10so8927590pde.19
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=aWB3wzRL4ZGb8+pHZqVQcGyrxNkEQX5zVC1xqdW3C8U=;
        b=0IfS2gWDL/IbbHM8ncH0C6fuzMxB4JJ3uLrUXZA55rsW16krm6T1cLEgxt+zceeADm
         oJNzhfvVDQJO89sPRYJff5f/nTQovN2mj1Ddh+4Wh3kH8rCFnJDYuICvKObL4YXz9WET
         e4Lio68OL6bwlDA9+KZEhFLUzlnuczpB7J6mhiwcT3+W29umVRAjDbUxxtjnjuq7uX10
         40em8HFJBegORknMkX9qjFw9fgfqxaoIdsmP6AX5jmm5Jq7VOsH2H7wOMayFJunDa31k
         yTJj7rw7w93KfQUZr5JeHMcIGOSRyeURPryk+6doKv5eGCsaPyWFCEZDkkebOjyJRuWq
         MT5g==
X-Received: by 10.70.51.163 with SMTP id l3mr87806809pdo.75.1417337866277;
        Sun, 30 Nov 2014 00:57:46 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id ou9sm14332693pbb.26.2014.11.30.00.57.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:57:45 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:57:43 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260434>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-list-files.txt | 4 ++++
 builtin/ls-files.c               | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/git-list-files.txt b/Documentation/git-list-=
files.txt
index 3039e1e..5dccbbc 100644
--- a/Documentation/git-list-files.txt
+++ b/Documentation/git-list-files.txt
@@ -45,6 +45,10 @@ OPTIONS
 --unmerged::
 	Show unmerged files
=20
+-R::
+--recursive::
+	Equivalent of `--max-depth=3D-1` (infinite recursion).
+
 --color[=3D<when>]::
 --no-color::
 	Color file names. The value must be `always`, `never`, or
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index f2b62b5..d0d39bd 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -594,6 +594,8 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 			N_("show cached files that have modification on working directory")=
),
 		OPT_BOOL('o', "others", &show_others,
 			N_("show untracked files")),
+		OPT_SET_INT('R', "recursive", &max_depth,
+			    N_("shortcut for --max-depth=3D-1"), -1),
 		OPT_BIT('i', "ignored", &dir.flags,
 			N_("show ignored files"),
 			DIR_SHOW_IGNORED),
--=20
2.2.0.60.gb7b3c64

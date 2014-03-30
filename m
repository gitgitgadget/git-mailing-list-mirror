From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 11/18] list-files: add -R/--recursive short for --max-depth=-1
Date: Sun, 30 Mar 2014 20:56:02 +0700
Message-ID: <1396187769-30863-12-git-send-email-pclouds@gmail.com>
References: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
 <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 15:56:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUGEE-0003Fc-Jl
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 15:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbaC3N4q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2014 09:56:46 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:62304 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbaC3N4p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 09:56:45 -0400
Received: by mail-pa0-f42.google.com with SMTP id fb1so7086597pad.1
        for <git@vger.kernel.org>; Sun, 30 Mar 2014 06:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MDRjnqHpz1dnEwH7XEM4dfZazaKTPQ9gJHqj+qkToLc=;
        b=ttb0JZ2d+hFBDNmm87E95qVOH27mkNDRKNFc7wQdXZWiA0iIYuEjgxEjbvH0qTLwtI
         ikOGhKUDMil+2l2phlAulGOURAAlvI23lakTXE0wQbNxouxjwtHBk+bHFM3kUNZsK8rF
         +QG3k8w1YfzhQVuDGNKb5YY5bPrmlVgh3pKumrWDb9ziXGq8TzzTZVuEefJxysRCdHrX
         D3YbSGPYzuzUKZoKU0bW4Sp3AUr2IYdzEbQOeanvimy8fkbW8NWdroIIRildNGOVawUG
         ajr2rFPSu1jUjpCLRLrG+xzjTuB9skmSdbujvZOhnY2wQKvgSSCx5Kt1A7nqE+D95wEA
         rzbA==
X-Received: by 10.68.237.133 with SMTP id vc5mr19449804pbc.92.1396187804648;
        Sun, 30 Mar 2014 06:56:44 -0700 (PDT)
Received: from lanh ([115.73.202.240])
        by mx.google.com with ESMTPSA id yv5sm37297083pbb.49.2014.03.30.06.56.41
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 30 Mar 2014 06:56:44 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Mar 2014 20:57:42 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245475>

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
index addbcce..656b632 100644
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
1.9.1.345.ga1a145c

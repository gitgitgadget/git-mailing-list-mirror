From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/21] list-files: add -R/--recursive short for --max-depth=-1
Date: Sun, 25 Jan 2015 19:37:47 +0700
Message-ID: <1422189476-7518-13-git-send-email-pclouds@gmail.com>
References: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 13:28:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFMIc-0002sf-2G
	for gcvg-git-2@plane.gmane.org; Sun, 25 Jan 2015 13:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbbAYM2N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jan 2015 07:28:13 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:45821 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbbAYM2M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2015 07:28:12 -0500
Received: by mail-pa0-f51.google.com with SMTP id fb1so6465219pad.10
        for <git@vger.kernel.org>; Sun, 25 Jan 2015 04:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lgT4u7us90UaGPh9FlpSa7cszoJHN+fbErBRfZmCa64=;
        b=wNQUjKd/iKgRDBx5ELzL6aWjPEfW1PCRGfQx8y6ZSbp/HF2/447qyQJTLwJJDSc1Vz
         uwJb/3TfBGtjUGJN1Mw4PCguM7v5JEn1fE+1n3gDDr+9LCt8Zrw2P+u4ixW14P4rrhSf
         lFxU1e8jlk28yHJiUWZKislzYfgy2Li7X2RDq2qBu/IjS3sfVdjQC/4/tTGiGS5aWVHX
         npPmXuNVkYXm9ckBeec9QAor1CC4uU1Kqe9pZaSRipeCeyUBPhK5gfY11tkmtO1fBtkQ
         ipyz9mPjLdPia/FeE5Zy5MglFpzKxwpVtAYMjD1Kvu3hCSm9KxoHHFM3lFwDnWBWrO81
         zgaA==
X-Received: by 10.68.236.67 with SMTP id us3mr25658377pbc.121.1422188891911;
        Sun, 25 Jan 2015 04:28:11 -0800 (PST)
Received: from lanh ([115.73.204.104])
        by mx.google.com with ESMTPSA id pp9sm7103449pbb.65.2015.01.25.04.28.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Jan 2015 04:28:11 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 25 Jan 2015 19:39:35 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263009>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-list-files.txt | 4 ++++
 builtin/ls-files.c               | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/git-list-files.txt b/Documentation/git-list-=
files.txt
index 2182a38..8d285c1 100644
--- a/Documentation/git-list-files.txt
+++ b/Documentation/git-list-files.txt
@@ -46,6 +46,10 @@ OPTIONS
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
index f2c29ce..010291c 100644
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
2.2.0.84.ge9c7a8a

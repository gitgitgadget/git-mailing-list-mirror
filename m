From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/21] list-files: add -R/--recursive short for --max-depth=-1
Date: Sun,  8 Feb 2015 16:01:30 +0700
Message-ID: <1423386099-19994-13-git-send-email-pclouds@gmail.com>
References: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 10:03:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNmA-0006C6-BZ
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 10:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755695AbbBHJD2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 04:03:28 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34167 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599AbbBHJDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 04:03:25 -0500
Received: by pdjg10 with SMTP id g10so18222601pdj.1
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 01:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=k4OiS/uAxgwFXA00YQ9vx+MA9cMehV8dbZnyQp9c1nQ=;
        b=YEuAeXo6KcHyUrv9+4w9/1/Neymhh15qcXUIQGp4dO60smDIINT6OjKvi3khg8Ut7v
         u4lGPf6CmVo0yiMKVEQb73GY/CCRwuz0hinwLLG8wh0a/C+rgdCzEcrPaj29G4EwV/X1
         qA/365btYlX/M8v1zRoAeKFJ6ACSSGJhZEsIuc7V15QY8H6vJWus/O7mueUeT9McKuZN
         BULM8K3t1rGcrfkaOoKERqZCKoeoK62YSuApsbXPPd2fVK7HwhmFPBZkIl7/9n269Ozs
         E3Lp+Xywz94IGoiTnZhsSzmWjIJGn5uq6S1PKCRWpfR6vOFNfxgy5ViC+PZdr2nXQRo2
         603A==
X-Received: by 10.68.69.111 with SMTP id d15mr8635536pbu.90.1423386205315;
        Sun, 08 Feb 2015 01:03:25 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id je2sm6159592pbd.44.2015.02.08.01.03.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 01:03:24 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 16:03:32 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263499>

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
index c5468c7..adc31f6 100644
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
2.3.0.rc1.137.g477eb31

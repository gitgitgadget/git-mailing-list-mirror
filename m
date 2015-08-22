From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/5] enter_repo: allow .git files in strict mode
Date: Sat, 22 Aug 2015 07:40:00 +0700
Message-ID: <1440204002-7638-4-git-send-email-pclouds@gmail.com>
References: <20150715132552.GA28574@lanh>
 <1440204002-7638-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bjornar@snoksrud.no,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 02:41:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSws6-0005Q0-8F
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 02:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbbHVAlR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 20:41:17 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35519 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbbHVAlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 20:41:16 -0400
Received: by pacdd16 with SMTP id dd16so54398041pac.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 17:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=o+tW8xgHbIk/pVHjg0wAbVULCKYbnDLVbigQrgPW9gA=;
        b=JnSUQQ8GDSQURvWbJWC8toRJ22F882zmC98uv5uw8g3jXbUxn5FjWCGWgeTfFzYabM
         njpG1C2+h0xLUk7hn5XKfFMJVGdHT7lGTsGsdaVfkZBgYp9PaMkmoSFYsAW+UioscCYY
         M2WF6/qckn5zeUh95Gbawyi5bjq+tglKoPctzAqM8e32y+ewqeLy52JuYkly2XmG/tOm
         2OilZ2qnCK/rwXi2xUHwnjYRMNCJHh2KJqsPJL2nUlbzB5H7HbHZnAFfwqZvZVlxk/Bc
         wzqAmTg22IOT7dbs+rOksb7JYhC70X+GdvP/6eIeagjf24U504+g8rqBfQfvDdQ1HaM+
         CVbw==
X-Received: by 10.66.216.227 with SMTP id ot3mr22402001pac.92.1440204075927;
        Fri, 21 Aug 2015 17:41:15 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id e4sm9113187pdd.45.2015.08.21.17.41.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 17:41:15 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Aug 2015 07:41:13 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440204002-7638-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276348>

Strict mode is about not guessing where .git is. If the user points to =
a
=2Egit file, we know exactly where the target .git dir will be.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 path.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/path.c b/path.c
index 7340e11..32d4ca6 100644
--- a/path.c
+++ b/path.c
@@ -438,8 +438,13 @@ const char *enter_repo(const char *path, int stric=
t)
 			return NULL;
 		path =3D validated_path;
 	}
-	else if (chdir(path))
-		return NULL;
+	else {
+		const char *gitfile =3D read_gitfile(used_path);
+		if (gitfile)
+			path =3D gitfile;
+		if (chdir(path))
+			return NULL;
+	}
=20
 	if (is_git_directory(".")) {
 		set_git_dir(".");
--=20
2.3.0.rc1.137.g477eb31

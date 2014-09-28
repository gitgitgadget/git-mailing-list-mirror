From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 09/32] fast-import: use git_path() for accessing .git dir instead of get_git_dir()
Date: Sun, 28 Sep 2014 08:22:23 +0700
Message-ID: <1411867366-3821-10-git-send-email-pclouds@gmail.com>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
 <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 03:23:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XY3DE-0002IM-BQ
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 03:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbaI1BXk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Sep 2014 21:23:40 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36150 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaI1BXj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2014 21:23:39 -0400
Received: by mail-pd0-f178.google.com with SMTP id y10so523114pdj.9
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 18:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Z9pvfdn4U7bNnDQHUY4YMn3GYJpQUgGZ1VkL/vy5hlY=;
        b=kjm35tTC8BPLqOgVtIyZ3EazXwo8oIjxzlmHQrj+ZyAetNAhL+fNuIuxl3zG/XVK19
         eGtSPmRU5Fl1IKAkM7U7gy/mTl+N9FasECN1lUgtGyPUqL03lO8FUVHHUdqtn3kQ7BvP
         7nwJNg0k6N8VWjnPSMUdZqa8U7ZTq4VYPZ+YQsHmD3pfLlN4xWtwDRC6JE2RrvnMLx1h
         faubAFQMQkCw4T7Lf1ghiyHeuSMA1eLbgHgKy3NoVDGKDsBJknp1WISCJIJ8nuztvrT4
         uEEp7NIVddvivSYvHaWvmnNBit33w5pfjBMJhliosrGByLMwwLde3UyInrTQUT2Ov5BN
         04qQ==
X-Received: by 10.70.90.174 with SMTP id bx14mr58183054pdb.27.1411867419316;
        Sat, 27 Sep 2014 18:23:39 -0700 (PDT)
Received: from lanh ([115.73.212.224])
        by mx.google.com with ESMTPSA id be14sm8546656pdb.49.2014.09.27.18.23.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2014 18:23:38 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Sep 2014 08:23:42 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257568>

This allows git_path() to redirect info/fast-import to another place
if needed

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fast-import.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 9ddcd3b..69e4c3f 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3130,12 +3130,9 @@ static void parse_progress(void)
=20
 static char* make_fast_import_path(const char *path)
 {
-	struct strbuf abs_path =3D STRBUF_INIT;
-
 	if (!relative_marks_paths || is_absolute_path(path))
 		return xstrdup(path);
-	strbuf_addf(&abs_path, "%s/info/fast-import/%s", get_git_dir(), path)=
;
-	return strbuf_detach(&abs_path, NULL);
+	return xstrdup(git_path("info/fast-import/%s", path));
 }
=20
 static void option_import_marks(const char *marks,
--=20
2.1.0.rc0.78.gc0d8480

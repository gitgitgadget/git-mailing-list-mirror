From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 08/25] fast-import: use git_path() for accessing .git dir instead of get_git_dir()
Date: Tue, 18 Feb 2014 20:39:57 +0700
Message-ID: <1392730814-19656-9-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 14:41:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFkvC-00071h-Ms
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 14:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755649AbaBRNlF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 08:41:05 -0500
Received: from mail-pd0-f182.google.com ([209.85.192.182]:53498 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755644AbaBRNlC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 08:41:02 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so16251968pde.13
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 05:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Nq6QbPVzLhYjKcOJJxvrJEn2WYmBX2lHNEo/nKzpRZM=;
        b=0fjfEMA4b0beenBoIaZMRwBCuzK9xsmxzDnuH/ost98KnQtfRVE+BV8wvAkyo37RB6
         OFAgp0Imd1T7cph9jb999XjYoxKxwxbQcAk57dwR+/S463HZqwg0/VoT0Cgj9kkKJjwb
         fPxIT8VdNQUw5LeINNnj9QakWcjnOhl8y4Cnu8X6t9Whr+M3sx/uePWX6m+DlnxKA3Fy
         klLOX6lkYX9cG1cRfz1+bC2+2rWfOlRQ80BkMjLwYGQLuQoyLa/j2O1A8g+W/o1TC8JX
         vMCA6orB128him4crT/7vSB04GKtWiT0i7sFjD4tpMSxNi8VfLV8STjJutS/g1LVICPW
         yuHA==
X-Received: by 10.67.22.38 with SMTP id hp6mr33194190pad.53.1392730862362;
        Tue, 18 Feb 2014 05:41:02 -0800 (PST)
Received: from lanh ([115.73.228.211])
        by mx.google.com with ESMTPSA id os1sm142655276pac.20.2014.02.18.05.40.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 05:41:01 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 18 Feb 2014 20:41:15 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242307>

This allows git_path() to redirect info/fast-import to another place
if needed

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 fast-import.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 4fd18a3..08a1e78 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3125,12 +3125,9 @@ static void parse_progress(void)
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
1.8.5.2.240.g8478abd

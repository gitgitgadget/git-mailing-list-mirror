From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/34] fast-import: use git_path() for accessing .git dir instead of get_git_dir()
Date: Sun, 30 Nov 2014 15:24:34 +0700
Message-ID: <1417335899-27307-10-git-send-email-pclouds@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:27:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xuzr5-0007z6-91
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:27:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbaK3I1j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:27:39 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:43143 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbaK3I1C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:27:02 -0500
Received: by mail-pd0-f175.google.com with SMTP id y10so8966678pdj.34
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=h07ZfTxsytKzPYwUtePAPc9RVThYmsn4Icz4Cy+e3Kg=;
        b=wp03Z0CGryKwB4kl8tGJXSjSWpF9DifxvhLYnqK8241/pscUHXLcYXIeGtwU/jZjbU
         njAXudybGvj7cDv4hdsynvz5Z037pIWEJeMZewxUDGrSyK0tRt3wgthUnJ4HWpnJIukO
         b0TqSFJiri8p8zWfVKdM7YwK7e4Ouw86CEAtbHhkTGTqv5EuZbaytLeUXNTzpP4w8u5i
         atc97fr3vbzoP86rRrqT59KBjgLKCqWVP8oWAxhHS6/4VNbuWmbwIWUoDrzjydMPFISG
         R6/WlmVs6v61keYm0yLLnz8COqu9IVh/4/Wa5mCUaNLpGgMbi9c2FG8vrf+veKkrLiU2
         ro9w==
X-Received: by 10.66.118.136 with SMTP id km8mr90634603pab.100.1417336022406;
        Sun, 30 Nov 2014 00:27:02 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id ap5sm14388588pad.22.2014.11.30.00.26.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:27:01 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:26:55 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260398>

This allows git_path() to redirect info/fast-import to another place
if needed

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 fast-import.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 3018130..1b50923 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3112,12 +3112,9 @@ static void parse_progress(void)
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

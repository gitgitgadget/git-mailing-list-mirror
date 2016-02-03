From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/20] usage.c: move format processing out of die_errno()
Date: Wed,  3 Feb 2016 16:35:31 +0700
Message-ID: <1454492150-10628-2-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 10:36:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQtr9-0004yu-K3
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 10:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbcBCJgC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 04:36:02 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35505 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104AbcBCJf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 04:35:59 -0500
Received: by mail-pa0-f47.google.com with SMTP id ho8so10745953pac.2
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 01:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3Afi9cDyYGVcBasUJn6ZFLbtmcceDZWXuJzSCOucgOM=;
        b=CJundx62RXdKNJgWRLWh4anaWE6EyV8j8Z+f3lVFSNwjoBgyV6F5wT8wEzGa0I5tMM
         7in0cz4s/hTy5wEp0df0zHE0msQ2t3r4O2FvbrYlR+/i/bfpztYkvWVcqxZXnPesWQcQ
         Cb7Y2sprNCiIKKd7SCVmderzG2QFf9QtqeAAKK/Cf3FeaTNOcT6T+ALdVdq3E0HhEh70
         KrqVTGWuCMHBB2USumt3rn9anh54+y9HhpjFUpTkGqnmfkCYiFIPxJ9tRIYvEMLevJ4/
         F3ZjqbDp/TNokkelMnGUpMkWJaVc9CnS999wKNbvWz7322fIk0wnhYfVs+LZbr2kwEDz
         NNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=3Afi9cDyYGVcBasUJn6ZFLbtmcceDZWXuJzSCOucgOM=;
        b=ZXRWs2DZwVHPrtrt6OYVo9d79VVPyF5JmwzhpSMaXRGymQiPlRrTarUloBDdThDo59
         PBzauJow6Ah47lbk4fjF3m6qNfCOO9+h7D3fzrnrYgjVXUrQmRzP1TU3iMnK3VP2UC4l
         RMvlzQtHs6O2/LcKGcZceSJRFWhEJI9lp5eZUPsPwS9nL904Kz3qucRy5Rw0Dd63yJEI
         O2FO6OpU1D1vcC0QwbvkncBAirjbmg+OfzQWaaQCMVbzw31R5Uz5J3BK7BjqDWI8bMI1
         ZIN4oJBZuBTI5g6JahQxN/mcbYb9W5EKNyan9WYxUmAw28HI8JCFKYAekJKrmOzCl3+L
         7ukg==
X-Gm-Message-State: AG10YORgJ/CutIt9uTHUv4Qlja+nyAffK3X2H3b6fgOMj5LW2EID8zgOISCQ+x2s8d8yGA==
X-Received: by 10.66.230.201 with SMTP id ta9mr752605pac.52.1454492158720;
        Wed, 03 Feb 2016 01:35:58 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id pu3sm8423255pac.9.2016.02.03.01.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 01:35:57 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 03 Feb 2016 16:36:10 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285346>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 usage.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/usage.c b/usage.c
index 82ff131..0dba0c5 100644
--- a/usage.c
+++ b/usage.c
@@ -109,19 +109,12 @@ void NORETURN die(const char *err, ...)
 	va_end(params);
 }
=20
-void NORETURN die_errno(const char *fmt, ...)
+static const char *fmt_with_err(const char *fmt)
 {
-	va_list params;
-	char fmt_with_err[1024];
+	static char fmt_with_err[1024];
 	char str_error[256], *err;
 	int i, j;
=20
-	if (die_is_recursing()) {
-		fputs("fatal: recursion detected in die_errno handler\n",
-			stderr);
-		exit(128);
-	}
-
 	err =3D strerror(errno);
 	for (i =3D j =3D 0; err[i] && j < sizeof(str_error) - 1; ) {
 		if ((str_error[j++] =3D err[i++]) !=3D '%')
@@ -137,9 +130,21 @@ void NORETURN die_errno(const char *fmt, ...)
 	}
 	str_error[j] =3D 0;
 	snprintf(fmt_with_err, sizeof(fmt_with_err), "%s: %s", fmt, str_error=
);
+	return fmt_with_err;
+}
+
+void NORETURN die_errno(const char *fmt, ...)
+{
+	va_list params;
+
+	if (die_is_recursing()) {
+		fputs("fatal: recursion detected in die_errno handler\n",
+			stderr);
+		exit(128);
+	}
=20
 	va_start(params, fmt);
-	die_routine(fmt_with_err, params);
+	die_routine(fmt_with_err(fmt), params);
 	va_end(params);
 }
=20
--=20
2.7.0.377.g4cd97dd

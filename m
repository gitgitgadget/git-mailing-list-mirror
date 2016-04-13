From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/26] fetch-pack: use skip_prefix() instead of starts_with()
Date: Wed, 13 Apr 2016 19:54:54 +0700
Message-ID: <1460552110-5554-11-git-send-email-pclouds@gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:56:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKL8-0004Fa-Rc
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030745AbcDMM4H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 08:56:07 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35335 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030725AbcDMM4E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:56:04 -0400
Received: by mail-pf0-f195.google.com with SMTP id r187so4086609pfr.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b7nG6B4M+hdvxTCA1g7asoD6S55fb68pf3hYcgqECug=;
        b=A0c68mZjLi5AT5ZdbZY1LlWyHKIqDWIrS6EkqD50bNUFLatkF5TSToNTUM9TSlHCIa
         xcKfKV43viP9JjJwFfoQmj9YeH2glBX/TDPSV1nIadQeWm5cG5EyjTzN/gW86OCLGYId
         i1YsrHnXlnnQ3zD3A7E28iyaX5CIrMlOkyALcQdqBzGyDikhu62qyWYos6bb5cT/p78X
         Ri+7Pd1reqRphzzxSCsjlN4zmtmp0tlgrwFrFY3JNSLhSbDrSjRjW+fmL2Wi6FZtkvSU
         tGkhcgpAcpR7mq5bIXT52QOWCSaJCSumv0P7g3dRAa5TXjdy8752FL+Mb90FEhXtU39y
         0uog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b7nG6B4M+hdvxTCA1g7asoD6S55fb68pf3hYcgqECug=;
        b=VMFld2XYTOZ/4CUFsltDcMS2T7zeAXdqYGUhkSjBovaCdHOaQjMtcnR7wlMgU8meas
         UDvtp4N16KzTTolwLCYCb41V93ByJ4nHnhIYB7XXNlVPwLc7T4D51kkSI0ZQJISr3sEf
         GrtKiC8TelHpAUUj4Dxqb3Q0zbMSGLlZUWcXH9iPBslskppH2e9CBKobWsDnU/U6GgdN
         oVYFPYuUNqp6WcB617OlhcmKTXxN/0Af/pgPajan5LZfCC7BCtSqV5azzBEgRPaUCgfh
         mrxSJ5Wan94W4KhFuH/JTB0wQ/gXL6VAUhNANsI0lK3ctea0ambKOCxloBh6EJeLicvB
         qTRQ==
X-Gm-Message-State: AOPr4FVsws1WW6UU4M1UvbupQmSL9EVC30JOuwnUB81Iw99HVlmjZkSKz2M+SgcZJ6r/lA==
X-Received: by 10.98.34.200 with SMTP id p69mr12620468pfj.114.1460552163231;
        Wed, 13 Apr 2016 05:56:03 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id vu5sm45402458pab.43.2016.04.13.05.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 05:56:02 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 19:56:09 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291402>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 9b2a514..8332d3d 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -59,12 +59,12 @@ int cmd_fetch_pack(int argc, const char **argv, con=
st char *prefix)
 	for (i =3D 1; i < argc && *argv[i] =3D=3D '-'; i++) {
 		const char *arg =3D argv[i];
=20
-		if (starts_with(arg, "--upload-pack=3D")) {
-			args.uploadpack =3D arg + 14;
+		if (skip_prefix(arg, "--upload-pack=3D", &arg)) {
+			args.uploadpack =3D arg;
 			continue;
 		}
-		if (starts_with(arg, "--exec=3D")) {
-			args.uploadpack =3D arg + 7;
+		if (skip_prefix(arg, "--exec=3D", &arg)) {
+			args.uploadpack =3D arg;
 			continue;
 		}
 		if (!strcmp("--quiet", arg) || !strcmp("-q", arg)) {
@@ -100,8 +100,8 @@ int cmd_fetch_pack(int argc, const char **argv, con=
st char *prefix)
 			args.verbose =3D 1;
 			continue;
 		}
-		if (starts_with(arg, "--depth=3D")) {
-			args.depth =3D strtol(arg + 8, NULL, 0);
+		if (skip_prefix(arg, "--depth=3D", &arg)) {
+			args.depth =3D strtol(arg, NULL, 0);
 			continue;
 		}
 		if (!strcmp("--no-progress", arg)) {
--=20
2.8.0.rc0.210.gd302cd2

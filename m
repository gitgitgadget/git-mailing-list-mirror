From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 06/41] builtin/fetch.c: use error_errno()
Date: Sun,  8 May 2016 16:47:26 +0700
Message-ID: <1462700881-25108-7-git-send-email-pclouds@gmail.com>
References: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
 <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 11:50:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLKs-0008Re-9I
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbcEHJtJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:49:09 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36009 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbcEHJtI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:49:08 -0400
Received: by mail-pf0-f194.google.com with SMTP id p185so16152150pfb.3
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zt+Lm0OheJFB7DqF11/v6HYMdV/zJs5N6kKanqhHl00=;
        b=jlAxFSRYVOx3c24JABhNZYG+oC/42igW/jhdGaMkVus6pstdfXrsKJJc2jzuqMX6I9
         iHvS9ixRqFc7xnQqy8lLVgmBSr+9WmYRVKfUgHnFI71wSniA+1Hsy1nXBgeb2UWb41tC
         DMtvwNVMIkLNixr9+xIs950Fsb8ngcJJQ/bY+dIo7bQZQHGQqCzCtDz59pPh9SVAEBnG
         MVxp04pSS3n0XyOhZNpDBuRRcX9dmqOId/Gct5ePQOdCGa6rMdezxhwR1zwX68jYJG2v
         Cqkt1+mdEyoGo33IUYmUWip96gEduatxrvpm5MI4cl+EMQTRyG6PCy5iuZdBCeX2rSVr
         qHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zt+Lm0OheJFB7DqF11/v6HYMdV/zJs5N6kKanqhHl00=;
        b=ikVqLIUFTIAFiA9yObiEv/TlUXaOzLUvstVFgnflplml3rmRi85Vcj512XIVdmXfSy
         XYABmRDkOCRB3LuKdizTbOvwHJl5dUCodm5F5hgj+prMN7R867HJp6LPAhGmKljhHCDV
         k+x4yOfIWSQtmeGdD71Mos5QL3x2SPDcJbJrd+/2n9zQ4Q2SFkOdzYLOW3iWhDBT7/sv
         0WWmAHquduYJmh76LWmO+Ok9RijmolnshZ/twlY1lCLNZc73luGV8QgTKtjSN8427aR4
         FabHsfm1zKmGDYI+meFmpmbEvTd5grrUYRvb9R3b2D8mW5ADaj0HCg2R2f6xZrKwfVQF
         kqkg==
X-Gm-Message-State: AOPr4FW4apz4XUdsbTUWVQUNva5kKH5gmRcXoVzJ/CKwZdjpTHZczvL8cCTplQ2Q4/YSGw==
X-Received: by 10.98.29.137 with SMTP id d131mr41944469pfd.2.1462700947435;
        Sun, 08 May 2016 02:49:07 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id h6sm32846234paf.23.2016.05.08.02.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:49:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:49:07 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293922>

A couple of newlines are also removed, because both error() and
error_errno() automatically append a newline.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f8455bd..1582ca7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -607,7 +607,7 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
=20
 	fp =3D fopen(filename, "a");
 	if (!fp)
-		return error(_("cannot open %s: %s\n"), filename, strerror(errno));
+		return error_errno(_("cannot open %s"), filename);
=20
 	if (raw_url)
 		url =3D transport_anonymize_url(raw_url);
@@ -848,7 +848,7 @@ static int truncate_fetch_head(void)
 	FILE *fp =3D fopen_for_writing(filename);
=20
 	if (!fp)
-		return error(_("cannot open %s: %s\n"), filename, strerror(errno));
+		return error_errno(_("cannot open %s"), filename);
 	fclose(fp);
 	return 0;
 }
--=20
2.8.0.rc0.210.gd302cd2

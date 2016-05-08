From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 22/41] diff-no-index.c: use error_errno()
Date: Sun,  8 May 2016 16:47:42 +0700
Message-ID: <1462700881-25108-23-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:52:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLMQ-0001Wb-PF
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbcEHJur convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:50:47 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36368 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbcEHJuq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:50:46 -0400
Received: by mail-pf0-f193.google.com with SMTP id p185so16154212pfb.3
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ixKnY5jHiqlgjhRy4Dh1VQCzCIoB5KlROrcgSjkOfmc=;
        b=O2eGokiY6EvLGVEZNh/IhLY/t/izKSLLIcvZM0o5V8BAclS2eaDO7uoEKZD1wwj32F
         z2o/BSMe68F8O6YMJN9xn20Fv13Yh9SXgCQpP9OA2qykoO+TamPRkhEwBwAOP+piNRUq
         UhxeQymV9HZ1EhxC+6HwewrwhbulQIkW4v9Td6HI2CcWB5GPIXnC0HBLfaS5DOGaCxNF
         Ivfw1mpzj1m1WU+gm0+GQ/fnKrbSRmYToQdoo3j8fN3k4HU7CTUMNy7foypx6DeorWrM
         BlQyzbPEb/4gIj3zPTArGUjzUZYq3vpocinI7WIszKrCG2UvmXpMcjaQ5bDKLLTJFgOP
         ZXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ixKnY5jHiqlgjhRy4Dh1VQCzCIoB5KlROrcgSjkOfmc=;
        b=CmLIkHhPVLLfG77ZR2WB7lgKykk+BmQTgh6ZikP4B1jGUGju5cTB7Xif6Js0gFUAaO
         UWzliK5FcAQRo5A2DHz9Gagz51LMMqommzCd9+cAbSR0fno4sO3gMIUX7FWE+tjNnI0n
         ea3+KRTLF6FJdKA8QgopX8P434rv/9RJ4VhyjJ6FAnL3ZqVOTkUlfkg8G4Ao9gJgccAy
         Df8HPQYON1Ad5u1Bv4PUsBqVyEBv7rnMnxDfTX+pG/Sre4Zd/D1uNe3wbyanjaUQQdT8
         zVy2G1QP7slxIuarXrPlT92ZQEdOFVE3qxnT+Lq2eGGMnXnCOFHlQgX4xx5xYqoDMWoo
         +VNw==
X-Gm-Message-State: AOPr4FVyQAf2KUKeFWGF3fil5sdo0EJQNRgcfmsob96WcbShzVKq+/AT34i7EWWGad2++Q==
X-Received: by 10.98.95.4 with SMTP id t4mr42071657pfb.162.1462701045742;
        Sun, 08 May 2016 02:50:45 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id p187sm8101210pfb.3.2016.05.08.02.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:50:44 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:50:45 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293937>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff-no-index.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 03daadb..1f8999b 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -65,8 +65,7 @@ static int populate_from_stdin(struct diff_filespec *=
s)
 	size_t size =3D 0;
=20
 	if (strbuf_read(&buf, 0, 0) < 0)
-		return error("error while reading from stdin %s",
-				     strerror(errno));
+		return error_errno("error while reading from stdin");
=20
 	s->should_munmap =3D 0;
 	s->data =3D strbuf_detach(&buf, &size);
--=20
2.8.0.rc0.210.gd302cd2

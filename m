From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 03/25] transport-helper.c: do not send null option to remote helper
Date: Thu,  4 Feb 2016 16:03:39 +0700
Message-ID: <1454576641-29615-4-git-send-email-pclouds@gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:04:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFqF-0005ZB-Ep
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965398AbcBDJEh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 04:04:37 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33356 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965373AbcBDJE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:04:29 -0500
Received: by mail-pf0-f170.google.com with SMTP id w123so38595586pfb.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RzqAjsowWsraCpO2lU1bsqweBrJAomy77EpJn8yVMSQ=;
        b=SEB4AMBmUvamFvRLg4DH91oh3mVAuxM6vEQhiUPWKV7Dkjwqa2RS5IbpH6qAIJJDhL
         6tyNJdrJ+jCgph6yqqeAE/lkTgkL/pLtToPXjyN42CclCpP/Qc0leBW4Wxt93/NOTY2x
         rqQcV1UHPh1RRiBJB/B2SXIY+W7jOFpeYYn65uT1REsXqnHMn6IroCMKNsNEEG54fn5E
         xIGFtRI47+HBh64neGHdUy3e3LNcUg4DoQcv/TzUOi0/FaHKkEuPFZramWyqPKDQ4U1U
         X7SIRYJXaoz/LA2WW0f767iozV+Yt0PVTncJv5NBUzLtPg762RW4Tanq6KBktmltNih+
         sJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=RzqAjsowWsraCpO2lU1bsqweBrJAomy77EpJn8yVMSQ=;
        b=CuEYJJikf6kvN8AsN0vJ17uNvD3EfzP1NDHsIu2vA7Pc7we8jdXS+gavXys25bJvoz
         h039bOd1d1aw0Q5J/UXqx/SdlX4wo6Q5tXWQoK878WloDThlWm8szrszI4NVHxV4fubq
         I86j5saF4U0lZFH7d6Bq1fxSZ/U/MetJ9KgkQciZb8GlHFjnNtPp3JMSW5F9OS9uY02+
         MygkY/7zfGNes6vcDj6lTvlwywOJovc0FUwBPBKGdsXHdOTUQD3xO3lkgaqNgWyEmThO
         XzGsGPVfeFs635DWSNd8xv6mQ7Hv6eIO9hPTCT0E1DtcZbqsXk4d7MgufxFu45Lm8Sar
         WD4A==
X-Gm-Message-State: AG10YOQkDe4TIAC7ldul6Ozulw7cxiTjlZM6K0I4JWWhtmPn0ruri8/SkXEJuOsWd6M0PQ==
X-Received: by 10.66.62.132 with SMTP id y4mr8760675par.49.1454576668905;
        Thu, 04 Feb 2016 01:04:28 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id h66sm15298144pfd.91.2016.02.04.01.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:04:27 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 04 Feb 2016 16:04:41 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285417>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 transport-helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 35023da..2e78c4d 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -309,8 +309,12 @@ static int set_helper_option(struct transport *tra=
nsport,
 	strbuf_addf(&buf, "option %s ", name);
 	if (is_bool)
 		strbuf_addstr(&buf, value ? "true" : "false");
-	else
+	else if (value)
 		quote_c_style(value, &buf, NULL, 0);
+	else {
+		strbuf_release(&buf);
+		return 0;
+	}
 	strbuf_addch(&buf, '\n');
=20
 	ret =3D strbuf_set_helper_option(data, &buf);
--=20
2.7.0.377.g4cd97dd

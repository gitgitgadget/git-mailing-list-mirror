From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 19/25] refs: add expand_ref()
Date: Thu,  4 Feb 2016 16:03:55 +0700
Message-ID: <1454576641-29615-20-git-send-email-pclouds@gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:06:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFrq-0007Tl-Ep
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965558AbcBDJGL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 04:06:11 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35172 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965563AbcBDJGE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:06:04 -0500
Received: by mail-pf0-f177.google.com with SMTP id 65so38511241pfd.2
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=LzQv+iIYy4yN2gAf7UNqIE+CyH5AWE9CmvG5y0IXyLY=;
        b=k20cvLS8ATVxV5gSeSIlaMh33DlP0PCijj3Dd47s7CCZprZax1lcy0dJySmXn3H76R
         d1pnL6tuljHkUwSMpC3F28Ta0iDgq5GntI1IG6FhpzFT8w722WOfvrkUUm4Fw7dyyCmV
         v6jBZoCRsXVt5Onrx99yNjuBJmxp5l0nxYb4IdA04Q6BXXifCwQJAUf7YICXc87FzYMK
         7ol0lKx1dsBird/7kaQQl4atNRQpuzE02Cu29y3y8MQFMPXqTFzNjZ47a6xFYd1SZrRI
         Y+eJdGTtsDsTVXxWGRNdbi4Dgit/JtvN7/ZPWzR6DQ4o8unoMd61xDH/YRUCr26lZs25
         1MwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=LzQv+iIYy4yN2gAf7UNqIE+CyH5AWE9CmvG5y0IXyLY=;
        b=an5qZqQyn25krmIgRCfUhTJeKVanr8LekZDqkwiTlmsMpOBf49BcDdYD03G4dQrQqN
         sefYCO5UPWJuLeueZXwLF/JuCh1HvyyK50tFxPdw0ApguziYqocbK18NuK0oyzoGUL4C
         cIAy5nGYrC1otcKH6xKqKue2cwqmK/hJHSpxHwh1B12ZZzHs7bGU1JVpZW0qmQg6YMmA
         W3PgvlCAeWL+GJWFpbmGlFALhEo6P2g0FlSfcFeSECD2p4ksfAnsWUrvLT41ImozsIhj
         z1k75iTctuu1N7RCxOQBN1O1ENWJ5mKUe/nVMwhjv001UIgjkFq/Ki4waJHLU37CV/nj
         VOjg==
X-Gm-Message-State: AG10YOSORag+CBscxqtGUKKeXO7CoHVPkZ35H+TpQYjaR89ALs6+bh3pOXiFX4wMqhRGtg==
X-Received: by 10.98.17.92 with SMTP id z89mr9492227pfi.16.1454576763901;
        Thu, 04 Feb 2016 01:06:03 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id 74sm15407852pfs.33.2016.02.04.01.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:06:02 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 04 Feb 2016 16:06:16 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285432>

This is basically dwim_ref() without @{} support. To be used on the
server side where we want to expand abbreviated to full ref names and
nothing else.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 refs.c | 8 +++++++-
 refs.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index e2d34b2..842e4d8 100644
--- a/refs.c
+++ b/refs.c
@@ -392,6 +392,13 @@ static char *substitute_branch_name(const char **s=
tring, int *len)
 int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref=
)
 {
 	char *last_branch =3D substitute_branch_name(&str, &len);
+	int   refs_found  =3D expand_ref(str, len, sha1, ref);
+	free(last_branch);
+	return refs_found;
+}
+
+int expand_ref(const char *str, int len, unsigned char *sha1, char **r=
ef)
+{
 	const char **p, *r;
 	int refs_found =3D 0;
=20
@@ -417,7 +424,6 @@ int dwim_ref(const char *str, int len, unsigned cha=
r *sha1, char **ref)
 			warning("ignoring broken ref %s.", fullref);
 		}
 	}
-	free(last_branch);
 	return refs_found;
 }
=20
diff --git a/refs.h b/refs.h
index 3c3da29..31a2fa6 100644
--- a/refs.h
+++ b/refs.h
@@ -90,6 +90,7 @@ extern int resolve_gitlink_ref(const char *path, cons=
t char *refname, unsigned c
  */
 extern int refname_match(const char *abbrev_name, const char *full_nam=
e);
=20
+extern int expand_ref(const char *str, int len, unsigned char *sha1, c=
har **ref);
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, cha=
r **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, cha=
r **ref);
=20
--=20
2.7.0.377.g4cd97dd

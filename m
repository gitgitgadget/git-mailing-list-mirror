From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 28/41] http.c: use error_errno() and warning_errno()
Date: Sun,  8 May 2016 16:47:48 +0700
Message-ID: <1462700881-25108-29-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:53:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLN2-0002DC-ST
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbcEHJvZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:51:25 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36509 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbcEHJvY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:51:24 -0400
Received: by mail-pf0-f195.google.com with SMTP id p185so16155315pfb.3
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pV6RZ1p+1oq/fdJUjZaS/3RUhTIAvJqDLyZISrvbfVM=;
        b=TK1hmhQ8iE/5qm7Z+UsiEwamDmOuYJqomz0ZCWBPaSM4/JfmW7yw4IeMMows4CsPbB
         FCZnNHxd3L7yfHYEzJ/61Aa/R8bzixRadV9YhPzK8nXChCxKhvh6tHExM3ClaJ8pK6Bm
         QJ4kdb8vLVCbFd6PBZRZauwy+8CxFr+r6SM+ivFQvPuKjWZYb0hDXUZfkZbAVzhUKbsb
         KyYLBcPqsYMgS4rJLr7t9rk04RBhVW0snknBvc7mc57fTANNah9X8Gfj1bWAwf+MbbQa
         kH5DEjZiP6ch7qKmExkvOtnvg9QWmIrVyk9w3AQzA1EXKqzbK0ZPcDf9f4v3X3BxTjFc
         BjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pV6RZ1p+1oq/fdJUjZaS/3RUhTIAvJqDLyZISrvbfVM=;
        b=Y/fcBLkHVGi16zFE2Tcd867dI0XW+sCJMaLlPd1Q4JoiTU3afmtewK/5MbxRLKL0yQ
         CFFnUXPrbnZuRHec/PhvU2v/Fy1+CjGo+yyJ+gVsvR78Na4TKs4DXe8g45B8SaLIaizC
         w338ETpIdsM+7IlgeCJsqLMDnghx2VpwFEl/uvmipkkDwbNWN5ThLpPrf8oHI5tzsNmm
         2xqd7VK88XYOiAbPT8B6WDdOA5LMr1JMEKfIUSlisUvTg4GG4gIkqBnNHtwB6H1TqfVv
         w9iRSxjVptvK9mtjUdeZrDyfeRvycIzT3UMmaGQvUCbi4THniVeqZpkKKz2kGS+d1RjC
         vIEg==
X-Gm-Message-State: AOPr4FUajMp6dXlPbdS9RO5P1N764nGeXe4KVXC8wY2+adEYMd4IFqQr3bS69eONVYoBog==
X-Received: by 10.98.82.19 with SMTP id g19mr41524198pfb.157.1462701083853;
        Sun, 08 May 2016 02:51:23 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id nz6sm32846537pab.39.2016.05.08.02.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:51:22 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:51:23 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293951>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 http.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/http.c b/http.c
index 4304b80..7565c93 100644
--- a/http.c
+++ b/http.c
@@ -446,8 +446,7 @@ static int sockopt_callback(void *client, curl_sock=
et_t fd, curlsocktype type)
=20
 	rc =3D setsockopt(fd, SOL_SOCKET, SO_KEEPALIVE, (void *)&ka, len);
 	if (rc < 0)
-		warning("unable to set SO_KEEPALIVE on socket %s",
-			strerror(errno));
+		warning_errno("unable to set SO_KEEPALIVE on socket");
=20
 	return 0; /* CURL_SOCKOPT_OK only exists since curl 7.21.5 */
 }
@@ -1894,8 +1893,7 @@ struct http_object_request *new_http_object_reque=
st(const char *base_url,
 	}
=20
 	if (freq->localfile < 0) {
-		error("Couldn't create temporary file %s: %s",
-		      freq->tmpfile, strerror(errno));
+		error_errno("Couldn't create temporary file %s", freq->tmpfile);
 		goto abort;
 	}
=20
@@ -1940,8 +1938,8 @@ struct http_object_request *new_http_object_reque=
st(const char *base_url,
 			prev_posn =3D 0;
 			lseek(freq->localfile, 0, SEEK_SET);
 			if (ftruncate(freq->localfile, 0) < 0) {
-				error("Couldn't truncate temporary file %s: %s",
-					  freq->tmpfile, strerror(errno));
+				error_errno("Couldn't truncate temporary file %s",
+					    freq->tmpfile);
 				goto abort;
 			}
 		}
--=20
2.8.0.rc0.210.gd302cd2

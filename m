From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 28/41] http.c: use error_errno() and warning_errno()
Date: Tue,  3 May 2016 19:04:01 +0700
Message-ID: <1462277054-5943-29-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
 <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 14:09:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ8c-0000xD-Mc
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932971AbcECMJJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:09:09 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35123 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932634AbcECMJH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:09:07 -0400
Received: by mail-pf0-f178.google.com with SMTP id 77so9242820pfv.2
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pV6RZ1p+1oq/fdJUjZaS/3RUhTIAvJqDLyZISrvbfVM=;
        b=FdpkPzuqFCfnqD4Vj894fowa6aeynGZLYCKo5rKcXIhnzE8mo63Hpt/hXurHl3Qc0D
         hYDnczPxKY5AFmSPYB/Uto8MIj+lGkSX2/hxhfHEZxDj5hBR/QaeCFBqLwpBseo5Ovzo
         h7BbAANz3XDtKa8RilelOBa/H8U/QgUEMWFx+SuhKdLVr8P8+KyrGt3UTmxVMM6eoZjl
         fRpsWBQM30K7ksulAtrw5yhiJsPo1RXJ1oE1fKR+tdgM+8WtnGE5WJrOD9FzZ2vRB9Zw
         cF4NOfyuoriOJGB0mo2j+O7K2HJ9YzOBelw/CO6OwVWUkGvw5KGAbIQdeXgYjPgL6iZW
         2D1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pV6RZ1p+1oq/fdJUjZaS/3RUhTIAvJqDLyZISrvbfVM=;
        b=jVyXASE/tJNVgmYLoik6JlE6ejC9IF/WZL/+xTjoS4J7FqTtRuy8Rjy7iftzlBX5PR
         WaHoeEBmyVCb2/sFaD+T9Dui/offGzxNRiMsrOqpWEIHrdjhRwrpCZj4Mp25sSuYjj+M
         Q4ZWbMQO0iWC2Z8FWjwfKUu69utKpaLqhOcaAyymMuuvWmzncSTndE4yksHn0I3HPlw7
         ZHmaPC86rnXo6ABrbouE7Ycv1WGvWrd0lUrNbgPimaAbvl6ii1JLw2itZtjBs/oHfY5B
         lIrBC0caVIDFuwhDlVucyPFW0MJIjDodbAE9APFBRL/Jhnkap6V6a/9O92d+sYP8tsPu
         xKsw==
X-Gm-Message-State: AOPr4FXbPA5Ztwd8aX0MiR628m+r+OgoXHjsVTVfc5E1iKIDdsc5nQ4CFE7rnaFWbomFdQ==
X-Received: by 10.98.66.145 with SMTP id h17mr2898559pfd.100.1462277346907;
        Tue, 03 May 2016 05:09:06 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id fn3sm5515574pab.20.2016.05.03.05.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:09:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:09:02 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293381>

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

From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 2/4] http.c: implements the GIT_TRACE_CURL environment variable
Date: Tue, 19 Apr 2016 15:10:42 +0000
Message-ID: <20160419151044.27814-3-gitter.spiros@gmail.com>
References: <20160419151044.27814-1-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, ramsay@ramsayjones.plus.com, gitster@pobox.com,
	sunshine@sunshineco.com, peff@peff.net,
	Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 17:11:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asXIw-0007DB-Rx
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 17:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbcDSPK6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2016 11:10:58 -0400
Received: from mail-qg0-f67.google.com ([209.85.192.67]:35791 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106AbcDSPK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 11:10:57 -0400
Received: by mail-qg0-f67.google.com with SMTP id b14so827452qge.2
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GDkiaLLLRSOKj2w/ttVgfdg9lxpd0b09S8y9krAI8so=;
        b=XFVlTjyhUdp5FBf5CJGMIgfGbnoHZt9vPOa8b1LC6i+LWO1t36RZq2wAHbNFZT52bw
         utDHmCozloG/qQAjfmUgSLmbBBniHHRlXNBzKBOp7MZLFqBzWvDF7r+2y3vjkcg3aSvr
         7Mfgnv05/TQYhRRDQYssKtLUJknbJDdsPMVBFmt3zXaIV6RxUgaavGKTxKtJRUiH/VFE
         F4RLLWuL2OQKfXwozglhNLO5oPy9WLnGPH1ow9JwzeI1IzGUCX1qQW0uSj8fX1JTHL8w
         pu4Ttf2boB3y5EaabUyWikScJJ/VdH39dkKBmx1Qxv8NWaQzVxY/5+/zqQeCbWZFUrO1
         pspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GDkiaLLLRSOKj2w/ttVgfdg9lxpd0b09S8y9krAI8so=;
        b=WC3PzQQhASlcR3ja6Y9Gm3eGIyOPZdmZJHZgtbOqtoFgL8vXXjm5pTeYfYEb4Ljysk
         iQjpekQPCI0KQzMX3nEjlB7rlCMBiuHXyE6r6dzFhmPpgX2+v2Y9cvOyJ6+FmCrUOETy
         tbZAtcvqXoDwJ8vxXPzRcp8Z9JfWFfccDTstB9EQm2nvmS44j0eqlcLMD23sIamF57Vd
         B1yBaHANk4aXNP1GYSlDj5/pm3BDJJZGewtl657MldRVspgqkLoO3uO9Z1Nqa19/ylSy
         yS1WT+HSTTOn7Y/Somx/0bXpjVa9mMGfrzgtFEoWVok6Uohy5/L801i3xHAZEusPH7B3
         zeaw==
X-Gm-Message-State: AOPr4FXizlAoRoJ8ktlzbLP6QxLZyYY8n2h5Q8OSMEOpOctPnbIl+HAzHbHXEHU65SqEOA==
X-Received: by 10.194.78.235 with SMTP id e11mr3651299wjx.54.1461078656034;
        Tue, 19 Apr 2016 08:10:56 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id u16sm4846168wmd.5.2016.04.19.08.10.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 08:10:55 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.383.g0f2638b
In-Reply-To: <20160419151044.27814-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291869>

Implements the GIT_TRACE_CURL environment variable to allow a
greater degree of detail of GIT_CURL_VERBOSE, in particular
the complete transport header and all the data payload exchanged.
It might be useful if a particular situation could require a more
thorough debugging analysis


Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>=20
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 http.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index 4304b80..278991e 100644
--- a/http.c
+++ b/http.c
@@ -11,6 +11,9 @@
 #include "gettext.h"
 #include "transport.h"
=20
+/*
+tatic struct trace_key trace_curl =3D TRACE_KEY_INIT(CURL);
+*/
 #if LIBCURL_VERSION_NUM >=3D 0x070a08
 long int git_curl_ipresolve =3D CURL_IPRESOLVE_WHATEVER;
 #else
@@ -464,6 +467,95 @@ static void set_curl_keepalive(CURL *c)
 }
 #endif
=20
+
+void curl_dump(const char *text, unsigned char *ptr, size_t size, char=
 nohex)
+{
+	size_t i;
+	size_t w;
+	struct strbuf out =3D STRBUF_INIT;;
+
+	unsigned int width =3D 0x10;
+
+	if (nohex)
+		/* without the hex output, we can fit more on screen */
+		width =3D 0x40;
+
+	strbuf_addf(&out, "%s, %10.10ld bytes (0x%8.8lx)\n",
+		text, (long)size, (long)size);
+
+	for (i =3D 0; i < size; i +=3D width) {
+
+		strbuf_addf(&out, "%4.4lx: ", (long)i);
+
+		if (!nohex) {
+			/* hex not disabled, show it */
+			for (w =3D 0; w < width; w++)
+				if (i + w < size)
+					strbuf_addf(&out, "%02x ", ptr[i + w]);
+				else
+					strbuf_addf(&out,"   ");
+		}
+
+		for (w =3D 0; (w < width) && (i + w < size); w++) {
+			/* check for 0D0A; if found, skip past and start a new line of outp=
ut */
+			if (nohex && (i + w + 1 < size) && ptr[i + w] =3D=3D '\r'
+			    && ptr[i + w + 1] =3D=3D '\n') {
+				i +=3D (w + 2 - width);
+				break;
+			}
+			strbuf_addch(&out, (ptr[i + w] >=3D 0x20)
+				&& (ptr[i + w] < 0x80) ? ptr[i + w] : '.');
+			/* check again for 0D0A, to avoid an extra \n if it's at width */
+			if (nohex && (i + w + 2 < size)
+			    && ptr[i + w + 1] =3D=3D '\r'
+			    && ptr[i + w + 2] =3D=3D '\n') {
+				i +=3D (w + 3 - width);
+				break;
+			}
+		}
+		strbuf_addch(&out, '\n');
+		trace_strbuf(&trace_curl, &out);
+		strbuf_release(&out);
+	}
+}
+
+int curl_trace(CURL *handle, curl_infotype type,
+	     char *data, size_t size, void *userp)
+{
+	const char *text;
+	(void)handle;		/* prevent compiler warning */
+
+	switch (type) {
+	case CURLINFO_TEXT:
+		trace_printf_key(&trace_curl, "=3D=3D Info: %s", data);
+	default:		/* in case a new one is introduced to shock us */
+		return 0;
+
+	case CURLINFO_HEADER_OUT:
+		text =3D "=3D> Send header";
+		break;
+	case CURLINFO_DATA_OUT:
+		text =3D "=3D> Send data";
+		break;
+	case CURLINFO_SSL_DATA_OUT:
+		text =3D "=3D> Send SSL data";
+		break;
+	case CURLINFO_HEADER_IN:
+		text =3D "<=3D Recv header";
+		break;
+	case CURLINFO_DATA_IN:
+		text =3D "<=3D Recv data";
+		break;
+	case CURLINFO_SSL_DATA_IN:
+		text =3D "<=3D Recv SSL data";
+		break;
+	}
+
+	curl_dump(text, (unsigned char *)data, size, 1);
+	return 0;
+}
+
+
 static CURL *get_curl_handle(void)
 {
 	CURL *result =3D curl_easy_init();
@@ -563,7 +655,11 @@ static CURL *get_curl_handle(void)
 			"your curl version is too old (>=3D 7.19.4)");
 #endif
=20
-	if (getenv("GIT_CURL_VERBOSE"))
+	if (trace_want(&trace_curl)) {
+		curl_easy_setopt(result, CURLOPT_VERBOSE, 1L);
+		curl_easy_setopt(result, CURLOPT_DEBUGFUNCTION, curl_trace);
+		curl_easy_setopt(result, CURLOPT_DEBUGDATA, NULL);
+	} else if (getenv("GIT_CURL_VERBOSE"))
 		curl_easy_setopt(result, CURLOPT_VERBOSE, 1);
=20
 	curl_easy_setopt(result, CURLOPT_USERAGENT,
--=20
2.5.0

From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 2/2] http.c: implements the GIT_CURL_DEBUG environment variable
Date: Fri,  1 Apr 2016 10:44:42 +0000
Message-ID: <1459507482-36678-2-git-send-email-gitter.spiros@gmail.com>
References: <1459507482-36678-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 12:44:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alwZW-00049j-3z
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 12:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758498AbcDAKox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 06:44:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33874 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754992AbcDAKow (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 06:44:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id p65so3591420wmp.1
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 03:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/LZkZk3trXQEohWrmQ/8L8SJakbnJsaD3Q1Y1FZVCNI=;
        b=IiAk6qR5ZF6UpwBL2NhuQ8BJMMMReHzC4creEMYBkLVqu7oazBfReyQTj4Es9gnG5T
         1x+kxphNKugLfl8v6yMdnFaWZc6xXfPnyZBUd5r72cL3yd4h0RG/8IXni9z3LIwfWZh+
         oEe68hK1byWOFbO5a2dJfKIu6Fr8e7pc4PsXrPDQ2qbdc8389ttN+LOUdMfQ/E0h/8i/
         ZBeYCZHFvru/IxkL5MaW5nsgH1eWPTKCFRxBXoj6Q/6p8+I76VgyBO+D9ahIyDGN0XgF
         MEp2X8hg1E+ZEe0gpyhbJGnkvKQ0zQQaHSFKufNxjjInLb+zvomO5N9tljsLaXNsOLKF
         V4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/LZkZk3trXQEohWrmQ/8L8SJakbnJsaD3Q1Y1FZVCNI=;
        b=UkY4TUcYZt7LQfLZC1bnt3nf5YI0o8f9rBZGQNTzRtN8Gqm5zFdtmBAE3J2p/eR62/
         t0Nf3T9duLYEm8oaYsW6oynOmRllj82zzH/rby3RXENg3DgDYQEi3XuWwiX1DboH5rur
         DiA/azqk1enA5NZWpu4CFBdIfL/Zoc1sgTDGXSXpXotNDvxifV8NMOsVrgqy7YZxHSEP
         /2DDucTMLndfahSKdGmz3PK8uoSldMWmGPS1GzHKKNCUHuOIa7d7vc8iuRsiQNhrLoQ6
         2frJlMUHr1SJjNiHi5apY1OrReXl1d7IU9zzgGpxwxqtT5GbpERTeIU0w7QD3nWY1DqG
         e/cg==
X-Gm-Message-State: AD7BkJLckBocgINX+xQglxZAmQZi/KSvAmTxJcRgSBJvXfvf5mKOixTqLaYXilPmLQr/2Q==
X-Received: by 10.28.105.5 with SMTP id e5mr3219395wmc.87.1459507490803;
        Fri, 01 Apr 2016 03:44:50 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id hq2sm13467438wjb.3.2016.04.01.03.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Apr 2016 03:44:50 -0700 (PDT)
X-Mailer: git-send-email 2.7.0.416.gbf6b42c.dirty
In-Reply-To: <1459507482-36678-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290520>

Implements the GIT_CURL_DEBUG environment variable to allow a greater
degree of detail of GIT_CURL_VERBOSE, in particular the complete
transport header and all the data payload exchanged.
It might be useful if a particular situation could require a more
thorough debugging analysis.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 http.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index dfc53c1..079779d 100644
--- a/http.c
+++ b/http.c
@@ -437,6 +437,97 @@ static void set_curl_keepalive(CURL *c)
 }
 #endif
 
+
+static
+void curl_dump(const char *text,
+	  FILE * stream, unsigned char *ptr, size_t size, char nohex)
+{
+	size_t i;
+	size_t c;
+
+	unsigned int width = 0x10;
+
+	if (nohex)
+		/* without the hex output, we can fit more on screen */
+		width = 0x40;
+
+	fprintf(stream, "%s, %10.10ld bytes (0x%8.8lx)\n",
+		text, (long)size, (long)size);
+
+	for (i = 0; i < size; i += width) {
+
+		fprintf(stream, "%4.4lx: ", (long)i);
+
+		if (!nohex) {
+			/* hex not disabled, show it */
+			for (c = 0; c < width; c++)
+				if (i + c < size)
+					fprintf(stream, "%02x ", ptr[i + c]);
+				else
+					fputs("   ", stream);
+		}
+
+		for (c = 0; (c < width) && (i + c < size); c++) {
+			/* check for 0D0A; if found, skip past and start a new line of output */
+			if (nohex && (i + c + 1 < size) && ptr[i + c] == 0x0D
+			    && ptr[i + c + 1] == 0x0A) {
+				i += (c + 2 - width);
+				break;
+			}
+			fprintf(stream, "%c",
+				(ptr[i + c] >= 0x20)
+				&& (ptr[i + c] < 0x80) ? ptr[i + c] : '.');
+			/* check again for 0D0A, to avoid an extra \n if it's at width */
+			if (nohex && (i + c + 2 < size)
+			    && ptr[i + c + 1] == 0x0D
+			    && ptr[i + c + 2] == 0x0A) {
+				i += (c + 3 - width);
+				break;
+			}
+		}
+		fputc('\n', stream);	/* newline */
+	}
+	fflush(stream);
+}
+
+static
+int curl_trace(CURL * handle, curl_infotype type,
+	     char *data, size_t size, void *userp)
+{
+	const char *text;
+	(void)handle;		/* prevent compiler warning */
+
+	switch (type) {
+	case CURLINFO_TEXT:
+		fprintf(stderr, "== Info: %s", data);
+	default:		/* in case a new one is introduced to shock us */
+		return 0;
+
+	case CURLINFO_HEADER_OUT:
+		text = "=> Send header";
+		break;
+	case CURLINFO_DATA_OUT:
+		text = "=> Send data";
+		break;
+	case CURLINFO_SSL_DATA_OUT:
+		text = "=> Send SSL data";
+		break;
+	case CURLINFO_HEADER_IN:
+		text = "<= Recv header";
+		break;
+	case CURLINFO_DATA_IN:
+		text = "<= Recv data";
+		break;
+	case CURLINFO_SSL_DATA_IN:
+		text = "<= Recv SSL data";
+		break;
+	}
+
+	curl_dump(text, stderr, (unsigned char *)data, size, 1);
+	return 0;
+}
+
+
 static CURL *get_curl_handle(void)
 {
 	CURL *result = curl_easy_init();
@@ -532,7 +623,11 @@ static CURL *get_curl_handle(void)
 			"your curl version is too old (>= 7.19.4)");
 #endif
 
-	if (getenv("GIT_CURL_VERBOSE"))
+	if (getenv("GIT_CURL_DEBUG")) {
+		curl_easy_setopt(result, CURLOPT_VERBOSE, 1);
+		curl_easy_setopt(result, CURLOPT_DEBUGFUNCTION, curl_trace);
+		curl_easy_setopt(result, CURLOPT_DEBUGDATA, NULL);
+	} else if (getenv("GIT_CURL_VERBOSE"))
 		curl_easy_setopt(result, CURLOPT_VERBOSE, 1);
 
 	curl_easy_setopt(result, CURLOPT_USERAGENT,
-- 
2.7.0.416.gbf6b42c.dirty

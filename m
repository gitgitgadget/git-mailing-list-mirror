Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 396D81F404
	for <e@80x24.org>; Thu, 25 Jan 2018 23:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751580AbeAYX6r (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:58:47 -0500
Received: from mail-ot0-f202.google.com ([74.125.82.202]:55292 "EHLO
        mail-ot0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbeAYX6p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:58:45 -0500
Received: by mail-ot0-f202.google.com with SMTP id 40so5942413otv.21
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=06Wipua2WVbPDvUwJxMdSPHMVxrFJ2uhUZ/D/F5AwLw=;
        b=ro5Sv/gw8F9qv7DCXmxup4dpUPwfQ37GvN0uEm0YiVGxZP7889ZOIkQnhPWDMraNzZ
         o5nKiA0isYx3ZmrI9JuyhawuDtTnr/wyss+vJVeeAeY0bL/U7iISNiK1xkVCPZq9II3H
         nVtC9evstDhbpgUsiO55lSoMlwluAqwwCvE5dPX5fBw3LqF7az8cADwQNkc4PdeVGMsJ
         46R3qXEO6nknjF2Sg0zWiYOPbYUCkMZ9g1cWN8DkVAe8/y5QO06GRywEWC/CMsktrD1a
         OAjtPROuDXTBUL5XUlHySuzoUMiLwXn9OaSZblOQDoIDObY9RzEO9Idv/mrRB90Xidaa
         Z38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=06Wipua2WVbPDvUwJxMdSPHMVxrFJ2uhUZ/D/F5AwLw=;
        b=hUMQ/ZPZKkQhhr3n2Z6zKWDm7BhjLIJDH8/MSCQbavLlWVxF8h7XOGPD+0WCGh6NC+
         Zq69a8Oeh4eOdXF+AAlk0KLibr27fLzJQ+cDnduAze5+oCkt8JyfsR60tjq4PDwVLmWc
         j3D/FpU7LQlqhaO1Pu2iThktKQ3EqZHftG1ZLLAcHmMeXM/w7gt9rVrH2yxE6vbtoJJE
         UQ/7DXR7NOm8rNsHqKPxThuJ1JNU2qXqNWgFI11+RyqwlsjBzXe4lIqT2ySDxRKZeyMR
         opgjwwzEvD29IZRw1uEDHirbTk3TlpXC9an65NZRmT4QCPNYKaOWks8A/gLgN97FUCxS
         mDPQ==
X-Gm-Message-State: AKwxytc+M1u5CxDe/F9+441k/ygU8g3cJkrvuWEwNtovrt+yXH2cKvGI
        qDYdrW6uPMHnvXAZLHiuo4rooiolRZMO1bmYlmiejmCIn46IfPoPlejdd7PTYmUsvsT+9Maa7gI
        CB1ETO1uk5UNCFP0AyWnLKSdcUxoYWRGrGVRYayTrNpGoGKsNFSwbKZRnRg==
X-Google-Smtp-Source: AH8x2275DJ/CV6Jbt+fWSB62IJMq49I3vw0Z9ZoXEtYFz5sIcani2A9GAF/UbB55nmBxUOVKeP0humTIA6c=
MIME-Version: 1.0
X-Received: by 10.157.89.162 with SMTP id u34mr7187oth.83.1516924724804; Thu,
 25 Jan 2018 15:58:44 -0800 (PST)
Date:   Thu, 25 Jan 2018 15:58:12 -0800
In-Reply-To: <20180125235838.138135-1-bmwill@google.com>
Message-Id: <20180125235838.138135-2-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v2 01/27] pkt-line: introduce packet_read_with_status
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current pkt-line API encodes the status of a pkt-line read in the
length of the read content.  An error is indicated with '-1', a flush
with '0' (which can be confusing since a return value of '0' can also
indicate an empty pkt-line), and a positive integer for the length of
the read content otherwise.  This doesn't leave much room for allowing
the addition of additional special packets in the future.

To solve this introduce 'packet_read_with_status()' which reads a packet
and returns the status of the read encoded as an 'enum packet_status'
type.  This allows for easily identifying between special and normal
packets as well as errors.  It also enables easily adding a new special
packet in the future.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pkt-line.c | 57 +++++++++++++++++++++++++++++++++++++++++++--------------
 pkt-line.h | 15 +++++++++++++++
 2 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 2827ca772..af0d2430f 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -280,28 +280,33 @@ static int packet_length(const char *linelen)
 	return (val < 0) ? val : (val << 8) | hex2chr(linelen + 2);
 }
 
-int packet_read(int fd, char **src_buf, size_t *src_len,
-		char *buffer, unsigned size, int options)
+enum packet_read_status packet_read_with_status(int fd, char **src_buffer, size_t *src_len,
+						char *buffer, unsigned size, int *pktlen,
+						int options)
 {
-	int len, ret;
+	int len;
 	char linelen[4];
 
-	ret = get_packet_data(fd, src_buf, src_len, linelen, 4, options);
-	if (ret < 0)
-		return ret;
+	if (get_packet_data(fd, src_buffer, src_len, linelen, 4, options) < 0)
+		return PACKET_READ_EOF;
+
 	len = packet_length(linelen);
-	if (len < 0)
+
+	if (len < 0) {
 		die("protocol error: bad line length character: %.4s", linelen);
-	if (!len) {
+	} else if (!len) {
 		packet_trace("0000", 4, 0);
-		return 0;
+		return PACKET_READ_FLUSH;
+	} else if (len < 4) {
+		die("protocol error: bad line length %d", len);
 	}
+
 	len -= 4;
-	if (len >= size)
+	if ((unsigned)len >= size)
 		die("protocol error: bad line length %d", len);
-	ret = get_packet_data(fd, src_buf, src_len, buffer, len, options);
-	if (ret < 0)
-		return ret;
+
+	if (get_packet_data(fd, src_buffer, src_len, buffer, len, options) < 0)
+		return PACKET_READ_EOF;
 
 	if ((options & PACKET_READ_CHOMP_NEWLINE) &&
 	    len && buffer[len-1] == '\n')
@@ -309,7 +314,31 @@ int packet_read(int fd, char **src_buf, size_t *src_len,
 
 	buffer[len] = 0;
 	packet_trace(buffer, len, 0);
-	return len;
+	*pktlen = len;
+	return PACKET_READ_NORMAL;
+}
+
+int packet_read(int fd, char **src_buffer, size_t *src_len,
+		char *buffer, unsigned size, int options)
+{
+	enum packet_read_status status;
+	int pktlen;
+
+	status = packet_read_with_status(fd, src_buffer, src_len,
+					 buffer, size, &pktlen,
+					 options);
+	switch (status) {
+	case PACKET_READ_EOF:
+		pktlen = -1;
+		break;
+	case PACKET_READ_NORMAL:
+		break;
+	case PACKET_READ_FLUSH:
+		pktlen = 0;
+		break;
+	}
+
+	return pktlen;
 }
 
 static char *packet_read_line_generic(int fd,
diff --git a/pkt-line.h b/pkt-line.h
index 3dad583e2..06c468927 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -65,6 +65,21 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
 int packet_read(int fd, char **src_buffer, size_t *src_len, char
 		*buffer, unsigned size, int options);
 
+/*
+ * Read a packetized line into a buffer like the 'packet_read()' function but
+ * returns an 'enum packet_read_status' which indicates the status of the read.
+ * The number of bytes read will be assigined to *pktlen if the status of the
+ * read was 'PACKET_READ_NORMAL'.
+ */
+enum packet_read_status {
+	PACKET_READ_EOF = -1,
+	PACKET_READ_NORMAL,
+	PACKET_READ_FLUSH,
+};
+enum packet_read_status packet_read_with_status(int fd, char **src_buffer, size_t *src_len,
+						char *buffer, unsigned size, int *pktlen,
+						int options);
+
 /*
  * Convenience wrapper for packet_read that is not gentle, and sets the
  * CHOMP_NEWLINE option. The return value is NULL for a flush packet,
-- 
2.16.0.rc1.238.g530d649a79-goog


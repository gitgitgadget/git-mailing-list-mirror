Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B05D820D17
	for <e@80x24.org>; Tue, 20 Jun 2017 07:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbdFTH4p (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:45 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36599 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752198AbdFTH4n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:43 -0400
Received: by mail-wr0-f194.google.com with SMTP id 77so16320048wrb.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8BBWfuJQ7DSfUDAjn0sWiphnrGRlVGSMIcnDgVenrqk=;
        b=X3R65JX7dG9bOqoBXmaz3meKkAyVtaXleaD53aUw3+uhDKW3k6i/GUXRhPRgZ/idx9
         xDvGNGgeivJeL0yVsgoWr0xbzxq8qSc5PyCc6a7URxR+mwoLl/LmLepZzGuwK9bbEeDc
         e2Q2ypUf4WDCUSfHj5/IX0qzC98ST2TF+lNNhEf3xEGXYZJh9A28KF3ZhpzZoh92Lxlf
         C4lxNgKHHVgvCvBXav0D4iiIvV7ek3mo99Eo1UeLs7IpZD0T3fKDYhY23XN+3jY6mZl/
         KeF30QFDwoRY5CdTIp6us+d8OLztd7uv7vDPQjdFmYFFMNOCvJHkthUPWv2Ra+aBTcE2
         IWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8BBWfuJQ7DSfUDAjn0sWiphnrGRlVGSMIcnDgVenrqk=;
        b=FYLtYLNYbXSpRjPQ6qozPu5HoZWTeg0D+q6ZLhKf74qUqogMbmj7Imv/3Wq18icaYl
         3ZVAWzpD/HWranQ0I+u9o8bpiliXWSd9SsYAH/faEDKWniqBjFrVTNr19gdBCTA+DYP5
         vBru0GM/z2wfsqspMWP0JOehUJOJRTg2GnewNb36zCDVo/OM7+wexoWv++Yo9U1iU5z9
         6LwjFTX4CeSCtQg9uGpUu7j04+gKT6608gjJdL8JshpaSSuwb34xc6j1A7BIvXOyIjeC
         xeivdCtx4UYNfYPUm42OgOSMuhT75zGch5Zxl9E2D13eoM5bUuDBb5Q359Drp5hc/nf9
         cneg==
X-Gm-Message-State: AKS2vOzG22wqvUTLWclFMvhJfrnH9d8nBqsQR9RgdXgXb7F/5YtQyU5I
        aOVILhxDm0gMB6wr
X-Received: by 10.223.161.138 with SMTP id u10mr4940871wru.191.1497945396947;
        Tue, 20 Jun 2017 00:56:36 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:36 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v4 37/49] odb-helper: add read_packetized_plain_object_to_fd()
Date:   Tue, 20 Jun 2017 09:55:11 +0200
Message-Id: <20170620075523.26961-38-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 odb-helper.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 1 deletion(-)

diff --git a/odb-helper.c b/odb-helper.c
index a27208463c..b2d86a7928 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -142,6 +142,121 @@ static int check_object_process_error(int err,
 	return err;
 }
 
+static struct odb_helper_object *odb_helper_lookup(struct odb_helper *o,
+						   const unsigned char *sha1);
+
+static ssize_t read_packetized_plain_object_to_fd(struct odb_helper *o,
+						  const unsigned char *sha1,
+						  int fd_in, int fd_out)
+{
+	ssize_t total_read = 0;
+	unsigned long total_got = 0;
+	int packet_len;
+
+	char hdr[32];
+	int hdrlen;
+
+	int ret = Z_STREAM_END;
+	unsigned char compressed[4096];
+	git_zstream stream;
+	git_SHA_CTX hash;
+	unsigned char real_sha1[20];
+
+	off_t size;
+	enum object_type type;
+	const char *s;
+	int pkt_size;
+	char *size_buf;
+
+	size_buf = packet_read_line(fd_in, &pkt_size);
+	if (!skip_prefix(size_buf, "size=", &s))
+		return error("odb helper '%s' did not send size of plain object", o->name);
+	size = strtoumax(s, NULL, 10);
+	if (!skip_prefix(packet_read_line(fd_in, NULL), "kind=", &s))
+		return error("odb helper '%s' did not send kind of plain object", o->name);
+	/* Check if the object is not available */
+	if (!strcmp(s, "none"))
+		return -1;
+	type = type_from_string_gently(s, strlen(s), 1);
+	if (type < 0)
+		return error("odb helper '%s' sent bad type '%s'", o->name, s);
+
+	/* Set it up */
+	git_deflate_init(&stream, zlib_compression_level);
+	stream.next_out = compressed;
+	stream.avail_out = sizeof(compressed);
+	git_SHA1_Init(&hash);
+
+	/* First header.. */
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), size) + 1;
+	stream.next_in = (unsigned char *)hdr;
+	stream.avail_in = hdrlen;
+	while (git_deflate(&stream, 0) == Z_OK)
+		; /* nothing */
+	git_SHA1_Update(&hash, hdr, hdrlen);
+
+	for (;;) {
+		/* packet_read() writes a '\0' extra byte at the end */
+		char buf[LARGE_PACKET_DATA_MAX + 1];
+
+		packet_len = packet_read(fd_in, NULL, NULL,
+			buf, LARGE_PACKET_DATA_MAX + 1,
+			PACKET_READ_GENTLE_ON_EOF);
+
+		if (packet_len <= 0)
+			break;
+
+		total_got += packet_len;
+
+		/* Then the data itself.. */
+		stream.next_in = (void *)buf;
+		stream.avail_in = packet_len;
+		do {
+			unsigned char *in0 = stream.next_in;
+			ret = git_deflate(&stream, Z_FINISH);
+			git_SHA1_Update(&hash, in0, stream.next_in - in0);
+			write_or_die(fd_out, compressed, stream.next_out - compressed);
+			stream.next_out = compressed;
+			stream.avail_out = sizeof(compressed);
+		} while (ret == Z_OK);
+
+		total_read += packet_len;
+	}
+
+	if (packet_len < 0) {
+		error("unable to read from odb helper '%s': %s",
+		      o->name, strerror(errno));
+		git_deflate_end(&stream);
+		return packet_len;
+	}
+
+	if (ret != Z_STREAM_END) {
+		warning("bad zlib data from odb helper '%s' for %s",
+			o->name, sha1_to_hex(sha1));
+		return -1;
+	}
+
+	ret = git_deflate_end_gently(&stream);
+	if (ret != Z_OK) {
+		warning("deflateEnd on object %s from odb helper '%s' failed (%d)",
+			sha1_to_hex(sha1), o->name, ret);
+		return -1;
+	}
+	git_SHA1_Final(real_sha1, &hash);
+	if (hashcmp(sha1, real_sha1)) {
+		warning("sha1 mismatch from odb helper '%s' for %s (got %s)",
+			o->name, sha1_to_hex(sha1), sha1_to_hex(real_sha1));
+		return -1;
+	}
+	if (total_got != size) {
+		warning("size mismatch from odb helper '%s' for %s (%lu != %lu)",
+			o->name, sha1_to_hex(sha1), total_got, size);
+		return -1;
+	}
+
+	return total_read;
+}
+
 static ssize_t read_packetized_git_object_to_fd(struct odb_helper *o,
 						const unsigned char *sha1,
 						int fd_in, int fd_out)
@@ -250,7 +365,9 @@ static int read_object_process(struct odb_helper *o, const unsigned char *sha1,
 	if (err)
 		goto done;
 
-	if (o->fetch_kind != ODB_FETCH_KIND_FAULT_IN)
+	if (o->fetch_kind == ODB_FETCH_KIND_PLAIN_OBJECT)
+		err = read_packetized_plain_object_to_fd(o, sha1, process->out, fd) < 0;
+	else if (o->fetch_kind == ODB_FETCH_KIND_GIT_OBJECT)
 		err = read_packetized_git_object_to_fd(o, sha1, process->out, fd) < 0;
 
 	subprocess_read_status(process->out, &status);
-- 
2.13.1.565.gbfcd7a9048


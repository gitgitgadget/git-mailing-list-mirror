Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A8D520401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbdFTH5b (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:57:31 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35078 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752151AbdFTH4h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id d64so21286877wmf.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=33aVgo8tcRz18W8dRTEwzWfDQRiRq0/O1f1VhjZTuB4=;
        b=MupE1DbfM2+GRw3NtIMsVNwdGrBfB/i5qstuy4jwQqjI5EofQzru8fElrUR3N8D979
         ZySZThCzOWafQydLlLMxj3p4pj92DPdOqwXv4I3gm1hBWCTG2bcu4PKYyUlUpZLb0//3
         ueYEFtEzXBUK33Y64ljXVPOTO8H8Qmj80JY51IVh8TIUNd6V+d4g8BVtZPzHqcHi6KwZ
         HUx3q/+/3gaeiGTHCn1+/v13gBh03D6zTF4wIIdxsIvLCay5JA+CGtCEmQ8ldoOw4zmT
         cAmOjNYGx1+PgTtz5LuiuVRYDU6phTJglgV6aZvpk/Albc4Parx7IyWsg7R4gsMRhmtE
         sS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=33aVgo8tcRz18W8dRTEwzWfDQRiRq0/O1f1VhjZTuB4=;
        b=h7dZukWJ8Qa62gnVCT5xJEg4OCvCnQIlUDk5r3wXmEeAx1QxGpAE3nJiZyCSew+rq7
         o2Z9dtOtpw67vq0I6nuUJRvegE3WvOU8XOKY2Tq0uU7UU9T63UbQ+WUFxzr1SMqByNuu
         c/NaBTiKRK5g2Pm6Yd40TnEKj6xsq27SBDd6wobhhOlMUqAF1G+6NI1msYK8HzfWqoc1
         hFvOALXiQbZr1FRo50Mt346CXBXQxbaLVIQYUF2LkD0wfy2xlNq/17cHbvf3nhlyPyAN
         TU7ENi/p6bhxJyntEvan/bBpoU5yMdSr+8bSxIYyn9Z5jKUV25RhnnWZ2GIvX07+uwiM
         b0zw==
X-Gm-Message-State: AKS2vOwCyHzJf5czLHou1xkOVz/XYsXhy9RrbN5LwC0Ie50ZNB5WvELr
        lK43RWzeSCXaiAK6
X-Received: by 10.28.105.218 with SMTP id z87mr1764339wmh.121.1497945395711;
        Tue, 20 Jun 2017 00:56:35 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:35 -0700 (PDT)
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
Subject: [RFC/PATCH v4 36/49] odb-helper: add read_packetized_git_object_to_fd()
Date:   Tue, 20 Jun 2017 09:55:10 +0200
Message-Id: <20170620075523.26961-37-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 odb-helper.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 78 insertions(+), 6 deletions(-)

diff --git a/odb-helper.c b/odb-helper.c
index 0017faa36e..a27208463c 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -142,6 +142,82 @@ static int check_object_process_error(int err,
 	return err;
 }
 
+static ssize_t read_packetized_git_object_to_fd(struct odb_helper *o,
+						const unsigned char *sha1,
+						int fd_in, int fd_out)
+{
+	ssize_t total_read = 0;
+	unsigned long total_got = 0;
+	int packet_len;
+	git_zstream stream;
+	int zret = Z_STREAM_END;
+	git_SHA_CTX hash;
+	unsigned char real_sha1[20];
+
+	memset(&stream, 0, sizeof(stream));
+	git_inflate_init(&stream);
+	git_SHA1_Init(&hash);
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
+		write_or_die(fd_out, buf, packet_len);
+
+		stream.next_in = (unsigned char *)buf;
+		stream.avail_in = packet_len;
+		do {
+			unsigned char inflated[4096];
+			unsigned long got;
+
+			stream.next_out = inflated;
+			stream.avail_out = sizeof(inflated);
+			zret = git_inflate(&stream, Z_SYNC_FLUSH);
+			got = sizeof(inflated) - stream.avail_out;
+
+			git_SHA1_Update(&hash, inflated, got);
+			/* skip header when counting size */
+			if (!total_got) {
+				const unsigned char *p = memchr(inflated, '\0', got);
+				if (p)
+					got -= p - inflated + 1;
+				else
+					got = 0;
+			}
+			total_got += got;
+		} while (stream.avail_in && zret == Z_OK);
+
+		total_read += packet_len;
+	}
+
+	git_inflate_end(&stream);
+
+	if (packet_len < 0)
+		return packet_len;
+
+	git_SHA1_Final(real_sha1, &hash);
+
+	if (zret != Z_STREAM_END) {
+		warning("bad zlib data from odb helper '%s' for %s",
+			o->name, sha1_to_hex(sha1));
+		return -1;
+	}
+	if (hashcmp(real_sha1, sha1)) {
+		warning("sha1 mismatch from odb helper '%s' for %s (got %s)",
+			o->name, sha1_to_hex(sha1), sha1_to_hex(real_sha1));
+		return -1;
+	}
+
+	return total_read;
+}
+
 static int read_object_process(struct odb_helper *o, const unsigned char *sha1, int fd)
 {
 	int err;
@@ -174,12 +250,8 @@ static int read_object_process(struct odb_helper *o, const unsigned char *sha1,
 	if (err)
 		goto done;
 
-	if (o->fetch_kind != ODB_FETCH_KIND_FAULT_IN) {
-		struct strbuf buf;
-		read_packetized_to_strbuf(process->out, &buf);
-		if (err)
-			goto done;
-	}
+	if (o->fetch_kind != ODB_FETCH_KIND_FAULT_IN)
+		err = read_packetized_git_object_to_fd(o, sha1, process->out, fd) < 0;
 
 	subprocess_read_status(process->out, &status);
 	err = strcmp(status.buf, "success");
-- 
2.13.1.565.gbfcd7a9048


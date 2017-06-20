Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B43C20401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752461AbdFTH5t (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:57:49 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34377 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbdFTH4S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:18 -0400
Received: by mail-wr0-f194.google.com with SMTP id y25so14132630wrd.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1rFDngIvHJxpzpxBqyfEuEDPDpdoqhGYGqR1U6KatVI=;
        b=WHa/UQ5I5iFRRx83Ix3D/YUG8052Te/R1tOMd/vfXsXEcUz0B9gVYP1Syr280qHTvq
         yJhCAPB03eWUK9xxjOyVYmb3I6B7K9Nwr6ziZc0O38xfIhuwklmfVdI4mROD7wNKpZYl
         ulFFsbrb1bnt+2xc088iR/3tTE+xDf6BAdjgbQtGaXC3PPBIWAboQz3TU/3ebeqRTEn1
         5BucP9ely9rxxPXedEK2ml6A1YD+ncCHvYhMr0otnK71uHdrH6jwM4G0Nz5HCFQRcuVV
         y6rOqyj1GnlmSHg2zUP5xzh1IzyJngcnwsJoUW+emBoC9Xcgt9p9xxzPbAsXq7gxbGzg
         uA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1rFDngIvHJxpzpxBqyfEuEDPDpdoqhGYGqR1U6KatVI=;
        b=S3uU8MqcuFFhTrtcoR5CIv9/GUsPdifR4H+Y/ckZUNqvIVlHYhFYo+RFG9c1TaNpgR
         7VeGQ3QV7w8VYGws6oVYZHj95qjvdL+FHCpzrisVT8JsEurDr4rqgJ0QBT411NEgs2Kf
         Rx6SF+rVc9wZx0SzANYL6HxTThoPXxD94JBPcR6Pmwqz8Sh3gUvL4O9P5obHFJ+7t9j+
         P8cgcjYpfJCneY6X9bBeOtrs9oDJ0mLTtZspfAUhKXT9MhJtMmhDyiA2qAoZfWsXGFDt
         qfS+Ht9WUV0qVBcY3d63DTq2AncXzsZjFyFjtsEEIXMNi1ik1Oyiap2RMVM/OC5LFsC+
         jCbA==
X-Gm-Message-State: AKS2vOzLI+Mpz/Bm9O9cv5POoxh5VNKrCATJEq0Ad8ehAGZ+j5JB6eLk
        FjER7vQAUQE8xA3G
X-Received: by 10.223.135.105 with SMTP id 38mr17902525wrz.23.1497945377022;
        Tue, 20 Jun 2017 00:56:17 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:16 -0700 (PDT)
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
Subject: [RFC/PATCH v4 21/49] odb-helper: add 'store_plain_objects' to 'struct odb_helper'
Date:   Tue, 20 Jun 2017 09:54:55 +0200
Message-Id: <20170620075523.26961-22-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds a configuration option odb.<helper>.plainObjects and the
corresponding boolean variable called 'store_plain_objects' in
'struct odb_helper' to make it possible for external object
databases to store object as plain objects instead of Git objects.

The existing odb_helper_fetch_object() is renamed
odb_helper_fetch_git_object() and a new odb_helper_fetch_plain_object()
is introduce to deal with external objects that are not in Git format.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c |   2 +
 odb-helper.c   | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 odb-helper.h   |   1 +
 3 files changed, 114 insertions(+), 2 deletions(-)

diff --git a/external-odb.c b/external-odb.c
index a88837feda..d11fc98719 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -36,6 +36,8 @@ static int external_odb_config(const char *var, const char *value, void *data)
 
 	if (!strcmp(key, "command"))
 		return git_config_string(&o->cmd, var, value);
+	if (!strcmp(key, "plainobjects"))
+		o->store_plain_objects = git_config_bool(var, value);
 
 	return 0;
 }
diff --git a/odb-helper.c b/odb-helper.c
index af7cc55ca2..b33ee81c97 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -159,8 +159,107 @@ int odb_helper_has_object(struct odb_helper *o, const unsigned char *sha1)
 	return !!odb_helper_lookup(o, sha1);
 }
 
-int odb_helper_fetch_object(struct odb_helper *o, const unsigned char *sha1,
-			    int fd)
+static int odb_helper_fetch_plain_object(struct odb_helper *o,
+					 const unsigned char *sha1,
+					 int fd)
+{
+	struct odb_helper_object *obj;
+	struct odb_helper_cmd cmd;
+	unsigned long total_got = 0;
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
+	obj = odb_helper_lookup(o, sha1);
+	if (!obj)
+		return -1;
+
+	if (odb_helper_start(o, &cmd, 0, "get %s", sha1_to_hex(sha1)) < 0)
+		return -1;
+
+	/* Set it up */
+	git_deflate_init(&stream, zlib_compression_level);
+	stream.next_out = compressed;
+	stream.avail_out = sizeof(compressed);
+	git_SHA1_Init(&hash);
+
+	/* First header.. */
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(obj->type), obj->size) + 1;
+	stream.next_in = (unsigned char *)hdr;
+	stream.avail_in = hdrlen;
+	while (git_deflate(&stream, 0) == Z_OK)
+		; /* nothing */
+	git_SHA1_Update(&hash, hdr, hdrlen);
+
+	for (;;) {
+		unsigned char buf[4096];
+		int r;
+
+		r = xread(cmd.child.out, buf, sizeof(buf));
+		if (r < 0) {
+			error("unable to read from odb helper '%s': %s",
+			      o->name, strerror(errno));
+			close(cmd.child.out);
+			odb_helper_finish(o, &cmd);
+			git_deflate_end(&stream);
+			return -1;
+		}
+		if (r == 0)
+			break;
+
+		total_got += r;
+
+		/* Then the data itself.. */
+		stream.next_in = (void *)buf;
+		stream.avail_in = r;
+		do {
+			unsigned char *in0 = stream.next_in;
+			ret = git_deflate(&stream, Z_FINISH);
+			git_SHA1_Update(&hash, in0, stream.next_in - in0);
+			write_or_die(fd, compressed, stream.next_out - compressed);
+			stream.next_out = compressed;
+			stream.avail_out = sizeof(compressed);
+		} while (ret == Z_OK);
+	}
+
+	close(cmd.child.out);
+	if (ret != Z_STREAM_END) {
+		warning("bad zlib data from odb helper '%s' for %s",
+			o->name, sha1_to_hex(sha1));
+		return -1;
+	}
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
+	if (odb_helper_finish(o, &cmd))
+		return -1;
+	if (total_got != obj->size) {
+		warning("size mismatch from odb helper '%s' for %s (%lu != %lu)",
+			o->name, sha1_to_hex(sha1), total_got, obj->size);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int odb_helper_fetch_git_object(struct odb_helper *o,
+				       const unsigned char *sha1,
+				       int fd)
 {
 	struct odb_helper_object *obj;
 	struct odb_helper_cmd cmd;
@@ -248,6 +347,16 @@ int odb_helper_fetch_object(struct odb_helper *o, const unsigned char *sha1,
 	return 0;
 }
 
+int odb_helper_fetch_object(struct odb_helper *o,
+			    const unsigned char *sha1,
+			    int fd)
+{
+	if (o->store_plain_objects)
+		return odb_helper_fetch_plain_object(o, sha1, fd);
+	else
+		return odb_helper_fetch_git_object(o, sha1, fd);
+}
+
 int odb_helper_for_each_object(struct odb_helper *o,
 			       each_external_object_fn fn,
 			       void *data)
diff --git a/odb-helper.h b/odb-helper.h
index 4e321195e8..3953b9bbaf 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -6,6 +6,7 @@
 struct odb_helper {
 	const char *name;
 	const char *cmd;
+	int store_plain_objects;
 
 	struct odb_helper_object {
 		unsigned char sha1[20];
-- 
2.13.1.565.gbfcd7a9048


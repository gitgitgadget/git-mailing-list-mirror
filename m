Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B952F1FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 21:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbcK3VYg (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 16:24:36 -0500
Received: from mail-wj0-f193.google.com ([209.85.210.193]:33329 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbcK3VY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 16:24:29 -0500
Received: by mail-wj0-f193.google.com with SMTP id kp2so24028623wjc.0
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 13:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w/9Lg3ikC1ZfAs/+K7qgViopRcbkqGeEm9Ate3/zvgY=;
        b=uWe6FrMHYuHo/kpmRc+jWaRi770MH+I2P0/u5SI1EOBOU6E4St3ViD8Ko+QsyCsANj
         0mLksZsyzLRLP8pAktSbtwiFp30DPfGmFqyoZUZXLz7agqTwGy9BItv22uUgE/sP4oa2
         WFe9/dr6RQ4cAtK6vHO3RBpNIgkhiUirakahiGTme80r474MmPHx+iko8Zh86EUjX2dt
         OUIwhR086rXaTQ0leun5pyJriGxpoikNX9GH1hVwxTpJrOYqX4hGYFQC66KvmokPnqAx
         GAm8NcglEaiAipbnhj9U5y0c/3RpTsVV9x62XL7FZG8/6fmUU8YjlXuHWLzCrcg99Jjz
         9pWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w/9Lg3ikC1ZfAs/+K7qgViopRcbkqGeEm9Ate3/zvgY=;
        b=STPIwp10Cgn+z9XEzUsrJYSpgdsBT+Zub4QPkNR1WIqu6pet21qJaIEAmLDUsyaCDM
         nT0m+mUEUSjEkesyJpPVdQkC8o+r0Rt6VOAANASLDOea+jd+7jX0IoAgpqhSfoAU+twa
         MDbd/qX4knxE6IUMSVKydODASiGvNGAk38DIsrEj4eBcofafbnknIWt9Se9xEf0LAj5m
         B0QuHBEBJ3chnEHV78HNwozM8l/Tgj9f7QY2oQ+pmOQzYdoxIy5G1u78d3qrnudhLpUO
         lj+Ut/14eyyDfrwXVNx65GlmrMdPlRUjxyhEVryVGi8eLViCCAynSx967CzU6oz8B7xL
         QgzQ==
X-Gm-Message-State: AKaTC01gl+nq/gL5WX1va04FvwhxUTTKjrNBVrqjGylHzcJwMipiJPcR/DBF+nGEHw4tcg==
X-Received: by 10.194.99.38 with SMTP id en6mr30413374wjb.184.1480539916360;
        Wed, 30 Nov 2016 13:05:16 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d64sm9802427wmh.3.2016.11.30.13.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 13:05:15 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v3 15/16] odb-helper: add 'store_plain_objects' to 'struct odb_helper'
Date:   Wed, 30 Nov 2016 22:04:19 +0100
Message-Id: <20161130210420.15982-16-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.rc2.37.geb49ca6
In-Reply-To: <20161130210420.15982-1-chriscool@tuxfamily.org>
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
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
index a980fbfbf2..af55377281 100644
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
index 7b7de7380f..6b9fb7927a 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -153,8 +153,107 @@ int odb_helper_has_object(struct odb_helper *o, const unsigned char *sha1)
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
@@ -242,6 +341,16 @@ int odb_helper_fetch_object(struct odb_helper *o, const unsigned char *sha1,
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
index af31cc27d5..80d332139d 100644
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
2.11.0.rc2.37.geb49ca6


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AB1D208B6
	for <e@80x24.org>; Thu,  3 Aug 2017 09:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbdHCJUM (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:20:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33302 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751910AbdHCJUF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:20:05 -0400
Received: by mail-wm0-f68.google.com with SMTP id q189so1446902wmd.0
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/XzHeL5Jy9BqfewxDZqvcPSfQzVg8p/ESoNMzCmkwxc=;
        b=Ht+2L0yJkwBGS1dQgR5YCEzkMn10kqTaBd6eialXwwW6JJm2QVNZwkF/fie3Z7UXOP
         FCnGWWfFXZ1MpVa0q7uWCdk7DBEm8SAZNH913HD4o1HIsTDakI1OdaVBpm2U/2qC8lzR
         JvA6i5gcy/frok+hnILsUWgG1wBhKbOBr+Y1SL1tkw4sqlPhJEbcV4GzQh7tRYyE0JFb
         WNvu9uFBEUeATQCDXW0FCnygqnAzOuzJ1tG/9Iu4Wf154KufOm24l0+5w15t8NdZVSe+
         wgSu96IvmE15IQSL/gUSEKldzyBKYf8e3EL0sDFS4Nl6Ore15Wrlf2qwY/WSg3tzlBYv
         qdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/XzHeL5Jy9BqfewxDZqvcPSfQzVg8p/ESoNMzCmkwxc=;
        b=JGbwk/DpwHLMr6bPLY7X+cGbsLkjEwGMEEsYP3plJnox8tfRGMs8sA/lh1ki6tr5Wk
         9iQ2Th2mIf87VxRC4+xQTj6u0X81mhnPK4yKhYd/n2MOAG+/61Pwh/NeG4R7VBk9Ht2l
         wQy5cX0TkHWlPY98j9wAPaxsjJXsiR10V5R3/jK5D9FGKFcb1v4xILKC3QAx76BO5Kw+
         f9uFxyCWY0UdGufWbxgfmHTNzLp8QYRUb+vRyuYJJLc9DZchPlIKI8G2b1FUMx27bQTK
         kRVQgrkB7MbJKAuO6YFtTK+JDVOZhHVy2iVxAuvTfB5fC8sxKa6JbDSyym8RubBXLRr7
         AG3g==
X-Gm-Message-State: AIVw113Z9Og90evF39fncq7tjp3iBsk809BC0g/Upfktzp3irxgEudp7
        t0yKOZBeqz2V4cuU
X-Received: by 10.28.101.5 with SMTP id z5mr767741wmb.136.1501752004302;
        Thu, 03 Aug 2017 02:20:04 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:20:03 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 22/40] odb-helper: add odb_helper_get_raw_object()
Date:   Thu,  3 Aug 2017 11:19:08 +0200
Message-Id: <20170803091926.1755-23-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The existing odb_helper_get_object() is renamed
odb_helper_get_git_object() and a new odb_helper_get_raw_object()
is introduced to deal with external objects that are not in Git format.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 odb-helper.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 111 insertions(+), 2 deletions(-)

diff --git a/odb-helper.c b/odb-helper.c
index 1be4461158..0603993057 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -217,8 +217,107 @@ int odb_helper_has_object(struct odb_helper *o, const unsigned char *sha1)
 	return !!odb_helper_lookup(o, sha1);
 }
 
-int odb_helper_get_object(struct odb_helper *o, const unsigned char *sha1,
-			    int fd)
+static int odb_helper_get_raw_object(struct odb_helper *o,
+				     const unsigned char *sha1,
+				     int fd)
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
+	if (odb_helper_start(o, &cmd, 0, "get_raw_obj %s", sha1_to_hex(sha1)) < 0)
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
+static int odb_helper_get_git_object(struct odb_helper *o,
+				     const unsigned char *sha1,
+				     int fd)
 {
 	struct odb_helper_object *obj;
 	struct odb_helper_cmd cmd;
@@ -306,6 +405,16 @@ int odb_helper_get_object(struct odb_helper *o, const unsigned char *sha1,
 	return 0;
 }
 
+int odb_helper_get_object(struct odb_helper *o,
+			  const unsigned char *sha1,
+			  int fd)
+{
+	if (o->supported_capabilities & ODB_HELPER_CAP_GET_RAW_OBJ)
+		return odb_helper_get_raw_object(o, sha1, fd);
+	else
+		return odb_helper_get_git_object(o, sha1, fd);
+}
+
 int odb_helper_put_object(struct odb_helper *o,
 			  const void *buf, size_t len,
 			  const char *type, unsigned char *sha1)
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty


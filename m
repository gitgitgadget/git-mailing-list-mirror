Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63778C64E8A
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 18:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B6D220A8B
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 18:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="t/HERWyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgKPSlW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 13:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgKPSlW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 13:41:22 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B05C0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 10:41:21 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q5so17764418qkc.12
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 10:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uL1RF0WmvNsclZSujVUSwWEjxuRPqgcw/X74iFXGWVs=;
        b=t/HERWyrbo+bnTBs30607dprgBHmJznuFR1QZaD0KiS+pGanMSorfvMltF2GvLVpIC
         GRDseNdmgyudLDJ2uRA+B0IWt194G0rAo++x3yNx6IIkQTyGEkzh+8Rw1F2BlDDXbugt
         xPd8ttqc19rM4fqAeXWNQVGzx47FfSi5z0wlavNBXG4H9PlqHljJ56JOTExJ8XK+uipB
         cr5whtQldE1tsY6+x0Wlw/rcvxKmRZWfLX9S7mOcen3TceQq56EzwStPBhqcxBuTc+st
         6QnBzkhmaJeQCabCGwrXXcReXda7W0U58DRA5U/cbxt7C6F77HMzRIjvOV6rgftHqwxG
         Ieqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uL1RF0WmvNsclZSujVUSwWEjxuRPqgcw/X74iFXGWVs=;
        b=PPDYOuA6RzlY6qxtffcAPhyydQndwUcJNQe+g7ptdrVz0nzLo1miI0EG2ImJKs+bKw
         cfOn4w2V6uVX80dWLw6EpWQgfRL+KhBYp8UKnwIDEuqsRX6oVBU1aWyQ2NH988U3MTJt
         ux7rfiDXDilzuZf0LHTOq5B0Rd+tBzhIzXQOQeuL99ndUjWvreSa78g2ZFy5sEZRuT6q
         4iPH5pqVlQ6Tf/OjkKmEk3spY/lEd9q6lKEWFO/yH5jLDlSbCvvfKcqsPpsxfcm+pxzw
         y51PtsqvIMBhYtl8nD4bic1npKY8BMATyaxlG/WoYcMaes58cvb//PJIQ+KATL1qKd21
         f/Lg==
X-Gm-Message-State: AOAM531vFF4tHampgBjns/obVvkNDyVc6d7hQkTiLFK1gWJQQ5PCDpks
        /KPS1h66mUrrozeq5y1D7tdj9iMqIZ9nymTO
X-Google-Smtp-Source: ABdhPJxNYvcnwp8H7BUDiDPd76oG/BT7BAC1aeD7fTN70/7EYMqo6yrpLPUIOjWBjHNYcPDFet7WxQ==
X-Received: by 2002:a37:5c6:: with SMTP id 189mr16430571qkf.390.1605552080022;
        Mon, 16 Nov 2020 10:41:20 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:990b:ddbb:a86d:1de2])
        by smtp.gmail.com with ESMTPSA id p27sm4404334qkp.70.2020.11.16.10.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 10:41:19 -0800 (PST)
Date:   Mon, 16 Nov 2020 13:41:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Subject: [PATCH 2/3] builtin/repack.c: keep track of what pack-objects wrote
Message-ID: <34e5a9deb5d02a3a349b2b662220dfc1e0d9075f.1605552016.git.me@ttaylorr.com>
References: <cover.1605552016.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605552016.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the subsequent commit, it will become useful to keep track of which
metadata files were written by pack-objects. We already do this to an
extent with the 'exts' array, which only is used in the context of
existing packs.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 03e2c2c44b..bb839180da 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -212,6 +212,27 @@ static struct {
 	{".promisor", 1},
 };
 
+static unsigned populate_pack_exts(char *name)
+{
+	struct stat statbuf;
+	struct strbuf path = STRBUF_INIT;
+	unsigned ret = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(exts); i++) {
+		strbuf_reset(&path);
+		strbuf_addf(&path, "%s-%s%s", packtmp, name, exts[i].name);
+
+		if (stat(path.buf, &statbuf))
+			continue;
+
+		ret |= (1 << i);
+	}
+
+	strbuf_release(&path);
+	return ret;
+}
+
 static void repack_promisor_objects(const struct pack_objects_args *args,
 				    struct string_list *names)
 {
@@ -240,11 +261,12 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 
 	out = xfdopen(cmd.out, "r");
 	while (strbuf_getline_lf(&line, out) != EOF) {
+		struct string_list_item *item;
 		char *promisor_name;
 		int fd;
 		if (line.len != the_hash_algo->hexsz)
 			die(_("repack: Expecting full hex object ID lines only from pack-objects."));
-		string_list_append(names, line.buf);
+		item = string_list_append(names, line.buf);
 
 		/*
 		 * pack-objects creates the .pack and .idx files, but not the
@@ -263,6 +285,9 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 		if (fd < 0)
 			die_errno(_("unable to create '%s'"), promisor_name);
 		close(fd);
+
+		item->util = (void *)(uintptr_t)populate_pack_exts(item->string);
+
 		free(promisor_name);
 	}
 	fclose(out);
@@ -430,6 +455,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (!names.nr && !po_args.quiet)
 		printf_ln(_("Nothing new to pack."));
 
+	for_each_string_list_item(item, &names) {
+		item->util = (void *)(uintptr_t)populate_pack_exts(item->string);
+	}
+
 	close_object_store(the_repository->objects);
 
 	/*
-- 
2.29.2.312.gabc4d358d8


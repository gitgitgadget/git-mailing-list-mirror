Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BC2C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 11:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357800AbiFVLu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 07:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357760AbiFVLu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 07:50:26 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A60A3CA74
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 04:50:25 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x4so9538018pfq.2
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 04:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8QLsd0i6p1PtYk0N+VTru4QYHHMITsmQaTJGoGgzRY0=;
        b=jkzUrnk3RmY2aNC8OQqrefPgLf1mJdhcmtpts9ZLSYCLmK+VAM1F7mouaPTXO4kOB1
         IY5+bJD2vIfSSR5Qhao3oag8JDtirLd4XNk0/8qY1cfXNt220mawMF1wv1JAAfpQLLA+
         Jzgq/qFQ8ilxWZGPOweUaBAFXwH3eywqiddwE/6XieUGHVck2HAc9EXh+92XWtSiC+UI
         jdW4gvvJvjySEc0JpCMLlkIkB1kTsQDUdfb0PLbbGoL0fyxXx00JJOLmQxfcfNi8mVeR
         FZc68IQ+yo3Ap7vK2qFaBmWfDRe2RonK31RX61AwH6N9be3j5QQVubTFg2NEOuF4jurd
         UQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8QLsd0i6p1PtYk0N+VTru4QYHHMITsmQaTJGoGgzRY0=;
        b=Ol+Kk4FWbKmWa66Z4qiWA5knST4xqbeBEAuaNIIx4VQmQv8N2oRQVb68w3vaxRZUSK
         sOo5A425Xww2UZwhhbgH0CudxB0wPId4ycOgB2L+KaiUAM8X0VWMbsSelOD0WvEYw37F
         uXrXL93sgQTFkqPnnxJyzfMl3uz3H+pF4cQA4uYBus1LASDzXyibeg856FLfGs8oWynf
         ItyY/53jEksXPJgoG0OpfXFrEkmqjxmCot40Wi4wJs2YeHl13CfpbaITgGD0hSH0wwq3
         rd53sLP/xZt1agryDn21dpIBuS6i96UP8zPrRTpJ0ngrz8c6LtolOfH+Wlj5zWnvWzD9
         FWsQ==
X-Gm-Message-State: AJIora+sDwnRJH/qUDyx/mxnbLCszQLFPD8Sa1SRv8cUOrCISOSCvX1z
        FyeeZdlp8tas93c3a4zDmYvMPpAqmNWs9LqM
X-Google-Smtp-Source: AGRyM1v+DpiJ8E8fQq+hSkV9ncKwStEivfoEI3FDj7QP07Az6SMC68eU5b2enpZ49UwhZhusE5HWJQ==
X-Received: by 2002:a05:6a00:4211:b0:51c:45e:532b with SMTP id cd17-20020a056a00421100b0051c045e532bmr35068348pfb.10.1655898624732;
        Wed, 22 Jun 2022 04:50:24 -0700 (PDT)
Received: from xxwECS.tbsite.net ([140.205.70.43])
        by smtp.gmail.com with ESMTPSA id p16-20020a170903249000b00163f1831ddfsm12583673plw.40.2022.06.22.04.50.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jun 2022 04:50:24 -0700 (PDT)
From:   haoyurenzhuxia@gmail.com
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, me@ttaylorr.com, derrickstolee@github.com,
        dyroneteng@gmail.com, Xia XiaoWen <haoyurenzhuxia@gmail.com>
Subject: [RFC PATCH] midx.c: clean up .rev file
Date:   Wed, 22 Jun 2022 19:50:14 +0800
Message-Id: <20220622115014.53754-1-haoyurenzhuxia@gmail.com>
X-Mailer: git-send-email 2.34.1.52.g9efd6505a3.dirty.agit.6.5.6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Xia XiaoWen <haoyurenzhuxia@gmail.com>

The command: `git multi-pack-index write --bitmap` will create 3
files in `objects/pack/`:
    * multi-pack-index
    * multi-pack-index-*.bitmap
    * multi-pack-index-*.rev

But if the command is terminated by the user (such as Ctl-C) or
the system, the midx reverse index file (`multi-pack-index-*.rev`)
is not removed and still exists in `objects/pack/`:

    $ GIT_TEST_MIDX_WRITE_REV=1 git multi-pack-index write --bitmap
    Selecting bitmap commits: 133020, done.
    Building bitmaps:   0% (3/331)
    ^C^C

    $ tree objects/pack/
    objects/pack/
    ├── multi-pack-index-3b048d1b965842cd866e10b6ec1a3035dbede0a5.rev
    ├── pack-b7d425f1b01727d5f364f5d9fbab2d1900fcd5c0.idx
    └── pack-b7d425f1b01727d5f364f5d9fbab2d1900fcd5c0.pack

This patch resolves this by adding a cleanup handler to the sigchain.

Signed-off-by: Xia XiaoWen <haoyurenzhuxia@gmail.com>
---
 midx.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/midx.c b/midx.c
index 5f0dd386b0..6586051a62 100644
--- a/midx.c
+++ b/midx.c
@@ -17,6 +17,7 @@
 #include "refs.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "sigchain.h"
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION 1
@@ -41,6 +42,8 @@
 
 #define PACK_EXPIRED UINT_MAX
 
+static struct strbuf rev_filename = STRBUF_INIT;
+
 const unsigned char *get_midx_checksum(struct multi_pack_index *m)
 {
 	return m->data + m->data_len - the_hash_algo->rawsz;
@@ -884,21 +887,29 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 	return pack_order;
 }
 
+static void remove_rev_file_on_signal(int signo)
+{
+	if (unlink(rev_filename.buf))
+		die_errno(_("failed to remove %s"), rev_filename.buf);
+
+	sigchain_pop(signo);
+	raise(signo);
+}
+
 static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
 				     struct write_midx_context *ctx)
 {
-	struct strbuf buf = STRBUF_INIT;
 	const char *tmp_file;
 
-	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex(midx_hash));
+	strbuf_addf(&rev_filename, "%s-%s.rev", midx_name, hash_to_hex(midx_hash));
 
 	tmp_file = write_rev_file_order(NULL, ctx->pack_order, ctx->entries_nr,
 					midx_hash, WRITE_REV);
 
-	if (finalize_object_file(tmp_file, buf.buf))
+	if (finalize_object_file(tmp_file, rev_filename.buf))
 		die(_("cannot store reverse index file"));
 
-	strbuf_release(&buf);
+	sigchain_push_common(remove_rev_file_on_signal);
 }
 
 static void clear_midx_files_ext(const char *object_dir, const char *ext,
-- 
2.34.1.52.g9efd6505a3.dirty.agit.6.5.6


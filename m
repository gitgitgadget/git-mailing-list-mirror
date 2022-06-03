Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF408C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347623AbiFCSjl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345061AbiFCSjE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:39:04 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF5DB868
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:38:10 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f23-20020a7bcc17000000b003972dda143eso6785343wmh.3
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 11:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qbKbe3zMB/lMcyq/ZzIEa/zohUIpI1QQEk+Txu7we4A=;
        b=STPmg7FdRTRDHv80+Hthz00i8AzWPRw976iVomzIQ0NbzFtyzyGhMCVtBm9heqMRYJ
         CYThFvamie9385jXNOf25VK9YU3kBNNkdJvkfR05jDfrKZOorFI8bPBXmeh8CWbpiA1r
         ajBIeGjncNafNMqVEhDDJGQLQFbwkVwU/sQvipyr5xfR7J1n119heMte3PkHvlTEJkvY
         hBCi9TKX3f3RgUQIMvnMu+AhXp9JSEaqy94OCOtzq+aN0rxJXhdTw5PWQ19bnzYKlt70
         DoPY/Pn0IJdejdFvmY9zQYkBLAiz0kME70XTEBNESYjE+N/KvdCc2D0oHR0YGyhyfVoi
         rq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qbKbe3zMB/lMcyq/ZzIEa/zohUIpI1QQEk+Txu7we4A=;
        b=gUXnREhSqOaZj8UXd8rlKhawHkA2o1UF9H0puE74I8XiPLqpdiNnWiaeEiBWOGdMmS
         EjYPKkM9dQS1Mb5WVlbEGZHHTm4uJEJoYvCCH7dU4t2SJAmtLPItH0gr7DCz3sdfSXC7
         qSD4RbIlvD5bOizHqt8Ek9NuRj0+qzvRDZbb3T5XWbvJh+uGxbVG11dxn/2w1YDK6hxI
         hNSWmrpQ2Aos8T+Aqq0x3OsPOPDb4p8LMmILVdVyNSeyKTSsanOAN3UoiXeZ03a+SvE3
         r919kuGAIeoptRCihZ9pBYLg7TKE6IrcbrHJyxJ+4UpUucMw2YMynN5ly05Z5HOLPvPZ
         M0PA==
X-Gm-Message-State: AOAM530SIbuaWJZJ68Kg+tnZOTNjWOFaWGXXdcoUUQVDf+NfK4DCmFXe
        FnNTW9YVQC+ht5i/c4KT3DRX9lgq2LBuUQ==
X-Google-Smtp-Source: ABdhPJxBtiS/Gns7hTT9BF8MPCy/3i+C+zpvJhY6Yiic3CUGyMLyDWJVeQ5i6mFx3oQa1vKPw0ZVxQ==
X-Received: by 2002:a05:600c:4e13:b0:397:6214:ee35 with SMTP id b19-20020a05600c4e1300b003976214ee35mr38669015wmq.153.1654281490032;
        Fri, 03 Jun 2022 11:38:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020adff6c5000000b0020c5253d926sm8232636wrp.114.2022.06.03.11.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 11:38:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 10/15] reftable: don't have reader_get_block() confuse -fanalyzer
Date:   Fri,  3 Jun 2022 20:37:47 +0200
Message-Id: <RFC-patch-10.15-b50558d3b24-20220603T183608Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1124.g577fa9c2ebd
In-Reply-To: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the control flow in reftable code add in 46bc0e731a7 (reftable:
read reftable files, 2021-10-07) to work around a false positive
spotted by GCC's -fanalyzer option[1]. The code was added in
46bc0e731a7 (reftable: read reftable files, 2021-10-07).

Usually we'd just leave such false positives alone, but having looked
at it the control flow was also odd and confusing to humans, so let's
change it.

What -fanalyzer complained about was:

	|......
	|  294 |         if (next_off >= r_size)
	|      |            ~
	|      |            |
	|      |            (24) following ‘false’ branch (when ‘next_off < r_size’)...
	|......
	|  294 |         if (next_off >= r_size)
	|      |            ~
	|      |            |
	|      |            (24) following ‘false’ branch (when ‘next_off < r_size’)...
	|......
	|  297 |         err = reader_get_block(r, &block, next_off, guess_block_size, r->size);
	|      |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	|      |               |
	|      |               (25) ...to here
	|      |               (26) calling ‘reader_get_block’ from ‘reader_init_block_reader’
	|
	+--> ‘reader_get_block’: events 27-29
	       |
	       |   59 | static int reader_get_block(struct reftable_reader *r,
	       |      |            ^~~~~~~~~~~~~~~~
	       |      |            |
	       |      |            (27) entry to ‘reader_get_block’
	       |......
	       |   63 |         if (off >= r_size)
	       |      |            ~
	       |      |            |
	       |      |            (28) following ‘true’ branch (when ‘off >= r_size’)...
	       |   64 |                 return 0;
	       |      |                        ~
	       |      |                        |
	       |      |                        (29) ...to here
	       [...]
	       |  275 |         *typ = data[0];
	       |      |                ~~~~~~~
	       |      |                    |
	       |      |                    (37) ...to here
	       |      |                    (38) dereference of NULL ‘data’

I.e. it thought that we could take the "return 0" in
reader_get_block() due to "(off >= r->size)", which followed the
identical "(next_off >= r_size)" check in reader_init_block_reader()
just before reader_get_block() was called.

But whatever GCC's -fanalyzer thinks it's confusing that we're
checking this twice, and making it look as though these parameters
might change within the reader_init_block_reader() function, but they
won't. So let's just do the check once early, and use "const" types to
assert that they'll be constant throughout.

1. https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105285

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 reftable/reader.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index 54b4025105c..e1649929b30 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -58,9 +58,9 @@ reader_offsets_for(struct reftable_reader *r, uint8_t typ)
 
 static int reader_get_block(struct reftable_reader *r,
 			    struct reftable_block *dest, uint64_t off,
-			    uint32_t sz)
+			    uint32_t sz, uint64_t r_size)
 {
-	if (off >= r->size)
+	if (off >= r_size)
 		return 0;
 
 	if (off + sz > r->size) {
@@ -281,6 +281,7 @@ static int32_t extract_block_size(uint8_t *data, uint8_t *typ, uint64_t off,
 int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
 			     uint64_t next_off, uint8_t want_typ)
 {
+	const uint64_t r_size = r->size;
 	int32_t guess_block_size = r->block_size ? r->block_size :
 							 DEFAULT_BLOCK_SIZE;
 	struct reftable_block block = { NULL };
@@ -289,10 +290,10 @@ int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
 	uint32_t header_off = next_off ? 0 : header_size(r->version);
 	int32_t block_size = 0;
 
-	if (next_off >= r->size)
+	if (next_off >= r_size)
 		return 1;
 
-	err = reader_get_block(r, &block, next_off, guess_block_size);
+	err = reader_get_block(r, &block, next_off, guess_block_size, r_size);
 	if (err < 0)
 		goto done;
 
@@ -309,7 +310,7 @@ int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
 
 	if (block_size > guess_block_size) {
 		reftable_block_done(&block);
-		err = reader_get_block(r, &block, next_off, block_size);
+		err = reader_get_block(r, &block, next_off, block_size, r_size);
 		if (err < 0) {
 			goto done;
 		}
-- 
2.36.1.1124.g577fa9c2ebd


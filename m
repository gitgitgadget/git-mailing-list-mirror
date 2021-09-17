Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C72C433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 21:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3655611C3
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 21:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344137AbhIQVWj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 17:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241675AbhIQVWi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 17:22:38 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D385C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 14:21:16 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z6so7163536iof.5
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j/AWH0Z0pKHAMhkAG1FRjnnJyX3QbRZqaE5juAMfac0=;
        b=wXphksseyGgoyZ/m71LYB4uKcTNxfsQ0WemzWoTxAS68f3RXw8cza/pW5j6HporRU/
         EPwYJuDG22J+eM7MCWrDvbBiWYNxD7+r2oS5JQo6DsJSi9fxNLTD9+Qx4Fuk1j63/blI
         0y2Ab9yqv6vt53W03SzHpknwpQg0iFI9SRz7XnHgMOlr7c8VSrWxLPkN6PC9wB7INige
         V3x58x9nxssl7TIzPwR4frdyjafUi7W+yleWCcoz6bFZQn1CIWKgTFeCXCw8Naai37Gh
         gcC2Voi85YgLwf6Qca5/zwkNV9wu1E5jvfuwfJ5Zd5e5bZMTbRWbknSFmY4X6nGd4YqS
         uvag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j/AWH0Z0pKHAMhkAG1FRjnnJyX3QbRZqaE5juAMfac0=;
        b=hQHtz2zZpvZT/SmY/dgAgwh0jj/oQlLRNUYC+eqS9G2KFqGXwAtL27EWHstgT0FBHZ
         RJoWhADh/aWWqnCl+9vTPb3EpVS9sCmQ1Bg8zlAgsZALMJvYcSty6bH9dpiju6Q4QNzw
         lJuVnlA9ggtSykEIKDbP9i3ylBVaBeryW41SgL3A9sI9HBZblICLhwYp7UeQgkAMVdD5
         FLhdw6F/qu2Wbp0cFZO89SaERBV7Av4LDnIk+lut9z+J01DmJ/0oFRRrWSnHxUEHDZw3
         6bCHDoMK0pHk3WS6nHbfkyDXqHnzvy1lGjkVEnSOxCHl7uAkJFJgW82pT3EgG10D4+JJ
         wJsQ==
X-Gm-Message-State: AOAM530Ubq55Imy+owk5j3XOYwWwqpQEW412KR+Qfs7p5Zx73cx96Vmf
        +jnQcrKlY0o1QS/hZN8wuTnXhZh6fOk5mZ+F
X-Google-Smtp-Source: ABdhPJz+1UpJM/CkhkLVH4J6UKLZSo9UjfmanR/YJxfHmSQ/Q0H2rxFwHd0bKp9T0VcVtjk8JzOGRw==
X-Received: by 2002:a02:77c4:: with SMTP id g187mr8868584jac.56.1631913675702;
        Fri, 17 Sep 2021 14:21:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s13sm4110372ilh.21.2021.09.17.14.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 14:21:15 -0700 (PDT)
Date:   Fri, 17 Sep 2021 17:21:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, gitster@pobox.com
Subject: [PATCH v3 1/7] t/helper/test-bitmap.c: add 'dump-hashes' mode
Message-ID: <4f2b8d95303d54a50b13117d771da690c4700d3e.1631913631.git.me@ttaylorr.com>
References: <cover.1631049462.git.me@ttaylorr.com>
 <cover.1631913631.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631913631.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pack-bitmap writer code is about to learn how to propagate values
from an existing hash-cache. To prepare, teach the test-bitmap helper to
dump the values from a bitmap's hash-cache extension in order to test
those changes.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c          | 27 +++++++++++++++++++++++++++
 pack-bitmap.h          |  1 +
 t/helper/test-bitmap.c | 10 +++++++++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 8504110a4d..04de387318 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1742,6 +1742,33 @@ int test_bitmap_commits(struct repository *r)
 	return 0;
 }
 
+int test_bitmap_hashes(struct repository *r)
+{
+	struct bitmap_index *bitmap_git = prepare_bitmap_git(r);
+	struct object_id oid;
+	uint32_t i, index_pos;
+
+	if (!bitmap_git->hashes)
+		goto cleanup;
+
+	for (i = 0; i < bitmap_num_objects(bitmap_git); i++) {
+		if (bitmap_is_midx(bitmap_git))
+			index_pos = pack_pos_to_midx(bitmap_git->midx, i);
+		else
+			index_pos = pack_pos_to_index(bitmap_git->pack, i);
+
+		nth_bitmap_object_oid(bitmap_git, &oid, index_pos);
+
+		printf("%s %"PRIu32"\n",
+		       oid_to_hex(&oid), get_be32(bitmap_git->hashes + index_pos));
+	}
+
+cleanup:
+	free_bitmap_index(bitmap_git);
+
+	return 0;
+}
+
 int rebuild_bitmap(const uint32_t *reposition,
 		   struct ewah_bitmap *source,
 		   struct bitmap *dest)
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 469090bad2..ed46d27077 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -52,6 +52,7 @@ void traverse_bitmap_commit_list(struct bitmap_index *,
 				 show_reachable_fn show_reachable);
 void test_bitmap_walk(struct rev_info *revs);
 int test_bitmap_commits(struct repository *r);
+int test_bitmap_hashes(struct repository *r);
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 					 struct list_objects_filter_options *filter,
 					 int filter_provided_objects);
diff --git a/t/helper/test-bitmap.c b/t/helper/test-bitmap.c
index 134a1e9d76..ff35f5999b 100644
--- a/t/helper/test-bitmap.c
+++ b/t/helper/test-bitmap.c
@@ -7,6 +7,11 @@ static int bitmap_list_commits(void)
 	return test_bitmap_commits(the_repository);
 }
 
+static int bitmap_dump_hashes(void)
+{
+	return test_bitmap_hashes(the_repository);
+}
+
 int cmd__bitmap(int argc, const char **argv)
 {
 	setup_git_directory();
@@ -16,9 +21,12 @@ int cmd__bitmap(int argc, const char **argv)
 
 	if (!strcmp(argv[1], "list-commits"))
 		return bitmap_list_commits();
+	if (!strcmp(argv[1], "dump-hashes"))
+		return bitmap_dump_hashes();
 
 usage:
-	usage("\ttest-tool bitmap list-commits");
+	usage("\ttest-tool bitmap list-commits\n"
+	      "\ttest-tool bitmap dump-hashes");
 
 	return -1;
 }
-- 
2.33.0.96.g73915697e6


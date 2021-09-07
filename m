Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1333FC433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A7C610C9
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347047AbhIGVTF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243883AbhIGVTF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:19:05 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844D0C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 14:17:58 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id i3so108372wmq.3
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 14:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8taixSM9wNIt2LTTTxrIiXohcSJTi8CgIZms0E4x+Pc=;
        b=e0QA8pgw7ESP4XScbrdY2/NK7apS7bmVseuvVZkZdy4TUkRx6tvXhE2Fu5ksZ3P+Bz
         k2EUCmInPxP5IwZ9PQ4zPGM4RkNlMt5XBDi9C5tyltTlpJn5CFPuStr2jPVeyvUIofdd
         gc/y5VZu0GI9SCgXYZFkjpKkz3Ydo7vZbkCvaFz5DiEPaM3IMEWuwCqrCH2Evb+8DZ9W
         0K6Zsg8nhnxg4ow4h8VQJ00svdjA/w/LyRnk49fcH0G+R2kaRpXOOVPWJk9XZQpM4kGl
         todR+rSnCIZy3o38vAyzdhyMoBpFphNmoZ62k95fTCdGLU4zOERRlsEJ8noQtlE3IOjr
         l8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8taixSM9wNIt2LTTTxrIiXohcSJTi8CgIZms0E4x+Pc=;
        b=WS6/0LCPtPycaM53S7jAVvoB4vt9EujD7Y2P6GGEuVWxfffkwCHl13QHhfwzCGXMyv
         B8CJNkoCBAOA0j+mv+XbAT4VXNdz08FNd8tXNvSjUyWAki4vPoeWJwm86UR9D1uFusx0
         OkVsTlksmRLZ+kH6ZqEH83zvb0ID9E8mj7Wuf6eyxcwjmhTCDOVI0wa7rk9pbPtruCub
         mdzfuEcCC86SzLa4kOkk9rvaP61a4kGXwITothoTnZt4CYTKdYjOEOK+RwFCt7nFNv9+
         zQGoJ2tQJOKOnlobrYLCrK4wsMXNhlv4Wpht+CtQH/lrWr3x0LRx86urF/el58+hROQ5
         AZpQ==
X-Gm-Message-State: AOAM530MEgyu2DlRSVuwkJLpTJHfZ2radlR55RgJ+z1BqsikR1sROBC9
        YqqgOzn2RMw3S/LSHuxedPwN214UGB3NWWZ0
X-Google-Smtp-Source: ABdhPJzNXLKYmOhWAlCDWC818u4Ouj3BDO2aro4cGLsnuRO6C89YpWB0VVuVx7DQh0NHn7/LtC+CRg==
X-Received: by 2002:a1c:23d2:: with SMTP id j201mr193760wmj.163.1631049476881;
        Tue, 07 Sep 2021 14:17:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a5sm119625wmm.44.2021.09.07.14.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:17:56 -0700 (PDT)
Date:   Tue, 7 Sep 2021 17:17:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 1/4] t/helper/test-bitmap.c: add 'dump-hashes' mode
Message-ID: <918f9b275a1a03b6383e32f28cf1db26a6d67633.1631049462.git.me@ttaylorr.com>
References: <cover.1631049462.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631049462.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pack-bitmap writer code is about to learn how to propagate values
from an existing hash-cache. To prepare, teach the test-bitmap helper to
dump the values from a bitmap's hash-cache extension in order to test
those changes.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c          | 22 ++++++++++++++++++++++
 pack-bitmap.h          |  1 +
 t/helper/test-bitmap.c | 10 +++++++++-
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index fa69ed7a6d..e44af36933 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1744,6 +1744,28 @@ int test_bitmap_commits(struct repository *r)
 	return 0;
 }
 
+int test_bitmap_hashes(struct repository *r)
+{
+	struct bitmap_index *bitmap_git = prepare_bitmap_git(r);
+	struct object_id oid;
+	uint32_t i;
+
+	if (!bitmap_git->hashes)
+		goto cleanup;
+
+	for (i = 0; i < bitmap_num_objects(bitmap_git); i++) {
+		nth_bitmap_object_oid(bitmap_git, &oid, i);
+
+		printf("%s %"PRIu32"\n",
+		       oid_to_hex(&oid), get_be32(bitmap_git->hashes + i));
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
index 81664f933f..b29514418c 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -53,6 +53,7 @@ void traverse_bitmap_commit_list(struct bitmap_index *,
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


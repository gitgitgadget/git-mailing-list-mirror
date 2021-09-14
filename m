Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE25C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 22:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B8F661175
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 22:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbhINWHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 18:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbhINWHV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 18:07:21 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A2AC061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 15:06:03 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id b15so684394ils.10
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 15:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j/AWH0Z0pKHAMhkAG1FRjnnJyX3QbRZqaE5juAMfac0=;
        b=ZjkWq6wfwNaKeYmxh00z7f1iTqBeQWUJTsBFEkZrqkN6L7e+Dnh9UEFNM5pp+evNCe
         rkZj3DZvf8Ac8g2ArpJUgUnDSMsGIsYG36jZjWoSZ+k5Pt53dU/vfQk/iefhkDXAWjKG
         EelOiIgPdoHj5SwYtAJGnh1DS6wxDKJm/4fE2BzJmT0KatfdTUEcYo+fsbKfnh0sMxXE
         f8so9X9isruZ0ZQa3U2UfDTPKoq6OEFOFuEg1RkmWX1MPff49oQtW20PBEB8+fr/qSlm
         4zfpKxvETwC4WMjfpK8AWqcZPsUHZkXH/WXj3v6cKrLHbeP8F/xfCWHH8sNhn5FKAXdg
         t8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j/AWH0Z0pKHAMhkAG1FRjnnJyX3QbRZqaE5juAMfac0=;
        b=Lx9eXPyaj1vESenPyGw9xTkQD2uDJcx+RsJTT6kQwWISRIk8z/XIAN4fnx7FdeyEsq
         enL13V55czG47IYb70uqbcHrEuUqXIWVjnuxmcF8WjavnqZsTuCxoGSOxNH9TATWeIL6
         LKI3TfVtAXrZsX1WV0UhARERrtSa+LLdqBnsSWPShYIefwUFlJepw//fO/cDqcvOsRep
         bZHSXjkb8aSa95d657pJQthWMiHBnADE2Ma+Kabdod0UHJgbMmHGYYIrD0jQc3RALl0R
         qzc2uDa/itxqP/OsSK390UWOl1+RqDdDms3qLQScbDjcCQWvZxU9eukp6XylKsehtBfd
         T19w==
X-Gm-Message-State: AOAM532L9liQ1JlprOILvXHBHHEv/tj2QT6nYhrAgCQBcPnaw4CBWdTz
        94M99IIkwO615+Q1/kA5j3MvJ/7v06EBlYrE
X-Google-Smtp-Source: ABdhPJzTaZ6ndkBw/oSk7B49e3AeQlKdaYnSbTJgR55OReihy1BzQzFnCGO/aU8K3zFK5buIaMJqzg==
X-Received: by 2002:a05:6e02:1144:: with SMTP id o4mr12170304ill.264.1631657162952;
        Tue, 14 Sep 2021 15:06:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n4sm7780789ilo.76.2021.09.14.15.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 15:06:02 -0700 (PDT)
Date:   Tue, 14 Sep 2021 18:06:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, avarab@gmail.com
Subject: [PATCH v2 1/7] t/helper/test-bitmap.c: add 'dump-hashes' mode
Message-ID: <4f2b8d95303d54a50b13117d771da690c4700d3e.1631657157.git.me@ttaylorr.com>
References: <cover.1631049462.git.me@ttaylorr.com>
 <cover.1631657157.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631657157.git.me@ttaylorr.com>
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


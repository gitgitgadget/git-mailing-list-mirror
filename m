Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126D6C433B4
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E289F6105A
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhDABcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbhDABcK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:32:10 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344C1C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:32:10 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id i19so426021qtv.7
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Iku2tmcE6irvwdu5op7oPdmD1GvhZ/RKHr3wosTnK1A=;
        b=HMz+nPF6A/4hTsa6KdObf5nmU5nf0muxNl2Wn0ceBcA3pvkfGBhKLxzuahmyNf7MMg
         yxQBx2KKTbn8Xq4H/ItEUZq1hOExqlsHXf5ybVAwbP66YY8GsoojYvpP1hmEcE+goTFT
         rfiIPjiBqc0HF9IcjuNZBLQjVGdMIn/rXZevmVcLXp6e9sFpd+ZJwMFAjb0nKi4rdn2T
         +G/NuMxprtYVNIuTQ8kvy62u+zLL6DxB2ssaxZw0/Gv50RHWky2cbRuUFZRkhFVAQ/Ct
         drf/aLzHCMc14w0JDexzD3yu9AtLGj9EH+kkIy/t92TtYkGRX0BK4xcswc2FdHzIO5Li
         tdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Iku2tmcE6irvwdu5op7oPdmD1GvhZ/RKHr3wosTnK1A=;
        b=VTubiU18KLY/eOsDRHOx+TgCGO5JXgP5C7acDfVJwFEU7lQ6sNu0JnUZUZ2bswzpx6
         kcNmFf/HVYjLVAk5xrIdgU47FZ6imIUyKVcI5qmEFyapLQXd4LN9TW1l85FofuAL9bmS
         KqHMWF71oH+t3vtrOcGv1x70KYWsHx6ZiXzUrgRNhqJP8aoB/CXd1lllfMkVkYF2oSn3
         e/SFJV3cE1SMZVijtqTk6FOLF6DZtXYKP/LrrmrbT77xEmxEUc7sN/GPA9uZz9q8+4IB
         VrApfP2EKBZYkOkqManI4z0FhDHoq8DqxGNG67K0G+A+l+wJ06M6tughSZnlJ9D8s+IS
         p0jQ==
X-Gm-Message-State: AOAM530gluwfe7+j5zYIUz5Ew2YKtphig/AoDVlmnuWOiNCbMdP8Y2mX
        UvhRey0Zb+FwTFy6Rp2bh0E7Um76Lnp71A==
X-Google-Smtp-Source: ABdhPJwVg+OI94LpripSxjXtXDbrjWQKH3phVFXXW6JFl1V5rr7CEffGx7dRvF0h0u9wVF5oBl5Yeg==
X-Received: by 2002:ac8:47cf:: with SMTP id d15mr4976560qtr.357.1617240729099;
        Wed, 31 Mar 2021 18:32:09 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:90ff:e0f0:a41:6c5a])
        by smtp.gmail.com with ESMTPSA id l17sm2429139qtk.60.2021.03.31.18.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:32:08 -0700 (PDT)
Date:   Wed, 31 Mar 2021 21:32:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Subject: [PATCH 1/3] pack-bitmap: add 'test_bitmap_commits()' helper
Message-ID: <053ba4b8319cae9fc804b5f9ce452be1bb16e1da.1617240723.git.me@ttaylorr.com>
References: <cover.1617240723.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617240723.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The next patch will add a 'bitmap' test-tool which prints the list of
commits that have bitmaps computed.

The test helper could implement this itself, but it would need access to
the 'bitmaps' field of the 'pack_bitmap' struct. To avoid exposing this
private detail, implement the entirety of the helper behind a
test_bitmap_commits() function in pack-bitmap.c.

There is some precedence for this with test_bitmap_walk() which is used
to implement the '--test-bitmap' flag in 'git rev-list' (and is also
implemented in pack-bitmap.c).

A caller will be added in the next patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 18 ++++++++++++++++++
 pack-bitmap.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 1ebe0c8162..7554510b14 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1350,6 +1350,24 @@ void test_bitmap_walk(struct rev_info *revs)
 	free_bitmap_index(bitmap_git);
 }
 
+int test_bitmap_commits(struct repository *r)
+{
+	struct bitmap_index *bitmap_git = prepare_bitmap_git(r);
+	struct object_id oid;
+	MAYBE_UNUSED void *value;
+
+	if (!bitmap_git)
+		die("failed to load bitmap indexes");
+
+	kh_foreach(bitmap_git->bitmaps, oid, value, {
+		printf("%s\n", oid_to_hex(&oid));
+	});
+
+	free_bitmap_index(bitmap_git);
+
+	return 0;
+}
+
 int rebuild_bitmap(const uint32_t *reposition,
 		   struct ewah_bitmap *source,
 		   struct bitmap *dest)
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 36d99930d8..c3cdd80756 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -49,6 +49,7 @@ void traverse_bitmap_commit_list(struct bitmap_index *,
 				 struct rev_info *revs,
 				 show_reachable_fn show_reachable);
 void test_bitmap_walk(struct rev_info *revs);
+int test_bitmap_commits(struct repository *r);
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 					 struct list_objects_filter_options *filter);
 int reuse_partial_packfile_from_bitmap(struct bitmap_index *,
-- 
2.31.1.163.ga65ce7f831


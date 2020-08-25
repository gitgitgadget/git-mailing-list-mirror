Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31677C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 02:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDFEE204EC
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 02:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="H7BVns7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgHYCBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgHYCBI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 22:01:08 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D5EC061574
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 19:01:06 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id x69so9665327qkb.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 19:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=CYqSdcBbvynESHYb9tf0yZPF6x+Cdo9UApyGt0trWAs=;
        b=H7BVns7wI2S7W77986nrmQtMVlyiKvuLNW3YQV/NkCy+NyZ69ZHoMtA5ZtokSgZSW9
         Bmef7NwDqgQP3ao6NKNu2mC7/IETR+3gxRP8lP6pUn2nN+lAKtEPOCFLysIMbr6DPSvP
         xnFIU5TeVRwf5hv36SqEzLB1+GkFpInNVNrtWJH6WsG7408cjf9Y1fNJGXuDzsRF6vQy
         8tt1lo1gBx9C6k7XcuxcBwjSV1xvaHjM/ypOi82x3IG4eUXjZIZPwx88G96WVyvN/oqf
         LiMtTvigWFnTcw1He8TbI2N/esgRlkxZ3BOUU2XlAcGfx9kjfzOitj1YriveJlRMymFV
         R51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=CYqSdcBbvynESHYb9tf0yZPF6x+Cdo9UApyGt0trWAs=;
        b=rBwUCnDGhJWq//6ONEzCC6Q6IFjR/nZECj5m6I+L7SVI1LrCABSGIItZhLk0Z2sYBy
         fHVazbe7nBD7c9Jh9lFyeMjBehdfPjqAw+dUrAojyXnGURPfRg5LJ/ZJSziGiGaXDEDs
         M8GIAl5SQ802uxFG5rBAdKN+lbY/V6ofvNYTSyXcxjr2eWza5kX/Duh9gPnkCsHauJ+S
         WctCGE+wUJTMrJy9wlCYoF/lvmUiGES0N/c9bJfrmdpRYvO67VmPK8ReD0K0Pazzpc1l
         zzH/G31MhVCdCVz3vf6BsvWS9Nl4lfy3OK0x6thrUL0IP/oSvl0q8JJQ8Wsd3zHfG1IF
         FZNQ==
X-Gm-Message-State: AOAM530hTrPbk6pf0Of3gbAtOR8vn3PruMC2GaEEOQAnElwJ9J66RLZ6
        FnNrXH9qCGbbVlJ2yct2qAIe6SbGO9beoSTw
X-Google-Smtp-Source: ABdhPJwxjTK/c0CgUhVnxeLRqU1cpLrqQmmmYPxKs2qt92Lo9vtvzrXqyD0c+5UkW25txH9boqoQSQ==
X-Received: by 2002:a37:9f56:: with SMTP id i83mr3260144qke.97.1598320865737;
        Mon, 24 Aug 2020 19:01:05 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1558:8dc0:5209:36ba])
        by smtp.gmail.com with ESMTPSA id y3sm10594381qkd.132.2020.08.24.19.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:01:05 -0700 (PDT)
Date:   Mon, 24 Aug 2020 22:01:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com
Subject: [PATCH] builtin/repack.c: invalidate MIDX only when necessary
Message-ID: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 525e18c04b (midx: clear midx on repack, 2018-07-12), 'git repack'
learned to remove a multi-pack-index file if it added or removed a pack
from the object store.

This mechanism is a little over-eager, since it is only necessary to
drop a MIDX if 'git repack' removes a pack that the MIDX references.
Adding a pack outside of the MIDX does not require invalidating the
MIDX, and likewise for removing a pack the MIDX does not know about.

Teach 'git repack' to check for this by loading the MIDX, and checking
whether the to-be-removed pack is known to the MIDX. This requires a
slightly odd alternation to a test in t5319, which is explained with a
comment.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
Something I noticed while working on a MIDX-related topic. Not critical
that we take this now since it's only dropping the MIDX too
aggressively, but not otherwise doing anything destructive. But, this
will make my somewhat large other series a little smaller.

 builtin/repack.c            | 12 +++++-------
 t/t5319-multi-pack-index.sh | 21 +++++++++++++++++++--
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 04c5ceaf7e..98fac03946 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -133,7 +133,11 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list,
 static void remove_redundant_pack(const char *dir_name, const char *base_name)
 {
 	struct strbuf buf = STRBUF_INIT;
-	strbuf_addf(&buf, "%s/%s.pack", dir_name, base_name);
+	struct multi_pack_index *m = get_multi_pack_index(the_repository);
+	strbuf_addf(&buf, "%s.pack", base_name);
+	if (m && midx_contains_pack(m, buf.buf))
+		clear_midx_file(the_repository);
+	strbuf_insertf(&buf, 0, "%s/", dir_name);
 	unlink_pack_path(buf.buf, 1);
 	strbuf_release(&buf);
 }
@@ -286,7 +290,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int keep_unreachable = 0;
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	int no_update_server_info = 0;
-	int midx_cleared = 0;
 	struct pack_objects_args po_args = {NULL};

 	struct option builtin_repack_options[] = {
@@ -439,11 +442,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
 			char *fname, *fname_old;

-			if (!midx_cleared) {
-				clear_midx_file(the_repository);
-				midx_cleared = 1;
-			}
-
 			fname = mkpathdup("%s/pack-%s%s", packdir,
 						item->string, exts[ext].name);
 			if (!file_exists(fname)) {
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 43b1b5b2af..16a1ad040e 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -382,12 +382,29 @@ test_expect_success 'repack with the --no-progress option' '
 	test_line_count = 0 err
 '

-test_expect_success 'repack removes multi-pack-index' '
+test_expect_success 'repack removes multi-pack-index when deleting packs' '
 	test_path_is_file $objdir/pack/multi-pack-index &&
-	GIT_TEST_MULTI_PACK_INDEX=0 git repack -adf &&
+	# Set GIT_TEST_MULTI_PACK_INDEX to 0 to avoid writing a new
+	# multi-pack-index after repacking, but set "core.multiPackIndex" to
+	# true so that "git repack" can read the existing MIDX.
+	GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -adf &&
 	test_path_is_missing $objdir/pack/multi-pack-index
 '

+test_expect_success 'repack preserves multi-pack-index when deleting unknown packs' '
+	git multi-pack-index write &&
+	cp $objdir/pack/multi-pack-index $objdir/pack/multi-pack-index.bak &&
+	test_when_finished "rm -f $objdir/pack/multi-pack-index.bak" &&
+
+	# Write a new pack that is unknown to the multi-pack-index.
+	git hash-object -w </dev/null >blob &&
+	git pack-objects $objdir/pack/pack <blob &&
+
+	GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -d &&
+	test_cmp_bin $objdir/pack/multi-pack-index \
+		$objdir/pack/multi-pack-index.bak
+'
+
 compare_results_with_midx "after repack"

 test_expect_success 'multi-pack-index and pack-bitmap' '
--
2.28.0.rc1.13.ge78abce653

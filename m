Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5AEC433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 15:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 458DF64E7C
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 15:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhBJPRF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 10:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhBJPQb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 10:16:31 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C80C061786
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 07:15:50 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o15so340567wmq.5
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 07:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=mlzyN6EN09cYDXnT25zJbM8VpmYb8hGqkzmMpJxXOqY=;
        b=V4PwWNdEZMoXurKFJyLeb43EiJ+RawVrrvMAARJEUflY15+PeVeST+T/QGFZghzKYi
         ij3uHFNMpnbgtIr00lqNJpF7q61VF4h73p8hsxmCPYlHeqZQktPbB55mn4Sog0+biedU
         B44RZEmLM0Q5Sq6WPbLkz4zeWeuNPMuKVXIglCVQzgMoAo1deXlwYB5iatSKtkUAh8n9
         ZivohiaF8zbGKicbi35ZJz0LEf1MhqBmJ/RgItFueMrEz0fJpQ8dBcei5jyjBVzy+SvN
         pQ6L1v0KYSZjWThZ8r1wfD5RSGv7c/fa4qu4ThxqFpFChKUfLZ7jP6AqljhXDYcxhGNr
         WC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=mlzyN6EN09cYDXnT25zJbM8VpmYb8hGqkzmMpJxXOqY=;
        b=bx1w4H7bt/HUW/Tw/Aj8l3kU1zSvfDNyLuq7ugCq7CmZAdZm+nE84V4XMCwhz+uxm4
         SDcWYV8AW4RFWaGfrc9nSF58UnMLwMR1cgIynmCryVIhaPfGYb+9as4P3G6RZa6a+sjk
         1PYCLm2hM7n/hQjAaKSS9N5Jk2nwWHgjGDfUQp2FlBDzGYIHm8TDDtizgWuEu/CJea8C
         MZX6h/aZdRRJ8LzFAqO2KNXlSWmKjBGQsH9cXfsDpBdjMh88b8VXdPl3blCumHB5qT5U
         vpAXK6sFsR5EhcDVlQSmq02U16Ykfaoi0y0oCPvvm/hnCwZG8bnoYat001HuFxbbZ7FP
         eMyw==
X-Gm-Message-State: AOAM53172/M0aWsNTs8Ap7zeRXqzcqv+VoF/IZfMt2Omqd/M6DdQeNZ/
        FsK8VVJb3KHziI+umncjEnCzFvt9chY=
X-Google-Smtp-Source: ABdhPJyQq5svG6Ifbtbn/Ntc/JD5CMLJUm859LE9BpDGg8p+86Pze/3psoH6iBuM0sSopO4nvG20QA==
X-Received: by 2002:a1c:29c6:: with SMTP id p189mr3404453wmp.110.1612970149209;
        Wed, 10 Feb 2021 07:15:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12sm2557272wmq.1.2021.02.10.07.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 07:15:48 -0800 (PST)
Message-Id: <2493f4b2f55d2b602e448db3f09da1ee3a97c81b.1612970140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.843.v3.git.1612970140.gitgitgadget@gmail.com>
References: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
        <pull.843.v3.git.1612970140.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Feb 2021 15:15:39 +0000
Subject: [PATCH v3 4/5] diffcore-rename: guide inexact rename detection based
 on basenames
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Make use of the new find_basename_matches() function added in the last
two patches, to find renames more rapidly in cases where we can match up
files based on basenames.  As a quick reminder (see the last two commit
messages for more details), this means for example that
docs/extensions.txt and docs/config/extensions.txt are considered likely
renames if there are no 'extensions.txt' files elsewhere among the added
and deleted files, and if a similarity check confirms they are similar,
then they are marked as a rename without looking for a better similarity
match among other files.  This is a behavioral change, as covered in
more detail in the previous commit message.

We do not use this heuristic together with either break or copy
detection.  The point of break detection is to say that filename
similarity does not imply file content similarity, and we only want to
know about file content similarity.  The point of copy detection is to
use more resources to check for additional similarities, while this is
an optimization that uses far less resources but which might also result
in finding slightly fewer similarities.  So the idea behind this
optimization goes against both of those features, and will be turned off
for both.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:       13.815 s ±  0.062 s    13.294 s ±  0.103 s
    mega-renames:   1799.937 s ±  0.493 s   187.248 s ±  0.882 s
    just-one-mega:    51.289 s ±  0.019 s     5.557 s ±  0.017 s

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c      | 54 ++++++++++++++++++++++++++++++++++++++----
 t/t4001-diff-rename.sh |  4 ++--
 2 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 001645624e71..df76e475c710 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -379,7 +379,6 @@ static const char *get_basename(const char *filename)
 	return base ? base + 1 : filename;
 }
 
-MAYBE_UNUSED
 static int find_basename_matches(struct diff_options *options,
 				 int minimum_score,
 				 int num_src)
@@ -727,12 +726,57 @@ void diffcore_rename(struct diff_options *options)
 	if (minimum_score == MAX_SCORE)
 		goto cleanup;
 
+	num_sources = rename_src_nr;
+
+	if (want_copies || break_idx) {
+		/*
+		 * Cull sources:
+		 *   - remove ones corresponding to exact renames
+		 */
+		trace2_region_enter("diff", "cull after exact", options->repo);
+		remove_unneeded_paths_from_src(want_copies);
+		trace2_region_leave("diff", "cull after exact", options->repo);
+	} else {
+		/* Determine minimum score to match basenames */
+		double factor = 0.5;
+		char *basename_factor = getenv("GIT_BASENAME_FACTOR");
+		int min_basename_score;
+
+		if (basename_factor)
+			factor = strtol(basename_factor, NULL, 10)/100.0;
+		assert(factor >= 0.0 && factor <= 1.0);
+		min_basename_score = minimum_score +
+			(int)(factor * (MAX_SCORE - minimum_score));
+
+		/*
+		 * Cull sources:
+		 *   - remove ones involved in renames (found via exact match)
+		 */
+		trace2_region_enter("diff", "cull after exact", options->repo);
+		remove_unneeded_paths_from_src(want_copies);
+		trace2_region_leave("diff", "cull after exact", options->repo);
+
+		/* Utilize file basenames to quickly find renames. */
+		trace2_region_enter("diff", "basename matches", options->repo);
+		rename_count += find_basename_matches(options,
+						      min_basename_score,
+						      rename_src_nr);
+		trace2_region_leave("diff", "basename matches", options->repo);
+
+		/*
+		 * Cull sources, again:
+		 *   - remove ones involved in renames (found via basenames)
+		 */
+		trace2_region_enter("diff", "cull basename", options->repo);
+		remove_unneeded_paths_from_src(want_copies);
+		trace2_region_leave("diff", "cull basename", options->repo);
+	}
+
 	/*
-	 * Calculate how many renames are left
+	 * Calculate how many rename destinations are left
 	 */
 	num_destinations = (rename_dst_nr - rename_count);
-	remove_unneeded_paths_from_src(want_copies);
-	num_sources = rename_src_nr;
+	num_sources = rename_src_nr; /* rename_src_nr reflects lower number */
 
 	/* All done? */
 	if (!num_destinations || !num_sources)
@@ -764,7 +808,7 @@ void diffcore_rename(struct diff_options *options)
 		struct diff_score *m;
 
 		if (rename_dst[i].is_rename)
-			continue; /* dealt with exact match already. */
+			continue; /* exact or basename match already handled */
 
 		m = &mx[dst_cnt * NUM_CANDIDATE_PER_DST];
 		for (j = 0; j < NUM_CANDIDATE_PER_DST; j++)
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 797343b38106..bf62537c29a0 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -280,8 +280,8 @@ test_expect_success 'basename similarity vs best similarity' '
 	# subdir/file.txt is 89% similar to file.md, 78% similar to file.txt,
 	# but since same basenames are checked first...
 	cat >expected <<-\EOF &&
-	R088	subdir/file.txt	file.md
-	A	file.txt
+	A	file.md
+	R078	subdir/file.txt	file.txt
 	EOF
 	test_cmp expected actual
 '
-- 
gitgitgadget


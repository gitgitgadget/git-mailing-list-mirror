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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E12C433E0
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 07:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CEFB64E23
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 07:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhBNHy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 02:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhBNHwv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 02:52:51 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B026BC0617A7
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:51:56 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id h67so104157wmh.1
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Eg5T87WVuPjTWM1Kn25bFQ3WO7SspbkGCOsQAjGzx7s=;
        b=IocjBKyeBoEel0Lor5phDYHuCfsGcX/NMInCjBnvdHhxIE4NoBbz/swsRy52f/nldY
         /Od8uDDIpztv9nFli+tuv46FBRHSYz/BfJT6uAlRF1RwGkkvrk7eN8fvkR8E8zpcKXvw
         RPEJJhhNCBHV2SYl+QfjFN6Ch74CZtN+vrbJkfi8JaZd8CAOY4vo6U3tcgFxc/pDOE9F
         G6S5qJr2hQC8JNPpgQShSyv4GnZXyoAyXAjGiMnCtmiBT4QQRxWhZetsY1cjw/Rl6FMZ
         aR2MFO5Jkdpdrw4q1phWI4z2lUNMtTtDC0QGA+s52CJ4v5t6EUZRlmiHYgyMhu40F7rF
         Ee4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Eg5T87WVuPjTWM1Kn25bFQ3WO7SspbkGCOsQAjGzx7s=;
        b=r/fSmEiGWxkNRomUOQiHVo/NYjgNLqn4QAa0nbwbL4R/SSZDMSihgNhsWEz1brO4VQ
         vKY1L1q7CDFx3DpTTEE8xlTy5e0O910XWrRq7B+2SCTPUdTcs80TY48wZJOUQAjmpvxK
         Ji8AYWeIGu3UEKPxBssQfDi8NP8Aah8ROGLiv2FlTaqzkqhtiMfrZ3EWl0kOj//s4Z9j
         abuUix88N4rcSwyGPbjr7BQIhF6Wlj/5tbHyyTqAVGrSduYYcQLdg6JmZHfTvLGFsf2T
         mQQfeTKv5FhXhhhuueXQUJyjvaEUSm2uiZO8OFHTWHEfU0SbQFsIRw29svdhtWkqyhwE
         mnBw==
X-Gm-Message-State: AOAM5324CH24lf54aEm7ugM0JZuey/eOKQ0LDI32wvn6t+9MQkXTjwbU
        nbZAcxl9rqajWAoiq4RiFtJssqStKoU=
X-Google-Smtp-Source: ABdhPJy+mKSVXg3FZ+HIX7koaPsG9H//381B+291/pha5WzmN5jDSbhL3aEe2cdP/9Iqo5QgiZw7RA==
X-Received: by 2002:a1c:408a:: with SMTP id n132mr9107703wma.86.1613289115410;
        Sat, 13 Feb 2021 23:51:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d23sm21437794wmd.11.2021.02.13.23.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 23:51:55 -0800 (PST)
Message-Id: <122902e2706f70e926e1e05952d7dee7914607f0.1613289112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.843.v5.git.1613289112.gitgitgadget@gmail.com>
References: <pull.843.v4.git.1613031350.gitgitgadget@gmail.com>
        <pull.843.v5.git.1613289112.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Feb 2021 07:51:49 +0000
Subject: [PATCH v5 4/6] diffcore-rename: guide inexact rename detection based
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
renames if there are no remaining 'extensions.txt' files elsewhere among
the added and deleted files, and if a similarity check confirms they are
similar, then they are marked as a rename without looking for a better
similarity match among other files.  This is a behavioral change, as
covered in more detail in the previous commit message.

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
 diffcore-rename.c      | 53 ++++++++++++++++++++++++++++++++++++++----
 t/t4001-diff-rename.sh |  7 +++---
 2 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 266d4fae48c7..41558185ae1d 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -379,7 +379,6 @@ static const char *get_basename(const char *filename)
 	return base ? base + 1 : filename;
 }
 
-MAYBE_UNUSED
 static int find_basename_matches(struct diff_options *options,
 				 int minimum_score)
 {
@@ -716,11 +715,55 @@ void diffcore_rename(struct diff_options *options)
 	if (minimum_score == MAX_SCORE)
 		goto cleanup;
 
-	/* Calculate how many renames are left */
-	num_destinations = (rename_dst_nr - rename_count);
-	remove_unneeded_paths_from_src(want_copies);
 	num_sources = rename_src_nr;
 
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
+						      min_basename_score);
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
+	/* Calculate how many rename destinations are left */
+	num_destinations = (rename_dst_nr - rename_count);
+	num_sources = rename_src_nr; /* rename_src_nr reflects lower number */
+
 	/* All done? */
 	if (!num_destinations || !num_sources)
 		goto cleanup;
@@ -751,7 +794,7 @@ void diffcore_rename(struct diff_options *options)
 		struct diff_score *m;
 
 		if (rename_dst[i].is_rename)
-			continue; /* dealt with exact match already. */
+			continue; /* exact or basename match already handled */
 
 		m = &mx[dst_cnt * NUM_CANDIDATE_PER_DST];
 		for (j = 0; j < NUM_CANDIDATE_PER_DST; j++)
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 0f97858197e1..99a5d1bd1c3a 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -277,10 +277,11 @@ test_expect_success 'basename similarity vs best similarity' '
 	git add file.txt file.md &&
 	git commit -a -m "rename" &&
 	git diff-tree -r -M --name-status HEAD^ HEAD >actual &&
-	# subdir/file.txt is 88% similar to file.md and 78% similar to file.txt
+	# subdir/file.txt is 88% similar to file.md, 78% similar to file.txt,
+	# but since same basenames are checked first...
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


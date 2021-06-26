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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94D9C49EA5
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 17:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9879A61C19
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 17:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhFZRHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 13:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhFZRHs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 13:07:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF6CC061766
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 10:05:25 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l8so5636480wry.13
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AQ1OdsAPr2gaze4eE18sUokQoCP+whnjXHIa60XXz/U=;
        b=Idhx+zdq5IE3D30DsGX1TOBv6vcMZe8qJc48pVDCt8XfCdUWorYh3L7UQk9sz4rT4r
         hP24VrlX1t5lEXW4KmIsP1LoGTBbkY+RVTg+8p7Hjj2GQA/e5XLbMT4kcU690Bp6x45C
         tFH5KndWkxZNDnRVBt2chm9zhNZlsYNDTwm/fbO7o1hzMrfknYeIiHriMXoik8BQH7Er
         PUYpXcO1vGUupXwDl6VGMNw2i6fw0nDnJ3NNcFvoABi9XN+FnrhEEa+Kvj4N6rHmDpe8
         M/Q8FVhfB4fO8DnhsRm/qfx1sptUg41eHuS58tTTTWWatu64ps+Oe8nsVcy6mqs1xDZX
         cnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AQ1OdsAPr2gaze4eE18sUokQoCP+whnjXHIa60XXz/U=;
        b=OiGGxbmjcDUV8snL2PKJmXfStGVV2JF2xk+6Kh/+8IR+C8aDuYdBgjDF+FOaBtnip4
         EzT3HvxaxNLEla2P8R4BNd2SK5UeH46tGTeMITiygVURWUKIOPwAhNez6Bg8+QFehWFM
         ttMf+Ro6zzOvEXq8bmoNLTmZTZz2jrMzK5yGQ8jXMlWKkL6bKgw1S6r6p7C3D5bHXsf7
         RCOBk7J+VdyBc6f23Z1GxGyvcy6rZQwDe3xKyZP+sNAi5EP6O8fjzZTu4d+Qe1aHGeuZ
         7DqvE+1BoWafS5bu1moK4gn2yF8G2ljkmA25ELrrluAgTHPO5Tf8t+Iqt/6AV5RC/870
         rW+Q==
X-Gm-Message-State: AOAM533OlmVTRw+bWazILdhv6qMfEmGWrh5WaL0fY0N/iHlvgwephKzH
        tFGwSHPsB+we5+386Rfcy2Y3Dxmjglg=
X-Google-Smtp-Source: ABdhPJxqnAOWoglcNoRBmpX1fs4Ylv3U9ixNg459poxDsRU22KTEQy4QInqR2arqXYQMU8RbYQra0A==
X-Received: by 2002:a5d:6d8b:: with SMTP id l11mr17954366wrs.21.1624727124465;
        Sat, 26 Jun 2021 10:05:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15sm9121057wrq.88.2021.06.26.10.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 10:05:24 -0700 (PDT)
Message-Id: <052f40c3c1a6b35f9253faf698f8cbc87f81675e.1624727121.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1039.git.git.1624727121.gitgitgadget@gmail.com>
References: <pull.1039.git.git.1624727121.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 26 Jun 2021 17:05:20 +0000
Subject: [PATCH 2/3] merge-ort: ensure we consult df_conflict and
 path_conflicts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Path conflicts (typically rename path conflicts, e.g.
rename/rename(1to2) or rename/add/delete), and directory/file conflicts
should obviously result in files not being marked as clean in the merge.
We had a codepath where we missed consulting the path_conflict and
df_conflict flags, based on match_mask.  Granted, it requires an unusual
setup to trigger this codepath (directory rename causing rename-to-self
is the only case I can think of), but we still need to handle it.  To
make it clear that we have audited the other codepaths that do not
explicitly mention these flags, add some assertions that the flags are
not set.

Reported-by: Anders Kaseorg <andersk@mit.edu>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c                         | 6 +++++-
 t/t6423-merge-rename-directories.sh | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index b954f7184a5..373dbac5079 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3237,7 +3237,7 @@ static void process_entry(struct merge_options *opt,
 	 *       above.
 	 */
 	if (ci->match_mask) {
-		ci->merged.clean = 1;
+		ci->merged.clean = !ci->df_conflict && !ci->path_conflict;
 		if (ci->match_mask == 6) {
 			/* stages[1] == stages[2] */
 			ci->merged.result.mode = ci->stages[1].mode;
@@ -3249,6 +3249,8 @@ static void process_entry(struct merge_options *opt,
 
 			ci->merged.result.mode = ci->stages[side].mode;
 			ci->merged.is_null = !ci->merged.result.mode;
+			if (ci->merged.is_null)
+				ci->merged.clean = 1;
 			oidcpy(&ci->merged.result.oid, &ci->stages[side].oid);
 
 			assert(othermask == 2 || othermask == 4);
@@ -3421,6 +3423,7 @@ static void process_entry(struct merge_options *opt,
 				   path)) {
 			ci->merged.is_null = 1;
 			ci->merged.clean = 1;
+			assert(!ci->df_conflict && !ci->path_conflict);
 		} else if (ci->path_conflict &&
 			   oideq(&ci->stages[0].oid, &ci->stages[side].oid)) {
 			/*
@@ -3447,6 +3450,7 @@ static void process_entry(struct merge_options *opt,
 		ci->merged.is_null = 1;
 		ci->merged.result.mode = 0;
 		oidcpy(&ci->merged.result.oid, null_oid());
+		assert(!ci->df_conflict);
 		ci->merged.clean = !ci->path_conflict;
 	}
 
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 2a2ab907338..7480daab46a 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5058,7 +5058,7 @@ test_setup_12i () {
 	)
 }
 
-test_expect_merge_algorithm failure failure '12i: Directory rename causes rename-to-self' '
+test_expect_merge_algorithm failure success '12i: Directory rename causes rename-to-self' '
 	test_setup_12i &&
 	(
 		cd 12i &&
@@ -5116,7 +5116,7 @@ test_setup_12j () {
 	)
 }
 
-test_expect_merge_algorithm failure failure '12j: Directory rename to root causes rename-to-self' '
+test_expect_merge_algorithm failure success '12j: Directory rename to root causes rename-to-self' '
 	test_setup_12j &&
 	(
 		cd 12j &&
-- 
gitgitgadget


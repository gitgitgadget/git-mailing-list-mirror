Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BF6C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 02:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 504F260F9E
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 02:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhG1Cpv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 22:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbhG1Cpu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 22:45:50 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D2CC061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 19:45:49 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 129so881176qkg.4
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 19:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vFuhFtvVqymEn3/jyY+vpA/8eC+cCAvA726w32Q36g0=;
        b=XbKkQ9W2SvU7Y8N1ju8mcCOJenGQ/1JHapLpIyYy9vDXkxbjLpMaPElw35g58T+Hyi
         UoWjsZOcg8s4hiNd6zG5rHx3ENR7oeBE3siDb8mLgkJGT7Fpdwtvk8hadUSxLpQwj+Db
         I1hjdBwHjUcymvSFqdz2rXLIIFcGMzWbAolx0QxAxyuspdUfHhbHzCNRSH0wIqeT0JUh
         V7ZZIbB1yOEz/V0zepCKhX35Fe9eU51XidwAMN0fJmkTgCWOY8jUTObhma+clTuS14hw
         shCjx+iA2+B42TJmrxCpP6/G4c1gIKT6mLhNgx750g5WiPl+zdEkADjlRDzblnrgbJN9
         EvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vFuhFtvVqymEn3/jyY+vpA/8eC+cCAvA726w32Q36g0=;
        b=LAFuQ7ehojXdmOavLAsnOA5y8BYsUNqfEo0SHlG5EYs8rRsvJ5Z0ZjscOZXAZuNbzg
         pfAcnam2313trpmmH7c71imcdaWpgcvHhZ9zh8ck7yq02CpuUUd7D97T1a5UaFr5bIUK
         JY43A5lbElLKpEzzvujXca5hkporHG5k+Ty/xJcme1hgvo9WHI5hTME7i1gHzFbML2hH
         l6PZlIFzS4pnH4yLUcnu0uuS9IHRvorprLt58uG7AmwpPeAM/2kbagfPWX+zwfS6CMnH
         ThjhmuRwvs/ZWVQ6CqrwcAeLcTVQCfHybHKYl2xEERuA4wo/nxxjZJmde636HwtmW8VL
         XZPQ==
X-Gm-Message-State: AOAM530xMf0iUctVg5LTCYAmS34UiKHhS4pdtQb3SCDzKQUk8CCQw817
        6Sar6pJmVnVgbqAZ+uvpiqgGr2KtCFsYqw==
X-Google-Smtp-Source: ABdhPJwwpIzndsabAdOYyVCvxVcyrq73g2EjAtXPo737mODBkdzmA+5bZCaKHeHS0x+7gRM2f9v+3g==
X-Received: by 2002:a37:f711:: with SMTP id q17mr25343906qkj.117.1627440347805;
        Tue, 27 Jul 2021 19:45:47 -0700 (PDT)
Received: from jerry-desktop.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id w20sm2610517qkj.27.2021.07.27.19.45.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jul 2021 19:45:47 -0700 (PDT)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com, lilinchao@oschina.cn
Cc:     Jerry Zhang <jerry@skydio.com>
Subject: [PATCH] git-apply: fix --3way with binary patch
Date:   Tue, 27 Jul 2021 19:44:34 -0700
Message-Id: <20210728024434.20230-1-jerry@skydio.com>
X-Mailer: git-send-email 2.32.0.4.g29b9734da9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Binary patches applied with "--3way" will
always return a conflict even if the patch
should cleanly apply because the low level
merge function considers all binary merges
without a variant to be conflicting.

Fix by falling back to normal patch application
for all binary patches.

Add tests for --3way and normal applications
of binary patches.

Fixes: 923cd87ac8 ("git-apply: try threeway first when "--3way" is used")
Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
 apply.c                   |  3 ++-
 t/t4108-apply-threeway.sh | 45 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 1d2d7e124e..78e52f0dc1 100644
--- a/apply.c
+++ b/apply.c
@@ -3638,7 +3638,8 @@ static int apply_data(struct apply_state *state, struct patch *patch,
 	if (load_preimage(state, &image, patch, st, ce) < 0)
 		return -1;
 
-	if (!state->threeway || try_threeway(state, &image, patch, st, ce) < 0) {
+	if (!state->threeway || patch->is_binary ||
+		try_threeway(state, &image, patch, st, ce) < 0) {
 		if (state->apply_verbosity > verbosity_silent &&
 		    state->threeway && !patch->direct_to_threeway)
 			fprintf(stderr, _("Falling back to direct application...\n"));
diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index 65147efdea..d32748f899 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -230,4 +230,49 @@ test_expect_success 'apply with --3way --cached and conflicts' '
 	test_cmp expect.diff actual.diff
 '
 
+test_expect_success 'apply binary file patch' '
+	git reset --hard main &&
+	cp $TEST_DIRECTORY/test-binary-1.png bin.png &&
+	git add bin.png &&
+	git commit -m "add binary file" &&
+
+	cp $TEST_DIRECTORY/test-binary-2.png bin.png &&
+
+	git diff --binary >bin.diff &&
+	git reset --hard &&
+
+	# Apply must succeed.
+	git apply bin.diff
+'
+
+test_expect_success 'apply binary file patch with 3way' '
+	git reset --hard main &&
+	cp $TEST_DIRECTORY/test-binary-1.png bin.png &&
+	git add bin.png &&
+	git commit -m "add binary file" &&
+
+	cp $TEST_DIRECTORY/test-binary-2.png bin.png &&
+
+	git diff --binary >bin.diff &&
+	git reset --hard &&
+
+	# Apply must succeed.
+	git apply --3way --index bin.diff
+'
+
+test_expect_success 'apply full-index patch with 3way' '
+	git reset --hard main &&
+	cp $TEST_DIRECTORY/test-binary-1.png bin.png &&
+	git add bin.png &&
+	git commit -m "add binary file" &&
+
+	cp $TEST_DIRECTORY/test-binary-2.png bin.png &&
+
+	git diff --full-index >bin.diff &&
+	git reset --hard &&
+
+	# Apply must succeed.
+	git apply --3way --index bin.diff
+'
+
 test_done
-- 
2.32.0.1314.g6ed4fcc4cc


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7B0C433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 01:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF796127A
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 01:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbhD0BNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 21:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhD0BNg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 21:13:36 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DF7C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 18:12:54 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id h20so29932133plr.4
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 18:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZOMx5QZLv2XB5D8sOFL19a4gntals5tcEBZ9uz391b0=;
        b=0G4OdMt4GGraBAUrvVkMD+XnLn77J+gMIrsknrBA6rAw2c3T3ITjwdftOpgBLNccFh
         PXWO2ghjtlTlK3WHrpBVU60j9SlJFbvcNhVB4IGeBaUss+w8M3KD3KJbMSKiOEOBoUmo
         G7e7VVFs/WPpIRE9golN92p19mSv6gQXZy8otUTIwIkjTZ8b+2CjGcyYgSY9d8rrxlY0
         WLCZm35zrHlIW5g9iWTaEDznRdgz6Rkg2vZvSbjnJEfHvHdquV6FcbgZM6+o7BPFWlWB
         UT987Ni3i19dfsc86bZBd4ACX2dHVeMPc03QBwbOrEsB7wjHvHBJZQbXxuj6LJ3zwB3h
         Zeyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZOMx5QZLv2XB5D8sOFL19a4gntals5tcEBZ9uz391b0=;
        b=BuNSuKLQuf3JRp64HiiJrSh3eQiinCAc0ODYwqcBur2uiHfslgooPYlPWpa59lA5ge
         Qx6dXwcRtb27m5su6cN8OfZPxraTIBi54mVXIxa7h6vWOcOQLtoJ8LlYZ+FwG31rlH9g
         fjwg/iPIkBWfY6MDXFVuGXgjJEP2sJMZxR+K6xXBSYlpLkkhDrDs9K9GOPCOnnt1ZGsQ
         7uhXtK44UX8fpbRxi+u67HxdTuXRIB4qV6JCugqmb2SnPFO+yekGiNaJA/YGlxCPJl16
         8H+8+PvZFB+W/timQUUpc9ZzCWU3mjYTy8sXlGU9z4eWfTj1qAU+fptKnZNDi1QGCiRC
         qLdw==
X-Gm-Message-State: AOAM5320ixry6PPot1gepbqc/Aj9cGJ9soJEwx8ZfpF9svlucBbeS6uj
        N2Ty0V4okan/LtPYXzyovTlhdjmTB8UaSabf
X-Google-Smtp-Source: ABdhPJzurxShrQYV9wnq2VRZVs9ixEcEJYLSiBkT23oCBOQiHkEQIS4YtmiHWayGI0e/xog+hmX9aw==
X-Received: by 2002:a17:90b:3706:: with SMTP id mg6mr2057852pjb.90.1619485972877;
        Mon, 26 Apr 2021 18:12:52 -0700 (PDT)
Received: from jerry-desktop.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id 132sm733097pfu.107.2021.04.26.18.12.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Apr 2021 18:12:52 -0700 (PDT)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     ross@skydio.com, abe@skydio.com, brian.kubisiak@skydio.com,
        Jerry Zhang <jerry@skydio.com>
Subject: [PATCH] git-apply: allow empty patch text
Date:   Mon, 26 Apr 2021 18:12:46 -0700
Message-Id: <20210427011246.28054-1-jerry@skydio.com>
X-Mailer: git-send-email 2.31.1.335.g42ef272d81
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git diff" produces no patch text if
there is no diff, but "git apply" exits
with code 128 if the patch text is empty.

Since every valid "git diff" should
result in a successful patch application
when applied to the same preimage as
the diff, allow "git apply" to handle
these empty diffs by doing nothing and
returning 0.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
 apply.c                | 2 ++
 t/t4126-apply-empty.sh | 7 +++++++
 t/t7006-pager.sh       | 2 +-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 5ea237232d..2abf2e8a61 100644
--- a/apply.c
+++ b/apply.c
@@ -4685,6 +4685,8 @@ static int apply_patch(struct apply_state *state,
 	state->patch_input_file = filename;
 	if (read_patch_file(&buf, fd) < 0)
 		return -128;
+	if (!buf.len)
+		goto end;
 	offset = 0;
 	while (offset < buf.len) {
 		struct patch *patch;
diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
index ceb6a79fe0..37351be609 100755
--- a/t/t4126-apply-empty.sh
+++ b/t/t4126-apply-empty.sh
@@ -31,6 +31,13 @@ test_expect_success 'apply empty' '
 	test_cmp expect empty
 '
 
+test_expect_success 'apply empty diff' '
+	git reset --hard &&
+	git diff >empty.patch &&
+	git apply empty.patch &&
+	git diff | git apply -
+'
+
 test_expect_success 'apply --index empty' '
 	git reset --hard &&
 	rm -f missing &&
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 0e7cf75435..2c0ada6bf6 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -567,7 +567,7 @@ test_default_pager        expect_success 'git -p shortlog'
 test_core_pager_subdir    expect_success 'git -p shortlog'
 
 test_core_pager_subdir    expect_success test_must_fail \
-					 'git -p apply </dev/null'
+					 'git -p log !'
 
 test_expect_success TTY 'command-specific pager' '
 	sane_unset PAGER GIT_PAGER &&
-- 
2.29.0


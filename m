Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208C9C56201
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5E15206D9
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl1cQ+94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbgKYWLl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 17:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbgKYWLk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 17:11:40 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15955C0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 14:11:40 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a3so184904wmb.5
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 14:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=SpbkI/cq6ypJA6uCDvP/u+gqDYEbyVb+8tGenPzXo1Y=;
        b=nl1cQ+94DikvIHwGQHTiTVWfVHpVP8epDBegzSSwvJm7SUBYnFhVyLnl96fU/qCWtP
         1I5+3uJTCml6Eeye9knwvMoVLIbdz5l8IV9cxesz4+h9dTF2oyPcPw9F2n3t9cUaJ/WN
         6IRolfsSXuGUYlqCVhyr1XAvdbl+qIOkdjkDe87MLrLDoBT125VTQ9ravax4JF+sa7m5
         2zq6r9r8JmkYKNj6xuk64tTZAZsmENuvwGRS2d6NF5DTwsmmmtSR/vozZAwgPXgO+nkQ
         A+hOPqEW9Sxa0HN3nFdVUi0WbAyEIBKPJEuDI5h5GdqRum6F5s/djNhFzuQgEUKxRbTI
         cwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SpbkI/cq6ypJA6uCDvP/u+gqDYEbyVb+8tGenPzXo1Y=;
        b=oX2m7BDLDf3p9UEQy398K9PPfeL4R+KnUHCzG9A6VwYbxDlYKDYKLFzFlpOpvZ5eLF
         T6QQhBSZoZcwV9DDjHiUUxWPVZje+KbDLx8xsgQKTg5O9wZVcf36IJnLFFVIWzNddZCf
         z2Pg91fPf8lkyFnpoX1g4GAJkfF7yQNCjoh72ykhLhgXB+HPMEWnPmqDyu8mWoJSieOF
         y1NkqEzCXhkuDlNDEoa0eJeGCQLtnmRihOQtSKgTJQKFrsLMde/yCNo+D+nhj0n94aR+
         WNq/EFCmBok7ISaOqyRKLyHdaUV60X7pjc8h+qDzAsQOBt3ySAhlTg49eJBKraKh/sFZ
         /tAQ==
X-Gm-Message-State: AOAM533qFyELFI73HsA2zZQ+hH20qTxBlieFGkAQKOi/WC7ZkfcJTZHL
        HKw/sIFVncw9p8+vExVucr3EKzf8t0Q=
X-Google-Smtp-Source: ABdhPJwXmuuRf350+lLeLvZdeD2vkZrcPWmZfE6nkfve2oxbg3lsG35p0wg4hQWLguse8gIVvVFAEA==
X-Received: by 2002:a1c:bd0b:: with SMTP id n11mr6345276wmf.111.1606342298556;
        Wed, 25 Nov 2020 14:11:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l23sm5603445wmh.40.2020.11.25.14.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 14:11:37 -0800 (PST)
Message-Id: <pull.799.git.1606342297403.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Nov 2020 22:11:37 +0000
Subject: [PATCH] perf/fsmonitor: use test_must_be_empty helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

Simplify test and make error messages more clear here.
Per feedback from Junio in
33226af42b (t/perf/fsmonitor: improve error message if typoing hook
name, 2020-10-26)

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
    perf/fsmonitor: use test_must_be_empty helper
    
    Simplify perf/fsmonitor test and make error messages more clear.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-799%2Fnipunn1313%2Fnk%2Ffsmonitor-test-cleanup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-799/nipunn1313/nk/fsmonitor-test-cleanup-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/799

 t/perf/p7519-fsmonitor.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 163a13bea3..9b43342806 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -129,8 +129,7 @@ setup_for_fsmonitor() {
 
 	git config core.fsmonitor "$INTEGRATION_SCRIPT" &&
 	git update-index --fsmonitor 2>error &&
-	cat error &&
-	[ ! -s error ] # ensure no silent error
+	test_must_be_empty error  # ensure no silent error
 }
 
 test_perf_w_drop_caches () {

base-commit: b291b0a628020eedb10b6236d87fe25d295cea81
-- 
gitgitgadget

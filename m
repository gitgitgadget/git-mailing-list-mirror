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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C78C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DE9F64F8D
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhBCPhh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 10:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbhBCPga (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 10:36:30 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413FEC06178C
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 07:34:57 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id z6so24798518wrq.10
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 07:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4JdvzMteIxlWXUcVb8uLqJSuNeM/NiZeS3hpk/UWicg=;
        b=orT0VTJqnGGKZVLjb53Jn1EVLDYcrKjoOEUWl3P4B0ZluSJPrs7xCuHa3HABzqibMD
         hYIUy2OeMNHXttmUxvc/W4EP+ilN0tUSEzmbjzOmqq6ZQVwpMTobrahKIbWzPoTbZimg
         nFkQkisFPsYy/IeTXsSqHvZnvM214Y9542wq0wU0Eu51+i6r51bxwSbBmleIJB0ts4+s
         qK9w9fU/ZHWm0+2gitWB0HkBetbbL8S8ap1Xf8qXaanhp/2xN/Hd95IGE1qxH11G2RM3
         R0Rr8aTUz4fnyGRGT6UU/a2edDD9PCHe8SvqXOOn/NzQSVCyuaSDeyyJJx/DJrevFf0q
         /YbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4JdvzMteIxlWXUcVb8uLqJSuNeM/NiZeS3hpk/UWicg=;
        b=DhLcK6QXEXtfiWTk9eSh4LMZ1PCLLsxbjCsZ2/5M/vuTZ2w/WAw93fOxUpmI1RHKVY
         vDt0HNTQlRgxzmPNM2bU2PKYIEgT7G1QYscWsR3CqJ9iQprZRPxLgyB8161aqjozJIsw
         C7KkrReWFkDyKHiOGn5fc7mOl2Y6DNJbVaABOkpMfJoWj9gyNMYMVfrpEw8ZKQLMY7PE
         eIgorO58sbEfnTN0W1AhoKHdWT9ywQslthLPdyouQWDzdO2psrZbhg4jHb6zONV3Izz1
         jnwyvYlURc6z+9bZu1Yd1v3TFVEGqSAAeycx9L0UMlNj6GDrv43gRhTvfOY/C4NuHTP2
         gFCw==
X-Gm-Message-State: AOAM532/MIkeCeHug0SeUDnYFzHXfwe28ujpMq81Sces056ZMlZiKVwa
        dOicbQRwaVkAE86E9Zbx7qPabAlimk4=
X-Google-Smtp-Source: ABdhPJxnr5QZZehbTrhe49fFf/mg24zob9FZwtwch4vd1P8bVS9YG+X+74LRHMrt8ZasYdd3S8Pskg==
X-Received: by 2002:adf:92a6:: with SMTP id 35mr4228898wrn.193.1612366495743;
        Wed, 03 Feb 2021 07:34:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m18sm4244878wrx.17.2021.02.03.07.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:34:55 -0800 (PST)
Message-Id: <9ceba5e69420f12eeb834f387372520b061e28a7.1612366490.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
        <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 15:34:42 +0000
Subject: [PATCH v2 03/11] p7519: move watchman cleanup earlier in the test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Shutdown Watchman after the Watchman-based tests and before the block of
"no fsmonitor" tests.

This helps ensure that Watchman cannot affect the test results for the
other.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p7519-fsmonitor.sh | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 21d525541d5..78e7d2c03f5 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -208,6 +208,11 @@ test_fsmonitor_suite() {
 	'
 }
 
+#
+# Run a full set of perf tests using each Hook-based fsmonitor provider,
+# such as Watchman.
+#
+
 if test -n "$GIT_PERF_7519_FSMONITOR"; then
 	for INTEGRATION_PATH in $GIT_PERF_7519_FSMONITOR; do
 		test_expect_success "setup for fsmonitor $INTEGRATION_PATH" 'setup_for_fsmonitor'
@@ -218,14 +223,6 @@ else
 	test_fsmonitor_suite
 fi
 
-test_expect_success "setup without fsmonitor" '
-	unset INTEGRATION_SCRIPT &&
-	git config --unset core.fsmonitor &&
-	git update-index --no-fsmonitor
-'
-
-test_fsmonitor_suite
-
 if test_have_prereq WATCHMAN
 then
 	watchman watch-del "$GIT_WORK_TREE" >/dev/null 2>&1 &&
@@ -235,4 +232,16 @@ then
 	watchman shutdown-server >/dev/null 2>&1
 fi
 
+#
+# Run a full set of perf tests with the fsmonitor feature disabled.
+#
+
+test_expect_success "setup without fsmonitor" '
+	unset INTEGRATION_SCRIPT &&
+	git config --unset core.fsmonitor &&
+	git update-index --no-fsmonitor
+'
+
+test_fsmonitor_suite
+
 test_done
-- 
gitgitgadget


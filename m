Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8B2C2D0E4
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 07:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE9A21D93
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 07:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRP3QOcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392786AbgK0Hvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Nov 2020 02:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392782AbgK0Hvw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Nov 2020 02:51:52 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E502C0613D4
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 23:51:52 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id f5so3818416ilj.9
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 23:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3N8OmOQFNx6Z25QLFPQLON+DSEIPCgbfupV+r8IndRg=;
        b=NRP3QOcXel13FewljO+uHJHWpEcEaTCRQ03f/dnP9dqU2Y92nrEXfIcUQXwxokpOYN
         wDagWYE6ajwSfRCQ1uPxuq3yWMxu/Me4Lc5lava2WvmMwdPcwiuNrMtDgrpX6VFqzHBi
         vyWsMo7/1C9p3C2suJ9kT6hsZAb7+k6ygmMNUFBxZ1I2EBxUJ2HpbSRJavQNEdZthnjW
         KyYKV8rL++OWdCvCCnt0mjPvhJJi29b6UIBkvkP0tA7/pLrbO+wvPLdNNrX271+UxXa6
         cbB4uCQ2c3GH6OHHLoxk72Pd/XfplyFDlzeOehrKB8yyYau84ynta84HDyYZeW782stY
         eM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3N8OmOQFNx6Z25QLFPQLON+DSEIPCgbfupV+r8IndRg=;
        b=sp3MuaqUkEiCJ85nR7eFoFpHaoj57LNa20moOlVT4IiQ2X8P4xeNGLHkPSdwRnXO9o
         wjd+cw3px/mqlm34K+CtkeF9av4L3DpdCh9kZ+Xczb3Rfk6GByglFP17AUdU5FPiz4oW
         EK2tBYM+mWt/aSuZziOlw+JnGLkO0Q6Zp4X7OqhsR6y52eZw8Ylvz2zzwLjgg2ihHwe1
         inYPgiRYHLe1yIv1gwm0tsYt63AwOEDl7HND33/RHmzJ0c0VY5fnpyRqJ54As0/eu8RJ
         /wicJ5lOIqZfeyNj8Wq0vGZI8dsoU8pTixqr0AC+jbgLrvmz2s9UhfoC4llnOY73uSft
         ZTdA==
X-Gm-Message-State: AOAM530dxyuTVInkBfBGgkKfqFWcrPZ4NnkFG/s59Ix6PwwUYA59O0Cs
        bddF+kOtq3PsqOcNRTNjowCoI1jQ2Jk=
X-Google-Smtp-Source: ABdhPJxnAxXTz2mpET/SiQoxfROV/HgqWUvqMfkAsiKdLef8z9hGCNqyUo+jZshFI5LmT5Ex/s1s9Q==
X-Received: by 2002:a92:2a01:: with SMTP id r1mr5912920ile.22.1606463511372;
        Thu, 26 Nov 2020 23:51:51 -0800 (PST)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id 10sm4652447ill.75.2020.11.26.23.51.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Nov 2020 23:51:50 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/3] t7900: fix test failures when invoked individually via --run
Date:   Fri, 27 Nov 2020 02:50:52 -0500
Message-Id: <20201127075054.31174-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84
In-Reply-To: <20201127075054.31174-1-sunshine@sunshineco.com>
References: <20201127075054.31174-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple tests use `rm expect` to remove a file created by earlier
tests. The presence of this file is immaterial at the point the attempt
is made to remove it, yet if it doesn't exist, the test fails
unnecessarily. One case in which the file may validly not exist is when
--run or GIT_SKIP_TESTS is used to selectively run particular tests. Fix
these pointless failures.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t7900-maintenance.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 0246e4ce30..ef3aec3253 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -429,7 +429,7 @@ test_expect_success !MINGW 'start and stop macOS maintenance' '
 	EOF
 	test_cmp expect actual &&
 
-	rm expect &&
+	rm -f expect &&
 	for frequency in hourly daily weekly
 	do
 		PLIST="$HOME/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
@@ -491,7 +491,6 @@ test_expect_success 'start and stop Windows maintenance' '
 	# stop does not unregister the repo
 	git config --get --global maintenance.repo "$(pwd)" &&
 
-	rm expect &&
 	printf "/delete /tn Git Maintenance (%s) /f\n" \
 		hourly daily weekly >expect &&
 	test_cmp expect args
-- 
2.29.2.576.ga3fc446d84


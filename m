Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2209C433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 13:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C436E22CB2
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 13:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbhAWNCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 08:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbhAWNC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 08:02:29 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C684C061797
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 05:01:12 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m2so6589477wmm.1
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 05:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sNPWbhKvtoOtgrUNqPaCjBr5Y4X1dFhd0+qmgkc3PnY=;
        b=GPGCww5vmeq5t/kdTOZfbr0JNxTQiNSib7k0zdyHKstX7kHK4I5V0NQh33cEyCV0E0
         V1DEB47QP2zX3jd/U7aCONXMwTnzasWl7/BMSXxITn5jDDiwZAhLhsJ54D2aiMgGnItT
         AARx452w2bLk0dkZ15FLMliawAasvIsu1dM6jCaKMBxujmizkNDIR9qAszvSRpHmen5V
         Snxb0Zqdp9wiRlP8cKSFdEDp2BWK7+yKmhxr+rzRSyGkjAS8P18FSQhvdBIAhEmEeQZJ
         tOIjRpwZnnxQt1tfMMMEdzol9CRB/fV3Nx/9fCY2k8jdEmrWLIOMw5cH/QmiGqDn70wT
         8DXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sNPWbhKvtoOtgrUNqPaCjBr5Y4X1dFhd0+qmgkc3PnY=;
        b=KOlqg9ubqfgHeKssJhcn8svkkSQIOlQnb7S3E+cqHi5CVgFQ68F3H+gMWjvp2YGLcd
         VJmDent4kzfkrl13l23+y9RQyo7IQeCcSPp3flmHQZHeuIXejxbZLzB3EghVpdnal4nC
         OXpltqV7DTdRM98Yt/1OSml1MQnK2SniWUrJ+gupmSSoZubqjFwypHEBh7LocPUgALJ2
         tGkmauvRdVZjHLeFQam9vBXZJKmKoIVsTnQqXMVXUcVDiFFTcGKEmFw9SHpLxWXJreP8
         UO51Q9ytbAEEaEsjzcVK6iF72+tOTnf8rvqkBUwY+u3qCBGmC8Go1YhcLrZkQtK42jWE
         m+sQ==
X-Gm-Message-State: AOAM533ZzaNCmBf865yNaxBh3eoQHw0xUlI0MEW9ayvgKZ1Kanuir+2q
        Q54OuqkdubhkFD3Edc86om2tF+GY3RLStQ==
X-Google-Smtp-Source: ABdhPJw/UfqGQE4swH0H0ffhV55+L59NO1hZCd5JW5PcpShsXzeXxZ/cGvoI8H6cax93792qj/xNBw==
X-Received: by 2002:a7b:cb4f:: with SMTP id v15mr8144493wmj.123.1611406870535;
        Sat, 23 Jan 2021 05:01:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c7sm16750319wro.16.2021.01.23.05.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 05:01:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/10] git-svn tests: rewrite brittle tests to use "--[no-]merges".
Date:   Sat, 23 Jan 2021 14:00:43 +0100
Message-Id: <20210123130046.21975-8-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <87sg6s6lrs.fsf@evledraar.gmail.com>
References: <87sg6s6lrs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Rewrite a brittle tests which used "rev-list" without "--[no-]merges"
to figure out if a set of commits turned into merge commits or not.

Signed-off-by: Jeff King <peff@peff.net>
[ÆAB: wrote commit message]
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t9151-svn-mergeinfo.sh | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index 806eff4023..c33bae91fb 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -17,21 +17,17 @@ test_expect_success 'load svn dump' "
 "
 
 test_expect_success 'all svn merges became git merge commits' '
-	git rev-list --parents --all --grep=Merge |
-		grep -v " .* " | cut -f1 -d" " >unmarked &&
+	git rev-list --all --no-merges --grep=Merge >unmarked &&
 	test_must_be_empty unmarked
 '
 
-
 test_expect_success 'cherry picks did not become git merge commits' '
-	git rev-list --parents --all --grep=Cherry |
-		grep " .* " | cut -f1 -d" " >bad-cherries &&
+	git rev-list --all --merges --grep=Cherry >bad-cherries &&
 	test_must_be_empty bad-cherries
 '
 
 test_expect_success 'svn non-merge merge commits did not become git merge commits' '
-	git rev-list --parents --all --grep=non-merge |
-		grep " .* " | cut -f1 -d" " >bad-non-merges &&
+	git rev-list --all --merges --grep=non-merge >bad-non-merges &&
 	test_must_be_empty bad-non-merges
 '
 
-- 
2.29.2.222.g5d2a92d10f8


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FA8C433FE
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 12:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241823AbiA1M5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 07:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240647AbiA1M45 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 07:56:57 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD767C06173B
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:56:55 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id w14so9675373edd.10
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a+95XNm9A5lLektt5K3xhCDsbvPOK+8SUexwFRJW0hg=;
        b=DoIniIYcuXtLxuyoRTWA4mRcMOs5fzRaSft3WAMZc6BMCkWrj508wtWlnLx4u88idU
         tJoW8NeAuPelltU8emMq2srpSOzohK2uPhSSQGjK6l3Pn6AkAPf9BS1UUvGdPP0Zku+C
         +UVp62MebQexj0GiA+GvKFYom65FaVVfZDI9+7AUAtdEcVoTvxs9orsKRamGWJYXCeLi
         umWAgkRQPzYyM0Dw3fOEqwD6CWTRG39+BHNFAfgPHTSRIfVfUd2fI9i5trEZwO8LFJDh
         1KxkwQCBX9rZVYQb9UeXewRKWT4+Znb4p1AF91gBnucT3X01V2qGHyivjZN5ND+fPWRs
         Cv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a+95XNm9A5lLektt5K3xhCDsbvPOK+8SUexwFRJW0hg=;
        b=nBywKf9rbo0+teuS20Kous43MG+v82cRcYTBPDW/vwhxte9l3hJ00tX/z2s4NrUNhY
         EHo7a4FDj0HdzmBa3HqndsBCGTdL55Ymu6MwZnoL3ZdECjYeHVqWC061CFXMQ91QlNpc
         AY1Nkn5XtPsnf4ro/F6HcI2nHzsfbRdyG14P/5emUADQYnc8ze0to24BWbX+ojDjQleJ
         yCjCXY/4Y7qqiyfowLZxo0rxyk4tR2/8KKbS6K6/J+UCxhgQM2ivaAXMgdrIgbtzUeBl
         8AJDIgGbYQiZk1+ffJX7Q0JvULzXHx7RhiH9wPQsnWsK9ehJ7d3K55fGDL954FEJvV1o
         xZxw==
X-Gm-Message-State: AOAM530jWQhSBIQXDfqiGyX6bI93B0X7gZ1wyYMgesFQ2NkuohrroMpb
        CW9iR2O9c2x0+XbnbNUFqQwG6AravyomMA==
X-Google-Smtp-Source: ABdhPJyYYIKWSJMW9dmcMVEpnQYHHg6Zxd5xGtH8+6lvTAD7YnkfDFsrjjKd2R/Kx4IoGpA0nW7IBQ==
X-Received: by 2002:a05:6402:387:: with SMTP id o7mr7864230edv.253.1643374614155;
        Fri, 28 Jan 2022 04:56:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g8sm10154691ejt.26.2022.01.28.04.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 04:56:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 8/9] submodule tests: test for init and update failure output
Date:   Fri, 28 Jan 2022 13:56:39 +0100
Message-Id: <patch-v5-8.9-b4f84132201-20220128T125206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.914.ge5c8aab0d5b
In-Reply-To: <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com>
References: <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com> <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend some submodule tests to test for the failure output of "git
submodule [update|init]". The lack of such tests hid a regression in
an earlier version of a subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7406-submodule-update.sh    | 14 ++++++++++++--
 t/t7408-submodule-reference.sh | 14 +++++++++++++-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 11cccbb333b..7764c1c3cb6 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -205,8 +205,18 @@ test_expect_success 'submodule update should fail due to local changes' '
 	 (cd submodule &&
 	  compare_head
 	 ) &&
-	 test_must_fail git submodule update submodule
-	)
+	 test_must_fail git submodule update submodule 2>../actual.raw
+	) &&
+	sed "s/^> //" >expect <<-\EOF &&
+	> error: Your local changes to the following files would be overwritten by checkout:
+	> 	file
+	> Please commit your changes or stash them before you switch branches.
+	> Aborting
+	> fatal: Unable to checkout OID in submodule path '\''submodule'\''
+	EOF
+	sed -e "s/checkout $SQ[^$SQ]*$SQ/checkout OID/" <actual.raw >actual &&
+	test_cmp expect actual
+
 '
 test_expect_success 'submodule update should throw away changes with --force ' '
 	(cd super &&
diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index a3892f494b6..c3a45455106 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -193,7 +193,19 @@ test_expect_success 'missing nested submodule alternate fails clone and submodul
 		cd supersuper-clone &&
 		check_that_two_of_three_alternates_are_used &&
 		# update of the submodule fails
-		test_must_fail git submodule update --init --recursive
+		cat >expect <<-\EOF &&
+		fatal: submodule '\''sub'\'' cannot add alternate: path ... does not exist
+		Failed to clone '\''sub'\''. Retry scheduled
+		fatal: submodule '\''sub-dissociate'\'' cannot add alternate: path ... does not exist
+		Failed to clone '\''sub-dissociate'\''. Retry scheduled
+		fatal: submodule '\''sub'\'' cannot add alternate: path ... does not exist
+		Failed to clone '\''sub'\'' a second time, aborting
+		fatal: Failed to recurse into submodule path ...
+		EOF
+		test_must_fail git submodule update --init --recursive 2>err &&
+		grep -e fatal: -e ^Failed err >actual.raw &&
+		sed -e "s/path $SQ[^$SQ]*$SQ/path .../" <actual.raw >actual &&
+		test_cmp expect actual
 	)
 '
 
-- 
2.35.0.914.ge5c8aab0d5b


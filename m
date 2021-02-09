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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCDDC433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 652A164EBD
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhBIHbB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 02:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbhBIHae (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 02:30:34 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCFAC061794
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 23:29:18 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id j11so9240149plt.11
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 23:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AKVyUTQ0PTfwwq76gRTHowmfpb1YnfKrY/iiF8w8GJ8=;
        b=u2GWuPcc2N9TI6iQAkS8uVR5uaPNta5x2M3jtTt2FGovjUgPVevUMYEZrWk1Wtw7hr
         9tFdthLHBa7MFLv0ho3bHBNGm0u+2OUCM6FxrHGe/fOpuRbp317D4ZmRbIVPx4YXNvlI
         miXRRn/9YNnv1xGoP37YSULvsEu6mZGIo7Z7DsdbeXCaJXWWvYJAsAF5M2VGvcTvCqR3
         ae2tDg9PVO27Pmmm1jviGWJVBKi6XrjZpJCWbPgHOsMk5XJiAlDitiro6MpiHx8nWQu8
         muQnPV/DfstYfZkUdgWQJgXU3TUEytQXvRjSuplwNcazeSqDpywkfPfGvdxnXM/agPGX
         H0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AKVyUTQ0PTfwwq76gRTHowmfpb1YnfKrY/iiF8w8GJ8=;
        b=k1snr4hOWIkszzdcE7vbanhMhQ45dQ9LCP8AMbfXMAnStQEAAtMVkYnHBldwiIIDFG
         Q468H19JTvyC71kcxNYvMfHQd2F5kn6h4uLJ5iQjlfig6eDPhDIprOIT0/i87J3uX5aT
         rlwivz1D8rYnMd9zBNTGM5KX8X+UThAo1B5WJLsYctHMsKgpIr0z9X3pNlsLnvdPxBcz
         lW1X4PM8dsr2DpRQK8y3Y5SGiaWliMIhCfpWOYUwLrNMKU2SxPKu4tq7RUW857+u3ax2
         h4zX6D0hTCWmABaDYqrilJkGKwudh9AbrnfdE8R9q4OtUjWr0TZ83K3TTD+0X4Uuwrwa
         YrSQ==
X-Gm-Message-State: AOAM532BznKApUPWpJYF10dsujcJaQBPxAv6RFAbf+eGnYEwzU06SA5o
        TsCiV7+2xyxGrh2oY086lvAT+A0ZxG0=
X-Google-Smtp-Source: ABdhPJymEifGYzXapjhqwpfTegG6Vm1gXqE7uVs0sv9nNHjdpa3qVo4kbHC4OHJmjocF1fXI4SOypA==
X-Received: by 2002:a17:90a:3fcf:: with SMTP id u15mr2862400pjm.127.1612855757845;
        Mon, 08 Feb 2021 23:29:17 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id w4sm5670443pfn.45.2021.02.08.23.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 23:29:17 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 6/9] t3905: use test_cmp() to check file contents
Date:   Mon,  8 Feb 2021 23:28:52 -0800
Message-Id: <80194bcfa5bc250e64a0d197790dd8eac93d395d.1612855690.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <cover.1612855690.git.liu.denton@gmail.com>
References: <cover.1612258145.git.liu.denton@gmail.com> <cover.1612855690.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Modernize the script by doing file content comparisons using test_cmp()
instead of `test x = "$(cat file)"`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3905-stash-include-untracked.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index c87ac24042..b26a97aef4 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -103,8 +103,10 @@ test_expect_success 'stash pop after save --include-untracked leaves files untra
 	git stash pop &&
 	git status --porcelain >actual &&
 	test_cmp expect actual &&
-	test "1" = "$(cat file2)" &&
-	test untracked = "$(cat untracked/untracked)"
+	echo 1 >expect_file2 &&
+	test_cmp expect_file2 file2 &&
+	echo untracked >untracked_expect &&
+	test_cmp untracked_expect untracked/untracked
 '
 
 test_expect_success 'clean up untracked/ directory to prepare for next tests' '
-- 
2.30.0.478.g8a0d178c01


Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A1DC43457
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35A4722257
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzqoS2zH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389040AbgJOB7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 21:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388202AbgJOB7i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 21:59:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96975C0613A5
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 14:13:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 13so890368wmf.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 14:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CzrCPnbUvNSakWF2bvkdGZ4dwzkAgsYCMdLnhb7Mw8c=;
        b=PzqoS2zHZ75nSP6bMsUYtHOAyOqHVWBTvKhTNJH4Vtu2pbj42Zr3udgYvajsLjcaYs
         S9MSI+iUJOARQqtzEec/oSoASo1gknaoa2T6RZEMEv5IXR0G4syon8n72Ob/IWMNQfSz
         GoahpTf9/gwbiwOFDgC17mwTjWh8OJA/5gpqiAzwjkfucQE0p7Sj/Oq54h51s1UrXmu8
         W0sM2PGhqn5S3/GTQ4cnHqDiCvzSXygCu9+19IO3EFiWDm9oLW1OloZ/m2l1PGN/Sk5O
         zSEArsNQfiaEwpo3eqDujp1FndjPfEDGPVDpxwYwdXTC3inN1P/Xjdsi1GaP/yBoRmKU
         zE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CzrCPnbUvNSakWF2bvkdGZ4dwzkAgsYCMdLnhb7Mw8c=;
        b=efAhwjpt6XhuLqsOatoHvO436mU/Tnkt7hRFtuICZVA4iuIlB2xBukR4DWk3aSBmYq
         hO1bQEW4gmzn2gUhUqKkir1vYXn5B7i+BCZ4iERHwamH8X4t1oA8W41NCU/xD1maHexP
         1W5J3xPKEUhZbvaHlJHN+zgyx7fl17iN0XkKaQAkfkGMsQn9FKm/9skmmexjkItsyyrF
         qax41WUVo2hLR5sIsvb7ZV9kcQlTikAB2X0HnONIvIuNtfJcmEAaOr1JGXv1XkYJIhuS
         /0BGrgCCYgC924lSqsaiE3YW2zcpxXbVzoXlfMj9w8zRmpXpoA4f3v1ZwOpYNpCaPRf4
         kp2A==
X-Gm-Message-State: AOAM532Phox0dEOapxm9OyQnxJRkWe+zk0/DMmlkvHVMaTEjaW+tFTOx
        SR8VY14cJmv+6KIhwQzF77a5EsvTsRk=
X-Google-Smtp-Source: ABdhPJzrkYTQxZ9o3oGUuUvFdHdpzCSroVC/tyxOEUZfCi7myz4ixZDg7qWAphOunDaRghviqVev9A==
X-Received: by 2002:a1c:f414:: with SMTP id z20mr701752wma.110.1602710028239;
        Wed, 14 Oct 2020 14:13:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s11sm814265wrm.56.2020.10.14.14.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 14:13:47 -0700 (PDT)
Message-Id: <6479d73603d538d2b97d209eec5c5e570fde1269.1602710025.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v3.git.git.1602710025.gitgitgadget@gmail.com>
References: <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
        <pull.878.v3.git.git.1602710025.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Oct 2020 21:13:44 +0000
Subject: [PATCH v3 2/3] t6006, t6012: adjust tests to use 'setup' instead of
 synonyms
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

With the new ability to pass --run=setup to select which tests to run,
it is more convenient if tests use the term "setup" instead of synonyms
like 'prepare' or 'rebuild'.  There are undoubtedly many other tests in
our testsuite that could be changed over too, these are just a couple
that I ran into.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6006-rev-list-format.sh   | 2 +-
 t/t6012-rev-list-simplify.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index bc95da8a5f..99a1eaf332 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -339,7 +339,7 @@ commit $head1
 .. (hinzugef${added_utf8_part_iso88591}gt) foo
 EOF
 
-test_expect_success 'prepare expected messages (for test %b)' '
+test_expect_success 'setup expected messages (for test %b)' '
 	cat <<-EOF >expected.utf-8 &&
 	commit $head3
 	This commit message is much longer than the others,
diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index b6fa43ace0..7254060240 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -168,7 +168,7 @@ test_expect_success '--full-diff is not affected by --parents' '
 #
 # This example is explained in Documentation/rev-list-options.txt
 
-test_expect_success 'rebuild repo' '
+test_expect_success 'setup rebuild repo' '
 	rm -rf .git * &&
 	git init &&
 	git switch -c main &&
-- 
gitgitgadget


Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63691C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31CB220738
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCKUMmI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgHCSlZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgHCSlY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:41:24 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4DAC061756
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 11:41:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k8so551726wma.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 11:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fvsCY/LQLBO1naRThY5dZ2dM+VjRgURHHXEDtpLNsMI=;
        b=vCKUMmI3IQTTrw7Y8gAVYIX/3JQbXhPKL4kewmrnN1Sc3DVPas9M8U15562VRZAlEf
         2S9sRoBeLvRq8/wZ42pLUHHBBwU/srUbfood3wJ8WWh0Yg4+ZRobGgyXb+oYnXqo+SQq
         9dwb+03HSxgA8lsKHdU3fAUqN36bWH29RjFyUMU2DVB/r/tCSq796oy3+EmsqRwTjRaa
         WkK/Y8Wmax2g/ozeufFyWHs4Y21w7H6jmnn8hwoVZETlqHlbfa0AVPX1y8Jed63VbeT6
         s+2sEJlF/2MpvQHnpmE/5ePpww7GlR6ip2RJdSYYMjhZqNTDjDK9noVpDeUWTgznrnzn
         R6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fvsCY/LQLBO1naRThY5dZ2dM+VjRgURHHXEDtpLNsMI=;
        b=g4eYI+7t1n1kUEYY9BBO6IxU5jGIumgyfgzFvRfLbrbD3l9BH1jv4UCdiQRwbO8bm+
         udhHx231dX3vxwr9NFELjhQnPiAo/UQkE0JrQogOR1osW/0BvMXnzQ6ZBnR5Sxd5xIuR
         OQnn0WYc4T4TqDDGYNjSDSzChCsmFb8VRg42H5gMBRXfsax8Qppg1yuG7aRI7/Xn89wL
         sNYWFg0kABIIjZb0H/yEb5o+/hZJP3l34BcJyqsVvHtVW4NKs1iqgTi53Sqh3MoQxfSK
         R8Bt28iEJVVnZPvFkycNsJessmbUA9fwIjv00uB6Tdj4EjxXrF/NEdl1zSZ3BMTkztIp
         hPFQ==
X-Gm-Message-State: AOAM530FbZDHKpcWvORajEZpwRnXMBtG19XsIQ4MDGtnaUJEH3OOFFz+
        5xFw9bvpLsTLxtHGqADcAzHWg77y
X-Google-Smtp-Source: ABdhPJyTXRy9FQdaKt4Zb28lpps8HQJ1oXPmPEjGl3g6ikLYkGwPPEg7s82lPsAhKlrEcHMDNraETQ==
X-Received: by 2002:a1c:32c3:: with SMTP id y186mr477086wmy.15.1596480082741;
        Mon, 03 Aug 2020 11:41:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t13sm25274077wru.65.2020.08.03.11.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:41:22 -0700 (PDT)
Message-Id: <21033c4c1455bb1e0bd996a5861cc9414912768f.1596480080.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.825.v2.git.git.1596480080.gitgitgadget@gmail.com>
References: <pull.825.git.git.1596349986.gitgitgadget@gmail.com>
        <pull.825.v2.git.git.1596480080.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Aug 2020 18:41:17 +0000
Subject: [PATCH v2 1/4] t6038: make tests fail for the right reason
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

t6038 had a pair of tests that were expected to fail, but weren't
failing for the expected reason.  Both were meant to do a merge that
could be done cleanly after renormalization, but were supposed to fail
for lack of renormalization.  Unfortunately, both tests had staged
changes, and checkout -m would abort due to the presence of those staged
changes before even attempting a merge.

Fix this first issue by utilizing git-restore instead of git-checkout,
so that the index is left alone and just the working directory gets the
changes we want.

However, there is a second issue with these tests.  Technically, they
just wanted to verify that after renormalization, no conflicts would be
present.  This could have been checked for by grepping for a lack of
conflict markers, but the test instead tried to compare the working
directory files to an expected result.  Unfortunately, the setting of
"text=auto" without setting core.eol to any value meant that the content
of the file (in particular, the line endings) would be
platform-dependent and the tests could only pass on some platforms.
Replace the existing comparison with a call to 'git diff --no-index
--ignore-cr-at-eol' to verify that the contents, other than possible
carriage returns in the file, match the expected results and in
particular that the file has no conflicts from the checkout -m
operation.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6038-merge-text-auto.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index 5e8d5fa50c..27cea15533 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -168,9 +168,9 @@ test_expect_failure 'checkout -m after setting text=auto' '
 	git rm -fr . &&
 	rm -f .gitattributes &&
 	git reset --hard initial &&
-	git checkout a -- . &&
+	git restore --source=a -- . &&
 	git checkout -m b &&
-	compare_files expected file
+	git diff --no-index --ignore-cr-at-eol expected file
 '
 
 test_expect_failure 'checkout -m addition of text=auto' '
@@ -183,9 +183,9 @@ test_expect_failure 'checkout -m addition of text=auto' '
 	git rm -fr . &&
 	rm -f .gitattributes file &&
 	git reset --hard initial &&
-	git checkout b -- . &&
+	git restore --source=b -- . &&
 	git checkout -m a &&
-	compare_files expected file
+	git diff --no-index --ignore-cr-at-eol expected file
 '
 
 test_expect_failure 'cherry-pick patch from after text=auto was added' '
-- 
gitgitgadget


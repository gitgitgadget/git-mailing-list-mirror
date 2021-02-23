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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90261C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66EA064E6B
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhBWUPu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 15:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbhBWUPe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 15:15:34 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE344C06121C
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:40 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o10so2200318wmc.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l5letMvz1wyLqoALj2Ll33jDZAuVfmkP2dhyJYF6caQ=;
        b=YDnP04Xrgwgas+oYYO5grnIXcnYUBXHBdDDYcubDSjGKMzAggRNrBfhNAqWpOc4gE9
         Pe8+lLjkXKMijwTFwyRB+suemuNXgYVJquCuXM7me9JBuhmzCfKDQJeJ4wQv2efY+GXY
         Fnx77E6xWfu0CqHxXmkyTENiPeoLWojkIEUoxlvLg3nK9ZDqQPxxXlkivU9AYcF/Bv6r
         f3kxunJ4BlZ/H/LJdfgZQYF7faSdM5ht1LVsqLUCpn5Y+gmUadbpm3UvfiA/h9631XyF
         mO7QeUIuS/hRdN0RFzopZwX5WdTNjTqh0cT7Ltt0xftMHSEK6dtmOf68NKi0cHs2ghUx
         ZHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l5letMvz1wyLqoALj2Ll33jDZAuVfmkP2dhyJYF6caQ=;
        b=hNxptRaBEo5EShp8J4capSN42UDvyAnK40O2ETcN0vq6V2TFWEdoVtkV58/W8OLNsK
         M7Zp64q+1Nsq+2ooc+fc8/srrWUoRFRCmTFsYJTo3DoXGxEY7pQUBtZppoynWTCwO9ra
         cH7UTF22ddDJNM9Z41JGt/gWynRX8CaefeQZVXcVN/VAVKURXVNhPdCJfr2vzwvpiF6I
         X2BGUdhr5E0NYegO752R3HjuiFt7e2t4KzexIZIOuGDN1k1Kl4PSMyFwjRqRj7tod6bO
         u87mTscJbzJiY7eSSEojMs0hUvD7EPpQ+UlY+t88HrdL+zCzxk/Rv6XlSKESUjOG2d7h
         TaBA==
X-Gm-Message-State: AOAM532x1YdgYI/CShyXpUX1r+rFEMk70YToISy39FVV6R4wKzXaM34n
        xxqCKfGTTwRuve2xB1P2HKErMsoNcjY=
X-Google-Smtp-Source: ABdhPJzt5oSq4JZVMGOK2W1tkhWt9SROF7dNJYaiuN4MIHgAMa94H9171D2s/ijvcSWadpo/4GOPnA==
X-Received: by 2002:a7b:c18b:: with SMTP id y11mr427884wmi.132.1614111279621;
        Tue, 23 Feb 2021 12:14:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 2sm33287320wre.24.2021.02.23.12.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 12:14:39 -0800 (PST)
Message-Id: <7d4627574bb8dc3e3a6d0ebd62dc2855ed61a904.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.git.1614111270.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 20:14:23 +0000
Subject: [PATCH 14/20] sparse-index: check index conversion happens
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add a test case that uses test_region to ensure that we are truly
expanding a sparse index to a full one, then converting back to sparse
when writing the index. As we integrate more Git commands with the
sparse index, we will convert these commands to check that we do _not_
convert the sparse index to a full index and instead stay sparse the
entire time.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index b38fab6455d9..bfc9e28ef0e1 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -391,4 +391,22 @@ test_expect_success 'submodule handling' '
 	grep "160000 commit $(git -C initial-repo rev-parse HEAD)	modules/sub" cache
 '
 
+test_expect_success 'sparse-index is expanded and converted back' '
+	init_repos &&
+
+	(
+		GIT_TEST_SPARSE_INDEX=1 &&
+		export GIT_TEST_SPARSE_INDEX &&
+		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+			git -C sparse-index -c core.fsmonitor="" reset --hard &&
+		test_region index convert_to_sparse trace2.txt &&
+		test_region index ensure_full_index trace2.txt &&
+
+		rm trace2.txt &&
+		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+			git -C sparse-index -c core.fsmonitor="" status -uno &&
+		test_region index ensure_full_index trace2.txt
+	)
+'
+
 test_done
-- 
gitgitgadget


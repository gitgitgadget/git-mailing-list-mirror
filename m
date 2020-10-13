Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C050CC433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B760208D5
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZQBndSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgJMTTz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 15:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgJMTTy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 15:19:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4D3C0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 12:19:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h7so709416wre.4
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 12:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R09JXklHb8YizcU80FIgE+G/eYi/IPb9/aJRu6H3vcw=;
        b=jZQBndSSP68vAjkPbbBUYyNdXoFrAhW9UjEEQEIj++JdW63M1CBkBjxt2h6Ua3TCr3
         IfBFz2BWFKgmeiXfqLf1mp7Sz2q8UTur8WGWsjN8m25VcdwC9iDCVoBsokcah4YGG+uT
         ksNVVNSJHavGLrPQJlRU9OjVb2iuJKHYR1PoWGbLyaWZtjhcIaFv3idyIGWdYEUMQb3S
         Ik/0r//cXuuOgsN5tnlrHrunbuq7fa8DwNJKWckYLM4DXJpZdp+KFWC3k5blnndI0v6X
         M+HsoxGHng8jBS0MbWIkTtJoiLDPpeV+ne5Yal544Z4gpdz8CtzgDM7REaCviaoidKRq
         sT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=R09JXklHb8YizcU80FIgE+G/eYi/IPb9/aJRu6H3vcw=;
        b=IiFUlO7KPSUeAwV9cOFOZ4u4eTQaQzPWyKCfvw+SRX599qjVFF1/WdD3vxC7vUUaVD
         hSUgP8TSPb9EwkZGBf+V6OxtKMBpCPOadzT6kXyIPaSn4umLAkhn4qjhkzGKrKHKpuCZ
         d6kbrHE75PqzFjn6rBeSqMAclzGYSMQVhqO0xBPGbXkJg5PsCq/SZDavxoMzJNoXAFad
         QyUL8FIMAi7iYbBH2LEjE9lDyWBXaY/UtzaqEg0yj67/nK0HqhJs6jJ5aQJLJI+MzViY
         obZnLLSo80FxQVVmGxJfLjA2yFGikdZZ/3e1Eh3kXzO2wyke9hGfrzfLBi0gNf1Q4TMN
         hdxg==
X-Gm-Message-State: AOAM532jcrVz46zskFvEPLkj2H7lrFHfe8hTdwwYiXOvta6kAOrRe1Ew
        zlnBB3zYPYHvoK7U7DVLXleGlxJs9GI=
X-Google-Smtp-Source: ABdhPJx2oxjEP73hNUJny19nW5RznPuWeJkx1TNME8wE22SeMicaqKB0iv63aT4H03SucBXy/vb8aA==
X-Received: by 2002:adf:ca13:: with SMTP id o19mr1319143wrh.206.1602616791198;
        Tue, 13 Oct 2020 12:19:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q5sm692651wrs.54.2020.10.13.12.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 12:19:50 -0700 (PDT)
Message-Id: <85a4ca164a9f665016d4aad0f29cbef6f62f36b0.1602616786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
        <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Oct 2020 19:19:46 +0000
Subject: [PATCH v2 3/3] test-lib: reduce verbosity of skipped tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When using the --run flag to run just two or three tests from a test
file which contains several dozen tests, having every skipped test print
out dozens of lines of output for the test code for that skipped test
adds up to hundreds or thousands of lines of irrelevant output that make
it very hard to fish out the relevant results you were looking for.
Simplify the output for skipped tests down to just showing the one-line
descriptions.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/test-lib.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2aca398e1e..fe81d9c733 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1059,7 +1059,6 @@ test_skip () {
 				"      <skipped message=\"$message\" />"
 		fi
 
-		say_color skip >&3 "skipping test: $@"
 		say_color skip "ok $test_count # skip $1 ($skipped_reason)"
 		: true
 		;;
-- 
gitgitgadget

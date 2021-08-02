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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F03C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E10BA610FF
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbhHBQxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbhHBQxu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 12:53:50 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72E1C061760
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 09:53:40 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n12-20020a05600c3b8cb029025a67bbd40aso4041919wms.0
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 09:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o9KVw4pEzNFeWgplGe9YGi9/mdHySu7RVQZAxi7KePI=;
        b=CFwV6BbyogJ3B8UnoZqzokq+AiHaxS3oV0JLjiTJXuIAM/UuEVT2kZQzAJD2O2PNU/
         5vU5XuaYy1QootesEONoI2iej7iW5j2hmvonzXLrHx/+BRx7N+DetOCKbau+goHJoyKm
         +UvGF/wG8jkPt8/GE9fZZQVA/3lJVlxn0IkQK7AHqLTWo8d4u4u4J2Wl0l7juh3hqgmQ
         kmVITX7nhRGcB/vwmsuinJjTdmwU3NzW8TO0MuinxNV+q/yWhZWw9f7uPxV6aKN2KzIb
         wrP3Bj/0R8rVk57gdQiqGNzu12SKxAQYVZTa53+0S6cstDMgYTmjUkyqmibKDOg5HIzd
         LUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o9KVw4pEzNFeWgplGe9YGi9/mdHySu7RVQZAxi7KePI=;
        b=J5W3w9S/CtlziHlNYM1X57NksD9a3bKu7fKV1mDXOxgyK9alAa/367uaci3lKiAqmG
         Juc8YbHDMudAKOOK/Txt1N+S7oB2GlF1AgUG41ObwrBiBlj0l2mfuNvHxpR67/LjXGgD
         /Hz7ruKZ8rbQ9QLyEUMYZ5Jo+ZmrV7gBKVyfRjVlgcHANlG8bk6KO46efqpPzhtTh0He
         nfoKgoidIHEZyvbn1GVsTW7qaF2zaHScunOcPr9sofqWmVON9DiGSOllBlcxdnsQmtcl
         WtpRHj5trURHVHlXtABCCyxZ4iReU/MPm5RdBvREqprVtT/h+JJVTibxPdyYf4jPjnEE
         kt/w==
X-Gm-Message-State: AOAM532+QSI6duhK4bV8ByPTFWtqk7vvbPlVRhUEiFWjY1/Zpz37FFOb
        AAqAMrlQvp7SRlwAqwrzATwV0YnuS7E=
X-Google-Smtp-Source: ABdhPJyMy3YE71UCMSbtN74wBxEB2mDhGJNTOT45/i1VYTIuqPLnEeBQjKTQazYGMgW/eqZfYyhV7g==
X-Received: by 2002:a1c:1b17:: with SMTP id b23mr17756871wmb.178.1627923219393;
        Mon, 02 Aug 2021 09:53:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q5sm12264107wrx.33.2021.08.02.09.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 09:53:39 -0700 (PDT)
Message-Id: <b62c3175c4c86a3ae3a2a748dd1311306f1220ca.1627923216.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
References: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
        <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 16:53:28 +0000
Subject: [PATCH v3 03/11] t6120: use git-update-ref rather than filesystem
 access
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t6120-describe.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 1a501ee09e1..bae2419150b 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -107,7 +107,8 @@ test_expect_success 'describe --contains defaults to HEAD without commit-ish' '
 check_describe tags/A --all A^0
 
 test_expect_success 'renaming tag A to Q locally produces a warning' "
-	mv .git/refs/tags/A .git/refs/tags/Q &&
+	git update-ref refs/tags/Q $(git rev-parse refs/tags/A) &&
+	git update-ref -d refs/tags/A &&
 	git describe HEAD 2>err >out &&
 	cat >expected <<-\EOF &&
 	warning: tag 'Q' is externally known as 'A'
@@ -135,7 +136,8 @@ test_expect_success 'abbrev=0 will not break misplaced tag (2)' '
 '
 
 test_expect_success 'rename tag Q back to A' '
-	mv .git/refs/tags/Q .git/refs/tags/A
+	git update-ref refs/tags/A $(git rev-parse refs/tags/Q) &&
+	git update-ref -d refs/tags/Q
 '
 
 test_expect_success 'pack tag refs' 'git pack-refs'
-- 
gitgitgadget


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB61C433E9
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0391364FD7
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbhCJTbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbhCJTbR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:31:17 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF54C0613D7
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:17 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i9so86874wml.0
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l5letMvz1wyLqoALj2Ll33jDZAuVfmkP2dhyJYF6caQ=;
        b=eO9oVswDGiOvcSQFiLwYwYKlRB7RiO7+pn/BUDAzEKeB3KKceL6G5gtsRr+l8sz4J6
         QJip6VfBQTCflrynbrea1YNAb5V9cult/Z0SJO12btOiG7CCIubc4YDJFZRiwnUVYgnG
         tnzlIZ9uYCA8pQFGDL87uQJkj2jrf4o+L3v59TD22EnTOr/v4O/FnGM4ZfWzT0kTcxC2
         vtuQ4KHQIHtCAzv2Synb01/wHKQ0Gz8+/z4Sq1ZoF+9/QmHNchMyXIGdTKONQ4rYwu/f
         oFe1vTJxzkPjA1n10n89giMXrqKEYufFDyaYrTyUgM55x3RZwT1+mLysr2E6i2+X6HEU
         K+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l5letMvz1wyLqoALj2Ll33jDZAuVfmkP2dhyJYF6caQ=;
        b=MQWmNAPNbEFUorHEnUwk83tpHpr21qBoJmiQ+L/dWCqjF2dLHHzVSGcJ9/QkKf+0ke
         l8rofZN10x66v5tjB14YGX+NZ6AScYFLaBCUF7wlIjT6VHQmKzEAXOGObwAm65FFN8pS
         BiFcHMglDrSHhmf+yw7SJFiE5o9sF0WmzonOsyz8+9rzI752TladdRHu/tzb3OXeExmg
         nX+vDvM6+j+D/98nQdvCwx2Gnts06N5NK082OfmbwQ/PZhFwUg3yYqZyft0jp56V5SCz
         Z3FuIaYyB39KCkcLegTUvB7caqOuDNo1klTXWHt7UFNTzxN2tM204oqHBMl3dtqpyIoD
         +p/w==
X-Gm-Message-State: AOAM533wxsUp/F+I/7Gi1p/9/x+6JgbQvSjSSCXjyGs7aYSghQhoey42
        icFlfQoFtGFwJT9j2OEfrEsH1hYi3KM=
X-Google-Smtp-Source: ABdhPJwlzyLmX/SlJoYwb4t81Bw7Pivd18eVcmXQe/Dn0Yfc0PVyy0LVX7YKJUGAvd0FtrHO342XVQ==
X-Received: by 2002:a1c:730a:: with SMTP id d10mr4750196wmb.53.1615404675913;
        Wed, 10 Mar 2021 11:31:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u4sm368191wrm.24.2021.03.10.11.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:31:15 -0800 (PST)
Message-Id: <3fa684b315fb02f42481182a986557e47a8cf0fd.1615404665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
        <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Mar 2021 19:30:57 +0000
Subject: [PATCH v2 14/20] sparse-index: check index conversion happens
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
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


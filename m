Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E64C4332B
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB5564DDA
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhBOAyi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 19:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhBOAyY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 19:54:24 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8217FC0617A7
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:09 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v14so7147844wro.7
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ca81a69vSZMc+hY33cfPcj8Z31zp+U2B5/P9EoRn8Mc=;
        b=czrVOczpf46IV7e0lxujmHzltvUkbQHyqHaV5yvyR+wxsQZ/1vx3l6CgvWGFnGGq4P
         nnw7HAGsRHIXjGUxOGScvPTbeuZXVxwCPwkhNTrqhkc2al9mUiSa3XIMp6+8N8xH+JR/
         wRqshYQ3jryUx+/GEOKmbhN++H9OQ4IWYK5Xqf6vIRz55EKUDiQmYfYiviEprk7Yknal
         Hwyu307CXV4NBzDwv9A2ZJO7FPlSXeaBJnSmX3vUxMuKt0Oo/rQXIxRAPji/5soFn6M7
         72GBnBuaWCQYsEWsXbr/A8PUtEak2kNyeO09uefhEfu86vk8X1YcIZs4XYeJb6PiUciw
         7ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ca81a69vSZMc+hY33cfPcj8Z31zp+U2B5/P9EoRn8Mc=;
        b=Yxik9TKiyHFvAsmFYuTKtYdQ9kKv2IzC5QRxVM4c+AKNgwycdxXUeyDXf3lRe0YoA3
         tzWhwSmIFnlIoiHvjwKl6A2WX78vQpykxo2mSayijoWBiAVYJGScRybhwhft37c6vXg7
         zW3JIzxs+BfbTMOs4+2kIhT8SX1Y7z3Va6HjMFiBPCy2Ie86aRzQdIlJUCveK8K4kQ1n
         6g/O00k7az3x1cER7o9XK+3C7XrwRzVuKpeOE8yWHf4gE6lZEUYNU+bc+1egOvANBw3W
         pJrEBJOc0BdxK7JQFgmjR6RBThOy0z3aD8v8xRdaJv7U1D9rEifooM4ay+oIkRe+pdEk
         lvhg==
X-Gm-Message-State: AOAM5319lyOC7QSa3MALCYRQZpwT2stKpK+v38I1USNekOklp6xHByHg
        xEGLOWEtxsMlbSDFYPvSrjT2fq9hstSl6Q==
X-Google-Smtp-Source: ABdhPJwu3W+JLJY7i8HLnMM6rWVuH+vmXwSPa/k+7q0pOTI75BX3AVnqsqQWLwBxav1z/hDmq4xiEQ==
X-Received: by 2002:a5d:50d2:: with SMTP id f18mr16819221wrt.338.1613350387991;
        Sun, 14 Feb 2021 16:53:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm5209832wmi.2.2021.02.14.16.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 16:53:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/20] userdiff tests: remove hack for "RIGHT" token
Date:   Mon, 15 Feb 2021 01:52:27 +0100
Message-Id: <20210215005236.11313-12-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87tuqebj6m.fsf@evledraar.gmail.com>
References: <87tuqebj6m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the "RIGHT" token isn't how we select the desired hunk header
line in the test anymore we can revert a hack added in
f1b75fbaf1 (t4018: convert custom pattern test to the new
infrastructure, 2014-03-21) and go back to the regular expression we
were testing before that change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018/custom.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4018/custom.sh b/t/t4018/custom.sh
index 69f1f7339f..20abb38451 100755
--- a/t/t4018/custom.sh
+++ b/t/t4018/custom.sh
@@ -33,14 +33,14 @@ public class Beer
 EOF_TEST
 
 test_expect_success 'custom: setup match to end of line' '
-	git config diff.custom.funcname "......Beer\$"
+	git config diff.custom.funcname "Beer\$"
 '
 
 test_diff_funcname 'custom: match to end of line' \
 	8<<\EOF_HUNK 9<<\EOF_TEST
-RIGHT_Beer
+Beer
 EOF_HUNK
-public class RIGHT_Beer
+public class Beer
 {
 	int special;
 	public static void main(String args[])
-- 
2.30.0.284.gd98b1dd5eaa7


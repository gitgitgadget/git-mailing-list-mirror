Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1882C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCC6D610E9
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344697AbhIIOZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243429AbhIIOZw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 10:25:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9549C025272
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 05:59:17 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u16so2444944wrn.5
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 05:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FbVkF41jm4pnO5owJK/DNG+XAaZvAE6vLUTYAhzZcjw=;
        b=FiybDf08SjqQZJVdrJiHxp6lfnU4Kqft4V9M4y3BM+/JbGIWlj1Psg9FS4FkqsxymW
         Ub1OZ+W6kloOHcZNMz5EjL4GoutTe/C5oV5ILR93dPENuQwJBmhddFiFvbZjIakU1f78
         omLdaW322BSRzfKbxHbAFDp7wucwLjhAv13wA0kyfT5eVTiL2QFmUHt/t/McEsWhwGaZ
         dH19kbd/o56o+Z5EkUdM5XGV2+1KeoGIgKAGGD0hzkvX7IScZBEXLmfazt+HBmsNcLqZ
         FRE/rcmO7AmltGbMN2b58zWtkkhioAYfk3qrT6NrMRSjZR3fJ8ZJYKuXSeRKaLp4T2eh
         Ep6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FbVkF41jm4pnO5owJK/DNG+XAaZvAE6vLUTYAhzZcjw=;
        b=fJZ2YrxCx0sWCS/d5Zgqin7phpLhvMiieI6bN3gx84FDByCBu6r5mxr2W2VkzOMxY7
         gwFhn6Oap418HtLUGJlx8zbNvC75HsjfYW33+/ri92GZiztJ63vtZQ2LX+ADZ5sbbx74
         PpOI7Ad0Pc1KjtXegOaM4gVxii8vV7B/aZtcM+S3zUkTphVgMDZ/pveJo16T4m8S19+f
         /fwv65F0UehIu8iL1kZZVEdNM281A6gguUGAuVvtf1Sx8wgn1U9Hb4SsId3bacppW3tz
         gvKJV42JQclPsRagqCKcFyEIH7Yab3j2z4jeZUpJ8wx5dDVm3nAxhMrH4dxtRxR9rI/q
         eSVw==
X-Gm-Message-State: AOAM532azzjLE47TN1udCTK0kC+Uxzc11X6SO0AfCUOUMhTHAvLMdSL2
        a2O1HkhecDmrNZb8JFqSUhs2Zy+sBi0F+Q==
X-Google-Smtp-Source: ABdhPJyOsmhzHwEes7RGcVCTgfX3RKYzoNXzzrOvEjTg+x9TCInLR3HvLm7yy7w4lxcv2ilC5ngzVA==
X-Received: by 2002:adf:e101:: with SMTP id t1mr3434040wrz.215.1631192356282;
        Thu, 09 Sep 2021 05:59:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c3sm1807138wrd.34.2021.09.09.05.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 05:59:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4] fixup! hook: run a list of hooks instead
Date:   Thu,  9 Sep 2021 14:59:14 +0200
Message-Id: <patch-1.1-38b21b65bee-20210909T125613Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.867.g88ec4638586
In-Reply-To: <patch-v4-1.5-2f0cac14965-20210909T122802Z-avarab@gmail.com>
References: <patch-v4-1.5-2f0cac14965-20210909T122802Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---

And of course just as I sent out
<cover-v4-0.5-00000000000-20210909T122802Z-avarab@gmail.com> I noticed
that there was one last memory leak left, it just wasn't stressed by
t1800-hook.sh, but some of the test of the tests, including
t0000-basic.sh!

That test coverage should be improved, but in the meantime Junio:
Here's a fixup to the just-sent you can hopefully squash into the
1/5. Sorry about the screwup.

 hook.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hook.c b/hook.c
index dc3033cb4c7..4b4205bce6c 100644
--- a/hook.c
+++ b/hook.c
@@ -416,8 +416,10 @@ int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
 	 * If you need to act on a missing hook, use run_found_hooks()
 	 * instead
 	 */
-	if (list_empty(hooks))
+	if (list_empty(hooks)) {
+		clear_hook_list(hooks);
 		goto cleanup;
+	}
 
 	ret = run_hooks(hook_name, hooks, options);
 
-- 
2.33.0.867.g88ec4638586


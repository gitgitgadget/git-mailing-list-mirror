Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC5DC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15CFF610A0
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345137AbhIBNNo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345153AbhIBNNG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:13:06 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3092BC0612AF
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:12:04 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n5so2832443wro.12
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rGCm6nrGmv9HCK/cM2iwIEMU+OTEATUQPfDN6FWPKjA=;
        b=i2CHxPsH9PlRK9AfAQvp+7sG8HnIqY0fZbynIY/QX3iP0/5pH9Lu6hZi6Eq+aGjwsq
         Tm/5VrogF2S/cVyN/qOkExPf1Y02TF3gV4XCVOBgbkwDsXLto7CmzXpmM8jwCTMoRe1/
         63ZVHzfXTyY44vnFn/rJqRrFs7/pIok/kq3LM0NrHuZPOjkdkjmMKRsh9YCWZMQ5DpvZ
         R3WqsGSxsFzynMhPxD0b4h+tkkLyy7SMopxVBZGUgDI7wIrJJqeNEuERN/5tGErKmx/x
         pxwQFEWgav4+88rcHhtriZgV6pabkmMPQugZyDrEp0NgEBGUOD30WmhRyH+fGOScqMHz
         /pUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rGCm6nrGmv9HCK/cM2iwIEMU+OTEATUQPfDN6FWPKjA=;
        b=rnqJnPlP5lZeJOj7NZ6m7yx6zsgVZ4qyXkNZXDusjlX71bsfUuujaDRzXW28lzPzsr
         /D2Akt96YpcXSP1yx0ePRaQmsNG4UzqqSbNnsprlfX/z/HY8F4DQkZGpNliRHojGplpw
         SJG8sdCm3mpboIpkGvTkcL7qYrM+glLJC7fuTBjReyZmWEPg6EIBi1U50wg0yC3iz094
         kjRjhiwnrKcpHhlFO6kCpWR1kMbpRJSEY57iLfwQ2usmwyGFTQXO2MISaYrxs0El7Whl
         oJBH21a+LNc08SnsiGVHe0p9FenwL2yF95vimBQE58TdqSJnF78iUkdujGZcRYDTpli9
         JwJA==
X-Gm-Message-State: AOAM532bNXliop6rVx+9979NWmdlwniccht4Jx7bvNiOrZq+l3yHY9Lp
        C/Ty8qVJCsjK1pDR6vaH4JP3/AKgNVG4Lg==
X-Google-Smtp-Source: ABdhPJyT8M5Yi+kmNdP6bZvlzQpiPmh3J5I0QE7h3mXoyXOo1t0E1NL+j+MqKJHmZASKMoa9jgRQvQ==
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr3708336wru.269.1630588322507;
        Thu, 02 Sep 2021 06:12:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:12:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 19/36] receive-pack: convert push-to-checkout hook to hook.h
Date:   Thu,  2 Sep 2021 15:11:19 +0200
Message-Id: <patch-v5-19.36-fa7d0d24ea2-20210902T125110Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com> <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the push-to-checkout hook away from run-command.h to and over to
the new hook.h library.

This removes the last direct user of run_hook_le(), so we could remove
that function now, but let's leave that to a follow-up cleanup commit.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 91fa799b66e..a7d03bbc7d3 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1435,9 +1435,12 @@ static const char *push_to_checkout(unsigned char *hash,
 				    struct strvec *env,
 				    const char *work_tree)
 {
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+
 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
-	if (run_hook_le(env->v, push_to_checkout_hook,
-			hash_to_hex(hash), NULL))
+	strvec_pushv(&opt.env, env->v);
+	strvec_push(&opt.args, hash_to_hex(hash));
+	if (run_hooks_oneshot(push_to_checkout_hook, &opt))
 		return "push-to-checkout hook declined";
 	else
 		return NULL;
-- 
2.33.0.816.g1ba32acadee


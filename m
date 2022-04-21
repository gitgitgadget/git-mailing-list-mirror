Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAEAC433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 12:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384301AbiDUM2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 08:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384105AbiDUM2a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 08:28:30 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1DD2F3A2
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 05:25:40 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x18so6495099wrc.0
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 05:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xRRcfaN/5UOJ0Z6EpW0InNRxxnK21meBKzpSMsKpZX8=;
        b=npu6s7qGPM642c/2dZjDIIjjNhZgsR4mimJSkcrwROztZzmY7T7rsKRbSzh832+6Mb
         RspJkaCUaxqdPw++AfHcmEu1WqfA9C/QC15uWR7P4wgKeNFVEKagRa3OF0eUQ2aD4Yyi
         9fp6D5f6t7/kKAO83NmgkpKRXsMM9AwWHZkCCgLNpcDogl5jNij67IPwb6kp7HCg8DZ8
         AvG/sCgMd9hZdJ21ya2GVskJfg3+mzEUM00Ybgp4BnXL7QY4gXuLsK0QR2hjt9Fi1Pkm
         5o19nacfsHgoRbwmxekJcIz+9n9dflDhMQSXbt6p/aURlHzp/Drig5rmrREBKrX8vXYH
         rwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xRRcfaN/5UOJ0Z6EpW0InNRxxnK21meBKzpSMsKpZX8=;
        b=2+sNSvFrUQAF2okRtwf3GD5TS3A8wYKbvNNhXW3FMJkySlQAIvtIqkf1vzRDcsIg6r
         9bvC9nSEeHyaG6ASn/tItryu+SeZSPjk+o1sE9rhxOJvYTQpAjt1TSIK0gsM4ljIReY2
         /hkbA12VJNav/cmP7isWxAWxDOHReU83hsAanjMl6HZGF1WlRUgm5QowMNP0WWa27fU9
         GqSijpAIfWb86/WrGR4aR05K9NoyF3iAWw/OClDhRW+vsuhoYD8a2Z77FWkZ+EWCMZgk
         6bzjLS0/NSAEWQuCtbGCsgEdFzQHEODWzN9ed5/J6M07ErX90WuxrJbcMbjq5zTaJra9
         ptng==
X-Gm-Message-State: AOAM530dZIORkgpGdH41TV1+OR2KPeqGGHjji2Duk6sWjJetttQlW1JW
        B8+qCsQOKWG73IA8zSPMl/dqS0sezXg+Mg==
X-Google-Smtp-Source: ABdhPJx41IZ2KHVSNc8t52Z1mbuvtREm0q0RsG/yNlWgB17+KIUsAW+SBGxpOR64EQXVn/+8M+XIRA==
X-Received: by 2002:a5d:64aa:0:b0:20a:7f8a:ec97 with SMTP id m10-20020a5d64aa000000b0020a7f8aec97mr19446470wrp.450.1650543938571;
        Thu, 21 Apr 2022 05:25:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c2c4700b0038eb7d8df69sm1920168wmg.11.2022.04.21.05.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 05:25:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/6] hook tests: fix redirection logic error in 96e7225b310
Date:   Thu, 21 Apr 2022 14:25:29 +0200
Message-Id: <patch-4.6-cf62569b2e0-20220421T122108Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.893.g80a51c675f6
In-Reply-To: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com> <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests added in 96e7225b310 (hook: add 'run' subcommand,
2021-12-22) were redirecting to "actual" both in the body of the hook
itself and in the testing code below.

The net result was that the "2>>actual" redirection later in the test
wasn't doing anything. Let's have those redirection do what it looks
like they're doing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1800-hook.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 26ed5e11bc8..1e4adc3d53e 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -94,7 +94,7 @@ test_expect_success 'git hook run -- out-of-repo runs excluded' '
 test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
 	mkdir my-hooks &&
 	write_script my-hooks/test-hook <<-\EOF &&
-	echo Hook ran $1 >>actual
+	echo Hook ran $1
 	EOF
 
 	cat >expect <<-\EOF &&
-- 
2.36.0.893.g80a51c675f6


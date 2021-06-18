Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1CEC48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 951A3613C2
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbhFRS2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbhFRS22 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:28 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43004C0613A3
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:18 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso10529179otl.13
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KcuRercXshr8fVDxo4roWVb7XS+XuYh41b1LArPaIh4=;
        b=lbOTHTIS2gLdmjKpH8UMOZvFlnsc4p8zpCv2XGHZOdPfRiEorwBcbWhZxSy2iPr2R3
         W3THOiomV/TwNvdq3etpRTfezvSATOTpuAl+grmdacnx1ixYypdsiQu8yCDQ+WscX2oO
         vfueTbCIiZRVvjKO26JSu6M+bUjNogYmfbOe0s2W14195K/yycqRYb64bgAUq/XHpWji
         71vzuF888sl19aOnDt8ucWv5sGown2zxXEGxJYSde/iFJJQ59VkoJv7kCIB22M7kEZow
         SxNIsRwQEmfO5Bvijx63thjryR55N5zc3acSHhtMNjvfeRapD3vTph80ms6YNJEpBbiv
         Z3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KcuRercXshr8fVDxo4roWVb7XS+XuYh41b1LArPaIh4=;
        b=NBPZ4PnKFS3Aizh7dBwrxQ6mpyuLuR/pCTcE8RrKO+WIQSFZ/3K6URjgd+gKURAn2H
         WyVLAwGXEFpWK8IvYuFh+N+Qsmu1gUZfyBGdbL71maSfefHcHqrLJDkvTBaYH2VOS0jX
         Skq/Hg/NzqvI2uPvvllp6FU9KLcmXNcTEPw8XtkFhSPE+iJXQqF/jSTiygCSohvKiXVh
         kvMQaave0uEjWVGAEMkoSAl4by7+InaC0BAP+agfVJG0LW4Ck89VtXZVxLTIUwR+yx6c
         U/ZbQh9I7y2M1Zp9tb5PnL1CB0MmZM8z1bBX0oJjn/fOHInNrKnQe1XK9bS4R1d5+AJ1
         sb+g==
X-Gm-Message-State: AOAM532W22C4GNT9UNcgYbUWZoMolbyCqujAZ8IM3Y0ldngi0/4kgDKa
        QTrKF9N+mdK83zm6rBEd6UIrBlUiDmVyxA==
X-Google-Smtp-Source: ABdhPJyaPjCMy3zlEUC9+4t7j3jtfnmft+ySOgvebh+sc+Ff2RL7KSvg2EdMUsTdBrP7erbtFkHwcg==
X-Received: by 2002:a05:6830:1387:: with SMTP id d7mr11077975otq.61.1624040777458;
        Fri, 18 Jun 2021 11:26:17 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id q1sm1909183oos.32.2021.06.18.11.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:26:17 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 30/45] test: completion: add missing test
Date:   Fri, 18 Jun 2021 13:25:03 -0500
Message-Id: <20210618182518.697912-31-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once the correct suffix in __git_complete_config_variable_name() is set,
we can add the test again.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index bb3eebffb7..9803878480 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2335,6 +2335,13 @@ test_expect_success 'git config - value' '
 	EOF
 '
 
+test_expect_success 'git config - direct completions' '
+	test_completion "git config branch.autoSetup" <<-\EOF
+	branch.autoSetupMerge Z
+	branch.autoSetupRebase Z
+	EOF
+'
+
 test_expect_success 'git -c - section' '
 	test_completion "git -c br" <<-\EOF
 	branch.Z
-- 
2.32.0


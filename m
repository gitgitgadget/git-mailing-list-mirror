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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0DEC11F66
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6FCA613B6
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239461AbhGNNP4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 09:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239460AbhGNNPt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 09:15:49 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A05C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:56 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id y21-20020a7bc1950000b02902161fccabf1so3883161wmi.2
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vMqcQEsJtqS7Yf+9IeXEy15Q6JfOB98l/zbk33z2MBY=;
        b=IMqMGE2aOHtSly1SS9fTr4fsPz64qf8CrZoTWg1cAuCFEG60UOX0EcdEjF1aUjGlYb
         cTEbeXBdLGIUsNjX6W1kmt35kjYibd+Btm8z2JsHumOgqnQw+Zts/xtUUFtiRoqoHOHr
         4Y4DgIvmYdqxFFMDxmaJpyY9y+Byg8RX6GaRz3sNDxbeREGJqTMBnUU2BkmRt/muigZI
         3yGFCqOf03Y9jS0QKne741wW4ZGZkLbs9lXQdfsRgAbKRNNgPW9kEO0yl8tveVhCrzNY
         4Rua7Cxmavib23vhkEM8IOrvG8pKUwiYFQgqEA8KuZVSGdX2Njy/IDgEeiCkyhng6wI7
         3LgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vMqcQEsJtqS7Yf+9IeXEy15Q6JfOB98l/zbk33z2MBY=;
        b=E/EG7WNL0OV5YyRyiGoRPgNF5ctCk2aC73DxLxtWVf9yi4EOyHb2KeZguyGhlpQSMB
         VefI0N0hwFbH7BrK9kpk7vQwAxfog5/DjwPsVnWxiSTK7Mcbzt2ztPwKxFx1F+8wyeAQ
         lmBWnxNQd3du9OPTU7qTRDqnv0r0KemDJKGhM0N2QjOAGk/Scfx3jgJEh+bA+77ZIFR1
         DAHM6E+dTWG6fuSTF/CvJnyVZLjNXGYVHMDO6AjYYaiFClXBtkZtZHFGqUkRmLwqx+GH
         LFAiRZatmr1vmnIKkuzp/X7yeTc0M5BpbPNRtImKpo77y7GaRFaC0EVVoIbUrXmmPF4l
         ccLw==
X-Gm-Message-State: AOAM530rBlYW/zRqBOzHAB3LtMbgXpluM8xtFzu1RUibIPFgvAZPMsHv
        YIkXbUMZXOSBScG3n6JNGZw+fIpeKoA=
X-Google-Smtp-Source: ABdhPJySo3IoTzRhSuIauQ7zWSl0ck/qKEgeF98gsGAtuV2p/wRK0BkZ5i37RY3MZfjt9iOVi0JPEg==
X-Received: by 2002:a1c:1d8e:: with SMTP id d136mr11112872wmd.52.1626268375482;
        Wed, 14 Jul 2021 06:12:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm2556103wrv.20.2021.07.14.06.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 06:12:55 -0700 (PDT)
Message-Id: <45861118991c20b0aa415b4fb1205a3a2738cbe3.1626268360.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
References: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
        <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 13:12:40 +0000
Subject: [PATCH v9 16/16] t1092: document bad sparse-checkout behavior
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de, Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

There are several situations where a repository with sparse-checkout
enabled will act differently than a normal repository, and in ways that
are not intentional. The test t1092-sparse-checkout-compatibility.sh
documents some of these deviations, but a casual reader might think
these are intentional behavior changes.

Add comments on these tests that make it clear that these behaviors
should be updated. Using 'NEEDSWORK' helps contributors find that these
are potential areas for improvement.

Helped-by: Elijah Newren <newren@gmail.com>
Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 2394c36d881..cabbd42e339 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -392,8 +392,8 @@ test_expect_failure 'blame with pathspec outside sparse definition' '
 	test_all_match git blame deep/deeper2/deepest/a
 '
 
-# TODO: reset currently does not behave as expected when in a
-# sparse-checkout.
+# NEEDSWORK: a sparse-checkout behaves differently from a full checkout
+# in this scenario, but it shouldn't.
 test_expect_failure 'checkout and reset (mixed)' '
 	init_repos &&
 
@@ -403,8 +403,8 @@ test_expect_failure 'checkout and reset (mixed)' '
 	test_all_match git reset update-folder2
 '
 
-# Ensure that sparse-index behaves identically to
-# sparse-checkout with a full index.
+# NEEDSWORK: a sparse-checkout behaves differently from a full checkout
+# in this scenario, but it shouldn't.
 test_expect_success 'checkout and reset (mixed) [sparse]' '
 	init_repos &&
 
@@ -524,6 +524,8 @@ test_expect_success 'sparse-index is not expanded' '
 	test_region ! index ensure_full_index trace2.txt
 '
 
+# NEEDSWORK: a sparse-checkout behaves differently from a full checkout
+# in this scenario, but it shouldn't.
 test_expect_success 'reset mixed and checkout orphan' '
 	init_repos &&
 
-- 
gitgitgadget

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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37311C43460
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1893061264
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhDTNhq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbhDTNhl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 09:37:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B314C06138B
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:37:09 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i21-20020a05600c3555b029012eae2af5d4so10629229wmq.4
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0bBFl4kf5+0rbKyIiArGE95Y14oh/bgCnE+LWpVBfe0=;
        b=EzRrMh7Jwn44Hz07smuuAlvEWGnD7rt48QCROPpHGqNiyGmbOYBCVWDuClF/Eaa5lX
         ktLdcxzfC9efl6gCZMvjLcitNRc7rKQP+4jI0SVt+BjGzAowLObG3bP1PRR3VMUpLJIw
         n+2iVjRZ+QjJtRRDegAOIv/eZsF4hgRSyWQcZAQ2T9oI4S4JADFckTA2bhAXRquWMeLX
         oS+/UdX2en9inBZfWh+PFcleWOpzXhlJ3iGiJ9j+myNfm1pJkhmVh92+K+opbYAOlkGV
         B4H2X8HPT2eUB10OVWXPld1Wxf+4KYzWOxuShe4iTlqSlM1aNk2DoBt3xPopV+1YxdWN
         6UFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0bBFl4kf5+0rbKyIiArGE95Y14oh/bgCnE+LWpVBfe0=;
        b=O0pGsk2NLRqFr1DFeZyRW/QKQpX5L+jcBG1xt/sLjOARJ+YMyIqJvESiNF1jhJ3e3h
         LjCEPwKmzx9aIAb0gvaTZXaLvsB0+w4HujteeAwF43eN382CdQBeLOnD4ev2UPeHbnzq
         vdrPjeW7Pn0lvdu7ULKf0cf+0kd16DtTD8s0l5aokuEG3e6hiYhg/cTIqqV+d4xwMIP0
         KFu58eHVAQXWlDqrR2xE4eHwWiFaItLTN8LK05SOxUim8MCZX1eQMkq0PUVodk2JImm5
         66HN8A8dXDfSlLA2f+gTeG++9SemUB0QWA2L610Ac1COx4NOEk8a40gO7PCTaXKr/tkL
         vqZA==
X-Gm-Message-State: AOAM530RBaXpyJYssI6kblZx9TjER94w+dzIxfqPYysalLcRzO3At5kz
        NHPI6ngqfhTx3plX/jtHiIShAI0TQePVCw==
X-Google-Smtp-Source: ABdhPJw9ty/ASErzueZmIdcydCAs+kC50qHQlquJxumHQijhsn7oUK7jTCPMb+tf7MKo2ojpnRBm7Q==
X-Received: by 2002:a05:600c:410c:: with SMTP id j12mr4508238wmi.112.1618925827863;
        Tue, 20 Apr 2021 06:37:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm17705518wrr.3.2021.04.20.06.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:37:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/8] branch tests: assert lookup_commit_reference_gently() error
Date:   Tue, 20 Apr 2021 15:36:57 +0200
Message-Id: <patch-5.8-8982c42127-20210420T133218Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-0.8-0000000000-20210420T133218Z-avarab@gmail.com>
References: <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com> <cover-0.8-0000000000-20210420T133218Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Assert the exact error returned by lookup_commit_reference_gently()
and "branch' itself in the non-quiet mode invoked by branch.c (via
parse_opt_commits()). This will be used to assert a subsequent change
that changes the lookup_commit_reference_gently() code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3201-branch-contains.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 349a810cee..5bd4b05b6e 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -166,7 +166,13 @@ test_expect_success 'implicit --list conflicts with modification options' '
 '
 
 test_expect_success 'Assert that --contains only works on commits, not trees & blobs' '
-	test_must_fail git branch --contains main^{tree} &&
+	tree=$(git rev-parse main^{tree}) &&
+	test_must_fail git branch --contains main^{tree} 2>actual &&
+	cat >expect <<-EOF &&
+	error: object $tree is a tree, not a commit
+	error: no such commit main^{tree}
+	EOF
+	test_cmp expect actual &&
 	blob=$(git hash-object -w --stdin <<-\EOF
 	Some blob
 	EOF
-- 
2.31.1.723.ga5d7868e4a


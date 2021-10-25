Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F55FC433FE
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 21:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FA1461076
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 21:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhJYV2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 17:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbhJYV2b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 17:28:31 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530B2C061767
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 14:26:08 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k7so10604941wrd.13
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 14:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5S3ZcHM3xhUSU9SYhBTiFqesP6joUdNYwCSF6dxzvL0=;
        b=cpVkev6JLuHviC+iQ3ijosPxQkV/bm4qSahYYuQSrvH6C7noziNKk46QCnP7LmHiU4
         S4WEaGEo2SF4q3qtYC9qorX16YD9BB8DMkieZOK3E9qM7tQPZjmernqnGRgKiqRa1RRH
         LunbVgNxkmq6KodySOrx3CTNu13W9enPtiOW5+3XrvJSf38bmZCbyp+9djcZDVDY5T+0
         +LlbCXGS1NRanGT09o53h0TO5YT2KjOpA2yhhlnoOb6U1Kbo9OUrCGcgskADLS0bR9OK
         ZfSqo069BCDkiM3IX9++fzAqvnuciMxW3DPrI+SfaliIN12XOjtdXkxAcez5tUODb4dT
         sUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5S3ZcHM3xhUSU9SYhBTiFqesP6joUdNYwCSF6dxzvL0=;
        b=BTktEUq8X1vvPRIZKi1ChHKOaFVR+vD7PBADbyPExP/k2eOWkWy1z1Wvx2sdwQvIcB
         EbFyGPpOH7f2/iiNahVRV9vJ90PFHVycS63s/hBIJQubBOpXI6m3T9Tqt2GI0TBC3rRN
         aRmJdyqp2EuRRi+Yu4+tnResY4DygtDLIwC6D7F3kb/s0WGWXQvty/Jgw4XL4BkwAbVa
         I9hY84LELomdAubvhbb+kd6Gom/JpBK2Axtq6qTlmufVEUImDZfd1xlquF+ERnfurgvS
         DuhITSzFYZWj2PINiddNuCNmw4DgVEO0PYiFJcbu4jHPk6NNt5eLOZ08pUe85cwmnXnN
         8vFA==
X-Gm-Message-State: AOAM532tCfzjeGwFesP+GkPVaayYgnpnfeMIeVrzHSOUbvtcsCCBFtuW
        gm1lMmGfjViRtEqTglmVoE93selhhFaFvg==
X-Google-Smtp-Source: ABdhPJwQJzOXMrbbDokVX1nEyA03vrFRVQeGb+mxkt8iAwlH1dxIGrGti78MEh5PcvWBerQj/979WQ==
X-Received: by 2002:a05:6000:2c6:: with SMTP id o6mr6337900wry.321.1635197166694;
        Mon, 25 Oct 2021 14:26:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m15sm17972784wmq.0.2021.10.25.14.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:26:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] leak tests: mark t5701-git-serve.sh as passing SANITIZE=leak
Date:   Mon, 25 Oct 2021 23:25:44 +0200
Message-Id: <patch-1.3-7639b9bbac5-20211025T211159Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1511.g4a4db174869
In-Reply-To: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "t5701-git-serve.sh" test passes when run under a git compiled
with SANITIZE=leak, let's mark it as such to add it to the
"linux-leaks" CI job.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5701-git-serve.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index aa1827d841d..1896f671cb3 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -5,6 +5,7 @@ test_description='test protocol v2 server commands'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'test capability advertisement' '
-- 
2.33.1.1511.gd15d1b313a6


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3119C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D1D61242
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhDGW4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhDGW4j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 18:56:39 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A461AC061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 15:56:28 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 184so22654798ljf.9
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 15:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=odf0LAlm/YjRtd0usOxwF92IYjGT9xm5nXDOql5Y01Q=;
        b=FZoS3AY6YmgEwWbl84zJDgrs0cfHr4uZbBIJISYJSkNDtesh6WotHtMiCMQR+/vB+5
         c2PzIWWV5bHWHfmb+vBXBLCI/5GLtmyxjkgEDWu3HNsg5QDErQ2C6koZeeEox6xDpEwp
         SeBwRTDLlcjohfqUHKbhi3wAnRvP7TBalo3vdrkvpf57NAofKfRbdnULbWaYnHO7TwWz
         tbzxvMIbGDtT7fBVM505I0TesRK4yA+gvJDZ5BJkH9AxxHsnggxcLtDExPDf71+IIjrA
         h5XTFYQTP6rBbwQtOj6IwIV09C6CgXjI1p/DivtgIo1uiSK4JuQJiBjJEBpKjChZnYuk
         x9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=odf0LAlm/YjRtd0usOxwF92IYjGT9xm5nXDOql5Y01Q=;
        b=hESANc5BCIJgCBYanrxzmbl25vfezD7UacrjD/S+N3iQcv8gI0LFfKtdZK5G7p8Cou
         Hpsv0EwrGA8YSy+Ztn+BLa91zql3sF2FN1WRmE8RfCQa6PkuM4XnGwtzmtwuuJwsWX+P
         LXjJ7KARMEg+MLFMv941khm8uRQsRLUtLV08f2iEFzTbT+IqPvRnCMJGan2e+wwWk6Dk
         h+rFkt7KYnidcOPs0pM8iaqz7MQmQOzxcU7UKn6wGFw2GM6YSejGFkbUNTiNYMm1+mCM
         iJE25uveTNcQeZE094xTzJXgJuIBraXB0TD+7ZPQKoF4V5miFkiwy+HCYiu13Ar5+kLN
         hFvQ==
X-Gm-Message-State: AOAM530xgPylgWJUE4OC94ksvNeAZt50Y5ygw7M4PLOQypSih7V9Kgl3
        jaRFjlp8/Qf0iJ3DUig9PaU=
X-Google-Smtp-Source: ABdhPJzJATU56ED5lWcpJgoSDkmYgcnhEkSXD56xcN58Wokn1wwF5L7276hQcM2lAlKSbOcbiSVPYQ==
X-Received: by 2002:a05:651c:282:: with SMTP id b2mr3491034ljo.176.1617836187205;
        Wed, 07 Apr 2021 15:56:27 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t25sm2580101ljo.102.2021.04.07.15.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 15:56:26 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 7/9] t9902: fix completion tests for log.d* to match log.diffMerges
Date:   Thu,  8 Apr 2021 01:56:06 +0300
Message-Id: <20210407225608.14611-8-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407225608.14611-1-sorganov@gmail.com>
References: <20210407225608.14611-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There were 3 completion tests failures due to introduction of
log.diffMerges configuration variable that affected the result of
completion of log.d. Fixed them accordingly.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t9902-completion.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 04ce884ef5ac..4d732d6d4f81 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2306,6 +2306,7 @@ test_expect_success 'git config - variable name' '
 	test_completion "git config log.d" <<-\EOF
 	log.date Z
 	log.decorate Z
+	log.diffMerges Z
 	EOF
 '
 
@@ -2327,6 +2328,7 @@ test_expect_success 'git -c - variable name' '
 	test_completion "git -c log.d" <<-\EOF
 	log.date=Z
 	log.decorate=Z
+	log.diffMerges=Z
 	EOF
 '
 
@@ -2348,6 +2350,7 @@ test_expect_success 'git clone --config= - variable name' '
 	test_completion "git clone --config=log.d" <<-\EOF
 	log.date=Z
 	log.decorate=Z
+	log.diffMerges=Z
 	EOF
 '
 
-- 
2.25.1


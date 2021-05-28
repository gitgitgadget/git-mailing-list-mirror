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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BE4C4708D
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFCB7611BD
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbhE1MNV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhE1MNT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:13:19 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4326FC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r10so3045910wrj.11
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y76LIDEogVgjWLyqVhKSZu/O8Gex/gwCHP7JWyhmFoY=;
        b=HEC6AOKB4Oa8njgeeXhIu6Q8SHnjdA1YDNs56dyr92YqORmpWNOMH3ZN9we7u3qq0l
         L+ke7uk1JKHuyrJhAypQVQ19kbmUgBnUpxjIBk7DpjCG2pcJPCsbY0XzvidnV6M3MPZS
         0xddC1GXgP+LDwHkZ8gWZ0ykroVgn96er9yFBGQl1zCvS2eqycrQC34MjGEfJ/HFCPdQ
         GbJNfO+aIEmZIClMmzjsb/yz0Dr4xP+F6v+ulvv+Hubj0AiAMjfGPFx8XXO1LkAS5EG2
         fi+ReBaKZQVizXThycSB79GNdvYJ3mQDB/fgaQTMZQ6lSUoQdeNiP74b1GXgGNE2wC3D
         3zkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y76LIDEogVgjWLyqVhKSZu/O8Gex/gwCHP7JWyhmFoY=;
        b=FQV6Xnu7IRLTsze7tqb47YipQudTEhmbyQWKnUK6RrDCkk9WDCHLRjCDXr4jx71JWf
         pDqzpnChEqPu48hN+cmllQXfiCq9vaMX0taFHD6LC11RhCMOzOF3h2y4D9IfbVKwULh2
         iGs0yRkVRo7Mnk/gTWd8hm4UQE8FptS4DSq2NphiyYzUpCQoUbyUirbESbXpA2ltLnkj
         DWxJAdzfgTtRbLwdM7iDbwcYY7cbNkPj0CGPByOnRojDArMPdgktIrhYE52jnH+EscDU
         u7hdheYJKXD7Cn6SdCwXPEDVtQrc5HIAozFbQ8kGrIaptwm9kTc82g0ULL0NETCnsLd3
         2OWg==
X-Gm-Message-State: AOAM530zRIQRJKbXgkmDuCwSJExxgMqx0wC+BDWvesDdp7pLKM7VtmGZ
        cXjZQFlcZY5zDBZbsAEUMWGwucU+QLNbOg==
X-Google-Smtp-Source: ABdhPJytOP9dscC2d6EFSDR6opss4T0qQIjM73EL4lN9fFl7yDZeRViA2D6iNEdZF/h505oB82Fb7Q==
X-Received: by 2002:a5d:508f:: with SMTP id a15mr8630178wrt.242.1622203901590;
        Fri, 28 May 2021 05:11:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:11:41 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/31] hooks tests: don't leave "actual" nonexisting on failure
Date:   Fri, 28 May 2021 14:11:03 +0200
Message-Id: <patch-01.31-8ac2efc71a0-20210528T110515Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.460.g26a014da44c
In-Reply-To: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com> <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Start by creating an "actual" file in a core.hooksPath test that has
the hook echoing to the "actual" file. We later test_cmp that file to
see what hooks were run. Having that list of files be empty if we fail
instead of throwing an error about it being nonexistent makes for
friendlier output, we'll see what hooks we should have run.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1350-config-hooks-path.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.sh
index f1f9aee9f5d..fa9647a7c0b 100755
--- a/t/t1350-config-hooks-path.sh
+++ b/t/t1350-config-hooks-path.sh
@@ -5,6 +5,7 @@ test_description='Test the core.hooksPath configuration variable'
 . ./test-lib.sh
 
 test_expect_success 'set up a pre-commit hook in core.hooksPath' '
+	>actual &&
 	mkdir -p .git/custom-hooks .git/hooks &&
 	write_script .git/custom-hooks/pre-commit <<-\EOF &&
 	echo CUSTOM >>actual
-- 
2.32.0.rc1.458.gd885d4f985c


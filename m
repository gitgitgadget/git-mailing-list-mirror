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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A34C432BE
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 22:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8CAB60560
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 22:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbhHBWix (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 18:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbhHBWis (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 18:38:48 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97112C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 15:38:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n11so11313135wmd.2
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 15:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xv+Tv09nJQdWH1UkNyJtccwUehY8HAGKEeBNlMlE68k=;
        b=Qg/li+gFOEBMLDdSNZ+Y04JO5EQYJ0O5Us9wgm1Io68VjKOaQwF3vvovSFlYzJb+ZA
         qAid0tui/iVBIv6rPe4ZGKsMpKGiOVMaoMLJSGKbXv/n21/wLmdUOXu7lN2dgspvkfU4
         S22Neelj8/c3M9HttQOr3bXUdz0zHwqrkjYb0Mmzq2GYaM5z6oBLPZIFX4piC/3ednzK
         Vv5HMsErzpGVL78QyYfCgpfACadEw0OkLEnGdEyt/QaNrb4kOmjRYdpRM7cITtVmFMKo
         VSrCNmnE998TVCJ6lLFe4SV0E+KFLsAnhfIhWbsfJPDxTSEAFDaUy4COrVqrkwNgtdMJ
         wvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xv+Tv09nJQdWH1UkNyJtccwUehY8HAGKEeBNlMlE68k=;
        b=aNmuQbVi/DjemWaZX+2OaZCC9nzg+Afb8u/HcbwyjEcB1B1T5Jtm4iG3hElj9re9De
         c7UAj2pws4O1/ohMksyNRPkS8LXuYPsI9TOJfG3iVjTz/OZuFhzsRbZ7HVpo5ooYX+c6
         dAnoH7IBEJUfXkuzUTNbb+K78NHL66SV9i7sFG9hweHAjPhX0ljmHlH6TuyJYtoYtZcr
         7/D7yJJmMb/CnpMfaEt24u/Hn9qG1Vzm0gRihf7d7I1kvpBmSmtQjeUQ5mzdtFoIUqS1
         TJ5Jz4zRZm1WkXMxYsppToyj25Ap7q+KUrSbjA2g2obK94hdDbYRtJbeLbThZsiRd2K2
         2OFA==
X-Gm-Message-State: AOAM532kaA0QSuCa2MGWWe7ZesbbbPnmvjXMJnKRB9Uknnmh1s7hCV3o
        +E8jec9lmcmkl/vlAj6vQH6O1kVkpE0=
X-Google-Smtp-Source: ABdhPJzXA2dVhhGoxZEXKAaYD0DlKuKF99S48bLKuxZg+mPonhh9ZSMR6msZC5tnpG7Kouh1kLQ1Rg==
X-Received: by 2002:a7b:c1c7:: with SMTP id a7mr18699037wmj.53.1627943917298;
        Mon, 02 Aug 2021 15:38:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10sm11656884wmb.40.2021.08.02.15.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 15:38:37 -0700 (PDT)
Message-Id: <020eaa2c819779fbb21960c42981303f858e2674.1627943914.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1006.v2.git.1627943914.gitgitgadget@gmail.com>
References: <pull.1006.git.1627925390.gitgitgadget@gmail.com>
        <pull.1006.v2.git.1627943914.gitgitgadget@gmail.com>
From:   "Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 22:38:34 +0000
Subject: [PATCH v2 3/3] clone test: update whitespace according to style guide
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Mahi Kolla <mahikolla@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Mahi Kolla <mahikolla@google.com>

Previously, the code used spaces to appropriately format. The spaces have been replaced with tabs to follow style guide standards.

Signed-off-by: Mahi Kolla <mahikolla@google.com>
---
 t/t5606-clone-options.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 69c4bacf52f..1a3f1e9ab18 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -18,8 +18,8 @@ test_expect_success 'setup' '
 
 test_expect_success 'clone --recurse-submodules sets submodule.recurse=true' '
 
-        git clone --recurse-submodules parent clone-rec-submodule &&
-        git config submodule.recurse true
+	git clone --recurse-submodules parent clone-rec-submodule &&
+	git config submodule.recurse true
 
 '
 
-- 
gitgitgadget

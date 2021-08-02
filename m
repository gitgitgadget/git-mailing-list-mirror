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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCCAC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 23:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07D4F60EE8
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 23:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhHBXX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 19:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhHBXX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 19:23:28 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292E2C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 16:23:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so948147wmb.5
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 16:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xv+Tv09nJQdWH1UkNyJtccwUehY8HAGKEeBNlMlE68k=;
        b=EvZ3YCdYXn8+nfNhcuhOgy2c86xnBezsGELQ5GkY8Yn4Pz6xQBz4mZto7ooEyN6MhO
         kzzt05bJuuy7aO7x57qpNumwQUd2GoqUnhBkXLhpRC55tPTwYE+XYRRXMBWr/13moAHT
         e+rcMkVUyq9x2/VZIeYsQwFjUYu/CL9fNAoWuZ3/pvPX/xKyxc5oUw9vf6JMFrzLRMar
         KS9CKZx7v/bySeDVoo/tIuuB1Xxfng0NGJS39LNdKyBDv/KK7EXiGF0n6qo/D80Jeujk
         8irU/6DvccjlJngzZWPy3uGlrr6sUIq5hX45IqI4w0KYp9cZr1IBXPM/jNx1FZOhoTRf
         P4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xv+Tv09nJQdWH1UkNyJtccwUehY8HAGKEeBNlMlE68k=;
        b=K3iFz7F8RKvw1Pu+j01ZQEhuf/Ix2XSYF68oOKtsyXx94XASk5BwJs4XQifMzCbMYj
         XTDJw1YyqGbKfVWkvqWeqiumkJyFjj1dHSIpIL6Ubb7qMMGqD2w5QyQQ43CuACj4IcNW
         jZs20doKPJ2E0sKTwWI8sscZT/h/QuUYQY0/0rI59PUA1Jaup//2QuGKOhg//crBdYKM
         vAYw25jYO7jV4uVh8TifVx6TRVX150fAsMNXz806zbDyEDCwtHNJ7XreU56yFOUH9fKB
         Zx/hrRMoxh1IN/10PTT7HzkQF2MnIN4PmPs3hjUfwUbV3HIKxzr7vBYSU1HHy5IMmkek
         lcLw==
X-Gm-Message-State: AOAM530QgPLdX2uo4XM99FV5x55jFT4M0d3s15XfI2H2Ga5JNmMsspA6
        68fqbFHrgxWylPVlNB9pPFyIcuj412Y=
X-Google-Smtp-Source: ABdhPJwfyUzUvi8GiDu+Bn6JeRPQpResAtDJ7Eey94FqXSZ7N2rT/1vOJvieiiOESZOJDV4kppW2Jw==
X-Received: by 2002:a05:600c:35d6:: with SMTP id r22mr1173467wmq.41.1627946595277;
        Mon, 02 Aug 2021 16:23:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y197sm778041wmc.7.2021.08.02.16.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 16:23:14 -0700 (PDT)
Message-Id: <020eaa2c819779fbb21960c42981303f858e2674.1627946590.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1006.v3.git.1627946590.gitgitgadget@gmail.com>
References: <pull.1006.v2.git.1627943914.gitgitgadget@gmail.com>
        <pull.1006.v3.git.1627946590.gitgitgadget@gmail.com>
From:   "Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 23:23:09 +0000
Subject: [PATCH v3 3/4] clone test: update whitespace according to style guide
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


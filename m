Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A519FC55ABD
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 15:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44937206A1
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 15:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSw7H6PM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgKKPSQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 10:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgKKPSO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 10:18:14 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8ECC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 07:18:14 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so2890911wrx.5
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 07:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WSF4lmPglrAIDWKqrktWF7RwCiyR8z/h8KT0SYjH9qw=;
        b=nSw7H6PM9cxFMVClY/OQRkjN4JRXNI0eFiAlCR2XJd35R8d6DEE3s/YxJqgvFqiWT9
         PeDDdl0itz+AsbkRsIC+1DWQOx4AMrxL5UTRkp3Get3NiLGRIGLuy6mCWvg6EILiTk/s
         4KlAmr3V9cXLzA1IievDGCc8VEFp8uLJTNqHFeq56vhhIf/XzaCHGbpDi3Y9DGzJlEav
         cAIpgsdLW6axJtPqwrXcyFMO9VgPlAeLLgQDlIFaKEvhnsyTvauJrvFFQZ0lsRpcxMnw
         hly9rjHqm0hNd53dIcQ4eRwrvrbJ8zp31lo22IqRD98dofpRpoG6yfOLIvOGDwrvVVen
         T/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSF4lmPglrAIDWKqrktWF7RwCiyR8z/h8KT0SYjH9qw=;
        b=ewdVczGc/W6lkYDqPUTeEKJof1qYz/mvPszX8NTtk5HBx/3cwsln84evDGIE7OKDzw
         5hiKuf8FtKFf533O8lNA3VR/wLFLPGicMXgyndvviF1KaP5iou1JM7c4NTr6hXpDHYPb
         LYRp3+s8F7vdz2K0wLkNtsJ59CMq6bKHgVIq/1G/Il9syyCsIlaFHPJ/VdX8IJVG7bBw
         VVwNnr82RHyo7PmkdOXbrMJldq2rU4vutppAtuazMnajRMo7E/mSU5Ls1fSP0xCLmjow
         OwZelGK08EQjiUu3+kYVlBROYeXqILNGxW6UUcVPNbmylROcufON/HRPQpc7IZTkxMid
         QVig==
X-Gm-Message-State: AOAM532cSjphgo8p1nZa7dtovEn0k2O2T8VU/t7Q5n8gHvTqQEuTg2Lu
        aBl852YxXMCTDLD8As6ryytdXSSKwiA9hw==
X-Google-Smtp-Source: ABdhPJwJYDifKfbU/tMZLSG1QjTjbIaDDDoKG5HLhz951WOMuMGqLNz9r8JsaFR7Dsitfh0SFvRZVA==
X-Received: by 2002:a05:6000:1cf:: with SMTP id t15mr15427883wrx.92.1605107892897;
        Wed, 11 Nov 2020 07:18:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q2sm2940010wru.76.2020.11.11.07.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 07:18:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] parse-remote: remove unused GIT_DIR variable
Date:   Wed, 11 Nov 2020 16:17:50 +0100
Message-Id: <20201111151754.31527-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com>
References: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This variable was last used in code removed way back in
45781adb9a ("get_remote_url(): use the same data source as ls-remote
to get remote urls", 2011-03-01).

Since it's only used in git-submodule.sh it could have been the case
that the code there relied on us setting $GIT_DIR, but that's not the
case. The only use of $GIT_DIR in git-submodule.sh involves a $GIT_DIR
variable that the code there sets by itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-parse-remote.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index d3c39980f3..6b743cda17 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -2,10 +2,6 @@
 # upstream branch that should be pulled by "git pull" from the current
 # branch.
 
-# git-ls-remote could be called from outside a git managed repository;
-# this would fail in that case and would issue an error message.
-GIT_DIR=$(git rev-parse -q --git-dir) || :;
-
 get_default_remote () {
 	curr_branch=$(git symbolic-ref -q HEAD)
 	curr_branch="${curr_branch#refs/heads/}"
-- 
2.29.2.222.g5d2a92d10f8


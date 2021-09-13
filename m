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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEBCC433FE
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71DEE6103B
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343506AbhIMPiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhIMPiC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:38:02 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289CDC09B05A
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 07:51:36 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u15so9092578wru.6
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 07:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4zlGxnujYNmoQ4QrIPw0p8RsHcRlItr76ND9Bcg/8AM=;
        b=OSskH8+tpBqB819KlqHj7K4n536RPWSHIBjrVqU0PWfAxEheian/9Ema+lbqOFxJii
         /7if5O0UgI7e165MG3j9GQO6p7YGbLRLaNF7mtkkznwiCCyj/0jrxb5G75M0+KjPmzcZ
         w+xy9QXAKgCWCe76Psf+gJt3sIugyxMgvsjMM085kbOUnrA6KepZBMemdOLuJALqY8Cb
         2yr25aKSko6U2evaX33D/YkPUVMdvrqG9YDJ2byUVkykoQ32RzQb4ybvK2KiP3hFCdSJ
         qlHDamUtVmkC3qZzCOUDW9oO6ThYuPqZzqbPl75D+3vb84zEbdK6mjiqNYj09KTBP4VT
         47QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4zlGxnujYNmoQ4QrIPw0p8RsHcRlItr76ND9Bcg/8AM=;
        b=kdogROYvA/cB/8kbbyYmIZd0u20wJKl9S+8orPBXS5mVoZVAMrj/T/cVeRjAc3egds
         yA6LhUC9kI69bhczfaV8KpSwgvM2FwSJAguXF3vaQ+0ATu9lw5LDnxzSbbsCkWjPvm8b
         JQXedIs0ucxMidfWkR+rVu6mTpy57+/J8bYDVA7/RPZlmpQLYvc9Y29WNe3xnMJzWyxa
         DMfWGGCJO8ZVlHQsd0mnfDf1KQoHwJ1YYb+OPzLuhy1+wYT85tynkoVIzAb+G1BPflnG
         OYXoB56BEszvPAQ0zY8T2DLNqro1UyNbdu6g29QmXdtt0sEo3ykL0i6h8YLsz5b0A7R4
         xrjw==
X-Gm-Message-State: AOAM5316w6+BD7oxPHdHOzl0eT5Mvx1LQ2aI+gHjrVkPlZV1CobPYtso
        7tq6e+veDKNxotxaYoykGyL1euHPhJu0Rw==
X-Google-Smtp-Source: ABdhPJw7vyYt6A8vF4VVQTu3zTbGrt9GrmKAZyC8eBaqrej4CyMgVwKtaXP/PszTk3CfRtI8YBnGAw==
X-Received: by 2002:a5d:5003:: with SMTP id e3mr13265249wrt.118.1631544694426;
        Mon, 13 Sep 2021 07:51:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o24sm3638854wmm.11.2021.09.13.07.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 07:51:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/9] INSTALL: don't mention the "curl" executable at all
Date:   Mon, 13 Sep 2021 16:51:21 +0200
Message-Id: <patch-v4-1.9-7b771aa70ef-20210913T144846Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1013.ge8323766266
In-Reply-To: <cover-v4-0.9-00000000000-20210913T144846Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20210913T144846Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 1d53f90ed97 (The "curl" executable is no longer required,
2008-06-15) the wording for requiring curl(1) was changed to the
current "you might also want...".

Mentioning the "curl" executable at all is just confusing, someone
building git might want to use it to debug things, but they might also
just use wget(1) or some other http client. The "curl" executable has
the advantage that you might be able to e.g. reproduce a bug in git's
usage of libcurl with it, but anyone going to those extents is
unlikely to be aided by this note in INSTALL.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 INSTALL | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/INSTALL b/INSTALL
index 66389ce0591..5b8bd5ccce1 100644
--- a/INSTALL
+++ b/INSTALL
@@ -139,8 +139,7 @@ Issues of note:
 	  (PPC_SHA1).
 
 	- "libcurl" library is used by git-http-fetch, git-fetch, and, if
-	  the curl version >= 7.34.0, for git-imap-send.  You might also
-	  want the "curl" executable for debugging purposes. If you do not
+	  the curl version >= 7.34.0, for git-imap-send. If you do not
 	  use http:// or https:// repositories, and do not want to put
 	  patches into an IMAP mailbox, you do not have to have them
 	  (use NO_CURL).
-- 
2.33.0.1013.ge8323766266


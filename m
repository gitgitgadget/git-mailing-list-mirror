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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0610EC433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB1C1611AF
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbhDQMcF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 08:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhDQMcE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 08:32:04 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6C6C061574
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:31:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a4so29230389wrr.2
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OwTrfxV45lHruFoTgz2NfzcnGqJcmU+3ZbVSDQm8+vU=;
        b=BBIDDw2QG/aISt0kZsw6gQKgCMf9vlXtOjniXph0rkZg/1JwKFCNN2r4Ywy5xgSp2m
         Gs1glYxi2OdP6MFe/3YIFO7zKne5XiIh2oixG4ltimIUZxB2W9DNe1l+vQnV7fdUP1M4
         syL1pf7RqlrQLc6ltIDlR8BeYBIu6zUuQkaM79ba1xCq2OiBJf9TxslqRNSj0dM3hAWO
         UAJqFm7wQGQnkUVUNEHCbyhHXOp0rUlLvrSwnj4hJPMhNwc9CH6URhEsr8OeP67rhPT3
         2bNYORGfj2lVOMUocQtqvcurj4Anoye4ovCq74nlxyOojBDKnyNyauQGBNV3JW12sNWl
         12BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OwTrfxV45lHruFoTgz2NfzcnGqJcmU+3ZbVSDQm8+vU=;
        b=bjxrY7wJAg+kLRmf78o3mC1ExmNsIu1QGSHWpwcg54QYa57EQ+NYtU7nAVSux2Uexg
         Np3hQSMK7f9z7JSWVKkd9K5cdW7oXs6WpaByYE66Dn9Lfi9GmHSKaHdXdxSTjwHqwB1q
         kacYmXoCOJK4LMkpuMVLs59QDP3qf7BrWncIYwy9eDgaPADt1czVCeFeTfJrdtXd0Y0d
         r0bASAqSL2SgZtvuGvZ33senrwKW7mUKLpqDY1e1/N5krP/IRyakH+rW1ZRff0LZfmf1
         +rjOHBVf89cZhka2yqwR/0QPVYNZ7jYpHjxYWlzcInWiVgMFy810xNYrNK1ykCj96oWk
         zcZA==
X-Gm-Message-State: AOAM532od0muT9f+y0IeRED7TYo9BgfFVK4xpdQHxd4DRPCJXTedGUtE
        xOfMbxKtXB2+4ZR5tE6NIx/9fvlYzmbecQ==
X-Google-Smtp-Source: ABdhPJwQ4y8tRTxGwrauQhOnlmRqEmyt1Iu6o7KkKhSUR2Cb78ps4Ac4O0oLriZ5Z6/1bD/sDFLwkA==
X-Received: by 2002:adf:ab50:: with SMTP id r16mr4261112wrc.336.1618662696711;
        Sat, 17 Apr 2021 05:31:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s8sm14700635wrn.97.2021.04.17.05.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 05:31:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] CodingGuidelines: remove suggestion to write commands in Perl/SH
Date:   Sat, 17 Apr 2021 14:31:27 +0200
Message-Id: <patch-1.1-98b1f938f7d-20210417T122959Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.722.g788886f50a2
In-Reply-To: <patch-1.1-83266f30b67-20210417T084346Z-avarab@gmail.com>
References: <patch-1.1-83266f30b67-20210417T084346Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a suggestion to write new commands in Perl or Shell to
experiment. This advice was added in 6d0618a820a (Add
Documentation/CodingGuidelines, 2007-11-08).

Since then the consensus changed to having no new such commands unless
necessary, and existing ones have been actively migrated to C.

So this isn't a new proposal or a suggestion to change the coding
style, but bringing this stale part of the CodingGuidelines in line
with reality.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

V1 of this was misencoded. I sent it as UTF-8 with
charset=ISO-2022-JP.

I'd been hacking the test-lib.sh, and at one point it escaped its
quarantine and started setting config in my main git.git, and I'd
managed to miss that i18n.logOutputEncoding encoding variable when cleaning it up.

Range-diff against v1:
1:  83266f30b67 ! 1:  98b1f938f7d CodingGuidelines: remove suggestion to write commands in Perl/SH
    @@ Commit message
         Since then the consensus changed to having no new such commands unless
         necessary, and existing ones have been actively migrated to C.
     
    +    So this isn't a new proposal or a suggestion to change the coding
    +    style, but bringing this stale part of the CodingGuidelines in line
    +    with reality.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/CodingGuidelines ##

 Documentation/CodingGuidelines | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 45465bc0c98..b9cd55db6a8 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -416,11 +416,6 @@ For C programs:
    that are made available to it by including one of the header files
    it must include by the previous rule.
 
- - If you are planning a new command, consider writing it in shell
-   or perl first, so that changes in semantics can be easily
-   changed and discussed.  Many Git commands started out like
-   that, and a few are still scripts.
-
  - Avoid introducing a new dependency into Git. This means you
    usually should stay away from scripting languages not already
    used in the Git core command set (unless your command is clearly
-- 
2.31.1.722.g788886f50a2


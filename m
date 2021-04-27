Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E297EC433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 11:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7AFB613BD
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 11:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbhD0LDp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 07:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbhD0LDn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 07:03:43 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A591DC061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 04:03:00 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o21-20020a1c4d150000b029012e52898006so6623102wmh.0
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 04:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GjpTPO6YGzTTjLGzhAUngHwkPzuSknLiQqJrhuPu5R0=;
        b=fYHshkvP6FxVCr1r3f+s5XFJID9qdZAvF3n4fbjhPMcorDLonKbe/oImaLaX4u98xd
         i3gMh+KnfrAHPKh8m8oaDp1ZX9w6SG6/wDPAGPKv6HB73RHGj1XBaakywBZZHEuXaSWf
         UmCWTTosvedoae8mWOwn+cwBroYNfkdT+wTTk5AOVq+UEN/Ew4IlXSEiMHmUFNW6AfWc
         xyrjqO5qClxiQNfIdqXKehPmnfYv8UgE6LCEh5acbtoMGZGfDmkT0zYDh0F9i9smYELn
         xAkB2dhqsi1QfiffqcqTxdCMg8IrZ3TeZI7KJ8kOeV8oTj4diyrfd/Q5b8Om6JS+hMNa
         jP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GjpTPO6YGzTTjLGzhAUngHwkPzuSknLiQqJrhuPu5R0=;
        b=cjvECOEgvRcvcoLzm0LsxZ73L3pyM3GKlW7sqvXwoIbXS9VaaUKFBCl4zqx5orFMtw
         5nLTD4hfr8LlkqTQyowhYQU2oNjrtzR7yfy1wZYF4mkC9tNTtwJEItPPmoI/zLHhrB89
         aaLu2Cu77L8mBE42XVAzdHpNZUPX3obTsxk3HFCXoBmIY5E+cl2/IgUqu6YCP8+gL7DZ
         YPCaSyCPVZKYI1nZwFHaRIFDTSGD9Cz5QUuaH9fgMWjiyxo53fQ9/Z2f8FlT/Oqptgmq
         hdqrpU3D27QAno/MYStjKVMZZGCmu4Us83xdbfDgGWO++uVyBpnfj2YOwFkG/dXmA2FX
         RGCw==
X-Gm-Message-State: AOAM530LWkWILmmRMF9HpiTP/oooOe60EwEZZJ8zxN1RS42fGD9P5VBN
        BN2Afoqp69EZ6jeWH7XeGRlzGrsHl4I=
X-Google-Smtp-Source: ABdhPJz7Vzz1qTjHIu01Blcb4RQlIMWS0gLuMNkYb8GZJyygZNJ7GBzbm6Ga1iFIGv8pzRRpYCRwew==
X-Received: by 2002:a1c:f20d:: with SMTP id s13mr24483111wmc.92.1619521379483;
        Tue, 27 Apr 2021 04:02:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s83sm20324849wms.16.2021.04.27.04.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 04:02:59 -0700 (PDT)
Message-Id: <pull.940.v2.git.1619521378282.gitgitgadget@gmail.com>
In-Reply-To: <pull.940.git.1619463549689.gitgitgadget@gmail.com>
References: <pull.940.git.1619463549689.gitgitgadget@gmail.com>
From:   "Peter Oliver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Apr 2021 11:02:57 +0000
Subject: [PATCH v2] doc: point to diff attribute in patch format docs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Peter Oliver <p.d.oliver@mavit.org.uk>,
        Peter Oliver <git@mavit.org.uk>,
        Peter Oliver <git@mavit.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Peter Oliver <git@mavit.org.uk>

From the documentation for generating patch text with diff-related
commands, refer to the documentation for the diff attribute.

This attribute influences the way that patches are generated, but this
was previously not mentioned in e.g., the git-diff manpage.

Signed-off-by: Peter Oliver <git@mavit.org.uk>
---
    doc: point to diff attribute in patch format docs
    
    From the documentation for generating patch text with diff-related
    commands, refer to the documentation for the diff attribute.
    
    This attribute influences the way that patches are generated, but this
    was previously not mentioned in e.g., the git-diff manpage.
    
    v2: Mention the specific relevant section of the gitattributes manual.
    Thanks to Junio C Hamano for the suggestion.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-940%2Fmavit%2Fdiff-gitattributes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-940/mavit/diff-gitattributes-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/940

Range-diff vs v1:

 1:  6f87f3962b84 ! 1:  191d81ef61a5 doc: point to diff attribute in patch format docs
     @@ Documentation/diff-generate-patch.txt: separate lines indicate the old and the n
             rename to a
       
      +5.  Hunk headers mention the name of the function to which the hunk
     -+    applies.  See linkgit:gitattributes[5] for details of how to tailor
     -+    to this to specific languages.
     ++    applies.  See "Defining a custom hunk-header" in
     ++    linkgit:gitattributes[5] for details of how to tailor to this to
     ++    specific languages.
      +
       
       Combined diff format


 Documentation/diff-generate-patch.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 2db8eacc3ec7..c78063d4f74a 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -11,7 +11,7 @@ linkgit:git-diff-files[1]
 with the `-p` option produces patch text.
 You can customize the creation of patch text via the
 `GIT_EXTERNAL_DIFF` and the `GIT_DIFF_OPTS` environment variables
-(see linkgit:git[1]).
+(see linkgit:git[1]), and the `diff` attribute (see linkgit:gitattributes[5]).
 
 What the -p option produces is slightly different from the traditional
 diff format:
@@ -74,6 +74,11 @@ separate lines indicate the old and the new mode.
       rename from b
       rename to a
 
+5.  Hunk headers mention the name of the function to which the hunk
+    applies.  See "Defining a custom hunk-header" in
+    linkgit:gitattributes[5] for details of how to tailor to this to
+    specific languages.
+
 
 Combined diff format
 --------------------

base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
-- 
gitgitgadget

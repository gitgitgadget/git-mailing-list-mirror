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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B88AC433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 11:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 274C264DF5
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 11:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBJLpN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 06:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhBJLmy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 06:42:54 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3F3C061356
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 03:39:00 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id d2so981836pjs.4
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 03:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cPF7JN9EXFHoXUAgjyQ8SEXELSTyAI2x2DbPyESxQcM=;
        b=qw450KQ3hI7E+Ys/UgyE8FphbWIQEyOyQ9iD/b4Ptr3i0Yl89vSVGkndFSl7R8RI6f
         snwkiAxd0In2M8YugMYZrL33sbHCTF1827xyilKIG08oZVV7pv43cTSJkU7OSLx2hUQ/
         2mmeoOmr98/8l8/CPGytmb+XExRkaetgN89D14AHoBMuABprnsHZRjtgJMyN8L/SiKJB
         6VlLCqFra9heDf6+Vw+ZwrXToLpNFcvdE3uV6BmHkH3e6zFjbNMtvzY23iHMGH7lUfGE
         q1ry0W3GenBRWo7cYRMUmSE0/UMms1jY9B6+AMKNSpWuDV3QRLmI09uTtLXbqxzClKqe
         JQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cPF7JN9EXFHoXUAgjyQ8SEXELSTyAI2x2DbPyESxQcM=;
        b=tjLeNFIvX5WC4pGwj2ZFZcZyuotC1tBbfGXkds333ynskhL/nyO83Q2/r9PyU0aJzo
         tm4UU7zenzOvE80/HdcYrNaorNwVkNhG9HEHz5D4xmH3IAECPJw28LIsUIssKhrIA6U+
         mMs4K7LCzV6yjAzByBQB0Fsq0/DOMncLaQqhOz30BE8+BOyy0ViHsW8M4pLnik9qz4V/
         yCclbVbe6+c9Y7UJ66V6bCL82GjM2HgdvnobLjNYBisQilqFT2I97swt2E6a+B99cDRZ
         CTBgG8q+yd21XuG4Oe8TBWdJZzhL+Gf1rauUwb2kPykxh6FIAxgtjl65PZpIP8s/0FMu
         zywg==
X-Gm-Message-State: AOAM533y4HDmm/t026E/m26rjDf74GG4c5FrX5KhyD7RqS9/HglufAzZ
        Wg+ah+oPKoEGrzGyKnhQ8B4RlkHGyxPYZA==
X-Google-Smtp-Source: ABdhPJzKBz0Us0S2yp3CmY4AM7EHkKxCz6TsT5BW7+sQHy0uX7UckZY4NLyZ2SI2nlwmwoFe/kXkEQ==
X-Received: by 2002:a17:90b:33ca:: with SMTP id lk10mr2714379pjb.186.1612957140106;
        Wed, 10 Feb 2021 03:39:00 -0800 (PST)
Received: from localhost.localdomain ([171.76.0.223])
        by smtp.googlemail.com with ESMTPSA id y3sm2123731pfr.125.2021.02.10.03.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 03:38:59 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 11/11] doc/rebase -i: fix typo in the documentation of 'fixup' command
Date:   Wed, 10 Feb 2021 17:06:51 +0530
Message-Id: <20210210113650.19715-12-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 Documentation/git-rebase.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index a6903419c4..8bfa5a9272 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -894,7 +894,7 @@ is used.  In that case the suggested commit message is only the message
 of the "fixup -c" commit, and an editor is opened allowing you to edit
 the message.  The contents (patch) of the "fixup -c" commit are still
 incorporated into the folded commit. If there is more than one "fixup -c"
-commit, the message from the last last one is used.  You can also use
+commit, the message from the final one is used.  You can also use
 "fixup -C" to get the same behavior as "fixup -c" except without opening
 an editor.
 
-- 
2.29.0.rc1


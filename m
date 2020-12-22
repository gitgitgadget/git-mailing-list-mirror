Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3C2C433E0
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 03:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F9B622ADC
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 03:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgLVD7D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 22:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgLVD7D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 22:59:03 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971C1C061793
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 19:58:22 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id x22so717138wmc.5
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 19:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=78P5B0EZI5YNm8H+irWULeMUTdacwATcznV9pFTYRBU=;
        b=hDhwqbDfCHHuswmXRCGol0jbA+/15YNJHGswA5mc5FfP+kwkEhmBf2GE6s+BCJiv81
         /XF0ufBt0K15vg18X2SJBASSrqOK0e8iJtTWVtDFzBVMUfO0L7zhV/nWxJ7DHbgZcee0
         Lglhfb2wugg509mhovrmfMMDPsfpg25HTjeUPXunEPsBSCuGGM8N4G+lzWznJ6Z6abhL
         XzQTJNge+hRyDyXIYoXTFrXX4d5Vn1LGHCfWt3L8atMZHCJv94z0p9c1qBb1V+uXHtr2
         CyyDDTlQN6rjp4m6ssirETMjNmUg8UqJT6oKPmMc/7sfN+IaSL3HKinHA4I1gFFy9b7p
         NU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=78P5B0EZI5YNm8H+irWULeMUTdacwATcznV9pFTYRBU=;
        b=Vcb/FeG9iPLpq0XofdNIy5pGr2HuYvFsInVkD7Q6wdH6SeaqgCURT2UTYbahJbhStY
         eq5WTIcl9WWlmakKYpvVLazAMZbu0saHJxzXFoGsYu2stN4Cb9Xi6LXd4oCXDqWZpfme
         XR2oCvyobk/45oNbmY4andsY2mbgW47bOgBuV0Ex5e0fU0KlxxeqaQZ8y6Wt9x38tAVU
         KgrO9NBqq2lY2KI2+Sp2c6FO781kA13FTc1iQjBKqTUDMWr3M4U9xrsoOd1TxyZJq24V
         i0ASi7JqbErAX65MfVhtzq7YpSIO1ciH2YSO80yBrdmZKmoFk+dBHUtBha5I6WXthefv
         9sxQ==
X-Gm-Message-State: AOAM532NknXFF4VAtcPqT5xdYOnNZmrADIygvwCLbkAggwwD/asNlcKa
        SeHpBdq+NYSD6ECzp0+10lgn7qE1aP0=
X-Google-Smtp-Source: ABdhPJyd5svtqP0BEo5gsyIRzFyddVJJ1JWFq++5pGKbdlzTD17/p3yqM//OY58zJk1TQbqtrtdJrw==
X-Received: by 2002:a1c:c287:: with SMTP id s129mr19692931wmf.79.1608609501266;
        Mon, 21 Dec 2020 19:58:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y11sm24865083wmi.0.2020.12.21.19.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 19:58:20 -0800 (PST)
Message-Id: <1f9af0e991c0b84cd00641322f2d76bdc8fbeb29.1608609498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.820.v5.git.1608609498.gitgitgadget@gmail.com>
References: <pull.820.v4.git.1608599513.gitgitgadget@gmail.com>
        <pull.820.v5.git.1608609498.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Dec 2020 03:58:17 +0000
Subject: [PATCH v5 2/2] negative-refspec: improve comment on
 query_matches_negative_refspec
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

Comment did not adequately explain how the two loops work
together to achieve the goal of querying for matching of any
negative refspec.

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 remote.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/remote.c b/remote.c
index 4f1a4099f1a..4d150a316ed 100644
--- a/remote.c
+++ b/remote.c
@@ -736,6 +736,12 @@ static int query_matches_negative_refspec(struct refspec *rs, struct refspec_ite
 	 * item uses the destination. To handle this, we apply pattern
 	 * refspecs in reverse to figure out if the query source matches any
 	 * of the negative refspecs.
+	 *
+	 * The first loop finds and expands all positive refspecs
+	 * matched by the queried ref.
+	 *
+	 * The second loop checks if any of the results of the first loop
+	 * match any negative refspec.
 	 */
 	for (i = 0; i < rs->nr; i++) {
 		struct refspec_item *refspec = &rs->items[i];
-- 
gitgitgadget

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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E525EC433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 01:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4BA822525
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 01:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgLVBMj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 20:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLVBMi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 20:12:38 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E05FC0613D6
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 17:11:58 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g185so603956wmf.3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 17:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=78P5B0EZI5YNm8H+irWULeMUTdacwATcznV9pFTYRBU=;
        b=N4BVeBnPCTDXKA02H9vC1Bh1U+7YhPl5QiZ2Y4hrGuYWgqWQlFslLKnTMmslo/IDdR
         a/5ONvsmv5lEJJVQS5AOsHaJTyS+9yrdvAnJRrf3nJ1JY4br9QwW9tiB2Ez+ZaZSm4ow
         +z22pDyKHdDzi9Qw3DV2CJIIAmHtu6QuhJuz/plvLhTwL99I04Z2ipzZF4u4rFs/8k2M
         RiXZyGDysdsIrU8S/CL1f092mnbbgdwZTCEck5r1+LCP754GMyJe03lRS9WuSU8vPVGU
         XXQYCje9hxoA6Bp+PvJ0mSegktyiovupU5vy3qHOhOv2UCFt8oXSpOiuyi3OGdLL9+D5
         f2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=78P5B0EZI5YNm8H+irWULeMUTdacwATcznV9pFTYRBU=;
        b=Hxa2QlvN1LG9URMnN7UlUVc/uuVpfzk5q6FCdwMnYKFzbttPTryM7AqNuQ+IRA41gT
         s7eTfg5M+Vt/wPyI3jOJyHenPRyLg2V0sLIY1ey01OMhFNy0HXPbvsq9lf4ItDOnk0JT
         8xmTUWtopbCs2LquygjxGQVYd/N9PjxLpECF/B/MaAZSMHCAw7iQCObGGeAlGIDOY+Q9
         ETnZBvrgU7y1pbWp/G1FDb51zXbwlM8lPD05v6TNzrVAp0elnKDbiQlJd0FwkPHA5sed
         leOtjgNLxavzdqDVFDF7zOAsx0IctW4yNTRP8XQaDz8wfB3PTzybC+cv0ylNlFRgl6uu
         P5cw==
X-Gm-Message-State: AOAM530hzdkixENmE2QwAgttfhmqTODbopsisCZYe/qi+0Wa1NTCM03W
        6FBYFSA7BCeST4j+yXTMkykUqF+w+IM=
X-Google-Smtp-Source: ABdhPJxz5Nn5lCoBG5dh/jPv8XddnXVGf6G8Z6p4Ub4urEc02zH2EVF+FUO85z7C7YfGKixjc/e81Q==
X-Received: by 2002:a05:600c:224b:: with SMTP id a11mr19022129wmm.97.1608599516918;
        Mon, 21 Dec 2020 17:11:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y2sm22453298wma.6.2020.12.21.17.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 17:11:56 -0800 (PST)
Message-Id: <20575407cc0d60a1c0a0f8251b45b2e5a317d465.1608599513.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.820.v4.git.1608599513.gitgitgadget@gmail.com>
References: <pull.820.v3.git.1608516320.gitgitgadget@gmail.com>
        <pull.820.v4.git.1608599513.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Dec 2020 01:11:53 +0000
Subject: [PATCH v4 2/2] negative-refspec: improve comment on
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

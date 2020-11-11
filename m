Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EC5C56201
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 030C520829
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2Qk3E6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgKKM2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 07:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgKKM22 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 07:28:28 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CADCC0613D4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:28:28 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 10so2104225wml.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=js8oUsMHl21kgw69PYKoHcc81MiST6F1XqDnN0kNdcM=;
        b=G2Qk3E6yMszllmLDrZ8b7zhQrb2FM6lBbCkzpPFWcBC219yALjOe2tAcoSerW4LN/b
         kCeBXumrcHLHyrXSeQ2tAa/EeLgpjoGAaOt/l0Pv7BRt6ndKFBMuY+mlYixiafzDNDCn
         u6ySwaaZML6A0wWvlfEsCq7dtJD4V/LRXEPFu5+O7AcK3/tl8I0JslxfHT7+cGRepFR5
         u2rR7NswZckY+aPBgm2mMQBZDOJeaUs+sHGAPt6Rt1bW+TfwelEqSls1isHwoo0hVIb3
         5v01cCS6DHzxXu+gf7CTDWg9NHegwOIdKaUcdt5SaTt2j06uY+/8VonfHcPtsXyiDVkm
         bF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=js8oUsMHl21kgw69PYKoHcc81MiST6F1XqDnN0kNdcM=;
        b=OtUQpIY0yu199bW40MeNI90aWKUDZWubMIkf8sYWqYUejeBxpq9gWYwqLGDLKYncGK
         CxcWynNKLyol5gCkqAj9Zp8GBZOIjkp6ySY8xQSDy1zPpPhY94k3LuhbQaxL4blpe9vL
         swb9qKYqBHWBfg0N01mdJ+htT3Bc+QJTQ/3xKfWtKWbHmCUsbAQFTpxvwoa/c18Z9tb6
         1QQLBZEv+aVfLhHSDJjKBbQOVZrFvcKxs/cTIC8P+g87Xmq5Mr7+z0G6sVPNIAjoAEei
         1pNfmWpYxv3pTt394Y5hSnCv3vlbJztjil+w5UGR0lliQGoG1HZ4MtALWto52y/T5ycK
         GG1w==
X-Gm-Message-State: AOAM53378RM5POHuvt8PeIdhRV8+LF7kSG5sqR/jdXrp3HZMF0qk7VXj
        xwuxJ7CumVeTjOC8AeSK7xkiKFqLy9g=
X-Google-Smtp-Source: ABdhPJy2zQQweM1RVanVNWADbd4YDj/3QeRifS/ElPjwSW3PCUbePOr/e5yMyU3T9fhk4liQ5j7S1Q==
X-Received: by 2002:a1c:bd08:: with SMTP id n8mr3847908wmf.136.1605097706634;
        Wed, 11 Nov 2020 04:28:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s202sm2386861wme.39.2020.11.11.04.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 04:28:26 -0800 (PST)
Message-Id: <6152122c04aacf8c3e3f1aae7b73995da6b9e354.1605097704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
        <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 12:28:14 +0000
Subject: [PATCH v2 01/11] add -i (built-in): do show an error message for
 incorrect inputs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

There is a neat feature in `git add -i` where it allows users to select
items via unique prefixes.

In the built-in version of `git add -i`, we specifically sort the items
(unless they are already sorted) and then perform a binary search to
figure out whether the input constitutes a unique prefix. Unfortunately,
by mistake this code misidentifies matches even if the input string is
not actually a prefix of any item.

For example, in the initial menu, where there is a `status` and an
`update` command, the input `tadaa` was mistaken as a prefix of
`update`.

Let's fix this by looking a bit closer whether the input is actually a
prefix of the item at the found insert index.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index 555c4abf32..8ca503d803 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -194,7 +194,8 @@ static ssize_t find_unique(const char *string, struct prefix_item_list *list)
 	else if (index + 1 < list->sorted.nr &&
 		 starts_with(list->sorted.items[index + 1].string, string))
 		return -1;
-	else if (index < list->sorted.nr)
+	else if (index < list->sorted.nr &&
+		 starts_with(list->sorted.items[index].string, string))
 		item = list->sorted.items[index].util;
 	else
 		return -1;
-- 
gitgitgadget


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3F9C61DD8
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CB1D20729
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIFfmU7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbgKPQIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 11:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbgKPQIg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 11:08:36 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1A3C0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 08:08:36 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 23so19238413wrc.8
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 08:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=js8oUsMHl21kgw69PYKoHcc81MiST6F1XqDnN0kNdcM=;
        b=ZIFfmU7X4eeH3Itq/a2AXgbmYbsAgRJSJDbp2W5f08pSF5nPjjuhBzNo6PYgnkiOKZ
         iD56OS4Yaxbw/XC/xdk6/Xsvjvi6Q/kJi0hO/qLrT2NXXL0NQl2ZFpWsQIJoJ5LixNlw
         3CJEslG92swnCLT5YBvwSyRfgC+ZJB1hPsziENfHrgmQZ7edwQKWDw7INYsUIUHsGzqq
         SmmUp969VpD6hszIxLnuBIvVicg2n1jNQLSiMwZV4MMnBMGOveSkn0fwTTKxpG7w0Cqj
         GTlGUASbDDkGT5Xhq1e2Yw1JM0zQcbcPikpMQo6JBTpeWnHVsN6CMJncvzE7+RYxRgtp
         PX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=js8oUsMHl21kgw69PYKoHcc81MiST6F1XqDnN0kNdcM=;
        b=cnkgQ7Pnmei2x6YA9Fgd/Ky+UkzaW2s5f8dDGZxRdetsmk1Vp/lurZAdQkxywXOJq1
         JQPoVC1FQzmhBvuB3Ldf928LDeNz73/cWNPUXzzXntNjVXc6e3kpI/P6oYkI/1i1ZINJ
         WzjHMPvX++csqFvZ1lOmsBcd25n2mAmgNekWOmPdO8g7rFN1i16OCNhasQNiyv5UnFLK
         I5dChzKM2/JNjxH7N7RFd9i7WvcSjkDp/xQUiVp45jkV9Wa5XPIWd7XoEwcN74w/XsW4
         SWzIWP/gEJyra2inx8HtEuUC5kUQUUN+HN0ZNrHWFgzqBYMl4d0KNj5ZX+DHF5CTY+D2
         2M2g==
X-Gm-Message-State: AOAM533iXhZ+TkgvZKax1Tnjz1CJpjAQpoBYDmyqQmIt/5EWkjBNuKKJ
        k8srunpmisDin2WydgHcLGpGTgGBYJA=
X-Google-Smtp-Source: ABdhPJxAnmhb6Uwt2ECP7kBVYAU6AeCVAULzlNW169/nfy8Hcc+hjTvqnWQoH0yZ2Bs1S74N2JK39w==
X-Received: by 2002:adf:fd85:: with SMTP id d5mr12265895wrr.99.1605542914713;
        Mon, 16 Nov 2020 08:08:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o197sm19720452wme.17.2020.11.16.08.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:08:34 -0800 (PST)
Message-Id: <6152122c04aacf8c3e3f1aae7b73995da6b9e354.1605542912.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
References: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
        <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Nov 2020 16:08:22 +0000
Subject: [PATCH v3 01/11] add -i (built-in): do show an error message for
 incorrect inputs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
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


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC16C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 16:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjBBQxW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 11:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjBBQxV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 11:53:21 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077C06278D
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 08:53:21 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id g9so1638355pfo.5
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 08:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V+iTmn9SQhti6Et6Jti5oB0Up6MpQcsg9oIqAHp2Zd4=;
        b=mjB4bbf5LPhoy6Wpe8Ct3qKS99E5ebSwZxCrtuGqUF22d9vZ3k0kXSIs/jmHfK6fsp
         GFHqB0OT6l8QvtWEE7mGFlgpdzrMSBj+zAkffXofpUiqxUGtIaWlB2RpX72gBVuXO2e8
         13+/6M19VfnUz33EkCcKVD8KTKGxDxVXlABP8mvZSy87waEW8FTj/5HHfp/VsmErtaxM
         tdeiZADycEpJy+DG8BT16jti+sbMNdSinXtxtPnAmgexAsIPgp3Yu1czKwdLOGhknaq2
         DJxXwBHNchbIzbAk5cTwQfaXLpN+Q4Hnb/MnEO5V/AFFMLYMZZoxs++/175DSZ9HT+gr
         /Xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+iTmn9SQhti6Et6Jti5oB0Up6MpQcsg9oIqAHp2Zd4=;
        b=xpY/ts+CS5BgbH968YykMezMkp7Taj6baNAeseiy/bL0dmJO9u9g/AngHOcSFhToBm
         8C7rUsec7cUwRMfTFguTgIVRkupiXZfUIkTSGL8hOdSj0NpubsIGEym82dU5EdDiHFHT
         yg3DDpKCvSnmgR6TG4eH+4B+XBMq6ggpbQ8cqPYnS2wVSdrmWwknsHpvNPb/0CQ1LZN/
         5eQUVdyrenYjkL9jZ8k3w1Odlwvp7zgf6Xg4WXubFHrqJll4AitkvPGY8ehTHJCnWIVM
         Moj7yD2VXGqia774r5Oz68nKhgmxd8hIpPF+CUFnza2M/clRFk4oonH/pCLhAVUGd294
         sDKQ==
X-Gm-Message-State: AO0yUKVbVbWdnNvRh8zI8M0TK52W0AFmKd4MEwebA4NIv2NmxobKhdWO
        dwHn6BdBLJiCEiuC1zXFbKHCbN+HJDcf/A==
X-Google-Smtp-Source: AK7set/mjT9nCY4Y5DAzsZEiSklAjvespA7m3i7T2tZ19i2RnialPyKtlCPhFg6uOWIOfzz02HWUDw==
X-Received: by 2002:a05:6a00:1c96:b0:593:893f:81d7 with SMTP id y22-20020a056a001c9600b00593893f81d7mr5494080pfw.16.1675356800143;
        Thu, 02 Feb 2023 08:53:20 -0800 (PST)
Received: from fivlite-virtual-machine.localdomain ([49.37.146.182])
        by smtp.gmail.com with ESMTPSA id e14-20020aa7824e000000b0056283e2bdbdsm13872374pfn.138.2023.02.02.08.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:53:19 -0800 (PST)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Kousik Sanagavarapu <five231003@gmail.com>
Subject: [GSoC][PATCH] merge: use reverse_commit_list() for list reversal
Date:   Thu,  2 Feb 2023 22:21:41 +0530
Message-Id: <20230202165137.118741-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of manually doing an in-place list reversal, use the helper
function reverse_commit_list(), hence improving code readability.

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---

This patch addresses the issue #1156(Use reverse_commit_list() in more
places) on gitgitgadget. I also would like to submit this patch as the microproject for
GSoC 2023.

 builtin/merge.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 5900b81729..4503dbfeb3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -736,7 +736,6 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		struct commit *result;
 		struct commit_list *reversed = NULL;
 		struct merge_options o;
-		struct commit_list *j;
 
 		if (remoteheads->next) {
 			error(_("Not handling anything other than two heads merge."));
@@ -757,8 +756,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		o.branch1 = head_arg;
 		o.branch2 = merge_remote_util(remoteheads->item)->name;
 
-		for (j = common; j; j = j->next)
-			commit_list_insert(j->item, &reversed);
+		reversed = reverse_commit_list(common);
 
 		hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
 		if (!strcmp(strategy, "ort"))
-- 
2.25.1


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8566ECAAD2
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 20:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiIAUBl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 16:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiIAUBj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 16:01:39 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8134190824
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 13:01:38 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id q14-20020a6557ce000000b0041da9c3c244so14507pgr.22
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 13:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date;
        bh=yzQkzOxh+lEPFlFozQHcQ8qcKuCz1Q7HA1lrwa1pgIU=;
        b=PmSuX+1So47pZiJdcsn12XkKpc+zXC7UItohCCC1gIdVyc3ir7QLQemq/S04RX1oDm
         VGGYVEba2eDvS4L86uxCoW9YoeOUd08IRe28nO5ecHHtImEJ60kr4yHyGj66/kXSz7LI
         DQN1FQGDQ/EYIlyDjKtGbQcU//bMKtxaxgHkrJvwiQBrd59oaKKVdtaCuSXbe4TBXgyu
         a6ZYmZnJnPnxbBu8X5EmId1RfuAvlnZeo9U93Vrz6iaKDk1U35zZ005HF5kcW2V5HxOB
         tq5x/vl8EcPFUuNQiKkcrX/5jsHvBvWmGd9CWurfItcOy7I3UnGmN6Cbuv778ymie0bM
         RT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yzQkzOxh+lEPFlFozQHcQ8qcKuCz1Q7HA1lrwa1pgIU=;
        b=qPKb2DNtqA9FjVI0kTFRRrK+3m2yE4EXshq+kyugzaEtJxETGbjsCpEcXaVrGUyAU3
         rZuZ84PoPFcruCf3Iijx7ilNmew4ps+fV+dwcSgYviWt+KhGtK44GrYbf/VGR5qa6ekA
         +XavHaG9cpPWNuz47w1nu1GInaaNSomNFGk/wQNbWBMbw5rKUsWTC3dhxj7qX1/qmqX0
         8n6NdbDx80X5NuWve/2SZMrmtDfrDD4CUwfS89Y0nhGfkCE8yKJe64bM+9tRe1k+Wa+L
         6+Jveji8/cODf+yR/1TLQMVM9PTw6GzIj4K2NIWEJpY4nyCk/HuyPOQoJJjnS+Pad2XI
         d7Iw==
X-Gm-Message-State: ACgBeo1+FCPZv2EJtJ6bhIT9DEuX3tMZYdHEMHq9R+DPiJg6iXsQvCfp
        OHUnk3vlZI7umnaYLQVjr7emXV66HbQGwpgZFuph
X-Google-Smtp-Source: AA6agR7gFVRRvkI1ER5B2swBSVyU0tm5lkcfdsg92DH/4hHXVqzUTfQEorQqEiRuNT/I2liop9ou/qoqkDB5eZVEEI6E
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a65:5683:0:b0:41c:b103:6037 with
 SMTP id v3-20020a655683000000b0041cb1036037mr27205145pgs.367.1662062497899;
 Thu, 01 Sep 2022 13:01:37 -0700 (PDT)
Date:   Thu,  1 Sep 2022 13:01:35 -0700
In-Reply-To: <eab40dcb296fd6a6ea14d13107cdc3ca6e64e311.1661806456.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901200135.515907-1-jonathantanmy@google.com>
Subject: Re: [PATCH 4/6] submodule: return target of submodule symref
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> diff --git a/refs.c b/refs.c
> index 90bcb271687..d72015c95e9 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1784,19 +1784,21 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
>  }
>  
>  int resolve_gitlink_ref(const char *submodule, const char *refname,
> -			struct object_id *oid)
> +			struct object_id *oid, const char **referent_out)

s/referent/target/ throughout this patch, I think.

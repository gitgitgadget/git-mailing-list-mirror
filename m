Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8BCC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 12:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB4820714
	for <git@archiver.kernel.org>; Wed,  6 May 2020 12:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NN16Pyt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgEFMDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 08:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727067AbgEFMDi (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 08:03:38 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E757CC061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 05:03:36 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id t3so415379oou.8
        for <git@vger.kernel.org>; Wed, 06 May 2020 05:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/jXdNBkFcRylaGr/TE1Dw754Y7N7t7dZxoxgHslkXWA=;
        b=NN16Pyt7D6+wQVF+t686QwpB7OuSRI+71nHfabCsr4fC2NTOF6aU5A6xl4gfITGlL/
         CNwNqfqyJHJYChpFUWCnhC43MXG5jUaSA9yuykwGWcAZFeSPCk8prkB5cheAhYU0ZI8H
         /tP6udyBJyO0syoNAuNWpDD2vKEGsQJ21CnWV9QV4H+P9j0ScH+hJNQAdgsgqq2QDHDv
         JCgHdyhL2RnTatv06ynhyE7wDi+v6jHRifAPK0zCNlwDbx50lgu8SACYcC0ok+f2UFlH
         Rt8ncDEKLyDM662Q5nkpLAX+Uifc8XEdxAhvTCzGZ4qWDyfIzCdUWVF5G3CtkboB8f0F
         q0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/jXdNBkFcRylaGr/TE1Dw754Y7N7t7dZxoxgHslkXWA=;
        b=tH8wcbPAYgTk33yeFXv/PSUejO0F5vY6oMFwvWHVSQ5pdtBjz+8Y0Va7evBoh87+Qn
         58Lj947VkOmZdZ11A88FVtr0OA24/h43MRTJqWDbQ19v3KUJwgG7hggpxmMtatrRkdGh
         ZGFH0RSTntZlJ6YbQ4zpoZQ10yzg9GbFwGoJ0P7eVIjzYlMgiU9VqO/uYkF2EBislLVU
         cnrmKrOzKTdnDe+0Qx5LCtQnZmA39FXPtq2FYVke2sl2bzFy8gZC1g3gXDi2weNqAbcp
         736NBX/2JsmXVthaJbfJF6BFikOOmZu33lY8nRMG0NI53vbWyAJ7BROQBYm9iK8FJxtT
         GhLQ==
X-Gm-Message-State: AGi0PubSKVooFfF9TEs/XJM6bQebL5ZMHcFNhmr8qWBdcQlHjHBvXsMV
        cF54+71OFVEG7LY0SE0G+wwAHCPYrSQ=
X-Google-Smtp-Source: APiQypJtGZaCtnZbCf4zXvN25/UrWopL4RASdeklDCE4aOCmL5jwmSO1Eb5Y8fIfVl0Y4oW0w4JPFQ==
X-Received: by 2002:a4a:615d:: with SMTP id u29mr6955753ooe.15.1588766615967;
        Wed, 06 May 2020 05:03:35 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t15sm545881oov.32.2020.05.06.05.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 05:03:35 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] midx: apply gitconfig to midx repack
To:     Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Son Luong Ngoc <sluongng@gmail.com>
References: <pull.626.git.1588684003766.gitgitgadget@gmail.com>
 <pull.626.v2.git.1588758194.gitgitgadget@gmail.com>
 <21c648cc486cf1abee51076d21e55649b1464516.1588758194.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e991e5af-83bc-d868-473e-54ece3489a7e@gmail.com>
Date:   Wed, 6 May 2020 08:03:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <21c648cc486cf1abee51076d21e55649b1464516.1588758194.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/6/2020 5:43 AM, Son Luong Ngoc via GitGitGadget wrote:
> From: Son Luong Ngoc <sluongng@gmail.com>
...
> - `repack.writeBitmaps` when `--batch-size=0` was NOT adopted here as it
> requires `--all` to be passed onto `git pack-objects`, which is very
> slow. I think it would be nice to have this in a future patch.

Just my two cents here: the reachability bitmaps are really tied to the
idea of a single pack right now. To create bitmaps, I would currently
suggest using the 'git repack' builtin with the proper options. That
command deletes the multi-pack-index, unfortunately, but it also produces
a single pack and deletes the others (when creating bitmaps).

You are right that the `--all` option required to pack-objects is not
appropriate to add inside `git multi-pack-index repack` as that changes
the pattern. It requires loading all reachable objects, even if they are
not already in packs covered by the multi-pack-index. This at minimum
violates expectations with the --batch-size argument.

Integrating reachability bitmaps more closely with the multi-pack-index
is certainly on our radar, but is a large endeavor.

This new patch looks good to me.

Thanks,
-Stolee

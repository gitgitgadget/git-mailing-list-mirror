Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEB9C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 10:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35E6961457
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 10:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhFOLBT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 07:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhFOLBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 07:01:16 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741DEC06175F
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 03:59:11 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso1973349pjb.4
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 03:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6mYzJtn66P4PRFu0DzPbRwQCoGcbG05h+H0cxLNMRRo=;
        b=eqerm4dVlpuDwp0lNH7tt7xTSKyFUsSk64sqxuADeOrgkFnHxdZ7Ph97tfgP7sTUO6
         qPo8be6qOEkeAmsuyfLrg7jEzs7ba9ImrIytb+BFIVGOhYiLUF8P7tjEx8/oBFI837R3
         h1NocAfq1i4rT1tkCjR6o4yHsoIx52+WT8JDY7QP4o6K6AXDOPivNigdb1pJ+2u4LMvf
         TyxIkWMi0MJKlKJucVDG4WUEDcUdpSIEfWc+ICjTAcZ64eMtdTdn5S+saH455mBMwYFp
         i+vf4FWlKDCcK76ol48rBXCLtWYrP7M7mKOIkDpM8iaot1HWAuelpulon9SouKLpXrsX
         WlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6mYzJtn66P4PRFu0DzPbRwQCoGcbG05h+H0cxLNMRRo=;
        b=Y+203oz2OWYaem++Kodc9YES4bdxx/bMtiBTUls3KRpHHOnXQ69iiwllcsdF8Kblkc
         Il1KOpiZVDjNclMTq4CkWssqCH7b+TxXOXDb+QGDcyTPyyvYF83bfeHQQF3FY2gg56+b
         hbnxje3jaSlpJc1tToG3w8APsX8qq7t6zrZvlauFcxNIKNFlRZPtw6nvYmkJvW+hwJMR
         5qZQxtj3xPo8ditxz9Fy0tKoYDg/l3miO2Guemgse6fWmckE7sbAXyan7gMQBM5accDG
         saEHYG4GLTKLMg8DudUKn851EYytjWD+9gHbbI5V1aRPuJIOTLGAwS5wpTfb9dCfP0AI
         HNCw==
X-Gm-Message-State: AOAM5305XoohGUeNSXKtB2y/MTfBOsFE11ahC7FyG57yEk9AJBGKMwMY
        U6ZD5VO3l5SbuU3wLbpPcvuA56jBlCzNeg==
X-Google-Smtp-Source: ABdhPJwSZTh6yR2haaNL5E5/S2ZGDA/IRLxL0RAGj7uMO34MUf7q7CruIE/0BcD4ORbRbt9pMbNpxA==
X-Received: by 2002:a17:90b:f07:: with SMTP id br7mr24901374pjb.141.1623754750751;
        Tue, 15 Jun 2021 03:59:10 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-38.three.co.id. [116.206.12.38])
        by smtp.gmail.com with ESMTPSA id g63sm15160737pfb.55.2021.06.15.03.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 03:59:10 -0700 (PDT)
Subject: Re: A suggestion: more readable human commands
To:     it-developer@abelardolg.com, git@vger.kernel.org
References: <fa2e886dd03a26c945d9deffe6f96d48@abelardolg.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <c3855aea-6cbd-af30-7791-07c212c52bbd@gmail.com>
Date:   Tue, 15 Jun 2021 17:59:04 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <fa2e886dd03a26c945d9deffe6f96d48@abelardolg.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/06/21 17.51, it-developer@abelardolg.com wrote:
> Hi there,
> 
> I would like to suggest you a new improvement.
> 
> Why not adding a new layer of abstraction for commands or to make more 
> explicitly the commands?
> 
> For instance:
> 
> To merge a single file from one branch to another:
> 
> git checkout <branch_name> <path_to_file> --patch
> 
> would be like more readable human like this:
> 
> git merge <path_file> to <dst_branch>
> 
> It uses a more natural language.
> 
> Best regards.

What workflow you do so that you need to merge single file?

-- 
An old man doll... just what I always wanted! - Clara

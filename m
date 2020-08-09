Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75263C433E0
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 15:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C3AA2065C
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 15:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBc8DK4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgHIPZ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Aug 2020 11:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgHIPZL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Aug 2020 11:25:11 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573A6C061756
        for <git@vger.kernel.org>; Sun,  9 Aug 2020 08:25:10 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f12so5916341wru.13
        for <git@vger.kernel.org>; Sun, 09 Aug 2020 08:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z3dybSeIrR2QaVDntKKWOQ2BLPpAt4ChtsOGzT+FfSQ=;
        b=FBc8DK4pXrUzweMJceviUkg1ZH51Q1mAXRPuWlIQFSEwPwVmyehf98UlUfVIM4u40M
         AyBPLOhNW1uSbAjYonnXtsvdzk12TePSbAKt2BC98HnChGpzkuXnD5YpIsq2cAHg3nyr
         YleNDIMH0V8wH0PuqGoC18U8wFTxYxMRu+ebrXbS1DKidUPcVLgPeab4AMA7pnAAy4a7
         vUCKUfCQxmwd58B4CTWfAUlaQQUYovZQjFhFcvfPYnkiSuu49qq5ZijbOdvDLwjmTsbO
         q5vhSJbOtvBv66B17l9BOqJUWGEOIM6+OdhWT1ybalAYXhChtSRylDivGhVi5Xt2+Xi5
         cNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=z3dybSeIrR2QaVDntKKWOQ2BLPpAt4ChtsOGzT+FfSQ=;
        b=de+utAwIajxMmmN196k9yjaMUihWc4ll+0l1ODXshKpFqaX/9LPjXRxgiew348rCCR
         JxhuTVIRM3hyLOMVpWm12jiglJ8dRYQK61IFs5XJTBe794nqe/9hPV4bGrunbBA/ecXk
         TRG0m13pKjQtBpxONNcghyszb3CMPcEHuH/jBVZ9eZPyVC2dk9mlsF9ZTRU5VXoihepy
         CLCxWB3oGOS4QrYNG3WpQQ1MnJ1EyyDXYPHQFwn4aXBJl/Y+k26aaw+FrqeBPgMDMiZJ
         XdKvm/mt3XaMqrkrhVRoIKFAssVSTjXasiewGE3Nm+gRx8TWZVHObLbEk1awYFkB+jtH
         E22g==
X-Gm-Message-State: AOAM530zTludNEoR3isvZWickG6W9cho6KtbPW7rTZTRSjkQzRqQE2TR
        p5WXpxuD5R2AvZmXY72k2+dtmkxF
X-Google-Smtp-Source: ABdhPJw+W1MAeUdSjt0R8wiRvUdiYScdsZtSxiLDnsowL5dJbUYP99pTg8WNuQc/YX5tauFxM8m8xg==
X-Received: by 2002:a5d:42c2:: with SMTP id t2mr20731889wrr.396.1596986706042;
        Sun, 09 Aug 2020 08:25:06 -0700 (PDT)
Received: from [192.168.1.240] (161.252.189.80.dyn.plus.net. [80.189.252.161])
        by smtp.gmail.com with ESMTPSA id c194sm17976796wme.8.2020.08.09.08.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2020 08:25:05 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 2/3] apply: make i-t-a entries never match worktree
To:     "Raymond E. Pasco" <ray@ameretat.dev>, phillip.wood@dunelm.org.uk,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <C4RQMTXM9R7C.1WK5637SFISUU@ziyou.local>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <e52f7048-45ab-1f5e-1b04-30bd9b98d9b2@gmail.com>
Date:   Sun, 9 Aug 2020 16:25:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <C4RQMTXM9R7C.1WK5637SFISUU@ziyou.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Raymond

On 08/08/2020 16:58, Raymond E. Pasco wrote:
> On Sat Aug 8, 2020 at 11:48 AM EDT, Phillip Wood wrote:
>> If I've understood correctly an i-t-a entry in the index combined with
>> nothing in the worktree is a deletion and that is why we don't want
>> --index to succeed when applying a creation patch? If so an expanded
>> explanation in the commit message to this patch would help rather than
>> just saying 'by definition'. I'm still a bit confused as we don't count
>> it as a deletion when using --cached or applying to the worktree.
> 
> Nothing that complicated - --index requires that the index and worktree
> be identical, and nothing that can possibly be in a worktree is
> identical to an i-t-a entry.

Oh, so --index requires the index and worktree to match and the worktree 
cannot represent i-t-a so they don't match. I'm still not totally 
convinced that it is useful to prevent a creation patch from applying 
when the path is missing from the worktree but is marked as i-t-a in the 
index but I guess it matches the behavior the general behavior where a 
patch can be successfully applied with 'apply' and 'apply --cached' but 
not with 'apply --index'

>>> --check goes through all the same code,
>>
>> The same code as --cached or --index? (I assume it's the former but
>> wanted to be sure)
> 
> "--cached --check" goes through the same code paths as "--cached",
> "--cached --index" goes through the same code paths as "--index",
> "--check" goes through the same code paths as [no options]. The option
> just makes it skip the part where it writes things out.

Thanks for clarifying that

Best Wishes

Phillip




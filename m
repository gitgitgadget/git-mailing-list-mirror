Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75354C433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 12:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C4B42080C
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 12:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCSc5QR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgHLMpI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgHLMpG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 08:45:06 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DC4C06174A
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 05:45:06 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id e11so1794120otk.4
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 05:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jaQi2nXF+mmQ/TPYjiAlrnWvWSeaILJ8OhsLH9TbzcI=;
        b=aCSc5QR1Et4z4SZv+tIoKYxw1K4oq8catpTvlAk3T+hp3vIPk0QlecQngmps3N8aFH
         xXaY3Fzo+JkHPmBffRbqGLdRo4y+6X2KnD6S0VBpmwnA4zdoMNrGbLPunbQcknJN0fkX
         H32R8sy7pgEnzC+2w4D1DG9+n3NiiaYZRkWaSDQS5TbNO5RHtWCMoyyatuxqSDJDggZd
         pgV7g7Fm7ZUrzWWrGOIlKmcGynItlRbPlyIM3eQsMtnBifZl+5ZD0og/aL2VTxLDUR3+
         IcAXvEl/wSxt+nNSkOSkddBpm7Y3eFIJVstiKlh0mAofW03z/8fPUC+NAwokVzBvmBI3
         UPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jaQi2nXF+mmQ/TPYjiAlrnWvWSeaILJ8OhsLH9TbzcI=;
        b=KTXxgyBXa7cjBrFm/bgsqmpZQLncCPcU0DgspxUJQjB/bysWXXLmlI12l4qpXgfRHa
         84ayY8jYH9X/o6Nnmeiu2s/cP2Ac3ju8+SWtXwJ/C2TPGSXUoOpi+umhqUZkdbFf9oi+
         wPFJNe+S6PD/9DT/K+AxRMNksXBMHks4VI/AEJe5dW2a/x85ml+P757BYdPQAHIBBcNx
         f8n6C0C3a2LJ+nkTl0ki2S3iSQutc7qRxWWlro+0JGxkrfWCGBb67Bsg42I5Le6zIufM
         cSyf4hzIFnbS8SP9quuXdAEeBvExg4HSxnEwXgTWhNjZM8bWIL3P1FTrZodWzauTCdrQ
         L0Yw==
X-Gm-Message-State: AOAM530CkyETX0HjuDCMhcNM/OhVEPei7BEU1+D5jm85P8HZBWubRNA2
        FCRBP0UOnWwMlKhqXtNjICg=
X-Google-Smtp-Source: ABdhPJyyt22itzlZJI2BQ4hw26G3g2vgG2qQYLLPuWAAUIx1/Sv1QtkXFSuIeITX+5dP1zuYxncnkA==
X-Received: by 2002:a9d:1c9c:: with SMTP id l28mr9642226ota.127.1597236303141;
        Wed, 12 Aug 2020 05:45:03 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:79ce:9d5a:1dc3:8f14? ([2600:1700:e72:80a0:79ce:9d5a:1dc3:8f14])
        by smtp.gmail.com with ESMTPSA id x21sm396314ooq.30.2020.08.12.05.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 05:45:02 -0700 (PDT)
Subject: Re: [GSoC] Blog about weeks 9, 10
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>, git@vger.kernel.org
Cc:     jnareb@gmail.com, me@ttaylorr.com
References: <20200812064627.GA40904@Abhishek-Arch>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <af5ccced-7cfc-23fb-11ee-244b31b73d20@gmail.com>
Date:   Wed, 12 Aug 2020 08:45:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200812064627.GA40904@Abhishek-Arch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/12/2020 2:46 AM, Abhishek Kumar wrote:
> Hello everyone!
> 
> Over the last two weeks, I worked on handling mixed commit-graph chains
> and adding tests for the new premises - New Git can work with commit
> graph files without generation data chunk and New Git handle mixed
> commit-graph chains gracefully.
> 
> I apologize for the rather slow progress and missing out on the blog
> post for Week 9 - My college has re-commenced classes on 3rd August, and
> the transition to online learning has been chaotic and uncertain.

I don't think your progress has been slow. Your patches are coming
after careful testing and I'm not seeing any "new contributor" mistakes!
The only issues I'm seeing are these "higher order" problems related
to mixed Git versions and striving for "perfect patches".

The early school year is causing chaos all around.

Thanks, and keep up the good work.

-Stolee

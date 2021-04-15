Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5548DC433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 02:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2114C611CC
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 02:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhDOCmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 22:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhDOCmu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 22:42:50 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2D6C061574
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 19:42:27 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id c6-20020a4aacc60000b02901e6260b12e2so2570425oon.3
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 19:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZLU1Un74DBqqJ/8xb4Dr9tLo6HKEi3qNiQvStqQNEcc=;
        b=D3LztMPetgpESlJ13tuQ5HcAXS22SWGXBvEChFRXUzjo4ctih45J6Q0yQSg7+QWuFv
         w8sfCcGAp9mU4/vpw45tuETi/ydh66fwbgTErahja+RA6NYIyCasydHw/gHEIAVWD4gQ
         uce9s5pj5dhK2Q5Xbolu4Uiw9SF3NB7C7m3jrtBsfPRtJTElEa13u3GhSwuI3TnI+SBb
         oqB65d+B8RPx6m8tO7dYGA0ykQTcEteXQ04vHlzBb1w66c5esSjgy8euHxwUsvknwC+2
         hAPEw9EhHhEl1XMhKndnjl7wFUlsjKxpZLwJRXeqcQL6LFX5HPwqKarQ2QMIQwucpKdE
         NEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZLU1Un74DBqqJ/8xb4Dr9tLo6HKEi3qNiQvStqQNEcc=;
        b=MLRpc0W0EMrEzfpvhxKpnRVAr3WBBLPcUrVCqZi4QZaTpe2E72mNvGeGufZ/UMuaNW
         Q7TxiehT5VQL/KptkfiXB+orxouh6pNx3LOS7PVk6Gu7I9cnfEAs8gOndiyfYAWAIdH3
         YOKEdWZHDSLJvoOw47NldCgJ7ReErtQChvdcAovkPI7Ypt5W/oa1OMq/HaV9Q78WzMcw
         wfTqhCBlY5qgh0Zxe4rA+qG12sW98tRC8beOA3zG+lYnoxSFF9cy2VWei+AOYUCWNrVh
         bAd6mVzLE7hAxtFeSpy7SHNntBiL5VWX2Md5idOOOllgwecxuC4vHfOCLA1Um00odIvV
         /r5Q==
X-Gm-Message-State: AOAM532YXHFi9cKVaFW/yiqFbHQ2hHm811Wm+ATwUaSrEOkspXTmKP5J
        SvHH0RiiNpq6BCiRb85frBs=
X-Google-Smtp-Source: ABdhPJzlcMNO5QKcX+qz7yu16U0WkU9h/m+u5Q6UrDhjxqoJCspE/MFiDafdwhsMPfGAcuNBrVoeGQ==
X-Received: by 2002:a4a:d38c:: with SMTP id i12mr920648oos.72.1618454546727;
        Wed, 14 Apr 2021 19:42:26 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e5b3:d157:1c7e:e794? ([2600:1700:e72:80a0:e5b3:d157:1c7e:e794])
        by smtp.gmail.com with ESMTPSA id f12sm357287otf.65.2021.04.14.19.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 19:42:25 -0700 (PDT)
Subject: Re: [PATCH v3 00/26] Sparse Index: API protections
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
 <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
 <CABPp-BGCpwguTJk3N-4Okrdpsio9Q7Hj1HSPPUZX1EZSiXkepQ@mail.gmail.com>
 <xmqqr1jcy4tl.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <154a24ab-238f-2180-2e71-40f6ed5ceb5f@gmail.com>
Date:   Wed, 14 Apr 2021 22:42:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqr1jcy4tl.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/14/2021 4:44 PM, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
>> This round looks good to me.
>>
>> Reviewed-by: Elijah Newren <newren@gmail.com>
> 
> Thanks; this kind of change inevitably would involve semantic
> conflicts with topics in flight, but we've seen Derrick works well
> together with others in such scenarios already, so let's run with
> this version and see what happens.

Thanks!

Semantic conflicts like the one in mt/add-rm-sparse-checkout won't
show up until I start relaxing command_requires_full_index, so I'll
need to be careful at those points. But I'll keep a lookout for
other issues contributors have when integrating across this change.

> Will merge to 'next' until there are new issues found, by the end of
> the week at the latest.

That timeline works for me.

-Stolee

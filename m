Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5985F1F424
	for <e@80x24.org>; Tue,  3 Apr 2018 11:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932065AbeDCLt3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 07:49:29 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:44542 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755300AbeDCLt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 07:49:28 -0400
Received: by mail-qk0-f176.google.com with SMTP id u9so4770197qkk.11
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 04:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Sq6DojhHuMNKhqa5WXFJUAwmq44cTAs2lb8l9AARjrA=;
        b=qR5wModuBCMIWQCu7g6vLZexAhdBMZstuWlIvDgmpTIHAJYlzkLV8ByzsKiMNgwvKi
         q2wO5FANqT/Smc08y169t1qzJfDWavGgQtj0EddXag6fjxjHVIiRxOLhmIZslu3ZisMZ
         9C/SIcqhqx53S2FU1Pv4rcItdx0MONEXbEr2WSo75+68i7xPR13FkLntwBHSLXrKUZFM
         tk6Fy5MjO8CE5V1BOsLOG73ltPYFuXDb8nH/92uN1UHKCBASuuhoFWSOCVVX+R4pZiia
         iUKDGdzpXrV1uEGinPNFYspQ0ykTe/Gabr+ckaO0uAmnRGtSy4MZqG3ruM+QG19i4Xvi
         J0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Sq6DojhHuMNKhqa5WXFJUAwmq44cTAs2lb8l9AARjrA=;
        b=LZOHGMVX6THncdTAYTMlLAob364Xh54Dle4VbxHpWj0xn7CSmtigGLhFeIzwMFOmkI
         AMcs8LafkYbApyc/7HFTxTeQ11x2Kk1oLdFBbDsgP98DBUYGTCijn85o3l9BCX1qX0I0
         TvjqKC2ItCeC0GNKfyrSfcZqCtUKF+jK9s4Uqqw9P05T+7avhKDl5Xgo7tD9YyzrjHJw
         a0NPsUNyU2BY4GqJQgX9NzMkhFiFu4LqgPWHOCKIBuJZ+krvzF2vN1AlSV/1FbMfmnWu
         qSFlJ2bt6fInrIJy0eFIT4+x51MXIX8aom2FTLiHwKu6Prtnw1/5Q6CN4cPObbMDzqXL
         LuFQ==
X-Gm-Message-State: ALQs6tAJFxtXj+kYrS42fmVQAGqgQqE886AlqEfKZcDJ7jPHodKq81PS
        l2wiSrfCbMjulRpWq3xXsko=
X-Google-Smtp-Source: AIpwx4/aQnLnvylP2zIrf1GGiKXCVxPLPx+PYN3PXPg5p0EyxHU32jeg0i7IEuPR0+4KD5DNT6wjrg==
X-Received: by 10.55.168.206 with SMTP id r197mr17873423qke.311.1522756167614;
        Tue, 03 Apr 2018 04:49:27 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id i5sm2141923qta.91.2018.04.03.04.49.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Apr 2018 04:49:26 -0700 (PDT)
Subject: Re: [PATCH v7 08/14] commit-graph: implement git commit-graph read
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
References: <20180314192736.70602-1-dstolee@microsoft.com>
 <20180402203427.170177-1-dstolee@microsoft.com>
 <20180402203427.170177-9-dstolee@microsoft.com>
 <xmqqo9j1xpi5.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <71a1650d-8ab7-49d7-aaef-32a12368afe3@gmail.com>
Date:   Tue, 3 Apr 2018 07:49:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqo9j1xpi5.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/2/2018 5:33 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> From: Derrick Stolee <dstolee@microsoft.com>
>> ...
>> +static int graph_read(int argc, const char **argv)
>> +{
>> +	struct commit_graph *graph = 0;
> The previous round said NULL above, not 0, and NULL is the better
> way to spell it, I would think.

Sorry about that. Hopefully it is easy to squash.

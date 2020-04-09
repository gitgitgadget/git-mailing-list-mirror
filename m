Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD37AC2BA2B
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 11:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1EC20A8B
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 11:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3Xo5RlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgDILwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 07:52:38 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:44771 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDILwi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 07:52:38 -0400
Received: by mail-qk1-f181.google.com with SMTP id j4so3541514qkc.11
        for <git@vger.kernel.org>; Thu, 09 Apr 2020 04:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UvxP3gVn805WI8xXxU5YQIRBrjtEuSoA+YoozOGisek=;
        b=D3Xo5RlIkLB08JDfSFtPZReq1n0P66ECvY9fyzwu6hFpLOERJQEXZD0X1+3WnSP2Y3
         BL9vSsk6Fc1/aqI8Vqwb4vmfa5CdC1LuN26ZXDVrraAwYzzj7VOAEn0HrhR9lgCKudEo
         T1aVIjRmmkWleWS/3ciReNE8EmQUN98F0Pp8FCx6KtVwdEjDlnewsbuHu6GnHz0HWllm
         37W05EPJxFHPEUVVqnae51/UNJ1TiezpGJXLgAu+lzM2rvyDA/Bom7vVpZRBVCUbpkJS
         EI4A1d3uDuhikTp/JtOwqaE+Lq8Iu8IPrYr7p2ud7eoxPKpfKnDBv0tWiXzaCaIwY7rw
         MM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UvxP3gVn805WI8xXxU5YQIRBrjtEuSoA+YoozOGisek=;
        b=J61Y0XkX69CnNztPFtv4kAgqtgy3oMdlA6LTj6BA+m9Ba2MxfGc6T0YLz1JktBwSGV
         aH0l2GXPJ0Us8SLoVhEIOF+eIXMPQcnb4VoMKzoQEARZHb67UguY8yOoCilh6VQM6iCo
         1by2XwctYAT9waWu+heqEkFzmLYbVqdr3dgTtoh4emd/ma3H8TcuDKIFmd4PnsJ2+R9v
         hRIIuDRqwHtIvzWyGBM36AkRmMYKWZJyTwDaYEdblDmxRJEWchQBFB6jLcJ+D7LLCQ/w
         vwJCWjpjHRLTigEDhR2iH+ltrYtp+uiWmW2DQixj5FJCsx3ipBaizuvwFKoWC1e52B36
         0A6g==
X-Gm-Message-State: AGi0PuYqj7NsUyWJen1lhZ45ulp4ljQlGIlko3h8jLAyya9Cj2ZYr8vy
        cXyg6mXB5TPsPegsfiTpiSY=
X-Google-Smtp-Source: APiQypL4ZLK64Dg7HysDgC0TqOD8eVodSp5ZiBpP840T0hL9V5KfAy3isoPbmHnm9OnmRhA/mCU4dQ==
X-Received: by 2002:a05:620a:11:: with SMTP id j17mr11475876qki.117.1586433158164;
        Thu, 09 Apr 2020 04:52:38 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id n124sm15043300qke.104.2020.04.09.04.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 04:52:37 -0700 (PDT)
Subject: Re: [PATCH] revision: --include-diversions adds helpful merges
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <pull.599.git.1586308923544.gitgitgadget@gmail.com>
 <xmqqv9mapxw9.fsf@gitster.c.googlers.com>
 <5f1c6868-303c-ccc1-553e-e54d0fa8e24f@gmail.com>
 <74562b04-b1ce-cad4-da18-4af030a3dc29@gmail.com>
 <xmqqzhbloj4u.fsf@gitster.c.googlers.com>
 <20200408200526.GA2270445@coredump.intra.peff.net>
 <9eab6c60-3c99-d6ac-9206-02ce37f7a479@gmail.com>
 <xmqqv9m9oe2p.fsf@gitster.c.googlers.com>
 <91fafa17-c58f-dcd0-320d-48c4512561f6@gmail.com>
 <xmqqimi9o705.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <076b4bf6-2bc5-97d2-2a50-d6d59ea85221@gmail.com>
Date:   Thu, 9 Apr 2020 07:52:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <xmqqimi9o705.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/8/2020 8:08 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>>> In my latest attempt at documentation, I called these merges "diverters"
>>>> yet still used "--include-diversions". Here are a few other words that we
>>>> could use:
>>>>
>>>>  * diverters or diversions
>>>>  * redirects
>>>>  * switches (think railroad switch). Synonym: exchange
>>>>  * detours
>>>
>>> ...none of the above tells me that they are not no-op (in other
>>> words, they do something meaningful), so I must be coming from
>>> a direction different from you are.  What redirects from what other
>>> thing, for example?
>>
>> The merges do something meaningful: they "merge in" a "real" change.
> 
> Yes, but "redirect", "switch", "detour", or "divert" do not quite
> mean "merging in a real change", at least to me.

Makes sense to me. The way you explain why certain words don't work
for you helps me think of new words to describe these merges:

 * signposts
 * guides
 * signals

For the argument, we cwould add "-merge" to each of these, such as
"--signpost-merges" or "--signal-merges".

I'm going to keep replying to this thread with ideas until someone
says "This one makes sense to me" or an equivalent. Alternatively,
someone else could present an idea and then I get to say "Aha!
That captures this concept clearly with an obvious metaphor!"

Thanks,
-Stolee

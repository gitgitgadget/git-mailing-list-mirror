Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,PLING_QUERY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1F7C433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 10:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B118233CF
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 10:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbhAOKnf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 05:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbhAOKne (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 05:43:34 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E0CC0613D3
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 02:42:54 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id 7so1527639wrz.0
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 02:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CA/13j+4iWPPIot3l83QIseUrRwxtyRgCqaW9g62QzU=;
        b=Fw1Fi/5k45Hi1lxHv/U03gdbekQOwqB+HNUF4+ycorykcBtWAjhTbPL0U5VBEUmAqN
         H28jT4jLf2Lm9dfXfzcXJ9TUdK4N5KwLo0XFnDkseTvMl6LnBnnvXY8KnfsaJXbCKL5x
         fgLuI28Ouu1TPadohWSBtSiWfaPcwio/voosgEWYXL3XfQqvAg3DoTF+D3FPod+PhcjT
         BublxFrWhaQ1SAOxQwokJrDxoktq50YvTs4ohlfqpWRA0P1pTItNVbbI3XwbmHo7OsME
         H0CCHVwfUVwLlL6FTM80i3HoPaeRnFBLXLKVbU6W5RjzBoXLPBVUqhmjY8x2u+UWddFb
         sCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CA/13j+4iWPPIot3l83QIseUrRwxtyRgCqaW9g62QzU=;
        b=fu33xTMzl6Y1Mnn1m7Q/P8FMn4biL1XXRYdcbGiUcCS7uZyxYHZ5OzEGUsHCQcSAQE
         x+mn2yaXZNmisfydgIhiGJF3tdT5Gvdm9EgKWf6soV2baHby95EFp7b4KHVRXCLMbLco
         rlAkdBdQNalZvvYusIMTLNopoSboZ0f3/5wUT8Q35c2KlwEYlOfZdNDrJEjM61RTqNeV
         AyjxDRGYohevoayLsD5zWOhV2SUFHhfpk2i61EdwZpa9MfGKFqQATkQ0X7dj55I2j5MP
         p6je6h4Kz0ALMrJSsTEMSfGNSwIaTLMomc+j6FnJl24gqykIBQpPCYr1JO5llZ+noO/y
         J2OQ==
X-Gm-Message-State: AOAM530GD6dvJSlkSTHiwEP5TcBiIde/eQYhfYMUIm33OCP3pf4SWQ4N
        CxsEyO4CRkfpsN9d6N72H9g=
X-Google-Smtp-Source: ABdhPJxiJqwcd4stwkWxmdXpmXODDkS7HQV811FCohLF0UCE/ueMRAz9QtunQXYxmmmGIsaKYO0q1A==
X-Received: by 2002:a5d:43d2:: with SMTP id v18mr12610779wrr.326.1610707373216;
        Fri, 15 Jan 2021 02:42:53 -0800 (PST)
Received: from [192.168.1.240] (112.16.7.51.dyn.plus.net. [51.7.16.112])
        by smtp.gmail.com with ESMTPSA id v1sm11996920wmj.31.2021.01.15.02.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 02:42:52 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: How to implement the "amend!" commit ?
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <CAPSFM5c2iqBn8_Dih2id7q6RRp0q=vfCSVUHDE5AOXZ8z3Ko9w@mail.gmail.com>
 <CAPSFM5f+cm87N5TO3V+rJvWyrcazybNb_Zu_bJZ+sBH4N4iyow@mail.gmail.com>
 <99b40665-45dd-6c4d-d46a-56c7dbf89568@gmail.com>
 <YACAHdDEMIgvQruK@nand.local>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0236bb58-61a7-6126-b50f-93e8b6bf3aef@gmail.com>
Date:   Fri, 15 Jan 2021 10:42:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YACAHdDEMIgvQruK@nand.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor

On 14/01/2021 17:32, Taylor Blau wrote:
> On Thu, Jan 14, 2021 at 10:39:50AM +0000, Phillip Wood wrote:
>>> Secondly, As an alternative to above, we can use `--fixup=<commit>
>>> --amend` and `--fixup=<commit> --reword`.
>>
>> This is not backwards compatible. At the moment If you create a fixup with
>> `git commit --fixup=aaa` and then realize it should refer to commit bbb
>> instead you can fix it with `git commit --amend --fixup=bbb`. That would no
>> longer be possible.
> 
> Too bad. I felt that this was the most ergonomic idea put forwards, but
> I also thought that we died with '--amend --fixup=xxx'. Its current
> behavior does make sense to me, but it's too bad that we can't use it
> for this new purpose.

I guess we could decide to change the behavior but I'm not sure there is 
a sufficiently compelling reason to do that. I agree the current 
behavior makes sense but (based on no data at all) I'm not sure that it 
is used very much. One thing I like about this option is that it is much 
easier to create an alias to create a particular type of fixup, with 
--fixup=amend:<commit> you have to use a shell function alias to do 
that. The down side of re-purposing "--amend" is that it no longer 
always rewrites HEAD which is potentially confusing.

> I suppose the first option (the '--fixup=reword:xxx' one really is the
> only one that can be implemented while preserving backwards
> compatibility, so I think we have no choice but to go with that one.)

I agree, to me it feels a bit more cumbersome, but on the plus side I 
think it is arguably clearer than re-purposing '--fixup=<commit> 
--amend' and it is slightly less typing than specifying two options as well.

Thanks for your comments on this series

Best Wishes

Phillip

> Thanks,
> Taylor
> 

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2A8C433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 05:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DAAF22AAA
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 05:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgLUFsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 00:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgLUFsB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 00:48:01 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1CBC0613D3
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 21:47:20 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id o6so7787587iob.10
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 21:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R8AHO/HeVsEFgcl4MQYehQ3+QIoBkbm9OyeyblTRmkU=;
        b=MU6kW2MGs2KXUIueOMSGFCr2atKm57H3oU1wK7nseer0lWBVslmEFbcRfbBE6Kixu2
         AkouguLZ7NMv7lG1n3dPgcIdIu4fQcwZGsC6IaMXAak1LBbv7kdacrrC4ct0QBjX6k33
         jhGHNPclala2GQDA3UpDSBiRi8XJEIQAfBnNixiAVfiXgfGeCta6Wd7Zwn/TCN4IZxla
         RBzG39f9pN4Wun5x5CXthaev1Vugiq1XY3CX30Ag/Fm6vJN4dfuTfBdKoHfbT+pFjjdi
         MwJ/lQqKKyM9khJGrtkuLQdM2/fBx53WBagoOQm/NIaJ75Zl/oHJbnW7i6iTzNNdU+Nw
         sLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R8AHO/HeVsEFgcl4MQYehQ3+QIoBkbm9OyeyblTRmkU=;
        b=rJGyg1icXza6CiZ9xFncU0+c5yxullOBbyTAqjORBh7aLU4qHOGCqFjOlbb9Sorz1Z
         0I2os1yNBIZzl6hNHd7GTj5BbRtuB3HE97rT6I1gtlLOp/kglGgcjNfPsHYMe8v1aZ38
         E/33pCyjsRXcC/YUxi9pKuqDW1oSdWawBOrYzwrv9Ip2JUif3ASN/mHUDti66wjUYHsQ
         llDT2K2p2ECjkJpClDKaCmRO95VggG6zPyVJjwF/F48EowFIs3gYEyYcq4ZGu6GzX3Sz
         BHSaRF8oI7Y1F7/YDI6Odlicj38ki3z5zXReATz4XPExI/neucGyJD26PFT3dIseC88f
         9HMg==
X-Gm-Message-State: AOAM530fRpP+H6Xi7K8OYz741abM0ThI7EWlkmaGrYQPFr2r3YnoocwC
        NRzDDcaUX1mWKilfzGB1wzs8bknzPvCltLlk
X-Google-Smtp-Source: ABdhPJzPE04h36wv8yLIB8CPqiIEE5Qf8UNmxeNfXy+wVgb6AOXXtAxkll3qoVid9dLQeqiGGWU8pw==
X-Received: by 2002:aed:2b45:: with SMTP id p63mr6894547qtd.111.1608508051919;
        Sun, 20 Dec 2020 15:47:31 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id d14sm9958468qtg.97.2020.12.20.15.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Dec 2020 15:47:30 -0800 (PST)
Subject: Re: [BUG] Regression in 'git mergetool --tool-help'
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     Git List <git@vger.kernel.org>, pudinha <rogi@skylittlesystem.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <CADtb9DyozjgAsdFYL8fFBEWmq7iz4=prZYVUdH9W-J5CKVS4OA@mail.gmail.com>
 <CAMP44s15CJVGRg5Qxcgqq8xVkDhpVyxND67-iQZF9uZ_PRstEQ@mail.gmail.com>
 <xmqqczz6qs0p.fsf@gitster.c.googlers.com>
 <5fddeda8a5a92_1de0de2088a@natae.notmuch>
 <xmqqsg81pvm8.fsf@gitster.c.googlers.com>
 <c4f2330f-715b-1745-5ad7-5477f4e833db@gmail.com>
 <568f42a0-f630-64ca-9f77-183dcaa56d1e@kdbg.org>
 <a9e6f3aa-e88e-6cc2-fb16-c26bdd3bf4d3@web.de>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <2e7485b6-86d9-4de2-a823-dd84fc7386b0@gmail.com>
Date:   Sun, 20 Dec 2020 18:47:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <a9e6f3aa-e88e-6cc2-fb16-c26bdd3bf4d3@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

Le 2020-12-20 à 11:23, René Scharfe a écrit :
> Am 20.12.20 um 11:28 schrieb Johannes Sixt:
>> Am 20.12.20 um 03:13 schrieb Philippe Blain:
>>> Thanks for both answers. Felipe's solution does the trick, but Junio's
>>> does not;
>>> it seems we do have to have a newline there. The following also works,
>>> and I think
>>> is portable:
>>>
>>> diff --git i/git-mergetool--lib.sh w/git-mergetool--lib.sh
>>> index 2defef28cd..6f03975493 100644
>>> --- i/git-mergetool--lib.sh
>>> +++ w/git-mergetool--lib.sh
>>> @@ -46,7 +46,7 @@ show_tool_names () {
>>>           while read scriptname
>>>           do
>>>               setup_tool "$scriptname" 2>/dev/null
>>> -            variants="$variants$(list_tool_variants)\n"
>>> +            variants="$(echo "$variants" && list_tool_variants)"
>>>           done
>>>           variants="$(echo "$variants" | sort | uniq)"
>>>
>>> I figured out what was different between the different Ubuntu versions I
>>> was testing:
>>> the Ubuntu 14 and 18 systems have Bash as /bin/sh, but my Ubuntu 20 system
>>> has /usr/bin/dash as /bin/sh (the default for Ubuntu these days).
>>>
>>> I'll try to send a formal patch with the diff above, time permitting...
>>
>> If possible, please do not use sub-processes like in your suggested
>> patch. How about
>>
>> 		variants="$variants
>> $(list_tool_variants)"
> 
> This still starts a subshell in the last line.  How about something
> like this?
> 
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 7225abd811..79d5ed1fa9 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -46,11 +46,9 @@ show_tool_names () {
>   		while read scriptname
>   		do
>   			setup_tool "$scriptname" 2>/dev/null
> -			variants="$variants$(list_tool_variants)\n"
> -		done
> -		variants="$(echo "$variants" | sort | uniq)"
> -
> -		for toolname in $variants
> +			list_tool_variants
> +		done | sort | uniq |
> +		while read toolname
>   		do
>   			if setup_tool "$toolname" 2>/dev/null &&
>   				(eval "$condition" "$toolname")
> 
> It requires setup_tool to be silent, though.
>

Thanks René and Johannes for two additional suggestions; both work correctly.
Junio, I retried yours and verified my quoting and I confirm it does not work.

I think I prefer René's suggestion.

Thanks all,

Philippe.

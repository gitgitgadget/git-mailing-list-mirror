Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4E7C54EAA
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 22:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjA3Wac (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 17:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjA3Wa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 17:30:27 -0500
Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86C82CC5F
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 14:30:16 -0800 (PST)
Received: from [10.0.2.15] ([147.147.167.102])
        by smtp with ESMTPA
        id McfFpqm5GOgYDMcfGpkFAI; Mon, 30 Jan 2023 22:30:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1675117814; bh=yMk3Q+0S4y48sEf0pmrhu4xJCvA+FzyhWFXY3OMmgiA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dzNvrJ+MjhCVvkx9InqCw58NhaJMszAxncUxLsdUtDKD4TXXb9doFz91PyQtqASbh
         wfOs1DfwW9wQLYTf5PHfwftgox6pXR86m1lzqGbdTXNLdrO0bD9phQHEhfe0ZqNxQ/
         5zzrKDJz525xkTlLUQ/JcQDl3JiTLGfGDu8U9ZZ8DxSW3pXeG+hk02e+JdAH5Ti8Ky
         rHPrK8MNddhodZt18EQg6wr0Ntsisfi4tVuQdlksXit9rE5W8hrF+5n7e00k+p8gMv
         Fj2BT+jUwmimeploVZVwX+heeTkRr/Up9Zr8k8dVQevtxlQYrzl2NX3mnFxBpBn5t5
         sSuueTxGynqBA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=CZQbWZnl c=1 sm=1 tr=0 ts=63d844f6
 a=O4HnXJxpn4bBnFCb4s/IkQ==:117 a=O4HnXJxpn4bBnFCb4s/IkQ==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=BxRVO4HRdrskf0eMuQsA:9 a=QEXdDO2ut3YA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Message-ID: <55c75313-79d4-1c5b-951b-5d1e75553441@ramsayjones.plus.com>
Date:   Mon, 30 Jan 2023 22:30:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] grep: fall back to interpreter if JIT memory
 allocation fails
To:     Junio C Hamano <gitster@pobox.com>,
        Mathias Krause <minipli@grsecurity.net>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
References: <20221216121557.30714-1-minipli@grsecurity.net>
 <20230127154952.485913-1-minipli@grsecurity.net> <xmqqbkmk9bsn.fsf@gitster.g>
 <xmqq1qnfancf.fsf@gitster.g>
 <adb5a43a-5081-4f60-d1ea-2a6511f858c0@grsecurity.net>
 <xmqqk0156z55.fsf@gitster.g>
 <9b5a1113-84f1-1651-bffc-6382462057dd@grsecurity.net>
 <xmqq357r4zvk.fsf@gitster.g> <xmqqlelj3hvk.fsf@gitster.g>
 <xmqqk0131zxi.fsf@gitster.g>
Content-Language: en-GB
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqk0131zxi.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDN9ub7wmdSg+A+eEsjhIvqjeJkUr7IG5fIzgS5BORf75fCgiQZriiLII1CXtYZtHBIfJ+azPV7PHoL3LtjkGmdhdiD+CyKOaWNfAbVtv+PKhBZqFHYp
 difQH+2jLAjy3O+/NboO8ZDE4pZjDYtteA6Mde1wP+/RR7D5t/4Tl8QsySTBG+A2/Sfvzu+C9aDduohCdO0uxIWisM6O4pe0qlA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 30/01/2023 21:21, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Having said all that, I do not mind queuing v2 if the "use *NO_JIT
>> to disable" is added to the message to help users who are forced to
>> redo the query.
> 
> In the meantime, here is what I plan to apply on top of v2 while
> queuing it.  The message given to die() should lack the terminating
> LF, and the overlong line can and should be split at operator
> boundary.
> 
> Thanks.
> 
>  grep.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git c/grep.c w/grep.c
> index 59afc3f07f..42f184bd09 100644
> --- c/grep.c
> +++ w/grep.c
> @@ -357,7 +357,11 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
>  			p->pcre2_jit_on = 0;
>  			return;
>  		} else if (jitret) {
> -			die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n", p->pattern, jitret);
> +			die("Couldn't JIT the PCRE2 pattern '%s', got '%d'%s",
> +			    p->pattern, jitret,
> +			    pcre2_jit_functional() 
> +			    ? "\nPerhaps prefix (*NO_GIT) to your pattern?" 

s/NO_GIT/NO_JIT/ ? :)

ATB,
Ramsay Jones

> +			    : "");
>  		}
>  
>  		/*

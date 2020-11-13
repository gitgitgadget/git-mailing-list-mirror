Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A81C56202
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A12FD2224C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6dvDsUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgKMMEP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgKMMED (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 07:04:03 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618B3C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:04:03 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 23so7931677wmg.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kElUBMqJeZqCQ/9LPMmkvCUriNhnnULcdPCuBqKB0bA=;
        b=C6dvDsUAQ5dIhO6NH9J+DIC6jO7ij4RdlQbZLL/xjrByujmv9AEFFSTdTJBHVBQi+r
         yp2bNT2DtzuCwqVuOoGKJY7HFztFRGG4h6Tp5uWyqcZbLMai9Hw/Tk0z3OZeaLS8QVRn
         mfYui+wLEKfAfSNdksBHVAvfz6JkRGlWeWuvMTi4+xDPqsn63C+yxOTA2qhrRHLzwmqF
         DcKt3GUSKuwcycGEWPxOOHpbC1WID8MWvLuKAAva4LvgQiftBimm3EYI2nchkVNQHdk0
         CxGG3PTddXYYrhrm0+Q3O2ORbNqzIszqEDr5Ppmwzd7f2taFad/hdLkz0Z+h5aRQL0AP
         juJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kElUBMqJeZqCQ/9LPMmkvCUriNhnnULcdPCuBqKB0bA=;
        b=nk6XaXBWs8yWNJpBd9DeMjIXoPlbLB5AZclvoOe9eHbbHYAjYGsrYjNdzgncW2ML7f
         HqxiZqdo09i7At62WUYRuBxEzLy5tlm1K0afv9ek8VgcqMoE0XRRtM1rgm21OOzWbz/v
         UDNCWVgg3HEjgrrS6QgzdmfiEuhiHAx/uGHvNPux36elkUfZTB+DY7ue+eFnL6ANSfqm
         HVNu6dKwEeX32kQewBrT1nm4p94pljib2eIYDjKcnkj86pEK084tiZaSIQZyDeMs6tZD
         PWfYNVbbnYUKY6NqSWYXvfCum95caH1aUMsdlCetgy7lyXnOclufWFuKda25kzN7Qd1n
         gykQ==
X-Gm-Message-State: AOAM5338G4FaxeMnAmwFhknW+zO2o0tYRwNkVcYfMGikqgXigHJb+usU
        76khCQ10y+X3fGoELK7Pv5M=
X-Google-Smtp-Source: ABdhPJyIqRxnWQvv39KLFrCgcqI6EVDJLGx+F1X48pIv7OAL1O9YIFAYcXGodIV5nZZGG47Y8gz6Ww==
X-Received: by 2002:a1c:a445:: with SMTP id n66mr2235144wme.51.1605269041945;
        Fri, 13 Nov 2020 04:04:01 -0800 (PST)
Received: from [192.168.1.201] (194.55.7.51.dyn.plus.net. [51.7.55.194])
        by smtp.googlemail.com with ESMTPSA id 15sm9783784wmg.1.2020.11.13.04.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 04:04:01 -0800 (PST)
Subject: Re: [PATCH v2 04/11] add -i: use `reset_color` consistently
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
 <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
 <c857c4493213bd7cc4d057487db2d1a74fa0bbd6.1605097704.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <6405f7c9-b084-ed48-e33e-009f388933bf@gmail.com>
Date:   Fri, 13 Nov 2020 12:03:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <c857c4493213bd7cc4d057487db2d1a74fa0bbd6.1605097704.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 11/11/2020 12:28, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> We already maintain a list of colors in the `add_i_state`, therefore we
> should use them.

Playing devil's advocate for a moment - why do we have a reset entry in 
that list? The next patch makes sure it cannot be customized which is a 
good thing so why not drop the `reset` member from `add_i_state` 
entirely? The perl version needed to get the reset string from `git 
config` and store it somewhere but in the C version we have a perfectly 
good constant we can use instead.

Best Wishes

Phillip


> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   add-patch.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/add-patch.c b/add-patch.c
> index b6d53229bb..bf89c43145 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -672,7 +672,7 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
>   		if (len)
>   			strbuf_add(out, p, len);
>   		else if (colored)
> -			strbuf_addf(out, "%s\n", GIT_COLOR_RESET);
> +			strbuf_addf(out, "%s\n", s->s.reset_color);
>   		else
>   			strbuf_addch(out, '\n');
>   	}
> @@ -1065,7 +1065,7 @@ static void recolor_hunk(struct add_p_state *s, struct hunk *hunk)
>   			      s->s.file_new_color :
>   			      s->s.context_color);
>   		strbuf_add(&s->colored, plain + current, eol - current);
> -		strbuf_addstr(&s->colored, GIT_COLOR_RESET);
> +		strbuf_addstr(&s->colored, s->s.reset_color);
>   		if (next > eol)
>   			strbuf_add(&s->colored, plain + eol, next - eol);
>   		current = next;
> 


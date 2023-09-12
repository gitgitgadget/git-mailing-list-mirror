Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF5ECA0EC3
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 13:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbjILN1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 09:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjILN1k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 09:27:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDF010CE
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 06:27:36 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401da71b7c5so63660515e9.2
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 06:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694525255; x=1695130055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xQ5q20IeVYTBdSs/9HyFJQytxvoxw0JkVxs++H4sJDc=;
        b=S9Yhg0JH2H6cFjIlQ1RKp+jOuetMVoTzmRNZ1IOkTnQ8NUHykX+tslVaTdDSCYl07I
         5QXoYTExaMxREE226VQANuOYj1gec89YhSqkR8MEfUUuSrWdj5KjUsl5a6iqV3P2ox9P
         Cc0Hx/zpFjPLlkDX+X/g+yXCmdLe8prOLf4XtTCswFgro4BYJAC6dtCvLsrYD/ociEVj
         JCN1PnO/3N0G8iUpZiPTMChsNBgxSOfz7EjsnyLajdRCBt3UF5zt0jjRkhixFCbW2Au/
         T2+raukjPws+Pcp5NgLskfKFZEmPo6pQHuyZwDIszPPAAP5FwMPXFSyw0EObQmpnBm6p
         1U5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525255; x=1695130055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQ5q20IeVYTBdSs/9HyFJQytxvoxw0JkVxs++H4sJDc=;
        b=B56glr6yMK359RSNt+7sOsNd31zj4jmv430PZyfXtizzTynqV93nollIXHt2fHs2Vg
         X/OzTP/UQSvZSGYZSUgvINu2MnzLozWykp7ThpoL7xRXc0Ah7b1uVev91oftI7IOhesi
         ctfp09Udvkczf01W3jE9D5kDHfh6LTgxf8lCEQ5d5IKJrRVv7Z36qr2ISB8VUXLdSODY
         0kcw+/WNpa8GBEg6sYph5De8Z+PYtSqq8jbGGtsPVZFfusGtQaRElCuvK/i842c4p/7s
         9eze8tTV2nWIa+PeoxV58TBDUyFfNW1VcHssCiEs7ZEV/ueMCFHMGibWRpPTF0aOuLZQ
         q6iQ==
X-Gm-Message-State: AOJu0YxPwrNiGiiz2TrIHRbYE9MGqSuU1fED9oxAJJJwmIPd/oBN8JGX
        EGRoJ2j88Y6ObPkeha4/sSfSxG78kNiWEQ==
X-Google-Smtp-Source: AGHT+IGAht/ZfNdWjZsughE4UPT/9o7He22jfgZN9wHvCrp5+YFBIcKVAQH+sL6qox5H8i4Zd6jHzg==
X-Received: by 2002:a05:600c:228f:b0:3fe:e842:60a0 with SMTP id 15-20020a05600c228f00b003fee84260a0mr11487786wmf.31.1694525254485;
        Tue, 12 Sep 2023 06:27:34 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id h19-20020a05600c315300b00402bda974ddsm13300516wmo.6.2023.09.12.06.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 06:27:34 -0700 (PDT)
Message-ID: <7ede7c26-9029-4e4b-81a3-f992eff74124@gmail.com>
Date:   Tue, 12 Sep 2023 14:27:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] sequencer: remove unreachable exit condition in
 pick_commits()
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <ddf8dc95-6583-4257-b48a-0115f59950ef@gmail.com>
 <20230912105541.272917-1-oswald.buddenhagen@gmx.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230912105541.272917-1-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/09/2023 11:55, Oswald Buddenhagen wrote:
> This was introduced by 56dc3ab04 ("sequencer (rebase -i): implement the
> 'edit' command", 2017-01-02), and was pointless from the get-go: all
> early exits from the loop above are returns, so todo_list->current ==
> todo_list->nr is an invariant after the loop.
> 
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

Thanks for updating the commit message, I think it is clearer now

Best Wishes

Phillip

> ---
> v2:
> - improved commit message
> 
> Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
> Cc: Phillip Wood <phillip.wood123@gmail.com>
> Cc: Junio C Hamano <gitster@pobox.com>
> ---
>   sequencer.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index a66dcf8ab2..99e9c520ca 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4832,10 +4832,6 @@ static int pick_commits(struct repository *r,
>   		struct strbuf head_ref = STRBUF_INIT, buf = STRBUF_INIT;
>   		struct stat st;
>   
> -		/* Stopped in the middle, as planned? */
> -		if (todo_list->current < todo_list->nr)
> -			return 0;
> -
>   		if (read_oneliner(&head_ref, rebase_path_head_name(), 0) &&
>   				starts_with(head_ref.buf, "refs/")) {
>   			const char *msg;


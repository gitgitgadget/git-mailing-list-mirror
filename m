Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9D2CA0EC3
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 10:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbjILKSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 06:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjILKSm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 06:18:42 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30611727
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 03:18:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-401b5516104so57411955e9.2
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 03:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694513916; x=1695118716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bUidDZN5MpsE+z4jDCriUMhehUX1CXP4qV4cG7tKrXg=;
        b=qgcyLjoV/Q/kvm1NM2R31uMWjIB7zJzleHB5vUTCf2BqQsnw7xk9Oe7NbtoPYF2qmO
         wE3tpzCKRPTGHOcwri2luVXkKQLvO/ODPG/oyV7vdISKQXMK6pfNbyAXw+/xJyeKMu54
         7hqDUJo2CAtnyoqBmWTu96PuY7t0P1PNu222TxHjbdFw1iNwaIZFDH+mCNyXQBWrXBsH
         kNgqRfpHzVPKnblG19clxvOptYJZH/qPKiAgr8kZjSNoY+TECbDyocgvxyPHuNIk3Pc5
         8Q7xPrJFnrbaz+7xpA1gGzWqSMNUMtK7qp9h0I2miCAzao67vwEAU9XXroHUa0GOzBr4
         fQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694513916; x=1695118716;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUidDZN5MpsE+z4jDCriUMhehUX1CXP4qV4cG7tKrXg=;
        b=rBUfLuCW+UGO5z1c9OxRAEnHIe+XkQahk3wlyopJiKRbwPMKGQXBSIyCjlfCO28aS1
         FWaM/vNtIAIqVn4U5e+ozlfyh9ku/012wv81q35KGSel4cA7iRQQWO4mWiB07W4rq3Zs
         IeB0mfFn3UZhJ2aOLRNy0VJVhiIfqHgGTjINgMcrSIt8Vpyk3F7esdI3ah7uJ6VwSWy4
         WGhDFaN8QJspojvYqlTGz2DKCum+qk7g41JPfRSaJ3Ytei9dTNb6dyMjKVAuXQw6UNQK
         vn9BOOpELrc1nB/7tsKNO0+oznGNfSoo/wcZ8H/HY5Rbok31mW1Hsankhx+Wf7ayfw8X
         rezg==
X-Gm-Message-State: AOJu0Yx90sQeDB5dYLB9vgrlI0zE72K1kpHY/DQdT/ZHhoqp1jccH7I4
        YxoTlCFeR7M/Yl3pnP+9n/w=
X-Google-Smtp-Source: AGHT+IG2ApmtcdzwaMnLSk+KUoBIchvIRs+2qx9vRNG8YJMqjFNlhLdUdpbI5ZMeRv1JNJrjFl7VIg==
X-Received: by 2002:a5d:4bc2:0:b0:317:55c:4936 with SMTP id l2-20020a5d4bc2000000b00317055c4936mr9472358wrt.9.1694513916144;
        Tue, 12 Sep 2023 03:18:36 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id o21-20020adfa115000000b0031f9bdb79dasm7015105wro.61.2023.09.12.03.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 03:18:35 -0700 (PDT)
Message-ID: <ddf8dc95-6583-4257-b48a-0115f59950ef@gmail.com>
Date:   Tue, 12 Sep 2023 11:18:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: remove unreachable exit condition in
 pick_commits()
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20230903151132.739151-1-oswald.buddenhagen@gmx.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230903151132.739151-1-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald

On 03/09/2023 16:11, Oswald Buddenhagen wrote:
> This was introduced by 56dc3ab04 ("sequencer (rebase -i): implement the
> 'edit' command", 2017-01-02), and was pointless from the get-go, as the
> command causes an early return.

While I agree this code is unreachable, just because it was unused when 
it was added does not mean it is unused now. It would be helpful for the 
commit message to explain that there are no "break" or "goto" statements 
in the loop body and therefore this code is only reachable when the loop 
terminates because todo_list->current == todo_list->nr

Best Wishes

Phillip

> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> 
> ---
> this remains valid after phillip's pending series, through it becomes
> marginally harder to prove (c.f. "sequencer: factor out part of
> pick_commits()").
> 
> Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
> Cc: Phillip Wood <phillip.wood123@gmail.com>
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



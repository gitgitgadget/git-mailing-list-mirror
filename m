Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3C9C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 10:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7391F61108
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 10:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhINKfS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 06:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhINKfR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 06:35:17 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A907C061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 03:34:00 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id s24so8820319wmh.4
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 03:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mh2RcrZETfiDL39ncA+snNRkXTIcKRafYFd3MIngTI8=;
        b=LVaJYXqwi7UnvInnn7rpnnVFzRtNv5jWOQwFMJ5iuWKeJGIdywnIc6Abs7Bva0bGUB
         rMP9mgMhWVDmrSUy9qwH4PeSRHqlRnJm2u7a5QVP9zo2qbW8SLsMLkSpbYDATcHNfu82
         TY/7aXuvCks9ajLnWZfQmvEpu3IOy9AuD2qVnVOyfR2651cW9DxTLsk9WwVuhHyL4ll4
         fJ0ZQbsAucQrgITNWbsTYMXqG2Ix1MVG6TeDylhZcT+5SGmzjF70yqky3QIltrNHV1R2
         Q08dC+MamIUyksI/QPMbn6w+mroEc0XhadQFxOpMvWEnNgJMtyORL9GmvHZTJqHqexGw
         Ovxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mh2RcrZETfiDL39ncA+snNRkXTIcKRafYFd3MIngTI8=;
        b=Arh256vbL6pHe7cfVYRkOuuKtP7xmy45+l8XWPhPtY0EZxr7lswGY+hhhTxu5HhrMr
         MjsyP3K+XAMx4nqP2SbyTnttvadRg5qsasgjcJ2EeFjeuibbEDmg7nRw28xIOQdjl1xI
         eHhWy0zGKGl9yoKM4HAYnWBt5LSF4zn6jU8yaspRWhRLeYnQWeeMIaHCOfxZxpNiK9mp
         X5IDAvm4cK5NGjGRM/XEP12D5XGcQRmBX3mKymeZxUPnWX+KRUjD1ZVHstvaV4oUmNv8
         mGzvlg4m22aUyWuI3vzDLsgdNv5emR8svJ4piq3kjFrWQ6bPQBlT71LmGayFNefGMyhx
         Q4XQ==
X-Gm-Message-State: AOAM531U87HGgOhyiVhKrccDkY2V6+y/moIN3kB9MMLffp+9Uo+rsg9y
        cxVDGkT+0lTY+AAMLLaEY/0=
X-Google-Smtp-Source: ABdhPJzOyavBD6s+ILwVYF8E9n04Qr9Wj0pLq5hlaYvsbwz3Q7CKdKDvZgdCP9+rGCnQKT+UKltGWg==
X-Received: by 2002:a7b:c0d5:: with SMTP id s21mr1369481wmh.125.1631615638925;
        Tue, 14 Sep 2021 03:33:58 -0700 (PDT)
Received: from [192.168.1.240] (46.107.7.51.dyn.plus.net. [51.7.107.46])
        by smtp.gmail.com with ESMTPSA id c23sm739927wmb.37.2021.09.14.03.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 03:33:58 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 08/11] rebase: remove redundant strbuf
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
 <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
 <ad3c4efc0272be8eee052a08731656a406f8f90b.1631546362.git.gitgitgadget@gmail.com>
 <3c7c5560-2cae-a4cf-a298-6d77a3fb9226@web.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b6cb3935-7e6a-5440-3439-7e9076ba5051@gmail.com>
Date:   Tue, 14 Sep 2021 11:33:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3c7c5560-2cae-a4cf-a298-6d77a3fb9226@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi René

Thanks for looking at this series

On 13/09/2021 19:34, René Scharfe wrote:
> Am 13.09.21 um 17:19 schrieb Phillip Wood via GitGitGadget:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> I'd rather see the use of that multi-purpose "buf" reduced, e.g. we
> could simplify path-building like this in a few cases:
> 
> -       strbuf_reset(&buf);
> -       strbuf_addf(&buf, "%s/applying", apply_dir());
> -       if(file_exists(buf.buf))
> +       if (file_exists(mkpath("%s/applying", apply_dir())))
> 
> Sure, this looks a bit lispy, but still better than the old code
> because there is no state to carry around and reset when "buf" is
> repurposed.

That's a nice suggestion, I think it's much clearer which file we're 
checking for.

Best Wishes

Phillip

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A59C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 09:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 165A161285
	for <git@archiver.kernel.org>; Thu, 13 May 2021 09:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhEMJke (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 05:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhEMJkc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 05:40:32 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331C6C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 02:39:23 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id k15so8052827pgb.10
        for <git@vger.kernel.org>; Thu, 13 May 2021 02:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SpgvlfVLDCoV9V+o+qsbug8qeIrsdW3jxJ1pw8c69E8=;
        b=lxUH4UASu4OWEooQPuHxiGntwOjO++iO5iJIokr257S52m7WWM5oLdQgnD9ta6pnTZ
         +A5AnUgNYT1zO8w05TfagIaQr7v8PdhKaJQH5bStE7Q8HUA772q+BHuAI0r6OP+hlG2j
         K/pR4buSExenKxJljwNaG3EJNExXGimZx3ukOeaVAk3whFaO1ZTRVC5Fj6uy5UGLM4R0
         NPpb8A/JrsqFpTghyjKqNE5HlOrAOV+/SaV3L+JCPRW7loWrogMWj/FP+HsmVZTfR5k+
         tF9OsfwyCXZWS+kLl6dYVwY+o9iiB0f4p1NvCrkcwl92jD5CwMkavlV+Q+vaqGyjeu5A
         I/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SpgvlfVLDCoV9V+o+qsbug8qeIrsdW3jxJ1pw8c69E8=;
        b=HR6zwT3fVCbv6iktBMFPVwMnFvlkY4e5uRrBFocO6wveXDZ06/sf6ky5q1GR704RC1
         si14rg3h/Xk+Zilw0255QrgcTWYyDYFgrsLyuMu/koEW0i4VxbBYlIirFxv22CEoXKe2
         U+9wxxwyfKych6jAX2kOUbkRpIMHzd7Mrwe0N191N1DBlB3aoshNC6vXgKvy/MrIakpb
         k16MzzN8kHyJtWw3+r28qzbdiEN631UV1tVyrNeGqd/qvO8zxLpNjdNqFhaTnCh+YWMs
         MrUJL8PI0FOgiDtl8EizhFpl+lFYS4mhiLHbPWcxbhO/NbL9w2mNmx9hOTTYHq13JysP
         PyyA==
X-Gm-Message-State: AOAM530D9WLZBETLHFtDOvHCbYY9NCX2uj4b0MLV5fXQFIFt/FUwPTDD
        GMGE+Z7Zs7HJe8IV5AGGY4qmiKg36GgsjA==
X-Google-Smtp-Source: ABdhPJzOhyc1FQu3RXM0lMWUmLsUE8XA3Yu5pb9Pas8f/8mTz3F/j5TgZJ5b4aHXIFdH13C7BFHUtg==
X-Received: by 2002:a63:5c4c:: with SMTP id n12mr20179586pgm.288.1620898762512;
        Thu, 13 May 2021 02:39:22 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-2.three.co.id. [180.214.233.2])
        by smtp.gmail.com with ESMTPSA id w14sm1742056pff.94.2021.05.13.02.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 02:39:22 -0700 (PDT)
Subject: Re: [PATCH] Fix typo in Documentation/RelNotes/2.31.0.txt
To:     lilinchao@oschina.cn, git@vger.kernel.org
References: <21c2f550aefd11eb9a470026b95c99cc@oschina.cn>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <889ed1db-1fda-8d96-d966-bd610951b377@gmail.com>
Date:   Thu, 13 May 2021 16:39:19 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <21c2f550aefd11eb9a470026b95c99cc@oschina.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Li, welcome to Git mailing list!

On 07/05/21 13.26, lilinchao@oschina.cn wrote:
> From: Li Linchao <lilinchao@oschina.cn>
> 
> replace 'whey' with `when`
> 
> Signed-off-by: Li Linchao <lilinchao@oschina.cn>
> ---
>   Documentation/RelNotes/2.31.0.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/RelNotes/2.31.0.txt b/Documentation/RelNotes/2.31.0.txt
> index cf0c7d8d40..617d211f3f 100644
> --- a/Documentation/RelNotes/2.31.0.txt
> +++ b/Documentation/RelNotes/2.31.0.txt
> @@ -49,7 +49,7 @@ UI, Workflows & Features
>      @{1}, but we failed to answer "what commit were we on?", i.e. @{1}
>   
>    * "git bundle" learns "--stdin" option to read its refs from the
> -   standard input.  Also, it now does not lose refs whey they point
> +   standard input.  Also, it now does not lose refs when they point

Looks OK.

>      at the same object.
>   
>    * "git log" learned a new "--diff-merges=<how>" option.
> 

Thanks.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

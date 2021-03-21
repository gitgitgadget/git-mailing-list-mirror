Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5EFC433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 09:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A0BD61933
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 09:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhCUJRz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 05:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhCUJRm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 05:17:42 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3260C061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 02:17:42 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so8866544pjc.2
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 02:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=syqyEKA6gm7kM8XjkxvndldNB5b11qG+CaVExFEN4e8=;
        b=tptEHv1MCbVjjZfOwbrZgBPKE1qAmmUcNWand0w/f+Mv5gpVObmULDpAf7hM3qbDxs
         NxudPDpUpouO4N1vuhOAfRQBIlkzu6RETQ7mNYK4GzGxhi9RRA2DF0Qmbwnp5pZ0PpeN
         CKu2MjLyW1ei8lxsxdqd00Ue+ihuLgm5osmCnOYDOaM5Wj77dnNAiDpgAPoFl8+PD54g
         qIlV/W/VTziU9x5zLxhnRaLtP2XA4Cpw2wG7RJMrSIkxSsWRf+cekN2IWg3V6a8ml6fJ
         t1HIQhiQv+64JQucmk117t8ziDjhnKDstZ7cyq4Bmby8PI7H7ENu/S80TPKxzKJjs+ec
         IphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=syqyEKA6gm7kM8XjkxvndldNB5b11qG+CaVExFEN4e8=;
        b=CXfjKZhvJPUgEZDvuP64LGew/PTg8QRCl0Xk4x/y+0kGlGv9784vxQRsz8iknDWdAQ
         Z0pbpRD0LeAfy9KogYkRVmszCcf7np9se2bA/4ycZ28ziiEC2/XrdgY/zs5fh+c8UyLs
         esX/oVv56kzmzhxBh+2er5ce1V6h0E3BL+FhMidfP8k7hrbv1UscJJqKQ6oGficCpDk1
         qVhwAOVLjzNCJstF6x+YoFR68v4dsxASeoDsMuDTXpN4GujnwGN1ABVZ5slDlJZRYxzR
         WaDSxsWV8PF8NEo1m9a7wOdqzZ7Kf6FzaGfTexrKXUMXZGZ7htLOpe2S3dnQf3Df4yJq
         Wj/A==
X-Gm-Message-State: AOAM530tmJq4VQnGeP9+DNuQZO+AIYBZtVVJGHPvDt0VFOGJTj8lx2b+
        3JcSooTxI5MTNc2ZkYxJ4s0TBONId3Bp78Fz
X-Google-Smtp-Source: ABdhPJxxuOxNUHYIg8+oD0NHqBWZqlIWhh3C/P5eg9debJ4k9BKcOVYd5srNpXeaWG62wD2yn795kg==
X-Received: by 2002:a17:90a:5d14:: with SMTP id s20mr7522192pji.6.1616318261931;
        Sun, 21 Mar 2021 02:17:41 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-76.three.co.id. [180.214.232.76])
        by smtp.gmail.com with ESMTPSA id n16sm10317164pff.119.2021.03.21.02.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Mar 2021 02:17:41 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] [GSOC] interpret-trailer: easy parse trailer value
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>, git@vger.kernel.org
References: <pull.911.git.1616251299.gitgitgadget@gmail.com>
 <pull.911.v2.git.1616317134.gitgitgadget@gmail.com>
 <8b8b236a4ffb81a8c6be3f320b878cea1d0f9d7a.1616317135.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <1722fbad-6ff3-444f-ad3f-59e37b640fc7@gmail.com>
Date:   Sun, 21 Mar 2021 16:17:37 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8b8b236a4ffb81a8c6be3f320b878cea1d0f9d7a.1616317135.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 21/03/21 15.58, ZheNing Hu via GitGitGadget wrote:
> +test_expect_success 'commit --trailer parse @nickname' '
> +	echo "I love git" >file1 &&
> +	git add file1 &&
> +	git commit -m "yly" --author="batman <email1>" &&
> +	echo "I love git" >file2 &&
> +	git add file2 &&
> +	git commit -m "yly" --author="jocker <email2>" &&
> +	echo "I love git" >file3 &&
> +	git add file3 &&
> +	git commit -m "yly" \
> +	--trailer "Reviewed-by:@bat" \
> +	--trailer "Signed-off-by:@jock" \
> +	--trailer "Helped-by:@email1" \
> +	--trailer "Mentored-by:@email2" &&
> +	git cat-file commit HEAD >commit.msg &&
> +	sed -e "1,/^\$/d" commit.msg >actual &&
> +	cat >expected <<-\EOF &&
> +	yly
> +
> +	Reviewed-by: batman <email1>
> +	Signed-off-by: jocker <email2>
> +	Helped-by: batman <email1>
> +	Mentored-by: jocker <email2>
> +	EOF
> +	test_cmp expected actual
> +'
> +
>   test_expect_success 'multiple -m' '
>   
>   	>negative &&
> +test_expect_success 'trailer parse @nickname' '
> +	echo "I love git" >file1 &&
> +	git add file1 &&
> +	git commit -m "yly" --author="batman <email1>" &&
> +	echo "I love git" >file2 &&
> +	git add file2 &&
> +	git commit -m "yly" --author="jocker <email2>" &&
> +	git interpret-trailers \
> +	--trailer "Reviewed-by:@bat" \
> +	--trailer "Signed-off-by:@jock" \
> +	--trailer "Helped-by:@email1" \
> +	--trailer "Mentored-by:@email2" \
> +	empty >actual &&
> +	cat >expected <<-\EOF &&
> +
> +	Reviewed-by: batman <email1>
> +	Signed-off-by: jocker <email2>
> +	Helped-by: batman <email1>
> +	Mentored-by: jocker <email2>
> +	EOF
> +	test_cmp expected actual
> +'
> +
>   test_expect_success 'without config in another order' '
>   	sed -e "s/ Z\$/ /" >expected <<-\EOF &&
I think please consider this case: When I add --trailer "Reviewed-by:@bat", and there are two
identity pairs that match (`batman <email1>` and `batman <email2>`), I need to choose one that
will be in the trailer (for example because <email1> is primary email). So a disambiguation
prompt should be added, something like:

```
There are <N> identities that match, please choose one that will be added to the trailer:
1) batman <email1>
2) batman <email2>
...
n) batman <emailn>
```

The prompt can be repeated for each trailer values that are non-unique.

Thanks

-- 
An old man doll... just what I always wanted! - Clara

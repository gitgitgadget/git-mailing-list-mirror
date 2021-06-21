Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B84DC48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 08:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2035C610C7
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 08:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFUIUO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 04:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhFUIUN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 04:20:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022E3C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 01:17:58 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i94so18545622wri.4
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 01:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T6QanbReoUHQmg5YYHLNmVx9Jbr+X/W66HW1gKiZ8kw=;
        b=EVC9rFoTrzl4RJYDQEF6ZjtoPQy4C2qL5vZdX6eGjqPvzk6bOV3EiiINswf3LTG7kv
         6PqWs5X5FJEEHzSjJIpw+nLPQfvUBSzfTUxNu0ZuydbLv0Kb3uEcRxDtgHqpouW0yYvd
         Yy4VxCR8BKc6GGShKYqJdg/QLxcY5U1XbNGKGNOhG3UJMlBoGMwCN+CKmjt4g3PzSOro
         nVLeKveqjYOUyaL69UWxhrlicQiXhd+WLnEL+3yo8W7W0kxisdBr+VX7qEeuWwlSuIy+
         V/3OGyHz+V/7jjKwfDb9a+yW4HNJjD+GWcL77NYeVEidIHshrCl/lDBCvPun3H5dfpuB
         LcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T6QanbReoUHQmg5YYHLNmVx9Jbr+X/W66HW1gKiZ8kw=;
        b=pe4nLRR97rsrg3/Le/o+kbC3qrzaB9nx+ShPVNKFpPHpbTuSnp1OYqAhAKNsdEiPVM
         N0tCEO3PjUeU5HF7E28VG715Yj0uTgY+E+udro6KTlqcDs2SNfxhExzvQnzh+PYHXP31
         +eiBLTAxwVRoKpV39oh20r5qHyKaoO5Isp+H/8d/1wXRnWYq5vLMm+gxexPbzUoH/f97
         8bDw7ZicUuhYJsarG+iyz+NyeIDChvGRTQcG1ym3t5d+o1p4gik2ZPOFQcG7c0jvwHYJ
         //ywpf6xvsKX5f6efRyuk5ykgdEX0JIinC0ve3dAIJta6cwAw1N7b0tGcFBsHFX7yhKj
         EQQw==
X-Gm-Message-State: AOAM5335XwqUFEKoHXCDL3cf03eKui0otxq/fcRLlrIvOSIwu+Vf9KYF
        aX1taLjLMI+0gc2MyN45jSg=
X-Google-Smtp-Source: ABdhPJy/fiLeL6weqTqQy4qDYRSloX991dcmxHBLLUMYq3x5LXGmg9goctyID2MwHPteoI0EonPqSQ==
X-Received: by 2002:adf:e502:: with SMTP id j2mr19557119wrm.275.1624263476188;
        Mon, 21 Jun 2021 01:17:56 -0700 (PDT)
Received: from [10.36.18.2] ([46.246.3.216])
        by smtp.gmail.com with ESMTPSA id e3sm6709091wro.26.2021.06.21.01.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 01:17:55 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] t6402: use find(1) builtin to filter instead of
 grep
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
References: <20210615172038.28917-1-congdanhqx@gmail.com>
 <20210619013035.26313-3-congdanhqx@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <d4082001-6c70-ae02-c448-e038923c840e@gmail.com>
Date:   Mon, 21 Jun 2021 10:17:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210619013035.26313-3-congdanhqx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/06/2021 03:30, Đoàn Trần Công Danh wrote:
> find(1) has a builtin (-prune) to filter its output, save a bit of time
> for invoking grep(1).
> 
> In addition, in a later change, we will try to use test_line_count_cmd
> to count number of lines in stdout and/or stderr of a command, due to

Looking at [PATCH v3 1/4] of this series, mention of "stderr" here is no
longer relevant.

> limitation of current implementation, it can handle pipe.

Seems like a typo s/can/can't/ ?

> Let's replace grep(1)'s usage with find(1) builtin filter.
> 
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
>   t/t6402-merge-rename.sh | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
> index 425dad97d5..5d76cd6414 100755
> --- a/t/t6402-merge-rename.sh
> +++ b/t/t6402-merge-rename.sh
> @@ -546,7 +546,7 @@ then
>   
>   		test_must_fail git diff --quiet &&
>   
> -		test 3 -eq $(find . | grep -v .git | wc -l) &&
> +		test 3 -eq $(find . -name .git -prune -o -print | wc -l) &&
>   
>   		test_path_is_file one &&
>   		test_path_is_file two &&
> @@ -565,7 +565,7 @@ else
>   
>   		test_must_fail git diff --quiet &&
>   
> -		test 4 -eq $(find . | grep -v .git | wc -l) &&
> +		test 4 -eq $(find . -name .git -prune -o -print | wc -l) &&
>   
>   		test_path_is_dir one &&
>   		test_path_is_file one~rename-two &&
> @@ -593,7 +593,7 @@ test_expect_success 'pair rename to parent of other (D/F conflicts) w/ clean sta
>   
>   	test_must_fail git diff --quiet &&
>   
> -	test 3 -eq $(find . | grep -v .git | wc -l) &&
> +	test 3 -eq $(find . -name .git -prune -o -print | wc -l) &&

Because in the original `grep` wasn't invoked with `-F` it means that
".git" is a regex which would match any path which contains the word
"git" in it, because "." matches any character, including the leading
slash that `find` outputs.  Such narrowing of what we intend to filter
out is a good change.

This semantic change in filtering doesn't affect tests in t6402, as the
test directory doesn't have paths with the word "git" except for the
".git" directory.  It might be worth mentioning in the commit message.

>   
>   	test_path_is_file one &&
>   	test_path_is_file two &&
>

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0D0C77B60
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 00:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242676AbjD0A2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 20:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241255AbjD0A2a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 20:28:30 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBE610C7
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 17:28:29 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f004943558so1740993e87.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 17:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682555307; x=1685147307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P4p6nQJOxdLZgVUSgJUCyG8FBYpdpjzFQVupMsCPq4s=;
        b=plQ+Y2N8OwGVcv+koOS8a2chFBNi/NkRrccx1cya402LVZRN2Fzf5esvdPjxpRwk5E
         tItx8uR7eKBE4hff8t1rwSPkfdiASmLse17COYhuSsRZDhpe1fLKRyJQlR1h3nEKWBxI
         3xtH5UUXaZHtQGjxy5MAVYmYKycg0gz3fCV1P5BIeoC3o50jJJohwg7CUH7FUZ/VX5Cx
         6ZLgvuLvSk5At6zqtDSeYrP/aRXdOkGTg/w5zfw871D1f2DbQCfNzgLhEEeeCEihFo8/
         kIhu8raeEDpJX3fdm/kN4GlNflvDJvqg9x4p9MvCKvkK4L8+dIPNH903gvbekZ527EIr
         UTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682555307; x=1685147307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P4p6nQJOxdLZgVUSgJUCyG8FBYpdpjzFQVupMsCPq4s=;
        b=FZS4mbLjyr7Rh2nm5lipEoa2jxw2xMbcqYalMUredEJagRL6Wl9H+SGUALOVlE27Fq
         1eqMmta/zkBb0TV81WOQIrqtu/a0a8lUeZS8whGJZJEKLd3CBju9lLANqfTGneYxEvJw
         8P93sTJmIh7iGTBD79bOdE7pR+UXakGbxXrCmONknmqYJ0XGVOf5JqgjGh/4wf8Z0sdM
         sRegK7+mqwkI2ludWCDfC20kl0KAiFPdXnfQpWIv6U715PWgCR++3hm9LT51s8ar+esL
         iIfXb39PjI4GKeHcGYSsh+zvNjrSZO1EoFMGn6bz2TVtSkuGKBwZ8vJu994267235fka
         p09w==
X-Gm-Message-State: AAQBX9fmmAtraXaavPNkB+ob8aP54GCh+AkqqZo1xVHw+8cSWHleZpV0
        xXP8rAEHgkOnboco+AHXXUjLEdH3PcIPifXq
X-Google-Smtp-Source: AKy350aFtYOSH121Cv2KOWjc/JVvqKQ8mwpm7StV+Id1yEiQq0VT4tZyc+CNwSsEkCBLoFMyFHEBvQ==
X-Received: by 2002:ac2:54a1:0:b0:4ef:edb3:b5e5 with SMTP id w1-20020ac254a1000000b004efedb3b5e5mr3127459lfk.52.1682555306841;
        Wed, 26 Apr 2023 17:28:26 -0700 (PDT)
Received: from [10.16.18.64] ([195.246.120.55])
        by smtp.gmail.com with ESMTPSA id r16-20020a2e94d0000000b002aa40d705a5sm2305835ljh.11.2023.04.26.17.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 17:28:26 -0700 (PDT)
Message-ID: <033bd734-9c32-e5a2-3f5c-c851e4e3bc5d@gmail.com>
Date:   Thu, 27 Apr 2023 02:28:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/3] checkout: warn when unreachable commits after using
 --orphan
To:     =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>,
        Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <f702476a-543a-da9b-ccd9-4431c80471e1@gmail.com>
 <417ae16c-9ba7-1e6d-c8d7-5b20a188b4fe@gmail.com>
Content-Language: en-US
From:   Andrei Rybak <rybak.a.v@gmail.com>
In-Reply-To: <417ae16c-9ba7-1e6d-c8d7-5b20a188b4fe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/04/2023 00:19, Rubén Justo wrote:
> diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
> index 2eab6474f8..6762a9a572 100755
> --- a/t/t2020-checkout-detach.sh
> +++ b/t/t2020-checkout-detach.sh
> @@ -124,6 +124,15 @@ test_expect_success 'checkout warns on orphan commits: output' '
>   	check_orphan_warning stderr "2 commits"
>   '
>   
> +test_expect_success 'checkout --orphan warns on orphan commits' '
> +	git checkout "$orphan2" &&
> +	git checkout --orphan orphan 2>stderr
> +'
> +
> +test_expect_success 'checkout --orphan warns on orphan commits: output' '
> +	check_orphan_warning stderr "2 commits"
> +'

These two tests could be a single test.

	test_expect_success 'checkout --orphan warns on orphan commits' '
		git checkout "$orphan2" &&
		git checkout --orphan orphan 2>stderr &&
		check_orphan_warning stderr "2 commits"
	'

Validating output like this in a separate step is an artifact of
the old way of checking localized strings.  Tests were split into
two in f06f08b78c ("i18n: mark checkout plural warning for
translation", 2011-04-10) and then prerequisite C_LOCALE_OUTPUT
was removed in f2c8c8007c ("i18n: use test_i18ngrep in t2020,
t2204, t3030, and t3200", 2011-04-12).  Usage of test_i18ngrep
was then removed in 1108cea7f8 ("tests: remove most uses of
test_i18ncmp", 2021-02-11).

> +
>   test_expect_success 'checkout warns orphaning 1 of 2 commits' '
>   	git checkout "$orphan2" &&
>   	git checkout HEAD^ 2>stderr



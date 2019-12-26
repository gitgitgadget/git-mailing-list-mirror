Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D72C2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 20:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79765206CB
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 20:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeOiev9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfLZUsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 15:48:47 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35447 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfLZUsr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 15:48:47 -0500
Received: by mail-qt1-f195.google.com with SMTP id e12so23141900qto.2
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 12:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LJai4BYD0wN/44ZfUa/vk2LZpxVToMmOTPOP4DOmINU=;
        b=QeOiev9g/SQ1J4eDPzOBpo6KhhDsahBd3A/mXriQ9vAJ4as5e578QwjFgyAbTw00RZ
         dSuqUeKX83sPjI8wgG6NBW4TsgZOeBN+804dmHsgxwHfiSMNhwnTdXuu2KBVLb+Frd0A
         yOhl9T/qZpI7/U7rcIhHoXEsjvALZ5sl/LvCpOsdhDn1stHzn6mb1bnzYB57QXZeMfSh
         dHwsSlKnGBu70GMg5og38SwC82EJKuLzLAgRhqZZe+mCwpwamQDLVvSjT5M7vxicHsmF
         JPJ7JliQZ94uz5Ti0UZbFo/mS1ua6f5d0OOdPBH0IQsy4z77XNUOOzk8lk6W0e1EX2FR
         GvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LJai4BYD0wN/44ZfUa/vk2LZpxVToMmOTPOP4DOmINU=;
        b=jUe40crS4y3VSucL3Pb9zgljG2a3dW41B+v9UQH/XWUd3kODaZZlfcjBLDmER0GZhS
         U3LapjHcmIClzKIdvywwCVo16+d9QW7OwIdqv4fnSg8yCQZzoVGJNQtSW9QlEf6aHCWk
         RzUMARXMOFvecdmLo4gCwWgaI6qnzyYX0qNlrFzti+s/5go1QTxlTPhtd2nxaRidnBNe
         GnHn7GAjTCQ/pwrrr3oepnD9bq781Mu1dn/+9UcRVozjnGBUdGo8usd+5D4oy8sut/C7
         KiOvKC3WIvJJmvDXv1bhzZDy32qQVL25rfsaheYocZfMEZV9Yorp/ActWmilDS7U+qW5
         s9qQ==
X-Gm-Message-State: APjAAAXfr/AEEV+AJ3vdewiV+Tev58QXbWezVBqC0ajkIo1SIis4dWuR
        Bd69DXqXNFHUhcQlv+vC99k=
X-Google-Smtp-Source: APXvYqyZJiDmmN7yn8ylEvNxlkQab39uvBjOKsB0YmUHs//sSsLnKZ7JisietXMfUhrMmfBj/mF09A==
X-Received: by 2002:ac8:6784:: with SMTP id b4mr34314272qtp.27.1577393326396;
        Thu, 26 Dec 2019 12:48:46 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:d596:b1c5:69e0:b2e5? ([2001:4898:a800:1010:86cc:b1c5:69e0:b2e5])
        by smtp.gmail.com with ESMTPSA id d143sm9015056qke.123.2019.12.26.12.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2019 12:48:45 -0800 (PST)
Subject: Re: [PATCH v2 9/9] ci: include the built-in `git add -i` in the
 `linux-gcc` job
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
 <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
 <23a3a47b0193395a280f32c01deaae5bdeeaa051.1577275020.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <600bb1f7-b54a-3bf7-40ae-af656768a752@gmail.com>
Date:   Thu, 26 Dec 2019 15:48:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <23a3a47b0193395a280f32c01deaae5bdeeaa051.1577275020.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/25/2019 6:57 AM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> This job runs the test suite twice, once in regular mode, and once with
> a whole slew of `GIT_TEST_*` variables set.
> 
> Now that the built-in version of `git add --interactive` is
> feature-complete, let's also throw `GIT_TEST_ADD_I_USE_BUILTIN` into
> that fray.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  ci/run-build-and-tests.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index ff0ef7f08e..4df54c4efe 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -20,6 +20,7 @@ linux-gcc)
>  	export GIT_TEST_OE_DELTA_SIZE=5
>  	export GIT_TEST_COMMIT_GRAPH=1
>  	export GIT_TEST_MULTI_PACK_INDEX=1
> +	export GIT_TEST_ADD_I_USE_BUILTIN=1
>  	make test

I see that I need to add this to the test-coverage builds.

Will do.
-Stolee


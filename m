Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844EDC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 22:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A4B23C85
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 22:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388378AbgLIV7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 16:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388349AbgLIV7v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 16:59:51 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52B3C0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 13:59:10 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id c14so2210153qtn.0
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 13:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rAPlC66E9TKDC+9zT5kQnhPcZN/KKpvTaOZ1ZgHGZcE=;
        b=PHf4RN9ejlqehI8Iv/DtuXUgnbgGGBevWwi4B40UHBrDp8kZCTUY5jypG6oqQ3eTCc
         uU0hhiJY1dmQOcKRfLMy/00s3G+Tolx7xKtGnNnikle1lCj0obyK0/qOR/jtsKQVl0r5
         JFAL8bOCpuch9IinpEky47q6uWjek1A+I7SOKwuzLl/g2+jOHKIucjsO5RV4IDUJAdZS
         j4fmQolXcNHeH27ei3LIFPOBjjk/rFnXezHw273gsYGKjSjt4iwDKgGJUjaHF8gvNllJ
         dRjdUFQOXffz0rhEWMynFtsV7IYsqiONvE4DTE38P+BjEvJnWVXMCX4v8+fFCl8Kidns
         L9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rAPlC66E9TKDC+9zT5kQnhPcZN/KKpvTaOZ1ZgHGZcE=;
        b=pI98/QbDaO2Lp/h+8F/qr4vOlnAoT1IKJJ2CdMdYCmADAnSBPjbrisGWajohhOQEBX
         881rsM7Yv7M6wyvpMZDCPciIUs1eNFzAw4TaP99fOFEmYA4O8X6cLcGvj+ZbRgyTXTel
         L1DmBFbTXZAHnSm+6FPJV3v3kFQ3A853WUlwnU9R/AP2BCmKPD2wXnQgEBuXrkaGWLAr
         Z0sXbFzsa7gERYaURfwlF1HjJauqz9aETN5WeNwPYZrZhnZEeaH7s5b9X/7r55iQevnl
         GC9rRXklkOBpH1mu1NdFcUhmqDlqYVp2p6T8IX7FZbKk9vgZBM6vaAXyXak3gEwddxT3
         pv5A==
X-Gm-Message-State: AOAM532yFTyzvHbXNgvdneeNzJJ03a3h63/4youoDPUefeJvi56v2+kB
        7Pu0px0vyFMeg4LgjxV1Suk=
X-Google-Smtp-Source: ABdhPJy4wKkl5Mkmyldezlv/90Z/aS64wUx6fv5Tc7UBRp2AhAJ2zqrDAPYy474O410vQ3leSg9Ouw==
X-Received: by 2002:ac8:5a04:: with SMTP id n4mr5597690qta.21.1607551149652;
        Wed, 09 Dec 2020 13:59:09 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:49a5:bddc:9642:d852? ([2600:1700:e72:80a0:49a5:bddc:9642:d852])
        by smtp.gmail.com with UTF8SMTPSA id e10sm1883218qte.48.2020.12.09.13.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 13:59:08 -0800 (PST)
Subject: Re: [PATCH v4 5/8] maintenance: add start/stop subcommands
To:     Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com, congdanhqx@gmail.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
 <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
 <5194f6b1facbd14cc17eea0337c0cc397a2a51fc.1602782524.git.gitgitgadget@gmail.com>
 <20201209185114.GN36751@google.com> <20201209191616.GO36751@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <19201a12-7df5-9b95-cd8d-ab2be90cbb40@gmail.com>
Date:   Wed, 9 Dec 2020 16:59:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <20201209191616.GO36751@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/9/2020 2:16 PM, Josh Steadmon wrote:
> Whoops, had a small think-o while writing the patch message. Fixed
> below.
> 
> -- >8 --
> Subject: [PATCH] t7900: use --fixed-value in git-maintenance tests
> 
> Use --fixed-value in git-config calls in the git-maintenance tests, so
> that the tests will continue to work even if the repo path contains
> regexp metacharacters.
> 
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  t/t7900-maintenance.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index fab0e01c39..41bf523953 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -422,7 +422,7 @@ test_expect_success 'start from empty cron table' '
>  	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
>  
>  	# start registers the repo
> -	git config --get --global maintenance.repo "$(pwd)" &&
> +	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
>  
>  	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=daily" cron.txt &&
>  	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=hourly" cron.txt &&
> @@ -433,7 +433,7 @@ test_expect_success 'stop from existing schedule' '
>  	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
>  
>  	# stop does not unregister the repo
> -	git config --get --global maintenance.repo "$(pwd)" &&
> +	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
>  
>  	# Operation is idempotent
>  	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&

Thank you for this. While I went to make sure the maintenance builtin worked
properly, I forgot to check the rest of the test script worked as well. This
is a good way to fix that.

Thanks,
-Stolee
 


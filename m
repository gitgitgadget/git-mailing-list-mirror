Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129B6C77B61
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 17:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjDJRhP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 13:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjDJRhN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 13:37:13 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BB310DB
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 10:37:12 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pc4-20020a17090b3b8400b0024676052044so5261348pjb.1
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681148232; x=1683740232;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfKX5Qi9VUFY0HxTp8qA8ZMg1I3Afl4gUzOCrBm1xU8=;
        b=oldjlZLzD7jtqHRuSwiQFpcwm4bp6Z00Bv1MLLF/PTYUcRCLV7qX3WJK/4tXR4760l
         JiHBd1C9u558HKQbVj1kPFauznz6q6rpZdp+hl2rXKc/3REInu8ZaA9WzqbV1oGHbvwO
         92gtbFKY+Tzl4J5KxUD0i+g6n2mrzhXCloZDY3KBd6+iMw82zAL/lW66kq/+51gsiuIG
         9yNr+WgRDG8gzswWfI96rnrBQxSquedXqGk3RM1FvNs5r3+qaCh9M1CEBNqcdUogA2uI
         i2vcoh8VRevzgoK+G9WUrDfuaNsammWtSEb1Unj+NuXYGVd4sFtwSQlIDpr0LLF/ZSyq
         BqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681148232; x=1683740232;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YfKX5Qi9VUFY0HxTp8qA8ZMg1I3Afl4gUzOCrBm1xU8=;
        b=A2qimJOQHqA4rXJBjByA/6gRiUYeGTnwo5JTxR0p/xONW61wY8sx/NAH1h3Ipjixa4
         iOfdTDykmlgQic5sIFLckSlaSobt/YjxyaPnOKXlnPuTqXrCWy1nBVaE/lXUvWzRThbJ
         0p+FN5JMTPpQb4bKyL6Va3nnEDfk0ernKRIf8d0ettE+A0pjIHiytSiLhdRO5rxRN3ej
         qJHw0WY8OvMX1yHEvzGx3tjA+6TwTjzUq/9yh3nmXRnIPbrbL7UM/rOetZGNWSSQ7Wyt
         6m7ENQxpkPoZqbt+9E8fybPu7JoMUp9tzHToCjnH6mX5yohkCPTIcMOfhqz42dOIyQst
         67hw==
X-Gm-Message-State: AAQBX9e3IMgS/viiqyeiYTXvIsVBze8f0YXN0dRUdjhBAIT+Z+z0DGV5
        dn6l+W/k8S5wdR4nVmRkKFU=
X-Google-Smtp-Source: AKy350Zq1DZWX2UIp2zAiGLR+Hnmy+LF4NVJWArqXIPOvZX6525Uxc/KLCNb0cNQ/eMaWIF621qrGg==
X-Received: by 2002:a17:902:e851:b0:1a6:4e86:6ca1 with SMTP id t17-20020a170902e85100b001a64e866ca1mr1643705plg.9.1681148232162;
        Mon, 10 Apr 2023 10:37:12 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902728f00b001a65131441csm351877pll.35.2023.04.10.10.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 10:37:11 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98ystei?= =?utf-8?Q?n?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH] t2024: fix loose/strict local base branch DWIM test
References: <230406.86h6tttn21.gmgdl@evledraar.gmail.com>
        <20230408205450.569548-1-rybak.a.v@gmail.com>
Date:   Mon, 10 Apr 2023 10:37:10 -0700
In-Reply-To: <20230408205450.569548-1-rybak.a.v@gmail.com> (Andrei Rybak's
        message of "Sat, 8 Apr 2023 22:54:50 +0200")
Message-ID: <xmqqfs97ej09.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

>> 3. t2024-checkout-dwim.sh
>> Test 'loosely defined local base branch is reported correctly' in t2024
>> has an interesting validation of output of "git checkout":
>> 
>>      git checkout strict | sed -e "s/strict/BRANCHNAME/g" >expect &&
>>      status_uno_is_clean &&
>>      git checkout loose | sed -e "s/loose/BRANCHNAME/g" >actual &&
>>      status_uno_is_clean &&
>> 
>>      test_cmp expect actual
>> 
>> which is fine, except that neither file "expect" nor "actual" contain
>> the string "BRANCHNAME".  And this test was broken when it was
>> introduced in 05e73682cd (checkout: report upstream correctly even with
>> loosely defined branch.*.merge, 2014-10-14).  It was probably intended
>> for this test to redirect standard error of "git checkout".  It should
>> be cleaned up as a separate patch/topic.
>
> Here's the patch.  Alternatively, the fix could be to just drop the sed
> invocation from this test.

Or we could check both stdout and stderr separately.  I think the
change in this patch reflects the intention of the original most
closely, so let's queue it as-is.

Thanks.


>
>  t/t2024-checkout-dwim.sh | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
> index 4a1c901456..74049a9812 100755
> --- a/t/t2024-checkout-dwim.sh
> +++ b/t/t2024-checkout-dwim.sh
> @@ -305,10 +305,13 @@ test_expect_success 'loosely defined local base branch is reported correctly' '
>  	test_config branch.strict.merge refs/heads/main &&
>  	test_config branch.loose.merge main &&
>  
> -	git checkout strict | sed -e "s/strict/BRANCHNAME/g" >expect &&
> +	git checkout strict >expect.raw 2>&1 &&
> +	sed -e "s/strict/BRANCHNAME/g" <expect.raw >expect &&
>  	status_uno_is_clean &&
> -	git checkout loose | sed -e "s/loose/BRANCHNAME/g" >actual &&
> +	git checkout loose >actual.raw 2>&1 &&
> +	sed -e "s/loose/BRANCHNAME/g" <actual.raw >actual &&
>  	status_uno_is_clean &&
> +	grep BRANCHNAME actual &&
>  
>  	test_cmp expect actual
>  '

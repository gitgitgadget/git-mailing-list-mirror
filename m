Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298E8C433FE
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 09:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11E5760E76
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 09:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241471AbhIFJuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 05:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237787AbhIFJuo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 05:50:44 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700D6C061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 02:49:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n5so8906519wro.12
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 02:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y8vfbbSdA0kLChkQx0/LEskvJ0AhAyn340gprNDtqpk=;
        b=CswTMwJPcTwRuNPbyqaK1uj6fgXFXBWz5n2LhTEeBdrVWv4dEZJuSbX51kug8nn9lc
         LQPLwHv1QVZtGuF/whWQT4YsNaLHAptJo3MZs2EeiRPWNRMEio2WBWxCT36//sLExko5
         tI8c0vEeIzz62kOu/1JzaDthM8QVmoD4gIjxIZe6VY/YNplxWJJMiIgfAOPebsaZ5dex
         jjGfiA/6u+Cj/UWgMJdBJfFhMNhWLX7ZWuw7+pJ/XShoFB2t1G0j3XAnN7xlj90zo/It
         KJxPqNxl54zpZ1bys+A5xD1Qho1yCkB4ZgzIMmRDjt/lowdBzgl+Cb8A7L4bKcnRLVey
         cf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=y8vfbbSdA0kLChkQx0/LEskvJ0AhAyn340gprNDtqpk=;
        b=DY+W9tgU5FpUOE7/ZGUzIiO1n0IcAF7LtN7lB7V1E6Lw++o+wKXsI1mByFArTb8okE
         uNEeDwdYwxDiffAf33KC7VqBslPqV64RJxOYt11+Q5u4oC+t9Xt1yEiE0xhoxKmorE5K
         S7M4DxKknIamdusBd5eyJHVAxHIrMywl4ZYFGWyjKhbH8M6JHJfmoTuOR9BbYfH8KtY0
         V5RC/dji2nqLftPqpk+V3c486DQUDk/+zrv6Gh1XnFVl9r3NYMf/h8B2yw4nkjOEi/xq
         ljQljW/P0ULYxEBtyoxCWq4nsREKg5creu+LWhSsMa0pMGrwh9nP69QhU6Guy98K4tiQ
         r+SQ==
X-Gm-Message-State: AOAM532GAlc5/r48jaHb3Pist0JYtHlIC0MQD4wBCjIQXmP3mnvuqFIG
        h1IFqJ0w+QiT0pYvMJ7ECFs=
X-Google-Smtp-Source: ABdhPJzavzbZEVS0AHF9Fmjt79aoEBIOdwrQ1DBxcQAx9I6eSizsw7Bjupj/iCHiNcmlEkq0K7eTQQ==
X-Received: by 2002:a5d:410b:: with SMTP id l11mr12536309wrp.76.1630921779073;
        Mon, 06 Sep 2021 02:49:39 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.254])
        by smtp.gmail.com with ESMTPSA id o18sm6565084wra.78.2021.09.06.02.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 02:49:38 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/7] git-sh-setup: remove unused git_pager() function
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
 <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com>
 <patch-v2-1.7-8eb1dfbff5d-20210906T070201Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <55293c43-811b-b030-9512-7525f5ebfd12@gmail.com>
Date:   Mon, 6 Sep 2021 10:49:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <patch-v2-1.7-8eb1dfbff5d-20210906T070201Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 06/09/2021 08:05, Ævar Arnfjörð Bjarmason wrote:
> Remove the git_pager() function last referenced by non-test code in
> 49eb8d39c78 (Remove contrib/examples/*, 2018-03-25).
> 
> We can also remove the test for this added in 995bc22d7f8 (pager: move
> pager-specific setup into the build, 2016-08-04), the test that
> actually matters is the one added in e54c1f2d253 (pager: set LV=-c
> alongside LESS=FRSX, 2014-01-06) just above the removed test.
> 
> I.e. we don't care if the "LESS" and "LV" variables are set by
> git-sh-setup anymore, no built-in uses them, we do care that pager.c
> sets them, which we still test for.

git_pager() might not be documented but I think it is useful for script 
authors and I wouldn't be surprised if someone out there is using it. 
The same goes for peel_committish(). It does not seem like a huge 
maintenance burden to keep and maybe document these two functions.

Best Wishes

Phillip

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   git-sh-setup.sh  | 16 ----------------
>   t/t7006-pager.sh | 13 -------------
>   2 files changed, 29 deletions(-)
> 
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 10d97641856..7ee4b0edff5 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -157,22 +157,6 @@ git_editor() {
>   	eval "$GIT_EDITOR" '"$@"'
>   }
>   
> -git_pager() {
> -	if test -t 1
> -	then
> -		GIT_PAGER=$(git var GIT_PAGER)
> -	else
> -		GIT_PAGER=cat
> -	fi
> -	for vardef in @@PAGER_ENV@@
> -	do
> -		var=${vardef%%=*}
> -		eval ": \"\${$vardef}\" && export $var"
> -	done
> -
> -	eval "$GIT_PAGER" '"$@"'
> -}
> -
>   sane_grep () {
>   	GREP_OPTIONS= LC_ALL=C grep @@SANE_TEXT_GREP@@ "$@"
>   }
> diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
> index 0e7cf75435e..08f712a4497 100755
> --- a/t/t7006-pager.sh
> +++ b/t/t7006-pager.sh
> @@ -49,19 +49,6 @@ test_expect_success TTY 'LESS and LV envvars are set for pagination' '
>   	grep ^LV= pager-env.out
>   '
>   
> -test_expect_success !MINGW,TTY 'LESS and LV envvars set by git-sh-setup' '
> -	(
> -		sane_unset LESS LV &&
> -		PAGER="env >pager-env.out; wc" &&
> -		export PAGER &&
> -		PATH="$(git --exec-path):$PATH" &&
> -		export PATH &&
> -		test_terminal sh -c ". git-sh-setup && git_pager"
> -	) &&
> -	grep ^LESS= pager-env.out &&
> -	grep ^LV= pager-env.out
> -'
> -
>   test_expect_success TTY 'some commands do not use a pager' '
>   	rm -f paginated.out &&
>   	test_terminal git rev-list HEAD &&
> 

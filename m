Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E81ECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 18:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiIAScQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 14:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbiIAScO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 14:32:14 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F427C31D
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 11:32:13 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t5so18006669pjs.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 11:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=FwpOFxnMyGC9oZlBZZ4qiefc4Dl+gajd5Gw5UDQPWh0=;
        b=IDBprngdHNCpQpI+qbTtN6/9WEgaobGLZeWxzOZFkZUT6sNI0OJbe8EFIRYYZK8Q3l
         CAEF46rm2HnDbkSEmUO/SG5drOK1Tm/FBnmrRBpCnwZIborg1CLQHrA82sSUGNd+uOY8
         CZYXd/R2YuYk2cVGtbkxnUmYVTM8S1RKk0jnalCXMBb8HFRIuMF9G53ZE0xecRUOI7nk
         4xQsej5ptE56T35SorHbluZnV0aY2c4Sn+0n4yO6i10IWJMkoccUDgLGKtPTHNw/eo03
         CIVbZHySU1vjx8NHJME+I4mEPzvl63jslxRK+nScanpliG2kVgnCvhQQkOaUaB/jqBpq
         nBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=FwpOFxnMyGC9oZlBZZ4qiefc4Dl+gajd5Gw5UDQPWh0=;
        b=52bFoGOy7pVxIis39jlOLZ6rRnLjckl35UwWEJMWxl+xEDmmuQtf7/e1njhI8TA/Lo
         mfT3h3ZxaMXshu9FPzHm8jyYfVsrGGDNuX5H0zcV3taQv+8InyGNzGSBXQooUBnVZXpy
         K/F0mQyktUYnX1UKo7kFqO53sClNteCQEiLjz0mR1xdFYi9L+1HFhiTdUdWF5Itlh1iT
         w09AFI6SMLJ+Aqdu3txM/+fY7Wr5vlJwgBelHkVuJvSp2up/GbQKhJsGuAi04WeyJRUu
         rkVM5YV8XEISI2O7ROhPnxgQuUAdE7cEmsHm9Nw1cV0twUQTt0ktomtZXvx1PQjfrtrF
         ZPWA==
X-Gm-Message-State: ACgBeo3Rn+yIjWO1+9mQmoQx2cOJiyzh/TvbflOd4Nnea71FO0dq+UTO
        zoJA+1KHXjtMQN+hBYOsmH8=
X-Google-Smtp-Source: AA6agR5yCM7E91Om6ZgGTXmxU82+oETb7wcj1EwtRA6bD0OG2cB1Ypln+Wo+7XG2IEP3fG9cohQ9Hg==
X-Received: by 2002:a17:902:7003:b0:172:cbb0:9af8 with SMTP id y3-20020a170902700300b00172cbb09af8mr32338970plk.57.1662057133070;
        Thu, 01 Sep 2022 11:32:13 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902dac300b001751d0ac555sm6179523plx.148.2022.09.01.11.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 11:32:12 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] t1800: correct test to handle Cygwin
References: <20220901173942.abolcr4aa5gixncm@lucy.dinwoodie.org>
Date:   Thu, 01 Sep 2022 11:32:12 -0700
In-Reply-To: <20220901173942.abolcr4aa5gixncm@lucy.dinwoodie.org> (Adam
        Dinwoodie's message of "Thu, 1 Sep 2022 18:39:42 +0100")
Message-ID: <xmqqedwv9c9f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie <adam@dinwoodie.org> writes:

> On Cygwin, when failing to spawn a process using start_command, Git
> outputs the same error as on Linux systems, rather than using the
> GIT_WINDOWS_NATIVE-specific error output.  The WINDOWS test prerequisite
> is set in both Cygwin and native Windows environments, which means it's
> not appropriate to use to anticipate the error output from
> start_command.  Instead, use the MINGW test prerequisite, which is only
> set for Git in native Windows environments, and not for Cygwin.
>
> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> ---
>
> The job of setting Cygwin up to get Git CI builds, either as part of the
> main CI builds or as something using separate automation, is rapidly
> rising up my when-I-have-the-time to-do list...

I added a few who probably are more familiar with Windows situation
than those already CC'ed.

A quick grep in the test directory

    $ git grep '\<WINDOWS\>" t

hits this one and t7450-bad-git-dotfiles.sh and nothing else, but
we do have quite a many hits of "test_have_prereq !MINGW,!CYGWIN".

I guess it depends on how common various "glitches" MINGW and CYGWIN
prerequistes are trying to cover, but I am wondering if we are
helped by having three (i.e. MINGW, CYGWIN, and WINDOWS)
prerequisites, or does WINDOWS as a separate prerequisite
contributes more to the confusion (and if so, if it is a good idea
to remove and use only MINGW and CYGWIN prerequistes).

One possible roadblock is that it is not easy to express "MINGW or
CYGWIN" in the prerequisite syntax and WINDOWS prerequisite is an
easy way to fill that gap.

In any case, thanks for a fix.  Will queue.

>  t/t1800-hook.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> index 64096adac7..fae8b2faf9 100755
> --- a/t/t1800-hook.sh
> +++ b/t/t1800-hook.sh
> @@ -159,7 +159,7 @@ test_expect_success 'git hook run a hook with a bad shebang' '
>  	# TODO: We should emit the same (or at least a more similar)
>  	# error on Windows and !Windows. See the OS-specific code in
>  	# start_command()
> -	if test_have_prereq !WINDOWS
> +	if test_have_prereq !MINGW
>  	then
>  		cat >expect <<-\EOF
>  		fatal: cannot run bad-hooks/test-hook: ...

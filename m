Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9313CEEAA7D
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 00:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjIOAKZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 20:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjIOAKX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 20:10:23 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDBE2100
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 17:10:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40475103519so10601755e9.0
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 17:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694736618; x=1695341418; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgRT15t90N4osUh6/U8/wKTb8O7KBxFwsNY9cKCY4xo=;
        b=mH3IXxAYmxyutc8jjYKgOMVg28q3RPdZFN3bPZ3ibhx7LVtvZ0SuZnENGrwcBPNkyw
         oYUYjRhqWYap/vX0xxT4AwBQ7g1B3Zzumklc0hWkOk1/hoTMu7iCf66NRD+E3jwYpyay
         str+BdSj9gjs9d4oQo9HhLrxcWJcbJxsKB1mtW3CkIfVYpI0hLPAmx4Ph7Q+OnoX5233
         MnOFewfJXMy3rrnUqa0/t6ZC+023yHPcO07e4SIS9pvOR+bZOGQHaC9bHgYqSMYATF/2
         P6ews6krOu33+trNWQ0qgK519BKiy97dy1sNZ8axbFjE0XjQmZQTSHtaiHwRK+0aEP9w
         rUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694736618; x=1695341418;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OgRT15t90N4osUh6/U8/wKTb8O7KBxFwsNY9cKCY4xo=;
        b=nRwQtSWuwyYkv3dUPVwUUlb4nWftm7nKER6qsnkdq6V9THtpAr9sIC6vwqPXAaJ5Ke
         Ss6eXZP28AtqErnCZQIFA+GJyPp81cAhEg/UNslzaDYQziuBNUNiCNXE+nH+DpKisGQt
         /iiBOsUxO68mlad7G75/+2zDsTibQwcoDkLixpDkZOrx9PW5NLzBjrQGxCM1f8ioyA8B
         hgP1ioFTzy9hXQVMr1GIIF8D347WuS1YgzFIzQoYkHksmdIvo2v0T0R0e8SexKKrfR/q
         qYNHAIWH2/5MchgQcuU2uoNnBMsZe3QVREXOZSV10+4F7ToBT656jsnDwft7fyS1sRk6
         aCWQ==
X-Gm-Message-State: AOJu0YxDvoY2seOTUQdTNqohgKzOSiOD7FJS7gBGvX2uJ9aLpDMe9YS4
        ad55dOVOkCQiHrbjpxb4i6aFjibqUJA=
X-Google-Smtp-Source: AGHT+IEebbkfz4oTeWDtEhUggjjPtd6kPikJvgK4Z0T9APxrWGCnwrGvU0cttLleEADgIHV7sSQfsw==
X-Received: by 2002:a05:600c:3647:b0:401:cc0f:f866 with SMTP id y7-20020a05600c364700b00401cc0ff866mr249826wmq.12.1694736617486;
        Thu, 14 Sep 2023 17:10:17 -0700 (PDT)
Received: from [192.168.2.52] (203.red-88-14-40.dynamicip.rima-tde.net. [88.14.40.203])
        by smtp.gmail.com with ESMTPSA id f21-20020a7bcd15000000b003fe24441e23sm3197229wmj.24.2023.09.14.17.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 17:10:17 -0700 (PDT)
Subject: Re: [PATCH 1/2] test-lib: prevent misuses of --invert-exit-code
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
References: <68522960-edda-26d3-ddca-cee63f2d859e@gmail.com>
 <1a60a1ca-0ef0-ecf5-d0aa-a28d7c148a82@gmail.com>
 <20230912083528.GC1630538@coredump.intra.peff.net>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <0d0e903f-aa3e-964d-7935-ceaae04a413e@gmail.com>
Date:   Fri, 15 Sep 2023 02:10:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230912083528.GC1630538@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12-sep-2023 04:35:28, Jeff King wrote:
> On Sun, Sep 10, 2023 at 01:08:11AM +0200, Rubén Justo wrote:
> 
> > GIT_TEST_PASSING_SANITIZE_LEAK=true and GIT_TEST_SANITIZE_LEAK_LOG=true
> > use internnlly the --invert-exit-code machinery.  Therefore if the user
> > wants to use --invert-exit-code in combination with them, the result
> > will be confusing.
> > 
> > For the same reason, we are already using BAIL_OUT if the user tries to
> > combine GIT_TEST_PASSING_SANITIZE_LEAK=check with --invert-exit-code.
> > 
> > Let's do the same for GIT_TEST_PASSING_SANITIZE_LEAK=true and
> > GIT_TEST_SANITIZE_LEAK_LOG=true.
> 
> OK, so we are trying to find a case where the user is triggering
> --invert-exit-code themselves and complaining. But in the code...
> 
> > @@ -1557,15 +1557,25 @@ then
> >  			say "in GIT_TEST_PASSING_SANITIZE_LEAK=check mode, setting --invert-exit-code for TEST_PASSES_SANITIZE_LEAK != true"
> >  			invert_exit_code=t
> >  		fi
> > -	elif test -z "$passes_sanitize_leak" &&
> > -	     test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
> > +	elif test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
> >  	then
> > -		skip_all="skipping $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=true"
> > -		test_done
> > +		if test -n "$invert_exit_code"
> > +		then
> > +			BAIL_OUT "cannot use --invert-exit-code under GIT_TEST_PASSING_SANITIZE_LEAK=true"
> > +		elif test -z "$passes_sanitize_leak"
> > +		then
> > +			skip_all="skipping $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=true"
> > +			test_done
> > +		fi
> >  	fi
> 
> You can see at the top of the context that we will set
> invert_exit_code=t ourselves, which will then complain here:
> 
> >  	if test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
> >  	then
> > +		if test -n "$invert_exit_code"
> > +		then
> > +			BAIL_OUT "cannot use --invert-exit-code and GIT_TEST_SANITIZE_LEAK_LOG=true"
> > +		fi
> > +
> >  		if ! mkdir -p "$TEST_RESULTS_SAN_DIR"
> >  		then
> >  			BAIL_OUT "cannot create $TEST_RESULTS_SAN_DIR"
> 
> That varible-set in the earlier context is from running in "check" mode.
> So:
> 
>   make GIT_TEST_PASSING_SANITIZE_LEAK=check GIT_TEST_SANITIZE_LEAK_LOG=true
> 
> will now always fail. But this is the main way you'd want to run it
> (enabling the leak log catches more stuff, and the log-check function
> you touch in patch 2 already covers check mode).
> 
> So I think you'd have to hoist your check above the if/else for setting
> up PASSING_SANITIZE_LEAK modes.

Arrg, sorry.  You're right.

This was part of the series by mistake.  Please, discard it.

In my tree, I have a previous commit with:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 87cfea9e9a..46b8a76e9c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1556,7 +1556,6 @@ then
                if test -z "$passes_sanitize_leak"
                then
                        say "in GIT_TEST_PASSING_SANITIZE_LEAK=check mode, setting --invert-exit-code for TEST_PASSES_SANITIZE_LEAK != true"
-                       invert_exit_code=t
                fi
        elif test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
        then

that is part of an unsent attempt to make:

  $ make SANITIZE=leak T=t7510-signed-commit.sh GIT_TEST_PASSING_SANITIZE_LEAK=check test
 
not to suggest, when GPG is missing, that t7510-signed-commit.sh is a
candidate to be marked as leak-free.  Which is distracting to me.

However I was not satisfied with the solution and discarded it.  But
unfortunately not entirely.  Sorry. 

> 
> -Peff

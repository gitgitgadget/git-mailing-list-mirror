Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE25DC64ED6
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 00:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjB0AAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 19:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjB0AAk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 19:00:40 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5119FE3A6
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 16:00:39 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so2845662wmq.2
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 16:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677456038;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+q/Or/45CoGoCGErS1G69a0cqVv/gCIJvvUadkZkFik=;
        b=P/i/VMllwTxtmL8gKD4qGJCUn9g/jXrkb0zS6Ueo4/o6lZlcAiigNBlNocHQGaDP6S
         +EsNC2LrH/T7Z8VH60WmskyzHWnYBb7070Sm56PaEZqjYT2x4L+wsTzD4ikqzYG9tqM5
         L94FYpI3XiA1sncbzSJDa3o4OPdRGdmunuZiEGlPEaijSqAsG7IgtM1kK6lfDd0wU/1A
         y8neLj7fpaVyDrdSetaaIGPSy3IcZ4M9r4SG9wNQtgpxGA4lXMEn75N+7/aDtto5NpQe
         9+VX/Yx0WMGSLqRMkN1WVFadStAC8gVAMjCf/X1IzAZMcOLzVzu3nMmkjZQAy+dciCE8
         5ozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677456038;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+q/Or/45CoGoCGErS1G69a0cqVv/gCIJvvUadkZkFik=;
        b=K2FK0QKvWl9YI47XR7fBgjXV9nrlg6jLlIc8szOb+n7VYnt2QF42TkgvXWBz9zksq9
         ZZeqia4VlbF9A6//CUGzOthz81XN/chdPzBREKCFEdsXVzmH05PoxlBccH9CVfarzmGu
         EJC0y0wfQi519FvsAc2N5CglcMkVRIDjXn69FKyITRxqjOpuQZDWagyFFG62wHK5WHlO
         lODB6bEz0tlMwej2BCWLIssMJwthSK9Y0JfchUoD4P5URCD5wmBvAXGjNpVHKSi0Uio5
         JnAwQ+R1OzOJzNODvsL4Ae6zCb/wEm2af3lFpQdN/SmrTnH7Q+U2StOMz//ouBPKzBHJ
         Jq0Q==
X-Gm-Message-State: AO0yUKVARIru9O7rpfHBfLRS3wwgsT0909V/KvGew0mmZg5d/pvWBx7y
        KTM/kbK6bKT1PG2RUlrt0Ho=
X-Google-Smtp-Source: AK7set+Bp6u/1hbscp1uGCCqioRj9B3/sdeHquubYg/1+kzLxLmEJiY1k1srPAnDcHLOhWUG5R5lWA==
X-Received: by 2002:a1c:ed1a:0:b0:3ea:f6c4:305e with SMTP id l26-20020a1ced1a000000b003eaf6c4305emr8492100wmh.38.1677456037642;
        Sun, 26 Feb 2023 16:00:37 -0800 (PST)
Received: from [192.168.2.52] (59.red-88-14-203.dynamicip.rima-tde.net. [88.14.203.59])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c219100b003e7f1086660sm10794218wme.15.2023.02.26.16.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 16:00:37 -0800 (PST)
Subject: Re: [PATCH v4 0/4] fix die_if_checked_out() when
 ignore_current_worktree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
 <6fed3b1b-1c4e-9298-19b6-7ad9c04c87dd@gmail.com> <xmqqbklhuzq8.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <7a8dc2ee-a8a3-b59e-f2ea-a7720320fb7c@gmail.com>
Date:   Mon, 27 Feb 2023 01:00:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqbklhuzq8.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25-feb-2023 14:50:07, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> >      +	test_when_finished "
> >     -+		git worktree remove wt1 &&
> >     -+		git worktree remove wt2 &&
> >     -+		git branch -d shared
> >     -+		git checkout -
> >     ++		git worktree remove wt1 ||:
> >     ++		git worktree remove wt2 ||:
> >     ++		git checkout - ||:
> >     ++		git branch -D shared ||:
> >      +	" &&
> 
> Sorry, but I do not get the point of this construct.  The
> test_cleanup variable that accumulates test_when_finished scripts is
> evaled without -e shopt set, so you can just remove all these ||:
> and add a single "true" at the end, like
> 
> 	...
> 	git checkout -
> 	git branch -D shared
> 	:
>     " &&
> 
> for exactly the same effect, no?

Yes, of course.

I agree that all of that '||:' can be confusing, but I'm not sure if a
final ':' is much better.

As I said in my response to Eric, I don't have a clear opinion here.

test_when_finished() was introduced in 2bf78867 (test-lib: Let tests
specify commands to be run at end of test, 2010-05-02) to allow
indicating some actions to be executed after the test block finishes,
even if the test fails, to leave a repository or overall situation
healthy for the next tests.

With that in mind, I ask myself, is it worth removing the worktrees
here?  Is it worth reporting a possible error in that removal?  If, for
example, in the future we deny the removal of a worktree under bisect,
is it worth reporting the failure here?  What about the "shared"
branch? ...

I Dunno.

Thank you for reviewing this patch.

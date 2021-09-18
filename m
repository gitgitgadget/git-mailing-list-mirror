Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F5FC433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 09:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E06C2610D1
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 09:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238190AbhIRJNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 05:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbhIRJNW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 05:13:22 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023FAC061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 02:11:59 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c22so39249408edn.12
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 02:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=dMBHYhcAk+O/Az/5c7JARlTAim7QMtsE2m2tmgzVH1k=;
        b=XNAee8a/mug3Y79mVpJxLi9LJq1CUtnKECB1UKBHwrOucqSUv2bvuekzWf6w+8/4ay
         HM74UBSEHmG5v3oha/iMVpX+bVQicI4SZxKW0y2aQZBGZatAfarVMR5rshrK5NoJL8Zk
         9K2eF+dtybEY5cuApsEBItppdBXNHihGuR8zKWIVZsTvvgxT75LpSGQ1WY6W+9R/AMgI
         4H8HWDMz4vHPD5Gf65vhhIie01ikEiqAkTDBwFh4poFnxuXILiVZ+OuG1Fr159ir71iH
         S9uPha364ljkFLFPNRWsjSPal/Z/eZ8KEPQWa/qvYhTeu2NrEhGGmaisjv2iIZLSdgco
         012w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=dMBHYhcAk+O/Az/5c7JARlTAim7QMtsE2m2tmgzVH1k=;
        b=4oQy4hhPnpD8pzwYKI/2i1iTDZ6rE8Mr2aG6U2HlhipRLBQGidqdTLVGO7snkidU6o
         djQuN0WhniPv6u4KbdZTuDiAU4kPjkWeKF1EcVfCyhQbecvOkHEusBClMT09A4WgbUPI
         KjivdyAg2/zYLsab+QbeMHkahTlyRq9ZMTTufmHs5nFfwabYVgQ3e7Jzh2FAJ7W2fNOR
         QnNGqQ09wqtkH39b3lbLsOKKxIFRc+a6uaHLVoQYAHegNw/2bnTDnWfz8cfSm+PBAlSZ
         76uInMWYVBBiBXrw2RZj8dYITH4sP8hwu1+Ea77Tvb+w3Q5zch6JbauVrYZKJ5vUkwE8
         rkZA==
X-Gm-Message-State: AOAM530E3lA7D7Xg54cREbsBP7CT3sUZhtukXhI1qY1bvdWgmN6UeSJv
        xI8+RNLz8tSuzwnx4CurprvobZNJuNs=
X-Google-Smtp-Source: ABdhPJxnhMzscTvVUKETVisCxba09tact8WdqrEmStKmbQA8raTdutz3JooSE3joJBaaOPr66tFHUw==
X-Received: by 2002:a50:d989:: with SMTP id w9mr17893551edj.99.1631956317421;
        Sat, 18 Sep 2021 02:11:57 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j14sm3969261edk.7.2021.09.18.02.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 02:11:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 7/7] t/helper/simple-ipc: convert test-simple-ipc to use
 start_bg_command
Date:   Sat, 18 Sep 2021 10:59:10 +0200
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <57f29feaadb4a732892cd193b2a1d3c838f09421.1631738177.git.gitgitgadget@gmail.com>
 <YULQ8DJFKlrOml8Z@nand.local>
 <aaad241c-4014-729c-32c9-df7039439a77@jeffhostetler.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <aaad241c-4014-729c-32c9-df7039439a77@jeffhostetler.com>
Message-ID: <87ilyycko3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 17 2021, Jeff Hostetler wrote:

> On 9/16/21 1:06 AM, Taylor Blau wrote:
>> On Wed, Sep 15, 2021 at 08:36:17PM +0000, Jeff Hostetler via GitGitGadget wrote:
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>
>>> Convert test helper to use `start_bg_command()` when spawning a server
>>> daemon in the background rather than blocks of platform-specific code.
>>>
>>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>>> ---
>>>   t/helper/test-simple-ipc.c | 193 ++++++++-----------------------------
>>>   1 file changed, 40 insertions(+), 153 deletions(-)
>>>
>>> diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
>>> index 91345180750..59a950f3b00 100644
>>> --- a/t/helper/test-simple-ipc.c
>>> +++ b/t/helper/test-simple-ipc.c
>>> @@ -9,6 +9,7 @@
>>>   #include "parse-options.h"
>>>   #include "thread-utils.h"
>>>   #include "strvec.h"
>>> +#include "run-command.h"
>>>
>>>   #ifndef SUPPORTS_SIMPLE_IPC
>>>   int cmd__simple_ipc(int argc, const char **argv)
>>> @@ -274,178 +275,64 @@ static int daemon__run_server(void)
>>>   	return ret;
>>>   }
>>>
>>> -#ifndef GIT_WINDOWS_NATIVE
>>> -/*
>>> - * This is adapted from `daemonize()`.  Use `fork()` to directly create and
>>> - * run the daemon in a child process.
>>> - */
>>> -static int spawn_server(pid_t *pid)
>>> -{
>>> -	struct ipc_server_opts opts = {
>>> -		.nr_threads = cl_args.nr_threads,
>>> -	};
>>> +static start_bg_wait_cb bg_wait_cb;
>> This whole patch is delightful to read, as the new implementation is
>> so
>> much cleaner as a result of the earlier work in this series.
>> Am I correct in assuming that this is to encourage a compiler error
>> if
>> bg_wait_cb does not satisfy the type of start_bg_wait_cb? If so, then I
>> think we are already getting that by trying to pass bg_wait_cb to
>> start_bg_command().
>
> I use that trick to get the compiler to give me a compiler error at the
> point of the function declaration.
>
> For example, If I add an arg to the function that doesn't match what's
> in the prototype definition, I get:
>
> t/helper/test-simple-ipc.c:280:12: error: conflicting types for 'bg_wait_cb'
> static int bg_wait_cb(const struct child_process *cp, void *cb_data,
> int foo)
>            ^
> t/helper/test-simple-ipc.c:278:25: note: previous declaration is here
> static start_bg_wait_cb bg_wait_cb;
>                         ^
> 1 error generated.
>
> Yes, we may get an error when the function pointer is referenced in
> start_bg_command() or if we're using it to initialize a vtable or
> something, but those errors are further away from the actual error
> (and sometimes they can be a little cryptic).
>
> Also, it helps document that this function's signature is predefined
> for a reason.
>
> It's a quirky trick I know, but it has served me well over the years.

I haven't seen this idiom before. I think it's best to avoid patterns
designed to massage messages out of any specific compilers/versions.

It seems inevitable that it'll either be counter-productive or
redundant. Here with clang v11 doing this makes the warning
worse. I.e. without the forward declaration:

    t/helper/test-simple-ipc.c:315:31: error: incompatible function
    pointer types passing 'int (void *, const struct child_process *,
    int)' to parameter of type ' start_bg_wait_cb *' (aka 'int (*)(void
    *, const struct child_process *)')
    [-Werror,-Wincompatible-function-pointer-types]
            sbgr = start_bg_command(&cp, bg_wait_cb, NULL, cl_args.max_wait_sec);
                                         ^~~~~~~~~~
    ./run-command.h:564:29: note: passing argument to parameter 'wait_cb' here
                                      start_bg_wait_cb *wait_cb,
                                                        ^
    1 error generated.

I.e. we get the specific warning category for this type of error
(-Werror,-Wincompatible-function-pointer-types), and we're pointed at
the caller in question (which to be fair, it seems you don't prefer),
but also a reference to the run-command.h definition.

Most importantly, we get quoted what the type is/should be, which is
missing with the forward declaration. It's the equivalent of saying "you
did bad!" instead of "you did bad X, do Y instead!".

>> E.g., applying this (intentionally broken) diff on top:
>> --- 8< ---
>> diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
>> index 59a950f3b0..3aed787206 100644
>> --- a/t/helper/test-simple-ipc.c
>> +++ b/t/helper/test-simple-ipc.c
>> @@ -275,9 +275,7 @@ static int daemon__run_server(void)
>>   	return ret;
>>   }
>> -static start_bg_wait_cb bg_wait_cb;
>> -
>> -static int bg_wait_cb(void *cb_data, const struct child_process *cp)
>> +static int bg_wait_cb(const void *cb_data, const struct child_process *cp)
>>   {
>>   	int s = ipc_get_active_state(cl_args.path);
>> --- >8 ---
>> and then compiling still warns of a mismatched type when calling
>> start_bg_command().
>> 
>>> -	*pid = fork();
>>> -
>>> -	switch (*pid) {
>>> -	case 0:
>>> -		if (setsid() == -1)
>>> -			error_errno(_("setsid failed"));
>>> -		close(0);
>>> -		close(1);
>>> -		close(2);
>>> -		sanitize_stdfds();
>>> +static int bg_wait_cb(void *cb_data, const struct child_process *cp)
>>> +{
>>> +	int s = ipc_get_active_state(cl_args.path);
>>>
>>> -		return ipc_server_run(cl_args.path, &opts, test_app_cb,
>>> -				      (void*)&my_app_data);
>>> +	switch (s) {
>>> +	case IPC_STATE__LISTENING:
>>> +		/* child is "ready" */
>>> +		return 0;
>>>
>>> -	case -1:
>>> -		return error_errno(_("could not spawn daemon in the background"));
>>> +	case IPC_STATE__NOT_LISTENING:
>>> +	case IPC_STATE__PATH_NOT_FOUND:
>>> +		/* give child more time */
>>> +		return 1;
>>>
>>>   	default:
>> I'm always a little hesitant to have default cases when switch over
>> enum
>> types, since it suppresses the warning when there's a new value of that
>> type. But we already have a similar default in client__probe_server().
>
> Do all compilers now handle switching over an enum and detect unhandled
> cases?  Once upon a time that wasn't the case IIRC.

I don't think so, but the ones we widely use do, i.e. clang and gcc at
least.

For this sort of thing it really doesn't matter if *all* compilers
support it, since we'll only need to catch such "missing enum arm"
issues with one of them.

E.g. in my 338abb0f045 (builtins + test helpers: use return instead of
exit() in cmd_*, 2021-06-08) I fixed something that I've only gotten
Oracle SunCC to emit (gcc and clang don't detect it), but as long as
that one compiler does & someone checks it regularly...

By having a "default" case you're hiding that detection from the
compilers capable of detecting a logic error in this code, whereas if
the compiler can't do that it'll just ignore it.

Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67191C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 09:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2B9206E9
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 09:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUIaREcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387721AbgDBJjk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 05:39:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40423 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgDBJjk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 05:39:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id a81so2835729wmf.5
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 02:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h+YiFKZjNefqnqY5Cqx7pacOausLNv9MuZUugv5MIRQ=;
        b=ZUIaREcODyhyZepiLNX91SSK/Kmr9PdiYUzLSv2doRqVZtnf6k2ACz3I+Qct2kSFER
         k/eUchncpsmEjY3Froya6dPJtqtkXEY3Uynw3Mow4AcrDj4lecQZvvrwJpXc1T1irsAD
         HEn6eu3jnCw+8Y0NlbQdUmj3GTWVKNpKEPvWt1UUjx0gi2oR1BAqnVGZXML4d9rKXaB1
         5yv+/Hz6bzgkU3+jFPw2OnckW0/Nf7/8H1UglhjYRW/WTZ3FvrDEAKKcw7A7TTAmy/3G
         10wNCgyBUXB2lj1R/fMw5g+ekmx9/Yt4k54IpVdnLQW3W11+OXRLPUzMiMpY8NkhE3TI
         PB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=h+YiFKZjNefqnqY5Cqx7pacOausLNv9MuZUugv5MIRQ=;
        b=Pg7EMh8L0q8qBHsV7qG2yXhJRz4CqoAudP5OjMNO9QCGOrv8IeDqsKUCbrEaHICAMI
         DNpCKB708K1BjAIUt54VTW4voaxtqlEi4KKEuu4SUfpvKoHvjrM2hlVImtoq9XfPQH1S
         5jefC2he8gwPtsJ9CVZxuHVpEzXnnu3YYxxRi7+y2tHaKiZZMEwVe7DsfxoUrchBokQr
         4EMqT/XrBGq2DN6ZeQ3zr9ptX8JGPkfC4u+dBRgnK8o1cwt2dpzhaI+1d6Cc6IMtmF5R
         q8fc07UbogrC75lfAw6nyq/HG0hhwkqEAEoquV4dnYYve2PLno7Y25XOmqH7ynQEIinK
         lcbQ==
X-Gm-Message-State: AGi0PuY3KXO5WolbIzCBGWf6YGKrJD9dofvNUkccXW/5HYHJpjGI7bEW
        PVnli/EnxlGFW7N5dB8WnoM=
X-Google-Smtp-Source: APiQypIaXZfENErbHiM73GZiqvEQFJkGbqHtxqGdfhT9pXdOCQJyZ77lU8Ai7h3hCKPmzCe0JJXzvA==
X-Received: by 2002:a7b:c92d:: with SMTP id h13mr2545398wml.120.1585820376380;
        Thu, 02 Apr 2020 02:39:36 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id a186sm6359091wmh.33.2020.04.02.02.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 02:39:35 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: honor GIT_REFLOG_ACTION
To:     Elijah Newren <newren@gmail.com>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Gevers <elbrus@debian.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.746.git.git.1585773096145.gitgitgadget@gmail.com>
 <24197.9157.362143.972556@chiark.greenend.org.uk>
 <CABPp-BGo=6W5wfba7us8ca3eAfz04v8WxyOQ96DkoXn2fV=J1Q@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <5c5532ac-7df5-e8ef-9122-f015783427c2@gmail.com>
Date:   Thu, 2 Apr 2020 10:39:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGo=6W5wfba7us8ca3eAfz04v8WxyOQ96DkoXn2fV=J1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/04/2020 06:15, Elijah Newren wrote:
> On Wed, Apr 1, 2020 at 4:29 PM Ian Jackson
> <ijackson@chiark.greenend.org.uk> wrote:
>>
>> Hi.  Thanks for looking at this.
>>
>> Elijah Newren via GitGitGadget writes ("[PATCH] sequencer: honor GIT_REFLOG_ACTION"):
>>>      I'm not the best with getenv/setenv. The xstrdup() wrapping is
>>>      apparently necessary on mac and bsd. The xstrdup seems like it leaves us
>>>      with a memory leak, but since setenv(3) says to not alter or free it, I
>>>      think it's right. Anyone have any alternative suggestions?
>>
>> I can try to help.  It's not entirely trivial.
>>
>> The setenv interface is a wrapper around putenv.  putenv has had a
>> variety of different semantics.  Some of these sets of semantics
>> cannot be used to re-set the same environment variable without a
>> memory leak - and even figuring out what semantics you have would be
>> complex and tend to produce code which would fail in bad ways.
>> There's a short summary of the situation in Linux's putenv(3).
>>
>> Would it be possible for git to arrange to set GIT_REFLOG_ACTION only
>> when it is invoking subprocesses ? Otherwise it would update, and >> look at, a global variable of its own.  (Or a parameter to relevant
>> functions if one doesn't like the action-at-a-distance effect of a
>> global.)
>>
>> And, it seems to me that the reflog handling should be centralised.
>>
>>> +     char *reflog_action = getenv("GIT_REFLOG_ACTION");
>>>
>>>        va_start(ap, fmt);
>>>        strbuf_reset(&buf);
>>> -     strbuf_addstr(&buf, action_name(opts));
>>> +     strbuf_addstr(&buf, reflog_action ? reflog_action : action_name(opts));
>>
>> Open coding this kind of thing at every site which needs to think
>> about the reflog actions will surely result in some of the instances
>> having bugs.
>>
>> Writing a single function that contans this (or most of it) would
>> happily decouple all of its call sites from literally asking about
>> getenv("GIT_REFLOG_ACTION") thereby making it easier to do the
>> indirection-through-program-variables I suggest.
> 
> That sounds great, but I'm not sure that "only when invoking
> subprocesses" will limit the places where we set the environment
> variable all that much; it might actually expand it.

Off hand I think we'd need to change run_git_checkout(), 
run_git_commit() and do_merge() to set the environment variable and fix 
try_to_commit() to use a proper variable for the reflog message.

>  I wasn't there
> for the whole history, but my understanding is the rebase code has
> slowly transformed from the original all-shell rebase
> implementation(s), to being a helper program that the shell could call
> into for parts of its operations and passing control back and forth
> between shell and C, to being a reimplementation of just invoking the
> same commands that the shell script would have, to slowly transforming
> into an actual library where invocations of other git subprocesses are
> being replaced with relevant function calls.  It's a long cleanup
> process that is still ongoing.  I'd like to get to the point where we
> only invoke subprocesses if the user specifies --exec or a special
> merge strategy, but that's a goal with a longer term timeframe than
> fixing a 2.26 regression.
> 
>> Having said that,
>>
>>> diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
>>> index 61b76f33019..927a4f4a4e4 100755
>>> --- a/t/t3406-rebase-message.sh
>>> +++ b/t/t3406-rebase-message.sh
>>
>> This test case convinces me that the patch has the right behaviour for
>> at least the case I care about :-).
> 
> Cool, sounds like it's a good immediate fix for the 2.26 regression,
> and then longer term as we continue refactoring we can hopefully
> isolate subprocess handling and writing of state.
> 
> As a heads up, though, my personal plans for rebase (subject to buy-in
> from other stakeholders) is to make it do a lot more in-memory work.
> In particular, this means for common cases there will be no subprocess
> invocations, no writing of any state unless/until you hit a conflict,
> no updating of any files in the working tree until all commits have
> been created (or a conflict is hit), 

I'm with you up to here - it sounds fantastic

> and no updating of the branch
> until after all the commits have been created.

We only update the branch reflog at the end of the rebase now.

> Thus, for the common
> cases with no conflicts, there would only be 1 entry in the reflog of
> HEAD the entire operation, rather than approximately 1 per commit. 

This I'm not so sure about. In the past where I've messed up a rebase 
and not noticed until after a subsequent rebase it has been really 
useful to be able to go through HEAD's reflog and find out where exactly 
I messed up by looking at the sequence of picks for the first rebase. 
Specifically it shows which commits where squashed together which you 
cannot get by running git log on the result of the rebase.

> I
> have a proof-of-concept showing these ideas work for basic cases. 

Sounds exciting

Best Wishes

Phillip

  So,
> I hope your tests don't depend on the number of entries added to
> HEAD's reflog.
> 

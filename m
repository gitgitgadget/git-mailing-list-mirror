Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1E1C4338F
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CC6160F23
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhGYMW5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 08:22:57 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:12406 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230193AbhGYMW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 08:22:57 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 880F012A9;
        Sun, 25 Jul 2021 15:03:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1627218204; x=1629032605; bh=5DvklacT0SzWIQC/wWN
        QJfm9O7HpVaCzv4aoVCLy4VQ=; b=RyWitmJ3yKLP78gxl7hgyss/FeT6IwNL4As
        /SARDfw7OyD1YY3UpdcGTrVdloHsv0MZoyYOrgYD9RPv0v/BUD0l5gXfbaKWGm12
        RTelukVwKWNQV0r2pVWg457Ddvsz9BelYfWIjB+nHx/xk/jq+20vZhiIDsaM3HLY
        ZOg4syRikzLRTlaoRRFp+CK6R6zy94qJjgluU/OIbzPPTg4tika+soNR0AacDLm5
        ZarJZ7sM8T8HBAvZ/kcsphmQBeI67lkzQDb5i1ofpwSpIoqSYM9fPmhcHbgCi+9A
        WcwxpUa0Zmub57uwJm4LXULMmb9os6sQjr1kKmtTLGIygY393QyBc1yXjFa7B4ns
        kWSe8p2os/lgvWfME9NrBl9PA1/URuzSyKCpTza7nsdc7os9JluYRCjOCyocKWEs
        4lCLtyejA2EuBenuRbz32NctnMiKU2Ki3UyHJarVrNdob4W37/N1gYalK5Nl9+E2
        aNZzhetPLGsoetd0x/6WpAx1m1b2+xFyHfQHi7XdJ8bGUHXOgJh3yIorffDx9i3o
        ZomVh3kd5AlXM91OGQEm+Dt/2D8Vj9E/xnO0slPhCIFdUZqRNLfRWYBT/3vcTUTC
        XxNzE/DBC22kBKdfiDjJMMb+yZE4eSeJqiOXyyjjnfJLuI5eHyC38pk18bVWTNHl
        j/DHwLwo=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id efrHJeIsjpFg; Sun, 25 Jul 2021 15:03:24 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id BB2C88B8;
        Sun, 25 Jul 2021 15:03:24 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 2104E444;
        Sun, 25 Jul 2021 15:03:23 +0200 (CEST)
Subject: Re: [PATCH 11/12] builtin/rebase: fix options.strategy memory
 lifecycle
To:     phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
 <20210620151204.19260-12-andrzej@ahunt.org>
 <6e02fc85-42a4-8b19-1fe7-3527c2308a24@gmail.com>
 <CABPp-BEQkUQLt-ZbwdO+ecd2rumttBUKUmh3=7LaKRxwXCkB+g@mail.gmail.com>
 <d1ef45c1-067e-abde-62a2-1df2c12ba3a3@gmail.com>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <9f298c97-07d6-7117-baab-6a44359c44d2@ahunt.org>
Date:   Sun, 25 Jul 2021 15:03:21 +0200
MIME-Version: 1.0
In-Reply-To: <d1ef45c1-067e-abde-62a2-1df2c12ba3a3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 22/06/2021 11:02, Phillip Wood wrote:
> Hi Elijah
> 
> On 21/06/2021 22:39, Elijah Newren wrote:
>> On Sun, Jun 20, 2021 at 11:29 AM Phillip Wood 
>> <phillip.wood123@gmail.com> wrote:
>>>
>>> Hi Andrzej
>>>
>>> Thanks for working on removing memory leaks from git.
>>>
>>> On 20/06/2021 16:12, andrzej@ahunt.org wrote:
>>>> From: Andrzej Hunt <ajrhunt@google.com>
>>>>
>>>> This change:
>>>> - xstrdup()'s all string being used for replace_opts.strategy, to
>>>
>>> I think you mean replay_opts rather than replace_opts.
>>>
>>>>     guarantee that replace_opts owns these strings. This is needed 
>>>> because
>>>>     sequencer_remove_state() will free replace_opts.strategy, and it's
>>>>     usually called as part of the usage of replace_opts.
>>>> - Removes xstrdup()'s being used to populate options.strategy in
>>>>     cmd_rebase(), which avoids leaking options.strategy, even in the
>>>>     case where strategy is never moved/copied into replace_opts.
>>>
>>>
>>>> These changes are needed because:
>>>> - We would always create a new string for options.strategy if we either
>>>>     get a strategy via options (OPT_STRING(...strategy...), or via
>>>>     GIT_TEST_MERGE_ALGORITHM.
>>>> - But only sometimes is this string copied into replace_opts - in which
>>>>     case it did get free()'d in sequencer_remove_state().
>>>> - The rest of the time, the newly allocated string would remain unused,
>>>>     causing a leak. But we can't just add a free because that can 
>>>> result
>>>>     in a double-free in those cases where replace_opts was populated.
>>>>
>>>> An alternative approach would be to set options.strategy to NULL when
>>>> moving the pointer to replace_opts.strategy, combined with always
>>>> free()'ing options.strategy, but that seems like a more
>>>> complicated and wasteful approach.
>>>
>>> read_basic_state() contains
>>>          if (file_exists(state_dir_path("strategy", opts))) {
>>>                  strbuf_reset(&buf);
>>>                  if (!read_oneliner(&buf, state_dir_path("strategy", 
>>> opts),
>>>                                     READ_ONELINER_WARN_MISSING))
>>>                          return -1;
>>>                  free(opts->strategy);
>>>                  opts->strategy = xstrdup(buf.buf);
>>>          }
>>>
>>> So we do try to free opts->strategy when reading the state from disc and
>>> we allocate a new string. I suspect that opts->strategy is actually NULL
>>> in when this function is called but I haven't checked. 

Thank you for noticing this. I think you're right - running an ASAN 
build past the whole test suite also didn't catch any double-frees which 
mostly confirms that opts->strategy is indeed always NULL here. But 
that's not a good reason for taking the risk.

>>> Given that we are
>>> allocating a copy above I think maybe your alternative approach of
>>> always freeing opts->strategy would be better.

I will go down this route for V2. Although on further thought: instead 
of my original idea of moving the string to replay_opts (and NULL'ing 
out rebase_options->strategy), I think it's better to create a new copy 
when populating replay_opts. The move/NULL approach I suggested in V1 
happens to work OK, but I think it's non-obvious and could break if we 
ever wanted to use get_replay_opts() more than once - creating separate 
copies reduces the number of surprises.

>>
>> Good catches.  sequencer_remove_state() in sequencer.c also has a
>> free(opts->strategy) call.
>>
>> To make things even more muddy, we have code like
>>      replay.strategy = replay.default_strategy;
>> or
>>      opts->strategy = opts->default_strategy;
>> which both will probably work really poorly with the calls to
>>      free(opts->default_strategy);
>>      free(opts->strategy);
>> from sequencer_remove_state().  I suspect we've got a few bugs here...
> 
> It's not immediately obvious but I think those are actually safe. 
> opts->default_strategy is allocated by sequencer_init_config() so it is 
> correct to free it and when we assign it in rebase.c we do
> 
>      else if (!replay.strategy && replay.default_strategy) {
>          replay.strategy = replay.default_strategy;
>          replay.default_strategy = NULL;
>      }
> 
> so there is no double free.

As mentioned above, ASAN isn't catching any double-frees here (but I 
guess that depends on whether or not you trust the test suite to be 
reasonably testing all permutations).

But it's still good to take note of sequencer_remove_state() free'ing 
opts->strategy, because I almost did manage to add a double free when I 
added a free(options.strategy) to cmd_rebase without also xstrdup'ing 
strategy in get_replay_opts().

> There is similar code in builtin/revert.c 
> which I think is where your other example came from. I think there is a 
> leak in builtin/revert.c though
> 
>      if (!opts->strategy && opts->default_strategy) {
>          opts->strategy = opts->default_strategy;
>          opts->default_strategy = NULL;
>      }
> 
>      /* do some other stuff */
> 
>      /* These option values will be free()d */
>      opts->gpg_sign = xstrdup_or_null(opts->gpg_sign);
>      opts->strategy = xstrdup_or_null(opts->strategy);
> 
> So we copy the default strategy, leaking the original copy from 
> sequencer_init_options() if --strategy isn't given on the command line. 
> I think it would be simple to fix this by making the copy earlier.
> 
>      if (!opts->strategy && opts->default_strategy) {
>          opts->strategy = opts->default_strategy;
>          opts->default_strategy = NULL;
>      } else if (opts->strategy) {
>      /* This option will be free()d in sequencer_remove_state() */
>          opts->strategy = xstrdup(opts->strategy);
>      }
> 

Nice find. I'm noticing a lot of interesting leaks in git's options 
handling, and those leaks also tend to be the trickiest ones to fix (as 
my blunder in the original version of this patch demonstrates :) ).

ATB,

   Andrzej

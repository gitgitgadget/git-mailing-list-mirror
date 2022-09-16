Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB39AC54EE9
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 13:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiIPNi4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 09:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiIPNiu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 09:38:50 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18EFACA3E
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 06:38:49 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f14so34682686lfg.5
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=G2uGG2rnwnjRFDJiHTq+EzJa3fjIPWz24mvmLaFTVP4=;
        b=ipVS06UNU0mvsG5sn43f5SbCDB8PGEy99reRCFLwhZwp5tu0X1l8YJcUH8HG3aQnCA
         gTmnYpVd9ar02uSB3z/1JuH06QSvpHiMSB08VKnvGEY73aULLLD9LuS/Hn+IJH/yHL5d
         VzpdwLyEftaeVADXMvSHIiqB1qcRy9hSsjgpmNDSp96NU3ZiqFoYksOKkkLBrfXCx5+5
         dECi276UzSOPJ1/D9VR5XL3EehUpZlGFJvp1BzWtDJesgqM4FRrl7d2W5JyBiyg/CR6W
         7Df7oz6lNn4e60B1kUB00TRCNl2xejArhU/M1tU2HgNUGX0bGHAhf2ZG5SKysU7B6Hp8
         0Qhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=G2uGG2rnwnjRFDJiHTq+EzJa3fjIPWz24mvmLaFTVP4=;
        b=vKMW3teK+IM0p6b0Wv06DZCYk6g/zIi6ZIeftEniCEgxbi7F0LaKMllbdXAJR+Q+ct
         Jgprbi51+TazFnkVNL8eenIlib6cWM4Na7Fg+ebI3eo/lLjrFXnLwhQTaA0/OokspMsD
         hbk+iotl6oiPlyCFIIc4iTgsSiSN4vMvG1wna4pX3zriyvKX3jgT7LUQRLveTk8ZdwMx
         Gxk31aduMeyDzbTothjJ+nOAErn47uO0DPosbs4gn2s2BvxUe9P21MJP6X64+YM5TKSO
         SssKgTZZVud1NvASR+CNuUaGzo2KJf/vqYEW91/X2WNZdGnl2JMP7fNIZ0IElhbZp6sC
         FLUw==
X-Gm-Message-State: ACrzQf2PYrKXFa9cte6aMqzccfHONOVGUbNDxmLAXhmOdINbEQiFYcc1
        cP3epGZalNCCwn0vuLU1kzHLwvF7b2I=
X-Google-Smtp-Source: AMsMyM7gT4xMgRLG1GedirB15gaql+Hk9AR6R7YQF+P1c1anOb5624u3YZYioT5NG5bhgi6tbyHgJw==
X-Received: by 2002:ac2:51b8:0:b0:497:ac71:736a with SMTP id f24-20020ac251b8000000b00497ac71736amr1808406lfk.510.1663335527435;
        Fri, 16 Sep 2022 06:38:47 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 7-20020ac25f07000000b00492e16b7ab3sm3497440lfq.94.2022.09.16.06.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 06:38:46 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] diff-merges: cleanup set_diff_merges()
References: <20220914193102.5275-1-sorganov@gmail.com>
        <20220914193102.5275-3-sorganov@gmail.com>
        <xmqq35csmkuq.fsf@gitster.g>
Date:   Fri, 16 Sep 2022 16:38:45 +0300
In-Reply-To: <xmqq35csmkuq.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        15 Sep 2022 13:41:17 -0700")
Message-ID: <87pmfvjv6i.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Get rid of special-casing of 'suppress' in set_diff_merges(). Instead
>> set 'merges_need_diff' flag correctly in every option handling
>> function.
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  diff-merges.c | 30 +++++++++++++++++++-----------
>>  1 file changed, 19 insertions(+), 11 deletions(-)
>
> Looks OK to me.
>
> Everybody else says set_X() but set_none() has nothing to do ther
> than calling suppress(), so the change does not really make a
> functional difference (as you said in the cover letter).
>
> Is the idea that the original value in .merges_need_diff member does
> not matter because in every case it is set to either 0 or 1?  Most
> cases call common_setup() to set it to 1 like this here...

Yes, exactly.

>
>> +static void common_setup(struct rev_info *revs)
>> +{
>> +	suppress(revs);
>> +	revs->merges_need_diff = 1;
>> +}
>
> ... but this does not touch (in other words, it does not explicitly
> clear) it, ...

>
>> +static void set_none(struct rev_info *revs)
>> +{
>> +	suppress(revs);
>> +}
>
>  ... so we still rely on somebody to set the .merges_need_diff
> to 0 initially, right?

No, the suppress() does clear everything, .merges_need_diff included.
The suppress() ensures every next diff-merges option on the command-line
actually overwrites and correctly sets everything.

>
>> -
>> -	/* NOTE: the merges_need_diff flag is cleared by func() call */
>> -	if (func != suppress)
>> -		revs->merges_need_diff = 1;
>>  }
>
> It is very good to see this one go.

Yep, that was a kludge that bothered me for a while indeed.

>
>>  /*
>> @@ -115,6 +122,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
>>  
>>  	if (!suppress_m_parsing && !strcmp(arg, "-m")) {
>>  		set_to_default(revs);
>> +		revs->merges_need_diff = 0;
>
> I am wondering how this becomes necessary?  Is it because
> set_to_default() would flip the member to 1 unconditionally, or
> something?

Yes, as all "native" -diff-merge= options set this bit to 1.

> If it weren't for this hunk, the lossage of the previous
> hunk is a very good clean-up, but if we need to do this, I cannot
> shake the feeling that we mostly shifted the dirt around, without
> really cleaning it?  I dunno.

Yes, I believe it does cleanup things in both these places.

The "-m" option indeed differs from the rest of the options in exactly
this thing: it wants .merges_need_diff=0 to suppress output unless '-p'
is given as well.

The -c/--cc are in fact similar, but they don't need this line as they
imply '-p' that in turn ignores .merges_need_diff, and generates output
anyway, so -m code has:

  revs->merges_need_diff = 0;

whereas -c and --cc code both have:

  revs->merges_imply_patch = 1;

Thanks,
-- Sergey Organov

>
>> @@ -125,7 +133,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
>>  		set_remerge_diff(revs);
>>  		revs->merges_imply_patch = 1;
>>  	} else if (!strcmp(arg, "--no-diff-merges")) {
>> -		suppress(revs);
>> +		set_none(revs);
>
> We do not need to explicitly set .merges_need_diff to 0 here,
> presumably because it is initialized to 0 and nobody touched it,
> right?

No, we rather do set it to 0 here, in suppress() called from set_none().

Thanks,
-- Sergey Organov

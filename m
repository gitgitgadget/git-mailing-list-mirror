Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F6AC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 11:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbiEXLuw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 07:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbiEXLuu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 07:50:50 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A722A709
        for <git@vger.kernel.org>; Tue, 24 May 2022 04:50:48 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id jx22so21349126ejb.12
        for <git@vger.kernel.org>; Tue, 24 May 2022 04:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=A1+LYb9dGRU2s3dwQqOy0b5NS5Lbyz9CjD3gmc27paQ=;
        b=enufS22gdMB4AEex3W+O+C0omrpMvHHNzw/3TK3e7czPpw5eSe7Hvm+/6B86O9G95i
         UM9r/Xq7sJwlhMa4+oXQdYZz4LywxywV0hC6LS91BnN5pVyQFd+FoEqJuKKGRW1J8YGf
         wsC/9IBS5DK8iYswmDLKcmTGYocUEMHwCzOzZPQkNdLNoIm9BalXVf2/BXPhtEcAhBSN
         95pAMHKPfF6Op2B7YGODZwJRzepaM0sacwhdI6rbqoWw4RnHSR7WSwyiUdeV2/AO8Aq2
         kGKEHUIYGeWXRMzB85kFkLWlgwfV+cXkEzsw74LlqitRG5o8Oh/4KGncUQtrmpUWq7gE
         puuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=A1+LYb9dGRU2s3dwQqOy0b5NS5Lbyz9CjD3gmc27paQ=;
        b=bGJcP1EDKnYqhWk1dwDxKqnDLAJ1bNLOs01pvYnb0whV5WQhLzdSpYn+cS14ebOH/q
         j+SWUe7S6HL4LmATbWF2GoM5QXtP8Xa3eQvmJlb19d9M71kOlrjX6uh1+tTG4b8Ixd8A
         ZQFM2TXGn++sAjg67hhh6tTeIqevyp4iGAQswPYtWUAa+Q+JXWdH4Zl9oJhENuACweBq
         hrnFpg9Fv7q/w+eJ1hZ8pFsR+6dfDQAyjfIZmntDwMuxY+Ko+wpFpmhvS2imXBrTMw5K
         NOogADl3WiMUTeepgXfwWSCE1i5M4QV/YIrzU2gjiMgBPcKaxPwJrT9nE/yYTX8DIglT
         q56A==
X-Gm-Message-State: AOAM530Pn21x6bSwgT//Qgw8zyVPSdSuPEjzSe56taJVOvEF3ymF2z/J
        fZ18xuQsushrvy3Dx7zRB9g=
X-Google-Smtp-Source: ABdhPJzIjLxuxYLjnQJtH2chwrYCpc9rC8lFA4pq1aKJ4x08UBMsZgReiQ2ziHS/0Guzc/XkZ4/4oA==
X-Received: by 2002:a17:907:72c5:b0:6f4:678:8742 with SMTP id du5-20020a17090772c500b006f406788742mr24098460ejc.607.1653393046981;
        Tue, 24 May 2022 04:50:46 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id c6-20020a056402120600b0042aa6a43ccdsm9404675edw.28.2022.05.24.04.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 04:50:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntT3m-003H1r-10;
        Tue, 24 May 2022 13:50:46 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
Subject: Re: [PATCH] diff: fix a segfault in >2 tree -I<regex> and
 --output=<file>
Date:   Tue, 24 May 2022 13:38:16 +0200
References: <a6a14213-bc82-d6fb-43dd-5a423c40a4f8@web.de>
 <patch-1.1-f7fd645468c-20220523T182954Z-avarab@gmail.com>
 <xmqqleusqaff.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqleusqaff.fsf@gitster.g>
Message-ID: <220524.86leurw3my.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 23 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Fix a regression in c45dc9cf30 (diff: plug memory leak from regcomp()
>> on {log,diff} -I, 2021-02-11), as noted in [1] there was a logic error
>> where we'd free the regex too soon.
>>
>> Now we'll ensure that diff_free() can be called repeatedly
>> instead. We'd ultimately like to do away with the "no_free" confusion
>> surrounding it, and to attempt to free() things only once, as outlined
>> in [2]. But in the meantime this will fix the segfault.
>
> Hmph, repeated calls to diff_free_file() now closes the file upon
> the first call.  I would have expected that such a resource would be
> released when all the references go away, i.e. upon the last call.
> The same thing for the ignore-regex array.

Yes, that would be much more sensible. But as noted:

    When producing a combined diff we'll go through combined-diff.c,
    which doesn't handle many of the options that the corresponding
    diff.c codepaths do.

I.e. the "right" thing to do in this case would require a much more
involved fix. We've somehow ended up not supporting --output=3D<file>, -I
and probably many other options in the combined-diff mode, which both in
testing and in this part of the implementation seems to have become an
afterthought.

So before any changes of mine we silently ignore those options, and in
those particular cases the "right" thing to do if we're not growing new
features would probably be to error out early if they were provided in
the combined diff mode.

But as a minimal fix just tailoring diff_free() towards the
not-combined-diff.c case seems to be the smallest & most correct thing
to do for now to address the segfault & the immediate issue.

> Clearing the "options->close_file" bit, and using FREE_AND_NULL(),
> would hide a breakage that could be caused by this change, doesn't
> it, because any use-after-release will say "ah, no need to close the
> file" and "oh, there is no regex".  The former is not so worrisome,
> but the latter may be---we may no longer have regex because the
> first call to diff_free_ignore_regex() has cleared it and the code
> that wants to use the regex, if exists, would happily say "oh, there
> is no regex", instead of exposing the use-after-release breakage to
> a segfault.

Yes, this wouldn't make much sense if we were supporting the file output
and -I in the combined-diff.c case, but AFAICT the two cases are:


 1. The "normal" diff case, where we set those up once, and diff_free()
    them once.

 2. The "combined-diff.c" case, where we might call diff_free() N times,
    but it's all to produce the diff itself, not for those options.


>> Thus we're here testing that -I<regex> is ignored in this case, and
>> likewise for --output=3D<file>, but since this is what we were doing
>> before c45dc9cf30 let's accept it for now.
>
> It is true that the result of applying this patch is equivalent to
> c45dc9cf (diff: plug memory leak from regcomp() on {log,diff} -I,
> 2021-02-11), but doesn't that merely point at the commit as the
> source of behaviour breakage?  With ignore-regex leaking before that
> commit, wouldn't we have been using ignore-regex with combined diff
> machinery?

No, because -I never did anything with the combined diff machinery,
neither did --output.

> Sorry, but I am failing to convince myself that this is not sweep
> the issue under the rug.

I think that's a fair summary, much of it was already under the rug,
we're sweeping some of the remainin parts under it :)

I think that whole combined-diff interaction really needs to be fix, not
just for the diff_free() case, but e.g. we should either error out or
support options that we're silently ignoring now.

But as noted in
https://lore.kernel.org/git/220520.86pmk81a9z.gmgdl@evledraar.gmail.com/
I do have patches queued up locally that form a better basis for fixing
these issues. I.e. once we fix this segfault and have
release_revisions() it'll be easy to get rid of that "no_free" case in
diff_free().

>> [...]
>>  void diff_free(struct diff_options *options)
>> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
>> index 056e922164d..b556d185f53 100755
>> --- a/t/t4013-diff-various.sh
>> +++ b/t/t4013-diff-various.sh
>> @@ -614,4 +614,19 @@ test_expect_success 'diff -I<regex>: detect malform=
ed regex' '
>>  	test_i18ngrep "invalid regex given to -I: " error
>>  '
>>=20=20
>> +test_expect_success 'diff -I<regex>: combined diff does not segfault' '
>> +	revs=3D"HEAD~2 HEAD~ HEAD" &&
>> +	git diff $revs >expect &&
>> +	git diff -I . $revs >actual &&
>> +	test_cmp expect actual
>
> And indeed this casts such a broken behaviour in stone.
>
>> +'
>> +
>> +test_expect_success 'diff --output=3D<file>: combined diff does not seg=
fault' '
>> +	revs=3D"HEAD~2 HEAD~ HEAD" &&
>> +	git diff --output=3Dexpect.file $revs >expect.out &&
>> +	git diff $revs >actual &&
>> +	test_cmp expect.out actual &&
>> +	test_must_be_empty expect.file
>
> So is this one.

I was on the fence about adding these tests, since I expected you to
comment on this aspect of them. I.e. we could just ignore the output
here and narrowly see if we segfault.

But since we had no tests at all for this before, and intentional or not
this behavior of combined-diff is long-standing behavior (that nobody
seems to have noticed or cared about) I think it's good to have tests
that check the "expected" (as in what we did before my c45dc9cf30)
output.

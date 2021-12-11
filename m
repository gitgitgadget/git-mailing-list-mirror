Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4CFC433EF
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 02:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbhLKCcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 21:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbhLKCcU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 21:32:20 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73847C061714
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 18:28:44 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x15so36150285edv.1
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 18:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=OaRWQK37JVoPai+fRzWH7aL26jhdrtfAzVrqb9b05z4=;
        b=j4DIJZrlRWyKoGrrgp6wmKnePNoKZzdoDIYsEDez+8VGENg+7flteQdufmXUw1Gwrq
         8Hwt74aLVsJ3oLBJi3y04OOu48by4mGIVzFbb0GwP7N2oEi/3RBQcPvdOMf4bCis+OSf
         2N3y29De9KgZZnwEJtC3j8XqmnYJB1R/m7icaPIOUlOOvL/T7AdQ2VKYUJ6CSu0PPm0H
         H4I2yP5Z4klOZS9ApcJMUq7q13hV5T6SJ+k/Gq/yJ4/mamf2yZXdkkg9Y+DBkEndbNO5
         uZ+PwOgctbKW9GL6X8Dmif7UPILJ4oknrbHy0g7y6otS4EAbE1PxZO5LJo6OjvkB7FuU
         knzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=OaRWQK37JVoPai+fRzWH7aL26jhdrtfAzVrqb9b05z4=;
        b=B7YqYBtHB4XC/AIoe66iuC94S8NekMw3gcWBJxBZhXVaL+l1qqLd6w7dzxWujO5dFs
         aorM7DDTivWVORijwDpOMNhgTFuzeg1JCWcJDEoYSGZ/IYLpcc0q/N2jZwJSrpQt/BlT
         gIjR10BP/A9qp7j/R4txMV2GevvS7JmjQx59UUUDPgUIEuN5wflHKmWGFBTKwuGc+wQS
         dOw30fUBswQZPjf5WnWtY5AtBauDURz9wuBGxEHeWQkJT9wzeIpQ1t1d/tZ5CwrpHxLA
         QB/bkub2MZaqSqHLRvPPxT4y5ZKNq61ybPdkGETKM9Nn8nos1U9tPTdboFRBnNSE4uHy
         +D6w==
X-Gm-Message-State: AOAM532GuKgdBFFaTk7BIXoQjkixpf3gYT+TqRJAC2Q0cT0xhGz5Ki7I
        /bQ7SViMNPD0kzduT9uOSFS94t89KiGDMg==
X-Google-Smtp-Source: ABdhPJxAay1f69TH+TI1+iET10lyZKdehfG4sOzdQ97hqoKNTQe4w5PwdzkDeXwpOl13FqOEzNmKew==
X-Received: by 2002:aa7:d849:: with SMTP id f9mr45019856eds.261.1639189722669;
        Fri, 10 Dec 2021 18:28:42 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t3sm2284361edr.63.2021.12.10.18.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 18:28:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mvs7t-000R8I-CA;
        Sat, 11 Dec 2021 03:28:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/5] Sparse index: fetch, pull, ls-files
Date:   Sat, 11 Dec 2021 03:24:57 +0100
References: <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>
 <pull.1080.v3.git.1639149192.gitgitgadget@gmail.com>
 <211210.86v8zwbev9.gmgdl@evledraar.gmail.com>
 <CABPp-BHLRUQmjEoO_eEvZWTrVFK_xdMoQH5Q9DAj7y=JrKDzig@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CABPp-BHLRUQmjEoO_eEvZWTrVFK_xdMoQH5Q9DAj7y=JrKDzig@mail.gmail.com>
Message-ID: <211211.86ee6jc1t2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 10 2021, Elijah Newren wrote:

> On Fri, Dec 10, 2021 at 8:31 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> [...]
>> Other than that 2/5 adds this documentation about ls-files --sparse:
>>
>>         If the index is sparse, show the sparse directories without expa=
nding
>>         to the contained files.
>>
>> Shouldn't we at least add:
>>
>>         Sparse directories will be shown with a trailing slash,
>>         e.g. "x/" for a sparse directory "x".q
>
> Makes sense.  Except I don't understand the trailing 'q' -- typo?

Yes, sorry.

>>
>> In addition to that I think this may have a buggy/unexpected interaction
>> with the --eol option:
>>
>>     040000 aaff74984cccd156a469afa7d9ab10e4777beb24 0       i/      w/  =
    attr/                   x/
>>
>> I.e. should we be saying anything about the EOL state of these? OTOHO I
>> tried adding a submodule and it says the same, which seems similarly
>> odd, so maybe it's either correct, or this isn't updated for those
>> either.
>
> If it matches what we do for submodules, for which eol values are also
> non-sensical, then I think we're good enough for this series.  Perhaps
> we just shouldn't print anything eol related for directories with
> --eol, but that sounds like an orthogonal series rather than something
> that should go in this one.

*nod*, probably.=20

>> Is the behavior of:
>>
>>     $ git -C sparse-index ls-files --stage --sparse -- 'folder2/a'
>>     $ echo $?
>>     0
>>
>> Expected? I.e. accepting /a when we'd just print "folder2/" and not
>> e.g. erroring (probably, just asking)?
>
> Fair question.  I think it's fine; by way of comparison:
>
> $ git rm --cached removed-and-no-longer-tracked-file
> $ git ls-files --stage -- non-existent-file
> removed-and-no-longer-tracked-file untracked-file
> $ echo $?
> 0
>
> So it also shows nothing and displays nothing when asked for file(s)
> that are not in the index.
>
> Yes, there is a slight semantic difference in that in your example we
> have a "folder2/" entry which *could be* expanded, but I am quite
> happy with the literal interpretation of the command that there is no
> "folder2/a" in the index.  Said another way, I'm happy with ls-files
> showing what is in the index right now, rather than what could be in
> it, or listing things that HEAD contains that we don't for whatever
> reason.

Sounds good.

>> How about:
>>
>>     $ ls -l sparse-index/x
>>     ls: cannot access 'sparse-index/x': No such file or directory
>>     $ git -C sparse-index ls-files --stage 'x/*'
>>     100644 78981922613b2afb6025042ff6bd878ac1994e85 0       x/a
>>     $ git -C sparse-index ls-files --stage --no-empty-directory 'x/*'
>>     100644 78981922613b2afb6025042ff6bd878ac1994e85 0       x/a
>>     $ git -C sparse-index ls-files --stage --no-empty-directory --sparse=
 'x/*'
>>     040000 aaff74984cccd156a469afa7d9ab10e4777beb24 0       x/
>>
>> The answer is probably "yes that's fine" because I've got no idea how
>> sparse really works, but just checking..
>
> You should read the docs for this option you are trying: "Do not list
> empty directories. Has no effect without --directory."    (Also,
> --directory only takes effect with --other, which you are also
> missing.)
>
> So yeah, that flag is irrelevant.  Perhaps ls-files should print a
> warning when flags are passed but ignored due to other flags not being
> passed, but that would belong in an orthogonal series rather than this
> one.

...

>> So it's very nice to have the new diff test in 2/5, but would be much
>> nicer/assuring to have that split into a trivial function followed by
>> seeing how the diff looked in combination with each of the other option
>> that "ls-files" accepts.
>
> There's no point testing in combination with flags that only affect
> untracked files.  And I'm very dubious of adding testing for a case
> where we would need to add an explicit disclaimer that "We have no
> idea what the output should be but we are testing it anyway".  So the
> options you suggest at least are things I'd rather not see us trying
> to add to the testing here.

This series is adding a new flag to ls-files, it doesn't error out when
combined with other existing flags, and observably changes their output.

I think erroring out would be fine, or doing whatever it's doing now,
but either way the gap in test coverage should be closed, shouldn't it?

I'd think the easiest and probably most prudent fix would just be to say
that we don't think some of these make sense with --sparse and have them
error out if they're combined, no?

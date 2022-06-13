Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83489C43334
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 23:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbiFMX51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 19:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239465AbiFMX50 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 19:57:26 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AE32BD
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 16:57:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gl15so14044525ejb.4
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 16:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=TQQwsxBkj/FzmLFgZb6MzquG88GG8VAwVomcjZ2Vo3c=;
        b=jxodyp0u6+lrTf9tQUIthl4a2RXxGQfnqG6n9R2yjJftRLkLS8meouva3mXVXUhEbH
         IeHMpcH5LVHZPM9PyUmHm6tIOudRygnkkd54HpBzXGdFmIsP29ppkCOSEkjuoVXPwXta
         td0WXIHWAKj5h9yYM3UoeFz1U4kYL3lYu340XR49dd0iFz9iHQ4ui5b5KUGPRX3mz8p6
         t1HVuoPoxFk84Xrrhykq7Gw/nUKsMSBxDJQpOqQNEbJtv+gyovGhARRYtHBaJS49iSkC
         bPdk/9nl+lACVdNyYDp1Hkjwm49gyNd+15LqM4d8W2Zlk6yMsPz1vXUVpyrAf3rRWwB6
         oY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=TQQwsxBkj/FzmLFgZb6MzquG88GG8VAwVomcjZ2Vo3c=;
        b=L7qasGuWdQp+aiu5RLDsqAPRWUb8O9dB2YGMIOb6/6kkGpkRoNA+/G28SbesCbLiGE
         SaQyKrl+KZO8V8GVpWTl0IqqYwANquZuPbnNasXBo7Z5OgyW8sG0srEQitnOCuhvNnPg
         yA/HrUKAx6J/uCSbfEuYQAVBFpRoZ1CbHq5OW76D+yHT1I6bkfn3/n9R06IeCukktaSn
         geQllNjb0wFnbTO+JKtsrss/n7gQm2Vk6LGKpaZb2OyHG1rk7ECfyjWbefQ1mrcfTKty
         1+FAQcS97VS13RuvWQoJCUCN3LgrlYV83M5u5EyKQfMnR596TpNyqzuNGSbbixOWxLlp
         uOog==
X-Gm-Message-State: AOAM532OPg3FyGj3bi1yK2TV24Lr+RJeE1K1NZnnwfYNMlvaohWTzsts
        0x4nSQZZG0ZpbTJ90HRK9GnyMLpYgGB4Dg==
X-Google-Smtp-Source: ABdhPJwUGN/pCrRB3HAXZsXsoE8qCeACdPJIzfBFk5wSj7snUcIxouCNUEwJFaKByaPKqkzWMBBjsQ==
X-Received: by 2002:a17:907:7d8e:b0:711:cf4b:9c5 with SMTP id oz14-20020a1709077d8e00b00711cf4b09c5mr1907441ejc.637.1655164642894;
        Mon, 13 Jun 2022 16:57:22 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id f18-20020a056402355200b004318ba244dcsm5917094edd.10.2022.06.13.16.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 16:57:22 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o0tvt-000Htz-Mf;
        Tue, 14 Jun 2022 01:57:21 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>
Subject: Re: [PATCH v2 00/12] submodule: make "git submodule--helper" behave
 like "git submodule"
Date:   Tue, 14 Jun 2022 01:31:10 +0200
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com>
        <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
        <kl6lwndk5ffc.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <kl6lwndk5ffc.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220614.86pmjcyv4u.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 13 2022, Glen Choo wrote:

> Thanks! I'm happy to see this happen regardless of whose patches we use
> :)

I didn't set out to keep "my side", but just to see if we could come up
with something non-RFC that could be queued/integrated sooner than
later, and removing dead code & the smallish changes to unify the
interfaces for a subsequent conversion seemed like it would be more
palatable.

Thus dropping 1-3/8 of yours, it's the "real" migration (or steps
towards it). Then your 4/8 was tangled up in that migration so I took my
smaller 12/20 over it.

I then took your 5/8, but combined with my 13/20 as discussed in the
CL. I.e. splitting up the external from internal interface change, which
we can do in two steps.

Your 6/8 is then taken over my 14-15/20, 7/8 is another thing I dropped
as the "real" migration to leave for later, and as discussed (see below)
your 8/8 is much smaller than the dead code removal we can do here in
2/12, i.e. we can drop --super-prefix, and a lot of yarn falls out once
we pull on that thread...

Most of the patches I dropped were my own :) I.e. the "actual
conversion" bits, and then I picked up e.g. the
s/absorb-git-dirs/absorbgitdirs/g etc., and other patches in my series
that unified the interfaces.

> Reading the cover letter, I think it probably makes sense for this to
> supersede gc/submodule-update. I haven't really looked at the changes
> yet though, but I will soon.

I hadn't noticed that Junio had picked your RFC patches up (I didn't
check, figuring since it was RFC they wouldn't be...).

Anyway, I'm fine with whatever gets us to the end goal most efficiently.

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> Here's a way of breaking apart the work that makes sense to me:
>>>
>>> - Reuse the patches that prepare git-submodule.sh for the conversion,
>>>   particularly 1-7/20 (create a "case" dispatch statement and its
>>>   preceding patches).
>>> - Keep my series that prepares "update", since that's the most tedious
>>>   one to convert. If I don't dispatch to the "case" statement, I don't
>>>   think it will even conflict with the preparatory series.
>>>
>>>   Some of your patches make more sense than mine, and I'll incorporate
>>>   them as necessary :)
>>> - Dispatch subcommands using the "case" dispatch, including "update". We
>>>   might have to do this slowly if we want things to be easy to eyeball.
>>> - "git rm git-submodule.sh"!
>>
>> Hopefully there's no stepping on toes here, but I thought I'd send
>> this out now (I went back to the laptop) to avoid the duplicate work,
>> since I'd already attempted combining the two, and this is the result.
>
> Fortunately I hadn't resumed work on this yet, so it works out :)

Hope it helped :)

>> [...]
>> This is still in this series as 02/12. I think you've misunderstood
>> that code, it *is* invoking "git submodule--helper" with
>> "--super-prefix", but the option is passed as:
>>
>>     git --super-prefix <path> submodule--helper
>>
>> And not as:
>>
>>     git submodule--helper --super-prefix <path>
>>
>> This is thus handled by other code before builtin/submodule--helper.c,
>> and it doesn't need to handle it.
>>
>> But anyway, this is confusing, so I updated the commit message (seen
>> in the range-diff below)>
>
> Ah that's right, I forgot that we have to pass it to "git" directly.
> Thanks.
>
> I wonder why we ever needed this. 89c8626557 (submodule helper: support
> super prefix, 2016-12-08) doesn't really explain it, so it looks like
> I'll have to dig around the ML.

It was needed, but not after b3c5f5cb048 (submodule: move core
cmd_update() logic to C, 2022-03-15) as my 02/12 discusses.

As a quick test try to check out b3c5f5cb048 and apply this change:

    -#define SUPPORT_SUPER_PREFIX (1<<0)
    +#define SUPPORT_SUPER_PREFIX 0

You'll find that t7406-submodule-update.sh passes, but check out its
parent (which is a commit of yours) and it'll fail, as we'll then emit
output like:

    -Submodule path '../super': checked out 'e1c658656b91df52a4634fbffeaa73=
9807ce3521'
    +Submodule path 'super': checked out 'e1c658656b91df52a4634fbffeaa73980=
7ce3521'

So this is just one of the things that were overly complex in
git-submodule--helper because parts of it had to bridge the gap between
*.sh and *.c land, but once we moved more parts to C we ended up getting
that for free.

>>>>   submodule--helper: have --require-init imply --init
>>>>   submodule--helper: understand --checkout, --merge and --rebase
>>>>     synonyms
>>>>   git-submodule doc: document the -v" option to "update"
>>>>   submodule--helper: understand -v option for "update"
>>>>
>>>> not-so-easy prep for "cmd_update()"
>>>>
>>>>   git-submodule.sh: dispatch "update" to helper
>>>>
>>>> Full cmd_update() migration in one go.
>>>
>>> Yeah, and since it's not-so-easy, it probably makes sense to continue to
>>> keep my series around. I'll borrow some of these patches if that's ok :)
>>
>> The proposal in *this series* is to leave this aside for now, but
>> generally I wonder what part of it you find not-so-easy.
>>
>> Personally I find it much harder to carefully review the way you
>> proposed to do it, i.e. to "buffer up" options that we "don't handle",
>> but actually need to sort-of handle, as we'd still like to die if we
>> have unknown options.
>>
>> Particularly since shellscript quoting etc. is a pain with that sort
>> of thing, as it doesn't have any real list or key-value
>> datastructures.
>>
>> Whereas getting it to the point where we're clearly just passing
>> options as-is through beforehand, and then simply dropping the wrapper
>> is, I think, much easier to review. You only need to trust or check
>> that e.g. "git submodule--helper update" also supports a "--progress"
>> option or whatever, and/or that we've got coverage for it.
>
> Makes sense. I suppose we don't have to overthink the conversion because
> we will have to make the leap of faith to C at some point.

Anyway, that's something we can leave aside for now. I.e. maybe your way
of doing it is better, maybe mine is. That's for later.

For now what do you think about focusing on initial smaller changes to
get the two command-line interfaces as close to 1=3D1 as possible, and to
remove dead code etc.

I.e. to aim for small changes now to make reviewing the eventual *.sh
v.s. *.c code as easy as possible, as the CLI for "submodule" and
"submodule--helper" will behave the same at that point, there won't be
any dead code etc.

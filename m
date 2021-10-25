Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EE1C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 22:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CBEE604DC
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 22:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhJYWje (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 18:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbhJYWje (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 18:39:34 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB6CC061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 15:37:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id y22-20020a1c7d16000000b003231ea3d705so806674wmc.4
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 15:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=R3fLr7vLkfO5bASDJM/5KlpT3KT833UnRmC2B72cFBw=;
        b=JcvDuNV/z/EYYyEVSrzX7jiYgGbYt7Ukd3gXIVVT4+whk5DaQEMK/oayDXxI9oaIcd
         bjjBW1a7oMi4w4Y29Iud/VQkVZoMqKbx5v3c2p7uFNCUk/vdi+X+pNR4hK+/MUBUa59P
         GltTA7XefpGM2B4OXgvvIp4c+3hLzpEBMEu1KdUGH8feMTocduDWDyHs8kbm2CicwrOB
         8j9BcVAlnaqdfqv2wPpRGHxQjZVjS/rxWRLKdzRHWajMY9FECUM9H3loWdptlA8jSouC
         NqUsOnxJUSc5Yzo2qw2OYXbr9R1nUKLyLRw/mGiOtLsR7kfueYWk2uFBG3zHF554PYwN
         0SRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=R3fLr7vLkfO5bASDJM/5KlpT3KT833UnRmC2B72cFBw=;
        b=ubQ4sOWhIfl/zswwOKDVuR9/9/OjPxD//uWHnobNebvKJLlA/ubFUhQONkGvu6Zg5X
         YvcMOty2RyPJRx5MnZILmhBkAY3A5fMpshYZN6OmwKPiFTuV61hdZlpj+h9sxphstD+A
         nC+nDATt64TFUcXwo4RuBrzeflq2e6MntmO+yXh95naZ6DPvH/Q2Ps2yDL91N6H/OkP8
         avKl9x/7j4gw+qir/VGA/zxvKDu1NFBlEDra96d9YXVUkSQMuwtr8wh+Ng7iUJVRjdaL
         boV2sknG+/Lh1ku9z48DYDk6VmkmrTYl5/+7HtoAOEQNqyJFd/7R3PIYZWDNqIFYJsaq
         6yrQ==
X-Gm-Message-State: AOAM530TloBRnX9L7CRUUcLTfNWwMb+A1q+QI0jDNO1Se8vn3hbOM8oM
        qLC0GyK83oZ9EHCgpl3dPRs=
X-Google-Smtp-Source: ABdhPJwDZaabQXWh4KFeYgHYeeAEi6D132BGPMX2IH4tepp1zSP3AJnLVizpTXFC+b27kR091e3pVA==
X-Received: by 2002:a7b:c212:: with SMTP id x18mr23261217wmi.175.1635201429752;
        Mon, 25 Oct 2021 15:37:09 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n11sm7981958wrs.14.2021.10.25.15.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:37:08 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mf8aa-001gxd-3H;
        Tue, 26 Oct 2021 00:37:08 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: changing the experimental 'git switch'
Date:   Tue, 26 Oct 2021 00:23:29 +0200
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2110211150290.56@tvgsbejvaqbjf.bet>
 <211021.86wnm6l1ip.gmgdl@evledraar.gmail.com> <87h7d5yrxy.fsf@osv.gnss.ru>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <87h7d5yrxy.fsf@osv.gnss.ru>
Message-ID: <211026.86sfwo20kr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 25 2021, Sergey Organov wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> [...]
>
>> I really don't know, but I do think that the most viable path to a
>> better UX for git is to consider its UX more holistically.
>>
>> To the extent that our UX is a mess I think it's mainly because we've
>> ended up with an accumulation of behavior that made sense in isolation
>> at the time, but which when combined presents bad or inconsistent UX to
>> the user.
>
> Yep. Moreover, this practice of "making sense" being the primary
> reasoning factor doesn't work very well even in isolation, for single
> Git sub-commands. As there is no defined underlying UI model, or rules,
> or even clear guidelines of how to properly design command-line options,
> multiple authors, all having their own sense and having no common ground
> to base their decisions on, inevitably produce some spaghetti UI.

Yes we're definitely lacking on the documentation front here at least,
but I do think we have quite a bit of consistency in the form of
parse_options() users....

> The UI model to be defined, provided we are serious about aiming at a
> good design, in fact has at least 2 aspects to address:
>
> 1. Uniform top-level syntax of all the Git commands.

have have e.g. hash-object but nothing like hash_object, there's that at
least..., but also mktag, not make-tag, so....

> 2. Uniform rules to handle command-line options.
>
> Being hard to produce simple yet flexible design by itself, the problem
> is further complicated by the need to absorb as much of the existing UI
> as reasonably possible.
>
> Once a model is defined though, we should be able to at least ensure new
> designs fit the model, and then, over time, gradually replace legacy UIs
> that currently don't fit.
>
> As a side-note, from this standpoint, discussing deep details of "git
> switch" options, or even relevancy of introducing of "git switch" in the
> first place, has still no proper ground.
>
> Not even touching (1) for now, let me put some feelers out to see if we
> can even figure how the rules or guidelines for command-line options
> design may look like.

Having hacked quite a bit on parse_options() recently, including quite a
bit of unsubmitted work I've got some opinions in this area :)

That API is as close as we get to uniform UX in this area.

> 1. All options are divided into 2 classes: basic options and convenience
>    options.

Are you thinking of things like "git config --bool" v.s. "git config
--type=3Dbool" (let's ignore that we discourage the former for now), or
more like "common" v.s. "obscure" ?

> 2. Minimalism. Every basic option should tweak exactly one aspect of
>    program behavior.

Generally, although for things like "git log" you quickly end up with
wanting to have pseudo-mode options imply one thing or the other,
sometimes for the better, sometimes wfor worse.

> 3. Orthogonality. Every basic option should not "imply" any other
>    option, nor change the behavior of any other option.

Yeah, generally.

> 4. Reversibility. Every basic option should have a way to set it to any
>    supported value at any moment, including setting it back to its
>    default value.

Yeah, for sure, we're generally quite good at this with parse_options(),
but there's exceptions (particularly with callbacks).

> 5. Grouping for convenience. A convenience option (usually with a short
>    syntax), should be semantically equivalent to an exact sequence of
>    basic options, as if it were substituted at the place of the
>    convenience option, and should not otherwise tweak program behavior.
>    I.e., a convenience option should be simple textual synonym for
>    particular sequence of basic options.

I think some examples for the above in terms of current git commands
would be quite helpful, I'm struggling to think of examples for some of
these.

> Please notice that in the above model basic option having a short form
> is formally considered to be a short convenience option that is a
> synonym for long basic option.
>
> There are obviously some other useful guidelines that could be defined,
> or some alternate approach could be chosen,but the primary point is that
> if we want a consistent UI, we do need some rules, and we need
> convenient implementation of the model agreed upon, and then ensure that
> from all the designs that "make sense", only those that fit into
> underlying model are accepted.

There was a recent discussion about cat-file option parsing semantics at
https://lore.kernel.org/git/87tuhuikhf.fsf@evledraar.gmail.com/

I have this unsubmitted (and updated from that discussion) patch to make
"cat-file" help friendlier:
https://github.com/avar/git/commit/bd32f57cd21

I wonder what you think abut that new output v.s. the old.

More generally, I've wanted to have some mode for parse_options() for a
while now to label a given option X as only going with option. We have
OPT_CMDMODE() for things that are mutually exclusive with all other
options, but not anything like a OPT_SUBCMDMODE() or whatever (and
sometimes such a thing would go with N "top-level modes", not just one).

Right now you need to do that manually, see the usage_msg_opt[f]()
verbosity at:
https://github.com/avar/git/blob/avar/cat-file-usage-and-options-handling/b=
uiltin/cat-file.c#L679-L755

I thing like that would be really useful, and would go a long way
towards consistent UX, as you could generate the sort of "grouped help"
shown in the commit link above with it, as well as have things like:

    git some-command --top-level-option --op<TAB>

Tab-complete only those --op* options that go with that
--top-level-option.

I guess what I'm saying is that I agree with you, but just think that
incremental changes to these UX APIs is the most viable way forward.

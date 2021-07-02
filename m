Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E0FC11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 13:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A70961420
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 13:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhGBNXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 09:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhGBNXk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 09:23:40 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F92C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 06:21:08 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w17so13184434edd.10
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 06:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=qsg3CR6EEbK28stGjaNzEjWoBIK8SSMoG100akqyS1A=;
        b=Sui3S5qq28PoksOpv86ot2UQ6mvBAnSAtqgGrCgEIq5Uqopxkp1X+74Q1BNiUq+ZXv
         sedFfZLKpxb6GXerjTIhcT6kPYi41W6oFKzXbTGGIMTi04Kj3nJeD3XNWn3CsLIZfC4d
         VrpkoCWXrjYHSXLs5SxXGVLWUjepLYmZfjTNvhr60KBHHI7ZElbAmJ9tuUScAlNB2Mr4
         FUgCxkDBnzqvew9kyjKogLtMBSJEUtZa5/NrRL00CrrIWfXgTXor/+RtFbru+OC9TsPa
         /DAPG53ZF90dkW5KwATY6Bfnqrf6QkN78Nq5Ympt8sf8CZlzfBPvSoW6iTPo3Z5yA6me
         Zeqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=qsg3CR6EEbK28stGjaNzEjWoBIK8SSMoG100akqyS1A=;
        b=NA5LEOQXEASOtOED0y5vlttfOGlXTrNcgWzlD1QjWOjHPVtHSiRYIsNtl+wUWEm7hj
         dl2Z5Kq3NOOGHCngerkWauyTwqHdjaxdUb8DuMew8UpTmOyVdrhUrTk8tY0D3TkRU1uR
         t+keBgRIwFjqzD93S7KQsurkAAM0E/yVcQ9WF9FD9t5lhzEKoBVqQonfejVnkWNjST5C
         bvSx7gqE7FrL+WDUGlpPDy3eIcLT4TQa/f75ErzI+0gGlZFxyQxn0t1FxzfK3b9NDgK0
         vA/QHx/1rc9JScph4NCzjUa+EWBj+GxQYUAMjGcUx+ix/jCIlnoK31tVAneegnUD7u9n
         Cx9w==
X-Gm-Message-State: AOAM531fUWTZ7zXsVNso8licOTZj/HSxjll/1festyHKkt6yoc23sy9m
        iUAD9aV8DtUbo/NorypLCis=
X-Google-Smtp-Source: ABdhPJzv94PQp6Iggf2iKiHsJnE45gqfO53gI2TF7ywnFnhCLUlDhM1tQ7aHYd0KtGFY9IsV0Kcm2g==
X-Received: by 2002:aa7:da53:: with SMTP id w19mr6675247eds.267.1625232066976;
        Fri, 02 Jul 2021 06:21:06 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id jz12sm1018953ejc.94.2021.07.02.06.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 06:21:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Structured (ie: json) output for query commands?
Date:   Fri, 02 Jul 2021 15:13:25 +0200
References: <CACPiFC++fG-WL8uvTkiydf3wD8TY6dStVpuLcKA9cX_EnwoHGA@mail.gmail.com>
 <CACPiFCLzsiUjx-vm-dcd=0E8HezMWkErPyS==OQ7OhaXqR6CUA@mail.gmail.com>
 <YNyxD4qAHmbluNRe@coredump.intra.peff.net>
 <YNzR5ZZDTfcN2Q+s@camp.crustytoothpaste.net>
 <YN3mk0LnyJyuQ+9T@coredump.intra.peff.net>
 <YN4xCRDi3JwMc+S0@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YN4xCRDi3JwMc+S0@camp.crustytoothpaste.net>
Message-ID: <87lf6oam2m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2021-07-01 at 16:00:19, Jeff King wrote:
>> On Wed, Jun 30, 2021 at 08:19:49PM +0000, brian m. carlson wrote:
>> 
>> > On 2021-06-30 at 17:59:43, Jeff King wrote:
>> > > One complication we faced is that a lot of Git's data is bag-of-bytes,
>> > > not utf8. And json technically requires utf8. I don't remember if we
>> > > simply fudged that and output possibly non-utf8 sequences, or if we
>> > > actually encode them.
>> > 
>> > I think we just emit invalid UTF-8 in that case, which is a problem.
>> > That's why Git is not well suited to JSON output and why it isn't a good
>> > choice for structured data here.  I'd like us not to do more JSON in our
>> > codebase, since it's practically impossible for users to depend on our
>> > output if we do that due to encoding issues[0].
>> > 
>> > We could emit data in a different format, such as YAML, which does have
>> > encoding for arbitrary byte sequences.  However, in YAML, binary data is
>> > always base64 encoded, which is less readable, although still
>> > interchangeable.  CBOR is also a possibility, although it's not human
>> > readable at all.
>> 
>> I don't love the invalid-utf8-in-json thing in general. But I think it
>> may be the least-bad solution. I seem to recall that YAML has its own
>> complexities, and losing human-readability (even to base64) is a pretty
>> big downside. And the tooling for working with json seems more common
>> and mature (certainly over something like CBOR, but I think even YAML
>> doesn't have anything nearly as nice as jq).
>
> I'm not opposed to JSON as long as we don't write landmines.  We could
> URI-encode anything that contains a bag-of-bytes, which lets people have
> the niceties of JSON without the breakage when people don't write valid
> UTF-8.  Most things will still be human-readable.
>
> We could even have --json be an alias for --json=encoded (URI-encoding)
> and also have --json=strict for the situation where you assert
> everything is valid UTF-8 and explicitly said you wanted us to die() if
> we saw non-UTF-8.  I don't want us to say that something is JSON and
> then emit junk, since that's a bad user experience.
>
> Ideally, we'd have some generic serializer support for this case, so if
> people _do_ want to add YAML or CBOR output, it can be stuffed in.

I'd think the ideal end-state is for us to have some standardized way to
pass structs of structured data around at the C-level.

Then everything that now supports a format such as git-log,
for-each-ref, cat-file --batch etc. could share the same formatting
logic. Our human-readable output would just be a special-case of
providing a default format, as it is in the case of some of these
commands.

If we had a bit of an extension of the %(if) etc. syntax that
for-each-ref uses to handle such nested structures we could emit
arbitrary structured data, e.g. the formatting language would be
sufficient to start a nested structure, only emit commas between
elements etc.

You could then emit JSON, XML or whatever you'd like with a "simple"
(well, it would be quite verbose) format specification. We could then
ship some default formats.

A related (but not quite the same) benefit would be to make the logic
driving the built-ins reeantrant, so a formatting feature like this
could be combined with a "--batch" mode supported by every (or most)
commands. So you could also e.g. run "log --batch" not just "cat-file
--batch" if you needed some of the formatting it provides.

This would be immensely useful to editor implementations and things
invoking git on the server, where we often need to pay the startup cost
for invoking N number of commands that are built into the "git" binary
anyway. So if they could be sent as a --batch ...

>> Our sloppy json encoding does work correctly if you use utf8 paths, and
>> I think we could provide options to cover other common cases (e.g., a
>> single option for "assume my paths are latin1"). I think life is hardest
>> on somebody writing a script/service which is meant to process arbitrary
>> repositories (and isn't in control of the strictness of whatever is
>> parsing the json).
>
> I think I'd rather provide a general encoding functionality than try to
> handle random encodings.  I _do_ want people to be able to do things
> like store arbitrary bytes in paths, because many people do use that
> functionality for shipping test files that verify their code works
> correctly on Unix systems.  I also want us to handle arbitrary bytes
> where we've stated that's a thing we support (e.g., in refs).  I _don't_
> want to encourage people to use non-UTF-8 text encodings, because I
> firmly believe those are obsolete.
>
> So, correct binary data support, yes; non-UTF-8 text, no.

I don't know how widely they're used with gits, but there's several
non-Unicode encodings in wide use, and e.g. non-UTF-8 but Unicode
encodings like UTF-16 in some contexts/platforms:

https://stackoverflow.com/questions/1200063/why-does-anyone-use-an-encoding-other-than-utf-8/2470079

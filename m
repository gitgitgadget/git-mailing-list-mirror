Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B05C433E0
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 19:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7CAE22AAA
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 19:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbhAJTZS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 14:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbhAJTZS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 14:25:18 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9542EC061786
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 11:24:37 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id q22so21791741eja.2
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 11:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=xqjrV1Zm+7p3c76YR58CA92MQwzC1xvqX0NrznuiBqw=;
        b=jIq82WyRI1eP79dSogVlYq9lYhL2ndMK0sZ+Cn2ucx02JgNZu8aMcMvqAP7fmbAgMN
         0XhBys4PA6z/SC7z8NkXLWXgZ/B3KwWVEo3NdAxLKjnf4gPap4BO52gv8pZicsPK5qaF
         l2xO6QyP6yo7XqXcX6wB9u2uT5Rxa2UIGkEEg5LEjWfuBKtd8ToBY3L138P3fMKiS6h6
         oXNlfd4rWKUUkDh/38VTAjQtpPpaxLesWPg78fbhL5MhhA4Q+iCqlx1M0wLuvTiy5X58
         vNUERIiXVEr8Hp/lZMZ9RU3AvU7LS33eYrcDt3Gj3ci3AcoG+8h6SheFFDvUc9oHfXXr
         NlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=xqjrV1Zm+7p3c76YR58CA92MQwzC1xvqX0NrznuiBqw=;
        b=igi04/vLosv8IxO7WxifbCVY+Kum551Dde2EDcvfNE6KsUtSLX3mmOqE4B5T8lBCWT
         2qZUC9veEzLYjKsEjA+syjv173m+5YefMNyD4plDnKh7vOaLwjdrAV/c3H8B2k+FEc8g
         dqwpeCRijHgyuUFp9PRcRUF8CtjVe1A1QlB/UYjCbStwSZbv6bLP2hKPiHBC7XO38sQd
         1WMqmt3tZcfU/oUrA/Ix5/zcXANH3shlchoyVrPk9Oz29XjTtQIK10pkueKpGm1IzG2e
         U1QbFt55kCrsxqx/SSN38d2nQFQKXBDrG5G4F2NiZbCBIesuoDPZo/kyt5Ml4izWpBIE
         +dqA==
X-Gm-Message-State: AOAM530KlsWiAX1m0oxR/kyKc1lkMkIsA3qD9mjfypAt8CIrBgESYOAr
        Ia1gVzHgO4FtNyiY+qkZYITO3pkYhI4=
X-Google-Smtp-Source: ABdhPJwWmbzCtUA8ATzfHeqAh95ml4ed3HeHdBEq+bjs34jCmvMFGp9xAZKTkRMW2r7jZp4yDIHsGg==
X-Received: by 2002:a17:906:f9d7:: with SMTP id lj23mr8943738ejb.266.1610306676253;
        Sun, 10 Jan 2021 11:24:36 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id d6sm6045542ejy.114.2021.01.10.11.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 11:24:35 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 5/5] mailmap: support hashed entries in mailmaps
References: <20210103211849.2691287-1-sandals@crustytoothpaste.net>
        <20210103211849.2691287-6-sandals@crustytoothpaste.net>
        <875z4bsbuz.fsf@evledraar.gmail.com>
        <X/UDT/oLKNQmxBXR@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <X/UDT/oLKNQmxBXR@camp.crustytoothpaste.net>
Date:   Sun, 10 Jan 2021 20:24:34 +0100
Message-ID: <87sg7861e5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 06 2021, brian m. carlson wrote:

> On 2021-01-05 at 14:21:40, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Sun, Jan 03 2021, brian m. carlson wrote:
>>=20
>> I think it makes sense to split up 1-4/5 here from 5/5 in this series
>> since they're really unrelated changes, although due to the changes in
>> 1-4 they'll conflict.
>
> Okay, I'll drop them.

Not replying to most of this E-Mail because I think there's nothing left
to add / you clarified things for me in those cases / we respectfully
disagree / any outstanding points we can pick up in your re-roll /
whatever :)

>> So we're talking about hiding the old E-Mail, presumably because it was
>> joe@ intsead of jane@, so in that case we could just support URI
>> encoding:
>>=20
>>     Jane Doe <jane@example.com>
>>     <jane@example.com> <%6A%6F%65@%64%65%76%65%6C%6F%70%65%72.%63%6F%6D>
>>=20
>> Made via:
>>=20
>>     $ perl -MURI::Escape=3Duri_escape -wE 'say uri_escape q[joe@develope=
r.com], "^@."'
>>     %6A%6F%65@%64%65%76%65%6C%6F%70%65%72.%63%6F%6D
>>=20
>> Which also has the nice attribute that people can make it obvious what
>> part they want to hide, since this is really a feature to enable social
>> politeness & consideration:
>>=20
>>     Jane Doe <jane@example.com>
>>     # I don't want to be known by my old name, thanks
>>     <jane@example.com> <%6A%6F%65@developer.com>
>
> I don't think this feature is going to get used if we just encode names
> or email addresses.  In the United States, when someone transitions,
> they get a court order to change their name.  I don't think a lot of
> corporate environments are going to want to just encode an old name or
> email address in a trivially invertible way given that.  This is
> typically a topic handled with some sensitivity in most companies.
>
> I will tell you that I would not just use an encoded version if I were
> changing my name for any of the reasons I've mentioned.  That wouldn't
> cut it for me, and I wouldn't use such a feature.  The feature I'm
> implementing is a feature I've talked with trans folks about, and that's
> why I'm implementing this as it is.  The response I got was essentially,
> "It's not everything I want, but it's an improvement."
>
> If the decision is that we want to go with encoding instead of hashing,
> then I'll drop this patch.  I'm not going to put my name or sign-off on
> that because I don't think it meets the need I'm addressing here.
>
> The entire problem, of course, is that we bake a human's personal name
> and email address immutably into a Merkle tree.  We know full well that
> people do change their names and email addresses all the time (e.g.,
> marriage, job changes), and yet we have this design.  In retrospect, we
> should have done something different, but hindsight is 20/20 and I'm
> just trying to do the best we can with what we've got.

Doesn't the difference in some sense boil down to either an implicit
promise or an implicit assumption that the hashed version is forever
going to be protected by some security-through-obscurity/inconvenience
when it comes to git.git & its default tooling?

And would those users be as comfortable with the difference between
encoded v.s. hashed if e.g. "git check-mailmap" learned to read the
.mailmap and search-replace all the hashed versions with their
materialized values, or if popular tools like Emacs learned to via a Git
.mailmap in a "need translation" similar to *.gpg and *.gz. How about if
popular web views of Git served up that materialized "check-mailmap"
output by default?

None of which I think is implausible that we'll get as follow-up
patches, I might even submit some at some point, not out of some spite.
Just because I don't want to maintain out-of-tree code for an
out-of-tree program that understands a Git .mailmap today, but where I'd
need to search-replace the hashed versions.

Ditto it being very likely that popular editors or web viewers will gain
support for this, just because it's tedious to manually hash &
copy/paste & validate values.

In looking at some of the fsck code recently & having some
yet-unsubmitted patches I thought of trying to compine it with
mailmap. I.e. it seems like a natural feature for fsck to gain to warn
you about unused mailmap entries, just like it can warn about
unreachable/dangling objects. After all these are really just sort-of
pointers into our Merkle tree. Spewing out all the mappings seems like
an obvious addition to that, e.g. in spewing out an
"optimized/non-redundant" (plain or hashed) mailmap to re-commit.

That's the main reason I'm uncomfortable with this approach, because it
seems to me to implicitly rely on things that are tedious now, but which
the march of history all but inevitably should make trivial if we were
to integrate it. Unless we're *also* promising to forever intentionally
(and artificially) keep it inconvenient.

E.g. the example of how long it takes to clone & extract this info from
chromium.git in the v1 thread.

It seems like a fair assumption that we'll have some future version of
git where you can ask a remote server about that sort of thing in
milliseconds.

Not because of this hashed .mailmap thing in particular, just as an
emergent effect that it's happy to serve up things it knows about the
DAG from having walked & cached it in general. E.g. info from the
commit-graph, what hash is contained in what ref, or how one value (such
as a .mailmap entry) maps to another etc.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AE2C433ED
	for <git@archiver.kernel.org>; Fri, 21 May 2021 07:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83C96135C
	for <git@archiver.kernel.org>; Fri, 21 May 2021 07:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbhEUHB5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 03:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbhEUHBw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 03:01:52 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC12C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 00:00:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l4so28897380ejc.10
        for <git@vger.kernel.org>; Fri, 21 May 2021 00:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Gax16FRtYI5A0uGZyBqNAVPPV6brwy0sePOVl/EKTB4=;
        b=IHIl+Jb6ck+SiGI5HF/6n8ulY9qYG27AaeJhmMWytbVO7zB3sG2jGySky00ZoatrEX
         9R/p6f40Hqm0+kcFNtEpB5bDziFh727eIFXoUsfChH5/riVnx9c9xacFCAoMqQbbGkID
         cEfSQ0dXNkI7AxkC9eNsZXjoHGjRSFClBoqEzIkgD7AHeuO+OHqtNmWERA0InrJc4OXi
         S63vFLsNW3IybjlSj/kti2T1Px9oAlshwtiwWt9q0fJOOljXgNrOZigoF5fUcGcZatdy
         ry6uNt+60b33JsjFMyHuDnEAHZpIrFnJxtYjg6bJQt8WhcmYYU+sK5NFV9Hsx5Po6Nsw
         Vmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Gax16FRtYI5A0uGZyBqNAVPPV6brwy0sePOVl/EKTB4=;
        b=J3iSTXNAsjgpBOd9P2/7n013uMsXZkvyu/8vzAmllfJVbCCSrHWhChu1YQ2D6EOsp2
         YiMpWkK/aTS4rYS2il+Z9wnZnvP5oPRzwWTHhB71v1NQubJVBMSJ/d98HHsV0KKXM3My
         FiTBuaH//U8MUX3E6nVicJeKVSfjjfqL1YgfapOzOG0bDvlGIJX8R4KLIt5NL0GSJSkZ
         qYwFaAIA6IJ9TYPn6ZTrc9JxnunBEcAsQSwmd8wsveZ59mPsrrlQ0RHb+CQjG3pUsCTq
         zd0t9sEkTH+f7NnUL9aBHp2tPG1skzlemxphb/AZxl45ljRBCG3Wt8mKJzte8gotAUde
         eY3A==
X-Gm-Message-State: AOAM531lYiQX3Ab5QAa/aZsiEBO78d4igQ96BKfoTwWUd+0Ip98P4eLr
        MDHB6zwXgWLhi5XXfh/tXL4=
X-Google-Smtp-Source: ABdhPJxlvouu06V6Tm1TS/0Rbzsv9gunGOWBZsolbk8EtJwYaVtCFGaVggaXrAmlHli7Xbx3GWIzWA==
X-Received: by 2002:a17:906:a51:: with SMTP id x17mr8892025ejf.25.1621580427039;
        Fri, 21 May 2021 00:00:27 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id h9sm3205162edr.10.2021.05.21.00.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 00:00:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 00/10] send-email: various optimizations to speed up
 by >2x
Date:   Fri, 21 May 2021 08:23:15 +0200
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
 <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
 <YKYdeom6SgAHqojm@coredump.intra.peff.net> <xmqqv97drmge.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqv97drmge.fsf@gitster.g>
Message-ID: <875yzcpo52.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 21 2021, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> I like all of this, except for the change in the interface of
>> Git::config_regexp(). You mention that it's new-ish, and probably not in
>> wide use. And I agree that's probably true. But it feels like violating
>> a principle of not breaking APIs, and we should stick to that principle
>> and not bend it for "well, it's not that old an API".
>>
>> I'd find it more compelling if it the existing interface was broken or
>> hard to avoid changing. But couldn't we just add a new function with the
>> extra info (config_regexp_with_values() or something)?
>
> We seem to use it in-tree only once, but we have no control over
> what out-of-tree users have been doing.

I thought people might have bought my argument in v1 that we just
document these as "public" as part of some copy/pasting in Git.pm, but
sure, I'll re-roll and make this a new function or something...

> I do like your proposed name for the fact that it has _with_values
> in it; the original gave us only a list of configuration variable
> names, and now we are getting name-value tuples.
>
> BUT
>
> I am not sure if I like the new interface, and I do not know if the
> the name "config_with_values" is a good match for what it does.
>
> Namely, when a function is described as:
>
>     =3Ditem config_regexp ( RE )
>
>     Retrieve the list of configuration key names matching the regular
>     expression C<RE>. The return value is an ARRAY of key-value pairs.
>
> I would expect it to return ([key1, value1], [key2, value2], ...),
> but the implementation returns (key1, value1, key2, value2, ...),
> i.e. a flattened list, if I am not mistaken.


...

>     my @cmd =3D ('config', '--null', '--get-regexp', $regex);
>     unshift @cmd, $self if $self;
>     my $data =3D command(@cmd);
>     my (@kv) =3D map { split /\n/, $_, 2 } split /\0/, $data;
>     return @kv;
>
> We get NUL terminated records, so we first split the entire output
> at NULs (to get a list of key-value records).  Each key-value record
> has the key followed by LF followed by value, so we split it at the
> first LF (i.e. a value with an embedded LF would behave correctly)
> to extract key and value out of it.  But the resulting list is a
> flat list with alternating key and value.
>
> The side that works on the returned value of courese knows that it
> is getting a flattened list and acts accordingly:
>
>     my @kv =3D Git::config_regexp("^sende?mail[.]");
>     while (my ($k, $v) =3D splice @kv, 0, 2) {
>         push @{$known_config_keys{$k}} =3D> $v;
>     }
>
> Perhaps it may be more performant than a more obvious and
> straight-forward "list of tuples", i.e.
>
>     return map { [split /\n/, $_, 2] } split /\0/, $data;
>
>     my @kv =3D Git::config_regexp("^sende?mail[.]");
>     for my $tuple (@kv) {
>         push @{$known_config_keys{$tuple->[0]}}, $tuple->[1];
>     }
>
> but somehow the flattened list felt unnatural at least to a na=C3=AFve
> reader like me.

The "performant" really doesn't matter here, we're comparing shelling
out to getting a small number of config keys back. So I wasn't trying to
optimize this.

Returning a flattened list is idiomatic in Perl, it means that a caller
can do any of:

    # I only care about the last value for a key, or only about
    # existence checks
    my %hash =3D func();

Or:

    # I want all key-values to iterate over
    my @kv =3D func();

Returning touples like this makes that less convenient for both, who'll
need to do more work to unpack them.

For what it's worth In Perl "return a list" means "flattened list", the
term "flattened list" I think comes from other languages. You'd call
what you're suggesting a list of arrays, or (if a top-level reference)
an array of arrays, AoA for short, AoH for array (ref) of hashes etc.

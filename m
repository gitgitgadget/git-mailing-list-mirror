Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40291C4708F
	for <git@archiver.kernel.org>; Sat, 29 May 2021 08:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D23F613F1
	for <git@archiver.kernel.org>; Sat, 29 May 2021 08:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhE2Iei (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 04:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhE2Ief (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 04:34:35 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6C9C061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 01:32:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ci15so5421079ejc.10
        for <git@vger.kernel.org>; Sat, 29 May 2021 01:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=nR8SnPMxi2/vIw5AZqPjiBRe0kOhIW9Bkjg38jifkEw=;
        b=isyGRIzbSMZebfrZG92H8C2zWhnMj7iV02umvXKpUIYR+IxzdWAo9iqyeYqiUYrZIX
         6x2lTzotdKadmyKP3EX7C9l6DgtfxBlMsCAgn3S8v15KkcTE44GMfqP47vEiiV0ryDzV
         eABixtoXhz9i4Vwc3I4VQxMAyZzReY+TrZYtqXEertGXF8p6IpswfbiznGJtfvz2oZgv
         V+4n3DUamxh4iBL1J8y0WGGlrsKyTBMSU30MS3DBq0zk5Cgi6ztSOqGhhzArzqMTQN4h
         RVOz4N127/QmQaydMkIGi4Cnlk9FXCxecsdJMLO9YzAfhyoXNhj7hNxd/ABMqjh5d9kU
         BedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=nR8SnPMxi2/vIw5AZqPjiBRe0kOhIW9Bkjg38jifkEw=;
        b=RJOfyyLGJqgE6IAEFmsTBtMPeas1nwMMhQgPXhFiOmbL+HJ4pEudoyGr5bgz/yH05X
         DISJ1b9ABODpUjBgGodBGVyDp8maeFr9CVfFX2X9RJmfCTdlp2ifzPqdXGFSrjL2qwRv
         GefdNwcxJQWuEaRcG33vHrU+0+U354znYPUtum7DYrpqKAV/8vt45DAuaDEx+PmyGaMx
         3JBlR/DMnO+eehexTnQLTSyjIkE4OgBGYiu6Ol/UXUn25NlCgUMgd5DehfvXPgv991nq
         0zfYCRjxxIVyU4DC2gP+iXDqqjJnUOiX6PWj+IRa74PDDBhP4Veat8F+bl4ySli26NEf
         f7pw==
X-Gm-Message-State: AOAM5337zuIS7EgKeA0R5b3fSB92Jh3eo650eGeB1DePuOmwfw5j4RQq
        4H3KOgeFBQHUoosfj/oNvu0=
X-Google-Smtp-Source: ABdhPJx5JMcYbvb4A1EdTqClJyyjfTP0psmlVI80VZ+8ncCJTRh/yzeXbLUs8/ip+y8aZR9619keXQ==
X-Received: by 2002:a17:906:3615:: with SMTP id q21mr13377529ejb.414.1622277177180;
        Sat, 29 May 2021 01:32:57 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id f10sm208519edx.60.2021.05.29.01.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 01:32:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 00/10] send-email: various optimizations to speed up
 by >2x
Date:   Sat, 29 May 2021 10:19:07 +0200
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
 <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
 <YKYdeom6SgAHqojm@coredump.intra.peff.net> <xmqqv97drmge.fsf@gitster.g>
 <875yzcpo52.fsf@evledraar.gmail.com>
 <60b11101e5288_50514208b4@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <60b11101e5288_50514208b4@natae.notmuch>
Message-ID: <87czta2b47.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 28 2021, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Returning a flattened list is idiomatic in Perl, it means that a caller
>> can do any of:
>>=20
>>     # I only care about the last value for a key, or only about
>>     # existence checks
>>     my %hash =3D func();
>
> I was staying on the sideline because I don't know what's idiomatic in
> Perl, but Perl and Ruby share a lot in common (one could say Perl is the
> grandfather of Ruby), and I do know very well what's idiomatic in Ruby.
>
> In perl you can do $ENV{'USER'}, and:
>
>   while (my ($k, $v) =3D each %ENV) {
>     print "$k =3D $v\n";
>   }
>
> Obviously it's idiomatic to use hashes this way [1].

For what it's worth idiomatic/good idea and "has an example in the perl
documentation" unfortunately aren't always aligned. A lot of experienced
Perl programmers avoid each() like the plague:
http://blogs.perl.org/users/rurban/2014/04/do-not-use-each.html

> It was a waste for Git::config_regexp to not do the sensible thing here.

FWIW we're commenting on a v2 of a series that's at v5 now, and doesn't
use config_regexp() at all, the relevant code is inlined in
git-send-email.perl now.

> You can do exactly the same in Ruby: ENV['USER']
>
>   ENV.each { |k, v| print "#{k} =3D #{v}\n" }
>
> And the way I would parse these configurations in Ruby is something like:

>   c =3D `git config -l -z`.split("\0").map { |e| e.split("\n") }.to_h
>   c['sendemail.smtpserver']
>
> And this just gave me an idea...

I'd probably do it that way in Ruby, but not in Perl.

Things that superficially look the same in two languages can have
completely different behaviors, a "hash" isn't a single type of data
structure in these programming languages.

In particular Ruby doesn't have hshes in the Perl sense of the word, it
has an ordered key-value pair structure (IIRC under the hood they're
hashes + a double linked list).

Thus you can use it for things like parsing a key=3D>value text file where
the key is unique and the order is important.

In Perl hashes are only meant for key-value lookup, they are not
ordered, and are actually actively randomly ordered for security
reasons. In any modern version inserting a new key will have an avalance
effect of completely changing the order. It's not even stable across
invocations:
=20=20=20=20
    $ perl -wE 'my %h; for ("a".."z") { $h{$_} =3D $_; say keys %h }'
    a
    ab
    bca
    dcba
    daebc
    cbaedf
    aecbfdg
    dgfcbaeh
    [...]

The other important distinction (but I'm not so sure about Ruby here) is
that Perl doesn't have any way to pass a hash or any other structure to
another function, everything is flattened and pushed onto the stack.

To pass a "hash" you're not passing the hash, but a "flattened" pointer
to it on the stack.

Thus passing and making use of these flattened values is idiomatic in
Perl in a way that doesn't exist in a lot of other languages. In some
other languages a function has to choose whether it's returning an array
or a hash, in Perl you can just push the "flattened" items that make up
the array on the stack, and have the caller decide if they're pushing
those stack items into an array, or to a hash if they expect it to be
meaningful as key-value pairs.

In the context of Git's config format doing that is the perfect fit for
config values, our config values *are* ordered, but they are also
sort-of hashes, but whether it's "all values" or "last value wins" (or
anything else, that's just the common ones) depends on the key/user.

So by having a list of key-value pairs on the stack you can choose to
put it into an array if you don't want to lose information, or put it
into a hash if all you care about is "last key wins", or "I'm going to
check for key existence".

I think that in many other languages that wouldn't make any sense, and
you'd always return a structure like:

    [
         key =3D> [zero or more values],
        [...]
    ]

Or whatever, the caller can also unambiguously interpret those, but
unlike Perl you'd need to write something to explicitly iterate the
returned value (or a helper) to get it into a hash or a "flattened"
array. In Perl it's trivial due to the "everything is on the stack"
semantics.

Anyway, all that being said the part we're talking about as a trivial
part of this larger series. I'd much prefer to have it just land as
"good enough" at this point. It works, we can always tweak it further
later if there's a need to do that.

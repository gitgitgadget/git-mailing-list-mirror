Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6BCC56202
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 12:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 582D221D1A
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 12:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQgdweUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389693AbgKZMqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 07:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388478AbgKZMqs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 07:46:48 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E47C0613D4
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 04:46:47 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id o9so2792225ejg.1
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 04:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=7iHE3diDp3FaqM9cmuAuFRfXYNKlcYpMhGWIw5G3PO8=;
        b=sQgdweUHn4P8W2vfNAmSjvQjY/BTnL8VoxUHkNFI8btoQVSxyHFMaW8ZXcx/CQ4hwr
         kG/6X1wwfXiWBu6Y6C+4o70q9tpj5rJubXFXshXd2TVO/HlqHUtW+qcicoIzSSgzuHuq
         bWd0Qmt/wb4hUAKylQafj481U1yyWkbm912FcZZQ9rERFUOeRGyN8fjo0j87WYnojBRd
         Do07k7A1CSe7tjpRXwcUvUVv1EYffjWaNvHmvcnjFNsTRPtlyk6HDX01O/WuBPE07qR3
         aKMzvDYLHWSbgc69Q/GZv1WIG/7TAWPf8mhTgRhtqJ0tSG0HwGZlHiKy3pOOymQKwOed
         rl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=7iHE3diDp3FaqM9cmuAuFRfXYNKlcYpMhGWIw5G3PO8=;
        b=jQGN3eqWuWiJgHU7QId5t65ReyzG/y53XtjKekHg+uTAyJp0Q/waHG2tYz9Eyq36Du
         6NwL2+1OasFAdK6ky2f9neFQY7eh4aRQVJe/s2Ua9b5rjhXxVlGOOHb9cXDr4JnY4WZ2
         hn7TBP0TtxjZBULqXHnhjkhnIRLDwayY5aZg6K8h5+KmBqAEiF0nygvefZAPLJLMyyko
         zW1DNm4Z+IC5k+/aXPmTDDOOuZq2Wxg/voT0btkyU3p5emLX08us547JtePchhj/uk2Q
         xIgGJrKnN63t2jGAdkhDz2Jioe321MKjqj+q2Gx6u2X30P55BPTis8srC8PIXI4I2Xsj
         1mzA==
X-Gm-Message-State: AOAM531I/PuglxH6d9VHU5GJE7H8RTKIPxbNa1L28sxz9r8lhCaBlffR
        wsuvNR0SVfszineWBPptC9g=
X-Google-Smtp-Source: ABdhPJylnhY6mcG1rowG4lriGZFbOBUs7IjoXeQKJf7dwXpKJuPPA1spuZvJQk/lTZbargoZNAvpBg==
X-Received: by 2002:a17:906:d8c9:: with SMTP id re9mr2556884ejb.266.1606394806301;
        Thu, 26 Nov 2020 04:46:46 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id w15sm867658ejb.49.2020.11.26.04.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 04:46:45 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH 08/12] mktag: use fsck instead of custom verify_tag()
References: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net> <20201126012854.399-9-avarab@gmail.com> <X79kgLjz4U9ubIKB@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <X79kgLjz4U9ubIKB@coredump.intra.peff.net>
Date:   Thu, 26 Nov 2020 13:46:44 +0100
Message-ID: <87r1ognv4b.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 26 2020, Jeff King wrote:

> On Thu, Nov 26, 2020 at 02:28:50AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> There was other "mktag" validation logic that I think makes sense to
>> just remove. Namely:
>>=20
>>  A. fsck only cares that the timezone matches [-+][0-9]{4}. The mktag
>>     code disallowed values larger than 1400.
>>=20
>>     Yes there's currently no timezone with a greater offset[2], but
>>     since we allow any number of non-offical timezones (e.g. +1234)
>>     passing this through seems fine. Git also won't break in the
>>     future if e.g. French Polynesia decides it needs to outdo the Line
>>     Islands when it comes to timezone extravagance.
>
> Yeah, I think this is a good choice to loosen.
>
>>  B. fsck allows missing author names such as "tagger <email>", mktag
>>     wouldn't, but would allow e.g. "tagger <email>" (but not "tagger
>>     <email>"). Now we allow all of these.
>
> Likewise, though I am confused. Should the second "tagger <email>" in
> that paragraph have something else in it?

There should be 1-2 and 3 spaces there, don't know why that didn't make
it. Will fix.

>>  C. Like B, but "mktag" disallowed spaces in the <email> part, fsck
>>     allows it.
>
> Possibly something we'd want to tighten in fsck, but I think keeping
> them in alignment is a good idea for now.
>
>> We didn't only lose obscure validation logic, we also gained some:
>>=20
>>  D. fsck disallows zero-padded dates, but mktag didn't care. So
>>     e.g. the timestamp "0000000000 +0000" produces an error now. A
>>     test in "t1006-cat-file.sh" relied on this, it's been changed to
>>     use "hash-object" (without fsck) instead.
>
> Seems reasonable.
>
>> +	/* verify_tag() will be removed in the next commit */
>> +	verify_tag("", 0);
>> +
>> +	/*
>> +	 * Fake up an object for fsck_object()
>> +	 */
>> +	obj.parsed =3D 1;
>> +	obj.type =3D OBJ_TAG;
>
> I don't love this "fake object struct on the stack" thing. I can't think
> of anything that would break outright, but it may be the only place
> where that struct isn't coming from the usual pool, and representing the
> common part of a larger object. Two definite gotchas, though:
>
>   - if the type is OBJ_TAG, then it may get cast to a "struct tag" by
>     other code, which could look past the end of the struct. I think
>     that fsck_object() doesn't do this, but it could (and it definitely
>     used to)
>
>   - you don't initialize the other fields. We'll definitely pass
>     &obj->oid in the fsck code, and even back to our report() callback,
>     even though it's full of garbage. In practice this is OK because our
>     custom report() won't look at them, but it seems awfully fragile.
>
> I recently genericized the type-specific fsck_* functions so that they
> just need an oid, and not an object struct. I think I didn't do
> fsck_object() just because it didn't have any callers where it mattered.
> So I think it would make sense here to either:
>
>   - make fsck_tag() specifically available outside of fsck.c, so could
>     call it directly
>
>   - convert fsck_object() to take an oid rather than an object struct.
>     It only uses the object itself to check for NULL-ness. Looking at
>     the callers, they all have non-NULL objects already. So I think that
>     check can't be triggered.
>
>>  check_verify_failure 'Tag object length check' \
>> -	'^error: .*size wrong.*$'
>> +	'^error: missingObject:'

When I started out hacking on this I just made fsck_tag() a non-static
function. The faking up obj only got added because I needed to call
fsck_object().

Between this and your comment to 12/12 I wonder if the least bad thing
isn't just to split up fsck_tag() into fsck_tag() and
fsck_tag_standalone(), so I can call the latter with a "populate the
object and type" argument, and fsck.c will just NULL those two
parameters since it doesn't care.

Gets rid of the obj faking, and gets rid of the custom parser in
mktag.c. It'll only need to do the object lookup at that point, and even
then since I've added everything else to fsck.c I might as well make
that another custom ERROR/EXTRA, i.e. have it learn to do the lookup
itself.

> We may want to enhance the "error:" here to make it clear we're talking
> about a format error in the tag input. Maybe:
>
>   error: tag input does not pass fsck: missingObject: ...
>
> or something.

*nod*

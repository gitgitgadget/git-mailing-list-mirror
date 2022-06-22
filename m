Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41B5C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 15:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359047AbiFVPdh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 11:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358620AbiFVPdX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 11:33:23 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2E939173
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 08:33:22 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c13so19973840eds.10
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 08:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=UqGcSK122STw+3J/ZbXoJIw626dmCTkotf9REClLlfI=;
        b=hhcbPVahfwwAh7yPNcMNaWoqUOxTOJ+dznmSkjBVl8Lgyq2Di/Y+TCc1YRjLi3vWW4
         aLZf2u4ABYcTL4NbtPLC1z3mVDGGzbh//so47K0yM+kYKDYels3C+O2T29GeNKiI8Qum
         G8pdRphF6syU2NYOuAtEKmeU/cjDWUUwPNNckD76BiKfSkoZRtXZ7QYcNPiFv55tD0F/
         H1ujp+VCsU/NPG4JLgyrNKe4312jKg9lNbjxfdfPqWN5nZMZ/anWlhO0YJQLyllQRJqB
         g7sqTZeJRGJP0SW/e5CTvDxxv4DjiXU581aNO3++c8UknkKeiyq6FBcF/YKhMM7L9mtz
         MbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=UqGcSK122STw+3J/ZbXoJIw626dmCTkotf9REClLlfI=;
        b=5RVM+VczqzmAoRoOXMV9g6obgO1exmAecSL8bEm0gI/aszWrOJb3+B6DbPQaBTJXhm
         GaSh+NtiLb6WgshAl6V32rH3G5JZMuL11sNzsfz6dGAv9ljkkWzSqR4f0MxqjIh0rvxU
         8WLExP+fGBQB8UWqVJ2m2gDBqKil7w2GWyvPnyMbjrTM59Uku6d+gOa4TLrlAaTZmDlq
         puyVlIC0IQncINkqekw22VZK66ggUtvLbwBf6JVMzb7xAaQxgR9a5IlQfTJoieJmvX5P
         9U41A3g8ND7Hf6V+4ODCzO8Xrr+8mBfXzH97Jk7Y6GoNo0szht7IVxTMcdaKobtERQXb
         VBRA==
X-Gm-Message-State: AJIora80oIrHL/W0q7yQ1BuLj29uC5sR4nz7Z09wEE7H9Z9+FO2/6dqk
        aGLoWPZOpNsBLIH5Q1rgok/+3kAcof+iMw==
X-Google-Smtp-Source: AGRyM1vPcku9j9d5CyhR5gSxnngUS5cq+yKew1dy0RXCeCf+GQ2/AdE2ypmRivMcPNMZks8GBrqpzQ==
X-Received: by 2002:a05:6402:42d3:b0:435:2c49:313d with SMTP id i19-20020a05640242d300b004352c49313dmr4789117edc.86.1655912000593;
        Wed, 22 Jun 2022 08:33:20 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id kx8-20020a170907774800b006ff802baf5dsm9460826ejc.54.2022.06.22.08.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 08:33:19 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o42M2-000nYL-Ma;
        Wed, 22 Jun 2022 17:33:18 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        rsbecker@nexbridge.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/10] fetch tests: fix needless and buggy re-quoting
Date:   Wed, 22 Jun 2022 17:21:24 +0200
References: <xmqqa6a5g0m3.fsf@gitster.g>
 <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
 <patch-10.10-54129b94a77-20220621T222854Z-avarab@gmail.com>
 <xmqqsfnx6xbh.fsf@gitster.g>
 <69256646-13b0-5619-3161-8d8e319fad50@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <69256646-13b0-5619-3161-8d8e319fad50@github.com>
Message-ID: <220622.86iloslnlt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 22 2022, Derrick Stolee wrote:

> On 6/22/22 2:12 AM, Junio C Hamano wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> This makes it a lot clearer, with no perl, no sed, no eval.  It does
>> become louder, but should be easier to follow in general ...
>>=20
>>>  test_configured_prune_type --mode link true  unset true  unset pruned =
pruned \
>>> -	"\"$remote_url\"" \
>>> +	REMOTE_URL \
>>>  	"refs/tags/*:refs/tags/*" "+refs/heads/*:refs/remotes/origin/*"
>>=20
>> ... except for a magic like this one.
>>=20
>> We may remember the REMOTE_URL -> $remote_url trick used here this
>> week, but I am not sure if we find it sensible in 3 months.
>>=20
>> But overall I think this makes it simpler.  I am not 100% sold on
>> the necessity of lengthy earlier steps, though.
>
> When I saw that this was a series with 10 patches (without reading
> anything else) I expected that you had created a test-lib.sh helper
> that allowed replacing a word in a string with another string, and
> then the remaining patches were fixing the other tests that have
> similar breaks when using "@" in the path.

I guess we could have such a helper, but I can't imagine a use-case for
it where the answer wouldn't be the same as what this series suggests:
Just stop passing a quoted argument list as one giant string.

> (Heck, I'd even take a "test-tool replace-word <string> <word>
> <replacement>" implementation [...]

If we need to replace a string we can use sed or perl, but much better
is to not need to do so in the first place. E.g. the "origin" match we
had before is now just "origin" in a case statement. I'm assuming that
you mean a test-tool to do something similar to strvec_split() (or
whatever the quoted variant was?).

> to avoid all of these issues we have
> due to using scripting languages that rely on special characters
> to define the match and replacement operation.)

We've got plenty of issues inherent in shellscript as a language with no
little in the way of complex types (e.g. no hashes).

But in this case the language gives us the right type (list), we just
weren't using it. No?

> It seems like this isn't the last time we are going to have a
> problem with string replacement like this, and having a well-defined
> helper would go far.

...I guess I'm not seeing the use-case for it, in this case it was "just
pass a list then", wouldn't that be the case in other similar scenarios.

> The rest of the changes to the test script seem more complicated
> than necessary for what _should_ be a simple problem.

I tried to optimize it for ease of review as opposed to diff size or
patch numbers, so e.g. doing mechanical replacements in their own
commits.

Do you have any specific things in mind that you think are too
complicated?

Yes, it should ideally not be such a pain, but as we made wide use of a
string instead of a list digging ourselves out of that hole took some
doing.

But I really think fixing the underlying issue is worth it, as opposed
to just plastering over it.

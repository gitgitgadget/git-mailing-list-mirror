Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B45EC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 00:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346919AbiEZAGz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 20:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347022AbiEZAFT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 20:05:19 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E260048E61
        for <git@vger.kernel.org>; Wed, 25 May 2022 17:05:17 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h11so27779128eda.8
        for <git@vger.kernel.org>; Wed, 25 May 2022 17:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=eXu2NAk7MIItk/PM0IUMfkT9OFbRZoU86Oi7N0viTRI=;
        b=edKRUtE3Td1qCrc338x25WlmbpCMqHf4GCfBmNeF+W4Gk2k1hFP9OJvL+7uFwpgeKm
         9QqnxKU9/3nUj8MkjDmGFJ+xg4du3Fv7udl9f4MljLZv/sjObZjq4h557bFwJSBkUS8Y
         rPmUEtSTFDdlDmO3ZaSwMZPj/UR7uawVUg0NqDeT6UwwRZwdO9iXp9rOQ+haR0r/T4Eg
         uJFAkQh+dM3/Xzp2y12Qi6aGPY+UclyIe1aRcyEfsiChW0rkU7adQVdz9A9D++D1Gg+K
         hustEOzD5qhg13R5bg8XzC6YcW+5PNHBkhVc/6tZoLbehQWUqpgGqSX1j/IxwBIOBaEc
         1HEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=eXu2NAk7MIItk/PM0IUMfkT9OFbRZoU86Oi7N0viTRI=;
        b=JwUBVgxXWw7S/LtbElrQlhVeyp1CFO/Lw529ic3DT5UiHv7aaFWBcZx1/CoA1MapKk
         7t5ELCeDBb/w/imXe0MZe39/SMqtjIhDrVAgLV0HgFkNEzH6V61zwyZuP9/T3pedCnt5
         JvY3YGpVTsrJYpdwSARy94k8XX+ago4ojqfSGfwF0uRXO7LLbLzIdDvDUt3DH3PDtC7R
         iuuWQFvKohhQefzLhtjScqUhel2qlhjjY3U9PwQXyUWqkYT2b7g7Ksc4TOLRUgld4+a0
         LL5H1cilC7ylRmMw3EtWHnZRPdg6bheGdXsbR85lTgwecojNlcyn4eKIuKLSyVQA88/a
         fDUw==
X-Gm-Message-State: AOAM533c0wHKUyUA7K0hIdM2VnLV+vYEVm4N7sukZuEJzSVCPmpuZNS4
        4BLK29XzSHKQalBEHa92crE=
X-Google-Smtp-Source: ABdhPJzOvtnKv7OlMspEw5FON7NENsUcIlX3lRbIy0PDFQWnKdkQ7yHMPYoMGPtwRSuke/7uEw/RwQ==
X-Received: by 2002:a05:6402:254e:b0:42b:4633:e53e with SMTP id l14-20020a056402254e00b0042b4633e53emr24161956edb.314.1653523516145;
        Wed, 25 May 2022 17:05:16 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906354400b006fe98c7c7a9sm18647eja.85.2022.05.25.17.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 17:05:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nu106-0006yd-Gi;
        Thu, 26 May 2022 02:05:14 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, rsbecker@nexbridge.com,
        'Jonathan Nieder' <jrnieder@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: adding new 32-bit on-disk (unsigned) timestamp formats (was:
 [PATCH v5 02/17] pack-mtimes: support reading .mtimes files)
Date:   Thu, 26 May 2022 02:02:39 +0200
References: <cover.1638224692.git.me@ttaylorr.com>
        <cover.1653088640.git.me@ttaylorr.com>
        <91a9d21b0b7d99023083c0bbb6f91ccdc1782736.1653088640.git.me@ttaylorr.com>
        <Yo0ysWZKFJoiCSqv@google.com>
        <015d01d86fa6$a10519f0$e30f4dd0$@nexbridge.com>
        <Yo1bUbys+Fz7g+6h@nand.local>
        <016e01d86fc5$64ecf180$2ec6d480$@nexbridge.com>
        <Yo1zW7ntTuNakpOD@nand.local>
        <220525.86o7zmt0l0.gmgdl@evledraar.gmail.com>
        <32db3720-e9c8-e192-6278-c55855ce1d3e@github.com>
        <Yo6b+8sixGAqMm/x@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <Yo6b+8sixGAqMm/x@nand.local>
Message-ID: <220526.86sfox6tvp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 25 2022, Taylor Blau wrote:

> On Wed, May 25, 2022 at 09:30:55AM -0400, Derrick Stolee wrote:
>> On 5/25/2022 5:11 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> > I must say that I really don't like this part of the format. Is it
>> > really necessary to optimize the storage space here in a way that leav=
es
>> > open questions about future time_t compatibility, and having to
>> > introduce the first use of unsigned 32 bit timestamps to git's codebas=
e?
>>
>> The commit-graph file format uses unsigned 34-bit timestamps (packed
>> with 30-bit topological levels in the CDAT chunk), so this "not-64-bit
>> signed timestamps" thing is something we've done before.
>>
>> > Yes, this is its own self-contained format, so we don't *need* time_t
>> > here, but it's also really handy if we can eventually consistently use
>> > 64 time_t everywhere and not worry about any compatibility issues, or
>> > unsigned v.s. signed, or to create our own little ext4-like signed 32
>> > bit timestamp format.
>>
>> We can also use a new file format version when it is necessary. We
>> have a lot of time to add that detail without overly complicating the
>> format right now.
>>
>> > If we really are trying to micro-optimize storage space here I'm willi=
ng
>> > to bet that this is still a bad/premature optimization. There's much
>> > better ways to store this sort of data in a compact way if that's the
>> > concern. E.g. you'd store a 64 bit "base" timestamp in the header for
>> > the first entry, and have smaller (signed) "delta" timestamps storing
>> > offsets from that "base" timestamp.
>>
>> This is a good idea for a v2 format when that is necessary.
>
> I agree here.
>
> I'm not opposed to such a change (or even being the one to work on it!),
> but I would encourage us to pursue that change outside of this series,
> since it can easily be done on top.
>
> Of course, if we ever did decide to implement 64-bit mtimes, we would
> have to maintain support for reading both the 32-bit and 64-bit values.
> But I think the code is well-equipped to do that, and it could be done
> on top without significant additional complexity.

Do you mean "on top" in the sense that we'd expect that before the next
release, so that we wouldn't need to deal with bumping the format, and
have some phase-out period for the older version etc.

Or that we would need to treat what's landing here as something we'll
need to support going forward?

I think if a format change is worthwhile doing at all that it's worth
just doing it now if it's going to be the latter of those, as changing
file formats before they're in the wild is easy, but after that it's at
best a bit tedious. E.g. we'll need testing to see how we deal with
mixed new/old format files etc. etc.

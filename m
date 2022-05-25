Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16A4C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 09:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbiEYJhW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 05:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbiEYJhT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 05:37:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F77C5F4D
        for <git@vger.kernel.org>; Wed, 25 May 2022 02:37:18 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id rs12so28756199ejb.13
        for <git@vger.kernel.org>; Wed, 25 May 2022 02:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=aaeXsdCSpLJ3JyviIVjc+xSyhtty0G1C7UUiHqh2K14=;
        b=RKWesmGLwsVgRQcQjQTIbNhznQg8pgthvzve2kqdtOEGTbG7LpMxlrJ1tgNEfV9ZBs
         DdyX0Rmn5jr5Ga3+3RW+q3ufBQmy18zVxJ3+9JQpGJIsRVfTTj2MuWvUNQNl3nURhd3E
         tRv/uqE/S/sywwLx7/7VUVVuhqz/c+hlBDoXx8WBD1Gfs9qBaqOZjyfQBBT7itJ0wXTl
         fpqAiOWgo/Cp8+HT9GMpy0KN36dFhfxC3DWQFTpY3xsnJ2LhjgwJ4NVLhCMBE+M5Mvm/
         W1q1VpWC/WIuG/UhPQw11Lip+Aottj+eVvx6nJ20LHbZBih4MaEwirOAHliJVbYtJlNh
         UX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=aaeXsdCSpLJ3JyviIVjc+xSyhtty0G1C7UUiHqh2K14=;
        b=6INg4QqgtmokAnzfuUYhFVryKwYukI+aHvjWZYufQ/xU71mTzYUPvHU+zwDMj66MPW
         GTovM7OULuVNeBhtY4GrqWCIpRhKc8koZonRYvcQ7zLV08AH9g1QRQ89prAdd8sbZHlB
         9yUAcZvEqNnBRVAjSRaCnXL6sYVl0BlpyY5rWmIEAbJBHxNPlUPBkHvaz3cfZCHqrT9V
         qeyoPg7tgF6W1tpZNLAwPVq/VrOAIbI3hIfOey+f27DJtSLsSJyZ1CqOuF931qgEK+yB
         3jDxK3mRRKz9BYnNm91XCgal137rueLi4VADe4Wc7ro8L7sxHwG41Y2E/vNXz7b//lFe
         wlJw==
X-Gm-Message-State: AOAM533VQJXhSkD90o6EMiz0k8OrubeNSy6l7jzVycfWmB7zS1i0wan1
        vrlnT1EBH9jdTcqS+uqcJfE=
X-Google-Smtp-Source: ABdhPJx2mnO1Hl516qdT1XwG+eKw6/2O6IAkzSEU/xSHYdkZy/wr4oDyeReTAA5QZADHtaKPLy4t3w==
X-Received: by 2002:a17:907:7245:b0:6ff:18be:3db6 with SMTP id ds5-20020a170907724500b006ff18be3db6mr218356ejc.198.1653471436409;
        Wed, 25 May 2022 02:37:16 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id fg22-20020a1709069c5600b006feb002a620sm5384800ejc.1.2022.05.25.02.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 02:37:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntnS7-003hOr-5n;
        Wed, 25 May 2022 11:37:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     rsbecker@nexbridge.com, 'Jonathan Nieder' <jrnieder@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com, tytso@mit.edu
Subject: adding new 32-bit on-disk (unsigned) timestamp formats (was: [PATCH
 v5 02/17] pack-mtimes: support reading .mtimes files)
Date:   Wed, 25 May 2022 11:11:05 +0200
References: <cover.1638224692.git.me@ttaylorr.com>
        <cover.1653088640.git.me@ttaylorr.com>
        <91a9d21b0b7d99023083c0bbb6f91ccdc1782736.1653088640.git.me@ttaylorr.com>
        <Yo0ysWZKFJoiCSqv@google.com>
        <015d01d86fa6$a10519f0$e30f4dd0$@nexbridge.com>
        <Yo1bUbys+Fz7g+6h@nand.local>
        <016e01d86fc5$64ecf180$2ec6d480$@nexbridge.com>
        <Yo1zW7ntTuNakpOD@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <Yo1zW7ntTuNakpOD@nand.local>
Message-ID: <220525.86o7zmt0l0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 24 2022, Taylor Blau wrote:

> On Tue, May 24, 2022 at 07:24:14PM -0400, rsbecker@nexbridge.com wrote:
>> On May 24, 2022 6:25 PM ,Taylor Blau write:
>> >On Tue, May 24, 2022 at 03:44:00PM -0400, rsbecker@nexbridge.com wrote:
>> >> I am again concerned about 32-bit time_t assumptions. time_t is 32-bit
>> >> on some platforms, signed/unsigned, and sometimes 64-bit. We are
>> >> talking about potentially long-persistent files, as I understand this
>> >> series, so we should not be limiting times to end at 2038. That's only
>> >> 16 years off and I would wager that many clones that exist today will=
 exist then.
>> >
>> >Note that we're using unsigned fields here, so we have until 2106 (see =
my earlier
>> >response on this in https://lore.kernel.org/git/YdiXecK6fAKl8++G@nand.l=
ocal/).
>>
>> I appreciate that, but 32-bit time_t is still signed on many
>> platforms, so when cast, it still might, at some point in another
>> series, cause issues. Please be cautious. I expect that this is the
>> particular hill on which I will die. =F0=9F=98=89
>> --Randall
>
> Yes, definitely. There is only one spot that we turn the result of
> nth_packed_mtime() into a time_t, and that's in
> add_object_in_unpacked_pack(). The code there is something like:
>
>     time_t mtime;
>     if (pack->is_cruft)
>       mtime =3D nth_packed_mtime(pack, object_pos);
>     else
>       mtime =3D pack->mtime;
>
>     ...
>
>     add_cruft_object_entry(oid, ..., mtime);
>
> ...and the reason mtime is a time_t is because that's the type of
> pack->mtime.
>
> And we quickly convert that back to a uint32_t in
> add_cruft_object_entry(). If time_t is signed, then we'll truncate any
> values beyond 2106, and pre-epoch values will become large positive
> values. That means our error is one-sided in the favorable direction,
> i.e., that we'll keep objects around for longer instead of pruning
> something that we shouldn't have.

I must say that I really don't like this part of the format. Is it
really necessary to optimize the storage space here in a way that leaves
open questions about future time_t compatibility, and having to
introduce the first use of unsigned 32 bit timestamps to git's codebase?

Yes, this is its own self-contained format, so we don't *need* time_t
here, but it's also really handy if we can eventually consistently use
64 time_t everywhere and not worry about any compatibility issues, or
unsigned v.s. signed, or to create our own little ext4-like signed 32
bit timestamp format.

Once we hit 2038 (or near that date) this would be the only part of our
codebase & on-disk formats that I'm aware of that would differ from
time_t's signedness, but perhaps there's some I've missed.

If there isn't a demonstrable reason (as in some real numbers, or
accompanying benchmark etc.) to special-snowflake this I really think we
should just go for signed 64 bit here, i.e. matching time_t on 64 bit
systems.

If we really are trying to micro-optimize storage space here I'm willing
to bet that this is still a bad/premature optimization. There's much
better ways to store this sort of data in a compact way if that's the
concern. E.g. you'd store a 64 bit "base" timestamp in the header for
the first entry, and have smaller (signed) "delta" timestamps storing
offsets from that "base" timestamp.

This would take advantage of the fact that when we find loose objects
we're vanishingly unlikely to have them splayed over more than a
days/weeks/months or in the worst case small number of years from the
"base" (and if we ever do we could simply shrug and leave such objects
out of the pack entirely).

We could thus keep the 32 bit second-resolution timestamps you have
here, they'd just be signed deltas to the 64 bit signed "base" in a
header.

Even better (again, if micro-optimizing this is really needed) would be
to store a 64 bit signed base and a table of 16 bit signed offsets.

We'd simply declare that for our expiry times we'd "snap" any such
values to the next day. Our current GC config exposes down-to-the-second
expiry times, but in practice nobody needs that. A 16 bit signed "day
offset" would give you 2^15/365 =3D 89 years +/- of day-resolution expiry
for objects. To avoid thundering herds we could even fake up an exact
down-to-the-second expiry on the computed day by combining the expiry
time & the first few bits of the OID.

=3D=3D BREAK

Aside about time_t being signed v.s. unsigned. This is edited from an
older off-list E-Mail of mine (from git-security): For time_t itself no
standard says that time_t must be signed, but in practice it's
ubiquitous

This thread is informative
http://mm.icann.org/pipermail/tz/2004-July/012503.html it continues the
month after: http://mm.icann.org/pipermail/tz/2004-August/thread.html

Summary: Yeah it can be unsigned in theory, but it seems like nobody's
been crazy enough to try it, so it's de-facto standardized to
signed. Everyone has a Y2038 problem, nobody has a Y2106 problem. Well,
with time_t, e.g. Linux filesystems tend to use unsigned 32 bit epochs:
https://kernelnewbies.org/y2038/vfs

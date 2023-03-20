Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A121C6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 10:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjCTKim (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 06:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjCTKiO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 06:38:14 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B7216885
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 03:37:35 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id er8so33010058edb.0
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 03:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679308650;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3LN1waPpEqwIOoYK2VR+7SAzuePoMdDU2P1OCLF8qbo=;
        b=oAwjtPw55BzR3nOZ3AILSkbZmVTfI+KPz2PNKrU5NxRv5YgoL9AXwt7MUBVe7i6Epp
         KAP0pFIsTuyyNrCKlX+gAX8O40tU7UBQkQ9hyf+kXxT2+Y3G6RHruVtmnnEj14l4ipxq
         D6YTC4nFWR3XfYpGSAJ8JpJbc46OlFiKDJmwergmrE0m5S1d23ff8+xkUdgzMXbim6iQ
         NZDiiRAFu37QmWQt5spkKnj08s6mmkH7jzp+beu2+H/MKc87ntknrzLw9aMuW9kM1NQl
         Qslwka0UR/59rMDg050JQxN95hsp22BHaL2PpudAVm4UA++EpRpWVTRDEHAqIqpjRvm2
         WakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308650;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3LN1waPpEqwIOoYK2VR+7SAzuePoMdDU2P1OCLF8qbo=;
        b=IPlNe/iXLRTD6ydEtywyj3ikHPtay8OwisXnVvKEyG2uFuYa6p8k1Swvp6y6RHiDjq
         1YTvrajolodzSK27WpUamdzRDFd9HYk4ek8oqcvfIKzK5FOKo0Wsm9iT39nx4S4NpbBg
         PmlTrwnuhIhZszlvUOf2Y8hwNcFYX/cyjV1CQMFGYyXVwFWz+yqXhOkrmCb7OFm06W5I
         CV+eN3C2umXMxVcK12pjlCUr3QYAyZmEUrjFKSTAVZn/sJ2mGMdloiYBLfRdLKLmhYyh
         Np9H7cxXopbh53AhsmezK3EF2Syn322lQR8VgC0rSrni0hC8az99/whQlSdDWeVZPpUN
         G6dQ==
X-Gm-Message-State: AO0yUKVYfqZNa7xxP/i0pkvea77fuRGvlghGbNPiAv8RS0RaEcyS4cI+
        6YrRC17JZgKpQIFxE8bvOSwjJUgqI0Y=
X-Google-Smtp-Source: AK7set/GRV1c9ki2qZc6eft9MlvB1Uxp6O+vxVqAT2lRtSEfIbFmtMOZC8T0qICwgQGNU1TM8VB8Ig==
X-Received: by 2002:aa7:c74f:0:b0:500:46ea:841 with SMTP id c15-20020aa7c74f000000b0050046ea0841mr9384052eds.38.1679308649876;
        Mon, 20 Mar 2023 03:37:29 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id i15-20020a50d74f000000b004fb1a83cb00sm4703587edj.75.2023.03.20.03.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 03:37:29 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1peCtM-0047LV-24;
        Mon, 20 Mar 2023 11:37:28 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/16] Header cleanups
Date:   Mon, 20 Mar 2023 10:58:40 +0100
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
Message-ID: <230320.86v8ivwvx3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 19 2023, Elijah Newren via GitGitGadget wrote:

> This series picks up where en/header-cleanups leaves off and does more
> header cleanups, trying to reduce the number of files depending on cache.=
h.
> (There are still more that could be done, but again, this is a good chunk
> for now.)

> Elijah Newren (16):
>   treewide: remove unnecessary cache.h inclusion from a few headers
>   treewide: be explicit about dependence on gettext.h
>   treewide: remove unnecessary inclusion of gettext.h
>   treewide: remove unnecessary cache.h inclusion from several sources

I couldn't seem to square what you were doing in 2/16 with what 4/16
does, but I think the "issue" is that the commit message for 4/6 doesn't
match at least one change it's making, i.e.:

	By making those files explicitly include gettext.h, we can
	already drop the include of cache.h in these files.

But in fact compat/linux/procinfo.c at least (I didn't do more than skim
the others) isn't like the rest, in that it doesn't need gettext.h at
all.

I also find the ordering hard to follow, but it's ultimately correct in
the cases I looked at. E.g. for ref-filter.c your 1/16 does:

	-#include "git-compat-util.h"
	+#include "cache.h"

Then 2/16 does:

	+#include "gettext.h"

So I wondered, wait a minute, didn't we just end up over-including
cache.h because we needed gettext.h, which the later commit adds?

But no, that's not the case, because as 1/16 notes ("on things from
cache.h[...]") we need *other* things from cache.h, so this is
ultimately correct.

Still, given that, I for one would have found this easier to follow if
commits like 2/16 came before the 1/16, i.e. let's first be explicit
about e.g. gettext.h, and then change git-compat-util.h inclusions to
cache.h, to clearly note in the progression that the two are distinct.

But this is also fine with me if you don't agree, or can't be bothered
to re-roll it.

As a more general note on the direction here: I have some old WIP
patches to do similar split-ups of cache.h, but in doing those I was
trying to first identify cases where we had a function in cache.h that
was used by the low tens of our ~500 *.c source files.

E.g. advice.h is such a case[1], ditto wildmatch.h. Then we have case
like ws.c[3], base85.c[4] and pager.c[5] where there's no corresponding
header, but we should probably create one (which those WIP commits of
mine do).

Whereas this approach feels like the opposite of that, i.e. at the end
of this series we're including gettext.h in more than 250 files.

Stepping back a bit, I think our use of cache.h falls into a few broad
categories:

 A. Things to do with the index (we should probably create an index.h
    for those).
 B. Used almost everywhere, i.e. "cache.h" can be though of as "git.h",
    or "common-utils.h" or whatever.
 C. Things used almost nowhere, or only a handful of places,
    e.g. wildmatch.h and others noted above.

Part of this series is a frontal assault on the "B" part of that. I
think if we're going to include gettext.h explicitly everywhere we're
probably saying by extension that no such thing as a "common header"
should exist.

Which I'd be fine with, I just personally never thought it was much of a
practical problem, i.e. to have the gettext.h's in our tree included
"everywhere", ditto "strbuf.h", and even "enum object_file" and other
"mostly everyone wants these".

Whereas it is rather annoying that we over-include things in cache.h, or
even have cache.h include other headers, as often minor changes to
related libraries result in a full re-build.

But maybe "B" isn't sustainable at all, and I'm just fooling myself
thinking we could have such a thing.

A nice thing I hadn't considered is that after your topic e.g. removing
the gettext.h inclusion from parse-options.h will compile *most* of git,
but we'll fail e.g. in:

	t/helper/test-parse-pathspec-file.c: In function =E2=80=98cmd__parse_paths=
pec_file=E2=80=99:
	./parse-options.h:209:40: error: implicit declaration of function =E2=80=
=98N_=E2=80=99 [-Werror=3Dimplicit-function-declaration]
	  209 |                                        N_("file"), (h) }
=09

So as we don't want gettext in t/helper/* it's nice to get *an* error
about that.

So, in the end I think I've convinced myself that even the "B" in that
"A..C" is a bad idea.

1. https://github.com/avar/git/commit/17366c2b7b4
2. https://github.com/avar/git/commit/ffb226fb6e6
3. https://github.com/avar/git/commit/1d023e554bf
4. https://github.com/avar/git/commit/e7d5b511090
5. https://github.com/avar/git/commit/0054eea1a1a=20

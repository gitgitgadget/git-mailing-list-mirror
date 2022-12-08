Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2051C4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 12:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiLHMwO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 07:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiLHMv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 07:51:57 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7D36DCDC
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 04:51:21 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id gh17so3589283ejb.6
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 04:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8ithf6xDdW18ZKibD+mk6a5dVl5E1g20IGY+imYcj/o=;
        b=aWxhp9iIy3KJ/MNNQ67VqjcGp23n4WtywQIqxmTZ4S4ZaTEGnOykr1MBHQCeU0onW1
         dQMBAOSnMEN3GvPT/xrpZGj9D2s98MxdMVA/u9S4kuaDkgBF7dLZlZiBSfyJzu0v+YFZ
         BIejf4da7ZUd3ZKmW0pfURSHEpc+U8+pjDiLChF5ReeogdAxWthdORfX7xfd4FXt5lu5
         CGfOTPD9vSdlHl67nQ8cZvcxDdWyK+KqF48DSnyZV9SGb5prhHSHYK0+lhzyAnho0qmU
         JhbvmCOK8+4keNpAikqOdCtcPmMe6JyXsVQ5K8rWlLT1YvpZ0MKv+HIvy4USulorLgqr
         Rd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ithf6xDdW18ZKibD+mk6a5dVl5E1g20IGY+imYcj/o=;
        b=mB8/42oli6R+aN9hXE8qoq4za9KtUiYwuKMbyBlLdO2woFKzAtzkZgXinMx5jB9a4r
         fqS3iRn71mm97Zf+/18rgTac1o1C0Pmdv7N0NoOHe80RCuEiaQrOdZmOpXFW7D6qe7lY
         CEsLQFmaTb6rNUujolhPhv+MWDNJfxZIIV4wIXt+mfT9vqMrm+GeJKxKpXuwPFs9tdIA
         0k2Rbr7U92wC6HIr6oxgazhmgMj0LHqD731gK0LdWgCs24qM3fpJkFg4ubgzrP9ySnHM
         zNAgbLgVJ+8ICbuVMGTFQrLsfy0noO2ZNZcHzImiZZu53pKtMEbNr8H6FG5wSnt+tMqI
         SL5g==
X-Gm-Message-State: ANoB5pn2tBLaxAb9q2T0sSjbrhraXT0rZyl4d3APYa3/dNMtbQpy3/9u
        AKB6wU93+27p1ZoGwm5qtgw=
X-Google-Smtp-Source: AA0mqf7oN8UAvUT2imEg7t3aygRvbxbh9zrgIDEqJQcXfjjbDVOVFXP8Lz7pc6vR46/BfwRzXK192A==
X-Received: by 2002:a17:906:4315:b0:7c0:bc68:757e with SMTP id j21-20020a170906431500b007c0bc68757emr1917590ejm.39.1670503879519;
        Thu, 08 Dec 2022 04:51:19 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906768300b007c099174a12sm9877799ejm.178.2022.12.08.04.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 04:51:19 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p3GMw-0053hR-1v;
        Thu, 08 Dec 2022 13:51:18 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        johncai86@gmail.com, Taylor Blau <me@ttaylorr.com>
Subject: Re: Question: How to execute git-gc correctly on the git server
Date:   Thu, 08 Dec 2022 13:35:04 +0100
References: <CAOLTT8Tt3jW2yvm6BRU3yG+EvW1WG9wWFq6PuOcaHNNLQAaGjg@mail.gmail.com>
 <221208.86a63y9309.gmgdl@evledraar.gmail.com>
 <Y5GLWe4Kdaz+T5P8@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y5GLWe4Kdaz+T5P8@coredump.intra.peff.net>
Message-ID: <221208.86o7se6ou1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 08 2022, Jeff King wrote:

> On Thu, Dec 08, 2022 at 12:57:45AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Is this for a very large hosting site that's anywhere near GitHub,
>> GitLab's etc. scale?
>>=20
>> A "git gc" on a "live" repo is always racy in theory, but the odds that
>> you'll run into data corrupting trouble tends to approach zero as you
>> increase the gc.pruneExpire setting, with the default 2 weeks being more
>> than enough for even the most paranoid user.
>
> I'm a bit less optimistic than "tends to approach zero" here. The
> objects themselves might be older, but they may become referenced or
> unreferenced in an immediate racy way. E.g., intending to move branch Z
> to branch A, a client asks to add A and remove Z. Since there is no
> atomic view of the ref namespace, a simultaneous gc might see Z gone,
> but A not yet existing (and of course it could also be _two_ clients,
> etc).

Yes, I'm really hand-waiving away the issue there for brevity.

You've got a really good summary of why exactly that race happens
somewhere in the list archive, which I'm not digging up now.

But (and just for the general audience here, I know you know this) that
race basically happens because "gc" concurrently decides that say a 2
week old blob containing "foo" isn't referenced, *and* we have a
concurrent branch push that happens to reference a "foo" blob, along
with a concurrent "gc".

I have run into this once or twice in practice (with a very high volume
in-house git server), and in those cases it was because person "B" doing
the new push was using person's "A"'s work to push a new branch, after it
had been ~gc.pruneExpire since the topic branch for "A" was
simultaneously being deleted.

In principle what I noted upthread is completely false, but I think in
practice it's almost always true. I.e. users aren't pushing random
blobs, and as time goes by the odds that the exact same content is
re-pushed go down.

It's also worth noting that some repositories are much more vulnerable
to this than others.

If you have predictable auto-generated content in your repo (think the
package+version list some languages routinely carry in-tree) you're much
more likely to run into this: Someone bumped that for a topic ~2 weeks
ago, nobody else bothered on any of their branches, and then the "A"+"B"
race described above happens.

As some practical advice to those running "gc" on live repos: To easily
mitigate this run expiry on the least busy hours of the day. Even for
truly global development teams there's usually a big lull when it's high
noon in the middle of the Pacific.

>> The "cruft pack" facility does many different things, and my
>> understanding of it is that GitHub's not using it only as an end-run
>> around potential corruption issues, but that some not yet in tree
>> patches on top of it allow more aggressive "gc" without the fear of
>> corruption.
>
> I don't think cruft packs themselves help against corruption that much.
> For many years, GitHub used "repack -k" to just never expire objects.
> What cruft packs help with is:
>
>   1. They keep cruft objects out of the main pack, which reduces the
>      costs of lookups and bitmaps for the main pack.
>
>   2. When you _do_ choose to expire, you can do so without worrying
>      about accidentally exploding all of those old objects into loose
>      ones (which is not wrong from a correctness point of view, but can
>      have some amazingly bad performance characteristics).
>
> I think the bits you're thinking of on top are in v2.39. The "repack
> --expire-to" option lets you write objects that _would_ be deleted into
> a cruft pack, which can serve as a backup (but managing that is out of
> scope for repack itself, so you have to roll your own strategy there).

Yes, that's what I was referring to.

I think I had feedback on that series saying that if held correctly this
would also nicely solve that long-time race. Maybe I'm just
misremembering, but I (mis?)recalled that Taylor indicated that it was
being used like that at GitHub.

Another thing that really helps to mitigate it is this never-in-tree
patch of mine (which ran in busy production for years, and probably
still):
https://lore.kernel.org/git/20181028225023.26427-1-avarab@gmail.com/

It's sensitive to "transfer.unpackLimit" if it's going to help with
that, and even if you always write duplicate content it won't fully help
with the race, as "B" may have seen the old ref, and hence not sent the
"foo" blob over (so the client would need to not have a copy of "A"'s
about-to-be-deleted topic).

All of which described a setup I ran it in, so *if* we ever ran into the
race then most likely we'd just have written duplicate content in the
incoming PACK, so we'd happily chug along.


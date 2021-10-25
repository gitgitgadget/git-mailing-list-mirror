Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63F6C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 22:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D80A6101C
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 22:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbhJYWTU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 18:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbhJYWTT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 18:19:19 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B159FC061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 15:16:56 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 71-20020a1c014a000000b0032cafd23b1dso85225wmb.4
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 15:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=b9HehMapAhoPP2kL2W3+HrPtFiBn2BVU0iXedugTyt0=;
        b=NtD6S/pndznjtHYi/HqmQ5HNJXn3Erzxdjzg+Sox0tdXZS15wRG7oKml5CnG6KStIF
         Y+b5Z4uA+tCFwCkyAe7EoL/eKrdwX9fvB/EyYV2ehDPT9vDSfStKSV1zkMcka1qaiqXD
         BS8LhHYINicUb05rOFZwny82jT/EbOGDDd0BGhn1qcYtlCA8OwhYGnrFNyKocy2ruWQN
         OnWFGJh/vDlUIpdfgKZxcxe0YASgFfgYxjRvaIkv1GI7ZW1JTNoW2DEQg2DPkjPYyGFJ
         5B7bEdqWQCIjg4K7mzW1kI9RYSDJEG3KrGYffPVufEQyW2+Z+l1TEqkCYVWofveGWatk
         yl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=b9HehMapAhoPP2kL2W3+HrPtFiBn2BVU0iXedugTyt0=;
        b=7ULJqvXJ4XBBQp3UmFB8x2i1mpO7kfRyHTVPJsw9ax0rLtvbtbM2QEEuBJeQpAg1pK
         OWQoHMMCr9pbQPednyULOcWQK213MPNb+7gJQV0JJR1fPa/fzhuXazFbC5z9XvolI0qS
         JHpuUlrNAx7rUM2+7AdDeH2V2Hwuszk/t0HP2xHw7ca9DBuDyN1Z6BW5TUigSp6YEdNl
         3/CB29jfgU10yt18zQrWlkFsl7bQQslLU+kPaX+nxO1PfgL7yX4p3ymoKjUL07iBF7hP
         edgH5c76Xczh9CrOHmNm9BrXcYglBYqat+8fbgxCzVqJ+OXoSu5lP092s+8MSnzpl7C9
         dOYw==
X-Gm-Message-State: AOAM531Bxh8yZ5xj9S1cgvC/7tddhe/ud7tHc2Y7G+QUjMWWEuvwkpIS
        umhJKJqswSzRrdvp9UfJVys=
X-Google-Smtp-Source: ABdhPJxUtWyonl0r/MXyX7FjdeUIWslFARq4sw0j/nK9CiTqakA+Y5SvKdwU3fnyhVDLd5AaiArmcw==
X-Received: by 2002:a05:600c:b41:: with SMTP id k1mr53200078wmr.4.1635200215205;
        Mon, 25 Oct 2021 15:16:55 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y5sm7617545wrd.75.2021.10.25.15.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:16:54 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mf8H0-001gZ5-6l;
        Tue, 26 Oct 2021 00:16:54 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Subject: Re: [Summit topic] The state of getting a reftable backend working
 in git.git
Date:   Tue, 26 Oct 2021 00:09:55 +0200
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2110211148400.56@tvgsbejvaqbjf.bet>
 <CAFQ2z_NBOC5sDSL6AjCe-5mPVhU1B_guJEsHwVT3=AK1aAt8UA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <CAFQ2z_NBOC5sDSL6AjCe-5mPVhU1B_guJEsHwVT3=AK1aAt8UA@mail.gmail.com>
Message-ID: <211026.86wnm021ih.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 25 2021, Han-Wen Nienhuys wrote:

> On Thu, Oct 21, 2021 at 1:56 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>>
>> This session was led by =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (on behal=
f of Han-Wen
>> Nienhuys, the driving force behind the reftable patches, who did not
>> attend the Summit). Supporting cast: Jonathan "jrnieder" Nieder, Johannes
>> "Dscho" Schindelin, Philip Oakley, Jeff "Peff" King, and Junio Hamano.
>>
>
> Thanks =C3=86var for doing this. I wanted to be there, but I took a much
> needed 2 week computer-less vacation .

No problem, as is perhaps clear from the notes I had to hand-wave some
questions away since I didn't know about those things.

>>..
>>      9.  Reftable has a set of files that go together. May want debuggin=
g tool
>>          to dump the content of a binary reftable file. But we can
>>          incrementally add those
>
>
> The patch series includes a test-tool for dumping both individual
> tables and a stack of tables. It's not super-polished, but it gets the
> job done.
>
> $ touch a ; ~/vc/git/git add a; ~/vc/git/git commit -mx
> ...
>
> $  ~/vc/git/bin-wrappers/test-tool  dump-reftable -t
> .git/reftable/0x000000000002-0x000000000002-327b23c6.ref
> ref{refs/heads/main(2) val 1 ab21c324503544acca84eb55f5ee7dce24b23e15}
> log{HEAD(2) Han-Wen Nienhuys <hanwen@google.com> 1635188263 0200
> 0000000000000000000000000000000000000000 =3D>
> ab21c324503544acca84eb55f5ee7dce24b23e15
>
> commit (initial): x
>
> }
> log{refs/heads/main(2) Han-Wen Nienhuys <hanwen@google.com> 1635188263 02=
00
> 0000000000000000000000000000000000000000 =3D>
> ab21c324503544acca84eb55f5ee7dce24b23e15
>
> commit (initial): x
>
> }

Neat.

From memory I think the more general concern Philip Oakley was also
expressing (but maybe he'll chime in) could also be addressed by a tool
that just un-reftable-ifies a repository.

I think such a thing would be useful, and I think we don't have that
already. Isn't the files backend or reftable usage now an "init"-time
setting.

It would be useful if for no other reason than to give user who are
looking at a repository that's weird somehow the ability to quickly
migrate 100% away from reftable, to see if it has any impact on whatever
they're seeing.

I wanted to implement a "git unpack-refs" a while ago for "pack-refs",
just to simulate some performance aspects of loose-refs without writing
an ad-hoc "ref exploder" one-liner again.

A migration tool would surely be pretty much that, no? I.e. we'd just
create a .git/refs.migrate or whatever, then hold a lock on reftable,
and in-place move .git/refs{.migrate,} (along with top-level files like
HEAD et al, presumably...).

Maybe there's more complexity I'm not considering than just the *.lock
dance in .git/*, but if not such a tool could also convert freely
between the two backends, so you could try refable out in an existing
checkout.

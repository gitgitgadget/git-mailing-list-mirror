Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D607C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E9A761378
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhEYKir (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 06:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhEYKi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 06:38:27 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1C3C06134A
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:35:37 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id u11so29816213oiv.1
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=NiTxgjIK1CCIrpLWnoGjFZrJ8pmd5rABEs9sGNR7ASo=;
        b=M3mvXw9TfEGxGSOzXzGgHE2vF0SF1oCmhyri5bPzSMtpWggjz9gEfTxCK9EeiBGfFU
         f4kbKMMT1TKeI3SQtURNkHe0r+5i7PGT4XUWj/cP6mW/pOWQBS6oOvyVTYG70GyH/nnr
         SML0WfYkPNFj+6rp0vAXMu9vuMd9HEFQB+52dQDqJTtzdlD9OBBNDFu+eFjZFxo3g1OI
         a2jGv4h9pZPfbKA0r/sYhEyKy2sntWs1B4Tvr918fvVGA2LGXm25iPVuhZ//BG8vudJX
         XyxzRuuueojoKEb9/3/HwGjUKphjSDMdxK2pZY4K87T+tbtqX02h5BYsut6Df/97P4XV
         6byw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=NiTxgjIK1CCIrpLWnoGjFZrJ8pmd5rABEs9sGNR7ASo=;
        b=CuXZSV+as0pAwdT6KXZ8mWRMtJHP3TpRcl3LjMxMM+OVafNyd+Ol6hJWwZ+D8qbZrd
         vMr3RiRDLC/xnPapBTl5Cd23+DxzO/Xw0peEFMaOYmsNd13rQa+KqaJtjc6nZAAt2qt3
         bnMej8YgIyTiFvDtvbeWxEHMBuPUOaebxxp2DL/hlj5WS8TOQkToIq+abgZdp8u6j4fx
         fLIBcGcfMydxgr7PBbnwYHTHC89ROFRPvfARtrLGLFYQl/zF9LhvnibRbFJd3u5b3Mig
         8h6vQQH/rWV5latTT6aJLW27zAFvd+fDcjZfOquhjLVi1cHmxRtHm69aKlXX54sSZfS8
         eRWQ==
X-Gm-Message-State: AOAM530B3UIB/MEaRPLXFBrjQCaYr30nJavCQjJELQQSuZgzk7HmzIHY
        9M1FGOXy7mK4JqZm8UIsiLw=
X-Google-Smtp-Source: ABdhPJxV9uJEC7uoIgjPnvLGZJ4N5Hcw/QFUxS077xwo16j6zUdXWWo7A4CDN0JIpDd8hkyur0GAXA==
X-Received: by 2002:aca:f4c5:: with SMTP id s188mr13712395oih.128.1621938937134;
        Tue, 25 May 2021 03:35:37 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id w28sm2228065oth.55.2021.05.25.03.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:35:36 -0700 (PDT)
Date:   Tue, 25 May 2021 05:35:35 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Siavash <siavash.askari.nasr@gmail.com>, git@vger.kernel.org
Message-ID: <60acd2f76e290_2257a208e9@natae.notmuch>
In-Reply-To: <xmqqtumrfgqx.fsf@gitster.g>
References: <87k0nt3f8i.fsf@gmail.com>
 <YKcTFDgW4etXFpOR@camp.crustytoothpaste.net>
 <YKeFxcTDp4tHSRu8@coredump.intra.peff.net>
 <YKgzvFHOcUgPjbj/@camp.crustytoothpaste.net>
 <YKqzj/DZU8m9AaI/@coredump.intra.peff.net>
 <60ab17018efee_1691c20832@natae.notmuch>
 <87o8d0o2or.fsf@evledraar.gmail.com>
 <xmqqtumrfgqx.fsf@gitster.g>
Subject: Re: Renaming "non-contrib" things out of contrib/* (was "Re: [Bug]
 git-credential-netrc.perl[...]")
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> =

> > I wonder if just a top-level completion/* wouldn't be best, or if we
> > want to group them all together something like
> > optional/{completion,credential}/ or other name suggesting that these=

> > are meant to interact with not-always-present 3rd party software. May=
be
> > integrations/* ?
> =

> Add-ons?

An add-on extends the functionality of the core. These are not add-ons.

> I think dispelling the conception by distro people must begin with
> an update to contrib/README where it clearly says these are
> "contributed software" that are not part of "Git".  They are not
> something we stand behind like what we have in the rest of the
> source tree.

They know what the README says.

But they also know what the README says is not true. git-completion.bash
is completely fine for wide-spread use, and in fact, it's already used
widely. They are not going to remove
`/usr/share/bash-completion/completions/git` just because upstream
developers write something innacurate in contrib/README.

Their first responsibility is to provide the most usable system they can
to their users. git completions for bash is essential towards that goal.

As long as the README contains innacurate information they will be
forced to ignore it, and keep installing valuable stuff from contrib/ at
their own discretion.

> We instead encourage them to write and sell their ware on their own
> merit alone, without planning to "borrow" authority and gain undue
> advantage over its competitors by being in the contrib/ area in our
> tree.

They why did you reject my git-related tool[1], and yet accepted a
direct competitor git-contacts[2]? It certainly looks like you have
undue advantage to one tool over the other.

There's is also hg-to-git, a competition of git-remote-hg.

And for that matter git-completion.zsh, a tool I created, and is now in
competition with git-completion[3].

It would be nice if what was stated above was true, but alas it's not.

Cheers.

[1] https://lore.kernel.org/git/CAMP44s2+rNG+VPVJ82UsfrmHugnUwBVJfYF5QRVn=
0=3DJC061RFg@mail.gmail.com/
[2] https://lore.kernel.org/git/7vobamgqqh.fsf@alter.siamese.dyndns.org/
[3] https://github.com/felipec/git-completion

-- =

Felipe Contreras=

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FD1C4338F
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 19:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADAD26128C
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 19:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhHOTft (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Aug 2021 15:35:49 -0400
Received: from mail-4322.protonmail.ch ([185.70.43.22]:24659 "EHLO
        mail-4322.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhHOTfs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Aug 2021 15:35:48 -0400
Date:   Sun, 15 Aug 2021 19:35:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eagain.st;
        s=protonmail; t=1629056116;
        bh=31Ws1bhmZ0mZGdNQ9ZwN7Yh1aBf48rrLACDU8ZcZmT0=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=Q6zywR+bdpwnbxBqTXvTb+gXYmdZQ86rAkR49YIfPEBuPCwBX7GtSEjdvaBPbq/iX
         S6TvqJ6ux1F4XtFc2wxJ1FHiOH2yQFGJD2OOM22XpaE7T7ttE+Gx5KZDNvtRp10b5c
         8XwqfbfuXw+lbxtOVHx6gPbL139IY8xPfcJqsLqE6E/WQ576z6Amuz8sZ/la5E5qpz
         OMVTpshBNiETj7X/DOFNFKVdShdSS6VGClLhWGUBeVSOhs6y/gdsyEAsLeEZEfQOeC
         EADe8wusi6Jv1bm01wsnDxSB9XsMqiSShJRKLb49nlfCNYM3JWhCUL+bHYdA5SHaNH
         usZNeST+ynKtQ==
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:   Kim Altintop <kim@eagain.st>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        bwilliams.eng@gmail.com, jrnieder@gmail.com,
        sunshine@sunshineco.com
Reply-To: Kim Altintop <kim@eagain.st>
Subject: Re: [PATCH v6 0/3] upload-pack: treat want-ref relative to namespace
Message-ID: <20210815213453.GB10013@schmidt.localdomain>
In-Reply-To: <nycvar.QRO.7.76.6.2108142344570.59@tvgsbejvaqbjf.bet>
References: <20210730135845.633234-1-kim@eagain.st> <20210731203415.618641-1-kim@eagain.st> <20210804203829.661565-1-kim@eagain.st> <20210804205951.668140-1-kim@eagain.st> <20210809175530.75326-1-kim@eagain.st> <20210813062237.10403-1-kim@eagain.st> <nycvar.QRO.7.76.6.2108142344570.59@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

thanks for your response. This is my very first patch to git.git, and a lot=
 of
it is learning about the conventions and expectations towards contributors,=
 as
well as getting familiar with the tooling while trying to avoid silly mista=
kes.
So please bear with me.

On Sat, 14 Aug 2021 Johannes Schindelin wrote:

> > CC'ing Johannes Schindelin as suggested by git-contacts.
>
> `git-contacts` wouldn't know that there are better experts on the
> namespace matter.

I can see now that this could come across weird. I should've written:

"CC'ing Johannes Schindelin, who started to turn up in `git-contacts` outpu=
t,
although I couldn't quite infer why. I haven't received any feedback about =
the
documentation change yet, and didn't have much success trying to find revie=
wers
by inspecting the history (parts of the file where moved). I am assuming th=
at
`git-contacts` is better than me at this, and Johannes' name shows up becau=
se of
touching the documentation. Johannes: feel free to ignore if this assumptio=
n is
wrong."

With this said, if you have any suggestions about finding reviewers for spe=
cific
parts of a patch, or who are the experts on a more cross-cutting topic, I w=
ould
appreciate if you'd share them!

> My only comment is that I would find the diff to `upload-pack.c` much
> easier to parse if the `arg` variable hadn't been renamed.

Can you explain why? Just because the diff would be smaller? I can see that=
 in a
larger patch it might have been preferable to put the rename into a separat=
e
commit, but in a hunk-sized change it seemed fine. It is also that this
particular naming ("refname_nons") is used in other places in upload-pack.c=
, so
it seemed obvious that, if I introduce namespace handling where it was
previously missing, the terminology (if you will) should be the same.

From you comment, it seems like the proposer of a patch should assume that =
the
reviewers only look at the diff as sent in the email, and not any context.
Junio's response suggests something else, but I guess it's fair that if som=
eone
feels like they got CC'ed by mistake, they're not going to spend too much t=
ime.

So my question from above stands: are there better ways to find the right p=
eople
to CC, especially for newbies?

Thanks,
Kim


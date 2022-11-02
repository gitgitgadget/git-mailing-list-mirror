Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85823C4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 15:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiKBPox (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 11:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiKBPog (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 11:44:36 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36011286FD
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 08:44:06 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id k19so25247180lji.2
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0/PvxhUkjOBonJtO471RJe8rjW0zpx7XzqHViOQs2c=;
        b=fOjitYRen+gqfNFpMkucMCqlmbgUnV75sczSjbrJi92cLZUrk4rfG1iWBGI98lIiWl
         jx2Chdb9o47FNS6X4JbWRV/02bds64UTFEChoS+GDL1qpLIBHxX4I0YOAvXdF7/h4BGq
         zwe0YU2Y+mYx0CGZnvwqQyK4dLm122xxrvtQb0f2VUy40aVkP0jAptkedHNotRp+DckQ
         RIEGtqwrCcCIS4iv8orJuc3aa143w9F4LLPLokj7br02T7raMw3y5OgKDIAz4ngsaJQA
         X3/2CWtqI9/shNib3gTsQG3NSjDsxeT4bVxALNJi1TxUo/53njJ3WqPbbC7aK6tnPFIp
         tVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0/PvxhUkjOBonJtO471RJe8rjW0zpx7XzqHViOQs2c=;
        b=dqpGvmReSBHE0QziGbBWYZcAfDgppOGOpxbdP8Cv/4iWrr4RKa5s5Q492RXqeEsJ1A
         Yczlew8ZCAEc5Fat6IqADDXqaf+rUZot84hDwWquQ2vN2LAjn8QYpXP3bbaPk5QRIys8
         0PWqdXXpNmhqKzUcUYBdKKBzm/Ep3bBgdQQ50K9y7+0XxCh4c08MFjalMNuCul1RuI7r
         4a+9CqC1xg/iPCKr3uIFX4pZJa37pMHzqwlcx028NhoNC7NyuxDDgG1AIe/OzynuLND8
         zGrAUSRXCR6ljEsVBCNmfE1Cax7RCGXAWBW+PvGK5/8vf3+TFgnXZBB/g3fBk5LLIWOB
         +oqQ==
X-Gm-Message-State: ACrzQf2I6h85jjKeFbErIl+Wp+gc20/PwNAkWQo84R+O1qsE0sqIcFHv
        9eENb+NGEfCSNU1UvcRf4MtTKDNyz3ul+BUksYQ=
X-Google-Smtp-Source: AMsMyM4Lahnvv6BHiH4cGaNLMW4RKg2qChhunaGdTGYtgjv0FUj7x/gHpXK0vr56B035gYPWGSdAcwyzBeGkyDhgMcw=
X-Received: by 2002:a2e:2a86:0:b0:277:203:e3e9 with SMTP id
 q128-20020a2e2a86000000b002770203e3e9mr9821497ljq.163.1667403844253; Wed, 02
 Nov 2022 08:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <CABYbkvP=fMmaFUD3bQbeQ-XKiMSP6g-u0p7Vq1Qt_K5=D5WJ+A@mail.gmail.com>
 <Y2EPgICMsmzKvCC8@coredump.intra.peff.net> <38d50c30-c6a3-5989-6e01-47c5467d9d6b@gmail.com>
 <Y2IeqOT5Ao1Qa0Zl@coredump.intra.peff.net> <CABPp-BGmNqV5H5meMggKYTcTJDxxt5dRT3rZRnRPz496OJn3Vg@mail.gmail.com>
 <Y2I0siBlVOngNUtK@coredump.intra.peff.net> <221102.86pme52z8d.gmgdl@evledraar.gmail.com>
In-Reply-To: <221102.86pme52z8d.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 2 Nov 2022 08:43:52 -0700
Message-ID: <CABPp-BHwWYij2zqTSnsuu1ib97M4kJhfjMeEFqV13nttdqT1yw@mail.gmail.com>
Subject: Re: gigantic commit messages, was Re: Git Bug Report: out of memory
 using git tag
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Martin Englund <martin@englund.nu>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 2, 2022 at 7:43 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Wed, Nov 02 2022, Jeff King wrote:
>
> > On Wed, Nov 02, 2022 at 01:14:59AM -0700, Elijah Newren wrote:
> >
> >> On Wed, Nov 2, 2022 at 12:51 AM Jeff King <peff@peff.net> wrote:
> >> >
> >> > Here are patches which fix them both. I may be setting a new record =
for
> >> > the ratio of commit message lines to changed code
> >>
> >> It looks like the first patch is 72 lines of commit message for a
> >> one-line fix, and the second patch is 61 lines of commit message for a
> >> two line fix.
> >>
> >> I don't know what the record ratio is, but it's at least 96[1], so
> >> clearly you'll need to figure out how to pad your first commit message
> >> with at least another 25 lines before this series can be accepted.
> >> ;-)
> >
> > Well, if we want to start digging things up... ;)
> >
> > Try this:
> >
> >   git log --no-merges --no-renames --format=3D'%H %B' -z --numstat '*.c=
' |
> >   perl -0ne '
> >     chomp;
> >     if (s/^([0-9a-f]{40}) //) {
> >       if (defined $commit && $diff) {
> >         my $ratio =3D $body / $diff;
> >         print "$ratio $body $diff $commit\n";
> >       }
> >       $commit =3D $1;
> >       $body =3D () =3D /\n/g;
> >       $diff =3D 0;
> >     } elsif (/^\s*(\d+)\t/) {
> >       # this counts only added lines, under the assumption that
> >       # small commits generally remove/add in proportion. Of course
> >       # ones that _only_ remove lines have infinite ratios.
> >       $diff +=3D $1;
> >     } else {
> >       die "confusing record: $_\n";
> >     }
> >   ' |
> >   sort -rn |
> >   head
> >
> > which shows there are a few in the 100's. Pipe through:
> >
> >   awk '{print $4}' |
> >   git log --stdin --no-walk=3Dunsorted --stat
> >
> > for a nicer view. I'm rejecting the top one on the grounds that it's
> > mostly cut-and-paste output, and also that #2 is mine. ;)
>
> I think that '*.c' is cheating, if anything I should be getting more
> points when you remove that, as I've been over explaining
> adding/removing a compiler flag or something. At least your #2 is tricky
> C code :)
>
> I haven't bothered to do this, but I think if you --word-diff
> --word-diff-regex=3D. and parse the resulting diff you'd get "better"
> results.
>
> Or, for better & similar (but not the same): compute the levenshtein
> distance of the pre- and post-image, and compute edit distance to commit
> message length.
>
> I haven't done that, but just from eyeballing it I think [1] beats your
> [2] by that criteria. Per:
>
>         $ perl -MText::Levenshtein=3Ddistance -wE 'say distance @ARGV' in=
t unsigned
>         6
>         $ perl -MText::Levenshtein=3Ddistance -wE 'say distance @ARGV' ""=
 _lf
>         3
>
> It should get 2x the score v.s. yours, but yours is <2x the
> words/characters.
>
> (Edit: But see [4] below)
>
> There's also e.g. my [3] that's fairly high in the running per your
> "only added lines". But I think it shows the perils of doing that,
> i.e. in general I don't see why you'd omit deletions, that commit
> message is certainly spending most of its time talking about why the
> deletion of the code at hand is OK.
>
> Once you count deletions it'll get *way* down the list, as it's 11
> deleted lines, 1 added.
>
> Hrm, I take some of the above back, I think [4] might be the winner.
> That's just an edit distance of 1, so it's around 2x the commit message
> length of yours if we adjust for your score of 6. (~2.5 by
> characters)[5].
>
> 1. 356c4732950 (credential: treat CR/LF as line endings in the
>    credential protocol, 2020-10-03)
> 2. aec0bba106d (config: work around gcc-10 -Wstringop-overflow warning,
>    2020-08-04)
> 3. f97fe358576 (pickaxe -G: don't special-case create/delete,
>    2021-04-12)
> 4. c58bebd4c67 (ci: update Cirrus-CI image to FreeBSD 12.3, 2022-05-25)
> 5. All measured with "git show --no-notes --no-patch <commit> | wc",
>    because I was lazy.

Hehe, my offhand joke started a contest over the whimsical question of
who's the most long-winded.  I think my work here is done.  :-)

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEEFC433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 08:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344114AbiBUIlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 03:41:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344091AbiBUIlB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 03:41:01 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEC7FCE
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 00:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645432827;
        bh=KmFuFDpaVyrMK+5CSjZ7+mDwkmd+uPhkwcGIYK5kpZo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ginskFec2/VmzRJdbIjehlkVbW2JWxcrLk7w3veC3pRdp4jrHz+yxvPZlI52hi/JE
         0atZGrN/7NeXEdy4YmgRB3ReOWEwURa6OxnRUx07U0ymc44uVItSE7UsuZAC6urNK5
         gMOvdIGFAfKCy6l3O2eSXvCHsj+QFhzgxnDyAxCM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHoNC-1nR3uP2lIk-00EvVV; Mon, 21
 Feb 2022 09:40:27 +0100
Date:   Mon, 21 Feb 2022 09:40:24 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 04/13] merge-tree: implement real merges
In-Reply-To: <CABPp-BF+LNPFcyj-Ao2nFJw=a9OeX6B-rpbRrn56vOi=h6b9iw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202210932070.26495@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com> <02c29f920d0d5fde6d85f7b86a69be92e3f0f34d.1643479633.git.gitgitgadget@gmail.com> <xmqqmtj9x8g4.fsf@gitster.g>
 <CABPp-BF+LNPFcyj-Ao2nFJw=a9OeX6B-rpbRrn56vOi=h6b9iw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wFBTqiyuzPHm6Ig5/qcCYaPM0BvrGjBA0v73mN5rumA7OBPZl0k
 2t/EUPeV7JbH72MYR1sq9WNy4W9/oZHixqUrjj6jJyRqvLp5+5Y8ej6lYENmVFPpUoUIr53
 OU8SjPg2nQk0+JDJeLG6C1nPFfWCBc9NAp1UyL91QVG1f1WM3i/ZliD9WxIMxUPB5wiwNhr
 zQgvuhemy3ucZR8QDthGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4IggY2dn/6c=:ObcR4y4STkBvyqmHq+QKx7
 z5uh1BYlwj7RcLgYZL4ifeMoFmdn/ITI9koV8ppzMUJmJQeew+HSjQ0cqb3OlHoyDgfr9K/N1
 kNc0MJSmtnpkiWPiwxKxKInSlQtwtAZuPzazh/fgmd7C2MDzUA57xXXcKPZCY03kxXs0vr+Sd
 WTxTOSIz20Z45F/lzG61pjeTJhU7LxZNQkDugsBFh8DQSC1bebSJ4VZUg43BWlAOWPltZzZqy
 7KFkCgS8I8EkTIX2IhgXWeyzqtKbrFeU7QFp7YJSXbn5Bfw/z9Z7tq5PSpmTfHs1qKBZ8crpL
 gEdPYukSvpHGKR0kan3TKMcLqrMHM/nRuFjnw89lyHm9Jga+IjWsEW3GFzP5mSi/YZoGQA48o
 DinvY/AkeEASkEsmnb9zFsHmGud0Lz/XgMk3GsJkP8YYCRpq9uzKTbC3qOCtOIAOMN2s0+lbZ
 9KkH8VmGXzy5P1vImIsOkkfjDiCZlTpQXi61N83lB0oMQejDslNHtj6+nWZcOqEe8urlY/7XH
 Qs9tZq/3fSHyIbA3//S6ajtoLsTDk6nIOAcUwjZNWTRNwkadpVyTDpS3WBAmeoUo3UMp5Xvhs
 hJwVxs9dbtAMndXfzcu7HRW2wV6iLmi/yPBB0jA/66BfZ9oFyVTKYNBpocTU/amUaNSBW5/IP
 h6PbCaUIQlBD9IQILPHlaaN/VWxYvVXWRZ0ireHANKV6dSOomun23ySiIc3//4mDKrJXvBu/f
 ZaIXpr6RH/DmnkU0MLgxZtG9xUhcs2W+3jtCBL1D/OI8NuANP3mwY6SC8WjHRaSgQgzWGiM2R
 7DmE1W3HdOW51RaW462D796u3b1EH+bZ4bcaUAjbt89dClwnR0xy9g2SDPRn/BzqRZ11m74Rw
 NK8uhZfV1yCtgVwajS2PBdYQdpykQekh8q7jQcqJ2ydhssRafGJzOHC34r8Pk5/xWbMdvTCi5
 51JbG/HYdwFzkTkZg8C253GLMnfX40K5c7p+Owd3jqdSkfzKBsdvr0UocX5RW88+3rQaF5YIV
 6xqM4Z4dtnVHqtIkKkhxrtc1dW22KQCGiDGglNdz+2dUSwsv0KeN7hIlNSAo4y/ymW9P2i67W
 0hH6QH9qXby2CE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 2 Feb 2022, Elijah Newren wrote:

> On Wed, Feb 2, 2022 at 1:30 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > +Performs a merge, but does not make any new commits and does not re=
ad
> > > +from or write to either the working tree or index.
> > > +
> > > +The second form is deprecated and supported only for backward
> > > +compatibility.  It will likely be removed in the future, and will n=
ot
> > > +be discussed further in this manual.
> >
> > This, especially the deletion of the original description on what
> > trivial merge does, may be premature, especially if it is still
> > "supported for backward compatibility".
>
> I actually extended it, but Dscho suggested removing it entirely --
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2201251804250.2121@tvgsbej=
vaqbjf.bet/.
> I can restore it; does that paragraph look good to you (you can see
> the full thing even if it's split by Dscho's commentary).

I do not necessarily feel strong about keeping the paragraph, but I would
appreciate a better rationale for that than "because it was there
previously".

At this point there cannot be any doubt that the "trivial mode" is worth
deprecating and getting rid off because it has been in little or no use.

I mean, elsewhere we are overzealously removing stuff "because _core Git_
does not use it", and here we keep something for... reasons?

> > > +test_expect_success 'Content merge and a few conflicts' '
> > > +     git checkout side1^0 &&
> > > +     test_must_fail git merge side2 &&
> > > +     expected_tree=3D$(cat .git/AUTO_MERGE) &&
> > > +
> > > +     # We will redo the merge, while we are still in a conflicted s=
tate!
> > > +     test_when_finished "git reset --hard" &&
> > > +
> > > +     test_expect_code 1 git merge-tree --write-tree side1 side2 >RE=
SULT &&
> > > +     actual_tree=3D$(head -n 1 RESULT) &&
> > > +
> > > +     # Due to differences of e.g. "HEAD" vs "side1", the results wi=
ll not
> > > +     # exactly match.  Dig into individual files.
> > > +
> > > +     # Numbers should have three-way merged cleanly
> > > +     test_write_lines 0 1 2 3 4 5 6 >expect &&
> > > +     git show ${actual_tree}:numbers >actual &&
> > > +     test_cmp expect actual &&
> > > +
> > > +     # whatever and whatever~<branch> should have same HASHES
> > > +     git rev-parse ${expected_tree}:whatever ${expected_tree}:whate=
ver~HEAD >expect &&
> > > +     git rev-parse ${actual_tree}:whatever ${actual_tree}:whatever~=
side1 >actual &&
> > > +     test_cmp expect actual &&
> > > +
> > > +     # greeting should have a merge conflict
> > > +     git show ${expected_tree}:greeting >tmp &&
> > > +     cat tmp | sed -e s/HEAD/side1/ >expect &&
> > > +     git show ${actual_tree}:greeting >actual &&
> > > +     test_cmp expect actual
> > > +'
> >
> > It is somewhat sad that we need to reivent merge test cases over and
> > over, instead of easily reuse an existing one by replacing
> >
> >         git checkout one &&
> >         git merge two
> >
> > with
> >
> >         git checkout one &&
> >         T=3D$(git merge-tree HEAD two) &&
> >         C=3D$(git commit-tree $T -p HEAD -p two) &&
> >         git reset --hard $C
> >
> > ;-)
>
> Sorry...I'm afraid I'm not following.

I cannot speak for Junio (nor do I want to). Having said that, I interpret
the quoted section as a lament on the somewhat repetitive complexity that
is required by our tests merely to set up a scenario where we can run the
actual command we want to test.

If my interpretation is correct, then it is probably fair to suggest using
`test_merge` in a setup-type of test case (because that not only runs `git
merge` but also tags the result), and then use `git reset --hard <tag>` in
subsequent test cases instead of re-running the `checkout && merge` dance.

Ciao,
Dscho

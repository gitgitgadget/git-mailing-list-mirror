Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 908E920248
	for <e@80x24.org>; Fri, 22 Mar 2019 14:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfCVOGv (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 10:06:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:53325 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbfCVOGv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 10:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553263602;
        bh=qljOBUD6/JnQvi8fmRHMuz5I/n9ng3iJ6Ee0ijWQsCQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Relg+FiNSUC7dTw8rSu3RU3LQuxndLqTExrY+ODbwULTYWt2a2Vv/ZLYQkVfPGxt2
         Em6TZo6vSUeykpMfLLRF7BH7+VsCZn6FmFQessX16giD9mNamH1xg0RWagTcsqG3oY
         h+Yeu8ce05EnPkPdbexWnZ04FVso170ItRw5lew0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIhDo-1h9Wg60Qhs-002Hg8; Fri, 22
 Mar 2019 15:06:42 +0100
Date:   Fri, 22 Mar 2019 15:06:25 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Jochen Sprickerhof <jochen@sprickerhof.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] add -p: coalesce hunks before testing applicability
In-Reply-To: <d6a8f77b-0a83-90ae-a7fb-a3954ac3b346@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1903221453360.41@tvgsbejvaqbjf.bet>
References: <20180828085858.3933-1-git@jochen.sprickerhof.de> <xmqq36uygyau.fsf@gitster-ct.c.googlers.com> <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net> <20180903190114.GC17416@vis> <d6a8f77b-0a83-90ae-a7fb-a3954ac3b346@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VGDMgNKhOfMNW86Y9tOghQSYyFEoySssgzum1UHI6Zyo08dDPMA
 EdsDKhuPoIbjpWJykAXpE2S3VCLO6wTBzfFcYolYQm7ASqhkS/Zullrn+/3wtnQspwxR4XV
 4hZldEL7JypdhinH3rrORDj/zgA5xAzNHAP3iGAdMxXFxUW8sRxiHRQaEs14+dpAUUbcFmV
 jne2iej7EpGRJwnsdUY9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KSHBWjqogjw=:VMzoj2i8fX1x56ywacuZa3
 dHwbDEdUyTBa5Bo0/dwVN8HjO81tN1888oaFXOACubaja8dlCElQIDVTFs3E5GiqYpRsd71Kx
 au97natUSqYpJJjn9MbXo0U7OPA3KAm/eqziHCAs8EHrK61O78f8RuFZHP9un2JpNV4ZtRBwF
 KRB4EXtLi+dR+myhsTJeWKIbHjKEH+lOFhw4+fHMz/QNQycWzoE2CGosD1a8lwh76zqPyaLX4
 1S78EjTFy9ruNP1PdV+6JTD1YjoVHzrpMnZgTtZYBtSLvG5AtU7LjITmOEv0zLkEvh8vxE+Cr
 3T+j0/GbXamKJ9ojAJNY9ofPNRdfjLQnj9+Ebzchy7u6V0cw5ZvKei9yYiz1DexQb1QymBd4B
 4G4NexA66DzGBkuvUAXHemSJ4NnaBKimK1DU982F4k2hBbiPJ8l2S2PiMdQpdt6WwGwH5S/ei
 CWhkf7bJD4i0Cn79nE9zChAlqKk0KmkoM3kN9jO4ywA1gQyZMtnmYnUwF5uvNsSEqkFIj1+9P
 gqJ7FY2w9ZsbQ0u6gbmlb/iPCJJmyX+XUZJBrPf51aZEF50SPwh9JB3oJ8QcJRhEqYv7HRJQA
 sA6ZzAE7qKP824T/ZWNCN26X+pHQMD3HEW8FuiKFcoGkaCZQfYPhQsfxBzdu4yzx021mtizKX
 6zttjJXeDunMszMl2BNs26oXLmVgAs65hJ+YA1EHw1giFAvTymmqx7HnGDH8ulhT+ESaLpMWm
 HXfdwo1Y74Si7HbDeBWskbIcl8+6gmxMS6VTweKMvNxjHwqxFhdsQ1FW+lR/XtZTsRbqlv0nJ
 LWNKO1jufmNhcrgQ0BjJhsXgI2cJ5dB9chSvYlkdMcLPr4o/T6PN2RC72G3IMMY00S07OPap3
 kOONAnrKcQxNACpxkU7cRuz9hZQ98cWuphrYKYyc3x7VgwvhWJesJLq43g3qpMUEuhDdO+ZP+
 BrLG98C4e8A==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 13 Sep 2018, Phillip Wood wrote:

> On 03/09/2018 20:01, Jochen Sprickerhof wrote:
>
> > * Phillip Wood <phillip.wood@talktalk.net> [2018-08-30 14:47]:
> >> When $newhunk is created it is marked as dirty to prevent
> >> coalesce_overlapping_hunks() from coalescing it. This patch does not
> >> change that. What is happening is that by calling
> >> coalesce_overlapping_hunks() the hunks that are not currently selecte=
d
> >> are filtered out and any hunks that can be coalesced are (I think tha=
t
> >> in the test that starts passing with this patch the only change is th=
e
> >> filtering as there's only a single hunk selected).
> >
> > Agreed here. It would be enough to include the first hunk in the test =
to
> > make it fail again. Still I would see the patch as going in the right
> > direction as we need something like coalesce_overlapping_hunks() to ma=
ke
> > the hunks applicable after the edit.
>
> Yes in the long term we want to be able to coalesce edited hunks, but I
> think it is confusing to call coalesce_overlapping_hunks() at the moment
> as it will not coalesce the edited hunks.

Agreed. I actually have code to coalesce even edited hunks, but it is all
in C.

> >> This is a subtle change to the test for the applicability of an
> >> edited hunk. Previously when all the hunks were used to create the
> >> test patch we could be certain that if the test patch applied then if
> >> the user later selected any unselected hunk or deselected any
> >> selected hunk then that operation would succeed. I'm not sure that is
> >> true now (but I haven't thought about it for very long).
> >
> > I'm not sure here. If we use the same test from t3701, do s(plit),
> > y(es), e(dit), it would fail later on. Can you come up with an
> > example?
>
> I think that if you split a hunk, edit the first subhunk, transforming a
> trailing context line to a deletion then try if you try to stage the
> second subhunk it will fail. With your patch the edit will succeed as
> the second subhunk is skipped when testing the edited patch. Then when
> you try to stage the second subhunk it will fail as it's leading context
> will contradict the trailing lines of the edited subhunk. With the old
> method the edit failed but didn't store up trouble for the future.

Indeed, this is a problem I also stumbled over.

> >> We could restore the old test condition and coalesce the hunks by
> >> copying all the hunks and setting $hunk->{USE}=3D1 when creating the
> >> test patch if that turns out to be useful (it would be interesting to
> >> see if the test still passes with that change).
> >
> > We set USE=3D1 for $newhunk already, or where would you set it?
>
> To match the old test it needs to be set on the hunks we've skipped or
> haven't got to yet so they're all in the patch that's tested after
> editing a hunk.

The way I fixed this in the C code is by teaching the equivalent of the
`coalesce_overlapping_hunks()` function to simply ignore the equivalent of
`$hunk->{USE}`: the function signature takes an additional `use_all`
parameter, which will override the `use` field.

Furthermore, my C code actually does the coalescing as part of the
`reassemble_patch()` function, feeding the output directly into the
`stdin` of the `git apply` process (with, or without `--check`).

And crucially, my C code does not try to assemble a new `hunks` array, but
simply works in-place, reverting the changes if the hunk edits result in a
patch that does not apply. The Perl version probably does not need that
part, as it is pretty careless with memory (as Perl encourages to do).

See for yourself:
https://github.com/dscho/git/commit/6f8ac4809280f2cd018683ab5199b004ada235=
0e#diff-f58d2179be56b196b9f35c6d24799a8eR337

Ciao,
Dscho

P.S.: Yes, this is part of my work to complete Slavica's "`git add -i`
in C" project. There are quite a few loose ends to tie, but I can already
use it myself to call `git add -p`, which is what I care most about, as it
regularly takes more than one second to spin up Perl on Windows, which is
friggin' annoying, I tell ya.

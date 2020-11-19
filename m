Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAAAC2D0E4
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 12:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04902246E0
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 12:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DJVaHe+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgKSMiY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 07:38:24 -0500
Received: from mout.gmx.net ([212.227.15.19]:57387 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbgKSMiY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 07:38:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605789497;
        bh=iZb8hYDNJmn9tTDwiI4kStzzoMdpGNtBo8icgMNpy9o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DJVaHe+TuWlfqlaiKPTDZ/1LQFIBYEX8J0MAlCuWokhF/sYjntw6GHmSLxGiqD4s+
         k1Ecr5pUrY3Ttgx5ypprYOrWm4W8hMk23YZ3l4lujK5rmJobhV2I6n8h6M2qQDgqF8
         l8pWhplwZvZ1xbyGAh/c8B2WOdjrsCuGdIWsAcew=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([213.196.212.61]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GQs-1kAyxV0Gye-014BmT; Thu, 19
 Nov 2020 13:38:17 +0100
Date:   Thu, 19 Nov 2020 13:38:16 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        shouryashukla.oo@gmail.com, git@vger.kernel.org,
        christian.couder@gmail.com, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, pc44800@gmail.com, chriscool@tuxfamily.org,
        stefanbeller@gmail.com
Subject: Re: [PATCH v2 2/3] submodule: port submodule subcommand 'add' from
 shell to C
In-Reply-To: <871rgprdt1.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011191327320.56@tvgsbejvaqbjf.bet>
References: <xmqqd01sugrg.fsf@gitster.c.googlers.com> <20201118231331.716110-1-jonathantanmy@google.com> <871rgprdt1.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1924640556-1605789499=:56"
X-Provags-ID: V03:K1:OCuGGWERS6lKoCTEp1NJtpXFZii5Be2aSLriRmg4LGQhF9GxCZK
 vHxiiMXL17O1peXw1YzTs8kl5KYw+cMNMaGVpHhNXBXijuQ/4YleK7DDoTR7UkPP3EjSO0S
 oHJEYnO+ryQstc2OdE0SdNR2inYiquheh89fwBKCsP2Lftms0+ugIC8nO4M6gSf0IJL9DZX
 llz1wwdRH2/CHChwXF6mQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DCIuZWd1ct4=:n+MqAeB+yniiIW6I5zPqp6
 SZC49/BKPZVLWy4HGEGVPjV6+yld1WzDQpMpEt0JEFUyuXSsIwSpbFM2BuvLBwq1et4+PgIBG
 BsjcrTZsInvohOZMgEg8WwnN5HibYcNmOf3Q2iMDH06uLf4gIYLh3BT79YZ06fK/o008DCVnh
 Dh52x2QY/LurD2qycVo5tPf8Fo7r0RdC3FnHM96TQn/QUZDknZfx/W82wtVDTbiLR9PIs3+In
 mOiZ16Tyl8GzxXVHMuNhFcRyN9/zZukJBuwX7joYzhYhxCSLj7xFLDGpTFz2ocO8EgGGnbQRt
 TnCzFe+LJnGI5PPotVT7f5Bm9MLozW0GRRO81/O7LJxLEzGACmv/fyHNCcPpC8zgsRLaLp2u2
 G7JwEHX95z3KhBzqXrOhbS1nJH01vqqqhMlMH+T59KFr6x6ctjBvQzqBZfy4GezsbvM25iIVF
 DI7hO86Dlo/e0qQsN2GtzW7lNasFvq//N9eOIsHECY7SzEDpqxrI/WvXeTRkphSg8I7lg9dEf
 /HiWgvKE7veaw8HT5auXYMEhq+iYQlKeb2DIj6BaSqQDKIcPJ8gVuF2iV5ssL3PFhybyt0Ial
 SYupR5aZGfzQvmPGfYx69+j4fZ6FL4xg5oEXwkJ4P1Mfa77i7FbzXwHr43SV+dZ5HFGoj3VbX
 JwsGjjOTvWjIL/a+HmxMpfG+Katg19GEMCnO9O35u5yLzLNN5hlBpVEf8IegvoL89tMkDCh7J
 FFyhUEgR3YGQI0VVgkndUx+9zhPNivPjRb0d7w2KYKhnMDwWu5wXFgmG3sYU98mTb0FQh/x3u
 zbQws3z0qzXNzwkv4JVRaBSxeyGGYHol48lEXF5SrEmRNF+xQBelgmtWUnqeDFWr0s3kfJ4+C
 09oHMnIm6oSI8WM41CkhCWJFm87zFYHpNieYC6GFY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1924640556-1605789499=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 19 Nov 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Thu, Nov 19 2020, Jonathan Tan wrote:
>
> >> Whew.
> >>
> >> This was way too big to be reviewed in a single sitting.  I do not
> >> know offhand if there is a better way to structure the changes into
> >> a more digestible pieces to help prevent reviewers from overlooking
> >> potential mistakes, though.
> >>
> >> Thanks.
> >
> > I just took a look at this, and one thing that would have helped is if
> > you ported the end of the function first in a commit, and work your wa=
y
> > backwards (in one or more commits).
> >
> > After reading through the whole thing, I saw that this is mostly a
> > straightforward start-to-finish port (besides factoring out code into
> > functions), but it would be much easier for reviewers to conceptualize
> > and discuss the different parts if they were already divided.
>
> Having done some minor changes to git-submodule.sh recently, I wondered
> if we weren't at the point where it would be a nice approach to invert
> the C/sh helper relationship.
>
> I.e. write git-submodule.c, which would be the small entry point, it
> would then mostly dispatch to a submodule--helper, which would in turn
> mostly dispatch to a new submodule--helper-sh (containing most of the
> current git-submodule.sh code), which in turn would re-dispatch to the C
> submodule--helper (which as an aside, then sometimes calls itself via
> process invocation).
>
> It's quite a bit of spaghetti code, but means that there's a straighter
> path to porting some of the setup code such as the "--check-writeable",
> is_absolute_path() etc. being changed at the start of the change here to
> git-submodule.sh.

Looking at
https://github.com/gitgitgadget/git/blob/ss/submodule-add-in-c/git-submodu=
le.sh,
I see that while there are still 794 lines, most of it is just mostly
redundant option parsing. The only function left to convert is
`cmd_update()`, and the first half was already converted to C long ago,
via the `git submodule--helper update-clone` subcommand:
https://github.com/gitgitgadget/git/blob/ss/submodule-add-in-c/git-submodu=
le.sh#L269-L530

At this stage I suspect that having a little more patience would make more
sense. After `cmd_update` is converted, we can simply finish the
conversion, without having to keep the shell script around.

Ciao,
Dscho

--8323328-1924640556-1605789499=:56--

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7E7C433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 10:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E92619B1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 10:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhCXK6W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 06:58:22 -0400
Received: from mout.gmx.net ([212.227.17.22]:47811 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234452AbhCXK6G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 06:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616583467;
        bh=91pnbIWYzaAEJFknAQESASjj8jRakGhoqaC+NeQB7O4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BfzrZzoQXHhSyUc6oFxUyQJscP6Y/MHSVX3tnHmTl1oF1PihD2Wlcn80KVLAsq/VY
         dWiyQiekXWzAKbK4LiUGmQ/4c5XanINHL8zzFhOzj8NQ4yBuNeho1Fdgyd+ht5+ak0
         ybfbzxi+eg+Ozoq2tU8eyA/f6HLa+qCwJ1mWhRi0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.9.78] ([213.196.212.127]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDNf-1m0q3g1ibX-00qk0Z; Wed, 24
 Mar 2021 11:57:47 +0100
Date:   Wed, 24 Mar 2021 10:10:24 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v7 08/15] merge-one-file: rewrite in C
In-Reply-To: <c968a6b8-bc0e-04f0-b72d-9fef05b60bd8@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2103241004590.50@tvgsbejvaqbjf.bet>
References: <20201124115315.13311-1-alban.gruin@gmail.com> <20210317204939.17890-1-alban.gruin@gmail.com> <20210317204939.17890-9-alban.gruin@gmail.com> <nycvar.QRO.7.76.6.2103222303210.50@tvgsbejvaqbjf.bet> <c968a6b8-bc0e-04f0-b72d-9fef05b60bd8@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-735098467-1616576867=:50"
Content-ID: <nycvar.QRO.7.76.6.2103241009120.50@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:aKoRNkz4nPyoNcOzG5jjel7j3IAxxwE9pEGywtM7lvI124JvP4F
 AAhD3XBt2MoSKR0kDv62S85wVxxMI0u3fkFN0RdT/pw1q4v2CzFiDJnAJJ/q57Ahk6z14h/
 LCdb16j8clyaG4jdBYGXR7DIX1tQOf8VGPzunZzSSQuy1EYQBEFLnlTboj3ofWdMOZZ4Y52
 THrFZTky9EjZoELhcZNTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tAMFC/oRy6s=:/x+LXHjgNcn+AHKirrgN+y
 +IG3Bgu3e2hqsMjkbL/NjmitFwqAvliJ+lbIoiTP8CVW5o86zY+aUgR/SfgIvf1eG85E2MCKq
 sWUzK05JMAXV7MCfZjvOJJn3sRtvQqCtTOj09QQ+c1xfaEq71kg1rLQ77GSsNAfZ5AgQ0vqx3
 fJSzOKdE1yNm8n597ClztU9O/rwKA6U6BDjJmFKMicI4JFL9sfBISVm3VSMlduAFGbTJqAuR2
 YO8omsBWXE5Q5eIcoTA05v8J2khNM2lIXLzQoJB9ip9Oa1c3HVMCT1gJ/0/8pvWyfiv5wpjtd
 JelswLkSPQCZeuLMLH6LdklVN8l4VMrB2BrbXVjWkF109zotnesccY+bCYDMqVe9yGV+20MiP
 WzhkwUYp1PVXuoMNTJpCsEdhG8ZsnO2A7yDcBCCFomXXTKVHqIK3yA/BQhgXtd34uhuty00rs
 1Yto0gctIL7qos+81Gh/CQ8atsHsr+62mm+f8g/ycmKCiCE8GYdWjQ7+vwKetB7inTPAq5MGP
 kynjfj3quEliLmPPOm1MiEZ9TVN8YhMw+TTtXnVPNpLh4pcS6KeD+CIAK7x+lgTjt8YuL8gGM
 A0OPp6jN4lT98xCIdvlT/iDEeRMZ1IJf1iHUFUf035OlakwKlL3BIniJJL86y0VuY2uLiGhfV
 4jM8UBY7M5mJPGvPv7tVNJbzrd8oHHvq4ebVSoWh85+l6ZRWmmJdCyCJAZT7uElkvMCbbIAxh
 HzMWUvxZqTOb4XD/QSvumJ7F98f0wnK0cO0gCdQjgnruZCqP2MtVQ4D6o+kfE72IBkiosVP7O
 fxz0upb4/SpoNpTsY8A2eBouYx68i/qaH3Pgbe3flqa8VpX9yCZZNdOrMo74gKdpZ77CUnVAW
 PMhXpIMLGzKSkLvD2yhlxmqfIBSVip2larAOxKyTw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-735098467-1616576867=:50
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2103241009121.50@tvgsbejvaqbjf.bet>

Hi Alban,

On Tue, 23 Mar 2021, Alban Gruin wrote:

> Le 22/03/2021 =C3=A0 23:20, Johannes Schindelin a =C3=A9crit=C2=A0:
> >
> > On Wed, 17 Mar 2021, Alban Gruin wrote:
> >
> >>
> >>  	for (; i < argc; i++) {
> >>  		const char *arg =3D argv[i];
> >> diff --git a/builtin/merge-one-file.c b/builtin/merge-one-file.c
> >> new file mode 100644
> >> index 0000000000..ad99c6dbd4
> >> --- /dev/null
> >> +++ b/builtin/merge-one-file.c
> >> @@ -0,0 +1,94 @@
> >> +/*
> >> + * Builtin "git merge-one-file"
> >> + *
> >> + * Copyright (c) 2020 Alban Gruin
> >> + *
> >> + * Based on git-merge-one-file.sh, written by Linus Torvalds.
> >> + *
> >> + * This is the git per-file merge utility, called with
> >> + *
> >> + *   argv[1] - original file object name (or empty)
> >> + *   argv[2] - file in branch1 object name (or empty)
> >> + *   argv[3] - file in branch2 object name (or empty)
> >> + *   argv[4] - pathname in repository
> >> + *   argv[5] - original file mode (or empty)
> >> + *   argv[6] - file in branch1 mode (or empty)
> >> + *   argv[7] - file in branch2 mode (or empty)
> >> + *
> >> + * Handle some trivial cases. The _really_ trivial cases have been
> >> + * handled already by git read-tree, but that one doesn't do any mer=
ges
> >> + * that might change the tree layout.
> >> + */
> >> +
> >> +#include "cache.h"
> >> +#include "builtin.h"
> >> +#include "lockfile.h"
> >> +#include "merge-strategies.h"
> >> +
> >> +static const char builtin_merge_one_file_usage[] =3D
> >> +	"git merge-one-file <orig blob> <our blob> <their blob> <path> "
> >> +	"<orig mode> <our mode> <their mode>\n\n"
> >> +	"Blob ids and modes should be empty for missing files.";
> >> +
> >> +static int read_mode(const char *name, const char *arg, unsigned int=
 *mode)
> >> +{
> >> +	char *last;
> >> +	int ret =3D 0;
> >> +
> >> +	*mode =3D strtol(arg, &last, 8);
> >> +
> >> +	if (*last)
> >> +		ret =3D error(_("invalid '%s' mode: expected nothing, got '%c'"), =
name, *last);
> >> +	else if (!(S_ISREG(*mode) || S_ISDIR(*mode) || S_ISLNK(*mode)))
> >> +		ret =3D error(_("invalid '%s' mode: %o"), name, *mode);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +int cmd_merge_one_file(int argc, const char **argv, const char *pref=
ix)
> >> +{
> >> +	struct object_id orig_blob, our_blob, their_blob,
> >> +		*p_orig_blob =3D NULL, *p_our_blob =3D NULL, *p_their_blob =3D NUL=
L;
> >> +	unsigned int orig_mode =3D 0, our_mode =3D 0, their_mode =3D 0, ret=
 =3D 0;
> >> +	struct lock_file lock =3D LOCK_INIT;
> >> +	struct repository *r =3D the_repository;
> >> +
> >> +	if (argc !=3D 8)
> >> +		usage(builtin_merge_one_file_usage);
> >> +
> >> +	if (repo_read_index(r) < 0)
> >> +		die("invalid index");
> >> +
> >> +	repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
> >> +
> >> +	if (!get_oid_hex(argv[1], &orig_blob)) {
> >> +		p_orig_blob =3D &orig_blob;
> >> +		ret =3D read_mode("orig", argv[5], &orig_mode);
> >> +	} else if (!*argv[1] && *argv[5])
> >> +		ret =3D error(_("no 'orig' object id given, but a mode was still g=
iven."));
> >
> > Here, it looks as if the case of an empty `argv[1]` is not handled
> > _explicitly_, but we rely on `get_oid_hex()` to return non-zero, and t=
hen
> > we rely on the second arm _also_ not re-assigning `orig_blob`.
> >
> > I wonder whether this could be checked, and whether it would make sens=
e to
> > fold this, along with most of these 5 lines, into the `read_mode()` he=
lper
> > function (DRYing up the code even further).
> >
>
> Do you mean rewriting the first condition to read like this:
>
>     if (*argv[1] && !get_oid_hex(argv[1], &orig_blob)) {
>
> ?
>
> In which case yes, I can do that.

Yes, that's what I meant. Or this instead:

	if (!*argv[1]) {
		if (*argv[5])
			ret =3D error(... mode was still given ...)
	} else if (!get_oid_hex(...)) {
		...
	}

> BTW the two lasts calls to read_mode() should be like
>
>     err |=3D read_mode(=E2=80=A6);

While this is certainly shorter than

	if (read_mode(...))
		ret =3D -1;

I actually prefer the latter, for clarity (we do want `read_mode()` to be
called, i.e. we cannot use `||=3D` here, but it is also not a bit-wise "or=
"
operation, therefore `|=3D` strikes me as misleading). What do you think?

Ciao,
Dscho

--8323328-735098467-1616576867=:50--

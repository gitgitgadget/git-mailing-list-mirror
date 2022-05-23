Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A8EC433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 23:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiEWXlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 19:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiEWXlT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 19:41:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F68186D9
        for <git@vger.kernel.org>; Mon, 23 May 2022 16:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653349265;
        bh=8RqCI0YQV/0v+WGFj1X78DAxQl4LXvOWV7maEvGTOIw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=R9HuJXuBP+0eD+amXAZYeo9N5lLVf02QWwkSMnmUjj3AOdx8hxLD3wziFoLjKf+J6
         5iQZAWElRyUk0sYLF1qnMMLRjcmqpAhMR36MbRXXFFfW3GdH3Ry3KipC60KvjMGgZz
         lvrs+4ajdZ2vEEvEJ0oibQYLDDLF6cU6SkibX8xs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIdif-1o5g8q0HOX-00EeAg; Tue, 24
 May 2022 01:41:05 +0200
Date:   Tue, 24 May 2022 01:41:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH] http.c: clear the 'finished' member once we are done
 with it
In-Reply-To: <xmqqr14jluu4.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2205240124280.352@tvgsbejvaqbjf.bet>
References: <cover.1651859773.git.git@grubix.eu>        <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>        <xmqqtua2jtr0.fsf@gitster.g> <xmqqczgqjr8y.fsf_-_@gitster.g>        <nycvar.QRO.7.76.6.2205232248360.352@tvgsbejvaqbjf.bet>
 <xmqqr14jluu4.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:J56PLurjLWZI6WjjAEA1XNsWRAshVLw3alK88iwSXAeO+w2BzDw
 7Cm2SD7PpUihGB4lziE4x/tJEpWXfopqeE4lX7Dn+vxiQh4y1D6SVBuH8Zd3ldjAX/mO6vk
 OfPXQaxRqMNHDJoOYOy/T0UQlf4ZgBwRFHx9ty5tdWNZS1vvmI+V19ZF3Y2shMGhRMtVyER
 Bscm6BnPEC82WEkQ0QfRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7rFFOy0F/JQ=:IjwuaKGX0frzQzTppNW2+c
 YpdcPoVmlI42TZzjDnhHhSCpHGl0Uib8kID9Ctrl0vgt0SuNSYYqw0O3fQ+Nh4s5LjCWICyQS
 A3vWn4uh311FhRVERYuwQMH1tl38jA3uQDaZUyGc7HCzMs2FJLjPbEYOwUInrDjUKFqnkHJsx
 0Mb2Ey+UVfkTN4DWHJRiqXAvBLW1P0bRVCOxST83pd3egbLUv9RFQf9+Shoom1VmFLABJAq+X
 O13G9IeDQigaTh8FVWdNuOy2M6K73UgGXVV1YEx3ijS9OeuDzuuqrW/wg1YKoKPaySCXYuHzk
 fTX/ZlPjH8QP5neHdFUbnAys4ZtjWFZrZrNY+6lXcu2t8ALD7DCyHQS1HPCIvElAbET4dmHOK
 lut7vtwYJnkZnW+sgUNYdvEaVitHuyNgD2qumNBBHs+5Ydu0YizdEPmIzaPBBndQfEJh1PyHO
 xTSgenSedJv5zW1hEg/IsJqNuV6lx7QnZaVAvM8lujWU/uaPngMgNHEk98RVtW3nYu9Kyb6Zi
 LfC0AUEAFGg+2OPAZ46jMVOHrQ6MB2WVY5Ui2z8TrNd+MW3Ji8Ef7Fajx5W/NxgQhQBTLrGAn
 xryc8Oi9cAweMfA4/tbsfwcP02N8IDFTj0aQVwMqN7VEGM9cYqlIFotdzSRtuesg+f7ezZHK1
 5BPaByOZEJXBSPY94LL8aSfq6op4pzTC7nN9T6Xh7xo5sEmFl7sDoXURa1IE0c5fWm4ez9itt
 qXX/gomTi4rIVQhT7mDuw8Ml0Uy5cYW/56YvpnsiZa/y7HPpMvc5+HGmBKUCQ+6dN5CBR8Kw7
 JrpqI+vaLuDiTkP+O+RwZqPbDgqQmu9/UI4U/jTVqZ2vobQGmhp3o9O7e4f5yKDNCgD6o5Kvr
 9mlkahzAOj4G1F3ma+VBOpmpSq31prjDU+uMixwjo9vt74hdGiiHQPBZYaq56ZXmSHVVjQNNh
 gUIvn7t6OQLp+rSstvo32TRnyOp6+3miREP/0nPuU+KXVduZ3D03jW4DFSJk+HtqW/jWvooCP
 dBZZ7gNDDrzBl+ZjRmUschyNGUx/LAA67o1BqjhnoAag5Svpl45xrIhXKLopcUDrCW5H29CqR
 +DPfyoPzk6aVEUFbhZFdEnj/A5v8Dh7KljF9iHYTbsDvUVIQvNo5RThmw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 23 May 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > I stumbled over the need for this while investigating the build failur=
es
> > caused by upgrading Git for Windows' SDK's GCC to v12.x.
> >
> >> diff --git a/http.c b/http.c
> >> index 229da4d148..85437b1980 100644
> >> --- a/http.c
> >> +++ b/http.c
> >> @@ -1367,6 +1367,9 @@ void run_active_slot(struct active_request_slot=
 *slot)
> >>  			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
> >>  		}
> >>  	}
> >> +
> >> +	if (slot->finished =3D=3D &finished)
> >> +		slot->finished =3D NULL;
> >
> > First of all, I suspect that
> > https://github.com/git/git/blob/v2.36.1/http.c#L1207 makes sure that G=
CC's
> > complaint is not actually accurate: we always re-set `finished` to `NU=
LL`
> > when getting an unused slot, so even if there is a left-over dangling
> > pointer, it is not actually used, ever.
> >
> > But we need something to pacify GCC. Let's look at your patch.
> >
> > The first thing to note is that this is not _quite_ thread-safe: betwe=
en
>
> Does this part of the code ever run multi-threaded?

It calls into cURL, which I suspect has a multi-threaded mode of
operation, and we do use some callbacks in `http-walker.c` and I was
worried that these callbacks could be called via cURL calls. That's why I
am concerned about thread-safety. I have looked for a while and not found
any way that code in `http.c` or `http-walker.c` could set `finished` by
way of a cURL callback, but there is a lot of code there and I could have
missed something crucial.

> > If that analysis is correct, I would expect the correct solution to tu=
rn
> > `finished` into an attribute of the slot, and change its role to be a =
flag
> > that this slot is spoken for and cannot be re-used quite yet even if i=
t is
> > not currently in use.
>
> I have a feeling that we've mentioned that at least twice (perhaps
> three times) in the recent past that it is in essense reverting what
> the "finished" change baa7b67d (HTTP slot reuse fixes, 2006-03-10)
> did.  We used to use the in-use bit of the slot as an indicator that
> the slot dispatched by run_active_slot() has finished (i.e. the
> in-use bit must be cleared when the request held in the struct is
> fully done), but that broke when a slot we are looking at in
> run_active_slot() is serviced (which makes in_use false), and then
> another request reuses the slot (now no longer in_use), before the
> control comes back to the loop.  "while (slot->in_use)" at the
> beginning of the loop was still true, but the original request the
> slot was being used for, the one that the run_active_slot() function
> cares about, has completed.
>
> So...

No, I suggested to replace the `finished` variable with an attribute (or
"field" or "member variable") of the slot, and to respect it when looking
for an unused slot, i.e. not only look for a slot whose `in_use` is 0 but
also require `reserved_for_use` to be 0. In essence, the
`run_active_slot()` function owns the slot, even if it is not marked as
`in_use`. That should address the same concern as baa7b67d but without
using a pointer to a local variable.

Ciao,
Dscho

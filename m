Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3AEC433EF
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 09:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbiAVJF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 04:05:27 -0500
Received: from mout.gmx.net ([212.227.15.15]:59331 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233929AbiAVJF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 04:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642842318;
        bh=NdOSzTHtEOm9yLmFJG1znSpSJUi70J8+FPBR5KtTFJs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QdlWNs1byfWSmZr9PjlXV0bRJk7ShZRtlWUuK8B/CWJb75SVMrmyC0eyhPyF/W0m6
         /ZYNEebx3csiADWCW9jb+UB233Yct2a5OiDWTCHSVE4TCogXjri3mGazgOc1OIfSFU
         i3rNiB/NP5adwOVMI1h3VrOm//fbW7rNapxlM//Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.174.184] ([89.1.213.181]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9Wys-1nGieA1nM4-005VjW; Sat, 22
 Jan 2022 10:05:18 +0100
Date:   Sat, 22 Jan 2022 10:05:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 0/2] builtin add -p: fix hunk splitting
In-Reply-To: <47e7b23a-56a3-b533-63ed-a854503b59ed@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201220938360.2121@tvgsbejvaqbjf.bet>
References: <pull.1100.git.1640010777.gitgitgadget@gmail.com> <pull.1100.v2.git.1641899530.gitgitgadget@gmail.com> <220111.861r1ezcxn.gmgdl@evledraar.gmail.com> <348d37a3-f01b-cda6-8ce4-1536e0bd3b06@gmail.com> <xmqqv8yovlc2.fsf@gitster.g>
 <47e7b23a-56a3-b533-63ed-a854503b59ed@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kdY1heU+bllsB1swWfm26zAsWp2iO0iomtBgItHj8fxA7e1hGGT
 0oqTDkknhC822BGpg0vIXN+tnfYrvrBK7dr56I974bJSGZV9h+MvOBGLFI3RbgX2KUS9b0x
 9xPWZleoUEPdSQApRNNPbXYAESbtrJr5YmLtdqZBSo44srMvYuzbcBeGfC5SrCM9vpgwN1A
 fv3pR8BNykfwMuqhf6dMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o3GfXJjKmCo=:gZnUXxixILwOzwHnK3Pb9w
 4BPOx/j8V/HH/RqfgwFt1oHrBlBNkosG5ze9Sa39E6sDlIMHiAMmJPsRB9Za7js9S+K+HDe+r
 6YcmKnci8VzhBbo6CYP7ExLIUO7rbcUhTWY3R1VC+Pzf3m8mTLqU/9rq5C/9tAYKUzSWr4srW
 sgzdBw+E2wqoECZ/ollLMyv2xQHWlBfJFkIOtPcx8w79eXSRc5whqbMGpxljURLU00oKxE9J5
 /kFt4uPcWSDV7A56LjWpQjD8XTS5v1EfKZ965f+ERTdA/yroH9y/MQB3/Cy3EEDIr37Lt9yrF
 wQoaFOjlXFYpFj7BmGWzrDKY5q0J4S6x/yrTnfkjuaG+PKJhzkIzqKqc38cxjsKFLbC4oleas
 BJ4POfeMEAeCht7b01CDcd7ECZeN5xOlf+7xTZzPx6dIQvsjQmVi6I7ZXyY6qjvR8engH9j4F
 l4SuyEoJHc5gtYcuvkcebbKdtplzeP+Fp4Sx2NKdVjZktorYAhMj0tiP67vFJkZXDEqamW1GQ
 J9htjQa0EDoM/XvhUnGeIHQT4SicDa/biZDB/CoidW7I6pkq0FuobXF6A1/ZEsSF5q5S/6B6T
 XOMAmZkvfzLeiAx/k+cSV8B45JJizwFXH+g5y5O/PCSQ2bTl3lgsasOzJr7Xn800Nf3yNh/hH
 IhpfugLwn6HAMTabobgmHtCUFVQRwKPT+OLE31ScOLLvafn75uLBzAFdVi0cZQNn+u7Tpm0Q+
 o5QIWALOP22iGNceqI1FpwiaQi133SJ1QgFohoQ5+CmU+Ztr2yfOh+WuR5Sqg1AW8RIqCH0BM
 ui85H0EwVS4d8oeBnM8586NtVbW7wC0acAGue5uFVRefgKAcQg63vq62Hw7JDeZM3EDl6cKxz
 ej+9XaINn2k9BKxfzAebmV4vnELkWnAffc/bVQPmYpz1ZBhKFX0icWEUryQva8YAnkhwvXZz1
 TQ4n0L+eLv3zelsreAVhiCmw0mei1lSAAmyHWkDLLISn1nbRuG3nlttN35WaThM0sE7AeO7Gb
 ZLBMsy4Vz5z22MTHX77E85s80Ifa8VxRyr2i0cBE2vUQWfhj9GHd19TycRE3qh3Wcs0axSuW1
 /p8JyoWL1Tq7Zs=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

first of all: thank you for these patches. I read over them and they have
my ACK.

On Wed, 19 Jan 2022, Phillip Wood wrote:

> On 12/01/2022 18:51, Junio C Hamano wrote:
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> >
> > > I'm not sure I want to go with your extra changes. I've left some
> > > comments on them below
> > >
> > > > @@ -488,12 +499,12 @@ static int parse_diff(struct add_p_state *s,=
 const
> > > > struct pathspec *ps)
> > > >    else if (starts_with(p, "@@ ") ||
> > > >      (hunk =3D=3D &file_diff->head &&
> > > >   		  (skip_prefix(p, "deleted file", &deleted)))) {
> > > > -		if (marker =3D=3D '-' || marker =3D=3D '+')
> > > > -			/*
> > > > -			 * Should not happen; previous hunk did not end
> > > > -			 * in a context line? Handle it anyway.
> > > > -			 */
> > > > +			hunk->splittable_into++;
> > > > +		/*
> > > > +		 * Should not increment "splittable_into";
> > > > +		 * previous hunk did not end in a context
> > > > +		 * line? Handle it anyway.
> > > > +		 */
> > > > +		complete_file(marker, &hunk->splittable_into);
> > > >      ALLOC_GROW_BY(file_diff->hunk, file_diff->hunk_nr, 1,
> > > >         file_diff->hunk_alloc);
> > >
> > > I deliberately left this alone as I think we should probably make
> > > this BUG() out instead of silently accepting an invalid diff.

FWIW this was overzealous defensive programming on my part. More on that
below.

> > As we are reading our own output, I agree that such a data error is
> > a BUG().

Indeed. I was less worried about the output format changing, and more
concerned with bugs in my parser ;-)

Although, having said that, I had meant to verify that `git add -p` cannot
be asked to produce and consume diffs with `-U0` when I wrote that
comment. Now I did that, and I am now confident that there is no way to as=
k
`git add -p` to generate and use context line-free diffs: we neither add
`-U<n>` in https://github.com/git/git/blob/v2.34.1/add-patch.c#L398-L417
nor do we call the user-facing `git diff` command that would interpret
`diff.context`, but instead we use `git diff-index` and `git diff-files`
(which ignore that config setting).

> > In any case, a helper to see if the file ended without post-context
> > is one thing, and a helper that specify what happens after we are
> > done with a single file, before we move on top the next file or
> > after processing the last file, is another thing.  The latter may be
> > able to make use of the former, but the latter may want to do more
> > than that in the future.

If you are concerned about the name of the function: maybe a better name
would be `maybe_increment_splittable_hunk_count(marker)`.

> >
> > As complete_file() is about finalizing the processing we have done
> > to the current file, it should be used for that purpose, and nothing
> > else, I think the hunk I see at
> > https://github.com/git/git/commit/c082176f8c5a1fc1c8b2a93991ca28fd63aa=
e73a
> > (reproduced below) is simply a nonsense.
> >
> > Stepping back a bit, though, is this helper really finalizing the
> > current file, or is it finalizing the current hunk?  If it were the
> > latter, then its use in the hunk I called "nonsense" above actually
> > makes perfect sense.
>
> Even if the helper is finalizing the current hunk then I think that "non=
sense"
> hunk would still wrong as it would be calling finalize_hunk() on _every_
> context line in the hunk rather than just being called once to finalize =
the
> hunk. We could call the function something like update_splittable() but =
then
> we'd need to explain why we were calling that function at the start of a=
 diff
> and at the end of the loop.

Right. The point of this check is to see whether we missed counting a
splittable hunk. Then it makes more sense to call it at the beginning of a
file, at the end of a file _and_ at a context line.

Having said all that, I am really fine with what landed in `next`.

Thank you,
Dscho

Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB70D332EA1
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760701471; cv=none; b=Enf405EWj7wmB1GwT0QdX9mIeDzQFLCfF3MTYieE0+l2Y6l0MJG9bFOIT8usLRBbpYoi5AI+Ihc9HX+wpwrRut9bCbadsXLBKNm6aQUT+hz07P2HyhMUyPr3NfjH3eXAXEVGG4gacnv1LhJQy/IUAh8qE9HYzXoZr9Ki1xS/dQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760701471; c=relaxed/simple;
	bh=TKSoOzSEv+dN2WHhowKYWyK7r2Xr1vvQO1RaiIDHF20=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f+ImdOXEjHX2RfS150k/rHLvHDaSqeNGgVsciGNxheec/IovKH5lHMqI8tIVSmoAc42/c49lNjPV61GwmST+8qmsIFPO/39L4/PkojrDF6QcHdYoLGOyN+8BtxF2gl61LA5nX/h0sqQX+73dtFo1+O5u3z9IBLfzynM5SYqUXko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=XtKykpEh; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="XtKykpEh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1760701456; x=1761306256;
	i=johannes.schindelin@gmx.de;
	bh=x7lAVckbKwp/ZujkkVRSiwPAY6rOR2eYOZrblVQxAK4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XtKykpEh634QjLAR9RfFfvOK6Sgb1TF9lzX7VJHB9t66X6yX8xylcYlwB40gKcYP
	 c/5d8MFEnTBbWkXwjiezs7L+zZVQNwdKOKbmDmqPNODsTHoGLqPaQqd6oRkEKmx0/
	 jyZzxMIODt9v9vzqwz6eqDlOjej2aHHxEDvRDZswRZiOyDqt4kuBnWni4OVb68BzU
	 aZXiroOS1Mb3Sr3jjyrJDPtzVcTTYatPC9V8OHgbBg2HxS9IQL00kX9f6ZXZzo2L3
	 CbcGU//LSZ6mh/g4cGdnkutYC5eSwbKAtvye0XrxMyOfPeOJfe8z2vnnolQuloo8O
	 1qdOPk4nER4SRuy1bQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.131]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Msq24-1uLKBL3HJ2-015zo0; Fri, 17
 Oct 2025 13:44:15 +0200
Date: Fri, 17 Oct 2025 13:44:13 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
cc: Jake Zimmerman <jake@zimmerman.io>, Lidong Yan <yldhome2d2@gmail.com>, 
    Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Regression in `git diff --quiet HEAD` when a new file is
 staged
In-Reply-To: <20251017075153.GA4078773@coredump.intra.peff.net>
Message-ID: <06a127d0-9c4b-6ee3-4e37-1ff768e5f39a@gmx.de>
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com> <20251017075153.GA4078773@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FAF02KWGcFA59heviP1zHeZrssUZsqLkK+BQlslp4aha53a0SAg
 u6Y7iIrUqICVLWNIFusSG3OPpvXe7Qtr1jwJUNdufZ9SsInfkntZTuG+5ipYGJ4CfABq5Mh
 mtL7EiuI/LS/1qSic99gu10IodGcxp0gMwJ+rlajJb8TAXmFcoU/Ci0sWAUZgX7f9qjnQvY
 X+BCsmQ0HBIXOTU/Zi04A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:D8jNujSvt94=;J+azXUVyZKo33eb+QL49dxWNlFD
 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
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Fri, 17 Oct 2025, Jeff King wrote:

> On Thu, Oct 16, 2025 at 05:09:07PM -0700, Jake Zimmerman wrote:
>=20
> > In git v2.51.1, `git diff --quiet HEAD` will actually print something
> > if the diff output includes a new, staged file.
> > [...]
> > I ran a git bisect and isolated this commit:
> > b55e6d36ebce69136559add8fffd1a65df231518
>=20
> Yikes, that is a pretty bad regression. I'm rather surprised that this
> wasn't covered in the test suite. t4035 does set this situation up, but
> it checks with git-diff-tree, not git-diff. I initially thought that was
> because diff defaults to "--patch" output and diff-tree does not, but
> even "diff-tree --patch" does not show the bug. Weird. Maybe it has to
> do with running diffcore bits?
>=20
> I see that the author of b55e6d36eb (diff: ensure consistent diff
> behavior with ignore options, 2025-08-08) posted this patch earlier
> today:
>=20
>   https://lore.kernel.org/git/pull.2071.git.git.1760671049113.gitgitgadg=
et@gmail.com/
>=20
> which seems to fix it, but there's no mention there of this thread.

The fix predates the thread, that's why.

The reason why it "seems to fix it" is this: The `git diff --quiet HEAD`
call enters this code block
(https://github.com/git-for-windows/git/blob/rebase-to-v2.51.1/diff.c#L687=
6-L6886):

```c
	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
	    options->flags.exit_with_status &&
	    options->flags.diff_from_contents) {
		for (i =3D 0; i < q->nr; i++) {
			struct diff_filepair *p =3D q->queue[i];
			if (check_pair_status(p))
				diff_flush_patch_quietly(p, options);
			if (options->found_changes)
				break;
		}
	}
```

Specifically, the `diff_flush_patch_quietly()` function is called, which s=
ets the `dry_run` flag. Later on, the `emit_diff_symbol_from_struct()` fun=
ction is entered. Here is the call stack:

```
#0  emit_diff_symbol_from_struct (o=3D0x5ff480, eds=3D0x5fe910) at diff.c:=
1355
#1  0x00007ff7c3b275fe in emit_diff_symbol (o=3D0x5ff480, s=3DDIFF_SYMBOL_=
HEADER,
    line=3D0x3561a010380 "\033[1mdiff --git a/file b/file\033[m\n\033[1mne=
w file mode 100644\033[m\n\033[1mindex 0000000..e69de29\033[m\n", len=3D90=
, flags=3D0) at diff.c:1597
#2  0x00007ff7c3b2d602 in builtin_diff (name_a=3D0x3561a0702a0 "file", nam=
e_b=3D0x3561a0702a0 "file", one=3D0x3561a070240,
    two=3D0x3561a0702b0, xfrm_msg=3D0x3561a1a0500 "\033[1mindex 0000000..e=
69de29\033[m\n", must_show_header=3D1, o=3D0x5ff480,
    complete_rewrite=3D0) at diff.c:3723
#3  0x00007ff7c3b2fdc6 in run_diff_cmd (pgm=3D0x0, name=3D0x3561a0702a0 "f=
ile", other=3D0x0, attr_path=3D0x3561a0702a0 "file",
    one=3D0x3561a070240, two=3D0x3561a0702b0, msg=3D0x5febf0, o=3D0x5ff480=
, p=3D0x3561a0220c0) at diff.c:4617
#4  0x00007ff7c3b302af in run_diff (p=3D0x3561a0220c0, o=3D0x5ff480) at di=
ff.c:4711
#5  0x00007ff7c3b353b0 in diff_flush_patch (p=3D0x3561a0220c0, o=3D0x5ff48=
0) at diff.c:6172
#6  0x00007ff7c3b35413 in diff_flush_patch_quietly (p=3D0x3561a0220c0, o=
=3D0x5ff480) at diff.c:6184
#7  0x00007ff7c3b372ec in diff_flush (options=3D0x5ff480) at diff.c:6882
#8  0x00007ff7c3b2134f in run_diff_index (revs=3D0x5feed0, option=3D0) at =
diff-lib.c:643
#9  0x00007ff7c39d8427 in builtin_diff_index (revs=3D0x5feed0, argc=3D1, a=
rgv=3D0x3561a0202a0) at builtin/diff.c:170
#10 0x00007ff7c39d9487 in cmd_diff (argc=3D1, argv=3D0x3561a0202a0, prefix=
=3D0x0, repo=3D0x0) at builtin/diff.c:633
#11 0x00007ff7c39932f0 in run_builtin (p=3D0x7ff7c3d46368 <commands+840>, =
argc=3D3, argv=3D0x3561a0202a0,
    repo=3D0x7ff7c3e742c0 <the_repo>) at git.c:506
#12 0x00007ff7c3993849 in handle_builtin (args=3D0x5ffd70) at git.c:778
#13 0x00007ff7c3993b04 in run_argv (args=3D0x5ffd70) at git.c:861
#14 0x00007ff7c3993f56 in cmd_main (argc=3D3, argv=3D0x3561a0300e0) at git=
.c:983
#15 0x00007ff7c3ab0a7e in main (argc=3D7, argv=3D0x3561a0300c0) at common-=
main.c:9
```

The `if (o->dry_run) return;` guard introduced in the fix from
https://lore.kernel.org/git/pull.2071.git.git.1760671049113.gitgitgadget@g=
mail.com/
will then suppress the output, as desired.

> Looking at that patch, my biggest concern is: are we missing other spots
> that need to special-case the dry_run setting?

That's an excellent concern to have, seeing as bugs love like company.

A comparatively deeper analysis shows that the `o->file` attribute is used
in these functions that are not guarded by the early return introduced in
the proposed fix:

- show_numstat()
- gather_dirstat()
- checkdiff_consume()
- builtin_checkdiff()
- run_diff_cmd() (unmerged paths)
- diff_flush_raw()
- flush_one_pair() (DIFF_FORMAT_NAME)

Of these, I think the only concerning one is the one in `run_diff_cmd()`.

Ciao,
Johannes

Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDCC315D46
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772763635; cv=none; b=gbSadNqZweqTFSylWdFZjkMEVxvRypDHYTwp8YBJuT9+dQuC3FgFBcKMEUeaQqBaETdZqnP/mflUwVmyu6ESlR4NYmFTbGT1zerAyqW8O4jgeSx3Px0RXYcZST5Vm81CaTKKPm3Hs+ijcMMldNfhCS1QrkqtmQfJ/N/W7ApL6+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772763635; c=relaxed/simple;
	bh=PfCP1Aqo4cspQGMDRE4bYQH4Vt0ce0TIWAqAdBgyVEY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TiSYecktXh2hH+Zi4cLRmbVcV4Mq+SBcQe351AOFj/7pjuAyzs/r9kuNU0QCQF1B7/zBuvu0FqPD7N7EXOYdj+7iEvxBoYvApRwFtGW6oMf7ksoan49aCxgQbBu5I9/tf2MKQjvSRoviP5xPyth3V79rz/zb/tOUlGkyuU4XZZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=qLGfRDmi; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="qLGfRDmi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1772763631; x=1773022831;
	bh=PfCP1Aqo4cspQGMDRE4bYQH4Vt0ce0TIWAqAdBgyVEY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=qLGfRDmiGucp17BMB52jp5wszotgQVR2UGS1DIblVeUMuZ/A7rE4mQE4Z/cow6RAE
	 XssExBYmTefbk7rBuug5Cmlmos00fMGWghrxtN/qDQET12nkxRJpHoLFk+U2ELo9Tg
	 KWeOEvSVZv0Cd/0fMH3stwxlbh4ICFs/vn7gVxA99EjevdmwN6XPniab8cKNAHzRkQ
	 E2NuikpkLCb77H4XhbfnSq8YSliNyoLUNcIESojqdgCpb7dQeZNMzOPlvP5w5hkvoi
	 4Z10BKsNOl35kSAKPoQ/6u4L5a182Uet1CWTFlPQyHXRXkuK6/LQEkMIVJq1/Gmcn8
	 2obAvmZAgodEw==
Date: Fri, 06 Mar 2026 02:20:25 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Chandra <Chandrakr@pm.me>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5] add: support pre-add hook
Message-ID: <Mas-XsZDLQf822y8cXTnllJLDJcd9vU8jRd7i4tj-7pCw90hurfkTos1piH-zF-g9A-IPM2sIZoXac1MB2yHn9oU-nX9kaLeuI9bXWp3Fbw=@pm.me>
In-Reply-To: <xmqqwlzq2i96.fsf@gitster.g>
References: <pull.2045.v4.git.1772710566599.gitgitgadget@gmail.com> <pull.2045.v5.git.1772714253412.gitgitgadget@gmail.com> <87o6l2xuku.fsf@collabora.com> <xmqqwlzq2i96.fsf@gitster.g>
Feedback-ID: 10057713:user:proton
X-Pm-Message-ID: e698c07c0edf220140866bb213218660757098b4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks all for the thorough review. I took some time to sit with the feedba=
ck and review how pre-commit and pre-push handles these cases.

Phillip Wood <phillip.wood123@gmail.com> writes:

> git-commit.adoc has a seperate section for HOOKS
> It would be clearer to say that the proposed changes are rejected

Agreed. I can add that.

> I'm struggling to see how it is helpful to the user for "git add
> --dry-run $path" to succeed when "git add $path" will be rejected

The --dry-run on commit also skips the pre-commit hook (builtin/commit.c re=
turns early at the dry_run check before run_commit_hook is reached). Pre-ad=
d follows the same convention. As I understand it, --dry-run answers what w=
ould be staged without side effects, including hooks.

I can see the argument for running the hook during --dry-run so users can p=
review rejections. After all, git push --dry-run runs the pre-push hook. If=
 the consensus is that pre-add should diverge from pre-commit here and foll=
ow pre-push, I'm happy to add that, but I think it would be better for cons=
istent --dry-run hooking to be a separate patch series applied to both add =
and commit.

> The other options all use "git apply" to apply a diff to the index
> so they could apply the patch to a temporary index which is then
> passed to the "pre-add" hook. If the hook fails the user should be
> given the option to re-edit the patch or re-select the hunks so
> that their work is not wasted.

pre-commit has the same gap as `git commit --interactive` and `git commit -=
-patch` run interactive staging and then the pre-commit hook runs on the re=
sult. If the hook rejects, the user's interactive selections are lost with =
no re-edit prompt.

I think it's a good idea to add retry/re-edit UX for --interactive and --pa=
tch, but it would be new behavior. IMO, it makes sense to keep v1 of pre-ad=
d consistent with how pre-commit works today, and do a follow-up series for=
 re-edit support in both hooks.

> To me this hook would be much more useful if it also checked
> changes staged by "git commit"

This is essentially asking pre-add to become a universal pre-staging hook, =
which I was fully in favor of earlier in this conversation. However, that i=
s a much larger scope than intended for this patch series, as each of the g=
it commit staging integrations have their own codepaths in prepare_index().=
 The pre-commit hook already covers the commit-time check, and the default =
pre-applypatch hook runs pre-commit for the same reason. I'm open to these =
changes, but I don't think it makes sense within the scope of this patch se=
ries.

> Calling it a lockfile is rather confusing

While it is literally the file created by the lock_file API, I can see the =
point that hook authors may not care about the locking mechanism more than =
they care that it's the proposed index.=20

> If we don't enforce them being read-only people will write hooks
> that update them just as they do for "pre-commit" hooks.

True, while the documentation says it should be treated as read-only, there=
's no enforcement here. On the other hand, if users are doing this for pre-=
commit, maybe it's better they're not read-only because there are use cases=
 for that affordance? I'm not sure about whether to actually force it to be=
 read-only or to allow users to do what they do with pre-commit hooks.

> We should be explicit that the proposed index state contains all
> the changes that would be committed so staging changes
> incrementally will check them multiple times.

Yes.=20

> I would be more accurate to say that it is not invoked by=20
> `git commit` at all

Also yes.

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Maybe add a test or two which define the pre-add hook via configs

I see now that what I thought was a redundant codepath test earlier was act=
ually not.

The hook.<name>.event / hook.<name>.command config infrastructure is in `ne=
xt` but hasn't graduated to `master` yet. I'll write that test once ar/conf=
ig-hooks lands in `master` but I'm sure functionally it will work because o=
f the switch you suggested from find_hook() to hook_exists().=20

> The turnaround in minutes between v4 -> v5 is also surprising.

Understood. I can wait for more review feedback before sending new updates.=
=20

I will note that I personally handtype every line of test, code, and docs t=
hat I commit although I use Claude and Codex for assistance and recommendat=
ions. They have been invaluable aids since this is my first contribution an=
d I don't have extensive experience with git internals. I'm sure I make mis=
takes due to being a neophyte here (and frankly I wouldn't claim C or shell=
 in the top 5 languages I'm skilled/experienced with). I believe AI Disclos=
ure is an ethical requirement, particularly in an open-source code base lik=
e this, in spite of reputational risks. If it induces reviewers to be more =
stringent, that is good, because it reduces the likelihood of mistakes pass=
ing through.

I am grateful for everyone's feedback. I believe this change is needed and =
will help a lot of users (including myself) who currently use weird workaro=
unds like aliases to shell scripts. Pushback is essential for quality and s=
urfacing opportunities for improvement. Thank you for the time spent review=
ing these changes.

Chandra Kethi-Reddy
@archonphronesis:matrix.org

Sent with Proton Mail secure email.


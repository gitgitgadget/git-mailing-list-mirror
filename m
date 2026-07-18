Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D935128BAB9
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784364757; cv=none; b=VwxYbSjstluMm41H0XUzYoR1MSIRtsR1AnQaeNYuEgoumQon0HPTIGVfVoAkszp0eMXDn5hyrgiYnHhHoIZjqAvFCMDXk891KX0F27ij5/wF3xxccBpmCLFSpRUtOyqGR4+lYuN7LMJ+3nnAtV43wZS85V0UJZHhWoRn1uZwo3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784364757; c=relaxed/simple;
	bh=KoivnmfQWSf3dhQSUAmEgWGP1cMK+sAW6Mt1nQja/HQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=J1zhjkEN6tinIKAfjaZychyY4sDe2AYZC83JhwRgjvHuCcffGCZrgvk/Hp7RRJgO3HTWUsqO7zww5XMSEKzsZIEmhsYUUm2ze5ayVcEZO5JM9emjLUSXAUgmPw00nst8ALz25Y0E5WNemEMrGy7aLLIPnHFTTXY6OqT6N/luyGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=UQ+KZT2u; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="UQ+KZT2u"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 19DEE60E1F;
	Sat, 18 Jul 2026 08:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1784364749; bh=KoivnmfQWSf3dhQSUAmEgWGP1cMK+sAW6Mt1nQja/HQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=UQ+KZT2u6gM+P07IiDpaC1t2nhiq7BZyL16K64Sw8dDnFCcQACfQyhcJHwgZkeIhR
	 bZcmdUDEqJr8SFDgHSGIaWsCWaU2rjWDX7EtPDFcMXJAaqDhHD3zaLleeuO6VXk3O6
	 vQWdV+HPcXHsbUAEH2B2Q40Y30kd/SpEMmbjBje8=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Jul 2026 04:52:28 -0400
Message-Id: <DK1KIH6CXW0X.1U2V3GU8L6HB7@lfurio.us>
Subject: Re: [PATCH v9 5/5] history: re-edit a squash with every message
Cc: "Phillip Wood" <phillip.wood123@gmail.com>, "D. Ben Knoble"
 <ben.knoble@gmail.com>, "Patrick Steinhardt" <ps@pks.im>, "Harald Nordgren"
 <haraldnordgren@gmail.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>,
 <git@vger.kernel.org>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <pull.2337.v8.git.git.1783674396.gitgitgadget@gmail.com>
 <pull.2337.v9.git.git.1784128573.gitgitgadget@gmail.com>
 <fb76afe31c98833582d2b6be764fa3a1c8b71bbe.1784128573.git.gitgitgadget@gmail.com>
In-Reply-To: <fb76afe31c98833582d2b6be764fa3a1c8b71bbe.1784128573.git.gitgitgadget@gmail.com>

On Wed Jul 15, 2026 at 11:16 AM EDT, Harald Nordgren via GitGitGadget wrote=
:
> @@ -130,6 +131,15 @@ marker meant for a commit outside it. The body after=
 an `amend!` subject
>  replaces the oldest commit's message when the marker targets that commit=
. As
>  an exception, a range made up entirely of markers for one target is comb=
ined
>  into a single commit, keeping the last `amend!` message if there is one.

> +The changes from every commit in the range are always folded in. Only th=
e
> +message text differs.

This sentence kept puzzling me when I re-read this part.  That isn't to
say that it doesn't make sense on its own, or isn't correct.  But in
this context, I wasn't sure why it was included.

For whatever reason, the diff from your v8 made it click, and I believe
you're trying to explain the previous sentence about the last `amend!`,
stating that all the other _effects_ of the other fixup!s are also kept
even though the message changes.  Is that right?

If so, I might suggest removing this sentence too.  At least to my
brain, it doesn't contribute to my understanding of the command, and
makes the paragraph feel like it changes subject in the middle.

> +With `--reedit-message` the template mirrors `git rebase -i --autosquash=
`:
> +each `fixup!`, `squash!`, or `amend!` is grouped under the commit it
> +targets rather than shown in commit order. A `fixup!` message is dropped
> +(commented out in full), a `squash!` keeps its body with only the marker
> +subject commented, and an `amend!` replaces its target's message, unless
> +a `squash!` folded into that target first, in which case it keeps its
> +body like a `squash!`.

This bit that comes right after would possibly do better as its own
paragraph imo.

Thanks!

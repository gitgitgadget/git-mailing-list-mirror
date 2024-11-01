Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835C819BBC
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467123; cv=none; b=dQdD8kkRgsji9N5uS8LBNhUjBVhEx2On4aMhxDJM0i0aHsQLrrXwYiX5j6juLlqzY1WGGPq7z92V/BUs+golhy6yC5mTHx4IBK+tLo/aPu4QjtkrCbN1Frr8mqIwVTQ7dI2gdlRkQNA56+5iSj/XwJW4B5+BUskLZsy20xDVPGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467123; c=relaxed/simple;
	bh=lA8L5Zb2XWJu0IwvSsG9YH3DIkfyj6x+k+t13CN5uqQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Df0icimVqpLjl4EjMsl1iv/nTlk7UWtXXtyL4WWNBomKeibZMgOuz7P3wYtyIkO2FlYHTG72OjAT+N6c+pVTmZhAi6n5/L709lwIg7iI3HEtp/wcqhLJ0APYsM13knDVNtctyR1renhBbLTl28k5QuvIXETYAwRHgcniExCIv8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=BuAh+RF+; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="BuAh+RF+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730467112; x=1730726312;
	bh=NXnqyBBjQLqLfbxuJOr5U2mK1ZdUgLNzEzH9BNReBkA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BuAh+RF+u5Hd8pfDpVi2stxCV84O/At7y240Gwd25I/tGyCtOPRpEyFteZpZnt1Si
	 BHMeRj6tx3uDDuyTuVWdXaWLCA2bj/NXyeTEmvNzprRtblpnwrZzYVKfu0lc9+zhmD
	 jGBwSaiBvm8EOhjYOAuhOcFjghrqBmv4J3WjXpunXZZ5WgHZw/ITsusiuz4CrrjayX
	 tvv4hAQmZ0FNoxH9AzcY01XEZH4VUPWUdWVFfi4VsdIWPAuLpQJRnQ/GMfWSRSIbVT
	 6uAXmOBptLRYqOFLWGX1moOMkgpIMys4gqHEdRwrbgwMWwlrQfB/sSsVyUZ6Du9VS0
	 qhn0CCH3ZI7vQ==
Date: Fri, 01 Nov 2024 13:18:28 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 0/8] Allow relative worktree linking to be configured by the user
Message-ID: <D5AVE5JXJ2AE.29R7FKWCHWIKQ@pm.me>
In-Reply-To: <xmqqzfmj2zp9.fsf@gitster.g>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> <xmqqzfmj2zp9.fsf@gitster.g>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 7c4250dd6dfb1d935cf721ee994ef9dd35ef6f49
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Nov 1, 2024 at 2:14 AM CDT, Junio C Hamano wrote:
> Caleb White <cdwhite3@pm.me> writes:
>
>> The base for this patch series is obtained by applying the following
>> patch onto 6a11438f43:
>> - cw/config-extensions topic (doc: consolidate extensions in git-config
>>   documentation, 2024-10-22, <20241021-cleanup-extension-docs-v1-1-ab02c=
ece3132@pm.me>)
>
> I am slowing getting back to speed, but with the above I noticed two
> things.

Welcome back! I hope you had a good break :).

>  - Do not encourage people to _apply_ random patches before your
>    series when the official tree has the same patches.  In this
>    case, you even know the branch the official tree uses
>    (i.e. cw/config-extensions), so tell readers to _merge_ the
>    topic before applying your series instead.

Ah, my apologies. I will make sure to do that in the future. When
I first added this note, a topic branch[1] had not been created yet and
I forgot to update it when it was.

>  - The notes/amlog I snarfed from the broken-out repository of
>    Taylor does not seem to record the message ID
>    <20241021-cleanup-extension-docs-v1-1-ab02cece3132@pm.me> Perhaps
>    I was looking at a wrong repository?

Hmm, I'm not sure. Here's the latest update in the What's Cooking report:

    * cw/config-extensions (2024-10-22) 1 commit
     (merged to 'next' on 2024-10-30 at 875fa0b619)
     + doc: consolidate extensions in git-config documentation
     (this branch is used by cw/worktree-extension.)

     Centralize documentation for repository extensions into a single place=
.

     Will merge to 'master'?
     source: <20241021-cleanup-extension-docs-v1-1-ab02cece3132@pm.me>

Best,

[1]: https://github.com/ttaylorr/git/tree/cw/config-extensions


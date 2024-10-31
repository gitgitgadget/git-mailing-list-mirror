Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512EA1CB52F
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730404372; cv=none; b=STyZNv9B4hDWKtSi04obvYsGD3/1vKm1ctnWXIclt++FkpG6NBe+mG3mEHct3OcCqKDkh1AI+B7i1aoAI5af2+Kf4hMtGFAuh251p37JYoQRmuyMiXMxJ9ofl+TmsZXn+JbRiJ7+6EhVDtggOFMjLncH0FiBbOjKWL2oC9p9wZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730404372; c=relaxed/simple;
	bh=+eTiwv0reyjOMLy13P/6JrdXFZkgESqq8LlUPzX1z/Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMeev9Jua/NiQvVXMhwi9vjHhkQtwliG8Gbl0bdjfuU8bWlqIkfEU8nupNs6DtI/N+q4S6LNH70qZZ79aqYOgOaRbnQss+rj2azRduDl0Kr+h/UJYLynkbjjehufKFUuyHd/WOr6ddWBsCuob8D5neSGAR0B8gTcb0pzyE+0u6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ZJEWs2gr; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ZJEWs2gr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730404368; x=1730663568;
	bh=DxIp+vo7jAq6+w3bgeE1FcqRzH8TD4oVt2UZA44sA6w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZJEWs2gr+aUNk618yke5e8BoWGka8aecvUOyo7FZs/Klk0nq536+m8fGtF9bOl4sq
	 U+iGgcfoVljE4oModiNwD5YsV+6i/gZUlAADOCy7XyLzjlZ7GCYmsUTnqNwesA2r7i
	 XSBeSsPTMCu1rA7dR1EsZyCDrZOQLIlHEaqxcZvfxPHOxRTBhWvX/hIdW4F1d52ggV
	 ctdhfwpvlPVNp5TN9OX69a8z5cAyEQkCBExIZg0LbwegOLV/VtoJDhWLIyO6pP6atB
	 Q0WbB/oSxbTcReqVqvOUDR4LpzPbWQznfks2gk8Dxs8HLCI4iaUQTMm24fQulz3UkZ
	 xiOHHcVoSB/wA==
Date: Thu, 31 Oct 2024 19:52:46 +0000
To: Taylor Blau <me@ttaylorr.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/8] Allow relative worktree linking to be configured by the user
Message-ID: <D5A95I1T5FZ6.60QJMN704514@pm.me>
In-Reply-To: <ZyPYiffYRDK/4LdG@nand.local>
References: <20241031-wt_relative_options-v3-0-3e44ccdf64e6@pm.me> <ZyPYiffYRDK/4LdG@nand.local>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: ccdc5b2f9bda74ecda354d2b939e18f5ebe646d1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Oct 31, 2024 at 2:20 PM CDT, Taylor Blau wrote:
> This version of the topic, as well as the previous round, appear to
> break CI:
>
>     https://github.com/ttaylorr/git/actions/runs/11602969587
>
> An easy reproduction locally is to run t/t5504-fetch-receive-strict.sh
> when built with 'make SANITIZE=3Dleak' and run with
> 'GIT_TEST_DEFAULT_REF_FORMAT=3Dreftable'.
>
> I'm going to kick this topic out of jch for the time being as it breaks
> CI, but please do send another round once you have fixed the issue. In
> the future, please verify that your series does not break CI before
> sending it to the list. Thanks.

My apologies, I executed

    make -j12
    cd t
    prove -j12 t[0-9]*.sh

(as recommended by t/readme) and everything passed. I did not know I
needed to run the tests with other environment variables set.

Best,


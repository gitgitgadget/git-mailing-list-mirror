Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AF617545
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722008008; cv=none; b=c0jfcqJkIXyMTWjHaHfil7PrxjxU44Ix3gdQQRSzVn5C6iKzXykZRj0yiGAlbZ986pjLvZnsvE3dIra4HIASncfR8k3twYXQxnKzXAA/0u57PtRICMMptiQvBV9BSZ2w6Os6ChBtIuFHRZ8tNyZP9WwUSU6V4IPw7c+OszX7LBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722008008; c=relaxed/simple;
	bh=YQxyibUbODIdxADICcVI+YylYqvJLAvWFUOMaOkvJJs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=potTXsXC+1MrCC8WAYQAp6VOD94VL1mTmbz0WEAWG0K4BrlK2jYqBQoLNe9y7UtwRoarNZImcs78Mer8ftdJJMcNm/yG9agG2EtF+QibfRwUxbREGL5GgTdeMtVFDBrnGBIxoVYfBg9HBinJA61YE2+QlohcDTmvyIdfxiBRqAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HlZkEfpL; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HlZkEfpL"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C333346EB;
	Fri, 26 Jul 2024 11:33:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=YQxyibUbODId
	xADICcVI+YylYqvJLAvWFUOMaOkvJJs=; b=HlZkEfpLQfQB/wbRkslxN/u+kDC9
	/JTiCaViqgEsT6TQF7V93Unjo/cOBXSKndkw4A4K6eiNLgcdmHPJ/uzFMY9k/FiX
	GM/Wya9RHgDLEs3GI2S3npI72TwiKI27Dw4z/w2eX9pFzQtxdkCq+2le+2DLxMBb
	DI31eyRdvABImU0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 24BE7346EA;
	Fri, 26 Jul 2024 11:33:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 98A16346E9;
	Fri, 26 Jul 2024 11:33:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Micha=C5=82?= Iwanicki <michal.iwanicki@3mdeb.com>
Cc: git@vger.kernel.org
Subject: Re: Does GIT_SSH_COMMAND apply to all git commands that connect to
 remote?
In-Reply-To: <3856e339-3c93-4c29-a668-334bdd7bff7a@3mdeb.com>
 (=?utf-8?Q?=22Micha=C5=82?=
	Iwanicki"'s message of "Fri, 26 Jul 2024 10:25:40 +0200")
References: <3856e339-3c93-4c29-a668-334bdd7bff7a@3mdeb.com>
Date: Fri, 26 Jul 2024 08:33:22 -0700
Message-ID: <xmqqy15oxj5p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 6513BA5E-4B64-11EF-856C-9625FCCAB05B-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Micha=C5=82 Iwanicki <michal.iwanicki@3mdeb.com> writes:

> I'm asking this question, because in docs it explicitly mentions git fe=
tch and git push. Does it apply do other commands
> like git clone? If yes then maybe this information should be added?

"git clone" is like "init + fetch + reset --hard" and "git pull" is
like "fetch + merge/rebase".  They both talk to a remote repository.

When the partial clone feature that allows lazy fetching of missing
objects is in use, you cannot even name an exact command that may
trigger transferring of objects from remote repositories, as a fetch
happens on-demand any time you access an object that you ought to
have fetched during the initial clone but you didn't due to use of
the partial clone feature.

All of them use the usual remote transfer mechanism.

I doubt that it makes sense to repeat it in any and all commands
that potentially connect to remote repositories.  In fact, "git help
git", the most central place, is where GIT_SSH_COMMAND and GIT_SSH
environment variables are described.

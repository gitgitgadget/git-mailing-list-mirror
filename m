Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9019B14F9C5
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720564241; cv=none; b=VeXXHBdv1DTqBoiHDVbIbwWgyozUmR8zOFT6AC0H5KBRbhvis/CI3BUbOrPxE2wkIEVkhrHfhKAc8Crb+CHWe6eMsk/Qkg8eH+bcx10zlc+O6mmHvUV0jFPn0vLkygsQ4GbkMfe8rRMtljTj6J0XDz2cn0WKKAtTXhFzVQj6SP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720564241; c=relaxed/simple;
	bh=nxqju1//5ppFl2xLXeg5+P/V07McFILwLfc0Ow9v5/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=udVW0JkyKRk7aGEg6l3Tv7mVAExS4duC7R3HOcbPrTOwrWI4pL9UWs+98iq34vDsmtvdQyZjfddJZ+U/O3LOEviEw+yJjkKp0LDbqeNyx++MVKaYsV23UkcFVe068LGWgnW88qNTRaU3UKaCc7TOUcXBrtsL8zmZbzxMGX3qDGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hKdrQgE1; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hKdrQgE1"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 653BA2D90E;
	Tue,  9 Jul 2024 18:30:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nxqju1//5ppFl2xLXeg5+P/V07McFILwLfc0Ow
	9v5/k=; b=hKdrQgE1UTn4wUfCx6uLyKvazSgfPHl5Sw0bSqa4Aj0PiTgJ2NwNOu
	tCij87THQETjtCbJiPiP9AJHgqZG1/Do7yjttgGdF254wsGx6y+TazKRsMx5BsSv
	UQpjQNB8vFnnO9/EuXf9kqYS82mURTf+12FtNEbT1GFsF1Ax3dqSE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5BFA52D90D;
	Tue,  9 Jul 2024 18:30:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC4FE2D90C;
	Tue,  9 Jul 2024 18:30:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Piotr Szlazak <piotr.szlazak@gmail.com>
Cc: Piotr Szlazak via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,
    Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    brian m. carlson <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] doc: update http.cookieFile with in-memory cookie
 processing
In-Reply-To: <9fa5db58-74ab-436c-b7ac-ff8762b29d03@gmail.com> (Piotr Szlazak's
	message of "Tue, 9 Jul 2024 23:37:06 +0200")
References: <pull.1733.git.git.1719177846725.gitgitgadget@gmail.com>
	<9fa5db58-74ab-436c-b7ac-ff8762b29d03@gmail.com>
Date: Tue, 09 Jul 2024 15:30:37 -0700
Message-ID: <xmqq7cdudwqa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DE2B0746-3E42-11EF-A898-965B910A682E-77302942!pb-smtp2.pobox.com

Piotr Szlazak <piotr.szlazak@gmail.com> writes:

> Hello Junio!
> Would you be able to take a look at my commit?

Please do not specifically name me.  If I did not respond, that was
because I considered it was outside my area of expertise, so pinging
me would not help all that much.

CC'ed folks who touched http.c (where the configuration is used) in
the past 6 months to ask for their help.

Thanks.

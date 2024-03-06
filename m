Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7264486621
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741040; cv=none; b=hZr6LiOGbxThkW9/WyuTJUx/16zWsobttehuMwimuZHM18Tt3b15iWCvD7wDkxTvXJi1U2UdpNGBResRwm+SK63f2No3q6iHh1m0f2ygxiu7mo4kcnMihsqJKhyuJeGYtH5Dj5yssAl6Ke7VIHt2NYm/ZsvmW8vVZiDcyg7F0Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741040; c=relaxed/simple;
	bh=EgQy0ks5W0/C5NXRZtg7cQQDOVVFXnplhxbJYs/iHto=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kWgGyEHAej0Sdn91T7bpqW1EHACRXp/PhrH5Ifu43ZpAwOeEQ2eTSUVkbvwItofihlbX4dyqZqXMAHLyBiH5hMMFg6G+N4Zpd8dHWu9ZsVFxL6+ORAEY5N0D2jldbCVbX2a18c5/U4EB1p6wkqAXi5z4wE7YyUWdwomFrUB958A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TU/pCbrq; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TU/pCbrq"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 58B181E3800;
	Wed,  6 Mar 2024 11:03:58 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EgQy0ks5W0/C5NXRZtg7cQQDOVVFXnplhxbJYs
	/iHto=; b=TU/pCbrqbuR7jYHe5EDTAROYfDuj0MifhoxddbH3TlMT/Q86l4Dcrm
	6cIPIIDT5ICXBoHUAby7Ns8xBJSZsauC4cG1DEk/o6FFTtWZWDigxdMN2UipvId5
	dLdAe5WPKEjnJGx3YvBvbuDgyB6in1Kdf/zgHeIqaWOtDpGBj3b7k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F6781E37FF;
	Wed,  6 Mar 2024 11:03:58 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AE13D1E37FE;
	Wed,  6 Mar 2024 11:03:57 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: Beat Bolli <bb@drbeat.li>,  git@vger.kernel.org,  Beat Bolli
 <dev+git@drbeat.li>
Subject: Re: [PATCH 19/22] t/t8*: merge "grep | sed" pipelines
In-Reply-To: <ZefSPAiTLrRVeXm6@pobox.com> (Todd Zullinger's message of "Tue, 5
	Mar 2024 21:17:32 -0500")
References: <20240305212533.12947-1-dev+git@drbeat.li>
	<20240305212533.12947-20-dev+git@drbeat.li>
	<xmqq8r2ww4xg.fsf@gitster.g> <ZefSPAiTLrRVeXm6@pobox.com>
Date: Wed, 06 Mar 2024 08:03:56 -0800
Message-ID: <xmqqplw7tkib.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 239F749C-DBD3-11EE-BED5-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Todd Zullinger <tmz@pobox.com> writes:

> Junio C Hamano wrote:
>> Isn't -E a GNUism?
> ...
> https://www.austingroupbugs.net/view.php?id=528 suggests
> that -E has been adopted 

Then that is OK.  Thanks for a good news.

> and, importanly, is more widely
> supported than -r (if we were considering using that rather
> than rewriting this to not use ERE syntax).

At least I wasn't, so it is irrelevant to this review, but it still
is nice to know about it [*].  Thanks.

[Footnote] 

 * or is the knowledge of '-r' itself also irrelevant, now '-E' is
   kosher and widely usable?

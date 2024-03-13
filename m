Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B34290A
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710343463; cv=none; b=lkjOXHAPpSFarJuA2wgYoDDbU7DCcvOUdKAs8DR1Yw2cJ5heH8WsF7TcAFNhOS67kCDhSb2Pv0H7RQ/Z2SowpNz4Qls9kOvz3UjQ9bUk537pdDUK74q07jKb17wDxICWYAedmCbvllOrFcy44Q9BhEzh1ueGJb7scpt+Z5Ytlbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710343463; c=relaxed/simple;
	bh=OuO2XI4kC/hcplhuc1GndJoL0L/3YvPUKHMeGJ8ZLAw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lXaXVVs7s2nIG45x9UrT/bhwmYhuLGmIh4p9jtJqWTv++mwxT0XP32+oGXHVPr6a/8d1k7j5fRfIR1UlzhBVFwTtHaoTQQNevfBj2JYlqrdoas1/JYX0AkcsfTxnVaS+iQCEjKJO4TL2ubgTZENVYrzaL/x0ibQ89aOaYj1ou+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wlhl41eI; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wlhl41eI"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6867A18B84;
	Wed, 13 Mar 2024 11:24:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OuO2XI4kC/hcplhuc1GndJoL0L/3YvPUKHMeGJ
	8ZLAw=; b=Wlhl41eI3bDzB7yIVOW2m0auM+ynAR9Srdqu11GkXnhbO/SMnM6xth
	ZwzOqCc6md9zxI1ht+QViJ5/MsrsyO4jMzXHtgwNIPlSxY6Fho1oiePeOjo3/tA3
	uZIaoVCQaDmKIefe8kIIz+7eBlfJgh8UOVt782WZv8pKgt8tKgF7I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5F0EF18B83;
	Wed, 13 Mar 2024 11:24:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 083C018B82;
	Wed, 13 Mar 2024 11:24:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: phillip.wood@dunelm.org.uk,  Peter Hutterer <peter.hutterer@who-t.net>,
  git@vger.kernel.org,  David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v3] diff: add diff.srcPrefix and diff.dstPrefix
 configuration variables
In-Reply-To: <e14ec355d447e16a794f313543dccf5b@manjaro.org> (Dragan Simic's
	message of "Wed, 13 Mar 2024 16:14:17 +0100")
References: <20240312231559.GA116605@quokka>
	<fac4fec23597bff0f4594112d2a9976d@manjaro.org>
	<d15eb4b0-2ea9-44d7-af5a-2ea1162294f4@gmail.com>
	<e14ec355d447e16a794f313543dccf5b@manjaro.org>
Date: Wed, 13 Mar 2024 08:24:16 -0700
Message-ID: <xmqqil1qf93z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C21D6F00-E14D-11EE-AEBB-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Well, I required nothing, I just noted it.  Such a small change can
> also be performed by Junio while applying the patch.

Doing so is trivial.  Having to remember doing so when there are
many other patches in flight is a burden.  Don't put things on my
plate when you do not have to.

Thanks.

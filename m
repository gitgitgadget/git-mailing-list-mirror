Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147C658AC5
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352557; cv=none; b=czgSrGVO8ZRNWwANEQ0XssQkwq7z7eWHEAFLT8xsBlW6Jkk9jDY7Hbibiva4PhbYYrx8JQYRCqKT4oQSd1LfEeoETLlfrVKqI0qXp/k0m2KONV3XhBUE63cYCesgE+jw+htAH4wQ4iQkF0OFmeKgaaRbJCuovb98Hy0uJctFSmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352557; c=relaxed/simple;
	bh=C7yL3Laa4mueAUbHMfwWzuB1bw3rDSlioXG74/CM6AI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EpNYWlKCCqm3yXE35tNg58YRZUdsZza4QdQQMcjtTk11NKULJZhFg2exBFgvBok1cATVRm3QlsJwMc2biUq2TRgkC+F0fGFwgs6k2sSpNmR9n/tdq0RwabOnAIwqeNKghiTF4KcB/Z2Ck3uqTz3Kmhyc2y+RpTZBLF8efUeTS4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rHG3MKOb; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rHG3MKOb"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A57B1A034;
	Wed, 13 Mar 2024 13:55:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=C7yL3Laa4mueAUbHMfwWzuB1bw3rDSlioXG74/
	CM6AI=; b=rHG3MKObPXWHkGsix3ACaI74PHIM0S46Skfizazi8/+0ZZqLJFZQjI
	jdh1hka5XTt748NOzNjXxvvU1Kk7qzqLm/1H9xXNxwkRlIcEo4Td1H64gH27iV8n
	MXHu4k5JiaAQwz1yLCT9/VVZz+4jMaKjNtde3yTSwbp+IZHY0BEZ4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9356A1A033;
	Wed, 13 Mar 2024 13:55:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3A8E11A030;
	Wed, 13 Mar 2024 13:55:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>,  git@vger.kernel.org,  David
 Heidelberg <david@ixit.cz>,  Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v3] diff: add diff.srcPrefix and diff.dstPrefix
 configuration variables
In-Reply-To: <9449a421-c6ea-427c-a600-73c6f99ccf0d@gmail.com> (Phillip Wood's
	message of "Wed, 13 Mar 2024 16:18:23 +0000")
References: <20240312231559.GA116605@quokka>
	<f8565251-2af1-470b-9b2d-798e3504b0d1@gmail.com>
	<xmqqbk7if8vj.fsf@gitster.g>
	<9449a421-c6ea-427c-a600-73c6f99ccf0d@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 13 Mar 2024 10:55:50 -0700
Message-ID: <xmqqcyryc8yh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EEAF4592-E162-11EE-9BAD-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> mention that one as well or just say something like "This is designed
> to be used to override the configuration variables `diff.*Prefix`.".

Excellent.

Thanks.  Peter, do you want to wrap things up with an updated patch
(no rush and no obligation to do so---we just want to know if it
will happen, in which case we will just wait, and otherwise somebody
else will do that)?

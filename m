Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B538188012
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355422; cv=none; b=SKF/CQhuTM+Qq2Qkwz8VgzXYRYiUx8XUIxY/cud6WwrSaX+fA2HMQU/Hn4LDeCjRRv7io/VyoQCrp7Sp8FhFtSeHbq7Qs5htJy26DV6xijJQANOBV8gh1RiMShj5GfX22rGhz+kf3j4Pvo6VijIhainWtou6JWX8hmbtpsMvyr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355422; c=relaxed/simple;
	bh=WnwqQsDQfz9LH7aGJz2cN2IrwrJcYAMf6V4hahUW6lA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pX/qkxJyTQAj0FpfAN3F9stSEfAyQBBCRn5k2OuN1MCIe9t6eVgQBqfCcrHKclODs2lzvYcBE3GtQP35c+wN4ZP4QXQuPA+bteHmdERCvyBbtiVDZKUOrQNda5I/CWqDhQJeV/WsVVTJID822uVe7aSZFmV+KlEy9OobzgXU6DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GdKxf/dB; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GdKxf/dB"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1CEBA383E6;
	Tue, 30 Jul 2024 12:03:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WnwqQsDQfz9LH7aGJz2cN2IrwrJcYAMf6V4hah
	UW6lA=; b=GdKxf/dBEQl3pSnZLtolDz+AXuDtsfejAVtqz/axfQFXBMCOu5PTcK
	JFjVvsBN09lgBJ3yeZvymMnRAokMe4AcVkIKhpPmlfwNR2PQi4VcFk57G2TB7+Mh
	I5nO2b91LrWY+L7a3FMUbbf989DZaf5wfV5OYgGPSwdJp/TKYKkTA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1549E383E5;
	Tue, 30 Jul 2024 12:03:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9FDF3383E4;
	Tue, 30 Jul 2024 12:03:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 2/3] safe.directory: normalize the configured path
In-Reply-To: <20240730073119.GA562212@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 30 Jul 2024 03:31:19 -0400")
References: <20240723021900.388020-1-gitster@pobox.com>
	<20240720220915.2933266-1-gitster@pobox.com>
	<20240730011004.4030246-1-gitster@pobox.com>
	<20240730011004.4030246-3-gitster@pobox.com>
	<20240730073119.GA562212@coredump.intra.peff.net>
Date: Tue, 30 Jul 2024 09:03:35 -0700
Message-ID: <xmqq4j86g948.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 47FA29A4-4E8D-11EF-9C2D-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

>> +			if (!is_absolute_path(check) && strcmp(check, ".")) {
>> +				warning(_("safe.directory '%s' not absolute"),
>> +					check);
>> +				goto next;
>> +			}
>
> This is_absolute_path() check is redundant, isn't it? If we are checking
> for a literal ".", then we know the path must be non-absolute.

What I meant was "If it is not absolute, that is an error, but if
the thing is a dot, that is allowed as an exception".

Is the lack of "!" confusing, I wonder?   We could rewrite it to
make it more explicit:

	if (is_absolute_path(check) || !strcmp(check, ".")) {
		; /* OK */
	} else {
		warning(_("not absolute %s"), check);
		goto next;
	}

My earlier draft for v3 had the check for dot a lot earlier in the
function, i.e.

	-	} else if (!strcmp(value, "*")) {
	+	} else if (!strcmp(value, "*") || !strcmp(value, ".")) {
			data->is_safe = 1;

and this part said "If not absolute, that is an error" without
anything about dot.

But then I changed my mind and made it unsafe to do this:

	cd .git/refs && git -c safe.directory=. foo

as safe.directory=. means "A repository at the current directory of
the process is allowed" and the repository in this case is not at "."
but at "..", meaning "." is a lot stricter than "*".



Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B064A16132E
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847582; cv=none; b=RJTDfwWmqs9nqQDuhnvAX1lmJYiHuQsF/TGXHKqxJ7isvKO17qU90lEPLxp3DxQHaUgg8TODF9XsCH+ESJYahmNjBZHwe4hpeLMlovocKU1UxdQfK2WdQ3iVsfOnFx0GtHTnPjSFvXQPrNMMAGvOxnjEr9eD3MNNOkHa9bwjYHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847582; c=relaxed/simple;
	bh=9A2kpYVsrqOT0THNEKXRrsltQDxRTEpwQdzsSJZbyP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HDvpFYA0kbXaE5eaEZkvRC8kb7UmzRqmLtXFANt45hEgZMzx8iBKrdx1K2W6eGG9Z0cXS+QuJfGgQ8aDa3AvkNEVuifNydyfkoG8hC3yEy+UIl0CA0/A999FLf+7BQ0rct552dRIJ3LVDCbKmmTt14KA0h6Y2rFWvmOyf5yhNeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=klAPfGCx; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="klAPfGCx"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8BEF41C705;
	Mon,  1 Jul 2024 11:26:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9A2kpYVsrqOT0THNEKXRrsltQDxRTEpwQdzsSJ
	ZbyP8=; b=klAPfGCxgj8gTFTwDZPH3l8pmLfRDStVL3yNEEkpJLedvZe/mUHzH9
	ukLgmC9uz8oM0//9irMW17LbrzDJ6ww1QXKcBCqJ3RVi/wRO6+sy+wuNYWbRw8Y+
	Ys639oisUDe1k4s44fSIvWL1eDtfJpEHYQnnBuDM4cJPwGzMlp16o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 84DEE1C704;
	Mon,  1 Jul 2024 11:26:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 244481C6FB;
	Mon,  1 Jul 2024 11:26:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] http: allow authenticating proactively
In-Reply-To: <Zn9UGwMQ4Ur-peI6@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Sat, 29 Jun 2024 00:23:55 +0000")
References: <20240628002742.3421311-1-sandals@crustytoothpaste.net>
	<20240628002742.3421311-2-sandals@crustytoothpaste.net>
	<xmqqa5j53pbo.fsf@gitster.g>
	<Zn8yhdN6henrIqgD@tapette.crustytoothpaste.net>
	<xmqqh6dc1zk2.fsf@gitster.g>
	<Zn9UGwMQ4Ur-peI6@tapette.crustytoothpaste.net>
Date: Mon, 01 Jul 2024 08:26:09 -0700
Message-ID: <xmqqr0cdyvzi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3EF99DB6-37BE-11EF-99ED-C38742FD603B-77302942!pb-smtp20.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2024-06-28 at 22:18:37, Junio C Hamano wrote:
>> Well, at least I couldn't read the proposed document update and read
>> that much out of it, and I suspect there may be other readers who
>> will share my confusion.  I think the source of the confusion is
>> that "don't request" does not automatically imply "allow the helper
>> to pick any scheme as it sees fit" if you do not know how helper is
>> designed to behave when it is not requested "any scheme".
>> 
>>     `basic` - Request Basic authentication from the helper.
>>     `auto`  - Ask the helper to pick an appropriate scheme.
>>     `none`  - Disable proactive authentication.
>> 
>> or something, perhaps?
>
> That sounds good.  I appreciate you providing some language that would
> be less confusing to you, because it will probably be less confusing to
> others as well.

Thanks.

Giving a possible alternative, when you are certain you understood
what you originally found confusing, is probably one of the things
we should add as a tip to ReviewingPatches document (do we have one
already--- #leftoverbits ?).


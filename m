Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C541420CC
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591375; cv=none; b=CWYYGIVG3wyTV5K5onNz9LkQ5k/JnpiA7+mA1HSoZ5K6PPJOilbsTJxnCQkyz8ICFqZ4YFAepCQSE1oPP9gezcm/YW8MDnlvhd20qjxrdr9u04IvZjTTzw6cptgVU5WB5fyGTEQ+dFFeSGE7cuiKM+U/FnvjviocsdtOBNPih48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591375; c=relaxed/simple;
	bh=LzEaw8u61De1GAtgGvSRlkaeWzFqHNlMmMJKc7m74uo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sQLl9IvLlyZUi15sDlyq3uQ8bRvrRuT7R9lvo+FzJqDie4uQmvbz7Tob5wS2865tkVpBNzkNuDi9fa391ZbHd2n4U+EPszn9E3ZIvNolYsK0fCZ7tvR3nme7T05FUI8b+4Ab4UbNjoC+FkfSN0KiVvzApydKCyW5x+/icJ9R8ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bIkO8hY/; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bIkO8hY/"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7319B1D9678;
	Mon,  8 Apr 2024 11:49:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LzEaw8u61De1GAtgGvSRlkaeWzFqHNlMmMJKc7
	m74uo=; b=bIkO8hY/TV36W46B4e2gqTCqWcnyBtawMgLqVmw8/kPI761khSjEeZ
	Q2+1IanUxmhz54iojmBO5U5ThqLa8qlRlu6q/ze5ylPnSzY7YPuZnq4Sa5ReaCtp
	Cvqpz1LIKpmXWD6+dUIF4rEXj/JdFdDI17Tru67V8cZKNYh2PjG2c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C7531D9675;
	Mon,  8 Apr 2024 11:49:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D24931D9673;
	Mon,  8 Apr 2024 11:49:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: =?utf-8?Q?L=C3=AA?= Duy Quang <leduyquang753@gmail.com>,
  git@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] Add lines to `git log --graph` to separate
 connected regions
In-Reply-To: <xmqq4jcdivgw.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	06 Apr 2024 22:37:51 -0700")
References: <20240407051031.6018-1-leduyquang753@gmail.com>
	<CAPig+cQVQrrXrDqys-TyCqFynR6=pmbxs-NK-ca-s0K8mjADaA@mail.gmail.com>
	<xmqq4jcdivgw.fsf@gitster.g>
Date: Mon, 08 Apr 2024 08:49:30 -0700
Message-ID: <xmqqy19netx1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 972AE1FC-F5BF-11EE-8F9A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> True.  But because we are doing graph, shouldn't we be able to do
> better?  For example, you can draw the two lineage of histories
> on different columns and ...
>
>        * a2
>        * a1
>      * b2
>      * b1
>
> ... that way, you do not need to lose one line of precious vertical
> screen real estate.

Just to save others time to go spelunking in the list archive,
"solutions" attempted and did not work in the past include

 (1) wasting a line to insert a "gap" in the output.
 (2) using marker different from '*' to mark each commit.

If taking the latter approach, it needs to designed to work well
with "boundary" and "left-right" options (the design to shift column
would not have to worry about these, which is another plus).

Thanks.

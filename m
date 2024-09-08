Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B11E3DBB6
	for <git@vger.kernel.org>; Sun,  8 Sep 2024 21:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725831551; cv=none; b=Hws0rWZ+6ma2n5zl8mUXo9mtgHqJSHag344to1N30YZL+NMpt8zqq/+3uqXNJzrTlREyOF+gT0oda37JsFDqP2RAKRBz4oLI0XOFPF5ENndjfjihrKgPsPC0tuAUAWOsofORiPRLpHgem2d4wQrC84fCwCmossxigd1qTRZ8/yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725831551; c=relaxed/simple;
	bh=pl6KAPX5McoQHJhYGbOFNiq+urzrYctRgdJsaNMiUOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kKBRzDFQ7O9TXCYCbycYgh9nVD6VHTz33r19cfStSU4sNkzHnGdvtyXL8qqEdvkN4EmCWtz10OWJMFuCs4N2m41PcIs0LeHRtx1g9T/I2TxBwAuFeNS81vJkbYHnKqKEMBQPNHG+XmZQlESNzKHcvE20RTm8RpkzUlxjAQuf2zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NapljFwK; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NapljFwK"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CF9E01BFDC;
	Sun,  8 Sep 2024 17:39:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pl6KAPX5McoQHJhYGbOFNiq+urzrYctRgdJsaN
	MiUOg=; b=NapljFwKzacs5UjZOzgJK7gGB3lbFg9l5XhvQ6viGOOoIgbcgQhycV
	nVwlcQI9pQ2v8BsVcz418vPnMXWb0oDMVo6dzq86LGdv6skR+8EKye+InlsnJNeT
	f6vy3Cmvgg0rc/LCuPLaCuzdiZ/c5jh7dBusLh1rMC3D5cHvrwbYM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C4E831BFDB;
	Sun,  8 Sep 2024 17:39:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 393251BFDA;
	Sun,  8 Sep 2024 17:39:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Calvin Wan <calvinwan@google.com>,  Josh Steadmon
 <steadmon@google.com>,  Elijah Newren <newren@gmail.com>,  Toon claes
 <toon@iotcl.com>
Subject: Re: [PATCH v2 00/22] Memory leak fixes (pt.6)
In-Reply-To: <cover.1725530720.git.ps@pks.im> (Patrick Steinhardt's message of
	"Thu, 5 Sep 2024 12:08:35 +0200")
References: <cover.1724656120.git.ps@pks.im> <cover.1725530720.git.ps@pks.im>
Date: Sun, 08 Sep 2024 14:39:01 -0700
Message-ID: <xmqq1q1tx1u2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C3AFA2D8-6E2A-11EF-938F-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> There are only some smallish changes compared to v1:
>
>   - Explain leak checking a bit more carefully and document the new
>     `GIT_TEST_PASSING_SANITIZE_LEAK=check-failing` value in t/README.
>
>   - Some more trivial commit message improvements.

These changes looked trivially good ;-)  Shall we mark the topic for
'next' soonish, or are there others who want to comment?

Thanks.

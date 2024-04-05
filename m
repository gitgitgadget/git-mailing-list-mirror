Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FA31D530
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335462; cv=none; b=A4nPk0gRcmBlwp5SuFdUzCrnOJICsVXhmsWsQrglaPeA9kUg/uTkykxCqv6VBIFePn4QvXYbHKxk4JFPqo4OG6Z3ooFJ+AEVWUF4roO2uGuTc5ZRqRM0amV7t4/rERgQVDBYMV9n9E1oGVXjM98+eBIjcQMPobGdiwfOe8/GSGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335462; c=relaxed/simple;
	bh=oQL0K2/ZJTk9tusVdvpo7lXQ5ZHdoGWwfL8FQLvP9h8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D5zv+orYhlWDf8FF65bYCGKOZ1hDLjW8s11q6H1XRi0J08lsvgbhsknzBXRD4WtltaLwyWfLO65xSHIxCTe2X/mJGk77v0b+E1yoZ1FQ3R+5axhgkEwRG9GpLlX8lhYyF1FagqV31vFsBibzc7jtOEOfwX1yPMqEg27je7wfc28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eNiyRbk4; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eNiyRbk4"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D5991EFA87;
	Fri,  5 Apr 2024 12:44:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=oQL0K2/ZJTk9tusVdvpo7lXQ5ZHdoGWwfL8FQL
	vP9h8=; b=eNiyRbk4+rgZ7ZO5KgrQ+YehopD2F33PNsc9hNrAVQ3Bj7nCtIB01g
	NIEUw9ATAfhaIfgTsqtbaVA1AmjZitEu3ZbdukMTPja13NJe+bxvsqG3F7k5rUS9
	5rHT+bGcC9aoAIKi2D7OvGAKGAK2W4rW91DgduXP0Wv3HNUISBauw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 54AFD1EFA85;
	Fri,  5 Apr 2024 12:44:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B83C91EFA82;
	Fri,  5 Apr 2024 12:44:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] send-email: make it easy to discern the messages for
 each patch
In-Reply-To: <8d47bd687f2ad80bbc1e1c86ae337327@manjaro.org> (Dragan Simic's
	message of "Fri, 05 Apr 2024 01:44:42 +0200")
References: <0e087ed992def0746f3d437253248904c2126464.1712262791.git.dsimic@manjaro.org>
	<xmqqzfu8yc40.fsf@gitster.g>
	<8d47bd687f2ad80bbc1e1c86ae337327@manjaro.org>
Date: Fri, 05 Apr 2024 09:44:16 -0700
Message-ID: <xmqqjzlbwyhr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BE78A164-F36B-11EE-B490-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Well, I actually wasn't lazy, but instead I wanted to give this patch
> better chances to be accepted, by introducing as a small amount of
> changes to the code as possible.  This was a lesson not to take that
> route, but to do "the right thing" instead.

The lesson you should be taking is a bit different here, though.

As we discussed, doing the separator correctly is harder and doing
the terminator correctly is much easier and less error prone.  So if
we chose to do terminator semantics and punt on doing separator
semantics, the right thing could have been to adjust the existing
tests to make sure that the new output with unnecessary trailing
blank line is expected.

Either that, or we should fix the code not to break the current
expectation.  Doing neither of these is not quite acceptable---
that is the lesson from this episode, I would think.

Thanks.

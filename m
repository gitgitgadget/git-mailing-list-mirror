Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994F37472
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 00:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708389169; cv=none; b=kclNirfvYQgpqW5FZb9Gc+YpkvZus9p+kwXCes9aoir3DjAOSg1Q9Q1il7w8nDy8zE0tIR8Va6o3TdQ+UFxLvZbcgPwLRhqECV0E/lXxkS8A4dBBJ2p1JPs6bMQeHzZgJIWxO0jSyN7rmrSMFpF2aLvUL8Wcq7gFJ/FZYSH14v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708389169; c=relaxed/simple;
	bh=pmKHMMRro48OptFAeSXBnwCvjBGnflzN9qwMNiWJdlo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CWAce6l9LcjQ44uUJRJizwAIYGoaqU83UcClLCXeIJFQh9fBP0Su0IBfMHAoJdzEU5/phUIPLy+SKk5hCal9nmQYRzpGhlJaFxvgZkviHTnZzmt8/bAEF3BfnEpgPUQsiY7CJrXBsAbOLvnK1ci4S78eWqN16a3WTXbW5ZEugnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vETNY697; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vETNY697"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 89EE21E2F84;
	Mon, 19 Feb 2024 19:32:46 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pmKHMMRro48OptFAeSXBnwCvjBGnflzN9qwMNi
	WJdlo=; b=vETNY697oN2afn909dLQ2CNDmGrxF7TCMFxItxxTl0Q+DHxgEpngjd
	YuN5RVUywbfsaFZDnzYJHOmwKEmOqPblBCsheRIn6NLR475RYWIumWFwH/G8Ch/U
	Kx+QsV67rymCqv02Y3K6rB8YYAS+cGOV89vsszmiY/EmpCae/6WmE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 815CE1E2F83;
	Mon, 19 Feb 2024 19:32:46 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DF7EF1E2F82;
	Mon, 19 Feb 2024 19:32:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: eugenio gigante <giganteeugenio2@gmail.com>,  git@vger.kernel.org
Subject: Re: [GSoC] Use unsigned integral type for collection of bits
In-Reply-To: <CAPig+cR5K=pQjK+7ZUyGn1M50RZ0pRD6kOPQgmp7qez_LNXcAg@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 18 Feb 2024 14:09:40 -0500")
References: <CAFJh0PTiN18LcKP6LW0d1u2gkodBD2cOJRBzU_subBaFpzM=CA@mail.gmail.com>
	<CAPig+cR5K=pQjK+7ZUyGn1M50RZ0pRD6kOPQgmp7qez_LNXcAg@mail.gmail.com>
Date: Mon, 19 Feb 2024 16:32:44 -0800
Message-ID: <xmqq1q98ynyr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 913D0B3E-CF87-11EE-99B2-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

>> 'diff_filespec_is_binary' inside 'diff.c' would have to be changed.
>
> The code in question is not being used as a "bag of bits". Rather,
> it's a tristate binary with values "not-set", "true", and "false".
> Whereas a typical binary could be represented by a single bit, this
> one needs the extra bit to handle the "not-set" case. Moreover, it is
> idiomatic in the Git codebase for -1 to represent "not-set", so I
> think this code is fine as-is since its meaning is clear to those
> familiar with the codebase, thus does not need any changes made to it.

Correct.  In general, bitfield structure members in our codebase
should be already fine.  Most of them are "unsigned : 1" and there
is not enough room in a single-bit bitfield to go signed.

> There are cases in the codebase in which a signed type is being used
> as a "bag of bits" instead of the more desirable unsigned type.
> ...
> So, refresh_index() is correctly expecting an unsigned value for
> `flags` but refresh() in `builtin/add.c` has undesirably declared
> `flags` as signed.

Thanks for a good example.  In a signed flag word that is used as a
bag of bits, the MSB is special, and unless you take advantage of
that special casing (which happens almost never), you should use an
unsigned word instead, to document that you are not doing anything
funny with the MSB, like "the flag word is negative, so the MSB must
be on", "I want to copy the bit immediately below MSB to MSB", etc.

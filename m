Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D033B1B2
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 05:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709185292; cv=none; b=eJvIgHw47+FVTb2jg08P6UNuiYWCCzSA22fhjLrX6eEmgyin4qdPyxHGnR4zSEKiBR/63UcwFUbP4mTStkkZFBmpXLZt77+zZeKuuWofMm49BQmgjZLG0oxKL9j5Y0Dq3TmzyXmkRf8K70v8nLW5PsaxlnWbbOhwAIxA/NfMYF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709185292; c=relaxed/simple;
	bh=1HqwxuxhqExhovhBuLmYivMzEQTQ48tZxSexcU8TwF0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gBYUaXh3WBVi6KcfF6bMt5E3S6gi4KeDt/6ssu3LVTnRyt4QcwsaJ6/aV8DaTqK2Cau8RAGqjN37SDgN6BYZdZWcFY1ioGQEgfiKjz80oh4eRkHTblVVXFemwXhIRamv4zbki5iSbV9SSlhVM7FmXpmYAbrbmga7dQGInqVePSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=R8ibOS+G; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R8ibOS+G"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E5881E0B6D;
	Thu, 29 Feb 2024 00:41:24 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1HqwxuxhqExhovhBuLmYivMzEQTQ48tZxSexcU
	8TwF0=; b=R8ibOS+G/YZBf7SNoOUzhV9WZqXn2tHUJ+nGToiYDXW4UeUkYFQatS
	owo5Thw5Vtx8JvrmCUyizMlDjTbvzLV3bfFaHDLInko5+0o+GXaQVkJYk2BmJsPL
	QZxl7t2y8PQq9/d5iAtfMQqCKFNDionQpw/zdlnvrEGAC93pL3oKo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 75EBC1E0B6B;
	Thu, 29 Feb 2024 00:41:24 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E2C8A1E0B6A;
	Thu, 29 Feb 2024 00:41:23 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Triplett <josh@joshtriplett.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] commit: Avoid redundant scissor line with
 --cleanup=scissors -v
In-Reply-To: <ZeAFutaddf4M2wjM@localhost> (Josh Triplett's message of "Wed, 28
	Feb 2024 20:19:06 -0800")
References: <9c09cea2679e14258720ee63e932e3b9459dbd8c.1708921369.git.josh@joshtriplett.org>
	<xmqqbk83nlw5.fsf@gitster.g> <Zd2eLxPelxvP8FDk@localhost>
	<4f97933f173220544a5be2bf05c2bee2b044d2b1.1709024540.git.josh@joshtriplett.org>
	<xmqqjzmpu7k6.fsf@gitster.g> <ZeAFutaddf4M2wjM@localhost>
Date: Wed, 28 Feb 2024 21:41:22 -0800
Message-ID: <xmqqttlrj08t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2C8D6C16-D6C5-11EE-A841-25B3960A682E-77302942!pb-smtp2.pobox.com

Josh Triplett <josh@joshtriplett.org> writes:

> If you do end up needing a resend of any of them, I'm happy to do so.

I do not think there is need for resending, but I think you promised
to add some tests earlier, so an updated patch may be in order ;-)

Thanks.

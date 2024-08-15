Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64D61537D9
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 22:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762637; cv=none; b=LPzJZEMH7ZEYurn68BeLlBZOt4rfW/c1SSqFXOC5JX+qRh9dT2GS/WCQ+sjQPdo95cf2ABOHOCufTpbEry4VrzxN51TXk72JhfWHXLY+GGa0YLgsV3HB3OcntoFGQMWfEODq2XqGaw9EMszo6tSwcR+WcLks6rog0JhSp6+BYZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762637; c=relaxed/simple;
	bh=zWjRrTgVX/39Sonmw+f2OSAv2fLxHWz+xwCB86FHXQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DxXKUTpuCvhciv8yEY6Y1jJwCmobp7e2tglGjc5iLkdq8O1dXWmvp87IwkIoYti5FUGKbWNHiDiT27fClDqk3erb2t+A1HTp+pBTI4TGp7XFzD7BhU6bZvsIF2v0yPiVZoX9wgcqoGHVljoAP7jiSFGdWdH5eRUq2nfhg0qB/mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ofv8iaQt; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ofv8iaQt"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7AADD264C5;
	Thu, 15 Aug 2024 18:57:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zWjRrTgVX/39Sonmw+f2OSAv2fLxHWz+xwCB86
	FHXQA=; b=Ofv8iaQtDyR8inQepLlCB4zFxDdqzknu2B4AM8fv39a+VM8uohAWoI
	WPTPvJAJ5uaRPp1yYXWrcSQy8UfDYq03eVz9yon7SymYS9XX+lGcHIatK8wGMSI6
	FLX45yKf0IYL3uNroHl61QJAqBYoBcS+0+7Jif7YXe+C9JxJ1+lJY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 72930264C4;
	Thu, 15 Aug 2024 18:57:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D6AAD264C3;
	Thu, 15 Aug 2024 18:57:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>,  Konstantin
 Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH v2 0/3] send-email: teach git send-email mode to
 translate aliases
In-Reply-To: <20240813-jk-translate-alias-send-email-v2-0-912db4eb6846@gmail.com>
	(Jacob Keller's message of "Tue, 13 Aug 2024 17:05:08 -0700")
References: <20240813-jk-translate-alias-send-email-v2-0-912db4eb6846@gmail.com>
Date: Thu, 15 Aug 2024 15:57:12 -0700
Message-ID: <xmqqplq9qtrr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B635800C-5B59-11EF-94C1-9B0F950A682E-77302942!pb-smtp2.pobox.com

Jacob Keller <jacob.e.keller@intel.com> writes:

> Jacob Keller (3):
>       t90001-send-email.sh: fix quoting for mailrc --dump-aliases test
>       t9001-send-email.sh: update alias list used for pine test
>       send-email: teach git send-email option to translate aliases

Seems to fail t9001 rather miserably on Windows.

https://github.com/git/git/actions/runs/10411559740/job/28835810137#step:5:2444

There seem to be way too many PREREQ related skippage, it is not all
that surprising (it does not make it excuable, though) if a new test
that comes later and not skipped is broken because earlier steps are
not executed.


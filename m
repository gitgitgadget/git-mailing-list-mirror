Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1D15227
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 01:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718759925; cv=none; b=WsV1uPvI8dOxU9RwTfbmNGoLWY3WpLcGhXR2LJVAgtdLjmPNhcc+8nwIf51quPe6FIsvhwwtK603nqbikQE/5CRTQ04toE9F5B17xDAwgA8HnRR5n7J9uVs4zxEDH29t1NTUMZTaURVSGjCqcV8vThggMLY6IGJexhXd3eR8OxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718759925; c=relaxed/simple;
	bh=ibdqBLlP/9I4G4cGcONU+d9WpR+t6pUneDKsdx7Loq0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q6nhoWbr3RFG/FD3cDifCX0SaPa3+mw2KOg/gMLL8x23jjW9SwCXZkNUWObujPn6rOWGrhl12pMi9DSd36a/kMqHZVscMIxLkUIr0S379y4Il67HVQkO0QWaeUjRJr1TlNe6t4U0JPCGWgoMdTzZYGELt4lKSUn6LITjc4x8OY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hCymzFzA; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hCymzFzA"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CD66B1FF46;
	Tue, 18 Jun 2024 21:18:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ibdqBLlP/9I4G4cGcONU+d9WpR+t6pUneDKsdx
	7Loq0=; b=hCymzFzAEFSFluo4KUyEuv7svgA7ekYFLH2QXQcXAHBRpriDH3LWt7
	XA3lOCCP5WPCHyb/BGWsz7EkvQyvffDUTU2/ZtdKIA/IM/vtG4s49vb/KEPZysJl
	GLp+TvLQHPoI8k/gQIkqNlMxmIeFLR2qVE5atrYNVdep873hBLbt4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C5C501FF45;
	Tue, 18 Jun 2024 21:18:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 04A481FF44;
	Tue, 18 Jun 2024 21:18:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] attr: notice and report read failure of
 .gitattributes files
In-Reply-To: <CAPig+cQy2e54Pjiu=7xw7Ox=OyxmFuoW6MU31JXXuXobQ_vvXA@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 18 Jun 2024 20:21:07 -0400")
References: <20240618233303.GA188880@coredump.intra.peff.net>
	<20240618234436.4107855-1-gitster@pobox.com>
	<20240618234436.4107855-3-gitster@pobox.com>
	<CAPig+cQy2e54Pjiu=7xw7Ox=OyxmFuoW6MU31JXXuXobQ_vvXA@mail.gmail.com>
Date: Tue, 18 Jun 2024 18:18:38 -0700
Message-ID: <xmqqplsdybkh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DC622864-2DD9-11EF-9659-C38742FD603B-77302942!pb-smtp20.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> ECANTPARSE: perhaps? s/errors/& be/

You're right.  Thanks.

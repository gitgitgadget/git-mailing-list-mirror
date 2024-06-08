Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB3E210FB
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717873256; cv=none; b=QcxvDxggHzOjquduweJ0XdcpWGfkyj9yEI5hAsjbFnNlc9wZgSE/SWfhPbd4LfBF3DDuC5kukUxfQoO5da4GRfF4Ln0mrL38EubpbqupNo9GLTZK/kxJo0n71jaLKUkR8Kb7j2TnEUVp3N0Ey1kb2xz0f4x5DoiQRUtTSnMBFso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717873256; c=relaxed/simple;
	bh=jgvfg5a+KvvoNYcSGNP/IVW9vdVDqCORP0qpPbL/J7k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h0dkFZpIHCghRq7SXKG+GPRFGa41MQ3w8uRaNCMJ/CsPSX7EyZsm6SIA3DPW1c0Z+qliVTxtuQuvF101HTflWQ8X6NkdsVxp0jS89gsDiitmgACJRIcOOCbu8Zdn1OC+Wswf7eeGCKvajTO7bdyeVvSWOs4H7O2rxcfTt56LLk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aMFatpMy; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aMFatpMy"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE00420BE9;
	Sat,  8 Jun 2024 15:00:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jgvfg5a+KvvoNYcSGNP/IVW9vdVDqCORP0qpPb
	L/J7k=; b=aMFatpMy7Yaj0XTjv/sC/zM0LgsP9j+faNSVDmBxmVfDdcGuDzW35f
	niNuom6oOhbopSS9KnATVnKxauu/r6p+uepDdYYuIPhgw4LoHAc7oeGT6o6v8DEn
	7lryMhrPyRlmndXS2qmN1Z176TwOGnhvxyOqkfJ2zJ2r1HqeI9k3U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A4C6F20BE8;
	Sat,  8 Jun 2024 15:00:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D34A20BE7;
	Sat,  8 Jun 2024 15:00:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: ellie <el@horse64.org>,  rsbecker@nexbridge.com,  git@vger.kernel.org
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
In-Reply-To: <20240608084323.GB2390433@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 8 Jun 2024 04:43:23 -0400")
References: <fec6ebc7-efd7-4c86-9dcc-2b006bd82e47@horse64.org>
	<0be201dab933$17c02530$47406f90$@nexbridge.com>
	<fdb869ef-4ce9-4859-9e36-445fd9200776@horse64.org>
	<0beb01dab93b$c01dfa10$4059ee30$@nexbridge.com>
	<200c3bd2-6aa9-4bb2-8eda-881bb62cd064@horse64.org>
	<20240608084323.GB2390433@coredump.intra.peff.net>
Date: Sat, 08 Jun 2024 12:00:51 -0700
Message-ID: <xmqq8qzfcl98.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6DBAB808-25C9-11EF-A5F7-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> One strategy people have worked on is for servers to point clients at
> static packfiles (which _do_ remain byte-for-byte identical, and can be
> resumed) to get some of the objects. But it requires some scheme on the
> server side to decide when and how to create those packfiles. So while
> there is support inside Git itself for this idea (both on the server and
> client side), I don't know of any servers where it is in active use.

Didn't the bundle URL work originate at GitHub?  I thought this use
case was a reasonable match to the mechanism.


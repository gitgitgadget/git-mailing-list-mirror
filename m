Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296C12746A
	for <git@vger.kernel.org>; Sat, 20 Apr 2024 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713633249; cv=none; b=P5duuko90J7RcFMF2LspNIBSTjH4pZHjKVhktkjA7P8eej35rGIRaShRZkC1GWGSmi8lxRl0e4yhEa03K8cWcTbCsIWuwZrX0Kug5bN7U5lzxCzF8DsL+UVJH/tYtEiiopBu8r8a5nXkxP3uF6RQ0iQvFXYfErhaMvtQYsQVSNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713633249; c=relaxed/simple;
	bh=EDOgTP0aSxHCeV/ZQOchl9eVxl5kNzRCxfMdHy/s1Gg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gy+HgeeZr4YASzN5RQJFB2ZSr20pTr4vNOvcxpBSmWUw4uA+1RqtWImZPzOaOMDrHowOJcSB0Ea+dffZlA9DJUQgFRjsGCXFlfmZXee+ef6zP7LZVvCLgXLwt7XDl6487oKn9h2lhlWQ3Lie1aRNsaRbCzroG+0VQElHQW/e8og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=m7wQd2rm; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m7wQd2rm"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 018FE1F779D;
	Sat, 20 Apr 2024 13:14:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EDOgTP0aSxHCeV/ZQOchl9eVxl5kNzRCxfMdHy
	/s1Gg=; b=m7wQd2rmLz8fWPuklZffh+08qsLcCcIOT2+btfi5d7h6vPyoCuC6bZ
	lVetAWJCiMQiiGSHDJLI+KgTiALf8hiDfqXjzMxQVKXjQ2uhHq1c/k5XBQr+79Tc
	OUkNZB4Ryr9GlFzjzqEf7AJ1++JiOEYaui8dsYnAtyhBmpPtAB1g4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DD3C41F779C;
	Sat, 20 Apr 2024 13:13:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 408901F779B;
	Sat, 20 Apr 2024 13:13:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Peter Krefting <peter@softwolves.pp.se>
Cc: Christian Couder <christian.couder@gmail.com>,  Jeff King
 <peff@peff.net>,  git@vger.kernel.org,  "Osipov, Michael (IN IT IN)"
 <michael.osipov@innomotics.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] bisect: Honor log.date
In-Reply-To: <4f0456c0-e926-ee60-4e14-6b8ed80d2ace@softwolves.pp.se> (Peter
	Krefting's message of "Tue, 16 Apr 2024 20:53:40 +0100 (CET)")
References: <3ec4ec15-8889-913a-1184-72e55a1e0432@softwolves.pp.se>
	<xmqqh6gni1ur.fsf@gitster.g>
	<5ea0837f-2668-028d-4094-c9400e92fceb@softwolves.pp.se>
	<xmqq7chif1pu.fsf@gitster.g>
	<20240401023225.GA2639800@coredump.intra.peff.net>
	<CAP8UFD0W7PUHTg2NwuVkQJik2+HqTDF6KRZZ8tA_dW7-YZtsbQ@mail.gmail.com>
	<xmqq8r1dfh65.fsf@gitster.g>
	<4f0456c0-e926-ee60-4e14-6b8ed80d2ace@softwolves.pp.se>
Date: Sat, 20 Apr 2024 10:13:58 -0700
Message-ID: <xmqqjzks3qjt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6087F8C8-FF39-11EE-9664-25B3960A682E-77302942!pb-smtp2.pobox.com

Peter Krefting <peter@softwolves.pp.se> writes:

> In this particular case, calling "git show" is really the last thing
> we want to do; so if we can move the cleanup that happens after it
> (that ends the bisect), it should be able to just take over the
> current process with a call to show, without needing to re-exec.

The cmd_foo() functions are also expected to either return to their
callers or call exit() themselves, and it is true that as the very
last step before giving the control back to the end-user in the
current "bisect" process, we could make an internal call to
cmd_foo() and let it exit with its own exit status.

But that is only the latter half of a story.

The cmd_show() (or any cmd_foo() in general) function expects to
start from within a pristine environment.  Calling them _after_
somebody else (in this case everything called from cmd_bisect())
clobbered the global state may or may not work (and in general we
should assume it would not work) correctly.

The outline of the envisioned end state of libification I gave was
about an arrangement to ensure that we can give such an pristine
state when we make a call to such "top level" entry point of "foo"
command (in this case, "show"), from a different command (in this
case, "bisect").  It is very much orthogonal to what you are talking
about, I think.  We need both.

> And calling back to the libification question, I would see this part
> of the bisect command to be something that would run *on top of* the
> library (with possibly an API to poke bad/good states into it), so I
> don't think that objection holds for this particular case.

There was no objection.  I was just pointing out that the infrastructure
is not ready to do so.

Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54851171D
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118737; cv=none; b=rU5Q2f689yX057zW1hqyg4WrGJnUxhL9xgw9WiLoVRZK6ttDaJ/eSTCkCpkKH/Zc8tSI5EzgRJQKIxMkx7cTJfexnRLH+vzI6h9lbNQmIFKulMygtL8Wy9h5gJA+8APNxUKL68gSh27GbwSqur5KT4e9g3G825TflgCQoDtSSG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118737; c=relaxed/simple;
	bh=eInFKtFfr8CQdvHTyjOJdcrMPmUQbq/ncYQ0frH5W+I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n8w7t8uYKLoY22ISUg3SWryvXPlPa4KnuTIeA5BlL4G4AZfgyunU2WqXddm+RutQK8vk1OV1emgtoQaJ/z1mHLqD3k1C2fo+jzPSKMK0RgaVrBPOYQoyjdQ6l9CIAIWblWCiYMUdb3V1MeyC0GcsMvsPHOt7ae7tF4ELcI0LN3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FAgoIIP2; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FAgoIIP2"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9FB98280E3;
	Tue, 11 Jun 2024 11:12:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=eInFKtFfr8CQdvHTyjOJdcrMPmUQbq/ncYQ0fr
	H5W+I=; b=FAgoIIP2i9+TVn7gbaUGYbbq4o3w9QsG9x1F9NLkQwksqyWVIP2jtn
	4+pzu/xMoyz+FRqRpMP3WjE1x42lZlpWbkxxMCh1UFPWLiUVWcm29ukBx/6uCBYH
	X0crfo8RFlwhWfmqv5bymPeGKhaNIh7sgVHtT4VHzUE2vSrKAMzIs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 98208280E2;
	Tue, 11 Jun 2024 11:12:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 050DF280E1;
	Tue, 11 Jun 2024 11:12:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Emily Shaffer <nasamuffin@google.com>,  ellie <el@horse64.org>,
  rsbecker@nexbridge.com,  git@vger.kernel.org
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
In-Reply-To: <20240611063123.GB3248245@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 11 Jun 2024 02:31:23 -0400")
References: <fec6ebc7-efd7-4c86-9dcc-2b006bd82e47@horse64.org>
	<0be201dab933$17c02530$47406f90$@nexbridge.com>
	<fdb869ef-4ce9-4859-9e36-445fd9200776@horse64.org>
	<0beb01dab93b$c01dfa10$4059ee30$@nexbridge.com>
	<200c3bd2-6aa9-4bb2-8eda-881bb62cd064@horse64.org>
	<20240608084323.GB2390433@coredump.intra.peff.net>
	<CAJoAoZkP58ZM4J3ejemyiqkkbEaQdphoyGj_LmX9-xb_eMgb4A@mail.gmail.com>
	<xmqq5xug1qrf.fsf@gitster.g>
	<20240611063123.GB3248245@coredump.intra.peff.net>
Date: Tue, 11 Jun 2024 08:12:12 -0700
Message-ID: <xmqqh6dzy0mr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FBBF8218-2804-11EF-9B46-6488940A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> I think they serve two different purposes. A packfile URI does not have
> any connectivity guarantees. So it lets a server say "here's all the
> objects, except for XYZ which you should fetch from this URL". That's
> good for offloading pieces of a clone, like single large objects.
>
> Whereas bundle URIs require very little cooperation from the server.
> While a server can advertise bundle URIs, it doesn't need to know about
> the particular bundle a client grabbed. The client comes back with the
> usual have/want, just like any other fetching client.

Yes, a bundle being a self-contained "object-store + tips", it is
a much more suitable building block for offloading clone traffic.

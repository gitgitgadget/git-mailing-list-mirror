Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9CA8C07
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710608562; cv=none; b=GNBw1Me/zXfk11QzjSqf1O8OorJuMjV/RkDEys/gK48ayKGM3Pj8glrfkwYJBCrOCYBkj9HnVjDAgAPcCreF4+UwHn2WqddKezVnoviw9XJlKXxTu8avdQTXuNZwTVioJFui8pVUH+5/AC4BsvKc3GBCdR8K/G1DdDSJn+0MG1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710608562; c=relaxed/simple;
	bh=pLxDUyc3j5sih31EZL+IYfYBXK0L2kUQGw7jszysdt8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uUIhHmjpFow/endqY6mpWdaUH7MImgXpsOMw+Gf1g6fJe56nY2gHRR9tH+VWq97wXYnj+zRlmH9dR6BPbRSgUaCe3+wL5laFPmh9z8fgRzucIHuzJrodJyGRv6MCFSgwL+z4G2Li6Z4DB/QbDRsj0Ckb6xMNTfl9N2dxqfxG3xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pzE/rzRO; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pzE/rzRO"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D778133189;
	Sat, 16 Mar 2024 13:02:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pLxDUyc3j5sih31EZL+IYfYBXK0L2kUQGw7jsz
	ysdt8=; b=pzE/rzRO4bgNs8nzF2I3EJSh6Hv7AKkRfDP5BDefTRFgiCaQ30AQc6
	pheDXh1Rlv0juxNW+70mvmdPpu5ORluzzJ/U0IEQnWo4ZB6Gc+tAZ2dAbxL42aGn
	ObDg4U8ajROfjA5Dzt4zzMmc4LJg4hu2qDKyJdtbpkkx3iju5zLL4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CE36933188;
	Sat, 16 Mar 2024 13:02:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 724BF33181;
	Sat, 16 Mar 2024 13:02:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Ignacio Encinas <ignacio@iencinas.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] config: learn the "hostname:" includeIf condition
In-Reply-To: <20240316065737.GA544929@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 16 Mar 2024 02:57:37 -0400")
References: <20240307205006.467443-1-ignacio@iencinas.com>
	<20240309181828.45496-1-ignacio@iencinas.com>
	<20240309181828.45496-2-ignacio@iencinas.com>
	<20240316065737.GA544929@coredump.intra.peff.net>
Date: Sat, 16 Mar 2024 10:02:31 -0700
Message-ID: <xmqqo7bem7o8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FB4E7416-E3B6-11EE-8307-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> Do we need to define "hostname" in more detail here? Specifically, I'm
> wondering whether the result will be a FQDN or not (i.e., the output of
> "hostname" vs "hostname -f"). Looking at the code I think it will just
> be the short name returned. That's probably OK, but it may be worth
> documenting.

That was my first reaction but there are places where "hostname"
already gives a name that is not "short" at all, without being
invoked with "-f".

For example, the (virtual) workstation I am typing this message on
sits in a $WORK datacenter, where "hostname" gives the same string
as "hostname -f", which looks like "git.c.xxxxxx.tld" ("git" is the
only part I picked myself for it, "c" is shared by those employee
workstations hosted at datacenters, "xxxxxx.tld" is redacted to
conceal the real domain name to protect the culprits ;-).

I think the most honest answer we can give in the documentation is
that we use what gethostname() [*] gives.


[References]

* https://pubs.opengroup.org/onlinepubs/9699919799/functions/gethostname.html

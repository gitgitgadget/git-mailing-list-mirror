Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A45145A0F
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 21:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722549133; cv=none; b=QzbiDKqaWbzmY2MR1Le+RHCNXREtRclQDkcnqSLTGiXVjMaSepdk4lZdOlbiqgc4IyEWIcqDdJWl5ZQiL9+y4tNb0D+TVIPiUSIeM1UmBLaEjyJzu59WqX2a9BhnRpfimOTUJ3vzV5mYYN6eHbLAYiD5eBMQeA+WcEQlW7Xqg7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722549133; c=relaxed/simple;
	bh=pipHfIwkLdzDzhrJZgkIwcrDO2lZko/af8VmWUvM6tQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QYDBFMRBY4Hfter5skmTZN02/M+1zBS0aFPFmLJ1KWrJihH/E+nRFTtYKPOmLdPQuHxnMqMnSJaQW/VbRZQgkPnUz8Ei45BEcOD3CcO3n1WPFOu8D2NJRfd/DscIt5W0boBBJmtVuec7bTLCjPbSdjNgX44Hgd2qxRNyZcAJhNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FFrJPlCm; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FFrJPlCm"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C69C2BB6E;
	Thu,  1 Aug 2024 17:52:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pipHfIwkLdzDzhrJZgkIwcrDO2lZko/af8VmWU
	vM6tQ=; b=FFrJPlCmoDVX9ghNBM406pAYRB/0uW37FMpHkLm8bdHG7PVYx7OHPJ
	lqAhFtB7hkxhierAnUnItxpwaPLhq/jSt81nBXqz9e1EIAjnuXMoXvLCuPU7sI6u
	p/mqwBVNloBpl+zM7V50O8fGXTc0YbFqUPGc+9WZUnMFGAwKWDpXU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 64C0D2BB6D;
	Thu,  1 Aug 2024 17:52:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5A5322BB6C;
	Thu,  1 Aug 2024 17:52:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org,  "W. Michael Petullo"
 <mike@flyn.org>
Subject: Re: Git clone reads safe.directory differently?
In-Reply-To: <Zqv9b_B5wKGp331o@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 1 Aug 2024 21:26:07 +0000")
References: <ZqZjRMqpEV_3WIkD@imp.flyn.org>
	<20240728224807.GA1299337@coredump.intra.peff.net>
	<ZqjQi6i2kiY4gcc1@imp.flyn.org>
	<Zqlo-i8uCb1Yr4Jm@tapette.crustytoothpaste.net>
	<xmqqv80m8pha.fsf@gitster.g>
	<ZqlxtGIyz0G9jlJr@tapette.crustytoothpaste.net>
	<20240731072832.GB595974@coredump.intra.peff.net>
	<xmqqo76d7coa.fsf@gitster.g> <xmqq1q391afc.fsf@gitster.g>
	<20240801061417.GD621899@coredump.intra.peff.net>
	<Zqv9b_B5wKGp331o@tapette.crustytoothpaste.net>
Date: Thu, 01 Aug 2024 14:52:04 -0700
Message-ID: <xmqqplqrud17.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4B5E74E6-5050-11EF-85E7-92D9AF168FA5-77302942!pb-smtp20.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The other case, where is_local is not set (and thus clone_local is not
> called), calls transport_fetch_refs, which either calls
> fetch_refs_via_pack or fetch_refs_via_bundle, both of which I assume
> actually make a git-upload-pack call.

OK.

> One related topic that is potentially interesting as well is whether
> `git bundle create` also offers the same security guarantees as `git
> upload-pack` in that it can be safely run on an untrusted repository.
> Either way, we may want to document that.

True.  I think "bundle create" in that regard can be viewed as a
thin wrapper around pack-objects and there is no customization
possibilities (smudge/clean filters, hooks, etc.) that malicious
repositories can take advantage of.

But what worries me more is the fact that any such evaluation can
only be about the current state.  A careless change to say
pack-objects [*] that allows innocent looking customzation to take
place _could_ turn out to be triggerable by the repository when
upload-pack is run, and the "innocent looking" customization may be
more generic than necessary and can be used creatively to cause
damage.  "Don't allow any customizations to 'rev-list' because its
internal is shared with 'pack-objects' that in turn is run from
'upload-pack'" would not be an answer.

It is unclear to me how to make sure such an evaluation done once in
the past will stay valid.  That is something we need to come up with
a viable approach and document, too.


[Footnote]

 * ... or rev-list or any pieces of machinery that are recursively
   relied on by a command that ought to be kept safe.

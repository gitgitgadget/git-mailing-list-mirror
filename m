Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C7E18A929
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718646297; cv=none; b=BGSbXe6BzXa/Vs9obCwOGIlLHlvIGoaDpWaRj+IQJcqOuPa3/tWdyGEyMC9r5k8iWc1XKxMhMXbdPP90qrvstG/RIYfP8T0WGUsOhV1uX+d2PH7ToS66DG61AqnJ/12Mx4fL+djzszLeXWjNIuuv9pi01VW2TqVBcYDQc484rrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718646297; c=relaxed/simple;
	bh=YayhWOlaw4/ulanX1r/gOc/Z3mg2zYfAvgF3urGB9T0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JZmlxzKCHQygs2wnzgSdXOqaZvG3roba5eDnrlglmMDqonUovtDHrPP0cGWE4oM9R92Y2Zwyl9737OdDKw61M1MIm0f8+z8YzAnshSqG0FLAUq2vcBoeuiZjFCNHDeklajLVqZBFJZ+zDBbABSdtkiJReFuQbwqBUzCmrihvYx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CVyn3ccy; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CVyn3ccy"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A0E001DF21;
	Mon, 17 Jun 2024 13:44:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YayhWOlaw4/ulanX1r/gOc/Z3mg2zYfAvgF3ur
	GB9T0=; b=CVyn3ccyGtLXG91DpPDOYKWDot/vDGktkhta24ak82w9c7em370jX8
	a1M5d3aG/SaS3Dw9QRVNtzhN4jJZOEeTvaq8IonwQW+P+nyVQJ7ZwBDqqAexiFJF
	bwO6cRqCgzxIl/KPOjuz9hq5snABS4A1VXA4weprpdwHdDsVs8WZg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 98C641DF20;
	Mon, 17 Jun 2024 13:44:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0AC6E1DF1F;
	Mon, 17 Jun 2024 13:44:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,  Christian Couder
 <christian.couder@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  ach.lumap@gmail.com,  chriscool@tuxfamily.org,  git@vger.kernel.org,
  kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v3 2/3] t/: port helper/test-sha1.c to unit-tests/t-hash.c
In-Reply-To: <20240616045259.GA17750@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 16 Jun 2024 00:52:59 -0400")
References: <20240229054004.3807-1-ach.lumap@gmail.com>
	<20240523235945.26833-1-shyamthakkar001@gmail.com>
	<20240523235945.26833-3-shyamthakkar001@gmail.com>
	<ZlCWcpcUkgUMWJYz@tanuki>
	<CAP8UFD1=yjZEZWvMYKq1RyY8fMSHze4XcLbCZMSFhCLBheaM+w@mail.gmail.com>
	<xmqqo78vnrba.fsf@gitster.g>
	<6fhpz4aqq7jr6ca2durig7e5a37g6ndzjjc2v46kjjkldohtja@tu7cdo4tu2r6>
	<20240616045259.GA17750@coredump.intra.peff.net>
Date: Mon, 17 Jun 2024 10:44:52 -0700
Message-ID: <xmqqr0cva2gb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4E06A1D4-2CD1-11EF-A99D-965B910A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> So no, git-hash-object can't be used to test this. You have to directly
> hash some contents with sha1, and I don't think there is any way to do
> that with regular Git commands.
>
> So I think we need to keep some mechanism for computing the sha1 of
> arbitrary contents.

You're right.  We'd need a separate test helper if we wanted to keep
using the shattered sample files as-is (which we do).

Thanks.

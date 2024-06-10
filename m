Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82969210E7
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718051658; cv=none; b=HtUu6dfxQy9WqY/1OZCIlzI6sj5Z/vcEhcttg1lmkqzsiHo0Djdb6XWsvVl3yfoz69fwzHeWY3qe3o4TuyLruSC/z2LZ2AKDd/9UllfCOw9A2kVdpGZlalHAQHFdUQ4k7r3wToHA1ABjWkDNzyax3vgqOp35OnZv4RgtU/OIM1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718051658; c=relaxed/simple;
	bh=waAz8tro8gN+m2meMqFi/GgDuj+JtPz4qPrQs3pZ2BU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YtkogahVB4qMREay4F2Qb1ggEuzMRKjAJC5GUkegxi+3GmyuKdhwmP9PaS2Krr/6iWB6J0ymKVRErDWOlYWqPbid5dmCUaAFJUY+xZKFUcHEmpjvFNI9GZaeaN2vZkuOdnascNXBGcEG1yDfkPQ8s9BDf2AJP5gbgrxRx/j7t74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OXBYQVMt; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OXBYQVMt"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 093201F9F5;
	Mon, 10 Jun 2024 16:34:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=waAz8tro8gN+m2meMqFi/GgDuj+JtPz4qPrQs3
	pZ2BU=; b=OXBYQVMtn7i+CNVAOvsk3TrindWkHph8gVvDRL8EZouyD9ocHWFTd3
	irPcOY6jhHKzT4orLCfRmfFx9JOFkz3O24tk5bXXTX8Hgsv6JAUzrUW0hfg59peA
	HdN0GVnCyJ5ducgLvDV3JlHLo1LS4fypBlq/R7UKCO/8rKKWkMxAo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 028371F9F4;
	Mon, 10 Jun 2024 16:34:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AAF861F9F3;
	Mon, 10 Jun 2024 16:34:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: Jeff King <peff@peff.net>,  ellie <el@horse64.org>,
  rsbecker@nexbridge.com,  git@vger.kernel.org
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
In-Reply-To: <CAJoAoZkP58ZM4J3ejemyiqkkbEaQdphoyGj_LmX9-xb_eMgb4A@mail.gmail.com>
	(Emily Shaffer's message of "Mon, 10 Jun 2024 12:04:30 -0700")
References: <fec6ebc7-efd7-4c86-9dcc-2b006bd82e47@horse64.org>
	<0be201dab933$17c02530$47406f90$@nexbridge.com>
	<fdb869ef-4ce9-4859-9e36-445fd9200776@horse64.org>
	<0beb01dab93b$c01dfa10$4059ee30$@nexbridge.com>
	<200c3bd2-6aa9-4bb2-8eda-881bb62cd064@horse64.org>
	<20240608084323.GB2390433@coredump.intra.peff.net>
	<CAJoAoZkP58ZM4J3ejemyiqkkbEaQdphoyGj_LmX9-xb_eMgb4A@mail.gmail.com>
Date: Mon, 10 Jun 2024 13:34:12 -0700
Message-ID: <xmqq5xug1qrf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CCC299A6-2768-11EF-8FAD-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Emily Shaffer <nasamuffin@google.com> writes:

> It seems to me that packfile URIs and bundle URIs are similar enough
> that we could work out similar logic for both, no? Or maybe there's
> something I'm missing about the way bundle offloading differs from
> packfiles.

Probably we can deprecate one and let the other one take over?  It
seems that bundleURI have plenty of documentation, but the only hit
for packfile URI side I find in the output of

    $ git grep -i 'pack.*file.*uri' Documentation

is the description of how the designed protocol extension is
supposed to work in Documentation/technical/packfile-uri.txt and not
even the configuration variable uploadpack.blobPackfileURI that
controls the "experimental" feature is documented.

Perhaps whoever was adding the feature to the public side stopped
after pushing out the absolute minimum and lost interest or
something?  We should update the documentation to reflect the
current status (e.g. is it still experimental? what more work do we
need on top of it to make it no longer experimental?), add at least
minimum description for server operators how to configure it on the
server side, etc. (I am assuming that the end-user does not have to
do anything to get the feature, as long as their version of Git is
recent enough).

Thanks.


Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECACC381B6
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 05:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594043; cv=none; b=cAnfjsNwQ4i+s0HZP74+EfPgjcStBCVCByqo1+Yv9GVLAU6yKFBMYjnjfmy3MmbNaFANNs2++8Vj+MTS0u4KljKJPTQhl5+4NtqVbaX2j0AVchVLxKvUXYK2QXzlRdgXZYVmeIEAJ49gOsp1XNDZAZsLFZg87qqbYUf9zPqWcwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594043; c=relaxed/simple;
	bh=z00+047cTw2qaQaTPUnrVNs3i0DjOdwUvISjxeoK4Dw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CumJ0GluPD9v0aueIUWVkgJcqkTpefmkecqCScn4zGLKqndaPo9VjHeRxKgpWriC3mzvfKMz2dJ5e+QKqPEN7c2ROQDCF5u0z3DCeLBWss4m0xfxWMmMYC4WxTCAOX5N4IQti5bZIU7tt1zK0rgCmbUj4ffuETOqXtCXb20EvqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oda5r3t6; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oda5r3t6"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 50D3B25586;
	Tue, 30 Jan 2024 00:54:01 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=z00+047cTw2qaQaTPUnrVNs3i0DjOdwUvISjxe
	oK4Dw=; b=oda5r3t6K2VsqBAObrxal3ghsdn7Io47XaZx73fmcyWCHLNtd6wd/O
	ZSeGBmzpZjySiNM7Q0WkHCylbf0QuLelqim/1vcyMS1hKjHlX1T6Csm4+RVgYKR5
	TaWdXWQPagh6k56wN/N1WVzoyy7zqEWQ5NKd61QCYPd9hKWbVvKsk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3CBE625585;
	Tue, 30 Jan 2024 00:54:01 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 324BB25583;
	Tue, 30 Jan 2024 00:53:56 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Sergey Organov <sorganov@gmail.com>,  Elijah Newren <newren@gmail.com>,
  git@vger.kernel.org
Subject: Re: what should "git clean -n -f [-d] [-x] <pattern>" do?
In-Reply-To: <20240130054401.GA166761@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 30 Jan 2024 00:44:01 -0500")
References: <87il3h72ym.fsf@osv.gnss.ru> <xmqq1qa5xq4n.fsf@gitster.g>
	<87ede56tva.fsf@osv.gnss.ru> <87a5ot6tos.fsf@osv.gnss.ru>
	<xmqqzfwspmh0.fsf@gitster.g> <87ede4fg8s.fsf@osv.gnss.ru>
	<xmqqzfwrjdul.fsf@gitster.g> <87jzns7a8a.fsf@osv.gnss.ru>
	<20240129182006.GC3765717@coredump.intra.peff.net>
	<87v87bx12j.fsf@osv.gnss.ru>
	<20240130054401.GA166761@coredump.intra.peff.net>
Date: Mon, 29 Jan 2024 21:53:54 -0800
Message-ID: <xmqqv87bcqod.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F48D8470-BF33-11EE-B641-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> I know that isn't necessarily relevant for new users today, but my point
> is mostly that we have clean.requireForce already and people would
> probably be annoyed if we took it away. :)

Sounds quite sane and sensible position.

My favourite question Git Rev News may ask their interviewee is "if
there were no existing users to worry about, what would you change
in Git?".  I have many things in my mind I would change if we could,
but they remain only in my fantasy, because we have to care, and I
have to fight for, those existing users who are silent majority,
simply due to the age of the tool.

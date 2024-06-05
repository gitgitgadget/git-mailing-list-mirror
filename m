Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D88188CAE
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717605006; cv=none; b=svU7j4iW0znQiL3PyylvDFm5fL7aGKhQUcy2C1k82Qpvw/wz2luqCHX/k6UU5XReaUZuDzeru/9UkX+tSX7QSqjtqgbRIr3uUK+Pj9AM+uxtZsMVB34N5/0PKIgajOpP0/xUMweX2yvRbnfUXum8fo0eDHIW4VP8pvHhhGImNMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717605006; c=relaxed/simple;
	bh=GdRLqOUJqSGovCCOCzsB4ygcPX9SHywJ2mSQl9liWPE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PAjBdegiyvgE+La+4l1xapMgIUZxIn1jme2OnM9KDsjWc90iKzUAdYilyu+50mNfIE8h6SqBN3AzKPRzexQ/5rxzMpaDREOHnOqJm/15GgzLzyKRC1Lb8j6UQ5GGKHVWbH+CDSFXh3RBjUxHJN58LIw92ULcuO0UT7URcI84Ua4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fjxogTtL; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fjxogTtL"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 25FED1B023;
	Wed,  5 Jun 2024 12:30:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GdRLqOUJqSGovCCOCzsB4ygcPX9SHywJ2mSQl9
	liWPE=; b=fjxogTtLCjm5h0uAPK2nEvrLT8bjx1xpetPPInPUAGLYtC9dIuKn2+
	JPwjWk0JJehud9FP2TDGgdLk268o6owv/lwMrFX8f193wdp9/eu6htCaHisVAqr5
	6fqmxFAZ9vliTVoGrfOHoh/OOwqBMASfvcQs4Cc9h5+yPwnG7J2CE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1E8D51B022;
	Wed,  5 Jun 2024 12:30:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 15DA21B01F;
	Wed,  5 Jun 2024 12:30:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2024, #01; Mon, 3)
In-Reply-To: <20240605083526.GB2345232@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 5 Jun 2024 04:35:26 -0400")
References: <xmqqo78h1bdg.fsf@gitster.g>
	<20240604085200.GA1147131@coredump.intra.peff.net>
	<xmqqzfs0tv0b.fsf@gitster.g>
	<20240605083526.GB2345232@coredump.intra.peff.net>
Date: Wed, 05 Jun 2024 09:30:00 -0700
Message-ID: <xmqqle3juzcn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DBA946D6-2358-11EF-8AEE-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> I do think it's the wrong fix in the long term, and we'd want a patch
> like this on top of the merge of jc/t1517-more and ps/no-writable-strings.

Oh, of course.  The "other topics" restructure the cmd_main() to
have a single exit point where we can release resources centrally.

Thanks.

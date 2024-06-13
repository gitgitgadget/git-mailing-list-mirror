Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA89E145B3F
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293656; cv=none; b=ut+BJtZofgiJ30Z0YMHi4Fq78TbgEu96L2wuQcqO9ar3Lx1fhNwXa5CuW72a3YurP+NCB7DPVb721Osia6uZX1qqLuIt4LNijiRK2FIzIZnJbFoEJ84TW2EcnbWcQGIymOjF11dPLRZT9ssGtFaCcOHJo/0PHp/FWnsFB1mCJz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293656; c=relaxed/simple;
	bh=Mpe241C5wWuuTt+el8Ch/MipWReMu4mblQPnDI9aPdI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dwnE5MW6f3ddW9XVPOvdgqtfinffvsVIejUeR45O9ke618RHhLDnQaYReroYbVEODFYLjWNzJGDjrNrC6JIUS2bIQ7dqCJ2VZskBQnWau5M8SJR5mEnSH6JvqNLp4388byV9mXtjx741hF1V1LiM0A/jI88hG7naZeNbOMT1enM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IPVZkK41; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IPVZkK41"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC7E8299EF;
	Thu, 13 Jun 2024 11:47:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Mpe241C5wWuuTt+el8Ch/MipWReMu4mblQPnDI
	9aPdI=; b=IPVZkK41ofsBQLzTgJrEqh5dqajuRIrKNR+XXz+yRMVfcjxOxtvZjW
	qzp9011g54pw4ihl+pmtFRCPGjTD4XytM4k+VC7SohxMfIAf+klz3lT+PQtq7el0
	T+Q9luFuXcr6HfceBwlV1R3oCWyB93a2agd58ShesHCpBb6G7o0YE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A450A299EE;
	Thu, 13 Jun 2024 11:47:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 153A4299ED;
	Thu, 13 Jun 2024 11:47:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH v4 2/2] ci: compile "linux-gcc-default" job with -Og
In-Reply-To: <20240613101522.GC817573@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 13 Jun 2024 06:15:22 -0400")
References: <cover.1717655210.git.ps@pks.im> <cover.1718001244.git.ps@pks.im>
	<03270d3414117ae7229d87127cff81e349557039.1718001244.git.ps@pks.im>
	<xmqqed946auc.fsf@gitster.g> <xmqqo785olpp.fsf@gitster.g>
	<20240613101522.GC817573@coredump.intra.peff.net>
Date: Thu, 13 Jun 2024 08:47:32 -0700
Message-ID: <xmqqr0d0n8tn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3FA2D6FE-299C-11EF-B3CC-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> I think you could do it with:
>
> 			if (data)
> #pragma GCC diagnostic push
> #pragma GCC diagnostic ignored "-Wuninitialized"
> 				munmap(data, mtimes_size);
> #pragma GCC diagnostic pop
>
> which is...ugly. There's a _Pragma() operator, too, which I think would
> let you make a macro like:
>
> 			if (data)
> 				SUPPRESS("-Wuninitialized", munmap(data, mtimes_size));
>
> which is maybe slightly less horrific? Still pretty magical though.
>
> But if the alternative is to do none of that, and just continue to avoid
> looking for warnings with -Os, I prefer that.

Oh, we are in agreement.  Such effort to annotate code and tolerate
inconvenience is better spent elsewhere but expertise and competence
are not as fungible as I wish them to be ;-)

Thanks.

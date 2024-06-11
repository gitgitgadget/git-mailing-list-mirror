Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F2125776
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718127034; cv=none; b=Xyqw26eKzYKWI6AOw1zEOS74bBFzuWOMfxo3xzhSUq7aClnfaEgm2aLcx01MF9f8fCO3AbOy4narWgNTiNAlMtWvflSHw6q4x/50/kliUNbWxCbEF6MeztJQk6GUIAhrkFW7ZrJqMn+wRt9PVDFiz3ugiyUgQGZKC1w7JFxF9j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718127034; c=relaxed/simple;
	bh=W/1cEEpl0/cnBlx2Dfr70D37vqjg+53xZL+fJrrXlQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R6Ec5bm0U00IkeUcJXD0nEjrQ+C7o3ydy2OdPq7uICpENmOysPk2w7Stt6PlixxG8WEmUMx1Kn4tvBEf4X7Kb1CnnxXwkGcHguOtJJg4YiV7EMYKQz3mcqh1IGuU3lrmUEr1JB4NAdB9jJObPE3eb2azV0PoNbXrVS8BcsbtrpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HajDKbgr; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HajDKbgr"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 51A6928FCA;
	Tue, 11 Jun 2024 13:30:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=W/1cEEpl0/cnBlx2Dfr70D37vqjg+53xZL+fJr
	rXlQk=; b=HajDKbgrgj6yUxy8yfvf4Z6NbMjsAMjM9AhblwmsJUlaHB8P1AGFw5
	0zE+4bgcdIMg8Of1jgfGD3mUhBIeMAgqThqTxN0Ww7HdwscOspuJPGMzBLHG9V1e
	5tzF5Yx9hnLHCFCWnNErQe4KlPAbvWTs/ZdfsoHrWKYEMbIPK2LMY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 495D328FC9;
	Tue, 11 Jun 2024 13:30:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AFD5328FC8;
	Tue, 11 Jun 2024 13:30:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] DONTAPPLY: -Og fallout workaround
In-Reply-To: <Zmg-jl83UA0P2Dnk@tanuki> (Patrick Steinhardt's message of "Tue,
	11 Jun 2024 14:09:50 +0200")
References: <cover.1717655210.git.ps@pks.im> <cover.1718001244.git.ps@pks.im>
	<03270d3414117ae7229d87127cff81e349557039.1718001244.git.ps@pks.im>
	<xmqqed946auc.fsf@gitster.g> <xmqqjziw3arr.fsf@gitster.g>
	<xmqqsexk1s43.fsf@gitster.g> <Zmg-jl83UA0P2Dnk@tanuki>
Date: Tue, 11 Jun 2024 10:30:24 -0700
Message-ID: <xmqqtthzwfnz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 49FC9B38-2818-11EF-8DB4-965B910A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The real bug that "-Og" would have been able to detect was reported by
> Peff via [1]. In this case it wasn't "-Og" that detected it, but
> Coverity did. But it would have been detected if we had a job that
> compiled with "-Og".

Thanks.  It is curious that you singled out "-Og" here, but with the
usual "-O2" optimization level, it does not seem to get noticed.

> But now that I see the full picture of this with different compiler
> options I have to agree that this is not really worth it. Especially not
> given that Coverity is able to detect such cases, even though that only
> happens retroactively after a topic has landed.
>
> Let's drop this experiment.

OK, but let's keep the CFLAGS_APPEND one ;-)

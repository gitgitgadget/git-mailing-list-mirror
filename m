Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD1628FF
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 17:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829649; cv=none; b=TuRefzNBXffOgKY4l7rttznjBk7yv5ZFG1WBMHzc3MMK7o81pNbflGcP2pYBkJPWDpBLpXSOAZl8SBGIuVgswVG452QrDdbY6Kkdu0ZgMV1sziCFNVvZHDJauqBsNVmoZ9q0Faax785qpb3tIA1hvq9gBXejlKTP725TvIRbax8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829649; c=relaxed/simple;
	bh=NflbsY+ZaVv2hMiMgUBg8Qy3zxiwybjAELqmn75Q8QI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ma9/k84FBomclc5zZe1l5dHrOdv20Rt/4tnx/HqjlUZPhknXZmncASdrW7SE7XRfqtmQdCtbu4ZG2uMgKl+IPiBYhkV0GdvbjefkG5sqGc5DMc3PwO7bJrlPSvne4Gv9re8vcbRpSdwwTPiuo/CpCxo34mkxb/YOHbNZaG8EVOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=i3dCgu0E; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i3dCgu0E"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C6252E6C0;
	Fri, 16 Aug 2024 13:34:07 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NflbsY+ZaVv2hMiMgUBg8Qy3zxiwybjAELqmn7
	5Q8QI=; b=i3dCgu0ECR59RVk166esvuxsPgQo9Z41OEuE0QlIm3VeKNX/vDh/M/
	N69SgauAHic78NW7mWR3R9oJd40YiLMdVnwiHiJszWz1Yb/1EM4X7m/XabXK2dYH
	GWCkPzXYtuR2unBQPKzk1DFqXjdsWHmpBhrRAdYfyBXf4uZdmwRRE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 239192E6BF;
	Fri, 16 Aug 2024 13:34:07 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 46AFF2E6BE;
	Fri, 16 Aug 2024 13:34:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Matheus Tavares <matheus.tavb@gmail.com>,  git@vger.kernel.org,
  johannes.schindelin@gmx.de,  newren@gmail.com,  Rodrigo Siqueira
 <siqueirajordao@riseup.net>
Subject: Re: [PATCH] rebase -x: don't print "Executing:" msgs with --quiet
In-Reply-To: <Zr8NOh-gMuhp-p0M@tanuki> (Patrick Steinhardt's message of "Fri,
	16 Aug 2024 10:26:34 +0200")
References: <767ea219e3365303535c8b5f0d8eadb28b5e872e.1723778779.git.matheus.tavb@gmail.com>
	<Zr8NOh-gMuhp-p0M@tanuki>
Date: Fri, 16 Aug 2024 10:34:05 -0700
Message-ID: <xmqqa5hcl6cy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BCB841DE-5BF5-11EF-B1AE-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>>  			if (res) {
>
> Do we also want to add a test for this fix?
>
> Other than those nits the fix looks obviously correct to me, thanks!

Thanks for a review.  I agree that this is almost there but would
want a test.


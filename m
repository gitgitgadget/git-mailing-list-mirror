Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CA01A38F2
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979455; cv=none; b=cxRz6sRQCiUATa2hi+LLcQdsH/ur7VEaZk+aLJY6/s0EYcT/gDbJaltQbWU3tFkym1kes6oQY0RMudO9BJ6aueHbaNrbpXUnNv+X9+1a+EVvt2ATujmEQzS1uS164rMdyVR0w8x9BiA2/VzitsXWSjfgrsX0RbVS6o1HbvuqPCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979455; c=relaxed/simple;
	bh=QgrIsvAvVxZxxG/5CvdaDJvWAKtKWFZ/lryFtBaETrY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eqQSLr3jx6jFG2HouzvYCRWBVoz6TSMntNw4OOi6HCOsJxnj0j62rpCV4pzAF2uk3VBKlnw3I8bwzNNqYQqphJn0dUD9B0SLjCt2XooeBl5nC4brSJMX3xzwaRZC52AUTRug3mpOTpnMMgNsk1zY3Hz95rrAJNTWVELgSFm+vT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wbvCfnyj; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wbvCfnyj"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6194A30430;
	Tue, 10 Sep 2024 10:44:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QgrIsvAvVxZxxG/5CvdaDJvWAKtKWFZ/lryFtB
	aETrY=; b=wbvCfnyjatXx5yV1JL5wYL4Wkc1Q8D/zaYycf2QxV/TVNIP2vLuGdE
	xyGRzDjY4r9XSAATIG3Tr7VcTA6mGN0WyT36OgsyMxGVFU39Diovya5ZxOE2lhAB
	7QdfdBD9WIYFhbEKQrdLSt7hOU3UAYyBeaWwWM2EsbCfB7HzL9QSM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 57E423042F;
	Tue, 10 Sep 2024 10:44:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8B35A3042E;
	Tue, 10 Sep 2024 10:44:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Calvin Wan <calvinwan@google.com>,
  git@vger.kernel.org,  Josh Steadmon <steadmon@google.com>,
  spectral@google.com,  emilyshaffer@google.com,  emrass@google.com,
  rsbecker@nexbridge.com,  mh@glandium.org,  sandals@crustytoothpaste.net,
  Jason@zx2c4.com,  dsimic@manjaro.org
Subject: Re: [PATCH v3 4/6] config: add git_configset_alloc() and
 git_configset_clear_and_free()
In-Reply-To: <c8d65466-a9c3-4556-84c1-3daf0c7cea14@gmail.com> (Phillip Wood's
	message of "Tue, 10 Sep 2024 09:50:25 +0100")
References: <20240906221853.257984-1-calvinwan@google.com>
	<20240906222116.270196-4-calvinwan@google.com>
	<CAPig+cRKbvWT3Bx65-ULAYRSrrKTCL0C7r6xpNSdN5JjLBPjCQ@mail.gmail.com>
	<Zt_qM8ZGN4fnqUoY@pks.im>
	<c8d65466-a9c3-4556-84c1-3daf0c7cea14@gmail.com>
Date: Tue, 10 Sep 2024 07:44:10 -0700
Message-ID: <xmqqjzfjo9fp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 24855EAA-6F83-11EF-A39A-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 10/09/2024 07:41, Patrick Steinhardt wrote:
>> Is there ever a case where one wants to
>> allocate the configset, but not use it?
>
> That was my thought too - I suggested providing git_configset_new()
> that would allocate and initialize a config set in my response to the
> last round [1]. It is good to see that the struct in now namespaced in
> the next patch but separating out allocation and initialization makes
> the api harder to use than it needs to be. I'd also like to see
> git_configset_clear_and_free() become git_configset_free().

Makes sense.

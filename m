Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C761A4F35
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722523236; cv=none; b=vBpKSXD04aRRs0FkZvml2BwwWczf4C/XaXfeIRLPd5T+BsFvDLafR3aIWObJ45Pq0C6E0NCCGsJkKTJg6J2eqREeHE8aYH8dZ5BQHWcE+Bw2UPBTYWo5UA0RZZtkGu2BQSdJsbKbNXaRBlMw+0KPBPnA2M0FfZejY+3bUaedJTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722523236; c=relaxed/simple;
	bh=JE4R+CLwbhJx5tLMiV/xZ3TV0wXMQPRgjSLGiMxLEWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ry9WbJNR0JjXtS04FuzSku+lurwsoOOmGVvlds7w6LbwIZ/TLUow0k6xVjnF4f0JEkl9k4NReootvprK/ns3S8jX3T5ZW+M8Rd6QKsAyO+bnmbEvdqOX8IF4fRstrvapjBX7XB5nzsYLsZDHOu4AmCvcQ072085NfUUJvG54Oz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kt1vXR0d; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kt1vXR0d"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A8621BBB5;
	Thu,  1 Aug 2024 10:40:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JE4R+CLwbhJx5tLMiV/xZ3TV0wXMQPRgjSLGiM
	xLEWA=; b=kt1vXR0dxaF8VArbq0CZOSfNj8ZJVbnbf/qWblstXngDyrdJ6+sTmu
	sWWqgQMecqwltIUGUGfOVlLLAa3QnhCPypFIS7jj+7lKMpxVMwF0YjtAzYFlgTG0
	ozeWzZd1tOm8YfxVBA0WyCrBwhMoH4AKhTwY8489cRH9Q30tKDotU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 507401BBB4;
	Thu,  1 Aug 2024 10:40:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B552D1BBB3;
	Thu,  1 Aug 2024 10:40:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Ryan Hendrickson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Subject: Re: [PATCH v3] http: do not ignore proxy path
In-Reply-To: <20240801054523.GA621899@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 1 Aug 2024 01:45:23 -0400")
References: <pull.1767.v2.git.1722062682858.gitgitgadget@gmail.com>
	<pull.1767.v3.git.1722441675945.gitgitgadget@gmail.com>
	<xmqqle1hyzcu.fsf@gitster.g>
	<20240801054523.GA621899@coredump.intra.peff.net>
Date: Thu, 01 Aug 2024 07:40:31 -0700
Message-ID: <xmqqfrroxq5c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0190972C-5014-11EF-902F-BAC1940A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> I think Ryan picked up this approach from my earlier mail. And the
> reason I suggested doing it this way is that the prereq test has an
> important side effect: it creates the socket and starts the proxy
> server!

Ah, OK.

> I think lazy prereqs only make sense when their only output is the
> yes/no of whether we match the prereq. And then we don't care when or
> how often they are evaluated.

Once the prereq test is attempted the result is cached (that's the
whole point of lazy prereq mechanism) so we won't see multiple sock
proxies spawned.

> I do think things would work, assuming the
> proxy server then can serve multiple tests. It just feels weird, and
> doing it more like the git-daemon/http tests made more sense to me
> (though those ones do not even do their work inside an expect block).

OK.  That's fine.  It is probably not a good fit for the pattern.

> If we did it in a lazy prereq I think you'd need to munge the path, as
> the lazy prereq operates in a throwaway directory (so the %30.sock would
> get removed before we can use it in the next test).

True.

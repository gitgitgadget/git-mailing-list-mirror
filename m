Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F201ABEC2
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722634993; cv=none; b=R2s5WZRyFiBSYK3JouSWlgHreqKEL7o/jiK4O2PjSO6kKtt/3DyKIxX1CqKpIiO64b/lZbLUb7FZHPsmmS+sD3J2g1FvkzSv0FHCFU29j7LUEV1NB66pvfTE93O8G7h9B/PCTEFftkEMYw2FFoB2csAudA+ASK6MRtQsm9zILgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722634993; c=relaxed/simple;
	bh=2wjXquTlxJgjoIN512x7lUjJCnzK7SaFLXI0nxM7jSE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pV86yvmpzR0P7z9S/Jp7cId0Tjq8gd249Z48DzxLB+EsL14fRrpSAiiGf6aGTQoGnSTO9Kc3s5n7LRZgr97Kl4383WOaP7DQD4YHT/jwOl0VKaZGvaebTOVPkggWVyEQAeqk5ezUFEAIvqMC8anVrBEBeHHvQ/Ukd2Ucm0zGJlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OsogObbc; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OsogObbc"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 848D01CCCF;
	Fri,  2 Aug 2024 17:43:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2wjXquTlxJgjoIN512x7lUjJCnzK7SaFLXI0nx
	M7jSE=; b=OsogObbcmgmwDn32gaW/CzvHZvS4b6hMWeCui99Lu58QTSBp+drdrk
	2zuYurtySme5xDAPN7F9MWy5AYADfR3dKjcJS5yM3PR7Tmbcgawyxy/vQ00KIqTu
	uupYdnhWL078/S2oDD2dZZiMzcs+pORnzs5r4x4LIhYvSgIPSEulA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7DA9F1CCCE;
	Fri,  2 Aug 2024 17:43:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 845FA1CCCD;
	Fri,  2 Aug 2024 17:43:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v5] http: do not ignore proxy path
In-Reply-To: <c7b3383b-ebbf-6ec4-00b8-41c9430a99f4@alum.mit.edu> (Ryan
	Hendrickson's message of "Fri, 2 Aug 2024 17:26:32 -0400 (EDT)")
References: <pull.1767.v4.git.1722489776279.gitgitgadget@gmail.com>
	<pull.1767.v5.git.1722576007398.gitgitgadget@gmail.com>
	<xmqq7ccygbx6.fsf@gitster.g>
	<2ba77de5-f103-c2f0-c009-71700c8a020d@alum.mit.edu>
	<xmqqv80idf52.fsf@gitster.g>
	<a0b916a4-8941-4c06-263d-0ae92dcaf29e@alum.mit.edu>
	<xmqqh6c2d8qt.fsf@gitster.g>
	<30733887-33d8-4049-7dc9-8bc9d0b106da@alum.mit.edu>
	<xmqqfrrmbpbv.fsf@gitster.g>
	<c7b3383b-ebbf-6ec4-00b8-41c9430a99f4@alum.mit.edu>
Date: Fri, 02 Aug 2024 14:43:05 -0700
Message-ID: <xmqqmslua9ee.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 349CE544-5118-11EF-B24E-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Ryan Hendrickson <ryan.hendrickson@alum.mit.edu> writes:

> I would also rather not put time into figuring out how best to rename
> the function "old_curl_version" if it no longer checks for the
> particular error produced when the curl version is too old,

Now, that is a good argument to make sure the "libcurl 7.84 or later"
I suggested to omit for the sake of brevity is in the pattern.

Thanks.



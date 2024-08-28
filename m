Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5B118786F
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862704; cv=none; b=sLCkPqDq57f63pkQYrWLK01tVKKPpiDaXbdLNyfi3xd+Lxti8uGZifSHhQEgQBkJ+pQUUxh5EjB5q9F4JdjNdrDOiOopfpONSkivkQuHwnOa+0tP2HIdwaI9JpG+Tu4CVLItfSOQ7nt6gFjTQ7BYrhQ+zgpuiYkrbmj0Z1F5v10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862704; c=relaxed/simple;
	bh=CwUGa1YPFcSw373R4bHV/pEyCgaMlYv5PTbOw+kCUog=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y90H2FEa/y6WFJ1ya1L2XevDLssbVw0quwxNSsa/C0J/V3QyG38YxRZhS1zT319FxnTsK/T94jm2QAYrSbI2Fhr5SvigU2J9SA5d0yMzyr0gUSLeKBcxv00G1pyklJs1Z0LEfY06dcrCBRnUewe7jaGvwqKzfz8taOU8NtJTiik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MxqVc7y/; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MxqVc7y/"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E06451846B;
	Wed, 28 Aug 2024 12:31:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CwUGa1YPFcSw373R4bHV/pEyCgaMlYv5PTbOw+
	kCUog=; b=MxqVc7y/QmPrBrOUd3pNhtmwUVLD3lv3acZ+IZHycUTeeijphKHRM6
	8EFco1iqrzL5kjNshQBasDVECiRPUdNFd4xG5S4KyQ7wttg/vtgvXsAYUSqzJXQc
	vJ5tdaN6/hUq19TVMzPsEJp+NR/6EU19mK0cJZDniSzb9Gs7LIZ6k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D80E51846A;
	Wed, 28 Aug 2024 12:31:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3EC7218469;
	Wed, 28 Aug 2024 12:31:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Shubham Kanodia <shubhamsizzles@gmail.com>,  git@vger.kernel.org
Subject: Re: Improvement: `git-maintenance` to allow configuring of remotes
 to fetch
In-Reply-To: <Zs8KzG0vzCEDvkvx@tanuki> (Patrick Steinhardt's message of "Wed,
	28 Aug 2024 13:32:34 +0200")
References: <CAG=Um+1wTbXn_RN+LOCrpZpSNR_QF582PszxNyhz5anVHtBp+w@mail.gmail.com>
	<Zs8KzG0vzCEDvkvx@tanuki>
Date: Wed, 28 Aug 2024 09:31:39 -0700
Message-ID: <xmqq4j7438yc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 01762B38-655B-11EF-B2AF-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I'm not aware of any discussion around this...

I do not think so, either.

I agree that it makes as much sense to limit prefetches to a subset
of remotes as it makes sense to limit to certain hierarchies (e.g.
excluding refs/changes/ or even limiting to refs/heads/seen and
nothing else).

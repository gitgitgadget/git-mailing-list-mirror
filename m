Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E061D5BADB
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711646733; cv=none; b=tyhKo/68897+NyWIdLJ1A/t/P93bAN+Nu+jtY0Cn6AWnPEy0uLIwIr5kM1Epa7yi1lH28FY8mv/vwM/5KHovbUjItKaL3o//AXZZzFqObMY7Fkl0BIR6kKKPCs2uP9T70tE6kDyxpOCwlxXE1kFqYOUIgppiG4Is+fxTmyUiSXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711646733; c=relaxed/simple;
	bh=bTtodjHidW8y3TPr6zDJb2nW51HtxrWrnS3aDM7isAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OpYNX5QwmtmEwR3wVwtfqmwcBov4taZMiZeyfGma+ld+xmEVhVhWXaror0qj+TCDAXEXPlceBqLMDZAxY1P5R9fGsI8p+jSnUSK8Ja68GS45C78YqunETUMAAVmXGqukmlMsl38cOj/M+u1jW7dwk/saoB4AqimU6hJLrxd/OVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=v98u3UST; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v98u3UST"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 953CB1EBAD8;
	Thu, 28 Mar 2024 13:25:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bTtodjHidW8y3TPr6zDJb2nW51HtxrWrnS3aDM
	7isAM=; b=v98u3USTqLwRhpHE+lfEKSUF/8DSMkNo6CWqNx7LXOOLftrkafRGIz
	duc0u0wZ6O4MZ1rKYlGRjlaPKXM2VaxQeP5w8hCzqWcE6l3aCsn7l2aXgDFRugDj
	RnEazrnJebVffNqA3kdeRjS/TY9fyFkGed/7XUkBYsGBDA6r+C0Zs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 882391EBAD7;
	Thu, 28 Mar 2024 13:25:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E31C71EBAD6;
	Thu, 28 Mar 2024 13:25:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  Matthew John Cheetham <mjcheetham@outlook.com>,  M Hickford
 <mirth.hickford@gmail.com>
Subject: Re: [PATCH 05/13] credential: gate new fields on capability
In-Reply-To: <20240328162923.GA1403492@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 28 Mar 2024 12:29:23 -0400")
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
	<20240324011301.1553072-6-sandals@crustytoothpaste.net>
	<20240328102053.GA890906@coredump.intra.peff.net>
	<xmqq7chmwczx.fsf@gitster.g>
	<20240328162923.GA1403492@coredump.intra.peff.net>
Date: Thu, 28 Mar 2024 10:25:27 -0700
Message-ID: <xmqqfrwauv3s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2C1AD092-ED28-11EE-8F99-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> I think the sneaking has already been done, because Windows CI uses bash
> (which is after all how I noticed this). I'm not sure if using bash more
> places would be helpful.

Yeah, you are absolutely right.  Let's not pile another difference
in the linux-TEST-vars that is already a kitchen sink.

Thanks for a quick dose of sanity.


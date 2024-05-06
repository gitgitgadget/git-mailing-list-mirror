Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98E2156C66
	for <git@vger.kernel.org>; Mon,  6 May 2024 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715021528; cv=none; b=M+cFvNnH01RI9YMgp4rlurTzLg3cUhJKjox4B/6GXXAfxHeR4fG6zQB8O3PB0Qre2QGHtI0uWoyKDYpEy4Iw01mzkt3uNO/bwQ+i8m2jEq+0yvU/4fzvaR9+E6uEynEmTTbn41tmcY3KLgiBXXLoy6pGkHjvcipuexbpgnu5J+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715021528; c=relaxed/simple;
	bh=wdiQF165h8mWOOdpBYOoUTf9JzHi947yw5RLkYOCRdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X1bAmlRchrheMEimUxO3zw1R3fU8NPayaqbMiuAU7+sshfZ+BiU+BCAXUrg4bml2RAiUSnf1uZErdPcFecjnuGfAPsKRDOXMDrGd77ZZEdkAjaMEbELPol5j2rArhTVRiHxsyI33L4s5zIN+vvWlu0GaftYTGKYHdyX0+nJ2Y94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=G9bKIuHp; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G9bKIuHp"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B2BF1229D8;
	Mon,  6 May 2024 14:52:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wdiQF165h8mWOOdpBYOoUTf9JzHi947yw5RLkY
	OCRdQ=; b=G9bKIuHp0dHTUDagz4pYf3ZdCBZsBUXDUX2eIcCHm7BC65M0SGIsxi
	QwnW6hn7yOhFpQkrzgb921SVfbZKnO1WB4SiJvDJPz7Z4Kzv30T0WBLEIVC/NE+A
	MpcjvOlpag31Wh4wuKjZjS0R00hhPbcSJbQGIrCjJ893SlxtW50Is=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AA1DE229D7;
	Mon,  6 May 2024 14:52:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F12A229D6;
	Mon,  6 May 2024 14:52:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] gitlab-ci: add smoke test for fuzzers
In-Reply-To: <ZjisGhU66kDKkZsZ@tanuki> (Patrick Steinhardt's message of "Mon,
	6 May 2024 12:08:26 +0200")
References: <01fb94999f8e2014ba4d09ce7451a4f5d315ee72.1714371146.git.ps@pks.im>
	<ZjisGhU66kDKkZsZ@tanuki>
Date: Mon, 06 May 2024 11:52:02 -0700
Message-ID: <xmqqy18mydrh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BB1935E8-0BD9-11EF-9682-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Apr 29, 2024 at 08:13:23AM +0200, Patrick Steinhardt wrote:
>> Our GitLab CI setup has a test gap where the fuzzers aren't exercised at
>> all. Add a smoke test, similar to the one we have in GitHub Workflows.
>> 
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>
> Junio, I haven't seen this topic getting picked up in your "What's
> cooking" report yet. Is this intentional or did it simply fall through
> the cracks?

The latter.  Thanks for a ping that is designed to make it easy to
find the patch (by going to the message it is a response to).

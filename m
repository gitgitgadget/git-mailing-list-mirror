Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A9B3E48C
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710344011; cv=none; b=IzJPEyhBmN4+DSHXylipdjHhN16Yyr+kFuCTVWaa7GJ3Cx7RjjFmsAA4q9cxvuIAPsNlQs84DEvQyxVClQaKmkFPaJQeVWepzOU0XBQITbIZKIXdniQxB6qAzFi4eudHZddPkZLN2tIFoKVUkGDnoa93zubB+oDfkCIULjb9k+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710344011; c=relaxed/simple;
	bh=uEUXWAx2HWMUUO2isQQIs7lwC1LF7ONMivIO7/f/2dE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W5L55ityluTgGTnvS+1tYS/nsM90PkXMQ/5swGiDRRGbP3hLg97Y3w8/0BIFn8IkL/2OaEvsZ0qBVez59twKefhpNlY4/taTDNhHNdZLNvQ9x5U+FlObVD/n2e6J+8LvxTuDw+nK9qC7LAGnBm3ALPIoCRwCCwLa1a6Akxxfo98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wetzZNkU; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wetzZNkU"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C6BFC1DBC7A;
	Wed, 13 Mar 2024 11:33:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uEUXWAx2HWMUUO2isQQIs7lwC1LF7ONMivIO7/
	f/2dE=; b=wetzZNkU/H1bgd79DNtQ5V5cRADWVfR2kcsWe/OuXX7nmTJr1WwAGz
	elPw9mjGtAzEFVWZOpL9Ga4MoDkOm+oyBdZEiEo/0qmXNEw99pg7pyUUkPhD4ooJ
	P+D2Hdtwo8UFBqmRuCwRGNyrdqWE75Y35k0s3qCqZNdFw22poB7SM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BE4211DBC79;
	Wed, 13 Mar 2024 11:33:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D79C21DBC78;
	Wed, 13 Mar 2024 11:33:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Florian Schmidt <flosch@nutanix.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2024, #03; Mon, 11)
In-Reply-To: <d9be2023-c5d7-4594-a06b-3303abb1a920@nutanix.com> (Florian
	Schmidt's message of "Tue, 12 Mar 2024 12:02:15 +0000")
References: <xmqqy1aol1lv.fsf@gitster.g>
	<d9be2023-c5d7-4594-a06b-3303abb1a920@nutanix.com>
Date: Wed, 13 Mar 2024 08:33:26 -0700
Message-ID: <xmqq7ci6f8op.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 09DA0028-E14F-11EE-BAF6-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Florian Schmidt <flosch@nutanix.com> writes:

> On 12/03/2024 00:45, Junio C Hamano wrote:
>> * fs/find-end-of-log-message-fix (2024-03-07) 1 commit
>>   - wt-status: don't find scissors line beyond buf len
>>   The code to find the effective end of log message can fall into an
>>   endless loop, which has been corrected.
>>   Waiting for review response.
>>   source: <20240307183743.219951-1-flosch@nutanix.com>
>
> I responded on the original thread, but to confirm here: from my side,
> this patch is ready to go.

Yeah, I think I wrote "waiting for ..." after I sent out
https://lore.kernel.org/git/xmqq7cidlqg5.fsf@gitster.g/
and before other responses came to the thread.

Let's mark the topic for merging to 'next'.  Thanks.

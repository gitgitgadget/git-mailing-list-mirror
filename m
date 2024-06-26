Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5326E611
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426775; cv=none; b=eQzOwsfBwL6JI43/Z8Z6R9u0HdldxoyNrQGlBLk8St/v6UKVYQEsSsZGzJrzkVVR64AJLU6i3JCm0RVo0/qlwj4P66wk0/sooYJnK0QK5l2S6LpLjDuaYOKHcGoRCP0fMWPdEE61UyMXLdiLRpdCouinKBsd32IueIgemdwyBVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426775; c=relaxed/simple;
	bh=m8WmKVZ+Zk4Us4lZKEAlV34QcqtcvLlIK7NAlP90tSw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YzPxVoPKYw12KITAcR4XOIAm4cQnP+20LjPQJLwdTeUjZnmJTtRDVjHLsNNE6mZ5MWAsmAeCPO1VbOOk8sX5DAUB9L/ZccBF8rZmzRWpxQ9hqzeynAmr7R4GOWHGIpf72BvDFUGGWJBa51PLqHEfqYW4/AUHwK53w7x0YWkXchk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wINHTrKX; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wINHTrKX"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E90B23926;
	Wed, 26 Jun 2024 14:32:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=m8WmKVZ+Zk4Us4lZKEAlV34QcqtcvLlIK7NAlP
	90tSw=; b=wINHTrKXv6I2qfpWQ6Gomv7lX/MMUGA7tQyHZIntUkRMyxsOKTCgMX
	TAL5I/ZMaKAoqLPDg01I6l5JY3P8vUptThBhSrbAgLyPLHzphLi1AqbLVvlpJPIj
	/YD6bzwiPqEJZw3VQtlcRHiet6OJTzhsnoH1oRSFhIHmBO9kjnzTY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9520A23925;
	Wed, 26 Jun 2024 14:32:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0200423924;
	Wed, 26 Jun 2024 14:32:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Darcy Burke <acednes@gmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>,  "Randall S . Becker"
 <randall.becker@nexbridge.ca>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 0/2] Darcy's "date underflow fix" topic, final reroll
In-Reply-To: <dedaa590-b9bf-498f-b743-ba058cba8486@gmail.com> (Phillip Wood's
	message of "Wed, 26 Jun 2024 16:21:01 +0100")
References: <20240625231248.4070257-1-gitster@pobox.com>
	<dedaa590-b9bf-498f-b743-ba058cba8486@gmail.com>
Date: Wed, 26 Jun 2024 11:32:51 -0700
Message-ID: <xmqqle2rzh9o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7FBDA16C-33EA-11EF-B014-965B910A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Junio
>
> On 26/06/2024 00:12, Junio C Hamano wrote:
>> So it has been some time since we discussed this topic.  Let's clean
>> up the messy "SQUASH???" patches I had to queue on top of the main
>> patch to keep the CI working and make them into a preliminary patch.
>> The tree at the end of the series is identical to what has been
>> queued in 'seen' for the past few weeks.  The only difference is
>> that we first lay groundwork to skip certain time-parsing tests on
>> 32-bit systems first, and then use Darcy's patch with minimum
>> adjustments for 32-bit systems.
>
> I've had a read through this verison and I don't have anything to add
> to Eric's comments.
>
> Best Wishes

Thanks, let's mark it for 'next' then.

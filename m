Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1588884039
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249114; cv=none; b=P7iQ5T87SsRQdZD0yxJ6lk86PWh1lYmWs0nyvx2MjVzG97WcEBNX+9qSFCpX6azVI6jbVkPiF7GK5hqdYTMOZ69bD3IJimbAsWlxLnwHA7wib0xPb3LA1ckfaOZP1bT84NR54Kt0Vyjdn4uSPL9HrVFesXKCQnzMYqZw94uH0DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249114; c=relaxed/simple;
	bh=4Rhgem9YHH4SMms+WTVWiUmvoEKJOeEBgU9o8d7ODvE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LIai24FEltuddJglh3d7TNEDoBEeu75rkbzq5ha1NOLKQgDtyry+FKvCGzm2n/hjSrauJrTUKGMiBjzZCwxfPUZByH7ZjhsWgx8T1+7o8/bdObqHMMex6oiUYToY1cP7b61+VyzqUHH7jkBI79vmK/NwTfz2znSyH36Wpp22WwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CAYv16nR; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CAYv16nR"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C68427322;
	Fri, 13 Sep 2024 13:38:26 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4Rhgem9YHH4SMms+WTVWiUmvoEKJOeEBgU9o8d
	7ODvE=; b=CAYv16nR7C3lc3OczSeJoxvDJrVTIbwyyri8045lQQ6QrUXlV5gO0Y
	F6BaaH9UxqVpPHTyYFHExY6KNWZ36ziLiea6iBUcWqpSpaDSvjQcUnH2npLWCPjz
	fTInMdgD07Ukf60GoLW3Fbq0NbK94rrkJc4JQSA2XsBHN8SBBuOrQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 84A7127321;
	Fri, 13 Sep 2024 13:38:26 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E417927320;
	Fri, 13 Sep 2024 13:38:25 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Han Jiang <jhcarl0814@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/4] remote: print an error if refspec cannot be removed
In-Reply-To: <acd287c8-990b-42b7-85dd-a206a887b8ee@gmail.com> (phillip's
	message of "Fri, 13 Sep 2024 16:11:53 +0100")
References: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
	<a8dfe403d0683aec4265bf920921e45d5b59cec3.1726067917.git.gitgitgadget@gmail.com>
	<xmqqseu56hhb.fsf@gitster.g>
	<acd287c8-990b-42b7-85dd-a206a887b8ee@gmail.com>
Date: Fri, 13 Sep 2024 10:38:24 -0700
Message-ID: <xmqqfrq3zc6n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FB0B7AA2-71F6-11EF-801F-9B0F950A682E-77302942!pb-smtp2.pobox.com

phillip.wood123@gmail.com writes:

> On 11/09/2024 21:52, Junio C Hamano wrote:
>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>   	if (!add_mode && remove_all_fetch_refspecs(key.buf)) {
>>> +		error(_("could not remove existing fetch refspec"));
>>>   		strbuf_release(&key);
>>>   		return 1;
>>>   	}
>> It is a minor point, but would it help to say what we tried to
>> remove (e.g. "from remote X") or is it too obvious to the end user
>> in the context they get this error?
>
> The user has to give the remote name on the command line so I think it
> should be obvious to the user.

That makes sense.  Thanks.

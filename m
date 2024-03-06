Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47BE12E47
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709691582; cv=none; b=UdnP/VAUn8T1xZChAldggeKTQWH7/x1J9SV11+6NmMBcCcMh7K7DdQwJ6TRLLRYO2W2cMO8iOUsdi6D9i3SJ3eo7NsTDaSTxFnrVydN9rUmQ0D3gz3SawAmdYQIEdn/68x0ESy7eK+FPwMYGjVLP3uHDEn3sGeEgSOvWenOjduI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709691582; c=relaxed/simple;
	bh=cK+p8+sEzDvto/IpwRd59aF3d6iqyEjbS1LdAcRl6Sw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RdgNax9abG84rLhlflVlMFLjqJrYvYnW5UILCEhBxm4VvOeDPTprY51l9OgscJk3dCxOIw2Ci7CuxuipL2OdnNyuuqR+nIKXxZxLH8CdWKvY83GFbDYDmIC1nJbDV92wmRXnd0xKNlm6H0Ibp5TiVzmxmTBf/hU7IR81N0d271E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sYWMm4eh; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sYWMm4eh"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1435A19A09;
	Tue,  5 Mar 2024 21:19:40 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cK+p8+sEzDvto/IpwRd59aF3d6iqyEjbS1LdAc
	Rl6Sw=; b=sYWMm4ehmH7QXp6ca+bYwOTKYfpJYcheodeQGmnBPHNh7fLdCe6G79
	/O3ITF48t5NIe+1SqdWYybUDN0t4Oz+hDvhaNYxfuYXNamrTiRm1DQEHrHqvnPrD
	nV38bqQoLtK0ycaw9dBP24JmqOOec66rvRsIsd63fykGXdVhxLutM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0D23519A08;
	Tue,  5 Mar 2024 21:19:40 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9804D19A07;
	Tue,  5 Mar 2024 21:19:36 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: phillip.wood@dunelm.org.uk,  John Cai via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  John Cai
 <johncai86@gmail.com>
Subject: Re: [PATCH] show-ref: add --unresolved option
In-Reply-To: <20240306003343.GA3797463@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 5 Mar 2024 19:33:43 -0500")
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
	<a3de2b7b-4603-4604-a4d2-938a598e312e@gmail.com>
	<20240306003343.GA3797463@coredump.intra.peff.net>
Date: Tue, 05 Mar 2024 18:19:34 -0800
Message-ID: <xmqqv860umo9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FA84071C-DB5F-11EE-BEB1-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> On Tue, Mar 05, 2024 at 03:30:35PM +0000, Phillip Wood wrote:
>
>> Hi John
>> 
>> On 04/03/2024 22:51, John Cai via GitGitGadget wrote:
>> > From: John Cai <johncai86@gmail.com>
>> > 
>> > For reftable development, it would be handy to have a tool to provide
>> > the direct value of any ref whether it be a symbolic ref or not.
>> > Currently there is git-symbolic-ref, which only works for symbolic refs,
>> > and git-rev-parse, which will resolve the ref. Let's add a --unresolved
>> > option that will only take one ref and return whatever it points to
>> > without dereferencing it.
>> 
>> "--unresolved" makes me think of merge conflicts. I wonder if
>> "--no-dereference" would be clearer.
>
> We have "--no-deref" in "git update-ref" already. It is probably better
> to stay consistent.

That's an excellent precedent.  Thanks.

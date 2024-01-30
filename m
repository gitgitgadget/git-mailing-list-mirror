Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92655364D6
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632951; cv=none; b=OYXpdFDLhFdHcX+p+qVaZJcKifjuJGDJtSJp8auYhr6vxPoP1gAORBWg4yb36cUh5qXyUz6JOpncKf5OcU+mMXvNszB/qX3NcJaU8U36S2tV7xrBpQ4MWSSxLiAxpHwjefl/5/VP7kiaehJQ9gJ+v1MAMKKPOd4ncQbb6Cv/tQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632951; c=relaxed/simple;
	bh=kExNIhrSAvaB/DKYZN+X9BdoJEDjJF0L/kfzeIOsDxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cYJsOUwY+cJnN//s3UZN4cMuuVXHtZC2yd6FDdtYgHLeWdf94/TLRP+r7eeXi0RuFLbTleUiVrhDjQWOoYgIX0pzdWkzB3hYwAH5XXwW7kc8tKH6KRg5iCPgSnADR8Pul4wXhJ6wDAMUUMRaKVpZxIKaSH9lPmNoNm7CNRwL7gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ULsLTALm; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ULsLTALm"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 443201E02AE;
	Tue, 30 Jan 2024 11:42:28 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kExNIhrSAvaB/DKYZN+X9BdoJEDjJF0L/kfzeI
	OsDxI=; b=ULsLTALmYR9z3a5TazdETJk196GQgawMjaDO/dVR/SNTVzDcBqBtr5
	f45o5Y/2amT7ELwdQsfhZ8S5ATmPG2QQ4Ns6pid1mseHRG2EAXSnLN0LdJmIU/uT
	+UfKzEBXvqjA0nvJUirms4qSsV1uoKw+gaG4r8kN6ph3kOKI46Tac=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A8CB1E02AD;
	Tue, 30 Jan 2024 11:42:28 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89E941E02AC;
	Tue, 30 Jan 2024 11:42:27 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
Cc: "Patrick Steinhardt" <ps@pks.im>,  <git@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] add-patch: compare object id instead of literal
 string
In-Reply-To: <CYRU26F9KCDF.2XI7VRT7N04OC@gmail.com> (Ghanshyam Thakkar's
	message of "Tue, 30 Jan 2024 12:09:15 +0530")
References: <20240128181202.986753-2-shyamthakkar001@gmail.com>
	<20240128181202.986753-3-shyamthakkar001@gmail.com>
	<ZbeQmv_KcChtrPqJ@tanuki> <CYRU26F9KCDF.2XI7VRT7N04OC@gmail.com>
Date: Tue, 30 Jan 2024 08:42:26 -0800
Message-ID: <xmqqsf2ebwnh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8D8822FC-BF8E-11EE-9C6C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Ghanshyam Thakkar" <shyamthakkar001@gmail.com> writes:

> Yeah, my original motive was to support '@' as a shorthand for HEAD.
> But, since '@' can also be used as branch name, I thought of comparing
> object ids instead of string comparison in accordance with the
> NEEDSWORK comment. However, as Junio pointed out, treating a branch
> name revision that points to same commit as HEAD, as HEAD would just
> cause confusion.

FWIW, if we are not doing so in our documentation already, we may
want to discourage use of "refs/heads/@", given that "@" is used as
a synonym for "HEAD" in some[*] contexts, specifying the HEAD
(i.e. "work on the branch that is currently checked out, or in the
detached state") and specifying the concrete name of a branch
(i.e. "work on this branch") mean totally different things and may
result in (what may appear to the user as a) confusing behaviour.

Granted, the user who names their branch "@" is only hurting
themselves and it falls into the "Doctor, it hurts when I do
this. Then don't do that!" category.  

But the documentation is where we tell them "Then don't do that!"
and we should know better how it hurts when they do so than those
who learn from the documentation, so ...


[Footnote]

 * Even use of "@" as a synonym for "HEAD" may want to be
   discouraged, as there are still unnecessary differences between
   them that are not worth our engineering resource to fix.  Do
   people know what "git checkout HEAD" and "git checkout @" do, for
   example?

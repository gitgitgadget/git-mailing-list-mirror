Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93D77494
	for <git@vger.kernel.org>; Fri, 24 May 2024 21:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716587516; cv=none; b=qyF88iK5elnzzPIMZfzY636Cg/A4KUeaz2n9GHxgOsDpHrETX7utdu7yzh4oG69c4XjlIK32WoUSF9XxEQnkhWR4uduH1klHoWQTBPfjOJmsv0iQUvPZc7l72Yxw+SCHBd5hBh1vN6FcW6FxdnZTXnHwLIaj+TYdCsTDKmZDJuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716587516; c=relaxed/simple;
	bh=BADqt9mBQegEFICRWNJIc0SZ7nxg+ta5KBa5SZ5OTP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=noLTnnDROcRvo6pyyW8CNHUU2iu8iUpP6uRePUoeBP1SNmLxksDB9ol4kVpWNq3hkVwnIAd/o+R2EZ/1v8ybF7zhICknY3XQ4+SfQQoBjRTwy+S3IvQ3jGNSV4Dsl0cNOsELN7fPI+ov/haP2urUiIsHqibrNJOpdmapI/RIkWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JshsDRQI; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JshsDRQI"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE1482BF74;
	Fri, 24 May 2024 17:51:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BADqt9mBQegEFICRWNJIc0SZ7nxg+ta5KBa5SZ
	5OTP0=; b=JshsDRQIEtc6eA4GfbjJywzcKaHKOPOl9d3jbwGXLAsY4oVdn7fJzz
	fN6pg/HQ65KjJTfxT43SohAgJVZIDqrfH8TPVn6I4P2DlZlGhpD3P6Y6+00ZpfYw
	RVmBkJL9N2rcI3L3EQOaJGUhV9UWFe3MCKiy89icciu6Nr4tbgVeE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A6BCF2BF73;
	Fri, 24 May 2024 17:51:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1AD0A2BF71;
	Fri, 24 May 2024 17:51:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 3/3] upload-pack: allow configuring a missing-action
In-Reply-To: <CAP8UFD1JZ7eJzrTk1YPrfy1XLAnnLvukABOJE69-JbqVWtL1AQ@mail.gmail.com>
	(Christian Couder's message of "Fri, 24 May 2024 18:41:56 +0200")
References: <20221012135114.294680-1-christian.couder@gmail.com>
	<20240515132543.851987-1-christian.couder@gmail.com>
	<20240515132543.851987-4-christian.couder@gmail.com>
	<xmqqv83fvw7p.fsf@gitster.g>
	<CAP8UFD1JZ7eJzrTk1YPrfy1XLAnnLvukABOJE69-JbqVWtL1AQ@mail.gmail.com>
Date: Fri, 24 May 2024 14:51:52 -0700
Message-ID: <xmqqjzjikhdz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D4F63898-1A17-11EF-A889-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

>> Repository S borrows from its "promisor" X, and repository C which
>> initially cloned from S borrows from its "promisor" S.  Even if C
>> wants an object in order to fill in the gap in its object graph, S
>> may not have it (and S itself may have no need for that object), and
>> in such a case, bypassing S and let C go directly to X would make
>> sense.
> ...
>>
>> It feels utterly irresponsible to give an option to set up a server
>> that essentially declares: I'll serve objects you ask me as best
>> efforts basis, the pack stream I'll give you may not have all
>> objects you asked for and missing some objects, and when I do so, I
>> am not telling you which objects I omitted.
>
> I don't think it's irresponsible. The client anyways checks that it
> got something usable in the same way as it does when it performs a
> partial fetch or clone. The fetch or clone fails if that's not the
> case. For example if the checkout part of a clone needs some objects
> but cannot get them, the whole clone fails.

But then what can the repository C do after seeing such a failure?

With the design, S does not even consult C to see if C knows about
X.  Without knowing that, it cannot safely decide that it does not
have to send objects that can be obtained from X to C.  Instead, S
simply say "if C requests an object that I do not have, just ignore
it and let C grab it from somewhere else".  How would it not be an
irresponsible design?



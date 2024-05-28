Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A854E17083D
	for <git@vger.kernel.org>; Tue, 28 May 2024 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911690; cv=none; b=NVOJ2Fk4vCW2uxJzT8vXv8gAm0mXfi3IQaqVOKeKylfGh60UtsgjsLDEz4Ner+ZbcGD5vO76rGe5sz0hY8cKIwDcq9AV510k14FvlnVN3jlqQHFDPxfeSdOIg6zkDvCUbYwVgqAZKU9LhKYyK+rUnsTNAQAykMaWz9me5oNZi3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911690; c=relaxed/simple;
	bh=Ee/p4rD2QsropN5U2DUNgnHAgnZEvkVeqokPI8KZFdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uov7VoZLTgVwV4IvVk8uTtQ4F90UbMwAw2NdwJABP8T5RvS35NW+LoQTBFxVICm5sFF1gohrW2+vCF5UAD0nvX6hmtcHJau/frZayXV4e6u0XF02zLj2DKYHBCB2FyNz1gpfn1hhkEIl0Nt0vJXWuYrlu7/vp/iiLcm4MhSiW/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BSL1F3/h; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BSL1F3/h"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E038821973;
	Tue, 28 May 2024 11:54:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Ee/p4rD2QsropN5U2DUNgnHAgnZEvkVeqokPI8
	KZFdo=; b=BSL1F3/h5LaJ6NS5sw8Xhho6A/qX0SyYYX2mEjqGxLf00l6kWmfwx6
	NHSU82VswmOKPjJW1bBVyKYFCASj4XWS1KESeU4+S2+FDSABwqPkaWhNzXRXqjBZ
	C65vOlyqnpmmsirG+0DOJTBGAyzIzdwXWxct/bb6V39hSNiq79ktQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D91EC21972;
	Tue, 28 May 2024 11:54:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EF4AC21971;
	Tue, 28 May 2024 11:54:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 3/3] upload-pack: allow configuring a missing-action
In-Reply-To: <CAP8UFD1_aHwbhF12v-miCTWEbbgjtpjTCmkRmFHu4Vusezq6dA@mail.gmail.com>
	(Christian Couder's message of "Tue, 28 May 2024 12:10:31 +0200")
References: <20221012135114.294680-1-christian.couder@gmail.com>
	<20240515132543.851987-1-christian.couder@gmail.com>
	<20240515132543.851987-4-christian.couder@gmail.com>
	<xmqqv83fvw7p.fsf@gitster.g>
	<CAP8UFD1JZ7eJzrTk1YPrfy1XLAnnLvukABOJE69-JbqVWtL1AQ@mail.gmail.com>
	<xmqqjzjikhdz.fsf@gitster.g>
	<CAP8UFD1_aHwbhF12v-miCTWEbbgjtpjTCmkRmFHu4Vusezq6dA@mail.gmail.com>
Date: Tue, 28 May 2024 08:54:43 -0700
Message-ID: <xmqq34q27wzg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9A744CFA-1D0A-11EF-975D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> It's basically the same as when a regular clone or a partial clone or
> a clone using bundle-uri fails or when using a regular bundle fails.
> If it failed because the remote was not properly configured, then that
> config can be fixed. If it fails because the remote doesn't have some
> objects, then maybe the missing objects can be transferred to the
> remote. And so on.

> The feature doesn't create any new kind of failure.

> "it would be nice if there was a capability for the client to say
> that it would like the server to give it information about the
> promisor that it could use, so that the user doesn't have to pass all
> the "remote.my_promisor.XXX" config options on the command like."
>
> and by saying that this could be added later.

Can such an update happen transparently, or does it need changes to
end-user experience?  It is of dubious value to leave the initial
series be incomplete if the latter is the case.

>> Without knowing that, it cannot safely decide that it does not
>> have to send objects that can be obtained from X to C.
>
> In the above command C is asking for a partial clone, as it uses a
> --filter option. This means that C knows very well that it might not
> get from S all the objects needed for a complete object graph.

Hmph.  If C asks a partial clone and S is willing to be the promisor
for C, S is essentially saying that it will serve C any objects on
demand that are reachable from any object it served C in the past,
forever, no?  It might not get from S initially all the objects, but
if it wants later, S promises to let C have them.


> Again when using a regular partial clone omitting the same set of
> objects, C also requests some objects that S doesn't have.  And
> this is not considered an issue or something irresponsible. It
> already works like this.

"S doesn't have" is because S has pruned objects that it shouldn't
have in order to keep the promise it made earlier to C, right?  If
that is the case, I would very much say S is being irresponsible in
that case.

> And then C still has the possibility to configure X as a
> promisor remote and get missing objects from there. So why is it Ok
> when it's done in several steps but not in one?

You are right that S can decide to unilaterally break the promise it
made C, so this update is not making it any worse than giving users
a broken implementation of promisor remotes.  I wouldn't call it OK,
though.

If somebody identifies that even without this series, S can lead to
repository corruption at C by pruning objects it does need to keep
its promise to C, the next action I expect from healthy project is
to try coming up with a mechanism to make it less likely that such a
pruning happens by accident (e.g., by noticing allowAnySHA1InWant as
a sign that the repository has promised others to serve anything
that used to be reachable from anything it historically served,
disabling repack "-d" and instead send the currently unreachable
objects to an archived pack, and something equally silly like that).
It certainly is not to add a new mechanism to make it even easier to
configure S to break promised it made to C.

So, I dunno.

Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B3616E88A
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765209; cv=none; b=IbTDRKnr4IBt41PUekpYzci6wAepcU0YJ/8uuAEWoTJ1mqFObIR6gApVDwL4JTHLuW8QDBu8AVPNYMnH4aLL2IqRlg3ZRDli20P3LphfRkOoVELdWgOEW9PS2XRf5wbeHEOplVF1V5Bgd/LlZYi0lZdUPMT9WLSCGpjSdj5q7xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765209; c=relaxed/simple;
	bh=kFdV2rlTKl4LbTHvBQHMezHsm3iq0gSR1NuYDMG6+MI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IT6bmP9+O3LEbwx3SoO0F+YtfXN8kZNN88YRNXRXJZpL0oFKH6/uox0Lj0hf0BuAV5gJbiVT9LiJsu/ubf7tuZ/dKnKN87R+hT4YX7bcCGTCkLbRSHOKrt4Rhi4rLi4K4PbR9E8Jkk6kvqxCwjA8Dc2QYOO+nycnWjJL1J83uNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pyTkBOcs; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pyTkBOcs"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BB84C1DF417;
	Wed, 10 Apr 2024 12:06:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kFdV2rlTKl4LbTHvBQHMezHsm3iq0gSR1NuYDM
	G6+MI=; b=pyTkBOcsY29LnHfaFUXA4BMZbYKgmQRCyirzNLiXJQFNshQ3EW/Z5Z
	ZFLRPRiVAUGepNqzOYWAsiuwsvvxkJsgbz3PC7MtMirNmsTt1wGBfJ6AaDzNQpPj
	Ic9F6kkEF+tvimrDba9Ttw95iSOd6x+6vGEB4E+9GkT1mnjK2nQeM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B32701DF415;
	Wed, 10 Apr 2024 12:06:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1ABD41DF414;
	Wed, 10 Apr 2024 12:06:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  Chris Torek
 <chris.torek@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 7/8] refs: add 'update-symref' command to 'update-ref'
In-Reply-To: <ZhYTe2zpJyHJ8iIT@tanuki> (Patrick Steinhardt's message of "Wed,
	10 Apr 2024 06:20:11 +0200")
References: <20240330224623.579457-1-knayak@gitlab.com>
	<20240330224623.579457-8-knayak@gitlab.com>
	<xmqqy19yf40l.fsf@gitster.g>
	<CAPx1GvdXdH3OdY1nC2ijVSdpWfg8jn5=j0KB+Wgv70wWeCNH5g@mail.gmail.com>
	<xmqqplvadmeq.fsf@gitster.g> <xmqqle5xeun1.fsf@gitster.g>
	<Zgv4H66NmLZ_o1IC@tanuki> <xmqqil0z7m5y.fsf@gitster.g>
	<ZhUsrolJ0_HOH1eU@tanuki>
	<CAOLa=ZSmDZcM473c2dNB0FTv79Vrh92YRTnVR74jOfzX1naNRA@mail.gmail.com>
	<ZhYTe2zpJyHJ8iIT@tanuki>
Date: Wed, 10 Apr 2024 09:06:45 -0700
Message-ID: <xmqqzfu1w6ay.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5473C95A-F754-11EE-B5B1-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> > I might have missed it while scanning through this thread, but why
>> > exactly is the zero OID not a good enough placeholder here to say that
>> > the ref must not exist? A symref cannot point to a ref named after the
>> > zero OID anyway.
>
>> > In my opinion, "update-symref" with an old-value must be able to accept
>> > both object IDs and symrefs as old value. Like this it would be possible
>> > to update a proper ref to a symref in a race-free way. So you can say:
>> >
>> >     git update-ref SYMREF refs/heads/main 19981daefd7c147444462739375462b49412ce33
>
>> > To update "SYRMEF" to "refs/heads/main", but only in case it currently
>> > is a proper ref that points to 19981daefd7c147444462739375462b49412ce33.
>> > Similarly...
>> >
>> >     git update-ref SYMREF refs/heads/main refs/heads/master
>
>> > would update "SYMREF" to "refs/heads/main", but only if it currently
>> > points to the symref "refs/heads/master".

I think that would work well.  We need to explicitly forbid a file
$GIT_DIR/[0-9a-f]{40} to be used as a pseudoref, which I think that
is an improvement.  I do not know how the transition to move to a
world with a stricter rule would look like, though.

>> > And by extension I think that
>> > the zero OID should retain its established meaning of "This ref must not
>> > exist":
>> >
>> >     git update-ref SYMREF refs/heads/main 0000000000000000000000000000000000000000
>> >
>> > This would only update "SYMREF" to "refs/heads/main" if it does not yet
>> > exist.

We express "SYMREF must currently be a symref" by naming an old-ref,
and we say "SYMREF can currently be either a ref or symref, but it
must point at this object" by naming an old-oid.  The looseness of
the latter (i.e. we cannot express "Before making HEAD point at ref
X, ensure that it is detached at OID") looks a bit disturbing, but
otherwise looks good.  I offhand do not know how expressive we would
want the "old" requirement to be.

>> On a side-note: This would also mean that we should somehow support
>> moving from symrefs to a regular ref via a transaction, so that means we
>> should allow
>> 
>>     update SP <ref> SP <new-oid> [SP (<old-oid> | <old-rev>)] LF
>> 
>> too, but I'm not going to tackle that in my patches.
>
> Yes, I think that would be a sensible idea, even though we have to be
> careful with backwards compatibility here. In any case, I think it makes
> sense to not extend the scope of your patch series and leave this for
> the future.

Likewise, we may want to be able to express "Before making HEAD
detached at commit X, ensure that HEAD points at ref Y that points
at commit Z".  IOW, the "old" part might have to be not

	[SP (<old-oid> | <old-ref>)]

but

	[SP <old-oid> SP <old-ref>]

to specify both, perhaps?

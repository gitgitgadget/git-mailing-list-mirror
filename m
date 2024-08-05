Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4B5158DCC
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872420; cv=none; b=eHOF5SJ8S0/Vm03EMU/FddlBNbnr9JT2Kk3c9Zr0/aRjh+E9+8sIOXUx/Rp9xjoolifgDdqrA9CY9lVGTkgmDzTL7Gz56wZfvQ9MTSwS+kPPI+zdZ8XV75sJbH8jPBlMawU14hCbd/Qy4n43UchmWNfRMUt4hy8cQ2hL+ufhZ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872420; c=relaxed/simple;
	bh=yD1gkWxEalZGZMcR2Va7trdLThH8Cq+raMFJbwjlArQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XSs0oUyw3Y6kBHAVgR0tzc+zqBhLPzpr7AuyrQKZPu7x4ES+h6AYQpZgOvOAj8snYlPyZkvHJo0p2Mhdycxn6HNmDyebZ+jqsGtZz8As4CdJpLJNJDF6g0WIdCo5GQjUxUXvpUwyaufyyNg4YCL2RMCo6uSwdcumhyITCvUXx8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mkz54jbe; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mkz54jbe"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 323C82E626;
	Mon,  5 Aug 2024 11:40:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yD1gkWxEalZGZMcR2Va7trdLThH8Cq+raMFJbw
	jlArQ=; b=mkz54jbeEZq+sE5oes7AzMZfvwdiEg9422fsmLoTAxcPstoW+EvZX8
	G0ebdLxSJbWojLcUzBchKRdM6U4JVnfv0zmhJRybB3jIOJbnuC3vYP8XWudjkd5H
	bP3Fc0eiq9MwfEYa0L9WiXUVAxVwmda2gJ+vXO9Iu9Rttleamo3uo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2AB852E625;
	Mon,  5 Aug 2024 11:40:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2EB602E624;
	Mon,  5 Aug 2024 11:40:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff King <peff@peff.net>,
  =?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,  Linus Arver
 <linusarver@gmail.com>,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/3] refs: keep track of unresolved reference value
 in iterators
In-Reply-To: <ZrCwqqLKcwdOYclN@tanuki> (Patrick Steinhardt's message of "Mon,
	5 Aug 2024 12:59:54 +0200")
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
	<pull.1712.v2.git.git.1722524334.gitgitgadget@gmail.com>
	<ac0957c9e6abdc2597900573703461833e9c9d69.1722524334.git.gitgitgadget@gmail.com>
	<xmqqa5hww600.fsf@gitster.g> <ZrCwqqLKcwdOYclN@tanuki>
Date: Mon, 05 Aug 2024 08:40:06 -0700
Message-ID: <xmqqh6bz567d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FE59B766-5340-11EF-BBBC-BF444491E1BC-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Aug 01, 2024 at 09:41:03AM -0700, Junio C Hamano wrote:
>> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> > @@ -886,6 +889,9 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
>> >  		iter->base.refname = iter->iter0->refname;
>> >  		iter->base.oid = iter->iter0->oid;
>> >  		iter->base.flags = iter->iter0->flags;
>> > +		if (iter->iter0->flags & REF_ISSYMREF)
>> > +			iter->base.referent = iter->iter0->referent;
>> 
>> Presumably base.referent is initialized to NULL so this "if"
>> statement does not need an else clause?
>
> This function typically ends up being called in a loop though. So
> without the else clause, wouldn't we potentially leak the value of a
> preceding ref into subsequent iterations like this?

OK, so this does need to clear it when we tell the caller we have
non SYMREF, as we do want to show NULL as base.referent to the
caller in such a case.  Thanks.

It does reinforce my larger point, which was:

>> Makes me wonder if we should follow the same "ignore what the flag
>> says when filling the .referent member; if the ref is not a symref,
>> the referent variable is NULL, and if it is, referent is never NULL"
>> pattern?  Then ref->u.value.referent is _always_ defined---the
>> current code says "the u.value.referent member is undefined for ref
>> that is not a symref", but with the suggested change, it will be
>> "the u.value.referent member is NULL for ref that is not a symref,
>> and for a symref, it is the value of the symref".
>
> Yeah, I think that would be preferable indeed.

In other words, with .referent member introduced, checking for
(.flags & REF_ISSYMREF) becomes a redundant&duplicated bit of
information, as the bit should exactly match the non-NULL ness of
the .referent member.

Thanks.

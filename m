Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B541E877
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 17:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713203634; cv=none; b=JpCCkExVDpa55xXjnQyGOHgHvGMCrVCN84/fbSMe1ACmT38PH6RNAn44/j1lFaU7poHnfHJJaNmfKr8rQM6+tKZMQDXo+o4+DhykdNIAVR1nYOmScrTqL3O0+5FkkNN48uTLSPQHGI6wD313R2oVq6IH13FaIrfZENheFYVCgWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713203634; c=relaxed/simple;
	bh=063I7oGxWpe2e32VYZACxmlQIGAgpai6qY03VO2H2PY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jKs5CR3gZbVUBTJyTAMdAJGSVTmSmcSqEQWuhc/EhshM9kgbimsw5zmjze4DPRFxpb5YO8ja3KJV2NHUybgR8dHZFrRJuVg01BDwL7Ejx4MRV9nxV+ilG76b6a+WVWV/TXONqnr7JnBOBE7bKNgts5CgK6oLKIfOrwy1fieGQkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bRk8jPND; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bRk8jPND"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C23053276F;
	Mon, 15 Apr 2024 13:50:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=063I7oGxWpe2e32VYZACxmlQIGAgpai6qY03VO
	2H2PY=; b=bRk8jPND7lCNTeIqXQ1Mj2IoOMDErpmKsjMCuov5lZiOa5fGVfX6bf
	4fZC5XiFoUwg+7chWQTrqR/bTI0tHXmnoqsBa+g43gN3BqM27wD/CIOW17sypHL6
	I0dg35ldLbF2IBTUgCIiRMdSQjlLk7JQapdl0EflQXghH7VVNSOX8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BACBC3276E;
	Mon, 15 Apr 2024 13:50:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C6EEA3276B;
	Mon, 15 Apr 2024 13:50:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 0/5] global: drop external `the_index` variable
In-Reply-To: <28541f00-9054-4aa0-8e47-348043b5f863@gmail.com> (Phillip Wood's
	message of "Mon, 15 Apr 2024 14:55:07 +0100")
References: <cover.1713180749.git.ps@pks.im>
	<28541f00-9054-4aa0-8e47-348043b5f863@gmail.com>
Date: Mon, 15 Apr 2024 10:50:48 -0700
Message-ID: <xmqq8r1eo6pz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B20E5328-FB50-11EE-A53E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Maybe I've got the wrong end of the stick but my impression is that it
> is the use of "the_repository" in library code (i.e. the files outside
> builtin/) that causes most of the pain. With that in mind would be we
> better focusing contributor and reviewer effort on eliminating
> "the_repository" from those files instead? It would need to be done in
> carefully in stages but would bring real benefits.

I am afraid that it would take a much larger effort.

I have a suspicion that many of the users of the_index do not have
to even need that the index_state they work on is connected to any
instance of a repository object (in other words, I tend to think
that the value of having a pointer to an index_state in an instance
of a repository structure is dubious), so in a sense, this rewrite
of code that use the_index to use the_repository may be going in a
wrong direction.  In other words, these functions may eventually
want to take a pointer to an index_state structure as their
parameters, without having to deal with the whole repository
structure, but this rewrite assumes they would eventually want to
all work with a repository structure when the_repository dependency
is lifted.  I'll need to see the codepaths involved more carefully
and think about it.

Thanks.



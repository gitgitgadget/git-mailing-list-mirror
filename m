Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A19119E82F
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247224; cv=none; b=rgFghFdGfZZzY1XnUHX3d6I5q+9913H6LTvjk5//hKxDACpM19jok63O+OEly1qwMqXHPUOVOszqBvQ5HG3TvqvnGWFoK3F6RzofkVfrJH/A90X7giELZgSbNJz/C+L/HfQGw7VoNSoHtoCysA3hTv9fU56RY9dub495MhZbly0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247224; c=relaxed/simple;
	bh=hMYJpE/3UPUNxueOmo+4d0Ywg09VqnCXYnZMOSz15DM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DPivI0MklxdXuue44grsnmObJBxg4rqqIsl9EOQWWWvkgVEgbN14ZfencqQV1fIHtllAR5yITJY+n0FjWeDMuPh69sdI7l3UdQd6LcgCUX4ob0KoBUot21So4xgD77pBMuyVrsy93wmMGhiIcRhZ4HmDrNT1uZbvKKh52gYwOxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eOMwMQJl; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eOMwMQJl"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D9A4E2150F;
	Mon, 24 Jun 2024 12:40:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hMYJpE/3UPUNxueOmo+4d0Ywg09VqnCXYnZMOS
	z15DM=; b=eOMwMQJl/oTosIIZS7AqHL0fgM+H2iaCkFpkxVMEoHE9gEF+IlRGku
	pyK92R29HsnGKca83lqlly5+dlsSAQnRvm5nT2POSXbYriDszajpH+94LhealE2l
	sWsVPKRRJwm9P2xtiZS6vdEMfiUueaxcSrDUN9iv/Ig8EqG1IE9YI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D32AF2150D;
	Mon, 24 Jun 2024 12:40:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F10302150A;
	Mon, 24 Jun 2024 12:40:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sean Allred <allred.sean@gmail.com>
Cc: David <dark0dave@mykolab.com>,  git@vger.kernel.org
Subject: Re: [PATCH] submodule: allow gitsubmodules to be pointed at tags
In-Reply-To: <m0sex2pi7q.fsf@epic96565.epic.com> (Sean Allred's message of
	"Mon, 24 Jun 2024 08:45:45 -0500")
References: <pull.1703.git.git.1718625706679.gitgitgadget@gmail.com>
	<m0wmmepj3b.fsf@epic96565.epic.com>
	<7D5BFC58-9BF1-4818-828D-453C416949EB@mykolab.com>
	<m0sex2pi7q.fsf@epic96565.epic.com>
Date: Mon, 24 Jun 2024 09:40:18 -0700
Message-ID: <xmqq4j9icn0t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 71CC6A46-3248-11EF-AC25-C38742FD603B-77302942!pb-smtp20.pobox.com

Sean Allred <allred.sean@gmail.com> writes:

> If you're ok with that behavior, then does it make sense to
> generalize it to the concept of a ref instead of just a tag name?
> This may do a better job of communicating the idea that no ref is
> inherently immovable.

Yup, I only took a brief glance at the patch, and I didn't quite see
the point of duplicationg an almost parallel mechanism to an
existing (--single-branch, set-branch) pair of the feature, only to
replace "branch" with "tag" (the patch noise / code churn did not
seem worth it).

In other words, is there a situation where a branch cannot be used
(or using a branch is more cumbersome or awkward) when the user
wants to use a tag with this patch?  As users can just as easily
move tags as they can move branches, the verb "freeze" used in the
proposed log message probably does not reflect reality anyway, as
you already pointed out.

Thanks.

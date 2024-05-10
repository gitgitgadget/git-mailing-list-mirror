Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05956CA6B
	for <git@vger.kernel.org>; Fri, 10 May 2024 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715355663; cv=none; b=JJUzvqnks0Ns0kALm5R97Kv5T4HxK8kHjOYqKRy7H1QHpPB+bKnGxK/2jWR9zrbOPfdh3V96lwI+JsjQdynPhx/SE/FgNtoyS3+NxEf3R1cDzWboKUAPj6Vp7E0803OKAPfsrTpWz95WMcIt2yQW2Vd9E23o6UfZI7baSVgjF+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715355663; c=relaxed/simple;
	bh=AgbVL71fuK3KPgtxcEK29fiWb4YyW+p4tt68WNTV2jQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sZXT/go9QzeeX5yMI5Ja/b8KfbAiP1S3Llbm5IOUFS0FQjAwWj7jV09YIn6fIw0gIaCYvTldib1Ssnh4wqN91EuA+5fGaVavvDQhEMQnfSQMx+/kfB2dlj+9sEYXuyG5rqpGDMbCj05iYghKcfr5RoAQ85gtj5bo1BaAZtuiB9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dY1Hbqt4; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dY1Hbqt4"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BA2D34C65;
	Fri, 10 May 2024 11:41:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AgbVL71fuK3KPgtxcEK29fiWb4YyW+p4tt68WN
	TV2jQ=; b=dY1Hbqt4CE+D5zeQSUqymbjoOgdr5Ai2AZF2r5Uo8MKSAcGrVN+45/
	dnMlpj+Ei94sAAoNzIET3M7g9CIelZRFb86wEaTfhzfpYP/M8yaFj/1IeqWh1Zx8
	+v4XWBYqCTPdEDqI6LairYxcuprY1xdFKitO6a+ATm1AmdMUWxs6k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9583834C64;
	Fri, 10 May 2024 11:41:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 22E1334C62;
	Fri, 10 May 2024 11:40:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/13] reftable: prepare for re-seekable iterators
In-Reply-To: <Zj3RR-I1v1XwSuJ-@tanuki> (Patrick Steinhardt's message of "Fri,
	10 May 2024 09:48:23 +0200")
References: <cover.1715166175.git.ps@pks.im> <xmqqwmo3x44s.fsf@gitster.g>
	<Zj3RR-I1v1XwSuJ-@tanuki>
Date: Fri, 10 May 2024 08:40:56 -0700
Message-ID: <xmqq1q697jzr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B22F5A0E-0EE3-11EF-B346-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The below diff would be needed on top of what you currently have in
> `seen`. In any case though, I can also resend this topic with
> ps/reftable-write-options pulled in as a dependency. Please let me know
> your preference.

Is it "needed", in the sense that "without the fix what you posted
is broken in such and such ways", or is it "I think it is niceR to
have it on stack because this one instance does not have to be on
heap"?  To me, they look equivalent and I have no problems with the
"nicer" variant, but your "needed" makes me wonder if I am missing
some correctness invariants I am violating without realizing.

Thanks.

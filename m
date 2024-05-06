Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E594156220
	for <git@vger.kernel.org>; Mon,  6 May 2024 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012105; cv=none; b=VeoDqrvdFOuUfFdX2olooC+wNdgibK2gliuRSryS726u5hAbQwCwlOeGji3VC1VOrV0ZQpeuFydsKzjE6p1OizSRgOXr6tpkvG1W6I06Uw/VxZ7PT0mQnAc1yUQL4jSWpNQhNm7ckB85pFrXlqnu/Lu7sCXiLh0FCvfrk0qp7KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012105; c=relaxed/simple;
	bh=tCdTbLdugSjysmesS//URd5Uj1PJDJCY7NuLRKOPcdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lCGTkbnyrNheEiiRUMDjfPN+LKpasxbWmsrwGYTBAuBWpbvIbkZNNhzudAQMK4Gp61bOVIotBLlAIPnN+YZ53p4wCZsPsKmD4YDjeIkkzzLdEMBfvU24rdGadlY5o6lf26dy2gj3DqR1+cl0R0sFLSxYo+4uGt7LPW633GkuKUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=R9lfv5k5; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R9lfv5k5"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A332B21986;
	Mon,  6 May 2024 12:14:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=tCdTbLdugSjysmesS//URd5Uj1PJDJCY7NuLRK
	OPcdQ=; b=R9lfv5k5fTppM1Xy786kxh3VoUJScRCnymgO5zreJws1eWwPZZkNEW
	foxsCDrEamvrHEmZ7Y4qY+sGVMpMYBVtynW4PJ55PFiJBiTMRwSYF2hbuaVkH2qe
	9/9bKB+bjnqvyuZ0m55Suke0WJi6Umjz5G8O5pK1b9ZsL23dg/vmI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A42D21985;
	Mon,  6 May 2024 12:14:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 03C8F21984;
	Mon,  6 May 2024 12:14:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 0/5] refs: remove functions without ref store
In-Reply-To: <Zjh8XWwJKp_I1dwE@tanuki> (Patrick Steinhardt's message of "Mon,
	6 May 2024 08:44:45 +0200")
References: <cover.1714717057.git.ps@pks.im> <xmqqikzu95cf.fsf@gitster.g>
	<20240503173553.GC3631237@coredump.intra.peff.net>
	<xmqq7cga7nzo.fsf@gitster.g> <Zjh8XWwJKp_I1dwE@tanuki>
Date: Mon, 06 May 2024 09:14:55 -0700
Message-ID: <xmqqseyu3ojk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C7CC49A8-0BC3-11EF-8F66-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> It's also in line with how other subsystems behave. Everything relating
> to strbufs has a `strbuf_` prefix, attr-related code has `attr_` or
> `git_attr_`, mem-pool has `mem_pool_`. So ref-related code having a
> `ref_` prefix just feels natural to me.

OK.  This is a tangent but there are a few functions with strbuf_
prefix whose sole association with the strbuf is that it is the type
that happens to be used to store the operand of the operation (it is
like naming getenv() as str_getenv() or something silly like that).
We should rename them to lose their strbuf_ prefix in the longer
term.

> ... But honestly, I doubt
> that it would be faster for any author of a patch series to figure out
> that they now need to a define something compared to just adding the
> `refs_` prefix to their functions.

The authors would not bother figuring that out while your series is
not yet in 'master'.  The alternative they have is to base their
series on top of yours.  You may have "what changes are needed on
the callers side" in your head, but they don't.

Somebody brought up the approach used in <banned.h> to move the
problem to link time, but in the context the only message we are
giving is "it is banned - do not use it", which is sufficient over
there, but probably not in this context.  "it was removed - use this
instead by adding this suffix and add that as the first parameter"
is the message I want whoever needs to deal with the fallout to see.



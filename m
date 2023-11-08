Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DFA328D2
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 17:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XGv84km3"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599571FE4
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 09:43:08 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DB09C2BE22;
	Wed,  8 Nov 2023 12:43:07 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=N5txxFyHBgWjmIu99lWztIjrxNbxHhk17zBFh+
	Axn1s=; b=XGv84km3x1kXBNQjNPzYjNwgnV+diTLJdCSsI24nN643m/WF1ACCOw
	/yz5m+sOH8Z0HP1uJhEMjzKkTTOdKBPpBQtWwnjUhg4hAnpuHIaLX4SbONe+JPeC
	azcgJPdhyYQhsUKBJ7iEzuIvurEldC62wLNKr8u1ArmuEcLHhZ9+g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D34E42BE21;
	Wed,  8 Nov 2023 12:43:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7521D2BE1A;
	Wed,  8 Nov 2023 12:43:04 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] t9164: fix inability to find basename(1) in hooks
In-Reply-To: <20231108172125.GD1028115@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 8 Nov 2023 12:21:25 -0500")
References: <cover.1699428122.git.ps@pks.im> <cover.1699455383.git.ps@pks.im>
	<361f1bd9c88e3e6b7b135ba67b39d3bf4d70e322.1699455383.git.ps@pks.im>
	<20231108172125.GD1028115@coredump.intra.peff.net>
Date: Thu, 09 Nov 2023 02:43:02 +0900
Message-ID: <xmqqwmus3zvd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4503E474-7E5E-11EE-9FD3-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> ... But the more robust way to do it is:
>
>   # export ORIG_PATH, which presumably is not cleared the same way PATH
>   # is, so that the hook can access it
>   ORIG_PATH=$PATH &&
>   export ORIG_PATH &&
>
>   cat >"$hook" <<EOF
>   # pull the original path from the caller
>   PATH=$ORIG_PATH
>   export PATH
>
>   ...do other stuff...
>   EOF
>
> That's assuming that environment variables make it intact to the hook at
> all (it is not clear to me why the original $PATH doesn't).

Yeah, the parenthetical comment points at the crux of the issue.  I
can tell from the patch what issue the platform throws at us we are
trying to work around, but it is frustrating not to know why the
platform does such unpleasant things in the first place.

Thanks.

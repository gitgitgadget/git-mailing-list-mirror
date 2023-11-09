Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B318F156C1
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SMnZtl76"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D6C2D65
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 02:06:26 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 83C4F1B2EE3;
	Thu,  9 Nov 2023 05:06:25 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bMxnyyZfZJCVJW85ryp7L1d3jUsfWRgtiHsPbq
	EjL00=; b=SMnZtl76bCkU07Mcl4HA6J+gIHIKUzOfRLyzeXZGkkKzN3V9HjgPsH
	O5nLGqWcEy43yS9k2xEJzrOrWGihjS+ZVEDQalLcOihVag5cPKtuAOXnYDzInNPg
	0OiWgwJgik+ThpK7a1znZDGOsixcJYEMmGjPe3P6oyn0k1R9YZBYo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C1AF1B2EDE;
	Thu,  9 Nov 2023 05:06:25 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD85F1B2EDB;
	Thu,  9 Nov 2023 05:06:23 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Oswald Buddenhagen
 <oswald.buddenhagen@gmx.de>,  Victoria Dye <vdye@github.com>,  Christian
 Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v6 0/8] ci: add GitLab CI definition
In-Reply-To: <cover.1699514143.git.ps@pks.im> (Patrick Steinhardt's message of
	"Thu, 9 Nov 2023 09:05:21 +0100")
References: <cover.1698305961.git.ps@pks.im> <cover.1699514143.git.ps@pks.im>
Date: Thu, 09 Nov 2023 19:06:22 +0900
Message-ID: <xmqqjzqr1bs1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A3EE8488-7EE7-11EE-AD05-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> There's only a single change compared to v5 based on Chris' feedback,
> namely to move around a `return 1`. The newly extracted helper function
> `create_failed_test_artifacts()` indeed wasn't the correct place to put
> this error code.

The caller of the helper always signals failure by returning with 1
after calling this helper, and if we later add new callers, it is
very plausible that the new callers also are calling the helper
because they have noticed that the tests failed.

If the helper were not named "create_failed_test_artifacts" but were
given a more appropriate name, say, "fail_with_test_artifacts", we
wouldn't have said that the helper is not the right place to return
with a failure status.  So, quite honestly, the difference since the
previous round is strictly a Meh to me.

But let's queue this version, because it is not making it worse ;-)

Thanks.

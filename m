Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83ED394
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 00:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gj16oRYw"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96EF95
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 16:44:43 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 600581B944;
	Tue, 14 Nov 2023 19:44:43 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DcvDm+Nv2/pJG/jrX9cKMYrZlkG8OqcIvHhWfL
	9ZOJo=; b=gj16oRYwdWKm/sfeTFPxozJ6NCjsH0LYtCQ6I6tpAA/obZIoO/ElwF
	MB+7nEDWB/nST6ajV7NG0nTp7KUWqBwMDLRVuF+9eLDEUjj0u4qzQOstXduHU4Nr
	5cHwB6veqXIWzjgjvtrqQHvT4mkciZBio3a70vWeQ3t6psRs3Xl9A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 563171B943;
	Tue, 14 Nov 2023 19:44:43 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D4C061B93F;
	Tue, 14 Nov 2023 19:44:39 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH] commit-graph: disable GIT_COMMIT_GRAPH_PARANOIA by default
In-Reply-To: <20231114194310.GC2092538@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 14 Nov 2023 14:43:10 -0500")
References: <7e2d300c4af9a7853201121d66f982afa421bbba.1699957350.git.ps@pks.im>
	<ZVNNXNRfrwc_0Sj3@tanuki> <xmqq7cmkz3fi.fsf@gitster.g>
	<xmqqzfzgxops.fsf@gitster.g>
	<20231114194310.GC2092538@coredump.intra.peff.net>
Date: Wed, 15 Nov 2023 09:44:38 +0900
Message-ID: <xmqq4jhnyhe1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 28B7A20A-8350-11EE-B260-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> What I'm getting as it that I think we have three options for v2.43:
>
>   1. Ship what has been in the release candidates, which has a known
>      performance regression (though the severity is up for debate).
>
>   2. Flip the default to "0" (i.e., Patrick's patch in this thread). We
>      know that loosens some cases versus 2.42, which may be considered a
>      regression.
>
>   3. Sort it out before the release. We're getting pretty close to do
>      a lot new work there, but I think the changes should be small-ish.
>      The nuclear option is ejecting the topic and re-doing it in the
>      next cycle.
>
> I don't have a really strong preference between the three.

I've been (naively) assuming that #1 is everybody's preference,
simply because #2 does introduce a regression in the correctness
department (as opposed to a possible performance regression caused
by #1), and because #3 has a high risk of screwing up.

As long as the performance regression is known and on our radar,
I'd say that working on a maintenance release after Thanksgiving
would be sufficient.

I might be underestimating the impact of the loss of performance,
though, in which case I'd consider that nuclear one, which is the
simplest and least risky.

Thanks.


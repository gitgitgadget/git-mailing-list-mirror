Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99423E476
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P7g7JhBV"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A881F93
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 08:48:35 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EB821C3DC7;
	Tue, 14 Nov 2023 11:48:35 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EOQtux6aK/X26CSzcnreDoLQ/DfYrdv0CGZC+V
	ZmxMc=; b=P7g7JhBVHmR6Ba4HmVLXtTdNxtzcYm7rEFRy+3QGmrOCJmhE3zqSb3
	R0tDllnRP8yWGDgMLOzcVpUaHogfhOy85ypDjbXcSr1aQhEQK1q8IopkitUIogwq
	EqlwN9ykBRSYhML+gqv/EZmXh19cKkhayXibGbkt2HB9YRQJxcRpY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 069AB1C3DC6;
	Tue, 14 Nov 2023 11:48:35 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 67F211C3DC2;
	Tue, 14 Nov 2023 11:48:34 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH] commit-graph: disable GIT_COMMIT_GRAPH_PARANOIA by default
In-Reply-To: <ZVNNXNRfrwc_0Sj3@tanuki> (Patrick Steinhardt's message of "Tue,
	14 Nov 2023 11:35:08 +0100")
References: <7e2d300c4af9a7853201121d66f982afa421bbba.1699957350.git.ps@pks.im>
	<ZVNNXNRfrwc_0Sj3@tanuki>
Date: Wed, 15 Nov 2023 01:48:33 +0900
Message-ID: <xmqq7cmkz3fi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A66389C8-830D-11EE-BE60-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Gah, I forgot to run this with GIT_TEST_COMMIT_GRAPH=1 before sending
> this patch. There are two test failures that this change introduces:
>
>   - t6022-rev-list-missing.sh, where we test for the `--missing=` option
>     of git-rev-list(1).

I would have expected you to enable the paranoia mode automatically
when this option is in effect.

> Both of these are expected failures: we knowingly corrupt the repository
> and circumvent git-gc(1)/git-maintenance(1), thus no commit-graphs are
> updated. If we stick with the new stance that repository corruption
> should not require us to pessimize the common case,...

Yeah, just like we try to be extra careful while running fsck,
because "--missing" is about finding these "corrupt" cases,
triggering the paranoia mode upon seeing the option would make
sense, no?  It would fix the failure in 6022, right?

Thanks for working on this.

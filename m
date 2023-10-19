Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492FF19440
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VxKABGUw"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5487413D
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 16:35:57 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2DA4820D3A;
	Thu, 19 Oct 2023 19:35:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bVnXlT9fMzkQITCCfQhOkKxx70Ebr01qJ9ciJE
	l/90o=; b=VxKABGUweIg1lKRuKk1z1x4myBwyXVvvWPZeZqN7n5QxJN3SuamTNv
	zrT6Uj+zOgabr+j2nla0AwIqL0QhkQ8dW7NV9BBYqNA9yZ628gMdgUqoNAIZJUfV
	aGhx5NLIf4wX1hidiC06bTn7uVdqTfEwOuq8zrfC8NbDfFENAx3oQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2651620D39;
	Thu, 19 Oct 2023 19:35:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 038C520D37;
	Thu, 19 Oct 2023 19:35:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v3 3/3] rev-list: add commit object support in
 `--missing` option
In-Reply-To: <xmqq4jimuv26.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	19 Oct 2023 15:05:53 -0700")
References: <20231016103830.56486-1-karthik.188@gmail.com>
	<20231019121024.194317-1-karthik.188@gmail.com>
	<20231019121024.194317-4-karthik.188@gmail.com>
	<xmqq4jimuv26.fsf@gitster.g>
Date: Thu, 19 Oct 2023 16:35:41 -0700
Message-ID: <xmqqttqmtcc2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3838EE14-6ED8-11EE-85BF-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Do we really need to allocate a new bit in the object flags, which
> is already a scarce resource?

Clarification.  I was *not* wondering if we can steal and (re|ab)use
a bit that is used for other purposes, in order to avoid allocating
a new bit.

Rather, I was wondering if we need to use object flags to mark these
objects, or can do what we want to do without using any object flags
at all.  For the purpose of reporting "missing" objects, wouldn't it
be sufficient to walk the object graph and report our findings as we
go?  To avoid reporting the same object twice, as we reasonably can
expect that the missing objects are minority (compared to the total
number of objects), perhaps the codepath that makes such a report
can use a hashmap of object_ids or something, for example.

Thanks.

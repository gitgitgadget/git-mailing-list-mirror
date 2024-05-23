Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56866D531
	for <git@vger.kernel.org>; Thu, 23 May 2024 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716480240; cv=none; b=I8C3OyafXh5uYnjAOhZQlzoJ6TFx8n8Mm5VIqkU45p/uY+eJ9t9Wi/1DoAzNJUuU7pCdJj3u/QumgJsbUfqGVspsCYk7SWzU72g090XSYklW3mP4m5O0e/fKLtz0bQBXfNfgAu0oGRS4XdttDONlSvieDvTxSE59ns3WCM1LruI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716480240; c=relaxed/simple;
	bh=jeP7s97BH6dGr6ZkIbJEUvB9b1zjCWmwATnGiv6c00I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PM2PI8elaUCCtaIJKVjRaF66WNDRVbSn3KrKgjVRfvZLQb9xOhpg8fge0aw7XGzDOUukAf/KVUy8p/M6por6ZjgLktF5j4O0E6qxebjNofyUkUMqTC/tN3Bf62Th9nqO6CrXGtRL2fz3VlCiRf4YuFUxEsKeJlRim4pW/S4OfXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SYDQnS9/; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SYDQnS9/"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C0D1E20CEB;
	Thu, 23 May 2024 12:03:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jeP7s97BH6dGr6ZkIbJEUvB9b1zjCWmwATnGiv
	6c00I=; b=SYDQnS9/+HapfxND2NMHYf7VM7N5heum7hyPBXLFMcVr8izrJHiVBD
	ruZDClvJspeP5Ula3T33bJR1MRkLunJkGpaDhGzd7YbM6TfK54ajjKQHst5dhHNO
	FRyH2rkTwVxnf1mX9Ol2qOKjkT7NZKzPOKNAT3++/aeAyGnnmqlBs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B948420CEA;
	Thu, 23 May 2024 12:03:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6192A20CE9;
	Thu, 23 May 2024 12:03:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 0/6] update-ref: add symref support for --stdin
In-Reply-To: <xmqqbk4wy3ji.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	23 May 2024 08:02:41 -0700")
References: <20240514124411.1037019-1-knayak@gitlab.com>
	<20240522090326.1268326-1-knayak@gitlab.com>
	<xmqqbk4wy3ji.fsf@gitster.g>
Date: Thu, 23 May 2024 09:03:53 -0700
Message-ID: <xmqq1q5swm52.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0E76CEA2-191E-11EF-96DE-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Wait.  There is something fishy going on.
>
>> Range diff vs v1:
>>  1:  1bc4cc3fc4 =  1:  1bc4cc3fc4 refs: accept symref values in `ref_transac...
>>...
>>  8:  4865707bda =  8:  4865707bda refs: remove `create_symref` and associated dead code
>>  9:  4cb67dce7c !  9:  2bbdeff798 refs: create and use `ref_update_ref_must_exist()`
> ...
> I am confused why we are seeing a total reroll of such an old topic.
>
> Also you have one more patch at the end.  Neither the before or
> after version of 9/9.
>
> Is this actually a single patch submission of 9/9 alone?  Patches
> 1-8/9 are all old ones that are in 'master' already.

And then there is a mystery of this v2 being a 6-patch series.
Perhpas a wrong range-diff was pasted into it?  If this were truly a
total reroll of the previous 8-patch series with an extra step
appended to the end, it would have been a 9-patch series, not 6.

Even puzzled...

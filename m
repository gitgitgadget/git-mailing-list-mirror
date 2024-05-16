Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809EB145A06
	for <git@vger.kernel.org>; Thu, 16 May 2024 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715882468; cv=none; b=I+qQ4ErvZvhTBhIxUwp/PVkSCuknQi+4BIs3coGIV5GEKPzVDySnqeAguLpylRmgMc/WtFdSEE8ICTFPBWoVQTq5y+loRN44VJS9u7g7h4dGxSQZe3ckL83CXBVqZ0GnIBMHoFFZztIfhCkCcX2Fz+ht6fg7Ychh1xOaXKLB/kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715882468; c=relaxed/simple;
	bh=mEUneoyVN1dGOEomdrC+LpmXs1JtyCe4mmVGh4tRlYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z3O70mbBfPj1AzjRKrERG5FcduTiXqFr59GFlRKX2NHW66qCsox4A3gTZFW3jrFJxJ5D6yVaIuuY91auWCtbNApxjJKPfswLXk5WD2cEK7cOou3Tk8I2TSuINPxrrpv7nYXiK6j+pm1CjpR0hIREv+Lq0w3waj5k8uyMmTTa9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BRthRq/s; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BRthRq/s"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B9ECD211EB;
	Thu, 16 May 2024 14:01:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mEUneoyVN1dGOEomdrC+LpmXs1JtyCe4mmVGh4
	tRlYU=; b=BRthRq/s+7ZFWEBHCEAvn20plhdXiz72gzlru07pEl6Ra4mMDnA8JM
	M8Teu/JVE9Hn5YhSeJQP/v/csuzPJh6H8GchiRSyQgt2OOJUSveaqrQsHxzNnnrX
	PfXQ35wc9d05mWVinEmattYqfE2uCmjRGGNQfWggqDb/iXhFWzyW0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CEBD2211E9;
	Thu, 16 May 2024 14:01:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6B01C211E6;
	Thu, 16 May 2024 14:01:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 03/16] refs: implement releasing ref storages
In-Reply-To: <CAOLa=ZT3VqhrHXt9x-4DN7norTb3RuscBx+VHipn=QxJvwwThQ@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 16 May 2024 11:39:36 -0500")
References: <cover.1715836916.git.ps@pks.im>
	<282fbe35a7c9db715a8a805f93f9b465d42885a5.1715836916.git.ps@pks.im>
	<CAOLa=ZT3VqhrHXt9x-4DN7norTb3RuscBx+VHipn=QxJvwwThQ@mail.gmail.com>
Date: Thu, 16 May 2024 11:01:01 -0700
Message-ID: <xmqqjzjtr602.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 42047DAC-13AE-11EF-998B-25B3960A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

>> +static void debug_release(struct ref_store *refs)
>> +{
>> +	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
>
> We should probably add a trace here, using `trace_printf_key()`

A totally ignorant question.  Should we be adding more traces with
trace_* API instead of trace2_* API?  If the latter aims to cover
superset of use cases the former did, I was hoping that we can
eventually deprecate the former, hence this question.  Of course We
could add a compatiblity layer that emulates trace_* API with a thin
wrapper around trace2_* API, but if we do not add new callers, it
may still be feasible to directly migrate the callers to use trace2_
API without having to invent such compatibility wrappers.


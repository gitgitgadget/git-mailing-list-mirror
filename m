Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757F716D318
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 17:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721670740; cv=none; b=jgBL5E8LbyEF7JtW6tXEvHxcd4pfX0FNQckoxwMtSsfVu7ZL2sSl0kmDrHOfVFfVNbfiwxsUWu7teNezNU6D8JjWCqRdelsw5Lk8lTsc6FSyfX2Gp+f7CkdBubBYw+ge6thHnpXgY1GGFkyzGO+dUdzD38DWkLMcooI7hC3axoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721670740; c=relaxed/simple;
	bh=9Otp9ZcSjiVP+R+D/9S2h/fc0w9JJT4UH9i0WfCNEpg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NfpV4LvoF/dBwN0gh7Nq39S7cQShnkzFHY8P6gzoQP2c+ovDsEIEHTCe5S2yInq0BJfE3hYOVQdxmmGKmR72MkHYQCfF9E9zclvyoYhfknz9S1/CUB9MAOnILCKja9PMspup4hfGvnBjlR1yPyvUYCYwM77p1bZvd+w8YIYd0NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Cxr775VC; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cxr775VC"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 526FD20908;
	Mon, 22 Jul 2024 13:52:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9Otp9ZcSjiVP+R+D/9S2h/fc0w9JJT4UH9i0Wf
	CNEpg=; b=Cxr775VCNzrtYIDbwYtOle60PPnNxcIzd31ZkSKbL9hDbkvRu0OYCb
	Th4X8Ee0P+AZ391Q8CFsk6FwYaAnaTpyHCUqXm6lfNRyitCWD+zhMu0a+oDfnA0Z
	p1jHJcIrY7C+LMaQymDeaIkVMD44cInxJ0HXmKYxfj7dxpLL1E6tg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A05620907;
	Mon, 22 Jul 2024 13:52:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF43420906;
	Mon, 22 Jul 2024 13:52:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org,  karthik188@gmail.com,  chriscool@tuxfamily.org
Subject: Re: [PATCH v5 2/5] t: move reftable/tree_test.c to the unit testing
 framework
In-Reply-To: <20240722061836.4176-3-chandrapratap3519@gmail.com> (Chandra
	Pratap's message of "Mon, 22 Jul 2024 11:27:55 +0530")
References: <20240716075641.4264-1-chandrapratap3519@gmail.com>
	<20240722061836.4176-1-chandrapratap3519@gmail.com>
	<20240722061836.4176-3-chandrapratap3519@gmail.com>
Date: Mon, 22 Jul 2024 10:52:15 -0700
Message-ID: <xmqqikwxco1c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 22563688-4853-11EF-8EA8-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> reftable/tree_test.c exercises the functions defined in
> reftable/tree.{c, h}. Migrate reftable/tree_test.c to the unit
> testing framework. Migration involves refactoring the tests to use
> the unit testing framework instead of reftable's test framework and
> renaming the tests to align with unit-tests' standards.
>
> Also add a comment to help understand the test routine.
>
> Note that this commit mostly moves the test from reftable/ to
> t/unit-tests/ and most of the refactoring is performed by the
> trailing commits.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---

Looking good.

"git show -M30" matches the moved file up correctly and makes it
easy to see that there is no serious changes snuck in (please do not
take this as a suggestion to run format-patch with -M30---I am just
saying that it was a good way to give an extra validation).

Thanks.

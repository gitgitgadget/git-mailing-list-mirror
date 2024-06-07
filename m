Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C727C19AA6A
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717779557; cv=none; b=jWR+RtEsWlLYwk2IljlUPZ3w7vgAgm4TauIXWQiyNAKoLkGYC1+4OYCO1Lb1p8ufte/ATzG6M3w+5gjUG0qMCM33F90SA3wiEeOCjD1ATW6OxVtcaJn0+adUHw77uyI+u36NEeXZlW7V8iZ3M+lmuwzjJpSHaBaK9SbxiilXXqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717779557; c=relaxed/simple;
	bh=NCzlGDDEphWNLHDLiaYsxyuvHKwq/jiZyObohgN5oEQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WV8xFvWPZyaf1ClgwsLXuZbUL/qg+AnYrOE5uMFg0bdXPaW99Ls+b+kvcJ/sDsmD0baYUFx3hXAldG7HOzw4vTBNe147rLn6tGwEm+iCbmmQQyfOCz2XyOu6ZsxhIqF/qo+riegmyV608WkOxAIbaixOiWWJknelPP6CYo7KSAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CFKvIMWJ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CFKvIMWJ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D244C37983;
	Fri,  7 Jun 2024 12:59:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NCzlGDDEphWNLHDLiaYsxyuvHKwq/jiZyObohg
	N5oEQ=; b=CFKvIMWJdalmZbXwkHgDGxKWp4AfXxkhGvGlQQUfACAM6m4cugDLJ0
	0iSlv/TlLoA6OxuasrprcwIic1xfKKDT2kZB/UVgNSlqYCUefJul98Lyz883OITz
	0oGyRkiOhmMlvUZ7DB76502IDkNQhkAhew6wnVvs/QIacaxJz/xZo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C9E7C37982;
	Fri,  7 Jun 2024 12:59:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 410C637981;
	Fri,  7 Jun 2024 12:59:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Philip Peterson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Philip <philip.c.peterson@gmail.com>
Subject: Re: [PATCH v2] apply: add unit tests for parse_range
In-Reply-To: <b7eca313-9ea8-4132-ba1d-ed9236e07095@gmail.com> (Phillip Wood's
	message of "Fri, 7 Jun 2024 16:00:07 +0100")
References: <pull.1677.git.git.1708317938.gitgitgadget@gmail.com>
	<pull.1677.v2.git.git.1716710073910.gitgitgadget@gmail.com>
	<b7eca313-9ea8-4132-ba1d-ed9236e07095@gmail.com>
Date: Fri, 07 Jun 2024 09:59:13 -0700
Message-ID: <xmqqo78celjy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 44DC2744-24EF-11EF-9A00-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks for re-rolling, I've left a few comments below
> ...
> This is an example of why I don't think we should check p1 and p2 when
> we're expecting the parse to fail. Also please note we don't use "//"
> comments in the code base.
>
> There is a good range of failing non-digit inputs. It would be nice to
> see a test for a hunk header where the number is too large to
> parse. Ideally we'd also change the parsing code to return an error in
> that case rather than waiting to error out later on as the apply code
> does currently. To do that You'd need to explicitly set errno to zero
> before calling strtoul() and check it afterwards.

Thanks.  All points you raised make quite a lot of sense to me.


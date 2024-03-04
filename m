Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A8F7BAFD
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 21:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589046; cv=none; b=Kup9xxUe2Z2gcKrFiCGbgScF6vbF07H+Y6A06a69D2Nnz+WLEgOnha+5BNEhTO3fIzwG40PEwWh0AN8YuJI11drTM4Ajb9VOg9TJ6i+sZHeihv0/J+jHdlZrB8x1N+NbT+pho76xj7VzzR2OwfmFMZC5/KDozXlCk1PCqDgMdOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589046; c=relaxed/simple;
	bh=5A2KKCjQqcewnB6wuSbZ+bw68enTpaiBfPu44HWtJIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NeXnb5tUhejU1kVVpXhSGGTw6IAeEFpKJkr+JVEVTA8VJtNeNlYi2OrOwW1Pc5/aLEU5iWedoS5o+mUjUwGI0dfhoClfesNdkZDeEnIcE2ycfsb3gVmqd0i39b86Qmtcc7O/DUQtrg9aqu95T271kCVb1oYqE6cRBTfmXCibwU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=io5FBMTR; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="io5FBMTR"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A61601F4C61;
	Mon,  4 Mar 2024 16:50:43 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5A2KKCjQqcewnB6wuSbZ+bw68enTpaiBfPu44H
	WtJIA=; b=io5FBMTR6DAbLpi1cdzilbq7UbLpclvb+mdPaUn2ugIxymKuKEy+Kb
	93lBa1W84lpYZ7ycWSvwYt6L8OROqVCjSF+zUkQ+48LLh8KsSBUtJASUWoSgqHxO
	FDuX2GI4NAIJlr19WBq5G9CReuE9AnZDXOstOlegn/P/N29S09cvY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9CE191F4C60;
	Mon,  4 Mar 2024 16:50:43 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0B2801F4C5F;
	Mon,  4 Mar 2024 16:50:42 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSOC][PATCH v3 1/1] t7301: use test_path_is_(missing|file)
In-Reply-To: <20240304171732.64457-2-vincenzo.mezzela@gmail.com> (Vincenzo
	Mezzela's message of "Mon, 4 Mar 2024 18:17:32 +0100")
References: <20240227161734.52830-1-vincenzo.mezzela@gmail.com>
	<20240304171732.64457-1-vincenzo.mezzela@gmail.com>
	<20240304171732.64457-2-vincenzo.mezzela@gmail.com>
Date: Mon, 04 Mar 2024 13:50:41 -0800
Message-ID: <xmqqcys9oedq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3FBE03E0-DA71-11EE-A695-25B3960A682E-77302942!pb-smtp2.pobox.com

Vincenzo Mezzela <vincenzo.mezzela@gmail.com> writes:

> Refactor test -f to utilize the corresponding helper functions from

As Eric pointed out to another GSoC applicant in a different thread,
this is not refactoring any code, so saying "refactor" is a bit
misleading.

    Replace use of "test -f" with the "test_path_is_file" helper
    function ...

> test-lib-functions.sh. These functions perform identical operations
> while enhancing debugging capabilities in case of test failures.
>
> In the context of this file, 'test ! -f' is meant to check if the file
> has been correctly cleaned, thus its usage is replaced with
> 'test_path_is_missing' instead of '! test_path_is_file'.

In other words, the original used "test ! -f" when it meant to say
"test ! -e", and test_path_is_missing would be a correct replacement?

If so that makes sense.

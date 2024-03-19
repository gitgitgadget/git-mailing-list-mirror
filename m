Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D073D69
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 00:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710808374; cv=none; b=b130IHc7jzlgtkkz/hnC3PUqKZo6C+JQMnNDHPdhhPoZpRPyTFB0j9TdRcwH4hclnqAAqE9ojLkEOjTm/Vo+DoHaLq1xiaBFKLpSca82E1Hk+19kgUftEqYmpRNFeYQGC9YtkwRYSVGz8HL0BuevKUcJ3UAFkEu0NaWNFNt8OR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710808374; c=relaxed/simple;
	bh=ahW/9Fsy1vi3AZh4svcgn+T0/jGL9dcdNqm0uN0JS8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b2yu4NZS9j2egmJG1iAzwQCW00kosr1bVN6MuRaadHT6/XFCTvixN8C9vJE3XVrzVXQRTV8jUzvE4kjhi+foCyWrJK/rGzBWcGomCCShRiQtdhTA+fe7/0FL7OL0ZgCDek/NP7dPkfdZ/H26EnxQt+jZJQRIY2epjTv94lGczPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gg20rCfR; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gg20rCfR"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 129261D2823;
	Mon, 18 Mar 2024 20:32:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ahW/9Fsy1vi3AZh4svcgn+T0/jGL9dcdNqm0uN
	0JS8g=; b=Gg20rCfR5OZBwymGi/q9X93tPhrgaoSRSjjdvWjH54xj4M5CLABfE7
	ro9pvTbqNoVT1sOSsFGLi8ceNii4hZD69Z7NH/f8fmrDPVkmxx5nm+lXuQK7ooJf
	OZ7rTYaXDBXibj1HZarV5phjoaPUAIuzxaqQJ0SN8YVs+zUEr64QQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09B2C1D2822;
	Mon, 18 Mar 2024 20:32:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6CD2F1D2820;
	Mon, 18 Mar 2024 20:32:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Dragan Simic <dsimic@manjaro.org>,  git@vger.kernel.org
Subject: Re: [PATCH 1/5] grep: perform some minor code and comment cleanups
In-Reply-To: <CAPig+cQ6Y2oOaPkKFsD41beXLHjhD++nmf59xrcswpb6_Q-sdA@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 18 Mar 2024 15:59:41 -0400")
References: <cover.1710781235.git.dsimic@manjaro.org>
	<96b81f3573d3f29bb97e77d623be0d53cf8085b0.1710781235.git.dsimic@manjaro.org>
	<CAPig+cQ6Y2oOaPkKFsD41beXLHjhD++nmf59xrcswpb6_Q-sdA@mail.gmail.com>
Date: Mon, 18 Mar 2024 17:32:46 -0700
Message-ID: <xmqqjzlzt61d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 35B80B94-E588-11EE-85D3-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> It's entirely subjective, of course, so no right-or-wrong answer, but
> I personally do not find that this change improves code quality or
> readability.

I agree that this is entirely subjective.  To those who wrote these
variable decls and inits, what they wrote was the most readable,
wasn't it?  It probably falls into the "to some readers the existing
code may not be perfect, but once it is written, it is not worth a
patch noise to fix it" category.

> With my reviewer hat on, I spent an inordinate amount of time staring
> at this change trying to locate each variable's new location to verify
> that no initializers were dropped and that the declared type hadn't
> changed.

It is true that "cleaning up, no behaviour changes intended" patches
are unpleasant to review.  They are boring to read, and the risk of
breakage due to mistake is unnecessary and severe.

But if the result is objectively better, such a one-time cost may be
worth it.  We are investing into the better future.  For example, we
may have an unsorted mess of an enum definition, and we do
appreciate in the longer run, such a definition were "more or less"
sorted within the constraint of some other criteria (like, "errors
get negative value").  If the enum is a huge one, it may need some
careful reviewing to verify such a change that turns the unsorted
mess into a sorted nice list, but the cost of doing so may be
justified.

Does the change in this patch qualify as "objectively better"?  I
dunno.

Thanks.

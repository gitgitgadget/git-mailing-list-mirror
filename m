Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1CD7FBDB
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118176; cv=none; b=szSJ/kmBFzHkqh8T7UyYUj0yfkHa2qwNbGWFBf0gl2j8I8mLAGyO7v7oIUEx/OOuSLkVO4cpoR20ynEwqULzhTBimg/Oa5gfE4MLEiNVRzGqzR5V+/3MgurQyd8/ISJDpzvaSuei3DT47rtPl4s2o/M5dIJiLXgrpRTXqRVNu+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118176; c=relaxed/simple;
	bh=eSeE2E/L1Ggy8hWypqYCWFcTiqDSQ+NjwCAQ22+ENag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WK9T0E6qN4v6FKJJpK/ZDWBJHlmDvA0S8OIcxUvQgfBmmdnIXbJ6pv1EC4pKrkFgCnn4mPqUFykmI7KgrW3nSbS1ST6n28G/0v0e94ILUwfntQsoU3JYrmF8iBfOhqeRp10FN7Mfy6oEFIGKA3NWZW7+UnCXs7M9cVD1wrgfQjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Be6U5GWR; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Be6U5GWR"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3DA9F1DA044;
	Wed, 24 Jan 2024 12:42:52 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=eSeE2E/L1Ggy8hWypqYCWFcTiqDSQ+NjwCAQ22
	+ENag=; b=Be6U5GWRC/XfBGehnVILFS83Xc7BOjsLzNepAJkIHcETFIVJP5q18N
	52R3Oj2uznFeArGaOVSrjjU04m55A5G63AKXWCxlPzUlWiIBaC3XwC8OnCPmxWJk
	gA+/z844qmf0lME6LNP7PUKcqKxrAJAbQx/mI/n/u9zeyLscoPRgw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 35E871DA043;
	Wed, 24 Jan 2024 12:42:52 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A37271DA042;
	Wed, 24 Jan 2024 12:42:51 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Md Isfarul Haque via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Md Isfarul Haque <isfarul.876@gmail.com>
Subject: Re: [PATCH 0/2] [GSoC][RFC/Patch] FIX: use utf8_strnwidth for
 line_prefix in diff.c
In-Reply-To: <pull.1653.git.git.1706105064.gitgitgadget@gmail.com> (Md Isfarul
	Haque via GitGitGadget's message of "Wed, 24 Jan 2024 14:04:22 +0000")
References: <pull.1653.git.git.1706105064.gitgitgadget@gmail.com>
Date: Wed, 24 Jan 2024 09:42:50 -0800
Message-ID: <xmqqjznyfx0l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FF2FACEE-BADF-11EE-99F1-25B3960A682E-77302942!pb-smtp2.pobox.com

"Md Isfarul Haque via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch adresses diff.c:2721 and proposes the fix using a new function.

Yay.  My favorite long-time pet-peeve topic.

>
> Md Isfarul Haque (2):
>   FIX: use utf8_strnwidth for line_prefix in diff.c
>   FIX memory leak in one branch

Our convention does not use "FIX" and other prefix on the subject.
Please check Documentation/SubmittingPatches.

Thanks.

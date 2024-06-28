Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3319B1C004C
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594704; cv=none; b=mfgeVwK955pYNhmemiULnHh5SQa+Sz9+12DafY2GHj20CrDk5HxxZUvYIAwlO/wlstwl+HDQ9jMUrq8POXBmFseXiRwo1H4yScq/gBInSUf3S5H4qzbl+GHGnVrdPSL8cXj2rEerxCuiPY590dLEkCYshdL0+2UXVjqlekQaNXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594704; c=relaxed/simple;
	bh=NHG5o1jwTwYZhEvE6VIJDSzOfB9Bf1LblS01vpXqNGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bves+DvBt396ftiIEW8NlXmW+IXZjNayHK1d0uWehLGqirHNKCG6l1+q50oXMkScIzTfEgnBMzOMG6lO5tgdWJ39J65YbmRjM87DKeVjITybvohuQ0nS1n1iaU2rxAFIv2k3E6Uauc/vg2sOXx58fCCyyZVKG+/G5LqHfv29Shg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bemmmXdF; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bemmmXdF"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F157933E22;
	Fri, 28 Jun 2024 13:11:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NHG5o1jwTwYZhEvE6VIJDSzOfB9Bf1LblS01vp
	XqNGA=; b=bemmmXdFnQg2T5bx1P3GtUT0xSZro9xCaLA3taz+bKsUqPQLTMUoVJ
	pqjn7zZU+ATJX+OJJfh2SQhx/AtJogMHKz4X7s60F7AUl3K6xX2+gcVScSTcvc5U
	Fon0/iwUcryARcPs4AY5nxisC5/mjbUi0Aj+LPKF8I8VyZSoCOm6U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D714A33E20;
	Fri, 28 Jun 2024 13:11:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 357D433E1F;
	Fri, 28 Jun 2024 13:11:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 0/7] Fix and improve some error codepaths in merge-ort
In-Reply-To: <3f1e155f-f559-42ac-9454-8ddcf7873f48@gmail.com> (Derrick
	Stolee's message of "Thu, 27 Jun 2024 22:45:34 -0400")
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
	<pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
	<3f1e155f-f559-42ac-9454-8ddcf7873f48@gmail.com>
Date: Fri, 28 Jun 2024 10:11:39 -0700
Message-ID: <xmqq34ox6lh0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7CC0A1DE-3571-11EF-B5D1-965B910A682E-77302942!pb-smtp2.pobox.com

Derrick Stolee <stolee@gmail.com> writes:

> I saw this in Junio's email about series requiring review, so I took a
> look despite missing v1. Stepping through each commit in my local copy
> helped make sure that these changes were correct in their proper context.
>
>> The last two patches change the behavior slightly for error codepaths, and
>> there's a question about whether we should show only the error messages that
>> caused an early termination of the merge, or if we should also show any
>> conflict messages for other paths that were handled before we hit the early
>> termination. These patches made a decision but feel free to take those last
>> two patches as more of an RFC.
>
> I also support this change in the final two patches.
>
> One thing I mentioned in an earlier reply was "why not use an
> enum in this tri-state 'clean' variable?" and then I tried to
> make just such a patch. ...
> ... But I'll leave that as something to think about another time. It
> does not change the merit of this series. I left a note about
> another "&=" case that wasn't touched, but it's not wrong as-is.

Thanks for having done a thorough review, including exploration of
an alternative.  Really appreciated.


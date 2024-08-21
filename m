Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF951136E09
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256517; cv=none; b=efnmJJO6cYdNb0QdqtfCQl2G3E/6uwVc3t/lNqSLCg5uyBu4o+wf1Pr/xmqDxmJQx7a1vQXXmnkZVe4TCbhzrUWAgm5MLKmdcROQF5YF+b3LXUIdN431y/R7N9mS0RadeqPOHGGwQAGrxpg2gEl3evogIagzUW0tT5+L+5lJqFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256517; c=relaxed/simple;
	bh=w+LF+VCIUT6KifWoqjVgVwkC7MUcNWEYSDJZBEXM4jU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cT1I19/9wZtTT4/nfJUy1tGv+vIlMfEXqYQKVv9FRxx91VxApw+5D17zwSGFJ8vmC/Bxnwnt2laxpTYTZTdXlB7Cg1ceN6xjCp/vdMU6CBsHnECjJ7AgKQT5xWU5XVBr8CFKKAAHf3vNDbOgpWSE2p4I3n7mpPPu/hgBbm3MKIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HebEatz2; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HebEatz2"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 578372F24F;
	Wed, 21 Aug 2024 12:08:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=w+LF+VCIUT6K
	ifWoqjVgVwkC7MUcNWEYSDJZBEXM4jU=; b=HebEatz2UUYgtdrqGBe/dAvkHyii
	vshq9cedPnGTWrXJhcn6EHdCbeuPptlsNzQJS7Xa4jFawsrmgjB6AUKhs5rr1KS5
	Kl5CGSi51fp+zrL74KHMow0VQxFAhrN9JBHjdX1wnS1eP0MljQx5E8ER3jan2w27
	xyp26siB2GkduDQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F13C2F24E;
	Wed, 21 Aug 2024 12:08:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D58AE2F24D;
	Wed, 21 Aug 2024 12:08:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,  git@vger.kernel.org,
  Karthik Nayak <karthik.188@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Christian Couder <chriscool@tuxfamily.org>,  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH v4] t: migrate t0110-urlmatch-normalization to the
 new framework
In-Reply-To: <CAP8UFD1WJqKUe-SA=w0oGQNgpLdaQNkc5Uh0rZtmCvDD1oQk7A@mail.gmail.com>
	(Christian Couder's message of "Wed, 21 Aug 2024 12:06:43 +0200")
References: <20240814142057.94671-1-shyamthakkar001@gmail.com>
	<20240820152008.21354-2-shyamthakkar001@gmail.com>
	<CAP8UFD1WJqKUe-SA=w0oGQNgpLdaQNkc5Uh0rZtmCvDD1oQk7A@mail.gmail.com>
Date: Wed, 21 Aug 2024 09:08:30 -0700
Message-ID: <xmqqplq1270h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 9C6EB666-5FD7-11EF-8B45-E92ED1CD468F-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Aug 20, 2024 at 5:20=E2=80=AFPM Ghanshyam Thakkar
> <shyamthakkar001@gmail.com> wrote:
>>
>> helper/test-urlmatch-normalization along with
>> t0110-urlmatch-normalization test the `url_normalize()` function from
>> 'urlmatch.h'. Migrate them to the unit testing framework for better
>> performance. And also add different test_msg()s for better debugging.
>
> This version addresses all the suggestions (nits actually) to improve
> the previous version, so it seems to me that it is good to go.

Looking good to me, too.  Thanks, both.

Will queue.  Let me mark it for 'next' in my "What's cooking" draft.

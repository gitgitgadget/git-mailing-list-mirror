Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB50116B391
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722886731; cv=none; b=p367gdK7lKF+UFITXBkutF0hson2rBhapTD9tW3kKmqO/UoiEhY7MdtJzz5qofFm73APuCdrVy70VYNBRQIHOpUMbYPnsAh0rDuWZS2FkSzVyFHG4EP7QfBb0TX2hxHlz6aKIbTr0riBPatE+H5rZ98IjgAr4mIG/GLNseH71Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722886731; c=relaxed/simple;
	bh=eyuSE6aqNCWqL+FetfbIpe9Fey3q/ylaHvY24Mjfjwo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AowEeKKZipg0wvSO45QeC6RshO7B0har+3Zky89+e10j8np8csY81D/y7bNNxmE3xGXbbg9cJa+yrxO+izfuqQ/FnezrGhYhVBoQ9pCNwBGVs2nlfj0cXv+eoBforzF4YYiI9me8I5XNxa2FNFEwZ+aov8/0aQUHRgfRrWzYJ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=anSPf21o; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="anSPf21o"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 053B02FB61;
	Mon,  5 Aug 2024 15:38:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=eyuSE6aqNCWqL+FetfbIpe9Fey3q/ylaHvY24M
	jfjwo=; b=anSPf21omp4Rm4eu9SsgS4RyGGSJjXLf3fV6QMNTr8who+H4Am58NM
	JQYxYkAnN1JwT/hL2WPLWV1vYH0w4R+lSapqQJTcUv944jpW/qdpQKRSVxWENwsk
	CPRrG1AlrEeuYWogeLPzqP/3OlQRHq/AGwPfIm9EzjKK4YlTxwNUM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F185A2FB5F;
	Mon,  5 Aug 2024 15:38:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E903E2FB5E;
	Mon,  5 Aug 2024 15:38:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v14 09/11] builtin/fsck: add `git-refs verify`
 child process
In-Reply-To: <ZrEbllB6WjLfWqNZ@ArchLinux> (shejialuo@gmail.com's message of
	"Tue, 6 Aug 2024 02:36:06 +0800")
References: <ZqulmWVBaeyP4blf@ArchLinux> <ZqumdJz3-0mqh6Rc@ArchLinux>
	<ZrDMdEJR6DV5HyLD@tanuki> <ZrDtVJYoJJZDesB4@ArchLinux>
	<xmqq4j7y3kmt.fsf@gitster.g> <ZrEbllB6WjLfWqNZ@ArchLinux>
Date: Mon, 05 Aug 2024 12:38:43 -0700
Message-ID: <xmqqsevi220s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 53CE4E84-5362-11EF-A6AD-BF444491E1BC-77302942!pb-smtp20.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> I agree with you that it would be strange if we do not expose any
> interfaces for user who are adventurous. Actually we may simply add an
> option "--refs-experimental" or simply "--refs" to allow the users check
> ref consistency by using "git-fsck(1)".
>
> I guess the concern that Patrick cares about is that we ONLY make refs
> optional here, but do not provide options for other checks. It will be
> strange from this perspective.

I do not care about strange all that much.  I however care about new
complexity in the code, complexity that is not taken advantage of
and is not exercised.  

You said

> From the development of this series, we can know the main problem is
> that fsck error message is highly coupled with the object checks.

and even if it is true and we have problem in fsck code paths, we
cannot see if _your_ solution to that problem is a good one without
having the code that exercises your additional code.

But if "git refs verify" does exercise all the new code paths (and
the refactored code that existed before this series, sitting now in
different places), then I do not have to worry about it.  My question
was primarily to extract "even though we do not wire this up to fsck,
we already have another code paths that uses all these changes" out
of you.

Thanks.

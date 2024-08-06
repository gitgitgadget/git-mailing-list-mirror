Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D6518D640
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722975448; cv=none; b=hri317ZuwboEvxekgClSakg6EsCeYa2diyhOim1UZhWX9qg1uav6LuhSHfcdlRQ1Dl6TaRT1z+LS4zxIdY7b6TOcV6WMqts0jt+4LS3W+9Bq/9quxawq4f8yvckMOzriCQYTc/HsvUir5D7bAYHmSDYR7IT2ST4F//mrWRVUu1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722975448; c=relaxed/simple;
	bh=DUeNiQV4CKhc9KAPVIZzYRzkjxaY0q15a0Saz5BjHYI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HNnQpO+owiRXgeax25+WZmMeHUlpIlUw22IUNl2zJi0P6K1IKWiOWWg6OwPiI0MTQ2m61CrCWaUSQrboKvMNM5RVy0ymXZXxAycFBcbpnLt8A+hXoWzayhLcJXBXz29aGldaGGbZK0j1Vs059ccxhDLFeujyID2egT0l0jqZAC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UHQ86cBb; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UHQ86cBb"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F7E630930;
	Tue,  6 Aug 2024 16:17:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DUeNiQV4CKhc9KAPVIZzYRzkjxaY0q15a0Saz5
	BjHYI=; b=UHQ86cBbNWYNvLJMwgzAHBRS8Z7QtkO8rPekB4qzb4hjrVxID8jgKk
	dYYrRAh10xSIwRc18AS3B5rwVndMyunnCS1rRJf0JJSEWZxPSXjwefiO/QqMWiTx
	w9R0h8AZM04YkyAya62n40FLNT60nq7mz42EJAqgTZxelSnkThT2A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 260A23092F;
	Tue,  6 Aug 2024 16:17:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 65A2F3092E;
	Tue,  6 Aug 2024 16:17:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: John Cai <johncai86@gmail.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff King <peff@peff.net>,
  Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <avila.jn@gmail.com>,
  Linus Arver <linusarver@gmail.com>
Subject: Re: [PATCH v2 3/3] ref-filter: populate symref from iterator
In-Reply-To: <A71B6F98-820D-4692-9712-C6D63F019DCE@gmail.com> (John Cai's
	message of "Tue, 06 Aug 2024 15:49:43 -0400")
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
	<pull.1712.v2.git.git.1722524334.gitgitgadget@gmail.com>
	<3e147e7d850773f44b48d1b86e89aef1415a0ccd.1722524334.git.gitgitgadget@gmail.com>
	<xmqqwml0uqxi.fsf@gitster.g> <xmqqsevouqsj.fsf@gitster.g>
	<A71B6F98-820D-4692-9712-C6D63F019DCE@gmail.com>
Date: Tue, 06 Aug 2024 13:17:23 -0700
Message-ID: <xmqqplqls8x8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E4BA5F68-5430-11EF-9F6F-9B0F950A682E-77302942!pb-smtp2.pobox.com

John Cai <johncai86@gmail.com> writes:

> Yes that's a good question. I took a look and it seems like in *most* cases by
> the time populate_value() is called, apply_ref_filter() has already been called that
> populates the symref member of ref_array_item.
>
> populate_value() gets called by get_ref_atom_value() which gets called by both
>
> 1. format_ref_array_item()
> 2. cmp_ref_sorting()
>
> In the case of [2], the callchain starts with filter_and_format_refs() which
> calls ref_array_sort() that eventually calls populate_value(). Before
> ref_array_sort() is called, filter_refs() is called which ends up calling
> do_filter_refs() with filter_one(), leading to apply_ref_filter().
>
> In the case of [1] however, there are a couple of code paths that call
> populate_value() without apply_ref_filter() ever being called.
>
> pretty_print_ref() directly calls format_ref_array_item() ->
> get_ref_atom_value() -> populate_value(). However, apply_ref_filter() is not
> called which means the symref will not be populated.

I am perfectly OK to keep the "fallback" code, even if you haven't
found a concrete reproduction to trigger it.  Removing it is not
part of what this series is trying to do, anyway.  The theme of the
topic has always been "optimize when we can", at least to me.

Having said that, if we somehow can give the analysis you did above
as hint to future developers, then they can start from there when
they consider if they can remove the "fallback" code.  It would help
even it just said

    /*
     * NEEDSWORK: this might have become a dead code after
     * optimization to grab symref target in apply_ref_filter().
     */

and nothing else.

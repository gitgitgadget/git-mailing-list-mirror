Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAB23FF4
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 01:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749651; cv=none; b=Qlxf3HSRq7m3sz2XGT6jeZNU+CHwAw16SHzO/mcV4awVPuJhpOI/X4/FD7zDxQZqmYxBT5WMqW9KTexoKwSf8hlNsAUPj4kLKWYUOkLmqz4QfPSLbUtX1zoWoffhN2tR3UAnBJUU2XdWW3mT985ZLriBn47ARiUlqs2t7+Vo7xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749651; c=relaxed/simple;
	bh=J61EiOzZZXfYE36iHINu79WDB202Lojj57cIbOEiqKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XzML6VCxHOFsNX24h0ylDyHlxmceKy5TxiWV2ZoFgRVZKC4unfMj5t1i42aCCyFV6liW/6SPsgkNly6Awf7Fs+DY6LkWQzt+HJfwa65xN9xOtfiBdFFVdPodo0qOabjMULkjl9v8McXgZPK25LZxHMuKP2tq2Cf8WUv1uDNXMRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=F7j8AxQt; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F7j8AxQt"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BF2431DA480;
	Wed, 31 Jan 2024 20:07:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=J61EiOzZZXfYE36iHINu79WDB202Lojj57cIbO
	EiqKE=; b=F7j8AxQtrE/VyUgfe+ak34Zc/2KuVZ1U6K/QdgnAckdQVWgqdWTEug
	j5zK1ETyiuvnon3Le2IJJ9N+TbequTNJ6exeVgrXqpb7NvG0O/qaHqxwt+hLBVxy
	d7civ7dtaECeyt4nrBiunxAOTgPZw2ybrQ9leGIic5iEsv+Xdbcho=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AAC481DA47F;
	Wed, 31 Jan 2024 20:07:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 194791DA47D;
	Wed, 31 Jan 2024 20:07:27 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v3 03/10] trailer: unify trailer formatting machinery
In-Reply-To: <owlyv879106s.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Wed, 31 Jan 2024 16:46:03 -0800")
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
	<pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<5c7a2354df0f4a29841f9ab8294ead0e1c3b9cf5.1706664145.git.gitgitgadget@gmail.com>
	<xmqqy1c545y0.fsf@gitster.g> <xmqqa5ol409k.fsf@gitster.g>
	<owlyv879106s.fsf@fine.c.googlers.com>
Date: Wed, 31 Jan 2024 17:07:25 -0800
Message-ID: <xmqqfryd2drm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 43E032B4-C09E-11EE-8013-25B3960A682E-77302942!pb-smtp2.pobox.com

Linus Arver <linusa@google.com> writes:

>> In any case, the updated code does try to call unfold_value() in
>> format_trailers() on "val" that has already been unfolded in
>> parse_trailers().
>
> Correct. But this was already the case before this series. IOW the
> existing code assumes that this function is idempotent: we call
> unfold_value() in parse_trailers() and again in format_trailer_info().

But not in format_trailers(), which is the theme of this step.  In
other words, the behaviour before and after this step of the
function are not the same (modulo that the new version stores the
output in a strbuf), and as the way the changes are presented here,
it is almost impossible to make sure that we are not introducing
regressions, without making such assumptions like "unfold_value() is
idempotent and we already rely on that fact elsewhere in the code".

It is not just "unfold", which was the first thing I happened to
notice, by the way.  There are many more lines in the new lines of
that function, doing things that the original version did not appear
to do, or doing in very different ways.

> I could just grow this series with another ~22 patches to include those
> additional refactors, but I am hesitant about doing so, simply due to
> the sheer number of them.

I actually do not mind at all if you started with a preliminary
clean-up series, and stopped the first batch somewhere in the middle
of the 20+ patches before even reaching any of these 10 patches we
see here, if that gives us a readable set of bite-sized changes that
prepare a solid foundation to rebuild things on top.  I am having a
feeling that not even a single person has reviewed them on list even
though we are already at the third iteration, which is quite
frustrating (and I would imagine that it would be frustrating for
you, too), and I suspect that the step like [v3 03/10] that makes
too large a change with too little explanation (and perhaps a bit of
"trust me, this does not change the behaviour") is one contributing
factor why people are afraid of touching it.


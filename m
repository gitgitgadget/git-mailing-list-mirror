Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA0013C3E6
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318629; cv=none; b=CvVEoKsATVDQDoVd95Hqg35mIHGQJsGbHq0Po49BFVrB9Kw8Ox7GQus4L5wSK+AVaV24QERbrzYQrcK44hFjm/h4dU8QuqTNfzEijYJsGfuU5smfwDk2rHXbaeaD8GneEvNvfI9kxc3m7I/8q56O1KHgP6Mu6O3Owm2eT4vq254=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318629; c=relaxed/simple;
	bh=PwdrvU+4uAsuY3mmMbyS+fkrgZ84x5sR5ynv48BUiOw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PFjsx5JwSwzuGxgdoDurFpEAUYDf/vz7RabIxjg4Uv5FD3NdnffwkDCuqycx5vE+6RTXPUqVK0YcV02FKD5pjbMivXR/hHLCjXcvsvwNOQv26GcSbXM0sJPa0dBuuvq+cQBz3/RD7vVHpkc8YrdWYU8D4Jrt23lpI5UvdBb+N6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eJsa7RT9; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eJsa7RT9"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AF0F422B39;
	Thu, 18 Jul 2024 12:03:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PwdrvU+4uAsuY3mmMbyS+fkrgZ84x5sR5ynv48
	BUiOw=; b=eJsa7RT97585PRgygG2orD7EasyFuiMfpaIXS/zlTrjdOxbN9Sv5Vb
	su8dm6/TGFPSH2XJ1bh7bPvvUqed2o328uk0ahIGljhBfDZGtNwkDkUAfbPB0vt5
	UCRLW1z3wDoPfqfp4HrQBLYgw3FzG6CRWQ361cXMkXpoiHJ6a9B9E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A586C22B38;
	Thu, 18 Jul 2024 12:03:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1B0C722B37;
	Thu, 18 Jul 2024 12:03:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  Eric Sunshine <sunshine@sunshineco.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v11 10/10] fsck: add ref content check for files
 backend
In-Reply-To: <CAOLa=ZRYoYfY-P-dzpYbz0Yq44_TYGyJamf1hufJ0fxGZb3Z0Q@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 18 Jul 2024 07:31:38 -0700")
References: <ZpPEdmUN1Z5tqbK3@ArchLinux> <ZpPFbYOqDVWKz0ic@ArchLinux>
	<CAOLa=ZRYoYfY-P-dzpYbz0Yq44_TYGyJamf1hufJ0fxGZb3Z0Q@mail.gmail.com>
Date: Thu, 18 Jul 2024 09:03:42 -0700
Message-ID: <xmqqsew6wuu9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4EDEE150-451F-11EF-9FAC-BAC1940A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> shejialuo <shejialuo@gmail.com> writes:
> ... 260+ lines of the original removed ...
>> +		 */
>
> What happens if a symbolic reference has trailing garbage ?
>
> ... 160+ lines of the original removed ...

It is a pain to have to look for only a single line with a new piece
of information in a 400+ line response, more than 99% of which are
quoted original.  Can you trim your quote a bit better?

Thanks.

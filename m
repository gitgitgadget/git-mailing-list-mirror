Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F26F4C81
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 01:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712365697; cv=none; b=IoC6u2TDw8hz24iwXxrKXj48RIuE7yLELhjAW5UzqeSLMYQ1bX5b1LxDgX6wTOcPHrp94d4V6SJwEr+sPY5FWS6sxX8moeJgxLIL4qm6p8uLiZBGQKMiNqZ4CW8ETNq/nucXWa6GSSseAmj0ToEDOk0xgONTMLqBkMolQhZAWhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712365697; c=relaxed/simple;
	bh=2OKb0UqMrNEKoc6P/G7T9cVqzG/IMt8uEYpsKsyBp48=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VIuOlUx/EJufE5Zr/j/3nggD9/Qx/xKWSssfNheO8r4+bLrajhxa+sHa+vBA9xFDh2LNfKDASK2qTGf6jpY+FreDMOCwaYD8UCDjD8BEYJj3vKZRL7ED/u7RymSrb5kXCoRt6uLzN+xJQGOEeTEp3Bm9cBt9/jg4G/EcD00sB64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GI6u+ZWZ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GI6u+ZWZ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CBD51F2E62;
	Fri,  5 Apr 2024 21:08:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2OKb0UqMrNEKoc6P/G7T9cVqzG/IMt8uEYpsKs
	yBp48=; b=GI6u+ZWZx/Gh0h+et/gqvjcrc/yqlejdWBXlCkWBez8NYAbpgu/bq9
	jjagzpf54SFfMqh/2Sv5KM9ZEUPDLXNX12fg2tujPgx8sJeYgQheBslm9cFB2WRK
	cbgc+qP0qdjhPus/PyezBkI9zD52/+qHxQ4wPBR2bHJY1/ivpdzB8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 361101F2E61;
	Fri,  5 Apr 2024 21:08:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 939C51F2E60;
	Fri,  5 Apr 2024 21:08:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Stefan Haller <lists@haller-berlin.de>
Subject: Re: [RFC] bisect: Introduce skip-when to automatically skip commits
In-Reply-To: <864b0f22-b07b-469b-8fc2-56940fd89a8b@schinagl.nl> (Olliver
	Schinagl's message of "Fri, 5 Apr 2024 08:50:38 +0200")
References: <20240330081026.362962-2-oliver@schinagl.nl>
	<864b0f22-b07b-469b-8fc2-56940fd89a8b@schinagl.nl>
Date: Fri, 05 Apr 2024 18:08:12 -0700
Message-ID: <xmqqcyr3s3gj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 24711E1A-F3B2-11EE-BB51-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Olliver Schinagl <oliver@schinagl.nl> writes:

> Hey all,
>
> I've also got my work on a branch in my repo, if that helps to look at
> things, https://gitlab.com/olliver/git/-/tree/skip_bisect
>
> Also included is a script to be used as an example. I opted to use
> `git show`, which is nice because it works both on commits, but also
> on notes.
>
> Anyway, any thoughts on the bellow before I send the full series?
>
> Olliver

I would not write get_skip_when() before studying the same file to
see if there already is a helper to read the whole file used in the
vicinity (like strbuf_read_file(), perhaps).

I do not have enough concentration to follow changes to
bisect_auto_next() is reasonable.  Especially I do not know why
"bisect-skip_when" wants to exist and what it is trying to do,
besides the fact that its name looks horrible ;-).


Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F87F9475
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 22:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718146362; cv=none; b=DdwCbIpMfsOmv7gkwGB7r9j8anVFX+yuF9ZoWf7orb4jkuW1cFEhgvyTa6oXGee0M9KvYfLRmqdAWZi3zxloFBrelgUoKPGjBgxU3Tm3iIxCoV2NUuP7oEwE24WivjkD+tQOFJea/aQgzaep1yTphTXhmDXE5h1jOSMMYcU3jGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718146362; c=relaxed/simple;
	bh=iwo/CSslRERT+RiPPEPSelH1UoRgtP5khX0xXMZgCdI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WzrXG31kTTyHdVze6PiYWroQtZs7nBmY1pboZKX15B9Ggcp7D8hVf6/DqlM6rhmVqsC2k7aGKk32XTtrWjtct7ODwPhg4XDtJvVPS+TFv1I/YoR+dG+ikTa6wj5j5tlzE5ROXg40mwVmMD9giFjMGu9YpKPmc56WJ4ZX6ojMVfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vLJw2jrw; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vLJw2jrw"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C46C52B148;
	Tue, 11 Jun 2024 18:52:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iwo/CSslRERT+RiPPEPSelH1UoRgtP5khX0xXM
	ZgCdI=; b=vLJw2jrwlMr2sWwjAYMszVlW6HN1yue+sDBRNj8+NbSzAb52fXsMLJ
	EfGjy8RNBpTdJH9JsZ89L/ak3PXGMH3r0oIAgG24NcuK6/sd+9nTgrxq5vLUanyX
	SXSTu0hCtEiOy+h1x+0G3a6YtxlcZeX76dQXg+choeB/+LayjXvWI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AC0582B147;
	Tue, 11 Jun 2024 18:52:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0ACAB2B146;
	Tue, 11 Jun 2024 18:52:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 05/16] index-info.c: identify empty input lines in
 read_index_info
In-Reply-To: <7e3bcc16e23c97d8a4efbb9e14b230ef9f44a1a7.1718130288.git.gitgitgadget@gmail.com>
	(Victoria Dye via GitGitGadget's message of "Tue, 11 Jun 2024 18:24:37
	+0000")
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<7e3bcc16e23c97d8a4efbb9e14b230ef9f44a1a7.1718130288.git.gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 15:52:37 -0700
Message-ID: <xmqq34pjt7m2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4D8B61EE-2845-11EF-A7F1-965B910A682E-77302942!pb-smtp2.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Update 'read_index_info()' to return INDEX_INFO_EMPTY_LINE (value 1), rather
> than the default error code (value -1) when the function encounters an empty
> line in stdin. This grants the caller the flexibility to handle such
> scenarios differently than a typical error. In the case of 'update-index',
> we'll still exit with a "malformed input line" error. However, when
> 'read_index_info()' is used to process the input to 'mktree' in a later
> patch, the empty line return value will signal a new tree in --batch mode.

Interesting.  We could even introduce "# commented input" but that
is a different story ;-).

I also wonder if we can flip it around and teach read_index_info()
to (1) silently accept and do a callback when it recognises the
input line is one of the supported formats, and (2) send any
unrecognised line, not just an empty one, with "unrecognised" status
code.  That way, the caller can handle more than single kind of
"special input line" more easily, perhaps?

Thanks.

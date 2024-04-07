Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AED1C0DFA
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 06:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712470104; cv=none; b=YMHvKWVyQ+fiJ1ynZm9mxRgayXTtZ0XQRCZ+Or/px2ORP2ZRVR32pNAvWpyQWslbuK3ATnvBTy8mrezTDhSNPVwpgRP2iSLo4zqWFJTvWDb97RuJzKUAGcSyZ50EoG+qKeeNyLZ8M+VGApyAPPEG6ilprK3rPl4T9rTWWtNqjVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712470104; c=relaxed/simple;
	bh=CnLvIi9NNgULUh1+jy1aWfiNP0Vh6fO/sWe8qUV2yz8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ugNmP+jsWWCiSwc+rnI72KssBS2QX1wfjKAOSKC3scOlFcA3BuB2+UM3w2yxJB3kmIat0bE/fqhRzhpyOjTpVvTdMGj7s/seSLXYbQYOA4CpRN0sssx6wtgE9NLQwgjsPFRP6PKX9QhcMVHgWxdcIThI/FnevC0LSQlXFUphc/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OnVV/Gpk; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OnVV/Gpk"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7362B1E68FF;
	Sun,  7 Apr 2024 02:08:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CnLvIi9NNgULUh1+jy1aWfiNP0Vh6fO/sWe8qU
	V2yz8=; b=OnVV/GpkfW+09T6Edi4tIxYmuXQbHRb+VYgCXxCLCty6IvZuOhmzXK
	kzKV6aP/FmBl808sgRWfnloEMh7y/Hlh8dmCAe1ZKIMSmauNCgQon6LGr+f260dF
	mo4qgWyuG7/7/Ca71mAzwiXt/YInU6TM0ZT9xWQfs8H7wjvdEYN9g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5BC5E1E68FC;
	Sun,  7 Apr 2024 02:08:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9E6961E68FB;
	Sun,  7 Apr 2024 02:08:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Max Coplan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  strager
 <strager.nds@gmail.com>,  me <mchcopl@gmail.com>
Subject: Re: [PATCH v2] log: add option to search for header or body
In-Reply-To: <pull.1710.v2.git.1712460247516.gitgitgadget@gmail.com> (Max
	Coplan via GitGitGadget's message of "Sun, 07 Apr 2024 03:24:07
	+0000")
References: <pull.1710.git.1712353687464.gitgitgadget@gmail.com>
	<pull.1710.v2.git.1712460247516.gitgitgadget@gmail.com>
Date: Sat, 06 Apr 2024 23:08:14 -0700
Message-ID: <xmqq4jcdhfht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 38E989BA-F4A5-11EE-BFDE-25B3960A682E-77302942!pb-smtp2.pobox.com

"Max Coplan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This change adds a new option to `git log` that allows users to search
> for commits that match either the author or the commit message. This is
> useful for finding commits that were either authored or co-authored by a
> specific person.

I have this feeling that the "solution" presented is not quite
addressing the use case in a more useful and direct way than it
could be.  When I designed how the --author/--committer restriction
and --grep in the body of the message interact, I made a concious
decision that "among those commits that were authored by person X,
find the ones that mention Y" is far more useful than "done by X, or
done by anybody that mention Y", especially when Y is just a text
search in the free form.  There was nothing that limits the mention
of Y to those specifically involved in the commit---the mention could
just have been part of text, like "earlier Max Coplan sent a patch,
but this commit is not related to it".

But these days, we have a more established "convention" that lists
people at the end in the form of "trailers", and that changes the
picture quite a lot from how the world order was back then.

In other words, if the true objective is to find commits that
involved person X, Y or Z (which is very common and would be a lot
more useful than finding those that involve all of them), shouldn't
we be limiting the --grep side even further so that a random mention
of person Y is excluded and hit is counted only when person Y is
mentioned on a trailer (while loosening the --author side so that it
is OR'ed instead of AND'ed)?

I am imagining a pair of new options to name people (all OR'ed) and
to name places the names of these people should appear (again, all
OR'ed).  I am not good at naming, so the option names in the example
is not more than illustration of an idea and not my recommendation,
but a command:

    git log --by="Max Coplan" --by="Junio C Hamano" \
	    --by-where=author,Signed-off-by,Co-authored-by

would find a commit that has one (or more) of the given names
in one (or more) of the places that are specified, where the places
can be either "author", "committer" to specify these headers in the
commit object, or random other string to specify trailer lines with
given keys.

Hmm?

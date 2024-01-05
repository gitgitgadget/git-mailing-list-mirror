Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523352E85B
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RFe2Fpmr"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C20D626513;
	Fri,  5 Jan 2024 11:26:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Dugg4ZdIQotvcfi64O3qy6S2U5BRdPqcZ+GZTN
	QpLZs=; b=RFe2Fpmrdwuhx1XMf7w0BaMAPwvBBnvn6WjYQliqMpzEBcpSANeSVm
	onv7r1Cx6a/++jkB04Q1fARwcsRpUx/InBZ7geSspih8RsVFjpO5AziPbmxkzZde
	KIxM3OG0YJ0Zw6i4Yb4L3FpIhNABvD9841SGj04coFryjikdg9FUo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BA55F26512;
	Fri,  5 Jan 2024 11:26:08 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6802D26510;
	Fri,  5 Jan 2024 11:26:05 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sean Allred <allred.sean@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: rebase invoking pre-commit
In-Reply-To: <m0sf3vi86g.fsf@epic96565.epic.com> (Sean Allred's message of
	"Thu, 21 Dec 2023 14:58:35 -0600")
References: <m0sf3vi86g.fsf@epic96565.epic.com>
Date: Fri, 05 Jan 2024 08:26:03 -0800
Message-ID: <xmqqttnroig4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1FCD1BF6-ABE7-11EE-B9FB-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Sean Allred <allred.sean@gmail.com> writes:

> Is there a current reason why pre-commit shouldn't be invoked during
> rebase, or is this just waiting for a reviewable patch?
>
> This was brought up before at [1] in 2015, but that thread so old at
> this point that it seemed prudent to double-check before investing time
> in a developing and testing a patch.
>
> [1]: https://lore.kernel.org/git/1m55i3m.1fum4zo1fpnhncM%25lists@haller-berlin.de/

If you are trying to make it less likely that your developers would
commit conflict markers by mistake, I think an effective way would
be to give "git rebase" an option (or a configuration variable) that
forbids it from making a new commit upon "git rebase --continue",
which AFAIK was added merely to help "lazy" folks to omit the
explicit "git commit" step in the following sequence:

    $ git rebase origin/master
    ... stops with conflicts
    $ edit
    ... now the conflicts are resolved (and hopefully you have
    ... tested the result)
    $ git commit
    $ git rebase --continue


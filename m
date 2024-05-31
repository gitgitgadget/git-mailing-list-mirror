Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC27B78C6B
	for <git@vger.kernel.org>; Fri, 31 May 2024 23:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717199197; cv=none; b=mOK6JSuuWAT1rjGHEV74IgWYJXmgKom03Pp6i3Egh2alYMz6vl+1Hj7Ph8r3MqgzyW5driBe70bKP/E9viHNhXjSannOvKVuebij76AmcHKdinAmYNnssHk5xigQD8Yc5r+wlzdg/k40QgeE+gV/b++136UDhxk8Q7z4w0WIgmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717199197; c=relaxed/simple;
	bh=Cl8MDAVaN+uMVvp4N5CV4yaWgI27QG0ZPL9QWu8R/3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g4L6hmBhnxq+Jxd0zumrkLdmD8BL6O2h4rtbGzdrDKhmWJCylXL14V+bbf5WSrkbZNSNh5TLu33FYOlm/PeFQgwK+nQXwNNZOos51tRllPJA7vbXNSNSo4lvrBOi00FpadMdA/tDyGH9pVZ3bAXSvL7y5SMDC2C9EUtcpjzUy9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FPTfRbFt; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FPTfRbFt"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 144FB3E5C4;
	Fri, 31 May 2024 19:46:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Cl8MDAVaN+uMVvp4N5CV4yaWgI27QG0ZPL9QWu
	8R/3U=; b=FPTfRbFtpMahry5bUZhPRv48z4tyj875yjstSqN1bV2S2NB7mWNpse
	YpLCh/y5PVGFxKDCS8tSuGAv7MXkPtWM5phbqAABu20ay/T44KUqUlu0vFiqnOow
	mh8TyH8bdxK0twapXhvjIbQvBE7B+kbaal0wyOlirDV3kJDskW3S4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B8723E5C3;
	Fri, 31 May 2024 19:46:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 24FDF3E5C2;
	Fri, 31 May 2024 19:46:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Ramsay
 Jones <ramsay@ramsayjones.plus.com>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 12/12] builtin/refs: new command to migrate ref
 storage formats
In-Reply-To: <d832414d1f8a7c8d9ec3ade13e11dd509c0ab641.1716877224.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 28 May 2024 08:32:07 +0200")
References: <cover.1716451672.git.ps@pks.im> <cover.1716877224.git.ps@pks.im>
	<d832414d1f8a7c8d9ec3ade13e11dd509c0ab641.1716877224.git.ps@pks.im>
Date: Fri, 31 May 2024 16:46:30 -0700
Message-ID: <xmqqjzj9czop.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0214ED70-1FA8-11EF-A305-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/git.c b/git.c
> index 637c61ca9c..683bb69194 100644
> --- a/git.c
> +++ b/git.c
> @@ -594,6 +594,7 @@ static struct cmd_struct commands[] = {
>  	{ "rebase", cmd_rebase, RUN_SETUP | NEED_WORK_TREE },
>  	{ "receive-pack", cmd_receive_pack },
>  	{ "reflog", cmd_reflog, RUN_SETUP },
> +	{ "refs", cmd_refs, RUN_SETUP },
>  	{ "remote", cmd_remote, RUN_SETUP },
>  	{ "remote-ext", cmd_remote_ext, NO_PARSEOPT },
>  	{ "remote-fd", cmd_remote_fd, NO_PARSEOPT },

One thing missing is an entry in command-list.

If you ran "make check-docs", you would have seen

    $ make check-docs
    no link: git-refs

The Documentation/MyFirstContribution.txt file does mention
command-list, but it is rather messy and unorganized.  I think the
checklist at the top of <builtin.h> would be the best source of
information at this moment.

Thanks.


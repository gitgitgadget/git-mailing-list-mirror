Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11E43D984
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723752390; cv=none; b=Ww4oFGX48x6WVgbW/fzXxkZy7JGOSivR9FaPOUSG5EkMGHVEzbK7lvYGafi9nqaXNjZYJfTkPxMsbeJ/QUed6tcq/g/eLCkXPWaqJ5Y2q2SmgipOKM27v1CJg/dzdJTJBwjqovRwuXvUPy6NO8Zi62Eaa+dLG0NXMNiUf2/5bsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723752390; c=relaxed/simple;
	bh=CvbbHefBMVrTQr6a0ddkRt87WVDYIwAO/sj3nNLnJ7o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sYDWGv+9WIavY5ePZzxUc8yaidR1bQexoxml0yl20EOOOxYehpcJJ9yjIakvpDNW1Upbi5ERkLEerBz4EV6Y+USFOm0qROB2XcC7vH7xPrPPTgXHSc6bchc/sHWHHT2B7QCak5rp6gyeDlqos9wGtIRLL3IZ2HhIF4yMo1UMMBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gj7WneDB; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gj7WneDB"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4766F2045A;
	Thu, 15 Aug 2024 16:06:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CvbbHefBMVrTQr6a0ddkRt87WVDYIwAO/sj3nN
	LnJ7o=; b=Gj7WneDBtQV3wDCoozvNfczhg37ZDQheGAOd9pxh5YXTTzOTzagXfK
	rvnUXAEHm+U2jF+GKZl3buS4ChKI92n9NIIEt3FZOZnlwJDZyyFaWIJ6PilM6s6P
	K0jdMjBuzXpU+MycC0wUeHE9/SDIPvXFn5+WFWtFcYx8vsJQq+b6g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3FD6320459;
	Thu, 15 Aug 2024 16:06:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A316D20458;
	Thu, 15 Aug 2024 16:06:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] send-pack: add new tracing regions for push
In-Reply-To: <d57f258026f941e7bc05de8dac359fc1e2e42bee.1723747832.git.steadmon@google.com>
	(Josh Steadmon's message of "Thu, 15 Aug 2024 11:51:13 -0700")
References: <cover.1723747832.git.steadmon@google.com>
	<d57f258026f941e7bc05de8dac359fc1e2e42bee.1723747832.git.steadmon@google.com>
Date: Thu, 15 Aug 2024 13:06:23 -0700
Message-ID: <xmqq8qwxsg8w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D933BE06-5B41-11EF-B63F-BF444491E1BC-77302942!pb-smtp20.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> From: Calvin Wan <calvinwan@google.com>
>
> At $DAYJOB we experienced some slow pushes and needed additional trace
> data to diagnose them.
>
> Add trace2 regions for various sections of send_pack().
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  send-pack.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/send-pack.c b/send-pack.c
> index fa2f5eec17..de8ba46ad5 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -512,8 +512,11 @@ int send_pack(struct send_pack_args *args,
>  	}
>  
>  	git_config_get_bool("push.negotiate", &push_negotiate);
> -	if (push_negotiate)
> +	if (push_negotiate) {
> +		trace2_region_enter("send_pack", "push_negotiate", the_repository);
>  		get_commons_through_negotiation(args->url, remote_refs, &commons);
> +		trace2_region_leave("send_pack", "push_negotiate", the_repository);
> +	}

> @@ -641,10 +644,12 @@ int send_pack(struct send_pack_args *args,
>  	/*
>  	 * Finally, tell the other end!
>  	 */
> -	if (!args->dry_run && push_cert_nonce)
> +	if (!args->dry_run && push_cert_nonce) {
> +		trace2_region_enter("send_pack", "push_cert", the_repository);
>  		cmds_sent = generate_push_cert(&req_buf, remote_refs, args,
>  					       cap_buf.buf, push_cert_nonce);
> -	else if (!args->dry_run)
> +		trace2_region_leave("send_pack", "push_cert", the_repository);
> +	} else if (!args->dry_run) {

Misleading "diff" but this is correct.

But makes me wonder if we really want to express these (and other
events we saw in [PATCH 1/2]) as regions we enter and leave.
Presumably we would generate a certificate instantly, compared to
all the other things happening in this process, like talking over
the network, waiting for the other end, and packing the payload, and
I suspect that the single bit the debuggers would want to learn from
the trace is "did we get asked to give a certificate?".
Sandwitching a rather expensive operation inside a pair of
enter/leave would give us a way to measure how long that operation
took in exchanges for one extra trace log entry, and "ah, we need to
first fetch the bundle and process it" we saw in [PATCH 1/2] is
something that is worth timing, but I am finding a bit hard to
believe it is worth doing for push cert generation.  It is
understandable if there weren't any suitable mechanism to simply log
"the control passed at this spot at this time" kind of event in the
trace2 subsystem, but I do not think it is the case.

> @@ -686,6 +692,7 @@ int send_pack(struct send_pack_args *args,
>  	strbuf_release(&cap_buf);
>  
>  	if (use_sideband && cmds_sent) {
> +		trace2_region_enter("send_pack", "sideband_demux", the_repository);
>  		memset(&demux, 0, sizeof(demux));
>  		demux.proc = sideband_demux;
>  		demux.data = fd;
> @@ -719,6 +726,8 @@ int send_pack(struct send_pack_args *args,
>  			if (use_sideband) {
>  				close(demux.out);
>  				finish_async(&demux);
> +				if (cmds_sent)
> +					trace2_region_leave("send_pack", "sideband_demux", the_repository);
>  			}
>  			fd[1] = -1;
>  			return -1;
> @@ -743,6 +752,7 @@ int send_pack(struct send_pack_args *args,
>  			error("error in sideband demultiplexer");
>  			ret = -1;
>  		}
> +		trace2_region_leave("send_pack", "sideband_demux", the_repository);
>  	}

This is also dubious.  When sideband is in effect, this records the
fact that we did ran pack-objects and allows as to measure how much
time it was spent.  But on a connection without sideband enabled, it
does not record anything.  But if we start the region a line sooner,
and finish the region a line later, we should be able to record the
same facts even for a connection without sideband enabled.  I also
find the name given to this region ultra-iffy.  Is it so important
that sideband_demux was used to communicate with the other end that
received the data our pack_objects() produced that the word
"sideband_demux" deserves to be in the name of the region, more than
the fact that this is the crux of sending pack data from us to them
(i.e. the main part of the "send-pack")?


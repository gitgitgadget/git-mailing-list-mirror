Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9751618635
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719866426; cv=none; b=C3TzP1df3vzm7rSIl48HWzyYH4i73NK3PbUP08akRsaLsnjSIglcoVm8hLReiAif5eqqoQPe4f27bkRgFouVInNWYaGqK9UHedYlt0mTBmRURdWlJQ/8pbv6xKsvT2W78YD4/fIxy/uXbQkkoHLqO4KvvoPlEed3bf+mjxYOVZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719866426; c=relaxed/simple;
	bh=W4qgT/7Z/DhhIfQUfecPamGyUXfLmslI9JzH0vfQKHY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ICm6Lw2J4gypt23rW5n1Urcu49+IBtTcJkhwGMPy8uBkL8vk6DAiTli1jNDpkq7xYrP6REhtDtd+kpj3p6vHRpYbcz1NREBKWRxS375CuLiacp/Pb9PkWxPWJ3ibgSbDh9+sGs00E+5aSne2Bg7bixq8c3LKCByqIUG+T5pq7I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hLigTSgt; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hLigTSgt"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 08AE81E798;
	Mon,  1 Jul 2024 16:40:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=W4qgT/7Z/DhhIfQUfecPamGyUXfLmslI9JzH0v
	fQKHY=; b=hLigTSgtNF+Yj6as+jiXwa03LsjuTxLeAkt0Y6Ny6/rDOqNRZuMtlb
	cxJyX/+ZQCAnSZXn2XSPkatoeZj2e+6etWV5H7z0FzYJxVcC9rJtDtsl3o0Vs4kH
	izzQDi31YfKnbRDaKYGNWB0c29X9HDilQ9nka05CchdWJjy4M55VU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F3A241E797;
	Mon,  1 Jul 2024 16:40:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D1D6D1E783;
	Mon,  1 Jul 2024 16:40:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  phillip.wood@dunelm.org.uk,  Florian Schmaus <flo@geekplace.eu>,
  git@vger.kernel.org
Subject: Re: [PATCH] setup: support GIT_IGNORE_INSECURE_OWNER environment
 variable
In-Reply-To: <20240701181916.GD3199@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 1 Jul 2024 14:19:16 -0400")
References: <20240626123358.420292-1-flo@geekplace.eu>
	<20240626123358.420292-2-flo@geekplace.eu>
	<9e5b0cc6-e28c-4c51-ab48-663c61c00ee3@gmail.com>
	<72e42e9f-5b85-4863-8506-c99d658d7596@gmail.com>
	<ae658244-877f-c5cf-8947-83b87b66d01f@gmx.de>
	<20240701181916.GD3199@coredump.intra.peff.net>
Date: Mon, 01 Jul 2024 13:40:18 -0700
Message-ID: <xmqqplrwvob1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 224767B2-37EA-11EF-8868-C38742FD603B-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> On Mon, Jul 01, 2024 at 06:34:10PM +0200, Johannes Schindelin wrote:
>
>> The `local_repo_env` array _specifically_ lists `GIT_CONFIG_PARAMETERS` in
>> https://github.com/git/git/blob/v2.45.2/environment.c#L129 to be removed
>> from the environment when spawning the `git upload-pack` process.
>> 
>> It was not originally listed, but added via
>> https://lore.kernel.org/git/20100824064114.GA20724@burratino/, where the
>> commit message does not really shed light into the question why this was
>> desirable, and there is no discussion in that mail thread about this
>> aspect of the patch, but at least the added test case reveals the
>> intention in some sort of way: The `-c` option allows to specify
>> `receive.denyDeletes`, and in the described scenario the idea was that it
>> would only apply to the client side of a local `receive-pack` but not the
>> "remote" one. As the example above illustrates, that patch might have
>> been overly focused on one specific, particular scenario.
>
> One reason we haven't loosened local_repo_env for the local transport is
> that it would make it inconsistent with all of the other transports.
> I.e., "git -c foo.bar=baz fetch" would still be ignored over ssh, https,
> and so on, because those transports don't pass environment variables.
>
> There's some more discussion from a similar case that came up a month
> ago:
>
>   https://lore.kernel.org/git/20240529102307.GF1098944@coredump.intra.peff.net/

Thanks.  I wonder if there is a way to add this kind of pieces of
information to old commits and discussion threads around it after
the fact, and if it helps us (like Dscho who wondered why we decided
if it is a good idea, and more importantly if we still think it is a
good idea and why).

    ... and then goes back to see the original discussion thread,
    with the "bright idea" that I could just follow up on 14-year
    old discussion thread.  Only to find that despite what Dscho
    said, the commit message does say why it is desirable ("to
    imitate remote transport well") already.

So, I guess we do not really need to do such a post-annotation in
this particular case, but I think after seeing somebody posting a
message like the one I am responding to and finding it helpful, it
would be helpful if somebody can post a message pointing at it as a
response to the old thread that wants a post-annotation.


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CB5263F2C
	for <git@vger.kernel.org>; Tue, 20 May 2025 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747738486; cv=none; b=fExlJBD47E5gQtfRFNt/DxdMlEGFFhOyacpelIIP3LPfc8WeCJheWP775WK3dGTHcLMbPIuA4dm4EK1AyBFVASCNiyCyv/WvEYQNc7ahQaGlT6OXxuraUPHBmr7g1mtpr3y4gE3j0EWnXAxRQHuOoS9aWumXv+GNV/pOWjYutIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747738486; c=relaxed/simple;
	bh=zdne3bwYUxF/+yAXQs9EMfyKT7Ds3PO7tYG0RcSMT4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5Ez7w+yngOCiYlxx/BKovn8oxnFyM1Mb5QDAId4B73tlCwLx1lxc1dbJNU9A8rI9HocNoyFvIxTKm6ORTcKO4CjJNJa5qYEhRwSYUcX6W5aWolGC0Xpz4hP7Z6SnWDGQg8Kt/hECO3if4+qrfqGQGDp7Lw21xO4KYWvAepZdLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhESTQyF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhESTQyF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74230C4CEE9;
	Tue, 20 May 2025 10:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747738485;
	bh=zdne3bwYUxF/+yAXQs9EMfyKT7Ds3PO7tYG0RcSMT4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GhESTQyF1BPVIjgYf95OGPg98NxHUItLY2ZQZTFtXy1181+j5oJ0gvP5OIjgB/QI5
	 UNhRu6zGaxjT2aVlcg1ArmBTxj/n5mUIrFltpeVuMa4v02INxTknNkv9r/pbiyJ5BP
	 kIhyyfKYssABCNpLiXcoImDr3C4hp6MeKrehiiScxFP79Yuv2GywfVNOU1OED6okLH
	 4JmbQzUkWJQvMnXf7T9fdkYphzRb5C0N0xxiVXkYZKmvb9JPKrpfHSKoihK2WYQ82a
	 gn2TnWrv66nHG1cTdr2imO1KizCgXEaEIUUAomKP2/DBvqmPZGfZeFyfHivsvtY1fD
	 qA63F6ubYTEDw==
Message-ID: <7b3b8efa-4cc1-4547-b66a-c469626eac46@kernel.org>
Date: Tue, 20 May 2025 12:54:41 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: Small patch to add support for MPTCP on Linux
Content-Language: en-GB, fr-BE
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: Muhammad Nuzaihan <zaihan@unrealasia.net>,
 "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
References: <JH8DWS.72DKHPTI873H3@unrealasia.net>
 <aCeg_wjLCf0Sz_7X@tapette.crustytoothpaste.net>
 <BP9EWS.WTYEEEQZEN2U1@unrealasia.net>
 <aChhxRx7sMD47N_s@tapette.crustytoothpaste.net>
 <4YPEWS.J5JRNETKLXF1@unrealasia.net>
 <a76dda61-f60c-4221-83db-5e165a2478b1@gmail.com> <xmqqo6vokvpv.fsf@gitster.g>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <xmqqo6vokvpv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Junio, Phillip, Muhammad, Brian,

I'm part of the team maintaining MPTCP in the Linux kernel. Do not
hesitate to reach me if you have any questions about MPTCP (I don't know
if there were still opened questions in this email thread).

@Muhammad: thank you for having initiated this email thread.

On 20/05/2025 01:49, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> As brian has already said I think it would be better to have a
>> Makefile knob to control this which defaults to being on for
>> linux. Take a look at the various USE_xxx definitions in the Makefile
>> and config.mak.uname for setting default compile flags for different
>> operating systems.
>>
>>> Also another check if a socket is supported by looking for a return
>>> value of
>>> "EAI_SOCKTYPE" (not EINVAL) and fallback to regular TCP if that is
>>> returned.
>>> EAI_SOCKTYPE should work across different UNIX systems as this is a
>>> posix error code.
>>
>> That error is not mentioned in the documentation for MCTCP on Linux
>> [1]. Please make sure your code checks for the errno values described
>> in the documentation.
> 
> Also according to RFC 6897, "MPTCP is designed to be totally
> backward compatible to applications".  I understand that this is
> quite unlike introducing IPv6 into IPv4-only world.  You can tell
> the system that supports MPTCP to use it in specific ways by
> updating your application, but your system's local policy may
> allow MPTCP to automatically set up multiple subflows even your
> application is not quite aware of MPTCP.
> 
> So, ... I somehow would be mildly surprised if Git were a kind of
> application that needs to take advantage of "several additional
> degrees of freedom that applications may wish to exploit" by using
> API that is "a simple extension of TCP's interface for MPTCP-aware
> applications".  Requiring a simple application like ours to tweak
> and rebuild in today's world does not sound like a winning strategy
> to promote a technology that "is designed to be totally backward
> compatible to applications", at least to me.

@Junio: Good point! This RFC 6897 was a bit optimistic I think. To get
MPTCP in the upstream Linux kernel, we had to make it opt-in, and the
modifications we suggested couldn't impact "plain" TCP performances (or
any other sockets). The previous implementation we were maintaining in a
fork was following RFC 6897 guidelines, and there was no need to modify
the apps at all, but that was not realistic either.

I then agree, this situation is different from the IPv6 vs IPv4 one, and
MPTCP in the Linux kernel is using the same socket API as with TCP. It
then means that to support MPTCP, all you need to do is to create a
socket with a specific argument: IPPROTO_MPTCP instead of IPPROTO_TCP
for the protocol, that's it [1], the rest doesn't need to be modified.

  socket(AF_INET(6), SOCK_STREAM, IPPROTO_MPTCP);

Knowing that, it is then possible to change the behaviour of some apps
by forcing them to create an MPTCP socket instead of a TCP one, e.g.
using LD_PRELOAD, and that's what "mptcpize" does, e.g.

  mptcpize run git clone git://git.kernel.org/(...)

There are other techniques (eBPF, SystemTap, etc.) [2], but it sounds
better to have a "native" support by modifying apps to change how
socket() is called, this modification should be minimal -- see
Muhammad's last WIP patch [4] -- and MPTCP could be used only when
needed. That's what many apps are already doing [3]. (Also some
sysadmins don't want to use other workarounds.)


@Brian, Phillip, Muhammad, I think it is better not to set IPPROTO_MPTCP
in arguments passed to getaddrinfo(), but modify what is given to the
socket() syscall. Something closed to what Muhammad suggested in his
last WIP patch [4]. I guess Muhammad will do a proper submission with
good commit messages when the new version will be ready and tested.


[1] https://www.mptcp.dev/implementation.html
[2] https://www.mptcp.dev/setup.html#force-applications-to-use-mptcp
[3] https://www.mptcp.dev/apps.html
[4] https://lore.kernel.org/git/ZXLJWS.WPQLCXFNN8TH@unrealasia.net/

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6978522DA0D
	for <git@vger.kernel.org>; Tue, 20 May 2025 20:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747773301; cv=none; b=t3x54/vcRzytAypwRf6a5qBScbWANd+JGG71n7I+hfOAVqfIxb4xaAYDvusteI/K0lY4axZEC+T1c4GP1+vdCQV56pSKw0lx0VZjVDUry1JL7TWfrT5KybckOiQm4TBZts3x5nMXpX4qGpg5dvYQa0/4ddFeTYp5m4BauCqyh1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747773301; c=relaxed/simple;
	bh=xkSOx89nFJLk+M7JB8nLguVlkZTJ6Fhu2oVV14r6Z80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+R66N6fBK3cYDyq++s3gfJM9fs3+RHLWlTUDEI+JVXgfGsqDAjw+83/mloF5QpNlsf7vsw/d46AzpnnnYfHrXZLnP+9ofraKp2a0zBRYBHdLpkw4Z1BNFWZl0FPHKBRARByYMmK2wGsqhSyr+L+WA2IPk4nu3hUkjvs4QsPrHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1HQ4sM1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1HQ4sM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9B6C4CEE9;
	Tue, 20 May 2025 20:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747773301;
	bh=xkSOx89nFJLk+M7JB8nLguVlkZTJ6Fhu2oVV14r6Z80=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X1HQ4sM1X+7G47C2sRbxuZo+/JlD5nwNLCiMySKCJdCApel6mkux/9739mYWVnYHy
	 lagoLKVFaysF2Z6P6I0SUpQVH3qO5Gq4JFVbYQcgGf0nZ6UjeEToPFS6AdCZOHhEZA
	 lIzdHKUyuQuJxgaRrNjv2Lq0p6eHqoBx5mGdN/v7jQKK2u5WDJEggqFZkwqMBMu08J
	 uIiDw6fiip0YoEK3GF85Rb3D4Y6hsgRknnqBz6PNWm3QO0VES7TvZ7F2KQ/CttZrgY
	 VHZsMkRoyqVyv+gUxlQk5ubvEMHXeTK3xb+WdD0O/eyFVgsl9aBuaNHZQIKQlgJdae
	 ixhj7AFPgDoMA==
Message-ID: <202e1a66-72af-48f6-9b3b-7d7473db699e@kernel.org>
Date: Tue, 20 May 2025 22:34:56 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: Small patch to add support for MPTCP on Linux
Content-Language: en-GB, fr-BE
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
 Muhammad Nuzaihan <zaihan@unrealasia.net>,
 "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
References: <JH8DWS.72DKHPTI873H3@unrealasia.net>
 <aCeg_wjLCf0Sz_7X@tapette.crustytoothpaste.net>
 <BP9EWS.WTYEEEQZEN2U1@unrealasia.net>
 <aChhxRx7sMD47N_s@tapette.crustytoothpaste.net>
 <4YPEWS.J5JRNETKLXF1@unrealasia.net>
 <a76dda61-f60c-4221-83db-5e165a2478b1@gmail.com> <xmqqo6vokvpv.fsf@gitster.g>
 <7b3b8efa-4cc1-4547-b66a-c469626eac46@kernel.org>
 <xmqqfrgzjnhg.fsf@gitster.g>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <xmqqfrgzjnhg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Junio,

On 20/05/2025 17:44, Junio C Hamano wrote:
> Matthieu Baerts <matttbe@kernel.org> writes:
> 
>> @Junio: Good point! This RFC 6897 was a bit optimistic I think. To get
>> MPTCP in the upstream Linux kernel, we had to make it opt-in, and the
>> modifications we suggested couldn't impact "plain" TCP performances (or
>> any other sockets).
> 
> "Couldn't impact" meaning that unconditionally passing IPPROTO_MPTCP,
> even when MPTCP is not available, would not hurt at all and falls
> back on using regular TCP?

Sorry, I was not clear. I meant "introducing MPTCP in the Linux kernel
couldn't impact other protocols in terms of memory allocated per socket
buffer or performances by adding extra checks a bit everywhere for example".

The socket API can be used the same way as with TCP: read, write,
set/get socket options, etc. Plus the MPTCP protocol is made to be
resilient: if one host doesn't support MPTCP, the connection continues
in "plain" TCP. In the worst cases, when dealing with middleboxes
altering packets in a way that it messes up MPTCP options, there will be
a fallback to "plain" TCP and the connections can continue using only
one path. It looks like the protocol is quite strong, because Apple has
been using MPTCP around the world since 2013, apparently.

In the Linux kernel, when the client didn't request to use MPTCP, a
listening socket supporting MPTCP on the server side will return a
"plain" TCP socket to the userspace during the accept() call. That's why
we recommend enabling MPTCP on the server side by default if supported:
the impact is minimal, and MPTCP is only used when requested by the
clients -- which are usually the ones benefiting more from MPTCP
features. That's in fact the current behaviour for apps written in Go:
MPTCP is now enabled by default on the server side, and it is easy to
enable it on the client side when needed.

> I am assuming that that is not what you meant.  Otherwise, you would
> not be calling RFC 6897 optimistic, and either the kernel or libc
> layer would be tweaking the socket() call "to make the right thing
> happen transparently" for everybody, and there wouldn't be any need
> for this conversation to happen here.

Sorry, yes, that was my understanding of this RFC 6897. Indeed, they
seem to suggest the kernel or the libc would decide when to use MPTCP,
and the apps would not need to care about that at all. That might work
for generic cases, but I guess the users and apps prefer to keep the
control of that. (This RFC apparently also suggest apps to take control
when needed.) Anyway, there are ways to force apps using MPTCP, but a
dedicated option handled by the apps seem cleaner and clearer.

> So I am assuming that at least for now, the choice to use or not use
> MPTCP needs to be made somehow.  Leaving it at the application
> level, by the way, does not sound like a winning strategy, but
> anyway, I think the reason why the platform folks do not take
> responsibility and make it up to the application is because MPTCP
> may not always be better than TCP; it may boost throughput by
> utilizing multiple links but may hurt latency, for example?

Yes indeed, you are right. To be able to use multiple paths, it is
required to add a few bytes in the TCP headers, in the options. If there
is only one path between two machines located next to each others, or
for very short connections, MPTCP and its few extra bytes are not worth
it. Or to be more precise, there is no need for a client to initiate the
connection with MPTCP in these cases. The servers can continue to create
MPTCP listening sockets, and let the clients decide.

> What are the criteria the end-user may want to use to decide its
> use, then?  If interacting with a specific remote repository over
> MCTCP proves better, would the user safely be able to say "I'll
> always use MCTCP when talking to that repository"?  Would it be per
> host (i.e. if one repository on a host is better with MCTCP, would
> all other repositories on the same host better off using MCTCP)?

On the client side, I see this option similar to using Git v2 or
push.gpgsign: if supported on the server side, I want to use it when my
client supports it. Enabling it would be beneficial when switching from
one network to another, or if I have access to multiple networks. Yet,
to save a few bytes (12B per connection request), I might not want to
try using MPTCP with servers that don't support it. Maybe some people
will only want to use it with big repository, or all the ones handled by
the same server.

So yes, I think it would be good to start with a global option, and one
per repository. Because it would be a new feature, people might want to
start using MPTCP only with servers supporting it.

> What I am getting at is that the choice between IPPROTO_TCP and
> _MPTCP may not be "If Git is compiled with MPTCP support, always use
> MPTCP", so we need to see where the configuration knob for end-users
> should be.

Even if MPTCP is used by default, I guess it would always be safer to
have an option to disable it, just in case. In the team, we are all
human, I don't exclude bugs :) (This sentence doesn't make sense any
more: if we were robots/AI, that would make even more sense to have an
option to disable it :-D )

BTW, again thank you all for maintaining and developing Git, this
crucial piece of software :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


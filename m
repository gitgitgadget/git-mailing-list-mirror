Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204972C11E9
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 20:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771360289; cv=none; b=Be9yek9+8UE/i+5N+xdShoqiSQU6QEk9cxBt4zVJeWVbjEGAx5cJ62janBoFd+6+T2luioapervpvcJ7gpskm+JXdBdVacmsas2BgF9gAEBZgdzGNkoCAEeFMQvXOP6SN1HL92+n15Z6ccrlKIp6P75JLzpn4Fwzl5O38sNU2u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771360289; c=relaxed/simple;
	bh=9/SJ+GFt6Lxdi2ccI7GLXw2C4l2oN11WUEA3J2wqaew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X601JI33IP5nNiLiDwUGmouJKHPXUr/DCoou5pezT6X5QOEaoAXWJskYmPpmiK3UYKDBMCrMqGCFi0ICg1rGhycV57zQAXthoPonEBQYnRZCETtAgIIN1nxGvyTnVGwecpqBioj/OneX/gErLf4YafowTIoB1fXiOcTgfyIWI/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.eu; spf=pass smtp.mailfrom=posteo.eu; dkim=pass (2048-bit key) header.d=posteo.eu header.i=@posteo.eu header.b=QwliiOFB; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.eu header.i=@posteo.eu header.b="QwliiOFB"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 42A2B240029
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 21:31:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu; s=2017;
	t=1771360285; bh=1mUMHjhGDFiD+6zBP7mFLPujNJeVFZGYbtmNod3Kpg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
	 Content-Transfer-Encoding:From;
	b=QwliiOFBXB7GeA+jNQqmN1ILw3WKaTEyR2FL2mk7SUbjkK/VBTbAroaV5nwrBuO66
	 J8BhQ8g9YNDgkfUw3NTv+WO1/x5UKgZKml6C0/uU9MoxIinFHWSbVS0OxVfwVWoJjV
	 E5SPK6XdncbTtvA1cknq42BXeNJtHo4OlIXy4k0xCcvLFALrVhVyGeIm/bHMj341DR
	 NLcPpL0nZIPb2wbKWSN+6mqrYcTGZIM2k5a5ukxtlcF6h269VywcmraYORzKJDZZEN
	 VH+xj2RCcXKAm9hsbvIJMumnhULc9jiXOAEJVeWoiqJX3QqVYgbMW2em2aw1W3+Hqm
	 3VR/brCQ9CGMA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fFrrr5c3Cz6twZ;
	Tue, 17 Feb 2026 21:31:24 +0100 (CET)
Message-ID: <19c5dd32-6752-43fa-a664-5e6d29d9e681@posteo.eu>
Date: Tue, 17 Feb 2026 20:31:25 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Push Certificates: Privacy Concerns Regarding the "pushee" Header
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <d180884c-8108-4c8a-9cc7-5314a4f5a45a@posteo.eu>
 <xmqqldgrb1ha.fsf@gitster.g>
From: Lorenz Leutgeb <lorenz.leutgeb@posteo.eu>
Content-Language: en-US
In-Reply-To: <xmqqldgrb1ha.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

You point out that a push certificate without a pushee is questionable 
(to say the least) and opens the door to replay attacks.  I understand 
and agree.  Thank you.

So let me cross out the option `--no-signed-pushee` and empty values for 
`--signed-pushee=<url>` from my previous proposal, and let us continue 
our discussion under the assumption that the pushee header is always set 
to a URL(-like) string.

On 2026-02-17 11:42-0800, Junio C Hamano wrote:
 > What implication does it have to allow the pusher to sign a
 > certificate that points at a "pushee" that is different from the
 > repository the signer directly pushed into?  [...]  I offhand do not
 > see a huge security problem in that arrangement.  Anybody can check
 > the certificate and the resulting history and verify the chain of
 > hashes to the same degree as you would trust SHA-1 (or SHA-256) for
 > the object integrity and GPG (or whatever you used to sign the push
 > certificate) for the certificate integrity.

Exactly.  And this is very much the situation I am in.  The middleman is 
actually the daemon that comes bundled with the application, which wants 
share the push certificate over the network.  The pusher only has to 
trust the middleman insofar as the middleman will actually forward the 
push to its best ability.  In my application, distribution of the 
certificates and syncing of objects is the main purpose of the daemon. 
But I digress...

Let me zoom in a bit more why I want to override the pushee: The way the 
application works is by means of a remote helper. That is, the user 
executes `git push example://foo ccae4e0:main`.  This is makes sense in 
the context of the application, as the user wants to carry out a logical 
"push to the network", and "foo" is an identifier that also has a 
well-defined meaning within the context of the application.  As you 
know, this will lead to execution of `git-remote-example`.  The remote 
helper is where the hand-off between "plain Git" and the application 
happens.  The remote helper knows that the push will be split in two 
parts.  It knows that it must carry out the first part immediately, 
which is a push to `home/lorenz.example/storage/foo`.  The repository at 
that path is the local view of the repository `example://foo` on the 
users filesystem.  This local repository then gets updated in the 
background by the daemon, and the daemon also notifies other peers on 
the network about the push.  This is the part where it must act as the 
middleman.

Now, in the context of the application, the global identifier of the 
repository across the network, and thus the pushee that I would like to 
see, is `example://foo`.  The path `home/lorenz.example/storage/foo` is 
merely a local name for it, like a cached copy if you will.

Perhaps this even raises a question on how remote helpers interact with 
signed pushes:  If Git allows to register URLs via remote helpers, how 
should remote helpers that do not have the "connect" capability control 
the pushee URL, which they likely are concerned with?

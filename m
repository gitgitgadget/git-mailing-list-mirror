Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7103469D
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 00:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723594221; cv=none; b=H57GKQCOpfU3laPUZfOdF/EvShjSNB7X24JBXo7JmAtZGcpRxA89hkHPshQ5rgfEyTikEYhHgkkm0aY3t1y7MOxznrFyyC84xkKNh6pWl59K30GyT2p7MWpJb/CA37lxMQNWsl9ddQsnIJmltW9PZpJPgrslM5SNy+0xy6xUUhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723594221; c=relaxed/simple;
	bh=yXM+186JsUuLPdWdrOmehc+lAQm1cx8hP4VEAG+z9gA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUq9jzs0odryaeyQiE5GmSMnLbRiFMYOrtu9Diq7T4AhKsa/jHem9pXO6XQ0USTCXAU3rHRGaUK48ren6vEaEUnqx35Y3feV5NIlW8OEa+mnl34h0LyyKlsi0svB870QXDdAva/pY3Fw95mi5EANd9jP6dj91dPXsIY62hYAxHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NMqtVyzY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NMqtVyzY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034EAC32782;
	Wed, 14 Aug 2024 00:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723594221;
	bh=yXM+186JsUuLPdWdrOmehc+lAQm1cx8hP4VEAG+z9gA=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=NMqtVyzYt5QM1SN+Jp7iNWVlb/Yh8T1zfMbH6XDBEjkhUwCrEUuf9j9LqdicMzt+z
	 4kVun2ygoVWbRjI8c4P0CgXwwmME3338ZZqf0ycV7/TOZ1FM0NHhFfxCESJdgx+xk4
	 8DJJBp73XXsi+mJqZJmKaD0mK20opon7fAWDWNa0=
Date: Tue, 13 Aug 2024 20:10:17 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Mike Castle <dalgoda@gmail.com>, git <git@vger.kernel.org>
Subject: Re: Heads up: GMail regularly marking list messages as spam
Message-ID: <20240813-rampant-quokka-from-betelgeuse-4bc3c9@lemur>
References: <CA+t9iMyT8fAR_fvQXOer=ivLnNKDnH8g_M8iQiq7gdrnfG7aCg@mail.gmail.com>
 <Zrp7yNKMxhPk6Tyt@tapette.crustytoothpaste.net>
 <20240813-sociable-fresh-whippet-3ee335@meerkat>
 <Zrvbpt3Fkl8yjesP@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zrvbpt3Fkl8yjesP@tapette.crustytoothpaste.net>

On Tue, Aug 13, 2024 at 10:18:14PM GMT, brian m. carlson wrote:
> The article you linked still recommends DKIM.  In addition, the article
> I linked doesn't appear to limit itself to non-mailing lists in any way.
> It says, "email senders", and a mailing list sends emails.  In fact, it
> explicitly mentions "[i]f you manage a forwarding service, including
> mailing lists or inbound gateways," so it still appears to cover both
> cases and apply to all senders, with only some additional requirements
> applying to forwarding services.
> 
> In general, adding DKIM (whether or not ARC is supported) _will_
> dramatically improve the deliverability of email in general, so it's a
> win overall. 

Sorry, but this is not factually correct. Adding a DKIM signature to a message
where the From: lists a different domain has no impact on anything at all when
it comes to the chances of it being marked as Spam at google.

E.g. your message has:

    From: "brian m. carlson" <sandals@crustytoothpaste.net>

And it already has a DKIM signature for your domain. Adding another DKIM
signature for vger.kernel.org will serve no purpose, because there is no
alignment between "vger.kernel.org" and the domain in your From: address.

In fact, we do add a cryptographic signature, but in the ARC record:
https://lore.kernel.org/git/Zrvbpt3Fkl8yjesP@tapette.crustytoothpaste.net/raw

It's from the overlord subspace.kernel.org domain, but it doesn't need to
align with "vger.kernel.org".

> Adding one-click unsubscribe would also probably keep some
> of those unsubscribe messages from hitting the list since people could
> automatically use the functionality of their mail client to unsubscribe.

This is not possible without rewriting the From: header, which will break all
patches. We cannot modify the message content or any of the main headers that
are DKIM-signed (this bit is mentioned in the forwarder guidelines I linked
to).

> And from a personal point of view, it is definitely useful for me, as
> someone who manages their own mail server, to heavily negatively score
> all email without DKIM, but I can't do that because vger doesn't add
> any.  That's the only thing preventing me from doing that.

There is a small subset of active git mailing list posters who send mail that
is not DKIM-signed, for example Jeff King:

https://lore.kernel.org/git/20240813124550.GC968816@coredump.intra.peff.net/raw

However, signing their messages with a DKIM signature from vger.kernel.org
will serve no purpose, unless we also rewrite the From: to match the
vger.kernel.org domain. The From: field would need to be something like:

    From: Jeff King via Git Mailing List <foo+somemagic+peff.peff.net@vger.kernel.org>

This is called "From-munging" and is not acceptable on any mailing list that
sends and receives patches, because this changes the Author of the patch.

Thing is, this has nothing to do with vger, because if Jeff emails you
directly and you set a high negative score for messages without a DKIM
signature, you won't get his mail either. The fact that it traversed or didn't
traverse vger.kernel.org has no impact on that.

-K

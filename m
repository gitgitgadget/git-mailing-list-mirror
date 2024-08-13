Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFF419EED8
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561575; cv=none; b=TID7kQyXTYUD9rI8uaITMh+bnj6Wnadju8TH2Gs20cBBMpK0hd1AjS+QVN6NbON0VB4/6OtF+VlLKl7swJ57mOQSpa7iUxKCCRBc8ZRtFPw/CqC5BNMTZam19ueGY94VyC+G5WEKplWDV8gLoyNgbDAAURID7ppGGXQpLQPCJq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561575; c=relaxed/simple;
	bh=G1jX/wn9+FxBMJX3eZ43qN1TNvvgaOQc+hQlSSD3X3c=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6f0s5fMxUMpPIuHs7IPDadlpzYvmjlO6Feaz1HzvI5D5ail/HQhdIT7sY1adOUmny3SHLdT3FpuvP9g3SuggX4ViRTsFcQooBSdczYpZ4RQgLrEs9asqso2QKE8L6tz1At1QN/800YhBfeeGGLTyuxL67JT4CZj653THuCDX/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uVKfiLMp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uVKfiLMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602FEC4AF09;
	Tue, 13 Aug 2024 15:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723561574;
	bh=G1jX/wn9+FxBMJX3eZ43qN1TNvvgaOQc+hQlSSD3X3c=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=uVKfiLMpoJRRjrVeSZTaihRfgH6pCLrcKon4c+aAeBCdNWZcJYmE2+YEgT69xJ2hh
	 XC/MwJxNhYMFbeLbBpcYkUTLwMqMr00e7s3vQgNUOjVtfj4sVaVxcBA/Ap6SMe3yL2
	 kZ2ToxIKAPwW4A6bmD+XCAWFM/UL60E6dW0d2d6o=
Date: Tue, 13 Aug 2024 11:06:13 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Mike Castle <dalgoda@gmail.com>, git <git@vger.kernel.org>
Subject: Re: Heads up: GMail regularly marking list messages as spam
Message-ID: <20240813-sociable-fresh-whippet-3ee335@meerkat>
References: <CA+t9iMyT8fAR_fvQXOer=ivLnNKDnH8g_M8iQiq7gdrnfG7aCg@mail.gmail.com>
 <Zrp7yNKMxhPk6Tyt@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zrp7yNKMxhPk6Tyt@tapette.crustytoothpaste.net>

On Mon, Aug 12, 2024 at 09:16:56PM GMT, brian m. carlson wrote:
> Gmail and Yahoo have both set up new requirements for senders[0].  This
> requires that all senders have SPF and DKIM, and senders sending more
> than 5000 messages per day have DMARC set up.  One-click unsubscribe in
> RFC 8058 is also obligatory, as is TLS for sending messages.  These
> changes came into effect in February 2024.
> 
> I don't believe vger uses DKIM (at least, it doesn't appear to add DKIM
> headers) and doesn't support RFC 8058 one-click unsubscribe.  Perhaps
> adding support for those, as well as any other relevant requirements,
> would improve things.

These guidelines are only applicable if vger was the origin of the messages,
not a forwarder. For forwarders, it is only required to add ARC signatures:

https://support.google.com/mail/answer/175365?hl=en

The only thing we aren't doing is we're not adding X-Forwarded-To headers,
because mlmmj doesn't yet support it (should be in 1.5).

-K

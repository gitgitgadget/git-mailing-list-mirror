Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE571DEFD3
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 21:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733173920; cv=none; b=t1618PxB4k1RiIPpqWA6FuWMlZldW/eV3bswstxtfeEWiQOlnuzMQ4XWX0U6yYs2EKk5Duj+NITdZdgOknvwvu5Y8XB71908tmhfqOxIfO5QQ1hqLP86xnx6/FGFPKeWmbi0DkXrx+IZfgnu/YfPioWvjs2cSxPPduCJiPCftTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733173920; c=relaxed/simple;
	bh=fc7ZriVu55a9HCux7VF5ZRi/B9iBHDlf1p6AqXBKhDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmL6CRKIA+wB4JuWXghEwBH1N6OAwrCM4WyxzU7TM7KSutfC9FwqUfp7owoqUJyamq8YiXPjC3dsyiPZ5y0WJX70x4dh23BMhUNf/xK1RZEX8k9xw3BJ1OMg+jn5R1IuCQyapl8yMdWs3P+qaNhsXwUiKs4ukfpYrq1ayWbBzUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cnXnwQav; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cnXnwQav"
Received: (qmail 16800 invoked by uid 109); 2 Dec 2024 21:11:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=fc7ZriVu55a9HCux7VF5ZRi/B9iBHDlf1p6AqXBKhDU=; b=cnXnwQavcrtK9vF7fziYJYXFVs2Xmeh39GeO5NMUs7xINN7s+iz5GzWREXvPyKT4y5vuL0ei+3u5hOCGOLpxyFD1u25LEfWQswH/KKdcIiqF6shBiCol3l6uvOt6uoIHyetBIKruuLfYmnzGFQ9Q9ddDX0tlGFwfXzv30UQucpMCE1zdaOKmflaCgpo2NtqDjHXu/gedGeb06oGTv6FwZ3rwILKwth5uRyKVzNEZRGnhLbouDME92GtfCj8nKyQKucUd//IibMmClQ6ngnbAuJUG+vF6V/K9dHOnome5yYuyE43kzg4Rc2jPkIDoNmzvA2oIYZaxsKM13fXK9RHOTQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 02 Dec 2024 21:11:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26503 invoked by uid 111); 2 Dec 2024 21:11:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Dec 2024 16:11:57 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 2 Dec 2024 16:11:56 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UsOpbWk=?= Debette <r.debette@instadeep.com>
Cc: git@vger.kernel.org
Subject: Re: Support of NETRC environment variable
Message-ID: <20241202211156.GG776185@coredump.intra.peff.net>
References: <CAGinwDzTDexiXpwR0BGTTgX_9BcQ9N2RSea2UBTnyurCM0QRfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGinwDzTDexiXpwR0BGTTgX_9BcQ9N2RSea2UBTnyurCM0QRfg@mail.gmail.com>

On Mon, Dec 02, 2024 at 06:36:34PM +0100, Rémi Debette wrote:

> This email follows discussions on this issue in the uv project:
> https://github.com/astral-sh/uv/issues/9576
> 
> The uv project supports setting an environment variable called NETRC
> that allows setting a path to a .netrc file if this one is not in the
> expected home path ~/.netrc
> Their documentation describes it here:
> https://docs.astral.sh/uv/configuration/environment/#netrc
> 
> git supports authenticating through the .netrc home file, but it seems
> it does not recognize this NETRC environment variable.
> Would there be an alternative way to set an alternate path?

No, there isn't. Git does not really support netrc itself[1]. But we do
rely on libcurl for making http requests, and it handles it internally.
The only explicit thing Git does is turn on the libcurl option that
allows the use of netrc.

It looks like curl also has a CURLOPT_NETRC_FILE option. So I think
there _could_ be a Git patch that takes the value from $NETRC and passes
it there. But if this is a standard-ish interface, I wonder if it would
make more sense to lobby curl folks to support $NETRC automatically.

-Peff

[1] There's also a netrc credential helper in contrib/, but that may
    defeat the purpose if you're looking for something people can just
    use out of the box. They'd need to build and install the helper, and
    then configure it.

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C0D28F3
	for <git@vger.kernel.org>; Thu, 22 May 2025 06:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747893990; cv=none; b=FZssyY8x7bI6oZKrcp14zeKY0c+dxXIhZbc86Xc7uapY9SYl4AEyUiWwqqPFYUWvfcbEdV9h3HJ2r7tk7xxok8K5l7i/5lxvXClMOngvvyoAQS2sgPNsVJKmqP9/9W3B/+HwC5WNBw8hyhbsIzWnkTGbnUgF0dyLmlFAghwvlsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747893990; c=relaxed/simple;
	bh=J4sg6IYbIf7NGuzw1J6ZCO60FAHvX8ig83T9n9w/uso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ON4+Zz4iltkwNMYPgmDrwkofVKDw8qRn9uQwl8j43KMyXPTI0ohB1MVjKD1J2w8e4SDhAGi+HugNTa5NQS8hOVjTIF78ag7aIO2Y1KTPgkrqOetBa/Kmp0giCmGAYl+WeoaMftQpQLNMGeWzC7/4zngi3SEQoXe9SDyub5JcTws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JzQrmHh8; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JzQrmHh8"
Received: (qmail 31448 invoked by uid 109); 22 May 2025 06:06:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=J4sg6IYbIf7NGuzw1J6ZCO60FAHvX8ig83T9n9w/uso=; b=JzQrmHh8KSfrZvtiKwR8fv7zbl0ETK646ofrLp3odZyPcLag+V4AkZiHPf6vCyWs/JFIR0uaR7zNH67rWWWyg3MkMIeEa41u2UevSwcYt0IxBVHpcpj4x/OuTDePzrDq5c23gQHFEqajgCTnM8+b9b7KPk0s80+7Xpr9o1BiaDoyCsw++NjhV59sCqRtIMUkqT/Ih0lIHaObpPmgno2cl+kR/IsFqjn/J5vff+G42Yp/Yy5949tioxVpBqGAtsoK7YoewcAVobEQU6ZkFDB38vp6jTXa2CyWw72wsMajmfBpKPDG8aB7Sf0XbE8Gx957PaQOy79C0K8eYV23zQ1gwQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 May 2025 06:06:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12675 invoked by uid 111); 22 May 2025 06:06:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 May 2025 02:06:31 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 22 May 2025 02:06:26 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH] t: remove unexpected SANITIZE_LEAK variables
Message-ID: <20250522060626.GB1137854@coredump.intra.peff.net>
References: <20250520-kn-remove-unexpected-exported-v1-1-bb60cec57e84@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250520-kn-remove-unexpected-exported-v1-1-bb60cec57e84@gmail.com>

On Tue, May 20, 2025 at 04:40:12PM +0200, Karthik Nayak wrote:

> As of 1fc7ddf35b (test-lib: unconditionally enable leak checking,
> 2024-11-20), both the `GIT_TEST_PASSING_SANITIZE_LEAK` and
> `TEST_PASSES_SANITIZE_LEAK` variables no longer have any meaning, the
> leak checks are enabled by default. However, some newly added tests
> include them by mistake. Let's clean this up.

Thanks, I saw these recently while looking at another topic and was
surprised. I hadn't yet confirmed that they truly are pointless, so I'm
glad that you did. :)

As a side note, we do still use the SANITIZE_LEAK prereq in a few
places, and I believe that it does actually work. It might be nice to
clean up any leaks in those few spots, though we probably want to keep
the prereq around forever (e.g., if you introduce a test which shows off
a leak and then fixes it later). All orthogonal to your patch, though,
which looks good to me.

-Peff

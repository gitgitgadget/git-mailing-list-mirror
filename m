Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B22D6FB0
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723076278; cv=none; b=eYsabrZUjjGFPkb5rLIWQLAYkfrvIgujEjuKTTGrTElG6P8Hi1wnvhHRmfAJjHHeBHX1wU67KHK7cMmJL/FQ6foQ6QjmxkwE+PE7VKICr90wvIaTDdXiQHbk5EWdKBoQPI7STCKSLpF/hSF69XumE9ncuMkfV70tqU9pGX6o0jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723076278; c=relaxed/simple;
	bh=ZrShM/afjOP3sxmJIN3FKf70sfIqm8mQFI+IyvWYXQ8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZriLd9359UgVIgzmrKVOvC/pZhqYTzKdUzBip8gQHGBVy0HRgWbJHp8X0U35qIFHEP2NAvCYvRN7qJcrq9SnOTyj/eL4dUKzEGWFGPSFWGVsLVO3S1qnkXy4vnzJEXMw0A4aJxzfVaAVcs/6KkuBCGvtPisFVt1uIRy4tVBD9P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3976092-ipxg00k01tokaisakaetozai.aichi.ocn.ne.jp ([221.188.33.92] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1sbqqj-00B4WQ-1H;
	Thu, 08 Aug 2024 00:17:52 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1sbqqd-005YpS-28;
	Thu, 08 Aug 2024 09:17:43 +0900
Date: Thu, 8 Aug 2024 09:17:43 +0900
From: Mike Hommey <mh@glandium.org>
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com,
	emrass@google.com, rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 3/6] contrib/cgit-rs: introduce Rust wrapper for
 libgit.a
Message-ID: <20240808001743.4sx32gbjtypq3rje@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <cover.1723054623.git.steadmon@google.com>
 <9a846c17c891e17566a9907b3627210a6a08ea76.1723054623.git.steadmon@google.com>
 <20240807224756.2zq5hkfq5j43b7jk@glandium.org>
 <njekhcypd7x7vdxmkzbdbeblwm4bwiiz74saxdmzqeod6zz547@qkkwkmpjvwkd>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <njekhcypd7x7vdxmkzbdbeblwm4bwiiz74saxdmzqeod6zz547@qkkwkmpjvwkd>

On Wed, Aug 07, 2024 at 04:29:54PM -0700, Josh Steadmon wrote:
> > You might as well use `dst.display()`.
> 
> Wouldn't that fail silently in the event that the path is non-UTF-8? I
> think I'd prefer to explicitly fail in that case, even if it seems
> unlikely.

That's the theory, unfortunately, reality is that even the most central
Rust crates don't care:
https://github.com/rust-lang/cc-rs/blob/main/src/lib.rs#L1357-L1360

Even better, last time I tried, cargo or rustc (I don't remember which
one it was) would blatantly fail to work if the path is not UTF-8 in the
first place.

Mike

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02574188735
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 09:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731921591; cv=none; b=YBLRer9PneqHz7XynF48zPGfrswp6bcLJe4rRPtEnl3D8XtZgZRnyRS4INwWFZE6hKYc1kcfS9PQsjQS6hMgXmb5D+FO9NMI4rFFTc497MiHAKD4QIHlWwflLcm7Fs5vnVPzWlbSHkDAiJNtOLXxl24OZKZU2cydgF6pbbaJlgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731921591; c=relaxed/simple;
	bh=msbanHA8tGXZPO7fMfxGL5RlfbM6OuRUtzcV7ZtVxnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9JQZgKVkqt12FmWZ3IQso8bT9WxU5Gin1GnTUWhuv0E5YQHfOY3d1oFyG+PstRBVTTMGFblkL85H1JkSpBsqTcroyZbhDDrWgtJ6CdR/Tp1FGGCJfNQiXy21j4NtIzAAUTuYGt9G2PygLTaglD18xpQ7HTvkv+Ug629qyHiU3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AZ9ApoP/; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AZ9ApoP/"
Received: (qmail 22133 invoked by uid 109); 18 Nov 2024 09:19:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=msbanHA8tGXZPO7fMfxGL5RlfbM6OuRUtzcV7ZtVxnA=; b=AZ9ApoP/kJWhmxppMKwLdIZD4D/RG6KwwvFfiolXQbWA7tpXKVWbenwUhlaQ1vym/CvaMXXOpVtjaCsoH4cvw3h9Qry8yJn9U70BAMiqFIE1cdN0wzlB0G7IDYnNpqG1ZA3POiG2apartULtp+1RJW7nYHz3qd7dwoo5zTv615vwG9JBbIU7nI/2DIZY3HI1VeBj5BbKdiKEaFk6wzMfRYnpRH5eskqO80Pf9SoJ1Z23P1BWOBinP7diAkR6xDcAYVXOdrKMoxd+HeQsJLH4X004jJY+jRMuHTw2IFCM8pLE/gJq34t6Q2FlQFu25ex5aVs3+cKHWHQ3iux3Owe5PQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Nov 2024 09:19:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17970 invoked by uid 111); 18 Nov 2024 09:19:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Nov 2024 04:19:53 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Nov 2024 04:19:48 -0500
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Sam James <sam@gentoo.org>, git@vger.kernel.org
Subject: Re: -Wunterminated-string-initialization warning with GCC 15 in
 object-file.c
Message-ID: <20241118091948.GC3984843@coredump.intra.peff.net>
References: <87wmh2o9og.fsf@gentoo.org>
 <20241117090329.GA2341486@coredump.intra.peff.net>
 <ZzoT03rsx7MTqSFl@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZzoT03rsx7MTqSFl@tapette.crustytoothpaste.net>

On Sun, Nov 17, 2024 at 04:03:31PM +0000, brian m. carlson wrote:

> On 2024-11-17 at 09:03:29, Jeff King wrote:
> > Here are some patches. The first one should fix the warning (but I don't
> > have gcc-15 handy to test!). Please let me know if it works for you (and
> > thank you for reporting).
> 
> Just so you know, since I believe you also use Debian unstable, you can
> install the gcc-snapshot package (which is, admittedly, rather large)
> and use `CC=/usr/lib/gcc-snapshot/bin/gcc`.

Thanks, I was stupidly looking for a "gcc-15" package in experimental,
not realizing it had not actually been released yet. I reproduced the
problem with the snapshot (which is from 20241004) and verified that my
series fixes it.

-Peff

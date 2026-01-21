Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056E937F8A1
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025219; cv=none; b=b7y3kYdbzms0Cy6DMF82hA9+MT76o1RbmCa9sBH2Or7P59c24EyoLFwMJx+AQ+k48iXZPiItW3suSptJfsuJ3Ewrco8kqQ0PFhMnH4igYlOyFUSAzXtn2//YB6o0bvw7op8DDhkPljTaTkVQG2nqsNjufnYssA0kqR4hS6MDk8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025219; c=relaxed/simple;
	bh=QV6Z/QSmgzUJhk+IOY2PNZlq7eWkRAryvrJ8O0jkgN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnXkqloU85QYF8CJeSnGHPYCccO5XTFo0zC7v5TmnT/eHB6Wx6D+YVhoUAICK8b/vedk6ms2vbrmV4EC8m69Pp4DvoMAm3TF6niIGVrJ+g8gEWVuj8XncTJ0bgQtW0AvXUoLiqXClfen1/W2OvhtJ5qf+NRW0hjs3HOteZUqLrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aENqrmDw; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aENqrmDw"
Received: (qmail 123298 invoked by uid 109); 21 Jan 2026 19:53:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=QV6Z/QSmgzUJhk+IOY2PNZlq7eWkRAryvrJ8O0jkgN4=; b=aENqrmDwfpUBg6YSFBzqP8S9dmbixssXTcaCEAnbirz9t8z78dCiod8t6bI8hhGdLZZz0AkyNZ2XcSh2lCS8yIngcsnQMLJjBADTvcIGf+H5pBqi5Zg15e7WDoc38hLXa5o+Fd7rELqDHe2epLotsY6/k3XY+kXdQidtEbLJ8oiGkZ+O811pVj6mQAbHgrMvWVBeBBgSua8+ZRMisSUxOFIuRqbLKWHy8H/wM3ZhCDLu49Ok3vl9Ihy60FSn35yLI3+KoQYRUg4k5zGN0fUgDxty+Oljdc2yh5iNFFvzqkObNKGKIdHAT1ppRBmO1TFh36Gik5cyW4tq2Ew9OFlAlQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jan 2026 19:53:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 209589 invoked by uid 111); 21 Jan 2026 19:53:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jan 2026 14:53:31 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 21 Jan 2026 14:53:29 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Paulo Casaretto via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"Paulo Casaretto (Shopify)" <paulo.casaretto@shopify.com>,
	Patrick Steinhardt <ps@pks.im>,
	Paulo Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH v5] lockfile: add PID file for debugging stale locks
Message-ID: <20260121195329.GA584009@coredump.intra.peff.net>
References: <pull.2011.v4.git.1767804355831.gitgitgadget@gmail.com>
 <pull.2011.v5.git.1768933954845.gitgitgadget@gmail.com>
 <20260121071344.GA570838@coredump.intra.peff.net>
 <CAPig+cSE7Y-MLu1PTdo2kUq_MztMQgm0eYby03cX2K5YAJLwsg@mail.gmail.com>
 <20260121163924.GA576236@coredump.intra.peff.net>
 <xmqqcy32u769.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcy32u769.fsf@gitster.g>

On Wed, Jan 21, 2026 at 10:55:42AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The second half is still valid, I think, but at that point it is the
> > only path that uses the close() in the out-path, so we might as well
> > drop the out-path one.
> 
> True.  A fix-up may look like this.  I've got rid of the assignments
> to "fd" that are not used.

Yup, that all looks correct to me.

-Peff

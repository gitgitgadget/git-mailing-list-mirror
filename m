Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3369B13CF82
	for <git@vger.kernel.org>; Thu, 23 May 2024 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716459172; cv=none; b=idkOzPYNTJx0tD8oRUS0y2qk5cpo9maqWzhomrDrgG/YibsjMIsmjT/cCTnMFOA39zkTstpMFEz1aKI0uVTtwjzaBCSmOMrrzKV8g5A4oHsfk53K9Y9BdSPitPDzWUj70pjKD8uknrcKYGYYCxLH+V1PF8F1IoOHnbwUyxhIvVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716459172; c=relaxed/simple;
	bh=rufR5GP7r6UXbvp4Eci/j7ntbhuqhrJY4jqHOX6Khug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aN6wMYHNNcs+7PaZIuDJIfcq8Tfj3xsTEqj9DBRxnslYKX0qDdQbKgadP7M6oUnbiFPBAbp9eRJAlnc2VILImnD/Dl4En8zYEbADw2snU865aKbRiaaYCrofMsUojXBbjEz2gD5k3QwGrg77rTtw1AaCbjlcpR+HCXRWqZ+/6gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31262 invoked by uid 109); 23 May 2024 10:12:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 May 2024 10:12:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28833 invoked by uid 111); 23 May 2024 10:12:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 May 2024 06:12:54 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 23 May 2024 06:12:48 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 17/30] pseudo-merge: implement support for selecting
 pseudo-merge commits
Message-ID: <20240523101248.GB1308330@coredump.intra.peff.net>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
 <3029473c094b3edf51828b7a1d1acfc8e959ece6.1716318089.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3029473c094b3edf51828b7a1d1acfc8e959ece6.1716318089.git.me@ttaylorr.com>

On Tue, May 21, 2024 at 03:02:32PM -0400, Taylor Blau wrote:

> diff --git a/Documentation/config/bitmap-pseudo-merge.txt b/Documentation/config/bitmap-pseudo-merge.txt
> new file mode 100644
> index 00000000000..d4a2023b84a
> --- /dev/null
> +++ b/Documentation/config/bitmap-pseudo-merge.txt
> @@ -0,0 +1,90 @@
> +NOTE: The configuration options in `bitmapPseudoMerge.*` are considered
> +EXPERIMENTAL and may be subject to change or be removed entirely in the
> +future.

I'm happy to see this all marked as experimental. We really don't know
what selection approach will be best yet, and it's good not to lock
ourselves in.

I wasn't sure how this would format via asciidoc, since we're in the
middle of a list of variables. It...kind of looks like the note goes
under the previous entry (for attr.tree) in the text manpage. Though
looking at the docbook, I _think_ it's actually outside of that, and
it's just how the roff ends up indenting it?

I don't know if it's worth spending too much time on, but maybe there's
an easy way to do it differently (I couldn't think of one).

This paragraph might also be a good place to refer to gitpacking(7).

> diff --git a/Documentation/gitpacking.txt b/Documentation/gitpacking.txt
> index ff18077129b..1ed645ff910 100644
> --- a/Documentation/gitpacking.txt
> +++ b/Documentation/gitpacking.txt

Thanks, I think this new file and the content you added address all of
my documentation complaints.

I think it will also be a good place to discuss bitmaps in general, but
you were IMHO wise to not do that in this series, which is already quite
big. :)

-Peff

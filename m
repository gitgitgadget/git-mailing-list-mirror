Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2261D516C
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765786466; cv=none; b=aaJKgWL9Mv5UwsNpUjn1A/FUeiRIXIHEmnSV2xL2/yqC2x6npJyiXWzEZ3XdqWMf6dG5NYmMNuG1ZK8+5aqwdD11P3Mw0boakCA4jI+V2tQwhE6aHs2oaox3wTlrqfTs36a3TY5zMGhMYGzamGqOthQ5cHOOnJuMt/jNbmpltG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765786466; c=relaxed/simple;
	bh=/7iCO1nHsKQgNImTtROFeznyez/3epIT3pc33cnj/NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6EfAbHW9M7pwPvOZmzQDvVB0lnp+R+KMOAVLRvclluyNqVMu4pVVMQM7qWWMJPBf8Sz8Q1DrI256sfVVRVhQrDp74QAxw6TsHejOEPcUxPRTT80/tYRNjN0d92Ot9GTVvZh8uczraSl9mJZ/3+jlSJl6lZ2tshgSNZIQgTiixM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AFcZc7h4; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AFcZc7h4"
Received: (qmail 361297 invoked by uid 109); 15 Dec 2025 08:07:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/7iCO1nHsKQgNImTtROFeznyez/3epIT3pc33cnj/NE=; b=AFcZc7h4JY1dSQtIkoBMaDFfMv0lD5reE9I+6z4x1qofgC3cJIs+Do/mgEP7ERjBzDE+luEmSKTYfFzgXHdMWNL92HTiZTA6jbKzrKgRn8gcDSKMbOy/EsWAc6d46/KvbbRhvDnhUS42eAb2zG0p+iIu09JfkZyWcYwe0RxyYtzG6SmGNcxtU+Pg56LUpyJCvXbueKYaALXEkhSJ0gp4yWMNNFinag+SkbdrGrQjdmqFvThzQAkKerNXYajB5S9gZqu7OOCngdGB4zBbwsaTK/P2xo68y5Xur39Z9Ul0mlpXXA/3OxeOUMX6wial7aLPiKg9VlxkRsuLEuAG+LvLYA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Dec 2025 08:07:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 480535 invoked by uid 111); 15 Dec 2025 08:07:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Dec 2025 03:07:41 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 15 Dec 2025 03:07:36 -0500
From: Jeff King <peff@peff.net>
To: jim.cromie@gmail.com
Cc: Jason Baron <jbaron@akamai.com>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	gregkh@linuxfoundation.org, ukaszb@chromium.org,
	louis.chauvet@bootlin.com
Subject: Re: [PATCH v6 00/31] drm/dyndbg: Fix dynamic debug classmap
 regression
Message-ID: <20251215080736.GA809641@coredump.intra.peff.net>
References: <20251118201842.1447666-1-jim.cromie@gmail.com>
 <76038c97-39ca-4672-adc0-4e8fe0e39fc8@akamai.com>
 <CAJfuBxxFWD0rEjm-va+Bjmf-m2nfOD_+ZEqKy22WX6QdugQCUw@mail.gmail.com>
 <5b3d492c-7037-45a5-a001-0064f14d5f81@akamai.com>
 <CAJfuBxzW6TMmdS74ZPfPSe1w6S=oO17WYZc-Jgn_et=-Muw05A@mail.gmail.com>
 <20251214195420.GA791422@coredump.intra.peff.net>
 <CAJfuBxx-_Z_hCoqdj2Lma7oP6LhCM6Pz=afe2P=wKO41T7R3mA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfuBxx-_Z_hCoqdj2Lma7oP6LhCM6Pz=afe2P=wKO41T7R3mA@mail.gmail.com>

On Mon, Dec 15, 2025 at 11:52:38AM +1300, jim.cromie@gmail.com wrote:

> using the mbox.gz from your link, I get a different failure, this time
> on patch 11
> [...]
> jimc@frodo:~/projects/lx/linux.git$ gunzip
> ~/Downloads/PATCH-v6-00-31-drm-dyndbg-Fix-dynamic-debug-classmap-regression.mbox.gz
> gzip: /home/jimc/Downloads/PATCH-v6-00-31-drm-dyndbg-Fix-dynamic-debug-classmap-regression.mbox
> already exists; do you wish to overwrite (y or n)? y
> jimc@frodo:~/projects/lx/linux.git$ git am --empty=drop

Ah, that is the difference: you are applying directly from the
downloaded mbox file, whereas I picked out the messages using mutt.

The mbox provided by lore is generally in the order the messages were
received, which does not necessarily correspond to the order they were
sent, or the rfc822 dates, or the subject lines. But "git am" does not
do any sorting; it applies the messages in the order it finds them in
the input mbox. So you get out-of-order patch application.

There's another possible gotcha, as well. The mbox for the thread will
contain other non-patch messages like the cover letter and any review
responses. Adding --empty=drop as you did will generally skip past
those, but not always. If somebody responds and says "Maybe do it like
this" with an inline patch, then "git am" will pick up that patch, too!


It worked for me because when I picked the patches out of the thread in
mutt, it showed them sorted by rfc822 date header and used that same
ordering to dump them to the new, filtered mbox. And of course I
manually decided on which messages were part of the patch series and
excluded the rest (based on subject lines).

It would probably be possible to teach "git am" to sort by date header,
but that's not always right, either (you could have a local series with
out-of-order author dates due to rebasing). You could use the subject
lines as heuristics, if you know that the sender didn't use any exotic
format-patch options. So there are probably some heuristics at play.

And none of those ideas helps with the selection problem, which is
another heuristics ball of wax.

Fortunately, I think b4 has melted that wax for us already (OK, maybe
I'm losing the metaphor). If you do:

  b4 mbox https://lore.kernel.org/lkml/20251118201842.1447666-1-jim.cromie@gmail.com/

you'll get that unordered mbox again. But if you use the "am" command:

  b4 am https://lore.kernel.org/lkml/20251118201842.1447666-1-jim.cromie@gmail.com/

it figures everything out and gives you the clean series in an mbox. It
also knows how to pick the latest version of the series (your v6 is in
its own thread here, but if it were in a thread with v1..v5, you again
get into another message-selection problem).

-Peff

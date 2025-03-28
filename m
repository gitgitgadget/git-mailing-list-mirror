Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2704218035
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 03:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743133598; cv=none; b=LT+JGoSqV7IhvqprZ4pt5QIoEcFzSFJFLj0slKC4vim/ATDmFzZzVT+PEDq7gWVzDYbWH+nxmAK/NmUFlQDo/VWdy8oPY4OpQNecoIWtqzZtiofP8dtuGH24ipgFVUHogH3E/DGjlTQMyhtem5VES5bExP4H0tBXiAEY0SLh0x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743133598; c=relaxed/simple;
	bh=dRA5L/BAxtcn9kzCgacbfmiAkZMh20n6QRhmSpRZwQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhooTNQS+qkyN5wjkqULgUxYdsNaTNK6UbQS6nmu75JnAEcPOerQ+IPrib1qiwl2JPc1WK+yzJHiuRGQz1XYI985629AbU1xl/LvJI8C73yRX1xwOUPYs/34jf4tNUVELrakbOEpQvF0oF7wMztXTvOSMPUCWf3Gd0nUcG7qwtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OG4tpOa1; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OG4tpOa1"
Received: (qmail 30198 invoked by uid 109); 28 Mar 2025 03:46:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=dRA5L/BAxtcn9kzCgacbfmiAkZMh20n6QRhmSpRZwQw=; b=OG4tpOa14Z+v5Ms613CanTrHFso1q/RYctUYh92Kc/5c0Kba+QKqbdEYUYDCqEhoAHzj2Wth3OEjG+pgZ5Ba074WJTO+SsDMcT0BzdBJonUX+7DZrXUECu8ppz0EkhvDcM8nwliWhKSVrNn/pWgLDNOu/RB82VmhCKYU9QxPONjbeoipiigbrWDS8ocxHNTuMwzKZJXtZ8K8J80+ihQEfBTUVJUyqAtwapdPUgBehNnYg1lDsqLWaDPL0bLlpiGTopXehPhRxtfWg/xzF39g5+59L3r6qxEeS6EnL37KFeuHJUHuAUIB/yusjKXsFkCWF+dR+Lert+9br41yl+mFsg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 28 Mar 2025 03:46:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11118 invoked by uid 111); 28 Mar 2025 03:46:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Mar 2025 23:46:29 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 27 Mar 2025 23:46:28 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/4] cat_one_file(): make it easy to see that the `size`
 variable is initialized
Message-ID: <20250328034628.GA3067273@coredump.intra.peff.net>
References: <pull.1888.git.1743079429.gitgitgadget@gmail.com>
 <b5e98d5e144f4b3a2771a421690b4b729dc1b7ae.1743079429.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5e98d5e144f4b3a2771a421690b4b729dc1b7ae.1743079429.git.gitgitgadget@gmail.com>

On Thu, Mar 27, 2025 at 12:43:46PM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The large `switch` statement makes it a bit impractical to reason about
> the code.
> 
> One of the code paths can technically lead to using `size` without being
> initialized: if the `t` case is taken and the type name is set to the
> empty string, we would actually leave `size` unintialized right until we
> use it.

I don't think that's quite true. If we have an empty type name we leave
the switch and hit these lines:

	if (!buf)
		die("git cat-file %s: bad file", obj_name);

	write_or_die(1, buf, size);

Since we set buf to NULL before the switch and never touch it in the 't'
case, we'll always hit that die() call.

So this really is a false positive, regardless of what happens to the
type name buffer. I'm a little surprised that CodeQL would get this
wrong, just because it is very easy to see that buf is not touched in
the 't' case at all (and thus must be NULL). But maybe I'm missing
something.

I do agree that the flow through the switch statement (where "break" is
good for some cases and a failure mode for others) makes this code
rather hard to reason about. I'm sure it could be rewritten, but I'm not
sure if it's worth spending time on.

> Practically, this cannot happen because the
> `do_oid_object_info_extended()` function is expected to always populate
> the `type_name` if asked for. However, it is quite unnecessary to leave
> the code as unwieldy to reason about: Just initialize the variable to 0
> and be done with it.

You can trigger the path in question like this:

  oid=$(echo foo | git hash-object --literally --stdin -w -t '')
  git cat-file --allow-unknown -t $oid

which hits the "bad file" message.

(Obviously the above is horrible and arguably something we should
consider forbidding; I have some patches moving towards ripping out
support for non-standard types entirely).

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index b13561cf73b..128c901fa8e 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -104,7 +104,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
>  	struct object_id oid;
>  	enum object_type type;
>  	char *buf;
> -	unsigned long size;
> +	unsigned long size = 0;

So even though I think your analysis above had a few wrong details, I do
agree this is a false positive in CodeQL and is probably OK to fix as
you do here. Though it might make more sense to do it alongside the
assignment to "buf" (or to move the initialization of "buf" up here).

-Peff

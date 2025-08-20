Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D80C2566D9
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755718191; cv=none; b=uHQuD52OHK0TSWwLHrxYwrm2JykNXM0e9BZxK7rD4JFiPt7Ap/EblCOS0Re3HI9xfDh+af9AeywfgSOm8sibPFWTLb0zM1Zod4t+0LD+EOHNMkoFXQwqKGk03eACRrPpTAxLd0n0YFIf0KBMlzthvONDx8fForakzVGFMHnhLY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755718191; c=relaxed/simple;
	bh=YWq6TpH46HeY9nE2NH+Hsws5mFJSMG5krRXGyYSGGjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3ZIU9jp1BuDhajmqsi+XqRpR/BWJpFx/MiUY5DimEeUhRzAZzAowp6UFVEj//26yHNuA9dTGW9kf7NpXEioMYu4bPZxKs89/5NqBOz34ErH5R9FgAoeoeQt54dG28vCc1G9S7UYckVJRNbJBLbP+fR7GClSxmr575DvKOpWmcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YYfzEQvR; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YYfzEQvR"
Received: (qmail 38272 invoked by uid 109); 20 Aug 2025 19:29:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=YWq6TpH46HeY9nE2NH+Hsws5mFJSMG5krRXGyYSGGjg=; b=YYfzEQvR69YKIfoRwWnhjBfW3gAkV0At9R806NCMVYnvFyVr0q/hOf0Qu6wxcffHtLllrlPZDC4tRYAgv0516oy6Kt0o7ErosB+9TniRxcTk3oNOB6mIXRGUErPqIchBc58FihXzQXVGDmA8/yVQnGfPpw6aEHbDSFInlZ6gRuN6b0nlV27Gb4Vg8OUh/LbY1IbS+Y4XA9vGwMYv6pmveUpPqTZkZre6yTgS1pDzZRoZIdpicBPVIem4KTVP6yo/utvuugC7H9KRt0vK4cmk+Ffz3LRWWEdZI4+Sy1PxfrK9LAc4KnW0LTjDSS+unlM8JCR/6au0wChMtNea0Sq8/Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Aug 2025 19:29:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 63315 invoked by uid 111); 20 Aug 2025 19:29:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Aug 2025 15:29:48 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 20 Aug 2025 15:29:47 -0400
From: Jeff King <peff@peff.net>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>, Patrick Steinhardt <ps@pks.im>,
	Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 6/9] submodule: encode gitdir paths to avoid conflicts
Message-ID: <20250820192947.GA1663047@coredump.intra.peff.net>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250816213642.3517822-7-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250816213642.3517822-7-adrian.ratiu@collabora.com>

On Sun, Aug 17, 2025 at 12:36:39AM +0300, Adrian Ratiu wrote:

> @@ -2632,5 +2633,23 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
>  	/* New style (encoded) paths go under submodules/<encoded>. */
>  	strbuf_reset(buf);
>  	repo_git_path_append(r, buf, "submodules/");
> -	strbuf_addstr(buf, submodule_name);
> +	base_len = buf->len;
> +
> +	/* URL-encode then case case-encode A to _a, B to _b and so on */
> +	strbuf_addstr_urlencode(&tmp, submodule_name, is_rfc3986_unreserved);
> +	strbuf_addstr_case_encode(&encoded_sub_name, tmp.buf);
> +	strbuf_release(&tmp);
> +	strbuf_addbuf(buf, &encoded_sub_name);
> +
> +	/* Ensure final path length is below NAME_MAX after encoding */
> +	name_max = pathconf(buf->buf, _PC_NAME_MAX);
> +	if (name_max == -1)
> +		name_max = NAME_MAX;

This patch seems to break the Windows CI builds, as they don't have
pathconf() there. I guess we'd need a compat wrapper that returns -1 in
this case. And likewise protects _PC_NAME_MAX from being seen on systems
that don't have it.

> +	encoded_len = buf->len - base_len;
> +	if (encoded_len >= name_max)
> +		die(_("encoded submodule name '%s' is too long (%zu bytes, limit is %ld)"),
> +		    encoded_sub_name.buf, encoded_len, name_max);

It also complained about %z here. I think you have to use PRIuMAX
instead. Likewise size_t is a "long long" on Windows (LLP64). So "%ld"
probably also needs to be PRIuMAX.

I also saw failures on the osx jobs for t7527.62 (submodule
absorbgitdirs implicitly starts daemon). I didn't dig in, but I can
guess they may be related to this series.

-Peff

Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED0354774
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 03:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774151622; cv=none; b=teMxIX2EeJtNhT0zGm1MRRtej0z4W4g9StrLsdrwqNB8cFtB8ts/Pcw4k+QR9LMpftD17iq9bVkd8yJLXnAX7+ayGIHTF0F3JkiI6oSf9Kh5jxLxl3v92K5dIxi+TPO8S8r1oasd9ClaJgIVzsR1JCRDZmeLc623abqQ6vIx5iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774151622; c=relaxed/simple;
	bh=MUMnTtk0PxWD2EaaeZiomtJJDEMx0vcQe0miUAvnDOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8gXM4Su9hhZqTdEkt5pmLxTLJSJtbI3VpCUJP4VOkN+cGDN459RIqLlCR5MLmN26BlhsrosrDfW4pWFomBHRx4JIdPMTvz+LedHopWQ8n/U1ZbJIeVy9Qlc//gxA9ob5HBk4MNHR1lSRHwZerHUoDKGLCsbmKJj0o93JA57Kok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SzprdvFF; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SzprdvFF"
Received: (qmail 93452 invoked by uid 106); 22 Mar 2026 03:53:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=MUMnTtk0PxWD2EaaeZiomtJJDEMx0vcQe0miUAvnDOI=; b=SzprdvFFJQaFB//VFwWJgvNIRG6Rb3h8UplzZlyJmqeKXvr83jOndn4YOVpwWrt2oh3YldBVA+pjcDo28NYcXTbdjD9zHUU+sNj5Exwn4mSB42oBiqzjCv+iQ00Ja+C7nX2ScpEhVxFHu03OmiDxbBOF5Elx2pri9yFhcahUTKRRcv7Bg9vmKYLc6KGJ83gnQ0pVvG4jJCADrIr+3ZsuWTbLc6EbNYFvuJ229YKkTSfHKNHExznP0kx26aEeD4L8rdZHWMYkDVhpg+FaZUb5KatX/8zIC3RcwTj6Rkp9Q4rIDBoW9+wKtdd+jt07nI9YTRy3a+AtNaQNh2kMm26PMw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 22 Mar 2026 03:53:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 128670 invoked by uid 111); 22 Mar 2026 03:53:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 21 Mar 2026 23:53:38 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 21 Mar 2026 23:53:38 -0400
From: Jeff King <peff@peff.net>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, joliss42@gmail.com, joliss@gmail.com,
	gitster@pobox.com
Subject: Re: [PATCH v2] refspec: safely parse refspecs outside a repository
Message-ID: <20260322035338.GA819989@coredump.intra.peff.net>
References: <20260321194653.24513-1-jayatheerthkulkarni2005@gmail.com>
 <20260322023557.15907-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260322023557.15907-1-jayatheerthkulkarni2005@gmail.com>

On Sun, Mar 22, 2026 at 08:05:57AM +0530, K Jayatheerth wrote:

> Fix this by ensuring `the_hash_algo` is non-NULL before checking
> `the_hash_algo->hexsz` for both standard and negative refspecs.
> When operating outside a repository, fetching is impossible,
> so bypassing the exact OID check is the cleanest approach.

This argument is glossing over some details. Trying to break down all of
the implications, I think we have:

  - Without knowing the hash algo, we cannot reject negative refspecs
    that look like oids. This is OK in practice for two reasons. One,
    the only commands which apply refspecs are fetch and push, and they
    require a repository. And two, while we miss an opportunity to
    complain about broken config, it is quite unlikely for somebody to
    have such config (a global-level configured negative refspec that
    looks like an oid). And they will be told about it when running an
    actual fetch anyway.

  - Without knowing the hash algo, we cannot mark refspecs with the
    exact_sha1 flag. Again, we are not actually applying any refspecs
    unless we have a repo. The exact_sha1 flag is used to influence the
    set of prefixes we send to a remote v2 upload-pack process, but
    only for fetch (which requires a repository). For ls-remote, which
    can run outside a repo, we don't even look at the refspecs.

And so for those reasons it's probably OK to quietly ignore things.
Still, it rubs me the wrong way a little that we might create a subtle
bug from some other caller.

If we think we don't care about refspecs, it kind of makes me wonder if
we ought to be able to tell the remote API that we are interested in
remotes for their URLs only, and _not_ for their refspecs. But maybe
that leads to madness, as we end up with half-initialized "struct
remote"s floating around our process.


The other thing I wondered is why we are talking about remote-curl here,
and not ls-remote. And that's because ls-remote already hacked around
this!

Check out 9e89dcb66a (builtin/ls-remote: fall back to SHA1 outside of a
repo, 2024-08-02), which adds this:

          /*
           * TODO: This is buggy, but required for transport helpers. When a
           * transport helper advertises a "refspec", then we'd add that to a
           * list of refspecs via `refspec_append()`, which transitively depends
           * on `the_hash_algo`. Thus, when the hash algorithm isn't properly set
           * up, this would lead to a segfault.
           *
           * We really should fix this in the transport helper logic such that we
           * lazily parse refspec capabilities _after_ we have learned about the
           * remote's object format. Otherwise, we may end up misparsing refspecs
           * depending on what object hash the remote uses.
           */
          if (!the_repository->hash_algo)
                  repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);

Obviously that is kicking the can down the road, but it kind of makes
sense that we would have the same hack in place for remote-curl (which
in practice is only going to be called out-of-repo by ls-remote anyway).
It is only the fact that it happens in a separate process that the
existing fix from 9e89dcb66a is not helping us.

> Additionally, while looking into the remote-curl execution path,
> take the opportunity to remove an unused `#include "git-curl-compat.h"`
> from `remote-curl.c`.

I doubt this is correct.

remote-curl checks GIT_CURL_NEED_TRANSFER_ENCODING_HEADER, which is
defined in git-curl-compat.h. It may work fine without that header if
you have a recent version of curl, but older systems would be subtly
broken.

> +test_expect_success 'ls-remote outside repo does not segfault with fetch refspec' '
> +	GIT_CEILING_DIRECTORIES=$(pwd) &&
> +	export GIT_CEILING_DIRECTORIES &&
> +	mkdir nongit &&
> +	(
> +		cd nongit &&
> +		env GIT_CONFIG_NOSYSTEM=1 \
> +			GIT_CONFIG_GLOBAL=/dev/null \
> +			GIT_CONFIG_COUNT=1 \
> +			GIT_CONFIG_KEY_0=remote.origin.fetch \
> +			GIT_CONFIG_VALUE_0="+refs/tags/*:refs/tags/*" \
> +			git ls-remote "$HTTPD_URL/smart/repo.git"
> +	)
> +'

Some of this is irrelevant to reproducing the bug (like redirecting
system and global config). And it is much easier to use "git -c" to set
temporary config.

We also have a "nongit" helper function already. So I think just:

   nongit git \
          -c remote.origin.fetch=anything \
          ls-remote "$HTTPD_URL/smart/repo.git"

is enough to trigger it. Possibly it is slightly more realistic to
actually use the remote whose refspecs we are configuring:

  nongit git \
         -c remote.origin.url="$HTTPD_URL/smart/repo.git" \
	 -c remote.origin.fetch=anything \
	 ls-remote origin

but as the bug exists now, either is sufficient to trigger it. You could
also add a negative refspec if you want to test that half of the change.

-Peff

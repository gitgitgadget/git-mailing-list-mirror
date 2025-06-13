Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C11E2D4B5D
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749812383; cv=none; b=M3Pgszi0f/p+Wvs9wiH7dj7IfhGGSFhrAWOZSP4r24BaPFWBai1+COPt36kPszCqj/0M5zmyRKxata+zD80dMKjTy+Vvnhz7sl9P38J7ecq99eVS8zKbU/olESjsmkxad1ZkYcl+DIxwNUKOdJjKAgtOThI3E9o5e5VP07Nz0s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749812383; c=relaxed/simple;
	bh=wG/3BeoPp/+2LG4TBTRVxGkb0jEIeurDiA+MY42CkxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1jJaA6wSDTTMcYciLjsgYq6PN+kJrN2+l0ombuydrosPfQMr28fA4uwazSVJUNnDQ9FYvlKQ9AON/k/SE2lpaXy11Oy52aiEUe+fJa+nIoPtq1CRSOO11GCavt2d7dQYmVngHK3VC3xkmccX8QnzsSIb4zWKx0c88YT7TXPI+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VhJ/tjTh; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VhJ/tjTh"
Received: (qmail 7966 invoked by uid 109); 13 Jun 2025 10:59:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=wG/3BeoPp/+2LG4TBTRVxGkb0jEIeurDiA+MY42CkxE=; b=VhJ/tjThYj/88FHzpiZfYghg53Epn3+nMT82wa2cWNHDi9sT7DFHNA5hWf0n9UqDr2Ij78+zWB0EvpVkKdJgEYsGWMhTOyP4ZA71Ut+iHbhyppDCPSoXhS8Q6YRc93L1aV3zKXFCKtroi9j/KTnDtRBZury1raW1HFQ/ackMeAL3wmHtbMqOCPh4pP6TPfjQFxOpnUhxAEdSndYPj+0jgz9R3YCfjwJnr5/CwhAXdDN5xNoc+X0CURMTwx5+XxTFIcYJv1i4aXlyvhNm3Qt0PUGZyl0cBEe9qhE8JHNBU++twf8yNudTX4bEK4h4442MSyAs6r+zDo3kDzGNRw6hww==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 13 Jun 2025 10:59:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 787 invoked by uid 111); 13 Jun 2025 10:59:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Jun 2025 06:59:32 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 13 Jun 2025 06:59:32 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Brad Smith <brad@comstyle.com>,
	Collin Funk <collin.funk1@gmail.com>
Subject: Re: build: sed portability fixes
Message-ID: <20250613105932.GA1995623@coredump.intra.peff.net>
References: <xmqqplf8evr9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqplf8evr9.fsf@gitster.g>

On Thu, Jun 12, 2025 at 10:04:58AM -0700, Junio C Hamano wrote:

>  * This time with a proposed log message.  I may fast-track it down
>    to 'master' before the release.  I personally am undecided, and I
>    do know that I hate the style of this particular sed script and
>    am tempted to fix it before committing, but I'll refrain from
>    doing so before the release.

The newline-less input is in v2.49.0 already, but the use of "sed -E" is
new in the 2.50 cycle. So it probably is worth addressing before the
release. In which case I tried to give the patch a very careful read to
avoid any brown paper bags.

> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index 1047b8d11d..ad3aa59045 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -82,7 +82,7 @@ read GIT_MAJOR_VERSION GIT_MINOR_VERSION GIT_MICRO_VERSION GIT_PATCH_LEVEL trail
>  $(echo "$GIT_VERSION" 0 0 0 0 | tr '.a-zA-Z-' ' ')
>  EOF
>  
> -REPLACED=$(printf "%s" "$INPUT" | sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
> +REPLACED=$(printf "%s\n" "$INPUT" | sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
>  	-e "s|@GIT_MAJOR_VERSION@|$GIT_MAJOR_VERSION|" \
>  	-e "s|@GIT_MINOR_VERSION@|$GIT_MINOR_VERSION|" \
>  	-e "s|@GIT_MICRO_VERSION@|$GIT_MICRO_VERSION|" \

OK, makes sense since we now stick the content into the INPUT variable.
That sometimes comes from a file, but we get it via process substitution
with $(cat), so the shell will strip off the trailing newline there. So
we can unconditionally add it back here. Goo.d

> diff --git a/generate-configlist.sh b/generate-configlist.sh
> index 9d2ad6165d..75c39ade20 100755
> --- a/generate-configlist.sh
> +++ b/generate-configlist.sh
> @@ -13,16 +13,16 @@ print_config_list () {
>  	cat <<EOF
>  static const char *config_name_list[] = {
>  EOF
> -	sed -E '
> -/^`?[a-zA-Z].*\..*`?::$/ {
> +	sed -e '
> +	/^`*[a-zA-Z].*\..*`*::$/ {

OK, this is just replacing the use of "?" with "*". I think it is OK to
be loose here, as we are parsing our own config docs. And if somebody
did write

  ```foo.bar```::

it is probably OK to parse that anyway. ;)

> -d' \
> +	d' \
>  	    "$SOURCE_DIR"/Documentation/*config.adoc \
> -	    "$SOURCE_DIR"/Documentation/config/*.adoc|
> +	    "$SOURCE_DIR"/Documentation/config/*.adoc |

And then this (plus the indentation above) is just non-semantic
whitespace tidying.

So the whole thing looks good to me.

-Peff

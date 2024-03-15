Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBE340BE6
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710524786; cv=none; b=mvSr3Gn1D8raX581cFegoofvRlsEAuG5Gm6lecA4lJW+gE1rjN/xNc5XGIFznEAtX/m6IznEy9KMxn4pQw45iph0SbbzhbkIg2uOp7oRCPPVil6AokirfBiLNAUDidC6grEHyuLMs8mHT2evO9rKB8ohPagykaZxYtYqSiA57nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710524786; c=relaxed/simple;
	bh=hWnFt7CmUhqHH7cbWTxzRJgn9Q86chBoRS/xTlQ8Fh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sWMliffzH9/uz6YnaqORO9Qt1NjoKqc/TF0974gkmwAYXfGlx8Bs/XVoSSzJvhezZhulOom4g4732E1veyCEfQHE3n/8FH0Lzldgyo7vvPTlHrTxhv2Dvn896c3GRuiNBXwwy4v56hs1W3hx2C0Jsr0hlBV+DU46Foep0e5gQm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=G8N5j5QE; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G8N5j5QE"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4D5A432E9F;
	Fri, 15 Mar 2024 13:46:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hWnFt7CmUhqHH7cbWTxzRJgn9Q86chBoRS/xTl
	Q8Fh8=; b=G8N5j5QEV8NzsMP8W9uNofAQZakb/iGw64XbnKtsew18rUbJ9HqwtK
	wRphKFvXJy1iQBTI/8X0jLWkaG5XS+TKNwC/j+Oh5Yagh2NMrkjW/xFhOfBBVfss
	Lt4CBR5xZbsvCzq+ULbbQyQO6PVLvzJSRL019ljITJ+tcgM8BEB9c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4470B32E9E;
	Fri, 15 Mar 2024 13:46:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2F1ED32E9B;
	Fri, 15 Mar 2024 13:46:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  rsbecker@nexbridge.com,  github@seichter.de
Subject: Re: [PATCH 2/4] config: really keep value-internal whitespace verbatim
In-Reply-To: <cd890a7015733e311e0e0a4939c539d2894e31cf.1710508691.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Fri, 15 Mar 2024 14:22:08 +0100")
References: <cover.1710508691.git.dsimic@manjaro.org>
	<cd890a7015733e311e0e0a4939c539d2894e31cf.1710508691.git.dsimic@manjaro.org>
Date: Fri, 15 Mar 2024 10:46:17 -0700
Message-ID: <xmqq4jd7qtg6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EDF26E26-E2F3-11EE-9B20-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Fix a bug in function parse_value() that prevented whitespace characters
> (i.e. spaces and horizontal tabs) found inside configuration option values
> from being parsed and returned in their original form.  The bug caused any
> number of consecutive whitespace characters to be wrongly "squashed" into
> the same number of space characters.
>
> This bug was introduced back in July 2009, in commit ebdaae372b46 ("config:
> Keep inner whitespace verbatim").
>
> Further investigation showed that setting a configuration value, by invoking
> git-config(1), converts value-internal horizontal tabs into "\t" escape
> sequences, which the buggy value-parsing logic in function parse_value()
> didn't "squash" into spaces.  That's why the test included in the ebdaae37
> commit passed, which presumably made the bug remain undetected for this long.
> On the other hand, value-internal literal horizontal tab characters, found in
> a configuration file edited by hand, do get "squashed" by the value-parsing
> logic, so the right choice was to fix this bug by making the value-internal
> whitespace characters preserved verbatim.

OK.

> Fixes: ebdaae372b46 ("config: Keep inner whitespace verbatim")

No need for this line.  You mentioned it in the text already, and
more importantly, grepping for trailers is not the right thing to do
because we may think we fixed all bugs in ebdaae372b46 did with this
patch, which may in 6 months turn out to be false but we cannot undo
the trailer.  On the other hand, the discussion of the problem in
the proposed log message gives readers a richer context and the
future developers can understand that this fixed one thing in
ebdaae372b46 but didn't even know about other bugs introduced by
that old commit and make more intelligent decision based on that
better understanding.

> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  config.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/config.c b/config.c
> index a86a20cdf5cb..5072f12e62e4 100644
> --- a/config.c
> +++ b/config.c
> @@ -817,33 +817,38 @@ static int get_next_char(struct config_source *cs)
>  
>  static char *parse_value(struct config_source *cs)
>  {
> -	int quote = 0, comment = 0, space = 0;
> +	int quote = 0, comment = 0;
> +	size_t trim_len = 0;


>  	strbuf_reset(&cs->value);
>  	for (;;) {
>  		int c = get_next_char(cs);
>  		if (c == '\n') {
>  			if (quote) {
>  				cs->linenr--;
>  				return NULL;
>  			}
> +			if (trim_len)
> +				strbuf_setlen(&cs->value, trim_len);
>  			return cs->value.buf;

So the idea is that we copy everything we read verbatim in cs->value
but keep track of the beginning of the run of whitespace characters
at the end of the line in trim_len so that we can rtrim it?  That
should be the most straight-forward implementation.

>  		}
>  		if (comment)
>  			continue;
>  		if (isspace(c) && !quote) {
> +			if (!trim_len)
> +				trim_len = cs->value.len;
>  			if (cs->value.len)
> +				strbuf_addch(&cs->value, c);
>  			continue;

While we are not inside a dq-pair, we keep ignoring a whitespace
character at the beginning (i.e. cs->value.len == 0).

If we have some value in cs->value, however, we add the whitespace
character to cs->value verbatim.  trim_len==0 signals that the last
character we processed was not a whitespace character, and we copy
the current length of cs->value there---this is so that we can rtrim
away the run of whitespaces at the end of the input, including the
byte we are adding here, if it turns out that we are looking at the
first whitespace character of such trailing blanks.

>  		}
>  		if (!quote) {
>  			if (c == ';' || c == '#') {
>  				comment = 1;
>  				continue;
>  			}
>  		}

> +		if (trim_len)
> +			trim_len = 0;

If we are outside a dq-pair, we reach here only when we are looking
at a non-whitespace character.  If we are counting a run of unquoted
whitespaces, we can reset trim_len here to record that we do not
have to trim.

But can we be seeing a whitespace that is inside quote here?  Is
resetting trim_len to zero what we want in such a case?  Let's see.
Inside dq, we'd want to accumulate bytes, possibly after unwrapping
their backslash escapes, to cs->value, and these bytes include the
whitespace characters---we want to keep them literally without
trimming.  OK.

Looking good.  We should already demonstrate that this works well
with a new test in the same patch, can't we?  If we can, we should.

Thanks.

>  		if (c == '\\') {
>  			c = get_next_char(cs);
>  			switch (c) {

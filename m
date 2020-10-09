Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57184C43457
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 21:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04DDA222E9
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 21:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="In7yC0pJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391291AbgJIVKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 17:10:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54055 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389097AbgJIVKK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 17:10:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3E69F100E57;
        Fri,  9 Oct 2020 17:10:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hRlSAKNqcL3in7okxONTFgHtWFE=; b=In7yC0
        pJD+46oU/pNsO4qRrYXjaOkied5CwRI/E6A/6f8fC9NsgdFRoyTgOu2H5+HIwfCy
        sFFAEEzA+ENEmRBG668cCydxHO/Mv4LfTAKHk5EHsO05C2A3nA5FfjhecdnJIxGa
        19RTK19Ju+xrg0PV2tVCOlMunBbTeP8nzSj/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=asxEqEjq8eM8I6EtRzdTsbCnsBjT9mib
        XsP63baUNHeuEsAi5VfVDAT9gBACkA6r7iU8yhykWp/JcqHPz2ELJeNEn+W/Uj/7
        K0I9dr+ZsxBuYK9qr2xj0vMGfr1CRke8ArA3yYznu8L1xxKDx9TYsmB6p3GeuErC
        hU6ChapgqO4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3656A100E56;
        Fri,  9 Oct 2020 17:10:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4E21C100E55;
        Fri,  9 Oct 2020 17:10:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 1/2] abspath: add a function to resolve paths with
 missing components
References: <20201009191511.267461-1-sandals@crustytoothpaste.net>
        <20201009191511.267461-2-sandals@crustytoothpaste.net>
Date:   Fri, 09 Oct 2020 14:10:04 -0700
In-Reply-To: <20201009191511.267461-2-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 9 Oct 2020 19:15:10 +0000")
Message-ID: <xmqqk0vzrtqr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE4A30BA-0A73-11EB-9EF5-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We'd like to canonicalize paths such that we can preserve any number of
> trailing components that may be missing.

Sorry, but at least to me, the above gives no clue what kind of
operation is desired to be done on paths.  How would one preserve
what does not exist (i.e. are missing)?

Do you mean some leading components in a path point at existing
directories and after some point a component names a directory
that does not exist, so everything after that does not yet exist
until you "mkdir -p" them?

I guess my confusion comes primarily from the fuzziness of the verb
"canonicalize" in the sentence.  We want to handle a/b/../c/d and
there are various combinations of missng and existing directories,
e.g. a/b may not exist or a/b may but a/c may not, etc.  Is that
what is going on?  Makes me wonder if it makes sense to canonicalize
a/b/../c/d into a/c/d when a/b does not exist in the first place,
though.

> Let's add a function to do
> that that calls strbuf_realpath to find the canonical path for the
> portion we do have and then append the missing part.  We adjust
> strip_last_component to return us the component it has stripped and use
> that to help us accumulate the missing part.

OK, so if we have a/b/c/d and know a/b/c/d does not exist on the
filesystem, we start by splitting it to a/b/c and d, see if a/b/c
exists, and if not, do the same recursively to a/b/c to split it
into a/b and c, and prefix the latter to 'd' that we split earlier
(i.e. now we have a/b and c/d), until we have an existing directory
on the first half?

> Note that it is intentional that we invoke strbuf_realpath here,
> repeatedly if necessary, because on Windows that function is replaced
> with a version that uses the proper system semantics for
> canonicalization.  Trying to adjust strbuf_realpath to perform this kind
> of canonicalization with an additional option would fail to work
> properly on Windows.  The present approach is equivalent to
> strbuf_realpath for cases where the path exists, and the only other
> cases where we will use this function the additional overhead of
> multiple invocations is not significant.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  abspath.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++----
>  cache.h   |  1 +
>  2 files changed, 47 insertions(+), 4 deletions(-)
>
> diff --git a/abspath.c b/abspath.c
> index 6f15a418bb..092bb33b64 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -11,8 +11,12 @@ int is_directory(const char *path)
>  	return (!stat(path, &st) && S_ISDIR(st.st_mode));
>  }
>  
> -/* removes the last path component from 'path' except if 'path' is root */
> -static void strip_last_component(struct strbuf *path)
> +/*
> + * Removes the last path component from 'path' except if 'path' is root.
> + *
> + * If last is not NULL, the last path component is copied to last.
> + */
> +static void strip_last_component(struct strbuf *path, struct strbuf *last)
>  {
>  	size_t offset = offset_1st_component(path->buf);
>  	size_t len = path->len;
> @@ -20,6 +24,10 @@ static void strip_last_component(struct strbuf *path)
>  	/* Find start of the last component */
>  	while (offset < len && !is_dir_sep(path->buf[len - 1]))
>  		len--;
> +
> +	if (last)
> +		strbuf_addstr(last, path->buf + len);
> +
>  	/* Skip sequences of multiple path-separators */
>  	while (offset < len && is_dir_sep(path->buf[len - 1]))
>  		len--;
> @@ -118,7 +126,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
>  			continue; /* '.' component */
>  		} else if (next.len == 2 && !strcmp(next.buf, "..")) {
>  			/* '..' component; strip the last path component */
> -			strip_last_component(resolved);
> +			strip_last_component(resolved, NULL);
>  			continue;
>  		}
>  
> @@ -169,7 +177,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
>  				 * strip off the last component since it will
>  				 * be replaced with the contents of the symlink
>  				 */
> -				strip_last_component(resolved);
> +				strip_last_component(resolved, NULL);
>  			}
>  
>  			/*
> @@ -202,6 +210,40 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
>  	return retval;
>  }
>  
> +/*
> + * Like strbuf_realpath, but trailing components which do not exist are copied
> + * through.
> + */
> +char *strbuf_realpath_missing(struct strbuf *resolved, const char *path)
> +{
> +	struct strbuf remaining = STRBUF_INIT;
> +	struct strbuf trailing = STRBUF_INIT;
> +	struct strbuf component = STRBUF_INIT;
> +
> +	strbuf_addstr(&remaining, path);
> +
> +	while (remaining.len) {
> +		if (strbuf_realpath(resolved, remaining.buf, 0)) {
> +			strbuf_addbuf(resolved, &trailing);
> +
> +			strbuf_release(&component);
> +			strbuf_release(&remaining);
> +			strbuf_release(&trailing);
> +
> +			return resolved->buf;
> +		}
> +		strip_last_component(&remaining, &component);
> +		strbuf_insertstr(&trailing, 0, "/");
> +		strbuf_insertstr(&trailing, 1, component.buf);

I may be utterly confused, but is this where

    - we started with a/b/c/d, pushed 'd' into trailing and decided
      to redo with a/b/c

    - now we split the a/b/c into a/b and c, and adjusting what is
      in trailing from 'd' to 'c/d'

happens place?  It's a bit sad that we need to repeatedly use
insertstr to prepend in front, instead of appending.

> +		strbuf_reset(&component);
> +	}
> +
> +	strbuf_release(&component);
> +	strbuf_release(&remaining);
> +	strbuf_release(&trailing);
> +	return NULL;
> +}
> +
>  char *real_pathdup(const char *path, int die_on_error)
>  {
>  	struct strbuf realpath = STRBUF_INIT;
> diff --git a/cache.h b/cache.h
> index c0072d43b1..e1e17e108e 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1320,6 +1320,7 @@ static inline int is_absolute_path(const char *path)
>  int is_directory(const char *);
>  char *strbuf_realpath(struct strbuf *resolved, const char *path,
>  		      int die_on_error);
> +char *strbuf_realpath_missing(struct strbuf *resolved, const char *path);
>  char *real_pathdup(const char *path, int die_on_error);
>  const char *absolute_path(const char *path);
>  char *absolute_pathdup(const char *path);

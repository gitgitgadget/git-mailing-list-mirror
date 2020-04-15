Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTTP_ESCAPED_HOST,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC0DC2BB1D
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 00:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C94252072D
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 00:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="T6oclpit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392316AbgDOAOk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405209AbgDOANn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 20:13:43 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD50DC061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 17:13:39 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t4so572868plq.12
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 17:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SPftoIRuZuWguuFhST9e7qZqBz2rb9CpCF0uXBr/yf8=;
        b=T6oclpitwN7CIcfWOaQKWWfyaPsoTvs/T2Gv5eP7Qi8NJ1sT9wn1L2vuTXFdZQFshs
         LQpognlMzo2nskmhJ+ZRhRLAItDV8b6yFggLURdbdjMzitOqVq/EvOvQ9WtwcO2opEKl
         tH+6xByHyU7Z3u7+T9pvsdAdOyOnaQOVIgwDValFXOW7GZo/TKZJ8jl2XP85o8I23axw
         1Jo7IvgVcE20ij+68F6pGnWwEugnTHqs+FT3eq2jNegCUtF21K6OozF97pdgT8lqYzpJ
         IfMAeY/HyvaYkq2zEHI3Sl6mHjLhLuR15a7eTsBqXPU0SJH3DLmLh1SEufuE3bfa/Igg
         KHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SPftoIRuZuWguuFhST9e7qZqBz2rb9CpCF0uXBr/yf8=;
        b=AZbV9Ph8XdElelnceGO/hMsyAwwAV2eksXNknyWZ67LhtlzVbLDqRjKzymL7O8Kzjd
         gasAlN+dhExjCnwUJEFU/6kthZngRyABYLBTktV09YE8nBcr9XvSGqOxZ1nzOKqDaeCU
         2hfMPQwFKzZYBYGmVDSW79H7yUSH/aYm0kLr19JpsYFisP7bNoXtalkDYO+z0J+JhE+X
         sA211wpaRYEkq/kMj/DnLnlhJ80kg5f5wML385mB4qn4WFZZ3fdCTFwJLVwk/gy6sskG
         9JEalJJQXIhu3XMVdGKx7LVK4IsNPnxKzmU7r/+2pOlp0XYlTezoEKYH2/x7Gpb4b5kt
         /uOA==
X-Gm-Message-State: AGi0PualK9JIH3nwKNg0bk/iZKn3mEw+YoN6mo3Pwy0LcAlB7+o+KLG4
        qzD4OwkCyDopK9DJIEE0dUCwEP8CDaikM5qR
X-Google-Smtp-Source: APiQypLBX6XewDwEuFEXe2q3917/MYIsgZW+wWmGV/MLEMK8TV4Dy/nMjWxw6h2a/GpAUbPd0cyoOQ==
X-Received: by 2002:a17:902:b717:: with SMTP id d23mr1377243pls.51.1586909619334;
        Tue, 14 Apr 2020 17:13:39 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id r26sm7229122pfq.75.2020.04.14.17.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 17:13:38 -0700 (PDT)
Date:   Tue, 14 Apr 2020 18:13:37 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] credential: treat "?" and "#" in URLs as end of host
Message-ID: <20200415001337.GA7457@syl.local>
References: <20200414214304.GA1887601@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200414214304.GA1887601@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, Apr 14, 2020 at 05:43:04PM -0400, Jeff King wrote:
> It's unusual to see:
>
>   https://example.com?query-parameters
>
> without an intervening slash, like:
>
>   https://example.com/some-path?query-parameters
>
> or even:
>
>   https://example.com/?query-parameters
>
> but it is a valid end to the hostname (actually "authority component")
> according to RFC 3986. Likewise for "#".
>
> And curl will parse the URL according to the standard, meaning it will
> contact example.com, but our credential code would ask about a bogus
> hostname with a "?" in it. Let's make sure we follow the standard, and
> more importantly ask about the same hosts that curl will be talking to.
>
> It would be nice if we could just ask curl to parse the URL for us. But
> it didn't grow a URL-parsing API until 7.62, so we'd be stuck with
> fallback code either way. Plus we'd need this code in the main Git
> binary, where we've tried to avoid having a link dependency on libcurl.
>
> But let's at least fix our parser. Moving to curl's parser would prevent
> other potential discrepancies, but this gives us immediate relief for
> the known problem, and would help our fallback code if we eventually use
> curl.
>
> Signed-off-by: Jeff King <peff@peff.net>

All makes sense to me. I agree that it would probably be preferable if
we could just use cURL's own parser and forget about this code entirely.
But, having it still be a fallback knocks out any benefit that we'd be
getting by relying on their parser rather than our own.

> ---
> Just a follow-on to today's release. This isn't security critical after
> the earlier fix, but it made some of the attack vectors much easier.

Yep, thanks for noting.

>  credential.c           |  9 ++++++++-
>  t/t0300-credentials.sh | 36 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/credential.c b/credential.c
> index 21b3ba152f..8aa9777548 100644
> --- a/credential.c
> +++ b/credential.c
> @@ -388,7 +388,14 @@ int credential_from_url_gently(struct credential *c, const char *url,
>  	cp = proto_end + 3;
>  	at = strchr(cp, '@');
>  	colon = strchr(cp, ':');
> -	slash = strchrnul(cp, '/');
> +
> +	/*
> +	 * A query or fragment marker before the slash ends the host portion.
> +	 * We'll just continue to call this "slash" for simplicity. Notably our
> +	 * "trim leading slashes" part won't skip over this part of the path,
> +	 * but that's what we'd want.
> +	 */
> +	slash = cp + strcspn(cp, "/?#");
>
>  	if (!at || slash <= at) {
>  		/* Case (1) */
> diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
> index 5b78ebbc3f..b6ec676989 100755
> --- a/t/t0300-credentials.sh
> +++ b/t/t0300-credentials.sh
> @@ -443,11 +443,45 @@ test_expect_success 'url parser ignores embedded newlines' '
>  	username=askpass-username
>  	password=askpass-password
>  	--
> -	warning: url contains a newline in its host component: https://one.example.com?%0ahost=two.example.com/
> +	warning: url contains a newline in its path component: https://one.example.com?%0ahost=two.example.com/
>  	warning: skipping credential lookup for url: https://one.example.com?%0ahost=two.example.com/
>  	askpass: Username:
>  	askpass: Password:
>  	EOF
>  '
>
> +# usage: check_host_and_path <url> <expected-host> <expected-path>
> +check_host_and_path () {
> +	# we always parse the path component, but we need this to make sure it
> +	# is passed to the helper
> +	test_config credential.useHTTPPath true &&
> +	check fill "verbatim user pass" <<-EOF
> +	url=$1
> +	--
> +	protocol=https
> +	host=$2
> +	path=$3
> +	username=user
> +	password=pass
> +	--
> +	verbatim: get
> +	verbatim: protocol=https
> +	verbatim: host=$2
> +	verbatim: path=$3
> +	EOF
> +}
> +
> +test_expect_success 'url parser handles bare query marker' '
> +	check_host_and_path https://example.com?foo.git example.com ?foo.git
> +'
> +
> +test_expect_success 'url parser handles bare fragment marker' '
> +	check_host_and_path https://example.com#foo.git example.com "#foo.git"
> +'
> +
> +test_expect_success 'url parser not confused by encoded markers' '
> +	check_host_and_path https://example.com%23%3f%2f/foo.git \
> +		"example.com#?/" foo.git
> +'
> +
>  test_done

These look good, too. Thanks for working on this.

> --
> 2.26.1.429.g609150846d

Thanks,
Taylor

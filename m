Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2338C433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 18:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353433AbiE0SJc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 14:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiE0SJa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 14:09:30 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930C01207D5
        for <git@vger.kernel.org>; Fri, 27 May 2022 11:09:28 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54E9912E8AC;
        Fri, 27 May 2022 14:09:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1kl8DmzC6oztR/ylbpk2kKq9vcq+Bz1NuTFXFY
        +In3o=; b=C5KBGa/I5JqBj8FXJb4m6fwQki8IF4YFNJHiYl5R8nvxkoxGwyoXas
        TyPYUhL2dXdpju4/HtISlWTuyjWUv7h141bUO3J3NXjOJ/lky9SyNf0et7kwOH/z
        KxCwZa1kg6XhB6IJvQU2xNdEEGUuo4NFjJBx9yoW0TrtIQDgxTmOw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E08012E8AB;
        Fri, 27 May 2022 14:09:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 96C6612E8AA;
        Fri, 27 May 2022 14:09:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        avarab@gmail.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] urlmatch: create fetch.credentialsInUrl config
References: <pull.1237.git.1653329044940.gitgitgadget@gmail.com>
        <pull.1237.v2.git.1653658034086.gitgitgadget@gmail.com>
Date:   Fri, 27 May 2022 11:09:25 -0700
In-Reply-To: <pull.1237.v2.git.1653658034086.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Fri, 27 May 2022 13:27:13
        +0000")
Message-ID: <xmqqsfou3l0q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 251C55AA-DDE8-11EC-AA8D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
> index cd65d236b43..7fd3ea89f5d 100644
> --- a/Documentation/config/fetch.txt
> +++ b/Documentation/config/fetch.txt
> @@ -96,3 +96,17 @@ fetch.writeCommitGraph::
>  	merge and the write may take longer. Having an updated commit-graph
>  	file helps performance of many Git commands, including `git merge-base`,
>  	`git push -f`, and `git log --graph`. Defaults to false.
> +
> +fetch.credentialsInUrl::
> +	A URL can contain plaintext credentials in the form
> +	`protocol://<user>:<password>@domain/path`. Using such URLs is not

In the above, 'protocol', 'domain' and 'path' are all placeholders,
just like <user> and <password> are, and it made me wonder if we
should be consistent.  Enclosing all placeholders in <angle-braket>
pairs would make the resulting text too loud, so it may make sense
to drop these highlights around user and password.

That makes it consistent with what git-credential-store.txt,
git-svn.txt, gitfaq.txt and urls.txt do

    git-credential-store.txt:https://user:pass@example.com
    git-svn.txt:	the URL, e.g. `svn+ssh://foo@svn.bar.com/project`
    gitfaq.txt:$ echo url=https://author@git.example.org | git credential reject
    gitfaq.txt:	https://author@git.example.org/org1/project1.git and
    gitfaq.txt:	https://committer@git.example.org/org2/project2.git.  This way, when you
    gitfaq.txt:	origin https://author@git.example.org/org1/project1.git` (see


> +	recommended as it exposes the password in multiple ways, including
> +	Git storing the URL as plaintext in the repository config. The
> +	`fetch.credentialsInUrl` option provides instruction for how Git
> +	should react to seeing such a URL, with these values:
> ++
> +* `allow` (default): Git will proceed with its activity without warning.
> +* `warn`: Git will write a warning message to `stderr` when parsing a URL
> +  with a plaintext credential.
> +* `die`: Git will write a failure message to `stderr` when parsing a URL
> +  with a plaintext credential.

Good.

> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 4a61f2c901e..387da74d175 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -71,6 +71,18 @@ test_expect_success 'clone respects GIT_WORK_TREE' '
>  
>  '
>  
> +test_expect_success 'clone warns or fails when using username:password' '
> +	test_must_fail git -c fetch.credentialsInUrl=warn clone https://username:password@localhost attempt1 2>err &&
> +	grep "warning: URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" err &&
> +	test_must_fail git -c fetch.credentialsInUrl=die clone https://username:password@localhost attempt2 2>err &&
> +	grep "fatal: URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" err
> +'
> +
> +test_expect_success 'clone does not detect username:password when it is https://username@domain:port/' '
> +	test_must_fail git -c fetch.credentialsInUrl=warn clone https://username@localhost:8080 attempt3 2>err &&
> +	! grep "uses plaintext credentials" err
> +'

Could we have one negative test here, too?  I.e. with an explicit -c
fetch.credentialsInUrl=allow given, no credential-in-URL errors and
warnings should be issued.

> diff --git a/urlmatch.c b/urlmatch.c
> index b615adc923a..16beda37a3a 100644
> --- a/urlmatch.c
> +++ b/urlmatch.c
> @@ -1,5 +1,6 @@
>  #include "cache.h"
>  #include "urlmatch.h"
> +#include "config.h"
>  
>  #define URL_ALPHA "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
>  #define URL_DIGIT "0123456789"
> @@ -106,6 +107,59 @@ static int match_host(const struct url_info *url_info,
>  	return (!url_len && !pat_len);
>  }
>  
> +/*
> + * Call this method when we have detected credentials within the 'url' in
> + * the form
> + *
> + *     scheme://username:password@domain[:port][/path]
> + *
> + * The 'scheme_len' value should be equal to the string length of the
> + * "scheme://" portion of the URL.

"scheme" is probably more technically correct here, even though in
the documentation that faces the end-users, "protocol" would be more
widely understood, so I think this inconsistency in a single patch
across paths is a good thing ;-)

> + * The fetch.credentialsInUrl config indicates what to do on such a URL,
> + * either ignoring, warning, or die()ing. The latter two modes write a
> + * redacted URL to stderr.
> + */
> +static void detected_credentials_in_url(const char *url, size_t scheme_len)
> +{
> +	const char *value;
> +	const char *at_ptr;
> +	const char *colon_ptr;
> +	struct strbuf redacted = STRBUF_INIT;
> +
> +	/* "allow" is the default behavior. */
> +	if (git_config_get_string_tmp("fetch.credentialsinurl", &value) ||
> +	    !strcmp("allow", value))
> +		return;

OK.

> +	at_ptr = strchr(url, '@');
> +	colon_ptr = strchr(url + scheme_len + 3, ':');

I am debating myself if we should explain "+ 3" that counts "://" in
a comment, but it probably is trivial to see.

> +	/*
> +	 * Let's do some defensive programming to ensure the given
> +	 * URL is of the proper format.
> +	 */
> +	if (!colon_ptr)
> +		BUG("failed to find colon in url '%s' with scheme_len %"PRIuMAX,
> +		    url, (uintmax_t) scheme_len);
> +	if (colon_ptr > at_ptr)
> +		BUG("input url '%s' does not include credentials",
> +		    url);

OK.  The caller shouldn't have called us in these two cases.

> +	/* Include the colon when creating the redacted URL. */
> +	colon_ptr++;
> +	strbuf_addstr(&redacted, url);
> +	strbuf_splice(&redacted, colon_ptr - url, at_ptr - colon_ptr,
> +		      "<redacted>", 10);
> +
> +	if (!strcmp("warn", value))
> +		warning(_("URL '%s' uses plaintext credentials"), redacted.buf);
> +	if (!strcmp("die", value))
> +		die(_("URL '%s' uses plaintext credentials"), redacted.buf);
> +
> +	strbuf_release(&redacted);

OK.  Let's look at the caller.

>  			if (colon_ptr) {
> +				detected_credentials_in_url(orig_url, scheme_len);
>  				passwd_off = (colon_ptr + 1) - norm.buf;
>  				passwd_len = norm.len - passwd_off;
>  				user_len = (passwd_off - 1) - (scheme_len + 3);

The caller apparently knows where the password and username are at
this point.  It is unclear which string these offsets are pointing
into at this point, but at the end of the function, we have the
offset and length of user and passwd that point into result, all in
our local variables, even when out_info is NULL.

	result = strbuf_detach(&norm, &result_len);
	if (out_info) {
		out_info->url = result;
		out_info->err = NULL;
		out_info->url_len = result_len;
		out_info->scheme_len = scheme_len;
		out_info->user_off = user_off;
		out_info->user_len = user_len;
		out_info->passwd_off = passwd_off;
		out_info->passwd_len = passwd_len;
		out_info->host_off = host_off;
		out_info->host_len = host_len;
		out_info->port_off = port_off;
		out_info->port_len = port_len;
		out_info->path_off = path_off;
		out_info->path_len = path_len;
	}
	return result;

It does make me wonder if we want another parser in the new
function.  Wouldn't it be easier to manage if we inserted a
call to 

	if (passwd_off)
		apply_fetch_credentials_in_url(result,
        			user_off, user_len, passwd_off, passwd_len);

just after the strbuf_detach() we see near the end of the function, where
apply_fetch_credentials_in_url() only reads the configuration and
calls warning or die as appropriate?

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E17C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 08:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiEXIfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 04:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiEXIfL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 04:35:11 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90661633AE
        for <git@vger.kernel.org>; Tue, 24 May 2022 01:35:09 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i40so22109691eda.7
        for <git@vger.kernel.org>; Tue, 24 May 2022 01:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=uvppGQkp4paiwkt1Oj2Xib7B1B9nP2MOXzYaHYqveRo=;
        b=PD/gwYV59DB4jvoEMrKj6eLpmZ7KTXl+jgdqyhPnF+D7MOWl8GeEgluotfdGHanMrZ
         /k4hp81oz8bU5NKQzNrimgwISXJq0Kv2yn0SOXfpYXuRvfruhKLmoux9gYzCDRCthdxS
         M3qdbgapxO9ejAG1DQ4ZnTxE4kLRe7422fpWhV/583eY6hYWoFgmXqPBMMYplyAkdHbX
         BVBCi0Ruvr3XInw6NiCxhB9L91QD+721+Cy8+U85Q/5xcqNyjBiJE8A9VpxL0+PgmUpp
         SjCF5zDaSyJsvGu/3ZhBj/3XXtjbVeHEzJDPOGgPTH54SWGwwq5ic1/BsCU9hTzeJcPi
         jFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=uvppGQkp4paiwkt1Oj2Xib7B1B9nP2MOXzYaHYqveRo=;
        b=oGAnrdcfYR+rHIbD9A2pkO7OylwIgpKvMXcmH0//ijM4lcmkgGN2x4s6VSP7ED490z
         qaKAAjTKU029rNchcKI3TxsSZixnlYNavSIoy+6CHc0zIuDBNdnAL6VUOLacFUGogNzr
         TuWUgJ2McBITzpAmi73W7zfFzjOTsJwJbgGbyom4UgMoDUidWITHb5sP5gimR0BAlSgY
         NiVnnfIlRSzAnChDms1HEK3nUxojefVHdAKRYZ2l1SMG6Yzcg0uf0dp5648mOvuOgiuG
         mKSW2bN1smaZenFJgNqEVZ2NWhWeJZplLZrSmWFi9OVtF+9aNY7siRDJpFXsVbmurufd
         89Bg==
X-Gm-Message-State: AOAM532MuPj0vmDpt8ybTBIa87XoaO9LjvR+F6TZkAPrrvOH1LMaBXGT
        mSaU99k9H2AuFtfhXg8gt9AgZiWOXWRXFQ==
X-Google-Smtp-Source: ABdhPJyqabvMoH//CZPGjcp6EFWRoKyPNQXp1cCwbjCGdx04pPVkJlzc8EFoGxzYxqXDzRg1B58/EA==
X-Received: by 2002:a50:cd08:0:b0:426:1d9b:4b13 with SMTP id z8-20020a50cd08000000b004261d9b4b13mr27537800edi.360.1653381307791;
        Tue, 24 May 2022 01:35:07 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id h24-20020a1709070b1800b006f3ef214e5csm5063509ejl.194.2022.05.24.01.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 01:35:07 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntQ0Q-003A15-HD;
        Tue, 24 May 2022 10:35:06 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        me@ttaylorr.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] urlmatch: create fetch.credentialsInUrl config
Date:   Tue, 24 May 2022 10:18:13 +0200
References: <pull.1237.git.1653329044940.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1237.git.1653329044940.gitgitgadget@gmail.com>
Message-ID: <220524.8635gzxr9h.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 23 2022, Derrick Stolee via GitGitGadget wrote:

> +fetch.credentialsInUrl::
> +	A URL can contain plaintext credentials in the form
> +	`protocol://<user>:<password>@domain/path`. Using such URLs is not
> +	recommended as it exposes the password in multiple ways. The
> +	`fetch.credentialsInUrl` option provides instruction for how Git
> +	should react to seeing such a URL, with these values:

Re the previous discussion about this (in the v1 patch /
https://lore.kernel.org/git/pull.945.git.1619807844627.gitgitgadget@gmail.com/):
In what ways?

That's rhetorical, the point being: Let's adjust this documentation to
discuss exactly why this is thought to be bad, what we're mitigating for
the user etc., are there situations where running git like this is
perfectly fine & not thought to be an issue? E.g. no password manager
and you trust your FS permission? Let's cover those cases too.

> ++
> +* `ignore` (default): Git will proceed with its activity without warning.
> +* `warn`: Git will write a warning message to `stderr` when parsing a URL
> +  with a plaintext credential.
> +* `die`: Git will write a failure message to `stderr` when parsing a URL
> +  with a plaintext credential.

You're implementing this with strcasecmp, so we also support DIE, DiE
etc. Let's not do that and use strcmp() instead.

> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 4a61f2c901e..34be520b783 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -71,6 +71,13 @@ test_expect_success 'clone respects GIT_WORK_TREE' '
>  
>  '
>  
> +test_expect_success 'clone warns or fails when using username:password' '
> +	test_must_fail git -c fetch.credentialsInUrl=warn clone https://username:password@localhost attempt1 2>err &&
> +	grep "warning: URL '\''https://username:\*\*\*\*\*\*\*\*@localhost/'\'' uses plaintext credentials" err &&
> +	test_must_fail git -c fetch.credentialsInUrl=die clone https://username:password@localhost attempt2 2>err &&
> +	grep "fatal: URL '\''https://username:\*\*\*\*\*\*\*\*@localhost/'\'' uses plaintext credentials" err
> +'
> +
>  test_expect_success 'clone from hooks' '
>  
>  	test_create_repo r0 &&
> diff --git a/urlmatch.c b/urlmatch.c
> index b615adc923a..6b91fb648a7 100644
> --- a/urlmatch.c
> +++ b/urlmatch.c
> @@ -1,5 +1,6 @@
>  #include "cache.h"
>  #include "urlmatch.h"
> +#include "config.h"
>  
>  #define URL_ALPHA "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
>  #define URL_DIGIT "0123456789"
> @@ -106,6 +107,46 @@ static int match_host(const struct url_info *url_info,
>  	return (!url_len && !pat_len);
>  }
>  
> +static void detected_credentials_in_url(const char *url, size_t scheme_len)
> +{

Just generally: This is only 

> +	char *value = NULL;

This init to NULL should be removedd, as we....

> +	const char *at_ptr;
> +	const char *colon_ptr;
> +	struct strbuf anonymized = STRBUF_INIT;

nit: Just call this "sb"? The's at least one line below over 79
characters that's within the bounds with a shorter variable name, and in
this case it's obvious what we're doing here...
> +
> +	/* "ignore" is the default behavior. */
> +	if (git_config_get_string("fetch.credentialsinurl", &value) ||

...initialize it here, and if we didn't the compiler would have a chance
to spot that if we were getting it wrong.

> +	    !strcasecmp("ignore", value))
> +		goto cleanup;
> +
> +	at_ptr = strchr(url, '@');
> +	colon_ptr = strchr(url + scheme_len + 3, ':');
> +
> +	if (!colon_ptr)
> +		BUG("failed to find colon in url '%s' with scheme_len %"PRIuMAX,
> +		    url, (uintmax_t) scheme_len);
> +
> +	/* Include everything including the colon. */
> +	colon_ptr++;
> +	strbuf_add(&anonymized, url, colon_ptr - url);
> +
> +	while (colon_ptr < at_ptr) {
> +		strbuf_addch(&anonymized, '*');
> +		colon_ptr++;
> +	}

Could we share code with 88e9b1e3fcb (fetch-pack: redact packfile urls
in traces, 2021-11-10), or for consistency note this as <redacted>
instead of stripping it out, as we do for that related URL-part
redaction?

> +	strbuf_addstr(&anonymized, at_ptr);

Maybe not worth it, but I wondered if we couldn't just use curl for
this, turns out it has an API for it:
https://curl.se/libcurl/c/libcurl-url.html

But it's too new for us to rely on unconditionally, but we could add
that to git-curl-compat.h and ifdef it, then we'll eventually drop this
custom code for ryling on the well-tested library.

I think doing that would be worth it, to show future authors that curl
can do this, so maybe we can start relying on that eventually...

> +	if (!strcasecmp("warn", value))
> +		warning(_("URL '%s' uses plaintext credentials"), anonymized.buf);
> +	if (!strcasecmp("die", value))
> +		die(_("URL '%s' uses plaintext credentials"), anonymized.buf);
> +
> +cleanup:
> +	free(value);

I think you can also just use git_config_get_string_tmp() here and avoid
the alloc/free. That's safe as long as you're not calling other config
API in-between, which you're not.

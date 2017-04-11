Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DA4620960
	for <e@80x24.org>; Tue, 11 Apr 2017 00:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbdDKA6U (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 20:58:20 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36673 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbdDKA6T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 20:58:19 -0400
Received: by mail-pf0-f173.google.com with SMTP id o126so40836156pfb.3
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 17:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2GzxV7vJSXpm3S3GJkAdXqyXCT1FFKWWAik86/WQFEk=;
        b=mg0bHvsUwmv+vqAuxzmGN2Hgq2s7s6ok8rtqtWtMV9zbNhZSSOWaEsqOCKZlcBHmSt
         GTgC6Jtojd4HhDlKJ5zizehD4PwIGH7FhILlUkC05zdjCnw7boQ9GZ8gbgq/ElaC0/lz
         o7a+uwszyC0VZ/Ftrma61utmb0wdWZHtzF4E4fW5Q2hz6wBbUHUWVBYKwlWpJWAO0HoJ
         DEoXiTdf+P2s0e1YTwC5/qdMDRaaKksWjcby9LVAZBRk3CzcRb5lj5pCsr5LreeyQTrY
         5XAD8YjU86VZDCEy+kp2tnLr2s6OeF2KYaJQWwLc46IuXOIP81dCxcKDY7i5t4jeO6hL
         uFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2GzxV7vJSXpm3S3GJkAdXqyXCT1FFKWWAik86/WQFEk=;
        b=Skhq6MCraSvb2oxqB6Bikf02P6VBQVFO1gvE1+rTjlVUUl0OnI8K4wLeG7whkkqlEk
         l05UpFVmUvZ3cwO9a6f0qiWbqnvk2xB/Su9thn360rCBgwvGEWO9KzycPx5gOZMeFQk4
         TrIyOix1bj39j38JKly/ocQUlaNj+SDYOIoe9Nmxwajo5DyTppbn8Hyh365wILSucjoT
         iVpFiWCqNCNy88fuh2AsJ71Z6LHEsHmLrneYawrSxd8e4+VllkpyFKT7+tpV0/psxMy1
         GsxVPdoXof0sF7lkxlncXMathXTFhDuWxtLFHdAyv2EXnbogmLb+L4CPX9CgdTecl/me
         CL6w==
X-Gm-Message-State: AFeK/H3YfR4632sdVu6Gd0/gd3+I4PLMbtMlT49LOXix2gItxl1XzVPoryy5O5O7TCUAaQ==
X-Received: by 10.84.192.129 with SMTP id c1mr71876563pld.181.1491872298845;
        Mon, 10 Apr 2017 17:58:18 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:dcb:fd1c:cdca:5669])
        by smtp.gmail.com with ESMTPSA id a184sm15448209pfb.118.2017.04.10.17.58.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 17:58:18 -0700 (PDT)
Date:   Mon, 10 Apr 2017 17:58:16 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/5] run-command: prepare child environment before forking
Message-ID: <20170411005816.GK8741@aiede.mtv.corp.google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170410234919.34586-5-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170410234919.34586-5-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> In order to avoid allocation between 'fork()' and 'exec()' prepare the
> environment to be used in the child process prior to forking.

If using something like posix_spawn(), this would be needed anyway, so
I'll review it.

[...]
> +++ b/run-command.c
[...]
> +static char **prep_childenv(const char *const *deltaenv)
> +{
> +	char **childenv;
> +	int childenv_nr = 0, childenv_alloc = 0;
> +	int i;
> +
> +	for (i = 0; environ[i]; i++)
> +		childenv_nr++;
> +	for (i = 0; deltaenv && deltaenv[i]; i++)
> +		childenv_alloc++;
> +	/* Add one for the NULL termination */
> +	childenv_alloc += childenv_nr + 1;
> +
> +	childenv = xcalloc(childenv_alloc, sizeof(char *));
> +	memcpy(childenv, environ, childenv_nr * sizeof(char *));
> +
> +	/* merge in deltaenv */
> +	for (i = 0; deltaenv && deltaenv[i]; i++)
> +		childenv_nr = do_putenv(childenv, childenv_nr, deltaenv[i]);
> +
> +	return childenv;
> +}

This potentially copies around most of 'environ' several times as it
adjusts for each deltaenv item. Can it be simplified? E.g.

	struct argv_array result = ARGV_ARRAY_INIT;
	struct string_list mods = STRING_LIST_INIT_DUP;
	struct strbuf key = STRBUF_INIT;
	const char **p;

	for (p = cmd_env; *p; p++) {
		const char *equals = strchr(*p, '=');
		if (equals) {
			strbuf_reset(&key);
			strbuf_add(&key, *p, equals - *p);
			string_list_append(&mods, key.buf)->util = *p;
		} else {
			string_list_append(&mods, *p);
		}
	}
	string_list_sort(&mods);

	for (p = environ; *p; p++) {
		struct string_list_item *item;
		const char *equals = strchr(*p, '=');
		if (!equals)
			continue;
		strbuf_reset(&key);
		strbuf_add(&key, *p, equals - *p);
		item = string_list_lookup(&mods, key.buf);

		if (!item) /* no change */
			argv_array_push(&result, *p);
		else if (!item->util) /* unsetenv */
			; /* skip */
		else /* setenv */
			argv_array_push(&result, item->util);
	}

	strbuf_release(&key);
	string_list_clear(&mods);
	return argv_array_detach(&result);

If the string_list API provided a lookup function taking a buffer and
length as argument, the environ loop could be simplified further to
use *p instead of a copy.

Thanks and hope that helps,
Jonathan

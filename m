Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FCCC6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 13:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjCONpI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 09:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjCONor (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 09:44:47 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE7C5FA62
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 06:44:13 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r11so24095562edd.5
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 06:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678887849;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rXOSyMO5Zc1Xb3oX0T2JExEfq0rogcgcJ4tUNcaIBwI=;
        b=cSthlFacnRFrWX4G6V3XnTQgUnIoQZWSplZamsFUiMCRnPIYja8u5oO55G6bCXGJ9D
         9WdvBXY1uWVgI6XgF3/PQZdCTWDqRtkXdnP+QF9vxsGDA2642SyTg2m/Dlpo+wP+f5+A
         MQRjara2z9PkV2t5tr8xN2NfeS7XaAWwSGwpP1A0x1C57yzzM4BWHVlPjSSNhyd6ASIG
         pPx3wTwnXeFSSu8asA1RR785c5S59wb7BWVwkI0Xt+W9GBLI94zCbw90hmBcC4YVt9LN
         6Qd5ZhtZh6+6J+zauMShLmvPjNkPDhKme+Ci8QcEfyyIbZwQkYS9A6gqGx4N2tiOf7mz
         +MMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678887849;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXOSyMO5Zc1Xb3oX0T2JExEfq0rogcgcJ4tUNcaIBwI=;
        b=SAdh/KANPNaX5GLYQSdZJ1ZOOyqF4xJw4NURZmFI71MNurC39cZIHtm8HeJxBIlboN
         7rz5KN0JBvc+NYTop5hZ7O3R1XLo750i0pEf9AGuJfPjYRmRYFguWKIiaVdyd4YTE18/
         EUjHM2HUicPk1fpjqXgFCDELBaNBPQeZ1PHdpcE5IqfJwyUFIqQmh3eC9xSRTdnPZZkd
         0iR+eVjjuh9P2jjhkpx5yEZ2fD/WRPjbbhGuvZfPTN4uN8tktRE1MvUFSflCRz6G1A6U
         SoJKhVM/Gl3AJTNrAuA4Zr1wppUvs9yQ6B4YxeXZ3nSk5MFmDME6wQoRsddsNWGBnpZs
         ZJww==
X-Gm-Message-State: AO0yUKUFdn2p1y5E+Ku6QNr2YR6AgX+lk4Ry9SEKnDR090wc5sRA2lSV
        boAnJKTLnl8YlFiD3FPpZ7w=
X-Google-Smtp-Source: AK7set9zf8z6mWpdT+vLsel1YxHQniPjFzodKVcmTKn00GWw6sI5wMr6zWXUpSACvsMY8dLovbLdHA==
X-Received: by 2002:a17:906:6a09:b0:888:b471:8e46 with SMTP id qw9-20020a1709066a0900b00888b4718e46mr7492266ejc.50.1678887848624;
        Wed, 15 Mar 2023 06:44:08 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id m18-20020a17090679d200b008e204a57e70sm2513267ejo.214.2023.03.15.06.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:44:08 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pcRQF-002x9a-1R;
        Wed, 15 Mar 2023 14:44:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 1/8] for-each-ref: add --stdin option
Date:   Wed, 15 Mar 2023 14:37:39 +0100
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
 <a1d9e0f6ff6660c9264673be18bc24956f74eb9c.1678468864.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <a1d9e0f6ff6660c9264673be18bc24956f74eb9c.1678468864.git.gitgitgadget@gmail.com>
Message-ID: <230315.86h6umxh7c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 10 2023, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> When a user wishes to input a large list of patterns to 'git
> for-each-ref' (likely a long list of exact refs) there are frequently
> system limits on the number of command-line arguments.

Okey, and the current API assumes you just assign "argv" to this, but...

> When reading from stdin, we populate the filter.name_patterns array
> dynamically as opposed to pointing to the 'argv' array directly. This
> requires a careful cast while freeing the individual strings,
> conditioned on the --stdin option.

..sounds potentially nasty...

> @@ -75,7 +77,27 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
>  	filter.ignore_case = icase;
>  
> -	filter.name_patterns = argv;
> +	if (from_stdin) {
> +		struct strbuf line = STRBUF_INIT;
> +		size_t nr = 0, alloc = 16;
> +
> +		if (argv[0])
> +			die(_("unknown arguments supplied with --stdin"));
> +
> +		CALLOC_ARRAY(filter.name_patterns, alloc);
> +
> +		while (strbuf_getline(&line, stdin) != EOF) {
> +			ALLOC_GROW(filter.name_patterns, nr + 1, alloc);
> +			filter.name_patterns[nr++] = strbuf_detach(&line, NULL);
> +		}
> +
> +		/* Add a terminating NULL string. */
> +		ALLOC_GROW(filter.name_patterns, nr + 1, alloc);
> +		filter.name_patterns[nr + 1] = NULL;
> +	} else {
> +		filter.name_patterns = argv;
> +	}
> +
>  	filter.match_as_path = 1;
>  	filter_refs(&array, &filter, FILTER_REFS_ALL);
>  	ref_array_sort(sorting, &array);
> @@ -97,5 +119,10 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  	free_commit_list(filter.with_commit);
>  	free_commit_list(filter.no_commit);
>  	ref_sorting_release(sorting);
> +	if (from_stdin) {
> +		for (size_t i = 0; filter.name_patterns[i]; i++)
> +			free((char *)filter.name_patterns[i]);
> +		free(filter.name_patterns);
> +	}
>  	return 0;
>  }

Why do we need to seemingly re-invent a "struct strvec" here? I tried to
simplify this on top of this (well, "seen"), and we can get rid of all
of this manual memory management & trailing NULL juggling as a result:
	
	diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
	index cf5ba6ffc12..13b75eff28c 100644
	--- a/builtin/for-each-ref.c
	+++ b/builtin/for-each-ref.c
	@@ -7,6 +7,7 @@
	 #include "parse-options.h"
	 #include "ref-filter.h"
	 #include "commit-reach.h"
	+#include "strvec.h"
	 
	 static char const * const for_each_ref_usage[] = {
	 	N_("git for-each-ref [<options>] [<pattern>]"),
	@@ -27,6 +28,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
	 	struct ref_format format = REF_FORMAT_INIT;
	 	struct strbuf output = STRBUF_INIT;
	 	struct strbuf err = STRBUF_INIT;
	+	struct strvec stdin_pat = STRVEC_INIT;
	 	int from_stdin = 0;
	 
	 	struct option opts[] = {
	@@ -81,21 +83,13 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
	 
	 	if (from_stdin) {
	 		struct strbuf line = STRBUF_INIT;
	-		size_t nr = 0, alloc = 16;
	 
	 		if (argv[0])
	 			die(_("unknown arguments supplied with --stdin"));
	 
	-		CALLOC_ARRAY(filter.name_patterns, alloc);
	-
	-		while (strbuf_getline(&line, stdin) != EOF) {
	-			ALLOC_GROW(filter.name_patterns, nr + 1, alloc);
	-			filter.name_patterns[nr++] = strbuf_detach(&line, NULL);
	-		}
	-
	-		/* Add a terminating NULL string. */
	-		ALLOC_GROW(filter.name_patterns, nr + 1, alloc);
	-		filter.name_patterns[nr + 1] = NULL;
	+		while (strbuf_getline(&line, stdin) != EOF)
	+			strvec_push(&stdin_pat, line.buf);
	+		filter.name_patterns = stdin_pat.v;
	 	} else {
	 		filter.name_patterns = argv;
	 	}
	@@ -123,10 +117,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
	 	free_commit_list(filter.with_commit);
	 	free_commit_list(filter.no_commit);
	 	ref_sorting_release(sorting);
	-	if (from_stdin) {
	-		for (size_t i = 0; filter.name_patterns[i]; i++)
	-			free(filter.name_patterns[i]);
	-		free(filter.name_patterns);
	-	}
	+	strvec_clear(&stdin_pat);
	 	return 0;
	 }

It *is* an extra copy though, as your implementation re-uses the strbuf
we already allocated.

But presumably that's trivial in this case, and if we care I think we
should resurrect something like [1] instead, i.e. we could just teach
the strvec API to have a strvec_push_nodup(). But I doubt that in this
case it'll matter.

In any case, if you don't want to take this as-is, please fix this so
that we're not reaching into the "filter.name_patterns" and casting its
"const char" to "char".

If we're going to add a hack here that API should instead know how to
free its own resources (so we could clean up the free_commit_list() here
seen in the context), and we could carry some "my argv needs free-ing".

But none of that seems needed in this case, this is just another case
where we can pretend that we have a "normal" argv, and then clean up our
own strvec, no?

1. https://lore.kernel.org/git/65a620b08ef359e29d678497f1b529e3ce6477b1.1673475190.git.gitgitgadget@gmail.com/

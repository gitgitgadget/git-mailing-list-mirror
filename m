Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6103C761A6
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 15:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbjC3Pyj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 11:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjC3Pyi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 11:54:38 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5568E
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 08:54:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id o11so18510760ple.1
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 08:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680191676;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jp6vqRjQM/Q9bsAbLWq/yaHNOe0eUqkRuuaYS17g3pQ=;
        b=ntPgfV+pOVOB1xL537LnDhdNHIjlHisC3IQdIIFICe/rXjwCrtkDHHkQMY/vmZubDL
         R0ppkQ/LjBzwYbl1pxGcCJ2a0JTTfLtnfBgYC9rnXoqg7zFPJyfuWzsPqd9MHIHkCfNp
         P/CvUCp4P9znSNiyLaIVQ290FuHKZmC2D6LtcWx/TFPGm5ta2cgZYC/ghIBDTezqkRew
         LVqy9vk0cKislXhScC2L1EXyrBeaQDeVYX7Fk4VsSNuD/9jczeVqCBxY0p5h5+LY8f2D
         WYWOYpxBVu17fbZaQjlC7qF5FJC9khfv5xllNJ3gZjGx1ezXiWbj+vhJ720O8xxnWN6J
         AjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680191676;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jp6vqRjQM/Q9bsAbLWq/yaHNOe0eUqkRuuaYS17g3pQ=;
        b=Tc1JXrNBanJmh2vUSTZelrc24NSOMhqvrFBwC1hltA1hID+pmWfCxPM44qzEYJ5Nmc
         cuVz30PShVZl5odEgfEmmehSjQr2UjzIiRV/miTQo052minyg8EwwjXmteng2qWdmnr8
         +9jix51PrG4QDrAwnypLTKdRCIkadyGYU4EPPjWCzA8hXuPV0DYt8AuTclROE0EADyrD
         w0e+6DcmF1f9vYNvFvnej6YTDvhjLTHRjGjgfEr4MVcw4rr5Y+TpBvroYHmne4HX/rd1
         Nzy3Ng2CmDNPx/KONjg52KzSHcwROGg7wQ1w25ISoeCeaMerrg1SJ57Nu4/3U5LChyrY
         EcGw==
X-Gm-Message-State: AAQBX9fLyEzteyGjNbRUNWt0/9U9MF0dnodLof+jc8Uw86O7mYTC3y24
        dL+yffXdl0ml2xJumSPg0pg=
X-Google-Smtp-Source: AKy350bEDOgu2Bk919hobaLN+TgbLKAieW/A6tg68u+zV8VbNcjZO8IdAo3TnewElABkE5gIs9SIuQ==
X-Received: by 2002:a17:90a:4f0f:b0:23d:3aa5:5ff3 with SMTP id p15-20020a17090a4f0f00b0023d3aa55ff3mr6799740pjh.14.1680191676457;
        Thu, 30 Mar 2023 08:54:36 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id ep1-20020a17090ae64100b0023cfdbb6496sm3488114pjb.1.2023.03.30.08.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:54:35 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] branch, for-each-ref: add option to omit empty lines
References: <20230330112133.4437-1-oystwa@gmail.com>
        <20230330112133.4437-3-oystwa@gmail.com>
Date:   Thu, 30 Mar 2023 08:54:35 -0700
In-Reply-To: <20230330112133.4437-3-oystwa@gmail.com> (=?utf-8?Q?=22=C3=98?=
 =?utf-8?Q?ystein?= Walle"'s
        message of "Thu, 30 Mar 2023 13:21:33 +0200")
Message-ID: <xmqqilei1bgk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Øystein Walle <oystwa@gmail.com> writes:

> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 6da899c629..0f4fa98b18 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -93,6 +93,11 @@ OPTIONS
>  --ignore-case::
>  	Sorting and filtering refs are case insensitive.
>  
> +-n::
> +--omit-empty-lines::
> +	Do not print a newline after formatted refs where the format expands
> +	to the empty string.

While I can see the utility of the new feature, it is unclear if its
merit is so clear that it deserves a short-and-sweet single letter
option from the get go.  Especially, don't we want to give this to
"git branch" and "git tag" in their listing modes for consistency,
but it means stealing "-n" also from them.

> @@ -757,7 +761,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	if (list)
> +	{

Move that opening brace at the end of the previous line, i.e.

-	if (list)
+	if (list) {

> +		if (omit_empty_lines && !format.format) {
> +			error("--omit-empty-lines without --format does not make sense");
> +			usage_with_options(builtin_branch_usage, options);
> +		}

Does it not make sense?  With the default format, it may happen that
there will be no empty line so there is nothing to omit, but I do
not see a strong reason to forbid the request like this.

>  		setup_auto_pager("branch", 1);
> +	}
>  
>  	if (delete) {
>  		if (!argc)
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 6f62f40d12..349c4d4ef8 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -19,7 +19,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  	int i;
>  	struct ref_sorting *sorting;
>  	struct string_list sorting_options = STRING_LIST_INIT_DUP;
> -	int maxcount = 0, icase = 0;
> +	int maxcount = 0, icase = 0, omit_empty_lines = 0;
>  	struct ref_array array;
>  	struct ref_filter filter;
>  	struct ref_format format = REF_FORMAT_INIT;
> @@ -35,6 +35,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  			N_("quote placeholders suitably for python"), QUOTE_PYTHON),
>  		OPT_BIT(0 , "tcl",  &format.quote_style,
>  			N_("quote placeholders suitably for Tcl"), QUOTE_TCL),
> +		OPT_BOOL('n' , "omit-empty-lines",  &omit_empty_lines,
> +			N_("do not output a newline after empty formatted refs")),
>  
>  		OPT_GROUP(""),
>  		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
> @@ -55,8 +57,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  	memset(&array, 0, sizeof(array));
>  	memset(&filter, 0, sizeof(filter));
>  
> -	format.format = "%(objectname) %(objecttype)\t%(refname)";
> -
>  	git_config(git_default_config, NULL);
>  	parse_options(argc, argv, prefix, opts, for_each_ref_usage, 0);

This smells fishy.  We establish the hardcoded built-in default, let
the config machinery override, and then finally let command line
options to further override.  You may be able to reach the same end
result by leaving the value unset, fill with the configured value,
override with the command line, and then if the value is still
unset, fall back to a hardcoded built-in default, but I do not see
why such a change logically belongs to a patch to add "--omit-empty"
feature.

> @@ -68,6 +68,12 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  		error("more than one quoting style?");
>  		usage_with_options(for_each_ref_usage, opts);
>  	}
> +	if (omit_empty_lines && !format.format) {
> +		error("--omit-empty-lines without --format does not make sense");
> +		usage_with_options(for_each_ref_usage, opts);
> +	}

I wouldn't do this, for the same reason as for "git branch".

> +	if (!format.format)
> +		format.format = "%(objectname) %(objecttype)\t%(refname)";

This is the other half of the earlier change I called "fishy".  It
may be benign, but it is distracting, especially when done without
explanation, in a change to add a feature that is not related.

> @@ -88,7 +94,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  		if (format_ref_array_item(array.items[i], &format, &output, &err))
>  			die("%s", err.buf);
>  		fwrite(output.buf, 1, output.len, stdout);
> -		putchar('\n');
> +		if (!omit_empty_lines || output.len > 0)
> +			putchar('\n');
>  	}

OK, but two points.

 * do not compare output.len with 0; it is sufficient to just write

	if (!omit_empty || output.len)

 * now we care if output is empty anyway, perhaps we can optimize
   out fwrite() too, perhaps with something like

	if (output.len || !omit_empty)
		printf("%.*s\n", output.len, output.buf);

   perhaps?

I am not sure about the latter, but we tend to use "%.*s" liberally
when we could use fwrite() in our codebase for brevity, so ...

> +test_expect_success 'git branch --format --omit-empty-lines' '
> +	cat >expect <<-\EOF &&
> +	Refname is (HEAD detached from fromtag)
> +	Refname is refs/heads/ambiguous
> +	Refname is refs/heads/branch-one
> +	Refname is refs/heads/branch-two
> +	EOF
> +	echo >>expect &&
> +	cat >>expect <<-\EOF &&
> +	Refname is refs/heads/ref-to-branch
> +	Refname is refs/heads/ref-to-remote
> +	EOF

It is hard to see that there is an empty line expected when the
expectation is prepared like this.  Why not something like

	cat >expect.full <<-\EOF &&
	one
	two

	four (three is missing)
	EOF
	sed -e "/^$/d" expect.full >expect.stripped &&

	git branch $args >actual &&
	test_cmp expect.full actual &&

	git branch --omit-empty $args >actual &&
	test_cmp expect.stripped actual &&

that highlights the fact that there is a missing line for one
expectation, and that the only difference in two expectations is the
lack of empty line(s)?

> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index c466fd989f..eec9d45513 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -1374,6 +1374,14 @@ test_expect_success 'for-each-ref --ignore-case ignores case' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'for-each-ref --omit-empty-lines works' '
> +	git for-each-ref --format="%(refname)" > actual &&
> +	test_line_count -gt 1 actual &&

The next test depends on that a branch 'main' exists, so perhaps
that should be tested here, at least?  And then if there is no other
branches and tags, we cannot tell if seeing only the 'main' branch
is due to --omit-empty correctly working, or due to the repository
having only that branch, so it is also good to check if there is
branches or tags other than 'main' in the output.

> +	git for-each-ref --format="%(if:equals=refs/heads/main)%(refname)%(then)%(refname)%(end)" --omit-empty-lines > actual &&
> +	echo refs/heads/main > expect &&
> +	test_cmp expect actual
> +'

By the way, lose SP between redirection operator '>' and its target,
i.e. write them like so:

	echo refs/heads/main >expect

This feature makes %(if)...%(else)...%(end) construct complete and
is a very good addition.

Thanks for working on it.


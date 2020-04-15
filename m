Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04897C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 17:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5BD320784
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 17:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZBq3dh9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410969AbgDORYr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:24:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59345 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410956AbgDORYn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 13:24:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FC394A408;
        Wed, 15 Apr 2020 13:24:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=feinvCltAr3Jjn1IpS39UkbjrIs=; b=ZBq3dh
        9QjQEojjP3cjx89wYQBxaciq5dWCcJeutnz9wF9C0jWFh+PLNekghKQU0M0D6yPT
        oBUzUDgDqFbIzEO3oMYBFa4cpjQBddZlD2ZmStf0zO5moGJZYQM3KHmkyf98Iu75
        UNlVWRoTcotvAioRcHrfYD0oDknxWAuhCCPhE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dHfr4irlRnPpe/9pJTQYMni2N9Lo6GCD
        CoihBieEtJqV9a1gS6mAKQiJPsK3+y6/AbnU07Yskls4HfcflxpkfYs2MGM7V/Cr
        75ZrhA37vUSKbu/5fJa9CtKCwLqIpEC6+iiI6/gAIN7P2tiTQGpwJUT8V3vH72xm
        fo2i2RIHYA0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 96C3D4A407;
        Wed, 15 Apr 2020 13:24:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 018A44A404;
        Wed, 15 Apr 2020 13:24:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sluongng@gmail.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2] log: add log.excludeDecoration config option
References: <pull.610.git.1586791720114.gitgitgadget@gmail.com>
        <pull.610.v2.git.1586965463222.gitgitgadget@gmail.com>
Date:   Wed, 15 Apr 2020 10:24:33 -0700
In-Reply-To: <pull.610.v2.git.1586965463222.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Wed, 15 Apr 2020 15:44:22
        +0000")
Message-ID: <xmqqftd47jce.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F948CD4C-7F3D-11EA-AA23-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Add the 'log.excludeDecoration' config option so users can exclude
> some refs from decorations by default instead of needing to use
> --decorate-refs-exclude manually. The config value is multi-valued
> much like the command-line option. The documentation is careful to
> point out that the config value can be overridden by the
> --decorate-refs option, even though --decorate-refs-exclude would
> always "win" over --decorate-refs.
>
> Since the 'log.excludeDecoration' takes lower precedence to
> --decorate-refs, and --decorate-refs-exclude takes higher
> precedence, the struct decoration_filter needed another field.
> This led also to new logic in load_ref_decorations() and
> ref_filter_match().

All of the above makes sense to me.

> diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
> index e9e1e397f3f..1a158324f79 100644
> --- a/Documentation/config/log.txt
> +++ b/Documentation/config/log.txt
> @@ -18,6 +18,11 @@ log.decorate::
>  	names are shown. This is the same as the `--decorate` option
>  	of the `git log`.
>  
> +log.excludeDecoration::
> +	Exclude the specified patterns from the log decorations. This multi-
> +	valued config option is the same as the `--decorate-refs-exclude`
> +	option of `git log`.

Can the config still be "the same as" that option, though, with the
new "unlike --decorate-refs-exclude that always wins, config is at
the lowest precedence" rule?

> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index bed09bb09e5..17592234ba4 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -43,7 +43,10 @@ OPTIONS
>  	If no `--decorate-refs` is given, pretend as if all refs were
>  	included.  For each candidate, do not use it for decoration if it
>  	matches any patterns given to `--decorate-refs-exclude` or if it
> -	doesn't match any of the patterns given to `--decorate-refs`.
> +	doesn't match any of the patterns given to `--decorate-refs`. The
> +	`log.excludeDecoration` config option allows excluding refs from
> +	the decorations, but an explicit `--decorate-refs` pattern will
> +	override a match in `log.excludeDecoration`.

This description does make sense.

> diff --git a/log-tree.c b/log-tree.c
> index 52127427ffe..bd8d4c07bb8 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -90,7 +90,8 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
>  
>  	if (filter && !ref_filter_match(refname,
>  			      filter->include_ref_pattern,
> -			      filter->exclude_ref_pattern))
> +			      filter->exclude_ref_pattern,
> +			      filter->exclude_ref_config_pattern))
>  		return 0;

As there is only one caller of the ref_filter_match() helper, I
wonder if we want to

 (1) move the helper to log-tree.c, make it static and remove its
     definition from refs.h, and optionally rename it so that it is
     clear that this is not part of the "ref_filter" API that drives
     "for-each-ref" and friends;

 (2) instead of adding yet another pattern to the parameter list,
     make the helper take the whole "filter" instance as a single
     parameter.

as a clean-up.

> diff --git a/refs.c b/refs.c
> index 1ab0bb54d3d..63d8b569333 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -339,9 +339,11 @@ static int match_ref_pattern(const char *refname,
>  
>  int ref_filter_match(const char *refname,
>  		     const struct string_list *include_patterns,
> -		     const struct string_list *exclude_patterns)
> +		     const struct string_list *exclude_patterns,
> +		     const struct string_list *exclude_patterns_config)
>  {
>  	struct string_list_item *item;
> +	int found = 0;
>  
>  	if (exclude_patterns && exclude_patterns->nr) {
>  		for_each_string_list_item(item, exclude_patterns) {
> @@ -351,7 +353,6 @@ int ref_filter_match(const char *refname,
>  	}
>  
>  	if (include_patterns && include_patterns->nr) {
> -		int found = 0;
>  		for_each_string_list_item(item, include_patterns) {
>  			if (match_ref_pattern(refname, item)) {
>  				found = 1;
> @@ -362,6 +363,16 @@ int ref_filter_match(const char *refname,
>  		if (!found)
>  			return 0;
>  	}
> +
> +	if (!found &&
> +	    exclude_patterns_config &&
> +	    exclude_patterns_config->nr) {
> +		for_each_string_list_item(item, exclude_patterns_config) {
> +			if (match_ref_pattern(refname, item))
> +				return 0;
> +		}
> +	}

Hmph.  Do we still need "found" here?  If there are include patterns
given explicitly from the command line, a ref MUST match one of them
in order to be included, and a ref that matches one of them will be
included no matter that exclude config says.

So shouldn't the updated logic for the include patterns part be more
like

	if (include_patterns is not empty) {
		for_each_string_list_item(item, include_patterns) {
			if (matches)
				return 1; /* matches */
		}
		return 0; /* did not match */
	}

Then the new code to deal with "config", which will come after the
"include" thing, will only have to deal with the case where there is
no include patterns given from the command line.  And when the
control reaches there, we need to do exactly the same thing as we do
to the commad line excludes, i.e. see if any of the config patterns
match, and say "reject" if we find a match.

And after the loop for the exclude config fails to "return 0" early,
we will hit the "return 1" at the end.

Had I butchered the logic somehow?

>  /*
> + * Returns 0 if the refname matches any of the exclude_patterns.
> + *
> + * Returns 0 if include_patterns is non-empty but refname does not match
> + * any of those patterns.
> + *
> + * Returns 0 if refname matches a pattern in exclude_patterns_config but
> + * does not match any pattern in inclue_patterns.
> + *
> + * Otherwise, returns 1.
>   *
>   * This has the effect of matching everything by default, unless the user
>   * specifies rules otherwise.
>   */

The above is not wrong per-se, but feels somewhat roundabout way to
define what it does, from the viewpoint of somebody who may want to
call or understand it.  "What matches one of the exclude patterns is
excluded.  If the include patterns is empty, what did not match
exclude patterns is included unless it matches one of the exclude
configs.  But if the include patterns is not empty, what did not
match exclude patterns is included only if it matches one of the
include patterns."
>  int ref_filter_match(const char *refname,
>  		     const struct string_list *include_patterns,
> -		     const struct string_list *exclude_patterns);
> +		     const struct string_list *exclude_patterns,
> +		     const struct string_list *exclude_patterns_config);
>  
>  static inline const char *has_glob_specials(const char *pattern)
>  {
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 0f766ba65f5..78f9ade6870 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -742,7 +742,23 @@ test_expect_success 'decorate-refs with glob' '
>  	octopus-a (octopus-a)
>  	reach
>  	EOF
> +	cat >expect.no-decorate <<-\EOF &&
> +	Merge-tag-reach
> +	Merge-tags-octopus-a-and-octopus-b
> +	seventh
> +	octopus-b
> +	octopus-a
> +	reach
> +	EOF
> +	git log -n6 --decorate=short --pretty="tformat:%f%d" \
> +		--decorate-refs="heads/octopus*" >actual &&
> +	test_cmp expect.decorate actual &&
>  	git log -n6 --decorate=short --pretty="tformat:%f%d" \
> +		--decorate-refs-exclude="heads/octopus*" \
> +		--decorate-refs="heads/octopus*" >actual &&
> +	test_cmp expect.no-decorate actual &&
> +	git -c log.excludeDecoration="heads/octopus*" log \
> +		-n6 --decorate=short --pretty="tformat:%f%d" \
>  		--decorate-refs="heads/octopus*" >actual &&
>  	test_cmp expect.decorate actual
>  '
> @@ -787,6 +803,9 @@ test_expect_success 'decorate-refs-exclude with glob' '
>  	EOF
>  	git log -n6 --decorate=short --pretty="tformat:%f%d" \
>  		--decorate-refs-exclude="heads/octopus*" >actual &&
> +	test_cmp expect.decorate actual &&
> +	git -c log.excludeDecoration="heads/octopus*" log \
> +		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
>  	test_cmp expect.decorate actual
>  '
>  
> @@ -801,6 +820,9 @@ test_expect_success 'decorate-refs-exclude without globs' '
>  	EOF
>  	git log -n6 --decorate=short --pretty="tformat:%f%d" \
>  		--decorate-refs-exclude="tags/reach" >actual &&
> +	test_cmp expect.decorate actual &&
> +	git -c log.excludeDecoration="tags/reach" log \
> +		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
>  	test_cmp expect.decorate actual
>  '
>  
> @@ -816,11 +838,19 @@ test_expect_success 'multiple decorate-refs-exclude' '
>  	git log -n6 --decorate=short --pretty="tformat:%f%d" \
>  		--decorate-refs-exclude="heads/octopus*" \
>  		--decorate-refs-exclude="tags/reach" >actual &&
> +	test_cmp expect.decorate actual &&
> +	git -c log.excludeDecoration="heads/octopus*" \
> +		-c log.excludeDecoration="tags/reach" log \
> +		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
> +	test_cmp expect.decorate actual &&
> +	git -c log.excludeDecoration="heads/octopus*" log \
> +		--decorate-refs-exclude="tags/reach" \
> +		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
>  	test_cmp expect.decorate actual
>  '
>  
>  test_expect_success 'decorate-refs and decorate-refs-exclude' '
> -	cat >expect.decorate <<-\EOF &&
> +	cat >expect.no-decorate <<-\EOF &&
>  	Merge-tag-reach (master)
>  	Merge-tags-octopus-a-and-octopus-b
>  	seventh
> @@ -831,6 +861,21 @@ test_expect_success 'decorate-refs and decorate-refs-exclude' '
>  	git log -n6 --decorate=short --pretty="tformat:%f%d" \
>  		--decorate-refs="heads/*" \
>  		--decorate-refs-exclude="heads/oc*" >actual &&
> +	test_cmp expect.no-decorate actual
> +'
> +
> +test_expect_success 'deocrate-refs and log.excludeDecoration' '
> +	cat >expect.decorate <<-\EOF &&
> +	Merge-tag-reach (master)
> +	Merge-tags-octopus-a-and-octopus-b
> +	seventh
> +	octopus-b (octopus-b)
> +	octopus-a (octopus-a)
> +	reach (reach)
> +	EOF
> +	git -c log.excludeDecoration="heads/oc*" log \
> +		--decorate-refs="heads/*" \
> +		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
>  	test_cmp expect.decorate actual
>  '
>  
> @@ -846,6 +891,10 @@ test_expect_success 'decorate-refs-exclude and simplify-by-decoration' '
>  	git log -n6 --decorate=short --pretty="tformat:%f%d" \
>  		--decorate-refs-exclude="*octopus*" \
>  		--simplify-by-decoration >actual &&
> +	test_cmp expect.decorate actual &&
> +	git -c log.excludeDecoration="*octopus*" log \
> +		-n6 --decorate=short --pretty="tformat:%f%d" \
> +		--simplify-by-decoration >actual &&
>  	test_cmp expect.decorate actual
>  '
>  
>
> base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7936C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 08:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiLLIea (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 03:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLLIe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 03:34:29 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F42B6151
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 00:34:27 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z92so11808175ede.1
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 00:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=alQML6rpzUdGebAMdmyGEsZ8w6IAqWpmXaLFbdYXIkc=;
        b=IGgx659/9VOmByc83hxni0r5KIzlR4VgGjqseQpapX3uc/CfSV7yGsYABa3b7BMb+A
         f6MdnCcYwrGlUoIRk8P5HZZk2XwsdYPK4QF7Eu6chMuaUxYYUVTex46eRAUXk4ckudd6
         89A3HhMXpCPHFgHyhr6lAYIznTdyp9VJMnIvVXXiinancMR7syz5ywQwbEYibC4tVfUC
         AxeQe8axGdGm0bs84+ZnROzVyTnyN/OcAKl4q0MTu71TjQeu3MIZy1Bjzznd2bS+dVzU
         sl98zVpAI/ieP7/v7vTbR3lX7Gozm3d+XbFR22o2cID3glzkVTTW9st2wZgn4NqPKReT
         iv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alQML6rpzUdGebAMdmyGEsZ8w6IAqWpmXaLFbdYXIkc=;
        b=ykYOaD5kjpQ+pUUi1LmC4C6mOK/ycwivVOS4HGeO5l9AE+6c1Bq/KTt8/h6BvccvbD
         54dQM9lQgSQiszMeE+uOwd9abV/j2P6OOJJK4vU5TAKAEASm61czUKwDnbiNNjoQLh1c
         8wta8Ai8QL6hvqXQDBKpys6PVGSgQlN3hw3lKhRx4cO3J2WUQEfRS9pbxylZWl+6wLPl
         2zRFvpxOSHylfmfmdOWb4EXktJjWAVszOj8esJNahjz3EI08nihNgfI6cFwL9IEw12P1
         OVyqT6Ol4B725Bee85vOI+5hAdfkwbFyZvmYGpd730aDOyXZMMhqK+sif32PdsDc2Rgz
         B0Ow==
X-Gm-Message-State: ANoB5plP13+o4QiEw/mF7BDeljqWjwpIGPoLpr1oCRJN+k0jWa3sNpcg
        WT9tYRpTm+CSUOP9E0BSoF0=
X-Google-Smtp-Source: AA0mqf54x9GGi9f7KztebykuvNVwaoR/V+OhCHg/jr35/D+0ovZPn27mzKLG5ZQq1QzrjGbusAuUyA==
X-Received: by 2002:a05:6402:f24:b0:46d:ca42:2e59 with SMTP id i36-20020a0564020f2400b0046dca422e59mr13755866eda.11.1670834065226;
        Mon, 12 Dec 2022 00:34:25 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id l8-20020a056402344800b0045d74aa401fsm3498743edc.60.2022.12.12.00.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 00:34:24 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p4eGW-005CjE-08;
        Mon, 12 Dec 2022 09:34:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v4 2/3] worktree add: add --orphan flag
Date:   Mon, 12 Dec 2022 09:11:25 +0100
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev>
 <20221212014003.20290-1-jacobabel@nullpo.dev>
 <20221212014003.20290-3-jacobabel@nullpo.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221212014003.20290-3-jacobabel@nullpo.dev>
Message-ID: <221212.86tu2158bz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 12 2022, Jacob Abel wrote:

> +static int make_worktree_orphan(const char * ref, const struct add_opts *opts,
> +				struct strvec *child_env)
> +{
> +	int ret;

You can avoid this variable entirely....

> +	struct strbuf symref = STRBUF_INIT;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	cp.git_cmd = 1;

(aside: We usually split up variables & decls, I think this is better
right before the run_command() line).
> +
> +	validate_new_branchname(ref, &symref, 0);
> +	strvec_pushl(&cp.args, "symbolic-ref", "HEAD", symref.buf, NULL);

...by just calling strbuf_release(&symref); right after this line, we'll
never need it again, and the strvec will have its own copy.

> +	if (opts->quiet)
> +		strvec_push(&cp.args, "--quiet");
> +	strvec_pushv(&cp.env, child_env->v);

So:

> +	ret = run_command(&cp);
> +	strbuf_release(&symref);
> +	return ret;

We don't have to carry the "ret" here, and can just do:

	return run_command(&cp);

> +}
> +
>  static int add_worktree(const char *path, const char *refname,
>  			const struct add_opts *opts)
>  {
> @@ -393,8 +415,9 @@ static int add_worktree(const char *path, const char *refname,
>  			die_if_checked_out(symref.buf, 0);
>  	}
>  	commit = lookup_commit_reference_by_name(refname);
> -	if (!commit)
> +	if (!commit && !opts->orphan) {
>  		die(_("invalid reference: %s"), refname);
> +	}

We don't add {}'s for one-statement if's like this, see
CodingGuidelines. So skip the {}'s.

>
>  	name = worktree_basename(path, &len);
>  	strbuf_add(&sb, name, path + len - name);
> @@ -482,10 +505,10 @@ static int add_worktree(const char *path, const char *refname,
>  	strvec_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
>  	cp.git_cmd = 1;
>
> -	if (!is_branch)
> +	if (!is_branch && commit) {
>  		strvec_pushl(&cp.args, "update-ref", "HEAD",
>  			     oid_to_hex(&commit->object.oid), NULL);
> -	else {
> +	} else {

Here that style change is good, even if it inflates the diff size a
litte bit with the while-at-it fixu-up.

> +	/*
> +	 * When creating a new branch, new_branch now contains the branch to
> +	 * create.
> +	 *
> +	 * Past this point, new_branch_force can be treated solely as a
> +	 * boolean flag to indicate whether `-B` was selected.
> +	 */
>  	if (new_branch_force) {
>  		struct strbuf symref = STRBUF_INIT;
>

I think I commented on this commentary in an earlier round. IMO it could
just be omitted, as the code is rather self-explanatory.

To the extent that it isn't this commentary just makes things more
confusing, at least to my reading. It's not explaining what the code is
doing now, because the very next line after this context (omitted here) is:

	new_branch = new_branch_force

So we're saying it "can be treated solely as a boolean flag", but it
isn't being treated as such by the code now.

And the "new_branch now contains the branch to create" is also
inaccurate, we're about to make it true with that assignment, but (and
again, I don't think a comment is needed at all) *if* we think that's
worth commenting on then surely the first paragraph of the comment
should be split off, and come just before that assignment.

> -	if (new_branch) {
> +	if (opts.orphan) {
> +		branch = new_branch;
> +	} else if (!lookup_commit_reference_by_name(branch)) {
> +		/*
> +		 * If `branch` does not reference a valid commit, a new
> +		 * worktree (and/or branch) cannot be created based off of it.
> +		 */

I think with the advice added in 3/3 this comment can also just be
omitted here, as the end result is that the comment will be
re-explaining something which should be obvious from the inline advice
string (and if it isn't, that inline string needs improving).

> -test_expect_success '"add" -b/-B mutually exclusive' '
> -	test_must_fail git worktree add -b poodle -B poodle bamboo main
> -'
> -
> -test_expect_success '"add" -b/--detach mutually exclusive' '
> -	test_must_fail git worktree add -b poodle --detach bamboo main
> -'
> +# Helper function to test mutually exclusive options.
> +test_wt_add_excl() {
> +	local opts="$@" &&
> +	test_expect_success "'worktree add' with '$opts' has mutually exclusive options" '
> +		test_must_fail git worktree add $opts
> +	'
> +}
>
> -test_expect_success '"add" -B/--detach mutually exclusive' '
> -	test_must_fail git worktree add -B poodle --detach bamboo main
> -'
> +test_wt_add_excl -b poodle -B poodle bamboo main
> +test_wt_add_excl -b poodle --orphan poodle bamboo
> +test_wt_add_excl -b poodle --detach bamboo main
> +test_wt_add_excl -B poodle --detach bamboo main
> +test_wt_add_excl -B poodle --detach bamboo main
> +test_wt_add_excl -B poodle --orphan poodle bamboo
> +test_wt_add_excl --orphan poodle --detach bamboo
> +test_wt_add_excl --orphan poodle --no-checkout bamboo
> +test_wt_add_excl --orphan poodle bamboo main

It's good to see this as a helper function, but I think it would be nice
to have this split up into its own pre-refactoring commit.

As here we're changing some existing tests that are per-se unrelated,
just so that they can use this new helper.

This commit could then add tests that use the helper, and which are new
for --orphan.

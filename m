Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631BAC05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 13:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjAWNZV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 08:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjAWNZT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 08:25:19 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B607824135
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 05:25:17 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id az20so30489683ejc.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 05:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Vka5j7voQ+/trBMyXKpT0Rt9VR4kvddu0XTyp7IrrE=;
        b=cjd14fJ+2cfEvFh5b/lLM9KHhoNA1yLOysxUFv2yoNLsP0Gelb5jD+lOeuCqgJdOEV
         Pg36tQBE0TEynS6qYKis1QwiVOVeHB0sD8pnRI3CGxUrfN+PfdHbgl9wKjIIF/G+z2Um
         37w4Mi6xzKDNBBPtH++Vkfn0tk4/PG7AcvDtT+Ey2aLpwbY9jtQLb2tbET4zSMb/nqBQ
         LQkz/GSLszvRFqq5Psupm7ksMT+PVwJgmYDwh6ENSFVz2yZ3vKkvzEE3zZ6MTfX24JaC
         Z1+skjdpcUC7kAo0eUqABW1TlRw2tLc60gLZIa4qVQxa5xJzErFh4x1FiM2EdpLW36hf
         pkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Vka5j7voQ+/trBMyXKpT0Rt9VR4kvddu0XTyp7IrrE=;
        b=7ICEgkTGZTSX7kLU/CTZtl89RG5LUyF6Q6aAFsZieuvTXsN6S3FXXG315NhYPtNMGM
         eWhW0wWJ/BFT+eKzU2105xQdcl2j7KwgRsjwPPVml1MCAdLHXT3EwBz+HWbY1SyjKXSr
         7GOOktS1m6g6GlwiF+o8s57pC/93WnIm9ClKmq5dlKZ4v6aeyZhBmkbf1P5UoyfbfsrW
         dcQLhFBvUU0he2Oj+6H+KQwXrECa47sU3qA7E0rLq5vsrivsZXN49Fa8gZMhG3onS6eu
         bN7KLWqBD0FDQ4PohY9vuL8wJFMeB+7zIKiCYzLPe1oBOvBP9jUz5/0vityatxF1UvVB
         KkNQ==
X-Gm-Message-State: AFqh2kreonUp6m4jrhbCzLUDjlqhP2+NzTPMG3Ex8AX1MVlwOREKCkuD
        l7IJn3DBqgywk6S2ujq9j1QnqVhxS2w=
X-Google-Smtp-Source: AMrXdXtrEsOgFQ7uu1tWq5fFmi+wUCXs0jzrAaQ+jzb78eB5OBQ3mhmwAaDZ6Pfzqk8iMQ7cMKMWew==
X-Received: by 2002:a17:906:644f:b0:877:6549:bb6 with SMTP id l15-20020a170906644f00b0087765490bb6mr19416146ejn.58.1674480315724;
        Mon, 23 Jan 2023 05:25:15 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id b2-20020a17090630c200b00780b1979adesm21956624ejb.218.2023.01.23.05.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 05:25:15 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pJwp0-0009Jv-2P;
        Mon, 23 Jan 2023 14:25:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        William Sprent <williams@unity3d.com>
Subject: Re: [PATCH v2] ls-tree: add --sparse-filter-oid argument
Date:   Mon, 23 Jan 2023 14:06:10 +0100
References: <pull.1459.git.1673456518993.gitgitgadget@gmail.com>
 <pull.1459.v2.git.1674474371817.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <pull.1459.v2.git.1674474371817.gitgitgadget@gmail.com>
Message-ID: <230123.861qnltmbp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 23 2023, William Sprent via GitGitGadget wrote:

> From: William Sprent <williams@unity3d.com>

...some further inline commentary, in addition to my proposed squash-in...

> diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
> index 0240adb8eec..724bb1f9dbd 100644
> --- a/Documentation/git-ls-tree.txt
> +++ b/Documentation/git-ls-tree.txt
> @@ -11,6 +11,7 @@ SYNOPSIS
>  [verse]
>  'git ls-tree' [-d] [-r] [-t] [-l] [-z]
>  	    [--name-only] [--name-status] [--object-only] [--full-name] [--full-tree] [--abbrev[=<n>]] [--format=<format>]
> +	    [--sparse-filter-oid=<blob-ish>]
>  	    <tree-ish> [<path>...]
>  
>  DESCRIPTION
> @@ -48,6 +49,11 @@ OPTIONS
>  	Show tree entries even when going to recurse them. Has no effect
>  	if `-r` was not passed. `-d` implies `-t`.
>  
> +--sparse-filter-oid=<blob-ish>::
> +	Omit showing tree objects and paths that do not match the
> +	sparse-checkout specification contained in the blob
> +	(or blob-expression) <blob-ish>.
> +
>  -l::
>  --long::
>  	Show object size of blob (file) entries.
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 72eb70823d5..46a815fc7dc 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -13,6 +13,7 @@
>  #include "builtin.h"
>  #include "parse-options.h"
>  #include "pathspec.h"
> +#include "dir.h"
>  
>  static const char * const ls_tree_usage[] = {
>  	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
> @@ -364,6 +365,65 @@ static struct ls_tree_cmdmode_to_fmt ls_tree_cmdmode_format[] = {
>  	},
>  };

Okey, here yo uupdate the *.txt, but not the "-h", but it's one of those
where way say <options>.

I for one wouldn't mind some preceding change like my 423be1f83c5 (doc
txt & -h consistency: make "commit" consistent, 2022-10-13), which in
turn would make t/t0450-txt-doc-vs-help.sh pass for this command, but
maybe it's too much of a digression...

> +	(*d) = xcalloc(1, sizeof(**d));
> +	(*d)->fn = fn;
> +	(*d)->pl.use_cone_patterns = core_sparse_checkout_cone;

I forgot to note in my proposed fix-up that I omitted this, but your
tests still pass, which suggests it's either not needed, or your tests
are lacking....

> +	(*d)->options = options;
> +	strbuf_init(&(*d)->full_path_buf, 0);
> +
> +	if (get_oid_with_context(the_repository, sparse_oid_name, GET_OID_BLOB,
> +			&sparse_oid, &oc))
> +		die(_("unable to access sparse blob in '%s'"), sparse_oid_name);
> +	if (add_patterns_from_blob_to_list(&sparse_oid, "", 0, &(*d)->pl) < 0)

As noted you can avoid the malloc here, which also sidesteps this (IMO
at last) ugly &(*v)->m syntax.

> +		die(_("unable to parse sparse filter data in %s"),
> +		    oid_to_hex(&sparse_oid));
> +}
> +
> +static void free_sparse_filter_data(struct sparse_filter_data *d)
> +{
> +	clear_pattern_list(&d->pl);
> +	strbuf_release(&d->full_path_buf);
> +	free(d);
> +}
> +
> +static int path_matches_sparse_checkout_patterns(struct strbuf *full_path, struct pattern_list *pl, int dtype)
> +{
> +	enum pattern_match_result match = recursively_match_path_with_sparse_patterns(full_path->buf, the_repository->index, dtype, pl);

I for one would welcome e.g. abbreviating "sparse_checkout_patterns" as
"scp" or whatever throughout, with resulting shortening of very long
lines & identifiers. E.g. for this one "patch_match_scp" or whatever.


> +	struct sparse_filter_data *data = context;
> +

Style: Don't add a \n\n between variable decls,

> +	int do_recurse = show_recursive(data->options, base->buf, base->len, pathname);

Instead add it here, before the code proper.


> +	if (object_type(mode) == OBJ_TREE)
> +		return do_recurse;
> +
> +	strbuf_reset(&data->full_path_buf);

I wondered if we need this after, but we don't, I for one would welcome a fix-up like:
	
	diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
	index 68d6ef675f2..74dfa9a4580 100644
	--- a/builtin/ls-tree.c
	+++ b/builtin/ls-tree.c
	@@ -410,19 +410,21 @@ static int filter_sparse(const struct object_id *oid, struct strbuf *base,
	 			 const char *pathname, unsigned mode, void *context)
	 {
	 	struct sparse_filter_data *data = context;
	-
	 	int do_recurse = show_recursive(data->options, base->buf, base->len, pathname);
	+	int ret = 0;
	+
	 	if (object_type(mode) == OBJ_TREE)
	 		return do_recurse;
	 
	-	strbuf_reset(&data->full_path_buf);
	 	strbuf_addbuf(&data->full_path_buf, base);
	 	strbuf_addstr(&data->full_path_buf, pathname);
	 
	 	if (!path_matches_sparse_checkout_patterns(&data->full_path_buf, &data->pl, DT_REG))
	-			return 0;
	-
	-	return data->fn(oid, base, pathname, mode, data->options);
	+		goto cleanup;
	+	ret = data->fn(oid, base, pathname, mode, data->options);
	+cleanup:
	+	strbuf_reset(&data->full_path_buf);
	+	return ret;
	 }
	 
	 int cmd_ls_tree(int argc, const char **argv, const char *prefix)
	
It's slightly more verbose, and we do end up needlessly reset-ing the
"last" one, but makes it clear that we don't have need for this after
this.

Which to me, also raises the question of why you have this
"full_path_buf" at all. It looks like a memory optimization, as you're
trying to avoid a malloc()/free() in the loop.

That's fair, but you could also do that with:

	const size_t oldlen = base->len;
	strbuf_addstr(base, pathname);
        /* do the path_matches_sparse_checkout_patterns() call here */
	/* before "cleanup" */
	strbuf_setlen(base, oldlen);

Or whatever, those snippets are untested, but we use similar tricks
elsewhere, and as it's contained to a few lines here I think it's better
than carrying another buffer.

> +	strbuf_addbuf(&data->full_path_buf, base);
> +	strbuf_addstr(&data->full_path_buf, pathname);

Nit: Shorter as: strbuf_addf(&sb, "%s%s", base.buf, pathname) (or equivalent);

> +
> +	if (!path_matches_sparse_checkout_patterns(&data->full_path_buf, &data->pl, DT_REG))
> +			return 0;
> +
> +	return data->fn(oid, base, pathname, mode, data->options);
> +}
> +
>  int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>  {
>  	struct object_id oid;
> @@ -372,7 +432,11 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>  	read_tree_fn_t fn = NULL;
>  	enum ls_tree_cmdmode cmdmode = MODE_DEFAULT;
>  	int null_termination = 0;
> +

Don't add this stray \n.

>  	struct ls_tree_options options = { 0 };
> +	char *sparse_oid_name = NULL;
> +	void *read_tree_context = NULL;
> +	struct sparse_filter_data *sparse_filter_data = NULL;
>  	const struct option ls_tree_options[] = {
>  		OPT_BIT('d', NULL, &options.ls_options, N_("only show trees"),
>  			LS_TREE_ONLY),
> @@ -399,6 +463,9 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>  					 N_("format to use for the output"),
>  					 PARSE_OPT_NONEG),
>  		OPT__ABBREV(&options.abbrev),
> +		OPT_STRING_F(0, "filter-sparse-oid", &sparse_oid_name, N_("filter-sparse-oid"),

Make that N_(...) be "object-id", "oid", "hash" or something?

I.e. the RHS with the <type> should be <thingy>, not
<thingy-for-some-purpose>.

> +			   N_("filter output with sparse-checkout specification contained in the blob"),
> +			     PARSE_OPT_NONEG),
>  		OPT_END()
>  	};
>  	struct ls_tree_cmdmode_to_fmt *m2f = ls_tree_cmdmode_format;
> @@ -474,7 +541,17 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>  		break;
>  	}
>  
> -	ret = !!read_tree(the_repository, tree, &options.pathspec, fn, &options);
> +	if (sparse_oid_name) {
> +		init_sparse_filter_data(&sparse_filter_data, &options, sparse_oid_name, fn);
> +		read_tree_context = sparse_filter_data;
> +		fn = filter_sparse;
> +	} else
> +		read_tree_context = &options;

You're missing a {} here for the "else".

Better yet, delete that "else" and change the decl above to be:

	void *context = &options;

Then just keep the "if" here, where you might clobber the "context".

> +
> +	ret = !!read_tree(the_repository, tree, &options.pathspec, fn, read_tree_context);
>  	clear_pathspec(&options.pathspec);
> +	if (sparse_filter_data)
> +		free_sparse_filter_data(sparse_filter_data);

I suggested a fixup for this, but as an aside don't make a free_*()
function that's not happy to accept NULL, it should work like the free()
itself.

> +
>  	return ret;
>  }
> diff --git a/dir.c b/dir.c
> index 4e99f0c868f..122ebced08e 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1457,45 +1457,50 @@ int init_sparse_checkout_patterns(struct index_state *istate)
>  	return 0;
>  }
>  
> -static int path_in_sparse_checkout_1(const char *path,
> -				     struct index_state *istate,
> -				     int require_cone_mode)
> +int recursively_match_path_with_sparse_patterns(const char *path,
> +						struct index_state *istate,
> +						int dtype,
> +						struct pattern_list *pl)
>  {
> -	int dtype = DT_REG;
>  	enum pattern_match_result match = UNDECIDED;
>  	const char *end, *slash;
> -
> -	/*
> -	 * We default to accepting a path if the path is empty, there are no
> -	 * patterns, or the patterns are of the wrong type.
> -	 */
> -	if (!*path ||
> -	    init_sparse_checkout_patterns(istate) ||
> -	    (require_cone_mode &&
> -	     !istate->sparse_checkout_patterns->use_cone_patterns))
> -		return 1;
> -
>  	/*
>  	 * If UNDECIDED, use the match from the parent dir (recursively), or
>  	 * fall back to NOT_MATCHED at the topmost level. Note that cone mode
>  	 * never returns UNDECIDED, so we will execute only one iteration in
>  	 * this case.
>  	 */
> -	for (end = path + strlen(path);
> -	     end > path && match == UNDECIDED;
> +	for (end = path + strlen(path); end > path && match == UNDECIDED;

All good, aside from this whitespace refactoring, as noted.

>  	     end = slash) {
> -
>  		for (slash = end - 1; slash > path && *slash != '/'; slash--)
>  			; /* do nothing */
>  
>  		match = path_matches_pattern_list(path, end - path,
>  				slash > path ? slash + 1 : path, &dtype,
> -				istate->sparse_checkout_patterns, istate);
> +				pl, istate);
>  
>  		/* We are going to match the parent dir now */
>  		dtype = DT_DIR;
>  	}
> -	return match > 0;
> +
> +	return match;
> +}
> +
> +static int path_in_sparse_checkout_1(const char *path,
> +				     struct index_state *istate,
> +				     int require_cone_mode)
> +{
> +	/*
> +	 * We default to accepting a path if the path is empty, there are no
> +	 * patterns, or the patterns are of the wrong type.
> +	 */
> +	if (!*path ||
> +	    init_sparse_checkout_patterns(istate) ||
> +	    (require_cone_mode &&
> +	     !istate->sparse_checkout_patterns->use_cone_patterns))
> +		return 1;
> +
> +	return recursively_match_path_with_sparse_patterns(path, istate, DT_REG, istate->sparse_checkout_patterns) > 0;

All good, except for the really long line, aside from the previous
suggestion, maybe pull "istate->sparse_checkout_patterns" into a
variable, as it's now used twice here in this function?

> +check_agrees_with_ls_files () {
> +	REPO=repo  &&
> +	git -C $REPO submodule deinit -f --all &&
> +	git -C $REPO cat-file -p $filter_oid >"$REPO/.git/info/sparse-checkout" &&
> +	git -C $REPO sparse-checkout init --cone &&
> +	git -C $REPO submodule init &&
> +	git -C $REPO ls-files -t >out &&
> +	sed -n "/^S /!s/^. //p" out >expect &&
> +	test_cmp expect actual

Instead of this last "sed" munging, why not use the "--format" option to
"ls-tree" to just make the output the same?

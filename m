Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0FAB676
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754065395; cv=none; b=MQ5tqg7WwtwsWqR7JSzqwfYf5jJKoHle+zg8FAySJgim/HbpWJv/8h7j90Z3xF9T5zmvQj5hKmmM36WwtKlULzZ3SM8UgRko5qXWs3Z5vJDsgp+U36S5T2Kt9XK9UJbt/o4G4kZWboz5P08JTThUJHIST88XNZHIhRhNG8BXKOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754065395; c=relaxed/simple;
	bh=JAaSa1AZ+VgIMKqG6T+OyC47VeqelyXcU6TyhpWes24=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W+Sbr4n3Oc9KGoOsjrEIoK0y/b/L5J7beIxkH9QOPjrY/UjjLKuxBEYlgQlK1HbQMrJ25i0GrGzJrdnva3zSx4Lb+nfWcJniKImATVQ71NgCRNJ/o/mhV7VJJcYeCZX/NHyhmHQTNPL/f862gdA6xGBra9c+igWAQQHUboBryr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=gTTZMPDM; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="gTTZMPDM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754065386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CYWgFcbiGr888h1f7k8sXMQvMrqJCwe0CwyTvhd76xU=;
	b=gTTZMPDMlrrf1KcPHciv5uHSJ7eXlzK/o8yst+3GzrFJg+taRaTecCk2MB9s/kEIhxGk5R
	8Pr7/Du17xwgcHg/ZKtEvsfTWUoGJXlj83eUgxDPKNB+eubUIT6Fi4CuIGqvOaLPe9wuBf
	BeELKScRE5rzTOdaqiCcMdNJWRtjqjI=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>, Taylor Blau
 <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, Christian Couder
 <christian.couder@gmail.com>, Jeff King <peff@peff.net>, =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 1/4] last-modified: new subcommand to show when files
 were last modified
In-Reply-To: <aIsQWcHf82ipHoWf@pks.im>
References: <20250716133206.1787549-1-toon@iotcl.com>
 <20250730175510.987383-2-toon@iotcl.com> <aIsQWcHf82ipHoWf@pks.im>
Date: Fri, 01 Aug 2025 18:22:50 +0200
Message-ID: <87ms8jui3p.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Jul 30, 2025 at 07:55:07PM +0200, Toon Claes wrote:
>> diff --git a/Documentation/git-last-modified.adoc b/Documentation/git-last-modified.adoc
>> new file mode 100644
>> index 0000000000..89138ebeb7
>> --- /dev/null
>> +++ b/Documentation/git-last-modified.adoc
>> @@ -0,0 +1,49 @@
>> +git-last-modified(1)
>> +====================
>> +
>> +NAME
>> +----
>> +git-last-modified - EXPERIMENTAL: Show when files were last modified
>> +
>> +
>> +SYNOPSIS
>> +--------
>> +[synopsis]
>> +git last-modified [-r] [-t] [<revision-range>] [[--] <path>...]
>
> I think we typically list long options here, not the short single-letter
> ones.

Okay, makes sense.

>> +
>> +DESCRIPTION
>> +-----------
>> +
>> +Shows which commit last modified each of the relevant files and subdirectories.
>> +
>> +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
>> +
>> +OPTIONS
>> +-------
>> +
>> +-r::
>
> -r, --recursive::
>
>> +	Recurse into subtrees.
>> +
>> +-t::
>
> -t, --tree-in-recursive::

Sure!

>> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
>> new file mode 100644
>> index 0000000000..e4c73464c7
>> --- /dev/null
>> +++ b/builtin/last-modified.c
> [snip]
>> +static int populate_paths_from_revs(struct last_modified *lm)
>> +{
>> +	int num_interesting = 0;
>> +	struct diff_options diffopt;
>> +
>> +	memcpy(&diffopt, &lm->rev.diffopt, sizeof(diffopt));
>> +	copy_pathspec(&diffopt.pathspec, &lm->rev.diffopt.pathspec);
>> +	/*
>> +	 * Use a callback to populate the paths from revs
>> +	 */
>> +	diffopt.output_format = DIFF_FORMAT_CALLBACK;
>> +	diffopt.format_callback = add_path_from_diff;
>> +	diffopt.format_callback_data = lm;
>
> I feel like this whole block could use a comment that explains what
> we're doing. Why do we copy `diffopt` around? 

I can extend the comment. We simply don't want to touch the original,
that's why we copy. Do you think it would be better to simply set the
callback before and reset it after?

> Why is it fine to free the struct at the end without unsetting
> `lm->rev.diffopt`? Couldn't that cause a double free?

Oof, that's a good call. In an earlier version it was only calling
clear_pathspec(). But then I got a comment[1] it would be better to call
diff_free(). I must I admit I didn't think it through further. Changing
back to clear_pathspec() seems the most sensible to me.

>> +	for (size_t i = 0; i < lm->rev.pending.nr; i++) {
>> +		struct object_array_entry *obj = lm->rev.pending.objects + i;
>> +
>> +		if (obj->item->flags & UNINTERESTING)
>> +			continue;
>> +
>> +		if (num_interesting++)
>> +			return error(_("last-modified can only operate on one tree at a time"));
>> +
>> +		diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
>> +			      &obj->item->oid, "", &diffopt);
>> +		diff_flush(&diffopt);
>> +	}
>> +	diff_free(&diffopt);
>> +
>> +	return 0;
>> +}
>> +
>> +static void last_modified_emit(struct last_modified *lm,
>> +			       const char *path, const struct commit *commit)
>> +
>> +{
>> +	if (commit->object.flags & BOUNDARY)
>> +		putchar('^');
>> +	printf("%s\t", oid_to_hex(&commit->object.oid));
>> +
>> +	if (lm->rev.diffopt.line_termination)
>> +		write_name_quoted(path, stdout, '\n');
>> +	else
>> +		printf("%s%c", path, '\0');
>> +
>> +	fflush(stdout);
>
> Is there a reason why we have to explicitly flush output? This command
> doesn't have any interactivity with the caller.

Not that I'm aware of, yeah, shouldn't really be needed.

>> +static void last_modified_diff(struct diff_queue_struct *q,
>> +			       struct diff_options *opt UNUSED, void *cbdata)
>> +{
>> +	struct last_modified_callback_data *data = cbdata;
>> +
>> +	for (int i = 0; i < q->nr; i++) {
>> +		struct diff_filepair *p = q->queue[i];
>> +		switch (p->status) {
>> +		case DIFF_STATUS_DELETED:
>> +			/*
>> +			 * There's no point in feeding a deletion, as it could
>> +			 * not have resulted in our current state, which
>> +			 * actually has the file.
>> +			 */
>> +			break;
>> +
>> +		default:
>> +			/*
>> +			 * Otherwise, we care only that we somehow arrived at
>> +			 * a final oid state. Note that this covers some
>> +			 * potentially controversial areas, including:
>> +			 *
>> +			 *  1. A rename or copy will be found, as it is the
>> +			 *     first time the content has arrived at the given
>> +			 *     path.
>
> Makes sense that we don't handle renames (yet). I think I didn't spot
> this in the manual, so maybe this is something we should document there.

I'll add a line in the docs.

>> +			 *  2. Even a non-content modification like a mode or
>> +			 *     type change will trigger it.
>
> Seems sensible as a default, as well. And likewise, we can add
> `--ignore-mode-changes` at a later point if we ever have a use case for
> it.

Agreed.

>> +			 * We take the inclusive approach for now, and find
>> +			 * anything which impacts the path. Options to tweak
>> +			 * the behavior (e.g., to "--follow" the content across
>> +			 * renames) can come later.
>> +			 */
>> +			mark_path(p->two->path, &p->two->oid, data);
>> +			break;
>> +		}
>> +	}
>> +}
>> +
>> +static int last_modified_run(struct last_modified *lm)
>> +{
>> +	struct last_modified_callback_data data = { .lm = lm };
>> +
>> +	lm->rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
>> +	lm->rev.diffopt.format_callback = last_modified_diff;
>> +	lm->rev.diffopt.format_callback_data = &data;
>> +
>> +	prepare_revision_walk(&lm->rev);
>> +
>> +	while (hashmap_get_size(&lm->paths)) {
>> +		data.commit = get_revision(&lm->rev);
>> +		if (!data.commit)
>> +			break;
>
> So in this case we have reached the end of our commit range. I assume we
> simply print the oldest commit of that range in this case?

Looking at this more in detail, I feel we should be calling BUG here.
When we've hit the boundary commit, we should be printing the remaining
paths with that commit, but with a caret `^` prepended. If we hit this
condition it means we went beyond the boundary, but still have paths
remaining. That's a bug.

But... As a matter of fact. I had a test failing (on the commit using
bloom filters). It didn't print remaining paths with the boundary commit
with a caret. This happens only when having GIT_TEST_COMMIT_GRAPH and
GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS set. And it's perfectly explainable
now:

With those set, we hit this exit condition. This happens because
maybe_changed_path() was called in previous loop, returning false. Then
we hit this exit, and un-printed paths remain. Big thanks for this hint.

>> +		if (data.commit->object.flags & BOUNDARY) {
>> +			diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
>> +				      &data.commit->object.oid, "",
>> +				      &lm->rev.diffopt);
>> +			diff_flush(&lm->rev.diffopt);
>> +		} else {
>> +			log_tree_commit(&lm->rev, data.commit);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int last_modified_init(struct last_modified *lm, struct repository *r,
>> +			      const char *prefix, int argc, const char **argv)
>> +{
>> +	hashmap_init(&lm->paths, last_modified_entry_hashcmp, NULL, 0);
>> +
>> +	repo_init_revisions(r, &lm->rev, prefix);
>> +	lm->rev.def = "HEAD";
>> +	lm->rev.combine_merges = 1;
>> +	lm->rev.show_root_diff = 1;
>> +	lm->rev.boundary = 1;
>> +	lm->rev.no_commit_id = 1;
>> +	lm->rev.diff = 1;
>> +	lm->rev.diffopt.flags.recursive = lm->recursive || lm->tree_in_recursive;
>> +	lm->rev.diffopt.flags.tree_in_recursive = lm->tree_in_recursive;
>> +
>> +	if ((argc = setup_revisions(argc, argv, &lm->rev, NULL)) > 1) {
>
> Tiny nit: it's rather unusual in our codebase to assign values in
> conditionals. I personally don't mind this usage at all -- I think it
> can make error handling way less verbose. But I'm not sure whether we
> deem this style acceptable.
>
>         argc = setup_revisions(argc, argv, &lm->rev, NULL)
>         if (argc) {
>             ...
>         }

I'm happy to adopt this change. I wasn't sure what the guideline is, for
some reason I assumed what I had. Personally I prefer the verbosity a
little more.

> I've seen this style several times in this patch. I think we should keep
> our typical style for now, but I wouldn't mind if you sent a patch for
> our coding style document so that we can discuss this.

No, let's follow typical style.

>> +		error(_("unknown last-modified argument: %s"), argv[1]);
>> +		return argc;
>> +	}
>> +
>> +	if (populate_paths_from_revs(lm) < 0)
>> +		return error(_("unable to setup last-modified"));
>> +
>> +	return 0;
>> +}
>> +
>> +int cmd_last_modified(int argc, const char **argv, const char *prefix,
>> +		      struct repository *repo)
>> +{
>> +	int ret;
>> +	struct last_modified lm;
>> +
>> +	const char * const last_modified_usage[] = {
>> +		N_("git last-modified [-r] [-t] "
>> +		   "[<revision-range>] [[--] <path>...]"),
>> +		NULL
>> +	};
>> +
>> +	struct option last_modified_options[] = {
>> +		OPT_BOOL('r', "recursive", &lm.recursive,
>> +			 N_("recurse into subtrees")),
>> +		OPT_BOOL('t', "tree-in-recursive", &lm.tree_in_recursive,
>> +			 N_("recurse into subtrees and include the tree entries too")),
>
> Should this maybe be called something like "--recursive-with-trees"?
> "--tree-in-recursive" reads somewhat strange to me.

I agree that sounds better. It seems we don't have either options yet,
so we're still open to chose.

>> +		OPT_END()
>> +	};
>> +
>> +	memset(&lm, 0, sizeof(lm));
>
> You can avoid the `memset()` and directly zero-initialize the struct
> when it's declared. Alternatively, you can move this function call into
> `last_modified_init()` itself, where it would be more reasonable.

Because I read parse_options() results into this struct, I cannot do the
memset() in last_modified_init(). So I'm changing to the `{ 0 }`
zero-init.

>> +	argc = parse_options(argc, argv, prefix, last_modified_options,
>> +			     last_modified_usage,
>> +			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
>> +
>> +	repo_config(repo, git_default_config, NULL);
>> +
>> +	if ((ret = last_modified_init(&lm, repo, prefix, argc, argv))) {
>> +		if (ret > 0)
>> +			usage_with_options(last_modified_usage,
>> +					   last_modified_options);
>> +		goto out;
>> +	}
>> +
>> +	if ((ret = last_modified_run(&lm)))
>> +		goto out;
>
> Two more cases where we assign `if ((ret = ...))`.

Yeah yeah, I've heard you ;-P. No no, joking, I appreciate you're
pointing this out.

>
> Patrick
>

[1]: https://lore.kernel.org/git/aDWWe6qCQXorPESd@pks.im/

-- 
Cheers,
Toon

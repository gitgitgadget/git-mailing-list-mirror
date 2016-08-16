Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D5311F859
	for <e@80x24.org>; Tue, 16 Aug 2016 18:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbcHPSy5 (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 14:54:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54610 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750822AbcHPSy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 14:54:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 89FE635675;
	Tue, 16 Aug 2016 14:48:17 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C4JFtPh0tqsNBtoVYscGwb8kEjU=; b=q28oxn
	OWDyaifhEs7NLTly71HFrjO+OqaNQf5H4W00Xsxmb0rO8I8iBOtbFNjpQmIMKgvy
	EgC6v2cx6jPPXEjLYaVz+rqmtO1ISFd2YuNafilhAbAtnDMotbflRGai6R3bf2HS
	JEOc0uLUiavOmShWe8nX33sFq3uyBjoQpk5nk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ejdTcEiJo8Oygqvp6l+VSOrJzTkKzh+M
	0yB6x+jz77nM0lSewXsgGpHrqHlaOaL69FYoI9uzs2M1C8KNs3TnIsl+vkR17+EB
	Umt9kK2h1PgO2LbfHfjht6/XNBz8xhzZGTKbS8lGjwp4n/8/LPZjuRSdBKolhcKI
	lk+ILB6XLu4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8216535674;
	Tue, 16 Aug 2016 14:48:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D2B9035673;
	Tue, 16 Aug 2016 14:48:16 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jacob Keller <jacob.e.keller@intel.com>
Cc:	git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v6 3/3] diff: add SUBMODULE_DIFF format to display submodule diff
References: <20160815230702.30817-1-jacob.e.keller@intel.com>
	<20160815230702.30817-4-jacob.e.keller@intel.com>
Date:	Tue, 16 Aug 2016 11:48:14 -0700
In-Reply-To: <20160815230702.30817-4-jacob.e.keller@intel.com> (Jacob Keller's
	message of "Mon, 15 Aug 2016 16:07:02 -0700")
Message-ID: <xmqqh9akczyp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE774CA6-63E1-11E6-A305-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index d5a5b17d5088..f5d693afad6c 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -123,7 +123,8 @@ diff.suppressBlankEmpty::
>  diff.submodule::
>  	Specify the format in which differences in submodules are
>  	shown.  The "log" format lists the commits in the range like
> -	linkgit:git-submodule[1] `summary` does.  The "short" format
> +	linkgit:git-submodule[1] `summary` does.  The "diff" format shows the
> +	diff between the beginning and end of the range. The "short" format
>  	format just shows the names of the commits at the beginning
>  	and end of the range.  Defaults to short.

It would be much better to describe the default one first and then
more involved one next, no?  That would also match what the change
to "diff-options" in this patch does (can be seen below).

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index cc4342e2034d..d3ca4ad2c2c5 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -215,8 +215,11 @@ any of those replacements occurred.
>  	the commits in the range like linkgit:git-submodule[1] `summary` does.
>  	Omitting the `--submodule` option or specifying `--submodule=short`,
>  	uses the 'short' format. This format just shows the names of the commits
> -	at the beginning and end of the range.  Can be tweaked via the
> -	`diff.submodule` configuration variable.
> +	at the beginning and end of the range. When `--submodule=diff` is
> +	given, the 'diff' format is used. This format shows the diff between
> +	the old and new submodule commmit from the perspective of the
> +	submodule.  Defaults to `diff.submodule` or 'short' if the config
> +	option is unset.

> @@ -2311,6 +2322,15 @@ static void builtin_diff(const char *name_a,
>  				two->dirty_submodule,
>  				meta, del, add, reset);
>  		return;
> +	} else if (o->submodule_format == DIFF_SUBMODULE_DIFF &&
> +		   (!one->mode || S_ISGITLINK(one->mode)) &&
> +		   (!two->mode || S_ISGITLINK(two->mode))) {
> +		show_submodule_diff(o->file, one->path ? one->path : two->path,
> +				line_prefix,
> +				one->oid.hash, two->oid.hash,
> +				two->dirty_submodule,
> +				meta, a_prefix, b_prefix, reset);
> +		return;
>  	}

The "either missing or is submodule" check used here is being
consistent with the existing "submodule=log" case.  Good.

> diff --git a/submodule.c b/submodule.c
> index 1b5cdfb7e784..b1da68dd49c9 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -333,6 +333,136 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
>  	strbuf_release(&sb);
>  }
>  
> +void show_submodule_diff(FILE *f, const char *path,
> +		const char *line_prefix,
> +		unsigned char one[20], unsigned char two[20],
> +		unsigned dirty_submodule, const char *meta,
> +		const char *a_prefix, const char *b_prefix,
> +		const char *reset)
> +{
> +	struct strbuf submodule_git_dir = STRBUF_INIT, sb = STRBUF_INIT;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	const char *git_dir;
> +
> +	if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) {
> +		fprintf(f, "%sSubmodule %s contains untracked content\n",
> +			line_prefix, path);
> +	}
> +	if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED) {
> +		fprintf(f, "%sSubmodule %s contains modified content\n",
> +			line_prefix, path);
> +	}
> +
> +	strbuf_addf(&sb, "%s%sSubmodule %s %s..",
> +		    line_prefix, meta, path,
> +		    find_unique_abbrev(one, DEFAULT_ABBREV));
> +	strbuf_addf(&sb, "%s:%s",
> +		    find_unique_abbrev(two, DEFAULT_ABBREV),
> +		    reset);
> +	fwrite(sb.buf, sb.len, 1, f);
> +
> +	if (is_null_sha1(one))
> +		fprintf(f, " (new submodule)");
> +	if (is_null_sha1(two))
> +		fprintf(f, " (submodule deleted)");

These messages are in sync with show_submodule_summary() that is
used in --submodule=log codepath.  Good.

> +	/*
> +	 * We need to determine the most accurate location to call the sub
> +	 * command, and handle the various corner cases involved. We'll first
> +	 * attempt to use the path directly if the submodule is checked out.
> +	 * Then, if that fails, we'll check the standard module location in
> +	 * the git directory. If even this fails, it means we can't do the
> +	 * lookup because the module has not been initialized.
> +	 */

This is more elaborate than what show_submodule_summary() does,
isn't it?  Would it make the patch series (and the resulting code)
more understandable if you used the same code by refactoring these
two?  If so, I wonder if it makes sense to split 3/3 into a few
separate steps:

 * Update the internal "--submodule=<type>" handling without adding
   the "--submodule=diff" and show_submodule_diff() function.

 * Refactor the determination of the submodule status (i.e. does it
   even have a clone?  where is its repository? etc.) from existing
   show_submodule_summary() into a separate helper function.

 * Make that helper function more elaborate like what you do here,
   and update show_submodule_summary().  I think the state
   show_submodule_summary() calls "not checked out" corresponds to
   what you say "not initialized" below, and they should share the
   same logic to determine that the submodule is in that state, and
   share the same message, for example.

 * Introduce "--submodule=diff", and show_submodule_diff() function;
   the latter would use the helper function prepared in the previous
   step.

perhaps?

> +	strbuf_addf(&submodule_git_dir, "%s/.git", path);
> +	git_dir = resolve_gitdir(submodule_git_dir.buf);
> +	if (git_dir) {
> +		/*
> +		 * If we can resolve a git dir, this means that the submodule
> +		 * has been checked out. In this case, just use the original
> +		 * path since we want access to the work tree
> +		 */
> +		git_dir = path;
> +	} else {
> +		/*
> +		 * If we can't resolve a git dir, this means that the
> +		 * submodule has not been checked out. In this case, try the
> +		 * standard location for modules
> +		 */
> +		strbuf_reset(&submodule_git_dir);
> +		strbuf_addf(&submodule_git_dir, "%s/modules/%s", get_git_dir(), path);
> +		git_dir = resolve_gitdir(submodule_git_dir.buf);
> +		if (!git_dir) {
> +			/*
> +			 * If we failed to find a git directory here, then the
> +			 * submodule must not have been initialized. Without
> +			 * the initialized contents of the submodule, we won't
> +			 * be able to perform the difference.
> +			 */
> +			fprintf(f, " (submodule not initialized)\n");
> +			goto out;
> +		}
> +	}
> +
> +	/*
> +	 * print a newline and flush the file so that the diff output appears
> +	 * starting on its own line
> +	 */
> +	fprintf(f, "\n");
> +	fflush(f);
> +
> +	cp.git_cmd = 1;
> +	cp.dir = git_dir;
> +	cp.out = dup(fileno(f));
> +	cp.no_stdin = 1;
> +
> +	argv_array_push(&cp.args, "diff");
> +	argv_array_pushf(&cp.args, "--line-prefix=%s", line_prefix);
> +	argv_array_pushf(&cp.args, "--src-prefix=%s%s/", a_prefix, path);
> +	argv_array_pushf(&cp.args, "--dst-prefix=%s%s/", b_prefix, path);
> +
> +	if (is_null_sha1(one)) {
> +		/*
> +		 * If the origin commit is null, we want to use the empty tree
> +		 * so that we see a diff of all the new contents added.
> +		 */
> +		argv_array_push(&cp.args, EMPTY_TREE_SHA1_HEX);
> +	} else {
> +		/* Use the old commit as the diff base */
> +		argv_array_push(&cp.args, sha1_to_hex(one));
> +	}
> +
> +	if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED) {
> +		/*
> +		 * If the submodule has modified contents we want to diff
> +		 * against the work tree, so don't add a second parameter.
> +		 * This is essentially equivalent of using diff-index instead.
> +		 * Note that we can't (easily) show the diff of any untracked
> +		 * files.
> +		 */
> +	} else if (is_null_sha1(two)) {

It is safer to have ';' inside the empty if(){} block to make sure
that one empty statement exists there.  It makes the intention of
the code clearer, too.

I am debating myself if this is a good thing to do, though.  The
submodule is a separate project for a reason, and there is a reason
why the changes haven't been committed.  When asking "what's different
between these two superproject states?", should the user really see
these uncommitted changes?

Thanks.

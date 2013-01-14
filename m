From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] diff: Introduce --diff-algorithm command line option
Date: Mon, 14 Jan 2013 10:44:40 -0800
Message-ID: <7vsj63bo4n.fsf@alter.siamese.dyndns.org>
References: <cover.1358006339.git.mprivozn@redhat.com>
 <6c058f13c6bb83985e8651a8dde99e7b17879d4e.1358006339.git.mprivozn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, trast@student.ethz.ch
To: Michal Privoznik <mprivozn@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 19:45:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tup1u-00049r-1Z
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 19:45:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757245Ab3ANSop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 13:44:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65169 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757204Ab3ANSon (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 13:44:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5281A9E9;
	Mon, 14 Jan 2013 13:44:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gErEXrcYCPcj5wHYJTFXF9BXplw=; b=d7b5DN
	MHlApIHeecDIKQcSM7odJto3sIoERfl7JcuzAuKGu4sCEjwtXg3c1S/EZ3SZVE0/
	+MoijPaDix0gd+WJon5A4qGakkrxja5opbo4Aj4jiua5jS8IJzvYEWICGHt6GVRY
	4Dtv9YMk3vQ/SiJXstTxB06twTLTlLofqdiE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sHl7X/o5a/rGlkZOz+clLxgAX23HlVhy
	BB4ZKHqDFp5KUDvka/7CgEymJrRaO4n6aZnua38LlKxSeor+XMIh/iuFYPnNA6+p
	MAuVxjFSBDvCQ+6+QSw6XzC/dL0hhjxY0y4uluLy7RsfjxwxQAkNd1ZLTOTfSQ6N
	gIp1OF/0+yU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8B91A9E8;
	Mon, 14 Jan 2013 13:44:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D267FA9E3; Mon, 14 Jan 2013
 13:44:41 -0500 (EST)
In-Reply-To: <6c058f13c6bb83985e8651a8dde99e7b17879d4e.1358006339.git.mprivozn@redhat.com>
 (Michal Privoznik's message of "Sat, 12 Jan 2013 17:02:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7521A9D0-5E7A-11E2-8E89-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213514>

Michal Privoznik <mprivozn@redhat.com> writes:

> Since command line options have higher priority than config file
> variables and taking previous commit into account, we need a way
> how to specify myers algorithm on command line.

Yes.  We cannot stop at [2/3] without this patch.

> However,
> inventing `--myers` is not the right answer. We need far more
> general option, and that is `--diff-algorithm`.

Yes, --diff-algorithm=default would let people defeat a configured
algo without knowing how exactly to spell myers.

> The older options
> (`--minimal`, `--patience` and `--histogram`) are kept for
> backward compatibility.

That is phrasing it too strongly to be acceptable.

People who do not care any configuration can keep using --histogram
without having to retrain their fingers to type a much longer form
you introduced (i.e. --diff-algorithm=histogram).  It is and will
always be just as valid a way to ask for --histogram as the new
longhand is.

> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>  Documentation/diff-options.txt         | 22 ++++++++++++++++++++++
>  contrib/completion/git-completion.bash | 11 +++++++++++
>  diff.c                                 | 12 +++++++++++-
>  diff.h                                 |  2 ++
>  merge-recursive.c                      |  6 ++++++
>  5 files changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 39f2c50..4091f52 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -45,6 +45,9 @@ ifndef::git-format-patch[]
>  	Synonym for `-p --raw`.
>  endif::git-format-patch[]
>  
> +The next three options are kept for compatibility reason. You should use the
> +`--diff-algorithm` option instead.
> +

Drop this.

> @@ -55,6 +58,25 @@ endif::git-format-patch[]
>  --histogram::
>  	Generate a diff using the "histogram diff" algorithm.
>  
> +--diff-algorithm={patience|minimal|histogram|myers}::
> +	Choose a diff algorithm. The variants are as follows:
> ++
> +--
> +`myers`;;
> +	The basic greedy diff algorithm.
> +`minimal`;;
> +	Spend extra time to make sure the smallest possible diff is
> +	produced.
> +`patience`;;
> +	Use "patience diff" algorithm when generating patches.
> +`histogram`;;
> +	This algorithm extends the patience algorithm to "support
> +	low-occurrence common elements".
> +--
> ++
> +You should prefer this option over the `--minimal`, `--patience` and
> +`--histogram` which are kept just for backwards compatibility.

Drop the last one, and replace it with something like:

	If you configured diff.algorithm to a non-default value and
	want to use the default one, you have to use this form and
	choose myers, i.e. --diff-algorithm=myers, as we do not have
	a short-and-sweet --myers option.

(but the above is a bit too verbose, so please shorten it appropriately).

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 33e25dc..d592cf9 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1021,6 +1021,8 @@ _git_describe ()
>  	__gitcomp_nl "$(__git_refs)"
>  }
>  
> +__git_diff_algorithms="myers minimal patience histogram"
> +
>  __git_diff_common_options="--stat --numstat --shortstat --summary
>  			--patch-with-stat --name-only --name-status --color
>  			--no-color --color-words --no-renames --check
> @@ -1035,6 +1037,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
>  			--raw
>  			--dirstat --dirstat= --dirstat-by-file
>  			--dirstat-by-file= --cumulative
> +			--diff-algorithm=
>  "
>  
>  _git_diff ()
> @@ -1042,6 +1045,10 @@ _git_diff ()
>  	__git_has_doubledash && return
>  
>  	case "$cur" in
> +	--diff-algorithm=*)
> +		__gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=}"
> +		return
> +		;;
>  	--*)
>  		__gitcomp "--cached --staged --pickaxe-all --pickaxe-regex
>  			--base --ours --theirs --no-index
> @@ -2114,6 +2121,10 @@ _git_show ()
>  			" "" "${cur#*=}"
>  		return
>  		;;
> +	--diff-algorithm=*)
> +		__gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=}"
> +		return
> +		;;
>  	--*)
>  		__gitcomp "--pretty= --format= --abbrev-commit --oneline
>  			$__git_diff_common_options
> diff --git a/diff.c b/diff.c
> index ddae5c4..6418076 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -144,7 +144,7 @@ static int git_config_rename(const char *var, const char *value)
>  	return git_config_bool(var,value) ? DIFF_DETECT_RENAME : 0;
>  }
>  
> -static long parse_algorithm_value(const char *value)
> +long parse_algorithm_value(const char *value)
>  {
>  	if (!value || !strcasecmp(value, "myers"))
>  		return 0;
> @@ -3633,6 +3633,16 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
>  		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
>  	else if (!strcmp(arg, "--histogram"))
>  		options->xdl_opts = DIFF_WITH_ALG(options, HISTOGRAM_DIFF);
> +	else if (!prefixcmp(arg, "--diff-algorithm=")) {
> +		long value = parse_algorithm_value(arg+17);
> +		if (value < 0)
> +			return error("option diff-algorithm accepts \"myers\", "
> +				     "\"minimal\", \"patience\" and \"histogram\"");
> +		/* clear out previous settings */
> +		DIFF_XDL_CLR(options, NEED_MINIMAL);
> +		options->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
> +		options->xdl_opts |= value;
> +	}
>  
>  	/* flags options */
>  	else if (!strcmp(arg, "--binary")) {
> diff --git a/diff.h b/diff.h
> index a47bae4..54c2590 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -333,6 +333,8 @@ extern struct userdiff_driver *get_textconv(struct diff_filespec *one);
>  
>  extern int parse_rename_score(const char **cp_p);
>  
> +extern long parse_algorithm_value(const char *value);
> +
>  extern int print_stat_summary(FILE *fp, int files,
>  			      int insertions, int deletions);
>  extern void setup_diff_pager(struct diff_options *);
> diff --git a/merge-recursive.c b/merge-recursive.c
> index d882060..53d8feb 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2068,6 +2068,12 @@ int parse_merge_opt(struct merge_options *o, const char *s)
>  		o->xdl_opts = DIFF_WITH_ALG(o, PATIENCE_DIFF);
>  	else if (!strcmp(s, "histogram"))
>  		o->xdl_opts = DIFF_WITH_ALG(o, HISTOGRAM_DIFF);
> +	else if (!strcmp(s, "diff-algorithm=")) {
> +		long value = parse_algorithm_value(s+15);
> +		if (value < 0)
> +			return -1;
> +		o->xdl_opts |= value;

Isn't this new hunk wrong?  DIFF_WITH_ALG() removes the previously
chosen algorithm choice before OR'ing the new one in, so that

	diff --histogram --patience

would not end up with a value PATIENCE|HISTOGRAM OR'ed together in
the algo field.

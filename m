Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B74091F404
	for <e@80x24.org>; Mon, 22 Jan 2018 22:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751137AbeAVWMv (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 17:12:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56382 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbeAVWMu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 17:12:50 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EA03BD7972;
        Mon, 22 Jan 2018 17:12:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QCqUrHUle8t3vQngzM9o7FlSDHM=; b=H4HoJ5
        KER+0DrYsAhzR1vLDqGQhuZqj83xYjfESJ3MsWYBgiZ0K+KAQBk3fqLiqCpL/Mf7
        YMVHniajffboM5RoHcAueq1peSuTyRdWKQl+9VaCtxqJurj2I4/PAcGaq2O6K5fg
        C4G+id+3oD35zSjH7lCx6gyL3tOagMkRvJ9eI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YN9S7mYPvqbQFZPWHRd3V6XVotCdzxLh
        5e0offt3htk0FxszZiPlwXDb1qzcG5RRWnxyWQ/Oi2DOjILLU8QXyYqf7O/GLcGy
        ljEXoEKpXcWBEMVrknPkqo0IgespVh2sb4cD1xJsAnceGXZqXECLjjkkEexX3yQ2
        kDHIK7qInbE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E16B2D7971;
        Mon, 22 Jan 2018 17:12:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 662FED7970;
        Mon, 22 Jan 2018 17:12:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 2/8] sequencer: introduce the `merge` command
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <647382ac70bfb7035345304a32d08f4e7b51cd40.1516225925.git.johannes.schindelin@gmx.de>
Date:   Mon, 22 Jan 2018 14:12:48 -0800
In-Reply-To: <647382ac70bfb7035345304a32d08f4e7b51cd40.1516225925.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 18 Jan 2018 16:35:30 +0100
        (STD)")
Message-ID: <xmqqpo61lezj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61E668E0-FFC1-11E7-98B5-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>  	end_of_object_name = (char *) bol + strcspn(bol, " \t\n");
> +	item->arg = end_of_object_name + strspn(end_of_object_name, " \t");
> +	item->arg_len = (int)(eol - item->arg);
> +
>  	saved = *end_of_object_name;
> +	if (item->command == TODO_MERGE && *bol == '-' &&
> +	    bol + 1 == end_of_object_name) {
> +		item->commit = NULL;
> +		return 0;
> +	}
> +
>  	*end_of_object_name = '\0';
>  	status = get_oid(bol, &commit_oid);
>  	*end_of_object_name = saved;
>  
> -	item->arg = end_of_object_name + strspn(end_of_object_name, " \t");
> -	item->arg_len = (int)(eol - item->arg);
> -

Assigning to "saved" before the added "if we are doing merge and see
'-', do this special thing" is not only unnecessary, but makes the
logic in the non-special case harder to read.  The four things
"saved = *eol; *eol = 0; do_thing_using(bol); *eol = saved;" is a
single logical unit; keep them together.

This hunk may have been the most expedient way to coax "-" into the
location where a commit object name is expected; it looks ugly, but
for the limited purpose of this series it should do.

> @@ -2069,6 +2077,132 @@ static int do_reset(const char *name, int len)
>  	return ret;
>  }
>  
> +static int do_merge(struct commit *commit, const char *arg, int arg_len,
> +		    struct replay_opts *opts)
> +{
> +	int merge_arg_len;
> +	struct strbuf ref_name = STRBUF_INIT;
> +	struct commit *head_commit, *merge_commit, *i;
> +	struct commit_list *common, *j, *reversed = NULL;
> +	struct merge_options o;
> +	int ret;
> +	static struct lock_file lock;
> +
> +	for (merge_arg_len = 0; merge_arg_len < arg_len; merge_arg_len++)
> +		if (isspace(arg[merge_arg_len]))
> +			break;

Mental note: this scans for a whitespace, and tab is accepted
instead of SP, which presumably is to allow human typed string.

> +	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
> +		return -1;
> +
> +	if (commit) {
> +		const char *message = get_commit_buffer(commit, NULL);
> +		const char *body;
> +		int len;
> +
> +		if (!message) {
> +			rollback_lock_file(&lock);
> +			return error(_("could not get commit message of '%s'"),
> +				     oid_to_hex(&commit->object.oid));
> +		}
> +		write_author_script(message);
> +		find_commit_subject(message, &body);
> +		len = strlen(body);
> +		if (write_message(body, len, git_path_merge_msg(), 0) < 0) {
> +			error_errno(_("Could not write '%s'"),
> +				    git_path_merge_msg());
> +			unuse_commit_buffer(commit, message);
> +			rollback_lock_file(&lock);
> +			return -1;
> +		}
> +		unuse_commit_buffer(commit, message);
> +	} else {
> +		const char *p = arg + merge_arg_len;
> +		struct strbuf buf = STRBUF_INIT;
> +		int len;
> +
> +		strbuf_addf(&buf, "author %s", git_author_info(0));
> +		write_author_script(buf.buf);
> +		strbuf_reset(&buf);
> +
> +		p += strspn(p, " \t");

... and this matches the above mental note.  It allows consecutive
whitespaces as a separator, which is sensible behaviour.

> +		if (*p)
> +			len = strlen(p);
> +		else {
> +			strbuf_addf(&buf, "Merge branch '%.*s'",
> +				    merge_arg_len, arg);
> +			p = buf.buf;
> +			len = buf.len;
> +		}

So... "arg" received by this function can be a single non-whitespace
token, which is taken as the name of the branch being merged (in
this else clause).  Or it can also be followed by a single liner
message for the merge commit.  Presumably, this is for creating a
new merge (i.e. "commit==NULL" case), and preparing a proper log
message in the todo list is unrealistic, so this would be a
reasonable compromise.  Those users who want to write proper log
message could presumably follow such "merge" insn with a "x git
commit --amend" or something, I presume, if they really wanted to.

> +		if (write_message(p, len, git_path_merge_msg(), 0) < 0) {
> +			error_errno(_("Could not write '%s'"),
> +				    git_path_merge_msg());
> +			strbuf_release(&buf);
> +			rollback_lock_file(&lock);
> +			return -1;
> +		}
> +		strbuf_release(&buf);
> +	}

OK.  Now we have prepared the MERGE_MSG file and are ready to commit.

> +	head_commit = lookup_commit_reference_by_name("HEAD");
> +	if (!head_commit) {
> +		rollback_lock_file(&lock);
> +		return error(_("Cannot merge without a current revision"));
> +	}

Hmph, I would have expected to see this a lot earlier, before
dealing with the log message.  Leftover MERGE_MSG file after an
error will cause unexpected fallout to the end-user experience
(including what is shown by the shell prompt scripts), but if we do
this before the MERGE_MSG thing, we do not have to worry about
error codepath having to remove it.

> +	strbuf_addf(&ref_name, "refs/rewritten/%.*s", merge_arg_len, arg);
> +	merge_commit = lookup_commit_reference_by_name(ref_name.buf);
> +	if (!merge_commit) {
> +		/* fall back to non-rewritten ref or commit */
> +		strbuf_splice(&ref_name, 0, strlen("refs/rewritten/"), "", 0);
> +		merge_commit = lookup_commit_reference_by_name(ref_name.buf);
> +	}

OK, so "abc" in the example in the log message is looked up first as
a label and then we take a fallback to interpret as an object name.

Hopefully allowed names in "label" would be documented clearly in
later steps (I am guessing that "a name that can be used as a branch
name can be used as a label name and vice versa" or something like
that).

> +	if (!merge_commit) {
> +		error(_("could not resolve '%s'"), ref_name.buf);
> +		strbuf_release(&ref_name);
> +		rollback_lock_file(&lock);
> +		return -1;
> +	}
> +	write_message(oid_to_hex(&merge_commit->object.oid), GIT_SHA1_HEXSZ,
> +		      git_path_merge_head(), 0);
> +	write_message("no-ff", 5, git_path_merge_mode(), 0);

These two calls gave me a "Huh?" moment; write_message() sounds like
it is allowed to be later updated with frills suitable for *_MSG
files we place in .git/ directory (iow, it is in principle OK if
commented out instructions common to these files are added to the
output by the function), but these want exact bytes passed in the
result, for which wrapper.c::write_file() is more appropriate.

Alternatively, perhaps write_message() can be dropped and its
callers can call wrapper.c::write_file() instead?  Such a clean-up
may require teaching the append-eol thing that write_message() wants
to wrapper.c::write_file(), but it shouldn't be a rocket science.

> +	common = get_merge_bases(head_commit, merge_commit);
> +	for (j = common; j; j = j->next)
> +		commit_list_insert(j->item, &reversed);
> +	free_commit_list(common);

I know this is copy&pasted code from "builtin/merge.c", but is there
a reason to reverse the common ancestor list here?

> +	read_cache();
> +	init_merge_options(&o);
> +	o.branch1 = "HEAD";
> +	o.branch2 = ref_name.buf;
> +	o.buffer_output = 2;
> +
> +	ret = merge_recursive(&o, head_commit, merge_commit, reversed, &i);
> +	if (ret <= 0)
> +		fputs(o.obuf.buf, stdout);
> +...

Other than these minor nits, looks quite promising.  Nicely done.

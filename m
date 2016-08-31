Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28A011F859
	for <e@80x24.org>; Wed, 31 Aug 2016 17:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161144AbcHaR3Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 13:29:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36090 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936053AbcHaR3V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 13:29:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id i138so8539582wmf.3
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 10:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=C/fL5BCCze8xPBN27ckgFYe8sobxRMuVklMN0BEkFF0=;
        b=m18EH3gR44m5W2UR/ZwqdkJRfoHnH00gumaO7Ji5xy0m8Rmp4QSLSWJQL2suT5huD3
         OhLJN6oRxZoV2uL+JAjr42fssCRrlGfXxMfVdkuW/Cu+kOQZFlsUA2o+ByCFxsLqfcSy
         lPsJ62BOiG/7ibBLarTLMPw1L1XxTIwamYmqK4rSm2Zo3+2tXsP5o+DVYmKadWOJMral
         p2/nS1JhribDtRfXZD0a9eAIx6Hb3ZJM9K6eNMOxJoN9oa/CEqewDEaA8Zy7DU5InKLx
         aUsChBdIw5dQjdDWSJgXnmP5e8OctWOzgmexeQg43qHWlrkTrsHGfEB3kPXJJLoRXmhd
         qpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=C/fL5BCCze8xPBN27ckgFYe8sobxRMuVklMN0BEkFF0=;
        b=erg0fxKb/ZusZxl9VNo+BhWEdeDH67oNNYH7NlH05sdlCukIS3SgZxXZYFDgYZr+IE
         R0vPud8YkO+/eUJMFsfHC4L7QG25YvsLgx34TFqS/CwBSaZYHByHsHNhTbyCNgUKIdh1
         iz0AYLw9Dn5I4zC+Q/4PJhJVZfc4kjLNfRuPxUtwYtwfhvsiQYHu6ZXN1O2Jd0BngAe4
         y9sAEpEr7QM9Q7HA2dDGz9VCAPie/qAdRjIJ2UTzojYay9rOy6zDTMZZi5g3fus4PN1X
         x6yz8xf40OpSf8WTIaska/PWszBE7e8ppyldtp9O8D/pBEZbemXgXf28Ljw5aYgD7sTP
         9uog==
X-Gm-Message-State: AE9vXwMW5P7iIkzIlMnAxpd1IMggOTIRc0eka/nueSgulTHXm92Gq/cOn8NTUQCIqI1Oqg==
X-Received: by 10.28.67.1 with SMTP id q1mr742426wma.50.1472664550330;
        Wed, 31 Aug 2016 10:29:10 -0700 (PDT)
Received: from [192.168.1.26] (enu134.neoplus.adsl.tpnet.pl. [83.20.10.134])
        by smtp.googlemail.com with ESMTPSA id a3sm881897wjw.15.2016.08.31.10.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 10:29:09 -0700 (PDT)
Subject: Re: [PATCH 09/22] sequencer: completely revamp the "todo" script
 parsing
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <163aaa2a64ddf6dfb28c77c821726e14cc78619e.1472457609.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <135c9ac7-49a6-8aa1-fc10-02c2a1fd0b1a@gmail.com>
Date:   Wed, 31 Aug 2016 19:29:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <163aaa2a64ddf6dfb28c77c821726e14cc78619e.1472457609.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 29.08.2016 o 10:05, Johannes Schindelin pisze:

> When we came up with the "sequencer" idea, we really wanted to have
> kind of a plumbing equivalent of the interactive rebase. Hence the
> choice of words: the "todo" script, a "pick", etc.
> 
> However, when it came time to implement the entire shebang, somehow this
> idea got lost and the sequencer was used as working horse for
> cherry-pick and revert instead. So as not to interfere with the
> interactive rebase, it even uses a separate directory to store its
> state.
> 
> Furthermore, it also is stupidly strict about the "todo" script it
> accepts: while it parses commands in a way that was *designed* to be
> similar to the interactive rebase, it then goes on to *error out* if the
> commands disagree with the overall action (cherry-pick or revert).

Does this mean that after the change you would be able to continue
"git revert" with "git cherry-pick --continue", and vice versa?  Or that
it would be possible for git-cherry-pick to do reverts (e.g. with ^<rev>)?

That's what we need to decide before becoming more lenient.
 
BTW. perhaps we would be able to continue with 'git continue', regardless
of what we have started with, I wonder...

>
> Finally, the sequencer code chose to deviate from the interactive rebase
> code insofar that it *reformats* the "todo" script instead of just
> writing the part of the parsed script that were not yet processed. This
> is not only unnecessary churn, but might well lose information that is
> valuable to the user (i.e. comments after the commands).

That's a very good change.

>
> Let's just bite the bullet and rewrite the entire parser; the code now
> becomes not only more elegant: it allows us to go on and teach the
> sequencer how to parse *true* "todo" scripts as used by the interactive
> rebase itself. In a way, the sequencer is about to grow up to do its
> older brother's job. Better.

Sidenote: this is not your fault, but Git doesn't do a good job on
changes which are mostly rewrites, trying to match stray '}' and the
like in generated diff.  I wonder if existing diff heuristic options
could help here.

> 
> While at it, do not stop at the first problem, but list *all* of the
> problems. This helps the user by allowing to address all issues in
> one go rather than going back and forth until the todo list is valid.

That is also a good change, though I wonder how often users need
to worry about this outside interactive rebase case.  If it is
preparation for rebase -i, where instruction list is written by
prone to errors human, it would be nice to have this information
in the commit message.

> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 241 +++++++++++++++++++++++++++++++++---------------------------
>  1 file changed, 134 insertions(+), 107 deletions(-)

Note: I have moved some lines of diff so that the change is more
readable to humans (but it results often in --++-++ chunk).

> 
> diff --git a/sequencer.c b/sequencer.c
> index 982b6e9..cbdce6d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -473,7 +473,26 @@ static int allow_empty(struct replay_opts *opts, struct commit *commit)
>  		return 1;
>  }
>  
> -static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
> +enum todo_command {
> +	TODO_PICK,
> +	TODO_REVERT
> +};

Do we have a naming convention for enums elements?  Or are we explicitly
making enums and #defines interchangeable?  I wonder...

...uh, I see we don't have naming convention, but all caps snake-case
names dominate:

  $ git grep -A2 'enum .* {'
  [...]
  diff.h:enum color_diff {
  diff.h- DIFF_RESET = 0,
  diff.h- DIFF_CONTEXT = 1,
  --
  dir.c:enum path_treatment {
  dir.c-  path_none = 0,
  dir.c-  path_recurse,
  --

Shouldn't we say 'TODO_PICK = 0' explicitly, though?

> +
> +static const char *todo_command_strings[] = {
> +	"pick",
> +	"revert"
> +};

It's a bit pity that we cannot use designated inits, and hanging comma,
(from ISO C99 standard).  That is:

  +static const char *todo_command_strings[] = {
  +	[TODO_PICK]   = "pick",
  +	[TODO_REVERT] = "revert",
  +};


> +
> +static const char *command_to_string(const enum todo_command command)
> +{
> +	if (command < ARRAY_SIZE(todo_command_strings))
> +		return todo_command_strings[command];
> +	die("Unknown command: %d", command);
> +}
> +
> +
> +static int do_pick_commit(enum todo_command command, struct commit *commit,
> +		struct replay_opts *opts)
>  {
>  	unsigned char head[20];
>  	struct commit *base, *next, *parent;
> @@ -535,7 +554,8 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>  		/* TRANSLATORS: The first %s will be "revert" or
>  		   "cherry-pick", the second %s a SHA1 */
>  		return error(_("%s: cannot parse parent commit %s"),

I wonder if we should not change also the error message: it is no
longer about command, but about operation in todo list (from what
I understand).  Though admittedly current message works for both...

> -			action_name(opts), oid_to_hex(&parent->object.oid));
> +			command_to_string(command),
> +			oid_to_hex(&parent->object.oid));
>  
>  	if (get_message(commit, &msg) != 0)
>  		return error(_("Cannot get commit message for %s"),
> @@ -548,7 +568,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)

From here on changes are about

  s/opts->action == REPLAY_\(PICK\|REVERT\)/command == TODO_\1/

Do we still need opts->action, or it is just needed less,
and it is 'todo' instruction that decides about command
(as it should)?

>  	 * reverse of it if we are revert.
>  	 */
>  
> -	if (opts->action == REPLAY_REVERT) {
> +	if (command == TODO_REVERT) {
>  		base = commit;
>  		base_label = msg.label;
>  		next = parent;
> @@ -589,7 +609,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>  		}
>  	}
>  
> -	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REPLAY_REVERT) {
> +	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
>  		res = do_recursive_merge(base, next, base_label, next_label,
>  					 head, &msgbuf, opts);
>  		if (res < 0)
> @@ -615,17 +635,17 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>  	 * However, if the merge did not even start, then we don't want to
>  	 * write it at all.
>  	 */
> -	if (opts->action == REPLAY_PICK && !opts->no_commit && (res == 0 || res == 1) &&
> +	if (command == TODO_PICK && !opts->no_commit && (res == 0 || res == 1) &&
>  	    update_ref(NULL, "CHERRY_PICK_HEAD", commit->object.oid.hash, NULL,
>  		       REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
>  		res = -1;
> -	if (opts->action == REPLAY_REVERT && ((opts->no_commit && res == 0) || res == 1) &&
> +	if (command == TODO_REVERT && ((opts->no_commit && res == 0) || res == 1) &&
>  	    update_ref(NULL, "REVERT_HEAD", commit->object.oid.hash, NULL,
>  		       REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
>  		res = -1;
>  
>  	if (res) {
> -		error(opts->action == REPLAY_REVERT
> +		error(command == TODO_REVERT
>  		      ? _("could not revert %s... %s")
>  		      : _("could not apply %s... %s"),
>  		      find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV),

And here those changes end.

  s/opts->action == REPLAY_\(PICK\|REVERT\)/command == TODO_\1/

I wonder if Coccinelle / Undebt would help here; or would simple
sed or query-and-replace-regexp be enough...

> @@ -683,116 +703,107 @@ static int read_and_refresh_cache(struct replay_opts *opts)
>  	return 0;
>  }
>  
> -static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
> -		struct replay_opts *opts)
> +struct todo_item {
> +	enum todo_command command;
> +	struct commit *commit;
> +	size_t offset_in_buf;
> +};
> +
> +struct todo_list {
> +	struct strbuf buf;
> +	struct todo_item *items;
> +	int nr, alloc, current;
> +};

So there should be s/commit_list [*]{1,2}todo_list/todo_list *todo_list/
from here on?

Hmmm... commit_list is, as defined in commit.h, a linked list.
Here todo_list uses growable array implementation of list.  Which
is I guess better on current CPU architecture, with slow memory,
limited-size caches, and adjacency prefetching.

I guess using items_nr and items_alloc would be not necessary
(and a bit funny / overkill).

> +
> +#define TODO_LIST_INIT { STRBUF_INIT, NULL, 0, 0, 0 }

Same as with other patches in this series, it would be enough to

  +#define TODO_LIST_INIT { STRBUF_INIT }

You are consistent.

> +
> +static void todo_list_release(struct todo_list *todo_list)
>  {

Grh... stray '{' matched...

> -	struct commit_list *cur = NULL;
> -	const char *sha1_abbrev = NULL;
> -	const char *action_str = opts->action == REPLAY_REVERT ? "revert" : "pick";
> -	const char *subject;
> -	int subject_len;
> +	strbuf_release(&todo_list->buf);
> +	free(todo_list->items);
> +	todo_list->items = NULL;
> +	todo_list->nr = todo_list->alloc = 0;
> +}
>  
> -	for (cur = todo_list; cur; cur = cur->next) {
> -		const char *commit_buffer = get_commit_buffer(cur->item, NULL);
> -		sha1_abbrev = find_unique_abbrev(cur->item->object.oid.hash, DEFAULT_ABBREV);
> -		subject_len = find_commit_subject(commit_buffer, &subject);
> -		strbuf_addf(buf, "%s %s %.*s\n", action_str, sha1_abbrev,
> -			subject_len, subject);
> -		unuse_commit_buffer(cur->item, commit_buffer);
> -	}
> -	return 0;
> +struct todo_item *append_todo(struct todo_list *todo_list)

Errr... I don't quite understand the name of this function.
What are you appending here to the todo_list?

Compare string_list_append() and string_list_append_nodup(),
where the second parameter is item to append.

I'm not against what this function does (grow array if needed, and
return pointer to the new todo_item that is to be filled), but
I don't quite agree with the name.  Naming is hard... :-(
[See later in reply for a proposal.]

> +{
> +	ALLOC_GROW(todo_list->items, todo_list->nr + 1, todo_list->alloc);
> +	return todo_list->items + todo_list->nr++;
>  }
>  
> -static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *opts)
> +static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)

Why the change of return type?  

I guess the previous code used only opts->action out of whole replay_opts,
and now we use item->command instead; that is why replay_opts is replaced
by todo_item.

Why now struct todo_item is first when struct replay_opts was last?
Not that I say is was a bad change...

>  {
>  	unsigned char commit_sha1[20];
> -	enum replay_action action;
>  	char *end_of_object_name;
> -	int saved, status, padding;
> -
> -	if (starts_with(bol, "pick")) {
> -		action = REPLAY_PICK;
> -		bol += strlen("pick");
> -	} else if (starts_with(bol, "revert")) {
> -		action = REPLAY_REVERT;
> -		bol += strlen("revert");
> -	} else
> -		return NULL;
> +	int i, saved, status, padding;

int i or enum?  Just kidding...

> +
> +	for (i = 0; i < ARRAY_SIZE(todo_command_strings); i++)
> +		if (skip_prefix(bol, todo_command_strings[i], &bol)) {

skip_prefix() is such a nice abstraction...

> +			item->command = i;
> +			break;
> +		}

Nice.  Replacing if-elsif chain with loop.  

I guess any hashmap would be serious overkill, as there are and would be
only a few actions possible.

> +	if (i >= ARRAY_SIZE(todo_command_strings))
> +		return -1;
>  
>  	/* Eat up extra spaces/ tabs before object name */
>  	padding = strspn(bol, " \t");
>  	if (!padding)
> -		return NULL;
> +		return -1;
>  	bol += padding;
>  
> -	end_of_object_name = bol + strcspn(bol, " \t\n");
> +	end_of_object_name = (char *) bol + strcspn(bol, " \t\n");

Why is this cast needed?

And do we say '(char *) bol' or '(char *)bol'?

>  	saved = *end_of_object_name;
>  	*end_of_object_name = '\0';
>  	status = get_sha1(bol, commit_sha1);
>  	*end_of_object_name = saved;
>  
> -	/*
> -	 * Verify that the action matches up with the one in
> -	 * opts; we don't support arbitrary instructions
> -	 */
> -	if (action != opts->action) {
> -		if (action == REPLAY_REVERT)
> -		      error((opts->action == REPLAY_REVERT)
> -			    ? _("Cannot revert during another revert.")

Errr... could the above ever happen?  Namely

  action != opts->action && action == REPLAY_REVERT && opts->action == REPLAY_REVERT

Surely not.

> -			    : _("Cannot revert during a cherry-pick."));
> -		else
> -		      error((opts->action == REPLAY_REVERT)
> -			    ? _("Cannot cherry-pick during a revert.")
> -			    : _("Cannot cherry-pick during another cherry-pick."));
> -		return NULL;
> -	}

Anyway, while it is / would be a good idea to prevent starting any
sequencer-based command (cherry-pick, revert, soon rebase -i) when
other command is in progress (cherry-pick, revert, soon rebase -i).
That is, if cherry-pick / revert waits for user action, you cannot
run another cherry-pick or revert.

Which I guess the above code was not about...

> -
>  	if (status < 0)
> -		return NULL;
> +		return -1;
>  
> -	return lookup_commit_reference(commit_sha1);
> +	item->commit = lookup_commit_reference(commit_sha1);
> +	return !item->commit;
>  }
>  
> -static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
> -			struct replay_opts *opts)
> +static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
>  {
> -	struct commit_list **next = todo_list;
> -	struct commit *commit;
> +	struct todo_item *item;
>  	char *p = buf;
> -	int i;
> +	int i, res = 0;
>  
>  	for (i = 1; *p; i++) {
>  		char *eol = strchrnul(p, '\n');
> -		commit = parse_insn_line(p, eol, opts);
> -		if (!commit)
> -			return error(_("Could not parse line %d."), i);
> -		next = commit_list_append(commit, next);
> +
> +		item = append_todo(todo_list);

A better name, in my personal option, would be

  +		item = todo_list_next(todo_list);

Or todo_next(todo_list).

> +		item->offset_in_buf = p - todo_list->buf.buf;
> +		if (parse_insn_line(item, p, eol)) {
> +			error("Invalid line: %.*s", (int)(eol - p), p);

This error message should, I think, be also translatable:

  +			error(_("Invalid line: %.*s"), (int)(eol - p), p);

> +			res |= error(_("Could not parse line %d."), i);

Wouldn't it make more sense to reverse order of errors, that is
first tell which line, and then show it?  

BTW. would be we able to show where exactly there was problem parsing,
that is at which character in line?  Or is it something for the future?

> +			item->command = -1;
> +		}
>  		p = *eol ? eol + 1 : eol;
>  	}
> -	if (!*todo_list)
> +	if (!todo_list->nr)
>  		return error(_("No commits parsed."));
> -	return 0;
> +	return res;

Ah, so 'res' is "was there an error" in any of lines.  Nice.

>  }
>  
> -static int read_populate_todo(struct commit_list **todo_list,
> +static int read_populate_todo(struct todo_list *todo_list,
>  			struct replay_opts *opts)
>  {
>  	const char *todo_file = get_todo_path(opts);

If I understand it correctly, replay_opts is used only to find out
correct todo_file, isn't it?

> -	struct strbuf buf = STRBUF_INIT;
>  	int fd, res;
>  
> +	strbuf_reset(&todo_list->buf);
>  	fd = open(todo_file, O_RDONLY);
>  	if (fd < 0)
>  		return error_errno(_("Could not open %s"), todo_file);
> -	if (strbuf_read(&buf, fd, 0) < 0) {
> +	if (strbuf_read(&todo_list->buf, fd, 0) < 0) {
>  		close(fd);
> -		strbuf_release(&buf);

A question: when is todo_list->buf released?

>  		return error(_("Could not read %s."), todo_file);
>  	}
>  	close(fd);
>  
> -	res = parse_insn_buffer(buf.buf, todo_list, opts);
> +	res = parse_insn_buffer(todo_list->buf.buf, todo_list);
> -	strbuf_release(&buf);
>  	if (res)
>  		return error(_("Unusable instruction sheet: %s"), todo_file);
>  	return 0;

Nice.

> @@ -848,18 +859,33 @@ static int read_populate_opts(struct replay_opts *opts)
>  	return 0;
>  }
>  
> -static int walk_revs_populate_todo(struct commit_list **todo_list,
> +static int walk_revs_populate_todo(struct todo_list *todo_list,
>  				struct replay_opts *opts)
>  {
> +	enum todo_command command = opts->action == REPLAY_PICK ?
> +		TODO_PICK : TODO_REVERT;
>  	struct commit *commit;
> -	struct commit_list **next;
>  
>  	if (prepare_revs(opts))
>  		return -1;
>  
> -	next = todo_list;
> -	while ((commit = get_revision(opts->revs)))
> -		next = commit_list_append(commit, next);
> +	while ((commit = get_revision(opts->revs))) {
> +		struct todo_item *item = append_todo(todo_list);
> +		const char *commit_buffer = get_commit_buffer(commit, NULL);

I see that you are creating todo file contents while walking revision list,
something that was left for later in current / previous implementation
of the sequencer...

[Added: I see it was done by format_todo() called from save_todo()]

> +		const char *subject;
> +		int subject_len;
> +
> +		item->command = command;
> +		item->commit = commit;
> +		item->offset_in_buf = todo_list->buf.len;
> +		subject_len = find_commit_subject(commit_buffer, &subject);
> +		strbuf_addf(&todo_list->buf, "%s %s %.*s\n",
> +			opts->action == REPLAY_PICK ?  "pick" : "revert",

Wouldn't it be simpler to use

  +			todo_command_strings[command],

Also, this string does not change during the loop, though I guess
compiler should be able to optimize it.

> +			find_unique_abbrev(commit->object.oid.hash,
> +				DEFAULT_ABBREV),
> +			subject_len, subject);

...Did format of the 'todo' file changed?  And if yes, was it in backward
compatible way, so that "git revert" or "git cherry-pick" started with
old version of Git can be continued with new version, and what is also
important (for somebody who sometimes uses system-installed Git, and
sometimes user-compiled one) the reverse: started with new, continued
with old?

> +		unuse_commit_buffer(commit, commit_buffer);
> +	}
>  	return 0;
>  }
>  
> @@ -964,30 +990,24 @@ static int sequencer_rollback(struct replay_opts *opts)
>  	return -1;
>  }
>  
> -static int save_todo(struct commit_list *todo_list, struct replay_opts *opts)
> +static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
>  {
>  	static struct lock_file todo_lock;
> -	struct strbuf buf = STRBUF_INIT;
> -	int fd;
> +	const char *todo_path = get_todo_path(opts);
> +	int next = todo_list->current, offset, fd;

The "next = todo_list->current" looks a bit strange.  Also, we do not
change todo_list->current, we use it in one place, so it can be used
directly without help of temporary / helper variable.  But that is
just my personal opinion.

Also, from 'next', 'offset' and 'fd', all those are different
uses of int: the index (int, rarely size_t), the offset in string
(formally ptrdiff_t, or size_t, but usually int), and the file descriptor.
I think from those the file descriptor could be kept in separate line;
it would help diff to be more readable.  But this is fairly marginal
nitpicking, and a matter of personal opinion.

>  
> -	fd = hold_lock_file_for_update(&todo_lock, git_path_todo_file(), 0);
> +	fd = hold_lock_file_for_update(&todo_lock, todo_path, 0);
>  	if (fd < 0)
>  		return error_errno(_("Could not lock '%s'"),
>  				   git_path_todo_file());

We should use 'todo_path' here... and this should be done in
one of earlier patches, isn't it?

This means that

  +	const char *todo_path = get_todo_path(opts);

should better be moved to earlier patch, too.

Or maybe not.  But it looks like missed git_path_todo_file() -> get_todo_path(opts)
[-> todo_path ] change.  If it was left because of planned whole rewrite,
it should be mentioned in the commit message of that earlier commit,
isn't it?

> -	if (format_todo(&buf, todo_list, opts) < 0) {
> -		strbuf_release(&buf);
> -		return error(_("Could not format %s."), git_path_todo_file());

Can we still get this error?  Could we get this error anyway,
and under what conditions?

> -	}
> -	if (write_in_full(fd, buf.buf, buf.len) < 0) {
> -		strbuf_release(&buf);
> -		return error_errno(_("Could not write to %s"),
> -				   git_path_todo_file());
> -	}
> +	offset = next < todo_list->nr ?
> +		todo_list->items[next].offset_in_buf : todo_list->buf.len;
> +	if (write_in_full(fd, todo_list->buf.buf + offset,
> +			todo_list->buf.len - offset) < 0)
> +		return error(_("Could not write to %s (%s)"),
> +			todo_path, strerror(errno));

Ah, so it saves the remaining todo_items on todo_list, not the
whole todo_list... the name does not fully show it.

> -	if (commit_lock_file(&todo_lock) < 0) {
> -		strbuf_release(&buf);
> -		return error(_("Error wrapping up %s."), git_path_todo_file());
> -	}
> -	strbuf_release(&buf);
> +	if (commit_lock_file(&todo_lock) < 0)
> +		return error(_("Error wrapping up %s."), todo_path);

Note: this is unrelated change, but we usually put paths in quotes, like this

  +		return error(_("Error wrapping up '%s'."), todo_path);

(in this and earlier error message), so that paths containing spaces show
correctly and readably to the user.  Though this possibly is not a problem
for this path.

Also, how user is to understand "wrapping up"?

>  	return 0;
>  }
>  
> @@ -1026,9 +1046,8 @@ static int save_opts(struct replay_opts *opts)
>  	return res;
>  }
>  
> -static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
> +static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  {
> -	struct commit_list *cur;
>  	int res;
>  
>  	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
> @@ -1038,10 +1057,12 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
>  	if (read_and_refresh_cache(opts))
>  		return -1;
>  
> -	for (cur = todo_list; cur; cur = cur->next) {
> +	while (todo_list->current < todo_list->nr) {

Why replace for loop with while loop?  Especially that now it
looks more for-y ;-)

  +	for ( ; todo_list->current < todo_list->nr; todo_list->current++) {

Oh... I now see why.

> +		struct todo_item *item = todo_list->items + todo_list->current;
> -		if (save_todo(cur, opts))
> +		if (save_todo(todo_list, opts))
>  			return -1;
> -		res = do_pick_commit(cur->item, opts);
> +		res = do_pick_commit(item->command, item->commit, opts);

I don't quite understand what sequencer tried to do here, but the
change looks all right.

> +		todo_list->current++;
>  		if (res)
>  			return res;
>  	}
> @@ -1066,7 +1087,8 @@ static int continue_single_pick(void)
>  
>  static int sequencer_continue(struct replay_opts *opts)
>  {
> -	struct commit_list *todo_list = NULL;
> +	struct todo_list todo_list = TODO_LIST_INIT;
> +	int res;
>  
>  	if (!file_exists(get_todo_path(opts)))
>  		return continue_single_pick();
> @@ -1083,21 +1105,24 @@ static int sequencer_continue(struct replay_opts *opts)
>  	}
>  	if (index_differs_from("HEAD", 0))
>  		return error_dirty_index(opts);
> -	todo_list = todo_list->next;
> -	return pick_commits(todo_list, opts);
> +	todo_list.current++;
> +	res = pick_commits(&todo_list, opts);
> +	todo_list_release(&todo_list);
> +	return res;

Nice.  Looks correct.

>  }
>  
>  static int single_pick(struct commit *cmit, struct replay_opts *opts)
>  {
>  	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
> -	return do_pick_commit(cmit, opts);
> +	return do_pick_commit(opts->action == REPLAY_PICK ?
> +		TODO_PICK : TODO_REVERT, cmit, opts);

The ternary conditional operator here translates one enum to other enum,
isn't it?

>  }
>  
>  int sequencer_pick_revisions(struct replay_opts *opts)
>  {
> -	struct commit_list *todo_list = NULL;
> +	struct todo_list todo_list = TODO_LIST_INIT;
>  	unsigned char sha1[20];
> -	int i;
> +	int i, res;
>  
>  	if (opts->subcommand == REPLAY_NONE)
>  		assert(opts->revs);
> @@ -1171,7 +1196,9 @@ int sequencer_pick_revisions(struct replay_opts *opts)
>  	if (save_head(sha1_to_hex(sha1)) ||
>  			save_opts(opts))
>  		return -1;
> -	return pick_commits(todo_list, opts);
> +	res = pick_commits(&todo_list, opts);
> +	todo_list_release(&todo_list);
> +	return res;

Looks correct.  And consistent.

>  }
>  
>  void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
> 


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A30B209FD
	for <e@80x24.org>; Fri, 26 May 2017 03:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163523AbdEZDQw (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 23:16:52 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35100 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163393AbdEZDQv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 23:16:51 -0400
Received: by mail-it0-f66.google.com with SMTP id 67so413598itx.2
        for <git@vger.kernel.org>; Thu, 25 May 2017 20:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7gCuYLrfw8pClvNevgkZ6vTnTzBJ6rJhXxxsmiFP9xM=;
        b=oh3RL8gQkvk7oLZLNa88CeZQZDwTYArmr5cU5R/tMqLvr1oUQzwnKx3Nd1jVEJO/04
         43PmNPehn9GUp8oNuDUH/IVV92uV9WjJc23hqHly2y0S5DvBFCUB7qYmtu2ThPl9naDc
         bhmoMDUMvv77zAO5iFDAy6VZc2VvSrSrK2CAgdGwrD+2weKYRTovkB4GM8EER80ULHGn
         jlYacCcWviG8l0tD40bB3S0OkPm/mLPXakgJlrCnHjlH4slFJ4BJirRkQh78/bs59W+1
         AGwf5ownAqD4io6nVjKLm1LwtY+SGCWyhnLg5+r161xgR/zd00nER8clbMwUiIhEFyIm
         a3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7gCuYLrfw8pClvNevgkZ6vTnTzBJ6rJhXxxsmiFP9xM=;
        b=qg63VyFmKXWMHuirp1nbP8rIcmyM5eE87BtwhitllVs/0vee9jnoGjuQqoeinwcx1w
         tZCLi20BIMkojSPZi2kRYoGvvSpM+/y1P7efv/8TQdEz7Xqnpz4lPGjEyNzw8xskPEve
         pq7veQrdpjZ0UCXPtV4OfFK9j84raBG9ldCrck/BdNayqun1Ar2EI/Uqn/klaRbKvpdU
         4pDtuuz5+Onp5YqHvKckhPPw7wTVxx39gWs1K2Wu1caVCxpOH+f5GSHnXn3P3VFntBlf
         1EUYODYwlLK551IAbw5L4M36obgtKtnvE+jc+ViqBQd6XAWB5/gGmw6+gQtm1RR3Uh/h
         tYhw==
X-Gm-Message-State: AODbwcC8RP/Dkv5/pf9b5oM7xXd3TqJ6AG2xBKqEP6oQPQ83SPSe4K2e
        d/yfi9vIAtvh2w==
X-Received: by 10.36.217.71 with SMTP id p68mr17659926itg.49.1495768610170;
        Thu, 25 May 2017 20:16:50 -0700 (PDT)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id 5sm1210650itw.23.2017.05.25.20.16.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 20:16:46 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     johannes.schindelin@gmx.de
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, phillip.wood@dunelm.org.uk
Subject: [PATCH v4 10/10] rebase -i: rearrange fixup/squash lines using the rebase--helper
Date:   Thu, 25 May 2017 23:16:39 -0400
Message-Id: <20170526031639.10790-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <6825a2bb46f43687af0565e4d38224d472932203.1493414945.git.johannes.schindelin@gmx.de>
References: <6825a2bb46f43687af0565e4d38224d472932203.1493414945.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> This operation has quadratic complexity, which is especially painful
> on Windows, where shell scripts are *already* slow (mainly due to the
> overhead of the POSIX emulation layer).
>
> Let's reimplement this with linear complexity (using a hash map to
> match the commits' subject lines) for the common case; Sadly, the
> fixup/squash feature's design neglected performance considerations,
> allowing arbitrary prefixes (read: `fixup! hell` will match the
> commit subject `hello world`), which means that we are stuck with
> quadratic performance in the worst case.
>
> The reimplemented logic also happens to fix a bug where commented-out
> lines (representing empty patches) were dropped by the previous code.
>
> While at it, clarify how the fixup/squash feature works in `git rebase
> -i`'s man page.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/git-rebase.txt |  16 ++--
>  builtin/rebase--helper.c     |   6 +-
>  git-rebase--interactive.sh   |  90 +-------------------
>  sequencer.c                  | 195 +++++++++++++++++++++++++++++++++++++++++++
>  sequencer.h                  |   1 +
>  t/t3415-rebase-autosquash.sh |   2 +-
>  6 files changed, 212 insertions(+), 98 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 53f4e144444..c5464aa5365 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -430,13 +430,15 @@ without an explicit `--interactive`.
>  --autosquash::
>  --no-autosquash::
>  	When the commit log message begins with "squash! ..." (or
> -	"fixup! ..."), and there is a commit whose title begins with
> -	the same ..., automatically modify the todo list of rebase -i
> -	so that the commit marked for squashing comes right after the
> -	commit to be modified, and change the action of the moved
> -	commit from `pick` to `squash` (or `fixup`).  Ignores subsequent
> -	"fixup! " or "squash! " after the first, in case you referred to an
> -	earlier fixup/squash with `git commit --fixup/--squash`.
> +	"fixup! ..."), and there is already a commit in the todo list that
> +	matches the same `...`, automatically modify the todo list of rebase
> +	-i so that the commit marked for squashing comes right after the
> +	commit to be modified, and change the action of the moved commit
> +	from `pick` to `squash` (or `fixup`).  A commit matches the `...` if
> +	the commit subject matches, or if the `...` refers to the commit's
> +	hash. As a fall-back, partial matches of the commit subject work,
> +	too.  The recommended way to create fixup/squash commits is by using
> +	the `--fixup`/`--squash` options of linkgit:git-commit[1].
>  +
>  This option is only valid when the `--interactive` option is used.
>  +
> diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
> index de3ccd9bfbc..e6591f01112 100644
> --- a/builtin/rebase--helper.c
> +++ b/builtin/rebase--helper.c
> @@ -14,7 +14,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  	int keep_empty = 0;
>  	enum {
>  		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_SHA1S, EXPAND_SHA1S,
> -		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS
> +		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH
>  	} command = 0;
>  	struct option options[] = {
>  		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
> @@ -33,6 +33,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  			N_("check the todo list"), CHECK_TODO_LIST),
>  		OPT_CMDMODE(0, "skip-unnecessary-picks", &command,
>  			N_("skip unnecessary picks"), SKIP_UNNECESSARY_PICKS),
> +		OPT_CMDMODE(0, "rearrange-squash", &command,
> +			N_("rearrange fixup/squash lines"), REARRANGE_SQUASH),
>  		OPT_END()
>  	};
>  
> @@ -59,5 +61,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  		return !!check_todo_list();
>  	if (command == SKIP_UNNECESSARY_PICKS && argc == 1)
>  		return !!skip_unnecessary_picks();
> +	if (command == REARRANGE_SQUASH && argc == 1)
> +		return !!rearrange_squash();
>  	usage_with_options(builtin_rebase_helper_usage, options);
>  }
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 92e3ca1de3b..84c6e62518f 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -721,94 +721,6 @@ collapse_todo_ids() {
>  	git rebase--helper --shorten-sha1s
>  }
>  
> -# Rearrange the todo list that has both "pick sha1 msg" and
> -# "pick sha1 fixup!/squash! msg" appears in it so that the latter
> -# comes immediately after the former, and change "pick" to
> -# "fixup"/"squash".
> -#
> -# Note that if the config has specified a custom instruction format
> -# each log message will be re-retrieved in order to normalize the
> -# autosquash arrangement
> -rearrange_squash () {
> -	format=$(git config --get rebase.instructionFormat)
> -	# extract fixup!/squash! lines and resolve any referenced sha1's
> -	while read -r pick sha1 message
> -	do
> -		test -z "${format}" || message=$(git log -n 1 --format="%s" ${sha1})
> -		case "$message" in
> -		"squash! "*|"fixup! "*)
> -			action="${message%%!*}"
> -			rest=$message
> -			prefix=
> -			# skip all squash! or fixup! (but save for later)
> -			while :
> -			do
> -				case "$rest" in
> -				"squash! "*|"fixup! "*)
> -					prefix="$prefix${rest%%!*},"
> -					rest="${rest#*! }"
> -					;;
> -				*)
> -					break
> -					;;
> -				esac
> -			done
> -			printf '%s %s %s %s\n' "$sha1" "$action" "$prefix" "$rest"
> -			# if it's a single word, try to resolve to a full sha1 and
> -			# emit a second copy. This allows us to match on both message
> -			# and on sha1 prefix
> -			if test "${rest#* }" = "$rest"; then
> -				fullsha="$(git rev-parse -q --verify "$rest" 2>/dev/null)"
> -				if test -n "$fullsha"; then
> -					# prefix the action to uniquely identify this line as
> -					# intended for full sha1 match
> -					echo "$sha1 +$action $prefix $fullsha"
> -				fi
> -			fi
> -		esac
> -	done >"$1.sq" <"$1"
> -	test -s "$1.sq" || return
> -
> -	used=
> -	while read -r pick sha1 message
> -	do
> -		case " $used" in
> -		*" $sha1 "*) continue ;;
> -		esac
> -		printf '%s\n' "$pick $sha1 $message"
> -		test -z "${format}" || message=$(git log -n 1 --format="%s" ${sha1})
> -		used="$used$sha1 "
> -		while read -r squash action msg_prefix msg_content
> -		do
> -			case " $used" in
> -			*" $squash "*) continue ;;
> -			esac
> -			emit=0
> -			case "$action" in
> -			+*)
> -				action="${action#+}"
> -				# full sha1 prefix test
> -				case "$msg_content" in "$sha1"*) emit=1;; esac ;;
> -			*)
> -				# message prefix test
> -				case "$message" in "$msg_content"*) emit=1;; esac ;;
> -			esac
> -			if test $emit = 1; then
> -				if test -n "${format}"
> -				then
> -					msg_content=$(git log -n 1 --format="${format}" ${squash})
> -				else
> -					msg_content="$(echo "$msg_prefix" | sed "s/,/! /g")$msg_content"
> -				fi
> -				printf '%s\n' "$action $squash $msg_content"
> -				used="$used$squash "
> -			fi
> -		done <"$1.sq"
> -	done >"$1.rearranged" <"$1"
> -	cat "$1.rearranged" >"$1"
> -	rm -f "$1.sq" "$1.rearranged"
> -}
> -
>  # Add commands after a pick or after a squash/fixup serie
>  # in the todo list.
>  add_exec_commands () {
> @@ -1068,7 +980,7 @@ then
>  fi
>  
>  test -s "$todo" || echo noop >> "$todo"
> -test -n "$autosquash" && rearrange_squash "$todo"
> +test -z "$autosquash" || git rebase--helper --rearrange-squash || exit
>  test -n "$cmd" && add_exec_commands "$todo"
>  
>  todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
> diff --git a/sequencer.c b/sequencer.c
> index 72e3ad8d145..63a588f0916 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -19,6 +19,7 @@
>  #include "trailer.h"
>  #include "log-tree.h"
>  #include "wt-status.h"
> +#include "hashmap.h"
>  
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>  
> @@ -2723,3 +2724,197 @@ int skip_unnecessary_picks(void)
>  
>  	return 0;
>  }
> +
> +struct subject2item_entry {
> +	struct hashmap_entry entry;
> +	int i;
> +	char subject[FLEX_ARRAY];
> +};
> +
> +static int subject2item_cmp(const struct subject2item_entry *a,
> +	const struct subject2item_entry *b, const void *key)
> +{
> +	return key ? strcmp(a->subject, key) : strcmp(a->subject, b->subject);
> +}
> +
> +/*
> + * Rearrange the todo list that has both "pick sha1 msg" and "pick sha1
> + * fixup!/squash! msg" in it so that the latter is put immediately after the
> + * former, and change "pick" to "fixup"/"squash".
> + *
> + * Note that if the config has specified a custom instruction format, each log
> + * message will have to be retrieved from the commit (as the oneline in the
> + * script cannot be trusted) in order to normalize the autosquash arrangement.
> + */
> +int rearrange_squash(void)
> +{
> +	const char *todo_file = rebase_path_todo();
> +	struct todo_list todo_list = TODO_LIST_INIT;
> +	struct hashmap subject2item;
> +	int res = 0, rearranged = 0, *next, *tail, fd, i;
> +	char **subjects;
> +
> +	fd = open(todo_file, O_RDONLY);
> +	if (fd < 0)
> +		return error_errno(_("could not open '%s'"), todo_file);
> +	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
> +		close(fd);
> +		return error(_("could not read '%s'."), todo_file);
> +	}
> +	close(fd);
> +	if (parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
> +		todo_list_release(&todo_list);
> +		return -1;
> +	}
> +
> +	/*
> +	 * The hashmap maps onelines to the respective todo list index.
> +	 *
> +	 * If any items need to be rearranged, the next[i] value will indicate
> +	 * which item was moved directly after the i'th.
> +	 *
> +	 * In that case, last[i] will indicate the index of the latest item to
> +	 * be moved to appear after the i'th.
> +	 */
> +	hashmap_init(&subject2item, (hashmap_cmp_fn) subject2item_cmp,
> +		     todo_list.nr);
> +	ALLOC_ARRAY(next, todo_list.nr);
> +	ALLOC_ARRAY(tail, todo_list.nr);
> +	ALLOC_ARRAY(subjects, todo_list.nr);
> +	for (i = 0; i < todo_list.nr; i++) {
> +		struct strbuf buf = STRBUF_INIT;
> +		struct todo_item *item = todo_list.items + i;
> +		const char *commit_buffer, *subject, *p;
> +		size_t subject_len;
> +		int i2 = -1;
> +		struct subject2item_entry *entry;
> +
> +		next[i] = tail[i] = -1;
> +		if (item->command >= TODO_EXEC) {
> +			subjects[i] = NULL;
> +			continue;
> +		}
> +
> +		if (is_fixup(item->command)) {
> +			todo_list_release(&todo_list);
> +			return error(_("the script was already rearranged."));
> +		}
> +
> +		item->commit->util = item;
> +
> +		parse_commit(item->commit);
> +		commit_buffer = get_commit_buffer(item->commit, NULL);
> +		find_commit_subject(commit_buffer, &subject);
> +		format_subject(&buf, subject, " ");
> +		subject = subjects[i] = strbuf_detach(&buf, &subject_len);
> +		unuse_commit_buffer(item->commit, commit_buffer);
> +		if ((skip_prefix(subject, "fixup! ", &p) ||
> +		     skip_prefix(subject, "squash! ", &p))) {
> +			struct commit *commit2;
> +
> +			for (;;) {
> +				while (isspace(*p))
> +					p++;
> +				if (!skip_prefix(p, "fixup! ", &p) &&
> +				    !skip_prefix(p, "squash! ", &p))
> +					break;
> +			}
> +
> +			if ((entry = hashmap_get_from_hash(&subject2item,
> +							   strhash(p), p)))
> +				/* found by title */
> +				i2 = entry->i;
> +			else if (!strchr(p, ' ') &&
> +				 (commit2 =
> +				  lookup_commit_reference_by_name(p)) &&
> +				 commit2->util)
> +				/* found by commit name */
> +				i2 = (struct todo_item *)commit2->util
> +					- todo_list.items;
> +			else {
> +				/* copy can be a prefix of the commit subject */
> +				for (i2 = 0; i2 < i; i2++)
> +					if (subjects[i2] &&
> +					    starts_with(subjects[i2], p))
> +						break;
> +				if (i2 == i)
> +					i2 = -1;
> +			}
> +		}
> +		if (i2 >= 0) {
> +			rearranged = 1;
> +			todo_list.items[i].command =
> +				starts_with(subject, "fixup!") ?
> +				TODO_FIXUP : TODO_SQUASH;
> +			if (next[i2] < 0)
> +				next[i2] = i;
> +			else
> +				next[tail[i2]] = i;
> +			tail[i2] = i;
> +		} else if (!hashmap_get_from_hash(&subject2item,
> +						strhash(subject), subject)) {
> +			FLEX_ALLOC_MEM(entry, subject, subject, subject_len);
> +			entry->i = i;
> +			hashmap_entry_init(entry, strhash(entry->subject));
> +			hashmap_put(&subject2item, entry);
> +		}
> +	}
> +
> +	if (rearranged) {
> +		struct strbuf buf = STRBUF_INIT;
> +
> +		for (i = 0; i < todo_list.nr; i++) {
> +			enum todo_command command = todo_list.items[i].command;
> +			int cur = i;
> +
> +			/*
> +			 * Initially, all commands are 'pick's. If it is a
> +			 * fixup or a squash now, we have rearranged it.
> +			 */
> +			if (is_fixup(command))
> +				continue;
> +
> +			while (cur >= 0) {
> +				int offset = todo_list.items[cur].offset_in_buf;
> +				int end_offset = cur + 1 < todo_list.nr ?
> +					todo_list.items[cur + 1].offset_in_buf :
> +					todo_list.buf.len;
> +				char *bol = todo_list.buf.buf + offset;
> +				char *eol = todo_list.buf.buf + end_offset;

I got a little confused with these offsets. I know it was part of a
previous series, but maybe we could add a description to the fields
of `struct todo_list` and `struct todo_item`.
Other than that, I don't have any particular comments.

> +
> +				/* replace 'pick', by 'fixup' or 'squash' */
> +				command = todo_list.items[cur].command;
> +				if (is_fixup(command)) {
> +					strbuf_addstr(&buf,
> +						todo_command_info[command].str);
> +					bol += strcspn(bol, " \t");
> +				}
> +
> +				strbuf_add(&buf, bol, eol - bol);
> +
> +				cur = next[cur];
> +			}
> +		}
> +
> +		fd = open(todo_file, O_WRONLY);
> +		if (fd < 0)
> +			res = error_errno(_("could not open '%s'"), todo_file);
> +		else if (write(fd, buf.buf, buf.len) < 0)
> +			res = error_errno(_("could not read '%s'."), todo_file);
> +		else if (ftruncate(fd, buf.len) < 0)
> +			res = error_errno(_("could not finish '%s'"),
> +					   todo_file);
> +		close(fd);
> +		strbuf_release(&buf);
> +	}
> +
> +	free(next);
> +	free(tail);
> +	for (i = 0; i < todo_list.nr; i++)
> +		free(subjects[i]);
> +	free(subjects);
> +	hashmap_free(&subject2item, 1);
> +	todo_list_release(&todo_list);
> +
> +	return res;
> +}
> diff --git a/sequencer.h b/sequencer.h
> index 28e1fc1e9bb..1c94bec7622 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -51,6 +51,7 @@ int sequencer_make_script(int keep_empty, FILE *out,
>  int transform_todo_ids(int shorten_sha1s);
>  int check_todo_list(void);
>  int skip_unnecessary_picks(void);
> +int rearrange_squash(void);
>  
>  extern const char sign_off_header[];
>  
> diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
> index 926bb3da788..2f88f50c057 100755
> --- a/t/t3415-rebase-autosquash.sh
> +++ b/t/t3415-rebase-autosquash.sh
> @@ -290,7 +290,7 @@ set_backup_editor () {
>  	test_set_editor "$PWD/backup-editor.sh"
>  }
>  
> -test_expect_failure 'autosquash with multiple empty patches' '
> +test_expect_success 'autosquash with multiple empty patches' '
>  	test_tick &&
>  	git commit --allow-empty -m "empty" &&
>  	test_tick &&
> -- 
> 2.12.2.windows.2.800.gede8f145e06

Liam

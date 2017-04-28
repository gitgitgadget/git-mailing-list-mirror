Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57B7E207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 21:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166125AbdD1VbB (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 17:31:01 -0400
Received: from mout.gmx.net ([212.227.17.20]:59083 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1165216AbdD1Va7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 17:30:59 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mg3h3-1dR5Y915cL-00NSoL; Fri, 28
 Apr 2017 23:30:44 +0200
Date:   Fri, 28 Apr 2017 23:30:42 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 00/10] The final building block for a faster rebase -i
In-Reply-To: <cover.1493207864.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1493414945.git.johannes.schindelin@gmx.de>
References: <cover.1493207864.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WUyDztotyATElwcXfiO3PUhYsZS9/pvfUvDKMwwe9N2T4pR/Di0
 LkrGyVNmdfMX+xn9pPiE8lnmgNISyXCB/zUXJUr1B2+bbYdHenUTvM14MIOWZtXAd3hrvXE
 BGmYJ8e85Od/DZ0CGIq5Q3GPJB1YeINBjidOWgLtOhiql4OBt6SxHMk0W619xZzvQ175LVp
 jbwFwGYYqBDaD2WSyyDqw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bEgkxOh3tCw=:IzstuoUdBqwqfKYINgWtrh
 B7Qpg1VrsoGQWqZxh1GnObEYth1mdfpoEQ6Bp69JPoMqLvlFR027U2kxB6jnVmP4phqcBUAKl
 leFXXSBZ1n0zCHWfB2MlUKYpFqpIdHX090Q2P6yr2Dx07kBfOr5JPksky/dm2VL0m4QHPvi+n
 MbcgjVZPaolqCMU4v00mWGUm2zme4VKsnY0W71bZkh1S8A4thSzznx9lsfc15awB8zTOa88PN
 a17qcv61ywU9BKxBxdP1l2kwaXb90Evp5RN4jGz2S3oUiS4A2jSN3Pf9D8x/lvn92qS1C3wwE
 d427lI52zJErfRBF/EdMak2vODOnudqyT+OPKuZsMxJkTTj7kRNB2HGnHrzXM8jdX448J934+
 Sgb3ct8ALEJjR7/sjrrqcaWDx29nLOrZHHK6gBUjoSMyfs0rx0V8c+tGWxiEhH/Pc0+BetYfD
 FoL2+x4Ny5abBWtdN/vaFqZwvjkrkjX1qJ9Y9luExXf8emj1bExBZ77ptpG2pCM45QNrpy2EZ
 UqgeO02or6juM264ObW/DkEe10Id24VzVXn52nsbhzii7d7gGMlw+3l2kn4q7qDN/Z0lj89kn
 ECvPqATZyNMuHnM5ix+FSlTtrGV4K7yJnLKW4PWTUWOgUXiCrX+axwNxZvmkLSf0L9IKe6/AP
 LHEDzR6uUOxR5FZAI2tKL/8p7Dfq4LxxlXLxL1AZpoX//fBTw0OBOaOAJ7YHY7anq8jqUVhxu
 cTpTl8sx2n2k7bz9ccMu8eSL0eDd/Es/U+QkQSnyJue2uzJxaZHH1vKUWS+Qw19GCiQ/ZSCKS
 ZSSlCnS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series reimplements the expensive pre- and post-processing of
the todo script in C.

And it concludes the work I did to accelerate rebase -i.

Changes since v3:

- removed the no-longer-used transform_todo_ids shell function

- simplified transform_todo_ids()'s command parsing

- fixed two commits in check_todo_list(), renamed the unclear
  `raise_error` variable to `advise_to_edit_todo`, build the message
  about missing commits directly (without the detour to building a
  commit_list) and instead of assigning an unused pointer to commit->util
  the code now uses (void *)1.

- return early from check_todo_list() when parsing failed, even if the
  check level is something else than CHECK_IGNORE

- the todo list is generated is again generated in the same way as
  before when rebase.instructionFormat is empty: it was interpreted as
  if it had not been set

- added a test for empty rebase.instructionFormat settings


Johannes Schindelin (10):
  t3415: verify that an empty instructionFormat is handled as before
  rebase -i: generate the script via rebase--helper
  rebase -i: remove useless indentation
  rebase -i: do not invent onelines when expanding/collapsing SHA-1s
  rebase -i: also expand/collapse the SHA-1s via the rebase--helper
  t3404: relax rebase.missingCommitsCheck tests
  rebase -i: check for missing commits in the rebase--helper
  rebase -i: skip unnecessary picks using the rebase--helper
  t3415: test fixup with wrapped oneline
  rebase -i: rearrange fixup/squash lines using the rebase--helper

 Documentation/git-rebase.txt  |  16 +-
 builtin/rebase--helper.c      |  29 ++-
 git-rebase--interactive.sh    | 373 ++++-------------------------
 sequencer.c                   | 530 ++++++++++++++++++++++++++++++++++++++++++
 sequencer.h                   |   8 +
 t/t3404-rebase-interactive.sh |  22 +-
 t/t3415-rebase-autosquash.sh  |  28 ++-
 7 files changed, 646 insertions(+), 360 deletions(-)


base-commit: 027a3b943b444a3e3a76f9a89803fc10245b858f
Based-On: rebase--helper at https://github.com/dscho/git
Fetch-Base-Via: git fetch https://github.com/dscho/git rebase--helper
Published-As: https://github.com/dscho/git/releases/tag/rebase-i-extra-v4
Fetch-It-Via: git fetch https://github.com/dscho/git rebase-i-extra-v4

Interdiff vs v3:

 diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
 index d39fe4f5fb7..84c6e62518f 100644
 --- a/git-rebase--interactive.sh
 +++ b/git-rebase--interactive.sh
 @@ -713,29 +713,6 @@ do_rest () {
  	done
  }
  
 -transform_todo_ids () {
 -	while read -r command rest
 -	do
 -		case "$command" in
 -		"$comment_char"* | exec)
 -			# Be careful for oddball commands like 'exec'
 -			# that do not have a SHA-1 at the beginning of $rest.
 -			;;
 -		*)
 -			sha1=$(git rev-parse --verify --quiet "$@" ${rest%%[	 ]*}) &&
 -			if test "a$rest" = "a${rest#*[	 ]}"
 -			then
 -				rest=$sha1
 -			else
 -				rest="$sha1 ${rest#*[	 ]}"
 -			fi
 -			;;
 -		esac
 -		printf '%s\n' "$command${rest:+ }$rest"
 -	done <"$todo" >"$todo.new" &&
 -	mv -f "$todo.new" "$todo"
 -}
 -
  expand_todo_ids() {
  	git rebase--helper --expand-sha1s
  }
 diff --git a/sequencer.c b/sequencer.c
 index 84f8e366761..63a588f0916 100644
 --- a/sequencer.c
 +++ b/sequencer.c
 @@ -2393,7 +2393,7 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
  int sequencer_make_script(int keep_empty, FILE *out,
  		int argc, const char **argv)
  {
 -	char *format = xstrdup("%s");
 +	char *format = NULL;
  	struct pretty_print_context pp = {0};
  	struct strbuf buf = STRBUF_INIT;
  	struct rev_info revs;
 @@ -2411,6 +2411,10 @@ int sequencer_make_script(int keep_empty, FILE *out,
  
  	revs.pretty_given = 1;
  	git_config_get_string("rebase.instructionFormat", &format);
 +	if (!format || !*format) {
 +		free(format);
 +		format = xstrdup("%s");
 +	}
  	get_commit_format(format, &revs);
  	free(format);
  	pp.fmt = revs.commit_format;
 @@ -2475,18 +2479,16 @@ int transform_todo_ids(int shorten_sha1s)
  		if (item->command >= TODO_EXEC && item->command != TODO_DROP)
  			fwrite(p, eol - bol, 1, out);
  		else {
 -			int eoc = strcspn(p, " \t");
  			const char *sha1 = shorten_sha1s ?
  				short_commit_name(item->commit) :
  				oid_to_hex(&item->commit->object.oid);
 +			int len;
  
 -			if (!eoc) {
 -				p += strspn(p, " \t");
 -				eoc = strcspn(p, " \t");
 -			}
 +			p += strspn(p, " \t"); /* left-trim command */
 +			len = strcspn(p, " \t"); /* length of command */
  
  			fprintf(out, "%.*s %s %.*s\n",
 -				eoc, p, sha1, item->arg_len, item->arg);
 +				len, p, sha1, item->arg_len, item->arg);
  		}
  	}
  	fclose(out);
 @@ -2525,8 +2527,8 @@ int check_todo_list(void)
  	enum check_level check_level = get_missing_commit_check_level();
  	struct strbuf todo_file = STRBUF_INIT;
  	struct todo_list todo_list = TODO_LIST_INIT;
 -	struct commit_list *missing = NULL;
 -	int raise_error = 0, res = 0, fd, i;
 +	struct strbuf missing = STRBUF_INIT;
 +	int advise_to_edit_todo = 0, res = 0, fd, i;
  
  	strbuf_addstr(&todo_file, rebase_path_todo());
  	fd = open(todo_file.buf, O_RDONLY);
 @@ -2540,17 +2542,17 @@ int check_todo_list(void)
  		goto leave_check;
  	}
  	close(fd);
 -	raise_error = res =
 +	advise_to_edit_todo = res =
  		parse_insn_buffer(todo_list.buf.buf, &todo_list);
  
 -	if (check_level == CHECK_IGNORE)
 +	if (res || check_level == CHECK_IGNORE)
  		goto leave_check;
  
 -	/* Get the SHA-1 of the commits */
 +	/* Mark the commits in git-rebase-todo as seen */
  	for (i = 0; i < todo_list.nr; i++) {
  		struct commit *commit = todo_list.items[i].commit;
  		if (commit)
 -			commit->util = todo_list.items + i;
 +			commit->util = (void *)1;
  	}
  
  	todo_list_release(&todo_list);
 @@ -2569,35 +2571,32 @@ int check_todo_list(void)
  	strbuf_release(&todo_file);
  	res = !!parse_insn_buffer(todo_list.buf.buf, &todo_list);
  
 -	/* Find commits that are missing after editing */
 -	for (i = 0; i < todo_list.nr; i++) {
 -		struct commit *commit = todo_list.items[i].commit;
 +	/* Find commits in git-rebase-todo.backup yet unseen */
 +	for (i = todo_list.nr - 1; i >= 0; i--) {
 +		struct todo_item *item = todo_list.items + i;
 +		struct commit *commit = item->commit;
  		if (commit && !commit->util) {
 -			commit_list_insert(commit, &missing);
 -			commit->util = todo_list.items + i;
 +			strbuf_addf(&missing, " - %s %.*s\n",
 +				    short_commit_name(commit),
 +				    item->arg_len, item->arg);
 +			commit->util = (void *)1;
  		}
  	}
  
  	/* Warn about missing commits */
 -	if (!missing)
 +	if (!missing.len)
  		goto leave_check;
  
  	if (check_level == CHECK_ERROR)
 -		raise_error = res = 1;
 +		advise_to_edit_todo = res = 1;
  
  	fprintf(stderr,
  		_("Warning: some commits may have been dropped accidentally.\n"
  		"Dropped commits (newer to older):\n"));
  
  	/* Make the list user-friendly and display */
 -	while (missing) {
 -		struct commit *commit = pop_commit(&missing);
 -		struct todo_item *item = commit->util;
 -
 -		fprintf(stderr, " - %s %.*s\n", short_commit_name(commit),
 -			item->arg_len, item->arg);
 -	}
 -	free_commit_list(missing);
 +	fputs(missing.buf, stderr);
 +	strbuf_release(&missing);
  
  	fprintf(stderr, _("To avoid this message, use \"drop\" to "
  		"explicitly remove a commit.\n\n"
 @@ -2609,7 +2608,7 @@ int check_todo_list(void)
  	strbuf_release(&todo_file);
  	todo_list_release(&todo_list);
  
 -	if (raise_error)
 +	if (advise_to_edit_todo)
  		fprintf(stderr,
  			_("You can fix this with 'git rebase --edit-todo' "
  			  "and then run 'git rebase --continue'.\n"
 diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
 index b9e26008a79..2f88f50c057 100755
 --- a/t/t3415-rebase-autosquash.sh
 +++ b/t/t3415-rebase-autosquash.sh
 @@ -271,6 +271,18 @@ test_expect_success 'autosquash with custom inst format' '
  	test 2 = $(git cat-file commit HEAD^ | grep squash | wc -l)
  '
  
 +test_expect_success 'autosquash with empty custom instructionFormat' '
 +	git reset --hard base &&
 +	test_commit empty-instructionFormat-test &&
 +	(
 +		set_cat_todo_editor &&
 +		test_must_fail git -c rebase.instructionFormat= \
 +			rebase --autosquash  --force -i HEAD^ >actual &&
 +		git log -1 --format="pick %h %s" >expect &&
 +		test_cmp expect actual
 +	)
 +'
 +
  set_backup_editor () {
  	write_script backup-editor.sh <<-\EOF
  	cp "$1" .git/backup-"$(basename "$1")"

-- 
2.12.2.windows.2.800.gede8f145e06


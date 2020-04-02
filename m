Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12E2C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 15:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9A020675
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 15:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8PHdM1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389290AbgDBPY6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:24:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39310 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388234AbgDBPY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 11:24:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so4696767wrt.6
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 08:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UO3dVHf8HAdhcRu/bkniIpvvz4soq7Wl//G5WtcnPv0=;
        b=P8PHdM1ruFmDTIUzAuf4SnQgYHsyTZucvD419OtjO0O3sg6bydSNYjYURR4BXc/+MM
         aoEnQehG0nyp6fN4KGKF29waM+329lq/iKpGVBDemkvpz8r6x7f2V1bXPSqhbEOIxLGh
         8tasO+q48U5HZ0zsS6YFaMIvJhZePwja1h4YDpEIeJ1PQNvPzaEgeRN0SfV2ub/LFztt
         sOhg/KTazaH947UQ/QmvGzJiy7kko1dxjiOCpm7Lzztb0JwKw27TEw/GT/sGVYFl+yTy
         rEkr129ynYKBVVcUZ8TikfRKncKFL8qEFgKThSbVEF6mtiHVVDFIi1MY+B45ZhA32yG9
         +reg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UO3dVHf8HAdhcRu/bkniIpvvz4soq7Wl//G5WtcnPv0=;
        b=AKk6cFhJC6r1Y/nymqzQ2g5SJ87Ny4vqtL01icLR9gElu8AF07vz77GMBelFLCQJtf
         4RsfIy6FOmmVpiUbT3rasArRUgj3gNqlMQL33GcA8jvhwuckgM7TNPc/xerQxoy99x5e
         NcotIr0RM+hLIadLJz6t1DrBZZ694qH+xXkPifGZMeruexWKO7rxgXPOk1vjB9aHFwOZ
         sQhXRVHmDv8lFJGFZDqg7GgcXX8wgEDMBBr6D3PkB1/BMxrnyMTp4PmdeoG/XeRVvs9b
         cFTL3sP6qDO9pmfq2SirFL2FBj5AqT7sE5bKiNMw6I4AAdcjbTaQZGjSOtbRjmUzG140
         w8oQ==
X-Gm-Message-State: AGi0PuYvN+DkzOySVvrZVkJ8ajVVC73XskPlxEhHYPrZ+pB3IffUy3fn
        6DIetuWESGcla1L6qC80CnU=
X-Google-Smtp-Source: APiQypKFuOG3Ehk1PvrnHX6MP6hsSXC/+02HbLoMPdoSu/JIX1tZ3sjpReVgxt6ew/c6+nObhC6P0Q==
X-Received: by 2002:adf:f2c5:: with SMTP id d5mr2144276wrp.409.1585841096263;
        Thu, 02 Apr 2020 08:24:56 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id h81sm8266614wme.42.2020.04.02.08.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 08:24:55 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 17/19] merge: teach --autostash option
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1577185374.git.liu.denton@gmail.com>
 <cover.1584782450.git.liu.denton@gmail.com>
 <9e3d4393cae8813cc4718c6ffcc28231b1344fbe.1584782450.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <cd7cb5aa-0a08-29dc-e1cc-f65a4010622f@gmail.com>
Date:   Thu, 2 Apr 2020 16:24:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9e3d4393cae8813cc4718c6ffcc28231b1344fbe.1584782450.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 21/03/2020 09:21, Denton Liu wrote:
> In rebase, one can pass the `--autostash` option to cause the worktree
> to be automatically stashed before continuing with the rebase. This
> option is missing in merge, however.
> 
> Implement the `--autostash` option and corresponding `merge.autoStash`
> option in merge which stashes before merging and then pops after.
> 
> This option is useful when a developer has some local changes on a topic
> branch but they realize that their work depends on another branch.
> Previously, they had to run something like
> 
> 	git fetch ...
> 	git stash push
> 	git merge FETCH_HEAD
> 	git stash pop
> 
> but now, that is reduced to
> 
> 	git fetch ...
> 	git merge --autostash FETCH_HEAD
> 
> When `git reset --hard` is run to abort a merge, the working tree will
> be left in a clean state, as expected, with the autostash pushed onto
> the stash stack.
> 
> Suggested-by: Alban Gruin <alban.gruin@gmail.com>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>   Documentation/config/merge.txt  |  10 +++
>   Documentation/merge-options.txt |   8 +++
>   branch.c                        |   1 +
>   builtin/commit.c                |   2 +
>   builtin/merge.c                 |  17 ++++++
>   builtin/reset.c                 |   7 ++-
>   path.c                          |   1 +
>   path.h                          |   4 +-
>   t/t3033-merge-toplevel.sh       |  22 +++++++
>   t/t7600-merge.sh                | 104 ++++++++++++++++++++++++++++++++
>   10 files changed, 174 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
> index 6a313937f8..88b29127bf 100644
> --- a/Documentation/config/merge.txt
> +++ b/Documentation/config/merge.txt
> @@ -70,6 +70,16 @@ merge.stat::
>   	Whether to print the diffstat between ORIG_HEAD and the merge result
>   	at the end of the merge.  True by default.
>   
> +merge.autoStash::
> +	When set to true, automatically create a temporary stash entry
> +	before the operation begins, and apply it after the operation
> +	ends.  This means that you can run rebase

copy and paste error - s/rebase/merge/

> on a dirty worktree.
> +	However, use with care: the final stash application after a
> +	successful rebase might result in non-trivial conflicts.
> +	This option can be overridden by the `--no-autostash` and
> +	`--autostash` options of linkgit:git-merge[1].
> +	Defaults to false.
> +
>   merge.tool::
>   	Controls which merge tool is used by linkgit:git-mergetool[1].
>   	The list below shows the valid built-in values.
> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index 40dc4f5e8c..34493eb58b 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -155,6 +155,14 @@ ifndef::git-pull[]
>   	Note that not all merge strategies may support progress
>   	reporting.
>   
> +--autostash::
> +--no-autostash::
> +	Automatically create a temporary stash entry before the operation
> +	begins, and apply it after the operation ends.  This means
> +	that you can run rebase on a dirty worktree.  However, use > +	with care: the final stash application after a successful
> +	rebase might result in non-trivial conflicts.

s/rebase/merge/

> +
>   endif::git-pull[]
>   
>   --allow-unrelated-histories::
> diff --git a/branch.c b/branch.c
> index 579494738a..bf2536c70d 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -344,6 +344,7 @@ void remove_merge_branch_state(struct repository *r)
>   	unlink(git_path_merge_rr(r));
>   	unlink(git_path_merge_msg(r));
>   	unlink(git_path_merge_mode(r));
> +	apply_autostash(git_path_merge_autostash(r));
>   }
>   
>   void remove_branch_state(struct repository *r, int verbose)
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 7ba33a3bec..c11894423a 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1687,6 +1687,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>   	unlink(git_path_merge_mode(the_repository));
>   	unlink(git_path_squash_msg(the_repository));
>   
> +	apply_autostash(git_path_merge_autostash(the_repository));
> +

It's hard to tell from the limited context but do we want to run 
commit_index_files() before applying the autostash? I wonder if this 
should be using remove_merge_branch_state() instead of duplicating it as 
well.

>   	if (commit_index_files())
>   		die(_("repository has been updated, but unable to write\n"
>   		      "new_index file. Check that disk is not full and quota is\n"
> diff --git a/builtin/merge.c b/builtin/merge.c
> index d127d2225f..e038bef5ad 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -82,6 +82,7 @@ static int show_progress = -1;
>   static int default_to_upstream = 1;
>   static int signoff;
>   static const char *sign_commit;
> +static int autostash;
>   static int no_verify;
>   
>   static struct strategy all_strategy[] = {
> @@ -286,6 +287,8 @@ static struct option builtin_merge_options[] = {
>   	OPT_SET_INT(0, "progress", &show_progress, N_("force progress reporting"), 1),
>   	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
>   	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> +	OPT_BOOL(0, "autostash", &autostash,
> +	      N_("automatically stash/stash pop before and after")),

If we're adding this option to several commands (rebase, merge, pull) 
then it might be worth defining it in parse-options.h

>   	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
>   	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
>   	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass pre-merge-commit and commit-msg hooks")),
> @@ -441,6 +444,7 @@ static void finish(struct commit *head_commit,
>   		strbuf_addf(&reflog_message, "%s: %s",
>   			getenv("GIT_REFLOG_ACTION"), msg);
>   	}
> +	apply_autostash(git_path_merge_autostash(the_repository));
>   	if (squash) {
>   		squash_message(head_commit, remoteheads);
>   	} else {
> @@ -634,6 +638,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
>   		return 0;
>   	} else if (!strcmp(k, "gpg.mintrustlevel")) {
>   		check_trust_level = 0;
> +	} else if (!strcmp(k, "merge.autostash")) {
> +		autostash = git_config_bool(k, v);
> +		return 0;
>   	}
>   
>   	status = fmt_merge_msg_config(k, v, cb);
> @@ -1291,6 +1298,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>   
>   		/* Invoke 'git reset --merge' */
>   		ret = cmd_reset(nargc, nargv, prefix);
> +		apply_autostash(git_path_merge_autostash(the_repository));
>   		goto done;
>   	}
>   
> @@ -1513,6 +1521,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>   			goto done;
>   		}
>   
> +		if (autostash)
> +			create_autostash(the_repository,
> +					 git_path_merge_autostash(the_repository),
> +					 "merge");
>   		if (checkout_fast_forward(the_repository,
>   					  &head_commit->object.oid,
>   					  &commit->object.oid,
> @@ -1579,6 +1591,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>   	if (fast_forward == FF_ONLY)
>   		die(_("Not possible to fast-forward, aborting."));
>   
> +	if (autostash)
> +		create_autostash(the_repository,
> +				 git_path_merge_autostash(the_repository),
> +				 "merge");
> +
>   	/* We are going to make a new commit. */
>   	git_committer_info(IDENT_STRICT);
>   
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 18228c312e..038c8532eb 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -25,6 +25,7 @@
>   #include "cache-tree.h"
>   #include "submodule.h"
>   #include "submodule-config.h"
> +#include "sequencer.h"
>   
>   #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
>   
> @@ -437,8 +438,12 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>   		if (reset_type == HARD && !update_ref_status && !quiet)
>   			print_new_head_line(lookup_commit_reference(the_repository, &oid));
>   	}
> -	if (!pathspec.nr)
> +	if (!pathspec.nr) {
> +		if (reset_type == HARD)
> +			save_autostash(git_path_merge_autostash(the_repository));
> +
>   		remove_branch_state(the_repository, 0);

This removes the autostash file for all reset types but we only keep the 
stash in the case of 'reset --hard' which is confusing.

Best Wishes

Phillip

> +	}
>   
>   	return update_ref_status;
>   }
> diff --git a/path.c b/path.c
> index 88cf593007..d764738146 100644
> --- a/path.c
> +++ b/path.c
> @@ -1535,5 +1535,6 @@ REPO_GIT_PATH_FUNC(merge_msg, "MERGE_MSG")
>   REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")
>   REPO_GIT_PATH_FUNC(merge_mode, "MERGE_MODE")
>   REPO_GIT_PATH_FUNC(merge_head, "MERGE_HEAD")
> +REPO_GIT_PATH_FUNC(merge_autostash, "MERGE_AUTOSTASH")
>   REPO_GIT_PATH_FUNC(fetch_head, "FETCH_HEAD")
>   REPO_GIT_PATH_FUNC(shallow, "shallow")
> diff --git a/path.h b/path.h
> index 14d6dcad16..1f1bf8f87a 100644
> --- a/path.h
> +++ b/path.h
> @@ -177,11 +177,12 @@ struct path_cache {
>   	const char *merge_rr;
>   	const char *merge_mode;
>   	const char *merge_head;
> +	const char *merge_autostash;
>   	const char *fetch_head;
>   	const char *shallow;
>   };
>   
> -#define PATH_CACHE_INIT { NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL }
> +#define PATH_CACHE_INIT { NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL }
>   
>   const char *git_path_cherry_pick_head(struct repository *r);
>   const char *git_path_revert_head(struct repository *r);
> @@ -190,6 +191,7 @@ const char *git_path_merge_msg(struct repository *r);
>   const char *git_path_merge_rr(struct repository *r);
>   const char *git_path_merge_mode(struct repository *r);
>   const char *git_path_merge_head(struct repository *r);
> +const char *git_path_merge_autostash(struct repository *r);
>   const char *git_path_fetch_head(struct repository *r);
>   const char *git_path_shallow(struct repository *r);
>   
> diff --git a/t/t3033-merge-toplevel.sh b/t/t3033-merge-toplevel.sh
> index d314599428..e29c284b9b 100755
> --- a/t/t3033-merge-toplevel.sh
> +++ b/t/t3033-merge-toplevel.sh
> @@ -142,6 +142,17 @@ test_expect_success 'refuse two-project merge by default' '
>   	test_must_fail git merge five
>   '
>   
> +test_expect_success 'refuse two-project merge by default, quit before --autostash happens' '
> +	t3033_reset &&
> +	git reset --hard four &&
> +	echo change >>one.t &&
> +	git diff >expect &&
> +	test_must_fail git merge --autostash five 2>err &&
> +	test_i18ngrep ! "stash" err &&
> +	git diff >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'two-project merge with --allow-unrelated-histories' '
>   	t3033_reset &&
>   	git reset --hard four &&
> @@ -149,4 +160,15 @@ test_expect_success 'two-project merge with --allow-unrelated-histories' '
>   	git diff --exit-code five
>   '
>   
> +test_expect_success 'two-project merge with --allow-unrelated-histories with --autostash' '
> +	t3033_reset &&
> +	git reset --hard four &&
> +	echo change >>one.t &&
> +	git diff one.t >expect &&
> +	git merge --allow-unrelated-histories --autostash five 2>err &&
> +	test_i18ngrep "Applied autostash." err &&
> +	git diff one.t >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_done
> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 4fa0ef8e3b..c08e4315f4 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -30,13 +30,17 @@ Testing basic merge operations/option parsing.
>   . "$TEST_DIRECTORY"/lib-gpg.sh
>   
>   test_write_lines 1 2 3 4 5 6 7 8 9 >file
> +cp file file.orig
>   test_write_lines '1 X' 2 3 4 5 6 7 8 9 >file.1
> +test_write_lines 1 2 '3 X' 4 5 6 7 8 9 >file.3
>   test_write_lines 1 2 3 4 '5 X' 6 7 8 9 >file.5
>   test_write_lines 1 2 3 4 5 6 7 8 '9 X' >file.9
>   test_write_lines 1 2 3 4 5 6 7 8 '9 Y' >file.9y
>   test_write_lines '1 X' 2 3 4 5 6 7 8 9 >result.1
>   test_write_lines '1 X' 2 3 4 '5 X' 6 7 8 9 >result.1-5
> +test_write_lines '1 X' 2 3 4 5 6 7 8 '9 X' >result.1-9
>   test_write_lines '1 X' 2 3 4 '5 X' 6 7 8 '9 X' >result.1-5-9
> +test_write_lines '1 X' 2 '3 X' 4 '5 X' 6 7 8 '9 X' >result.1-3-5-9
>   test_write_lines 1 2 3 4 5 6 7 8 '9 Z' >result.9z
>   
>   create_merge_msgs () {
> @@ -675,6 +679,106 @@ test_expect_success 'refresh the index before merging' '
>   	git merge c3
>   '
>   
> +test_expect_success 'merge with --autostash' '
> +	git reset --hard c1 &&
> +	git merge-file file file.orig file.9 &&
> +	git merge --autostash c2 2>err &&
> +	test_i18ngrep "Applied autostash." err &&
> +	git show HEAD:file >merge-result &&
> +	test_cmp result.1-5 merge-result &&
> +	test_cmp result.1-5-9 file
> +'
> +
> +test_expect_success 'merge with merge.autoStash' '
> +	test_config merge.autoStash true &&
> +	git reset --hard c1 &&
> +	git merge-file file file.orig file.9 &&
> +	git merge c2 2>err &&
> +	test_i18ngrep "Applied autostash." err &&
> +	git show HEAD:file >merge-result &&
> +	test_cmp result.1-5 merge-result &&
> +	test_cmp result.1-5-9 file
> +'
> +
> +test_expect_success 'fast-forward merge with --autostash' '
> +	git reset --hard c0 &&
> +	git merge-file file file.orig file.5 &&
> +	git merge --autostash c1 2>err &&
> +	test_i18ngrep "Applied autostash." err &&
> +	test_cmp result.1-5 file
> +'
> +
> +test_expect_success 'octopus merge with --autostash' '
> +	git reset --hard c1 &&
> +	git merge-file file file.orig file.3 &&
> +	git merge --autostash c2 c3 2>err &&
> +	test_i18ngrep "Applied autostash." err &&
> +	git show HEAD:file >merge-result &&
> +	test_cmp result.1-5-9 merge-result &&
> +	test_cmp result.1-3-5-9 file
> +'
> +
> +test_expect_success 'conflicted merge with --autostash, --abort restores stash' '
> +	git reset --hard c3 &&
> +	cp file.1 file &&
> +	test_must_fail git merge --autostash c7 &&
> +	git merge --abort 2>err &&
> +	test_i18ngrep "Applied autostash." err &&
> +	test_cmp file.1 file
> +'
> +
> +test_expect_success 'completed merge with --no-commit and --autostash' '
> +	git reset --hard c1 &&
> +	git merge-file file file.orig file.9 &&
> +	git diff >expect &&
> +	git merge --no-commit --autostash c2 &&
> +	git stash show -p MERGE_AUTOSTASH >actual &&
> +	test_cmp expect actual &&
> +	git commit 2>err &&
> +	test_i18ngrep "Applied autostash." err &&
> +	git show HEAD:file >merge-result &&
> +	test_cmp result.1-5 merge-result &&
> +	test_cmp result.1-5-9 file
> +'
> +
> +test_expect_success 'aborted merge (merge --abort) with --no-commit and --autostash' '
> +	git reset --hard c1 &&
> +	git merge-file file file.orig file.9 &&
> +	git diff >expect &&
> +	git merge --no-commit --autostash c2 &&
> +	git stash show -p MERGE_AUTOSTASH >actual &&
> +	test_cmp expect actual &&
> +	git merge --abort 2>err &&
> +	test_i18ngrep "Applied autostash." err &&
> +	git diff >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'aborted merge (reset --hard) with --no-commit and --autostash' '
> +	git reset --hard c1 &&
> +	git merge-file file file.orig file.9 &&
> +	git diff >expect &&
> +	git merge --no-commit --autostash c2 &&
> +	git stash show -p MERGE_AUTOSTASH >actual &&
> +	test_cmp expect actual &&
> +	git reset --hard 2>err &&
> +	test_i18ngrep "Autostash exists; creating a new stash entry." err &&
> +	git diff --exit-code
> +'
> +
> +test_expect_success 'merge with conflicted --autostash changes' '
> +	git reset --hard c1 &&
> +	git merge-file file file.orig file.9y &&
> +	git diff >expect &&
> +	test_when_finished "test_might_fail git stash drop" &&
> +	git merge --autostash c3 2>err &&
> +	test_i18ngrep "Applying autostash resulted in conflicts." err &&
> +	git show HEAD:file >merge-result &&
> +	test_cmp result.1-9 merge-result &&
> +	git stash show -p >actual &&
> +	test_cmp expect actual
> +'
> +
>   cat >expected.branch <<\EOF
>   Merge branch 'c5-branch' (early part)
>   EOF
> 

From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v5] worktree: add: introduce --checkout option
Date: Tue, 29 Mar 2016 11:54:02 +0100
Message-ID: <20160329105402.GB1578@serenity.lan>
References: <01020153bcda5e6c-2bae9b68-6669-4f29-a512-136c42722001-000000@eu-west-1.amazonses.com>
 <01020153c1dae323-b918e73f-f116-4760-9747-9aa8cafb2db5-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ray Zhang <zhanglei002@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 13:08:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akrHv-0003pk-QZ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 12:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756789AbcC2KyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 06:54:16 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:58575 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756678AbcC2KyP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 06:54:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 6B880866041;
	Tue, 29 Mar 2016 11:54:14 +0100 (BST)
X-Quarantine-ID: <rSh9WSG-q4QT>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_40=-0.001, URIBL_BLOCKED=0.001]
	autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rSh9WSG-q4QT; Tue, 29 Mar 2016 11:54:09 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 84675CDA521;
	Tue, 29 Mar 2016 11:54:03 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <01020153c1dae323-b918e73f-f116-4760-9747-9aa8cafb2db5-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290116>

On Tue, Mar 29, 2016 at 10:11:01AM +0000, Ray Zhang wrote:
> By adding this option which defaults to true, we can use the
> corresponding --no-checkout to make some customizations before
> the checkout, like sparse checkout, etc.
> 
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Ray Zhang <zhanglei002@gmail.com>
> ---
> Changes since last version of this patch[v4]:
> 	t/t2025-worktree-add.sh: use test -e to test file existence.
> 	builtin/worktree.c: refactor the code a little bit.
> 
> [v4]: http://article.gmane.org/gmane.comp.version-control.git/290030
> [v3]: http://article.gmane.org/gmane.comp.version-control.git/289877
> [v2]: http://article.gmane.org/gmane.comp.version-control.git/289713
> [v1]: http://article.gmane.org/gmane.comp.version-control.git/289659
> ---
>  Documentation/git-worktree.txt |  8 +++++++-
>  builtin/worktree.c             | 29 ++++++++++++++++++-----------
>  t/t2025-worktree-add.sh        | 12 ++++++++++++
>  3 files changed, 37 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 62c76c1..c622345 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -9,7 +9,7 @@ git-worktree - Manage multiple working trees
>  SYNOPSIS
>  --------
>  [verse]
> -'git worktree add' [-f] [--detach] [-b <new-branch>] <path> [<branch>]
> +'git worktree add' [-f] [--detach] [--checkout] [-b <new-branch>] <path> [<branch>]
>  'git worktree prune' [-n] [-v] [--expire <expire>]
>  'git worktree list' [--porcelain]
>  
> @@ -87,6 +87,12 @@ OPTIONS
>  	With `add`, detach HEAD in the new working tree. See "DETACHED HEAD"
>  	in linkgit:git-checkout[1].
>  
> +--[no-]checkout::

This should be:

--checkout::
--no-checkout::

(see for example --progress in Documentation/merge-options.txt).

> +	By default, `add` checks out `<branch>`, however, `--no-checkout` can
> +	be used to suppress checkout in order to make customizations,
> +	such as configuring sparse-checkout. See "Sparse checkout"
> +	in linkgit:git-read-tree[1].
> +
>  -n::
>  --dry-run::
>  	With `prune`, do not remove anything; just report what it would
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 38b5609..d8e3795 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -21,6 +21,7 @@ static const char * const worktree_usage[] = {
>  struct add_opts {
>  	int force;
>  	int detach;
> +	int checkout;
>  	const char *new_branch;
>  	int force_new_branch;
>  };
> @@ -284,18 +285,22 @@ static int add_worktree(const char *path, const char *refname,
>  	if (ret)
>  		goto done;
>  
> -	cp.argv = NULL;
> -	argv_array_clear(&cp.args);
> -	argv_array_pushl(&cp.args, "reset", "--hard", NULL);
> -	cp.env = child_env.argv;
> -	ret = run_command(&cp);
> -	if (!ret) {
> -		is_junk = 0;
> -		free(junk_work_tree);
> -		free(junk_git_dir);
> -		junk_work_tree = NULL;
> -		junk_git_dir = NULL;
> +	if (opts->checkout) {
> +		cp.argv = NULL;
> +		argv_array_clear(&cp.args);
> +		argv_array_pushl(&cp.args, "reset", "--hard", NULL);
> +		cp.env = child_env.argv;
> +		ret = run_command(&cp);
> +		if (ret)
> +			goto done;
>  	}
> +
> +	is_junk = 0;
> +	free(junk_work_tree);
> +	free(junk_git_dir);
> +	junk_work_tree = NULL;
> +	junk_git_dir = NULL;
> +
>  done:
>  	strbuf_reset(&sb);
>  	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
> @@ -320,10 +325,12 @@ static int add(int ac, const char **av, const char *prefix)
>  		OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
>  			   N_("create or reset a branch")),
>  		OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit")),
> +		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
>  		OPT_END()
>  	};
>  
>  	memset(&opts, 0, sizeof(opts));
> +	opts.checkout = 1;
>  	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
>  	if (!!opts.detach + !!opts.new_branch + !!new_branch_force > 1)
>  		die(_("-b, -B, and --detach are mutually exclusive"));
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> index cbfa41e..3acb992 100755
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -213,4 +213,16 @@ test_expect_success 'local clone from linked checkout' '
>  	( cd here-clone && git fsck )
>  '
>  
> +test_expect_success '"add" worktree with --no-checkout' '
> +	git worktree add --no-checkout -b swamp swamp &&
> +	! test -e swamp/init.t &&
> +	git -C swamp reset --hard &&
> +	test_cmp init.t swamp/init.t
> +'
> +
> +test_expect_success '"add" worktree with --checkout' '
> +	git worktree add --checkout -b swmap2 swamp2 &&
> +	test_cmp init.t swamp2/init.t
> +'
> +
>  test_done
> 
> --
> https://github.com/git/git/pull/217
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

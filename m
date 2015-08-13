From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 2/2 v4] worktree: add 'list' command
Date: Thu, 13 Aug 2015 15:26:29 -0400
Organization: Twitter
Message-ID: <1439493989.8855.18.camel@twopensource.com>
References: <1439490739-9361-1-git-send-email-rappazzo@gmail.com>
	 <1439490739-9361-3-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, sunshine@sunshineco.com, git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 21:26:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPy97-0001DL-1X
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 21:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbbHMT0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 15:26:32 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:35312 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbbHMT0c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 15:26:32 -0400
Received: by qgj62 with SMTP id 62so38167965qgj.2
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 12:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=tLIFxxNd9I2tZ3K/xiWodfxlkDeGyj5LNYsuZm6FHv4=;
        b=DRBeNoXlAvuVXYVUDqWiV/8Of31kSwhhanFtNdJq0kJj0egxotxkzXMyG9nFcMi9iH
         Y6TqJr8djzSAJKe8Cbro/yR7KrFMo1jQWkW2IuQE23Vio6vGOLZFAnVjGjrX+9f+kaKm
         3uUZmypMdQ2UbvBU4yMECLT0+6SdAu72O4AVH/plF14QVqHrc4ZWjIwqD2my5wqJiBg/
         5+qFdNG0zlxJlmedamiwXi7W6gByrZ8O6EW01/25rPaLmiGlmiQRMtpP/C6YIpWkP50d
         fdY1Qkva2FvypDnae4lnQrJI8EouCOMvUuiS0MhQxELTs0DLZtLqoACP3ujblFaNt1dL
         xCVQ==
X-Gm-Message-State: ALoCoQnibsX6tAkG1xl6tqMGPuMUhBkkF78/45EVGG6Sd02y/0jHGtXMkiUeLu55gGF02XMWuhCz
X-Received: by 10.140.238.3 with SMTP id j3mr20668301qhc.14.1439493991331;
        Thu, 13 Aug 2015 12:26:31 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id i35sm1642938qkh.36.2015.08.13.12.26.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2015 12:26:30 -0700 (PDT)
In-Reply-To: <1439490739-9361-3-git-send-email-rappazzo@gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275889>

On Thu, 2015-08-13 at 14:32 -0400, Michael Rappazzo wrote:
> 'git worktree list' uses the for_each_worktree function to iterate,
> and outputs in the format: '<worktree>  (<short-ref>)'

I'm not sure I'm going to have time to review the whole thing, but I
think we ought to have tests with both bare and non-bare main repos.

> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
>  Documentation/git-worktree.txt | 11 ++++++++-
>  builtin/worktree.c             | 55 ++++++++++++++++++++++++++++++++++++++++++
>  t/t2027-worktree-list.sh       | 51 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 116 insertions(+), 1 deletion(-)
>  create mode 100755 t/t2027-worktree-list.sh
> 
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index fb68156..e953b4e 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -11,6 +11,7 @@ SYNOPSIS
>  [verse]
>  'git worktree add' [-f] [--detach] [-b <new-branch>] <path> [<branch>]
>  'git worktree prune' [-n] [-v] [--expire <expire>]
> +'git worktree list' [--path-only]
>  
>  DESCRIPTION
>  -----------
> @@ -59,6 +60,12 @@ prune::
>  
>  Prune working tree information in $GIT_DIR/worktrees.
>  
> +list::
> +
> +List the main worktree followed by all of the linked worktrees.  The default
> +format of the list includes the full path to the worktree and the branch or
> +revision that the head of that worktree is currently pointing to.
> +
>  OPTIONS
>  -------
>  
> @@ -93,6 +100,9 @@ OPTIONS
>  --expire <time>::
>  	With `prune`, only expire unused working trees older than <time>.
>  
> +--path-only
> +	With `list`, only show the worktree path
> +
>  DETAILS
>  -------
>  Each linked working tree has a private sub-directory in the repository's
> @@ -167,7 +177,6 @@ performed manually, such as:
>  - `remove` to remove a linked working tree and its administrative files (and
>    warn if the working tree is dirty)
>  - `mv` to move or rename a working tree and update its administrative files
> -- `list` to list linked working trees
>  - `lock` to prevent automatic pruning of administrative files (for instance,
>    for a working tree on a portable device)
>  
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index a43e360..b39ecbd 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -12,6 +12,7 @@
>  static const char * const worktree_usage[] = {
>  	N_("git worktree add [<options>] <path> <branch>"),
>  	N_("git worktree prune [<options>]"),
> +	N_("git worktree list [<options>]"),
>  	NULL
>  };
>  
> @@ -443,6 +444,58 @@ done:
>  	return ret;
>  }
>  
> +/* list callback data */
> +struct list_opts {
> +	int path_only;
> +};
> +
> +static int print_worktree_details(const char *path, const char *git_dir, void *cb_data)
> +{
> +	struct strbuf head_file = STRBUF_INIT;
> +	struct strbuf head_ref = STRBUF_INIT;
> +	struct stat st;
> +	struct list_opts *opts = cb_data;
> +	const char *ref_prefix = "ref: refs/heads/";
> +
> +	strbuf_addf(&head_file, "%s/HEAD", git_dir);
> +	if (!opts->path_only && !stat(head_file.buf, &st)) {
> +		strbuf_read_file(&head_ref, head_file.buf, st.st_size);
> +		strbuf_strip_suffix(&head_ref, "\n");
> +
> +		if (starts_with(head_ref.buf, ref_prefix)) {
> +			/* branch checked out */
> +			strbuf_remove(&head_ref, 0, strlen(ref_prefix));
> +		/* } else {
> +		 *  headless -- no-op
> +		 */
> +		}
> +		printf("%s  (%s)\n", path, head_ref.buf);
> +	} else {
> +		printf("%s\n", path);
> +	}
> +
> +	strbuf_release(&head_ref);
> +	strbuf_release(&head_file);
> +	return 0;
> +}
> +
> +static int list(int ac, const char **av, const char *prefix)
> +{
> +	struct list_opts opts;
> +	struct option options[] = {
> +		OPT_BOOL(0, "path-only", &opts.path_only, N_("only show the path of the worktree")),
> +		OPT_END()
> +	};
> +
> +	opts.path_only = 0;
> +
> +	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
> +	if (ac)
> +		usage_with_options(worktree_usage, options);
> +
> +	return for_each_worktree(&print_worktree_details, &opts);
> +}
> +
>  int cmd_worktree(int ac, const char **av, const char *prefix)
>  {
>  	struct option options[] = {
> @@ -455,5 +508,7 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
>  		return add(ac - 1, av + 1, prefix);
>  	if (!strcmp(av[1], "prune"))
>  		return prune(ac - 1, av + 1, prefix);
> +	if (!strcmp(av[1], "list"))
> +		return list(ac - 1, av + 1, prefix);
>  	usage_with_options(worktree_usage, options);
>  }
> diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
> new file mode 100755
> index 0000000..220f98e
> --- /dev/null
> +++ b/t/t2027-worktree-list.sh
> @@ -0,0 +1,51 @@
> +#!/bin/sh
> +
> +test_description='test git worktree list'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	test_commit init
> +'
> +
> +test_expect_success '"list" all worktrees from main' '
> +	echo "$(git rev-parse --show-toplevel)  ($(git symbolic-ref --short HEAD))" >expect &&
> +	git worktree add --detach here master &&
> +	echo "$(git -C here rev-parse --show-toplevel)  ($(git -C here rev-parse HEAD))" >>expect &&
> +	git worktree list >actual &&
> +	test_cmp expect actual &&
> +	rm -rf here &&
> +	git worktree prune
> +'
> +
> +test_expect_success '"list" all worktrees from linked' '
> +	echo "$(git rev-parse --show-toplevel)  ($(git symbolic-ref --short HEAD))" >expect &&
> +	git worktree add --detach here master &&
> +	echo "$(git -C here rev-parse --show-toplevel)  ($(git -C here rev-parse HEAD))" >>expect &&
> +	git -C here worktree list >actual &&
> +	test_cmp expect actual &&
> +	rm -rf here &&
> +	git worktree prune
> +'
> +
> +test_expect_success '"list" all worktrees from main --path-only' '
> +	git rev-parse --show-toplevel >expect &&
> +	git worktree add --detach here master &&
> +	git -C here rev-parse --show-toplevel >>expect &&
> +	git worktree list --path-only >actual &&
> +	test_cmp expect actual &&
> +	rm -rf here &&
> +	git worktree prune
> +'
> +
> +test_expect_success '"list" all worktrees from linked --path-only' '
> +	git rev-parse --show-toplevel >expect &&
> +	git worktree add --detach here master &&
> +	git -C here rev-parse --show-toplevel >>expect &&
> +	git -C here worktree list --path-only >actual &&
> +	test_cmp expect actual &&
> +	rm -rf here &&
> +	git worktree prune
> +'
> +
> +test_done

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSoC 04/17] builtin-rebase: parse rebase arguments
 into a common rebase_options struct
Date: Tue, 15 Mar 2016 11:54:58 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603151134230.4690@virtualbox>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com> <1457779597-6918-5-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 11:55:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afmdH-00052j-49
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 11:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbcCOKzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 06:55:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:62925 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932452AbcCOKzR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 06:55:17 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LqW8j-1aAakE2Nsn-00e0gN; Tue, 15 Mar 2016 11:54:59
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1457779597-6918-5-git-send-email-pyokagan@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Du622jaQMqrL4F5flU/mo+nhSl7BLPYAqwNxgeyVsL4pFtaULXC
 kYbXhQpNJ4WaECJmIiaY/pdXJVl0dA8WymTxSfJV9kZultKL3xazO69DBuk1K7NJAMAQ5XK
 LbwXoYEpgJouoD6MLxObv70dtRRDdVAdJmth1YXL1yhvIWNMIemMTyQLpmZ0f8gmW8qgJ8x
 /KXZH29MdhNRuTGVeGg2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:u6JGf+XrIeE=:tZGJjssXDFGGZ7fuRRuAWi
 DSR2QliRnqGy/Ibxc/Ik5diDz8hdd1WVnHVc0Yj07OkoAjvnGiML06Zrdz5qX+FEGMApJG5FR
 GmSIqP6WsedVXnfyaBfug6AzTk9pJxSPyQKVAl3TPMKp7fXyPvrwJaszeiEdcVwrKVhJS1NrV
 zoG/t6bCiAWlnMshaCFfe56tIaOKmN5noeFE/be7O1bDArxF+TIycHjDrPuRRPf0At5YJco5R
 W+7AtQzN1qtp7Nq5QL164Q2Koo1e9A84mldf54NfiAg0czNwkmBSisMeiFLRvQAqmxtvsScYV
 PSV5IqxNYTknqFv2p3+Bj16PZrMKTQY6LTnrdwhZAjFnK1aUzgJxipzRGNoWVxYvA827tD3iL
 Z2U/wTIMzGnvxuIyw+Bahf/CIpaFIp00hmodjCeFv2d/c9yOr6ql9SC56AzNleTWrPMWSn+sj
 1PXoSIy1CPyPl30rnQDJFfQlsufwlWDbe1Stue+gjVq2OF2MkophlBWE7kfVRk9dT4vVlfbID
 WkO9ceFwSQ0Kmz61IPGJi8pZx+Z32PXxvUx7/0ktNXRQd5PujiULKvNhf9x/ZHZfpClKU+VYa
 3DdYTHACXwXrUl6ZcLEfIndEeGoRBFwJnEdyKrQXONy9fKHea1Ql00KrZ1so/M5mL1def9udW
 sv3gHYCNL+3GH3FwRCh7POlzx5cFG5JMKOdPIyUV0voKDib28Q3wO3v/tHKn3CNpeXrwBCBJT
 xB+FChFde2No+tqMCKbUxoALB7EKIWN+7g1HqJzXNUwldKjRkXlfjYQ3G0gfqGamV3SOij1a 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288845>

Hi Paul,

On Sat, 12 Mar 2016, Paul Tan wrote:

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 04cc1bd..40176ca 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -4,6 +4,112 @@
>  #include "cache.h"
>  #include "builtin.h"
>  #include "parse-options.h"
> +#include "rebase-common.h"
> +#include "remote.h"
> +#include "branch.h"
> +#include "refs.h"
> +
> +/**
> + * Used by get_curr_branch_upstream_name() as a for_each_remote() callback to
> + * retrieve the name of the remote if the repository only has one remote.
> + */
> +static int get_only_remote(struct remote *remote, void *cb_data)
> +{
> +	const char **remote_name = cb_data;
> +
> +	if (*remote_name)
> +		return -1;
> +
> +	*remote_name = remote->name;
> +	return 0;
> +}

This function gets only the remote's name, not only the remote. And this
is not really a functionality specific to rebase, is it?

> +const char *get_curr_branch_upstream_name(void)
> +{
> +	const char *upstream_name;
> +	struct branch *curr_branch;
> +
> +	curr_branch = branch_get("HEAD");
> +	if (!curr_branch) {
> +		fprintf_ln(stderr, _("You are not currently on a branch."));
> +		fprintf_ln(stderr, _("Please specify which branch you want to rebase against."));
> +		fprintf_ln(stderr, _("See git-rebase(1) for details."));
> +		fprintf(stderr, "\n");
> +		fprintf_ln(stderr, "    git rebase <branch>");
> +		fprintf(stderr, "\n");
> +		exit(1);
> +	}

Urgh. Elswhere we have _("Blabla\nBlublub\n") constructs, which is already
a little bit ugly, but this mix of fprintf_ln() and fprintf() together
with adding a whopping 3 strings (for the price of 1) for the translators
(and missing one...) is too ugly for my taste.

Also, there is a horrible, horrible, horrible exit(1) there. I know, you
put this into builtin/ and so we assume it is okay to just exit() left and
right, but *why*? Is this not a function we might want to reuse elsewhere?
As such, it should live in remote.[ch], take a "hint" parameter in case
there is no current branch (and BTW "HEAD" should not be hard-coded to
begin with, but instead be another parameter), and it should return -1 on
error, not exit.

> +
> +	upstream_name = branch_get_upstream(curr_branch, NULL);
> +	if (!upstream_name) {
> +		const char *remote_name = NULL;
> +
> +		if (for_each_remote(get_only_remote, &remote_name) || !remote_name)
> +			remote_name = "<remote>";
> +
> +		fprintf_ln(stderr, _("There is no tracking information for the current branch."));
> +		fprintf_ln(stderr, _("Please specify which branch you want to rebase against."));
> +		fprintf_ln(stderr, _("See git-rebase(1) for details."));
> +		fprintf(stderr, "\n");
> +		fprintf_ln(stderr, "    git rebase <branch>");
> +		fprintf(stderr, "\n");
> +		fprintf_ln(stderr, _("If you wish to set tracking information for this branch you can do so with:"));
> +		fprintf(stderr, "\n");
> +		fprintf_ln(stderr, _("If you wish to set tracking information for this branch you can do so with:\n"
> +		"\n"
> +		"    git branch --set-upstream-to=%s/<branch> %s\n"),
> +		remote_name, curr_branch->name);
> +		exit(1);
> +	}

Same here. The rebase-specific part of the hint should be a parameter, the
thing should not die at all, and it really wants to live in remote.[ch].

> +/**
> + * Given the --onto <name>, return the onto hash
> + */
> +static void get_onto_oid(const char *_onto_name, struct object_id *onto)
> +{
> +	char *onto_name = xstrdup(_onto_name);

By convention, variable names starting with an underscore are reserved for
use by the standard library.

> +	struct commit *onto_commit;
> +	char *dotdot;
> +
> +	dotdot = strstr(onto_name, "...");
> +	if (dotdot) {
> +		const char *left = onto_name;
> +		const char *right = dotdot + 3;
> +		struct commit *left_commit, *right_commit;
> +		struct commit_list *merge_bases;
> +
> +		*dotdot = 0;
> +		if (!*left)
> +			left = "HEAD";
> +		if (!*right)
> +			right = "HEAD";
> +
> +		/* git merge-base --all $left $right */
> +		left_commit = lookup_commit_reference_by_name(left);
> +		right_commit = lookup_commit_reference_by_name(right);
> +		if (!left_commit || !right_commit)
> +			die(_("%s: there is no merge base"), _onto_name);
> +
> +		merge_bases = get_merge_bases(left_commit, right_commit);
> +		if (merge_bases && merge_bases->next)
> +			die(_("%s: there are more than one merge bases"), _onto_name);
> +		else if (!merge_bases)
> +			die(_("%s: there is no merge base"), _onto_name);
> +
> +		onto_commit = merge_bases->item;
> +		free_commit_list(merge_bases);
> +	} else {
> +		onto_commit = lookup_commit_reference_by_name(onto_name);
> +		if (!onto_commit)
> +			die(_("invalid upstream %s"), onto_name);
> +	}
> +
> +	free(onto_name);
> +	oidcpy(onto, &onto_commit->object.oid);
> +}

A lot of this looks *awfully* like the parameters we throw at rev-list (or
for that matter, log). Why can't we reuse that machinery?

> @@ -12,20 +118,96 @@ static int git_rebase_config(const char *k, const char *v, void *cb)
>  
>  int cmd_rebase(int argc, const char **argv, const char *prefix)
>  {
> +	struct rebase_options rebase_opts;
> +	const char *onto_name = NULL;
> +	const char *branch_name;
> +
>  	const char * const usage[] = {
> -		N_("git rebase [options]"),
> +		N_("git rebase [options] [--onto <newbase>] [<upstream>] [<branch>]"),
>  		NULL
>  	};
>  	struct option options[] = {
> +		OPT_GROUP(N_("Available options are")),
> +		OPT_STRING(0, "onto", &onto_name, NULL,
> +			N_("rebase onto given branch instead of upstream")),
>  		OPT_END()
>  	};
>  
>  	git_config(git_rebase_config, NULL);
> +	rebase_options_init(&rebase_opts);
> +	rebase_opts.resolvemsg = _("\nWhen you have resolved this problem, run \"git rebase --continue\".\n"
> +			"If you prefer to skip this patch, run \"git rebase --skip\" instead.\n"
> +			"To check out the original branch and stop rebasing, run \"git rebase --abort\".");
>  
>  	argc = parse_options(argc, argv, prefix, options, usage, 0);
>  
>  	if (read_cache_preload(NULL) < 0)
>  		die(_("failed to read the index"));
>  
> +	/*
> +	 * Parse command-line arguments:
> +	 *    rebase [<options>] [<upstream_name>] [<branch_name>]
> +	 */
> +
> +	/* Parse <upstream_name> into rebase_opts.upstream */
> +	{

In Git, unless there are very compelling reasons, we avoid non-conditional
blocks. Probably you did that to have this local declaration:

> +		const char *upstream_name;

But that declaration can easily live in the cmd_rebase() scope,
simplifying the code and being easier on the reader's eyes.

> +	/*
> +	 * Parse --onto <onto_name> into rebase_opts.onto and
> +	 * rebase_opts.onto_name
> +	 */
> +	get_onto_oid(onto_name, &rebase_opts.onto);
> +	rebase_opts.onto_name = xstrdup(onto_name);

My, this onto_name() sure gets strdup()ed a lot... Maybe we can avoid
that?

> +	/*
> +	 * Parse <branch_name> into rebase_opts.orig_head and
> +	 * rebase_opts.orig_refname
> +	 */
> +	branch_name = argv[0];
> +	if (branch_name) {

In Git's source code, we appear to rely on argc instead on argv[argc]
being NULL.

> +		/* Is branch_name a branch or commit? */
> +		char *ref_name = xstrfmt("refs/heads/%s", branch_name);
> +		struct object_id orig_head_id;
> +
> +		if (!read_ref(ref_name, orig_head_id.hash)) {
> +			rebase_opts.orig_refname = ref_name;
> +			if (get_oid_commit(ref_name, &rebase_opts.orig_head))
> +				die("get_sha1_commit failed");
> +		} else if (!get_oid_commit(branch_name, &rebase_opts.orig_head)) {
> +			rebase_opts.orig_refname = NULL;
> +			free(ref_name);
> +		} else {
> +			die(_("no such branch: %s"), branch_name);
> +		}

Here, ref_name does not get free()d. It lives on as
rebase_opts.orig_refname but it gets increasingly fiddly to reason about
the correctness of the code.

A better idea would be to leave the responsibility of keeping track
completely with the caller, i.e. have the fields of the options struct as
const char *. Then you can make the values strbufs as needed and in the
case of a builtin that exits anyway, you do not even need to release in
the end.

> diff --git a/rebase-common.c b/rebase-common.c

As pointed out elsewhere, it is not a good idea to put stuff used by the
rebase into rebase-common.c. Either it is so specific to rebase that it
can go into rebase.c, or it is so not specific to rebase that it can go
into path.c, wt-status.c, diff.c etc

Ciao,
Johannes

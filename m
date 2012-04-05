From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] git-cherry-pick: Add ignore-if-made-empty option
 [v2]
Date: Thu, 05 Apr 2012 14:01:43 -0700
Message-ID: <7vobr551vs.fsf@alter.siamese.dyndns.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-4-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 23:02:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFtp2-0000ko-I6
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 23:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195Ab2DEVCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 17:02:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64603 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755002Ab2DEVBq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 17:01:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06C817751;
	Thu,  5 Apr 2012 17:01:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Trd1blWeSybRuPEX0vzfDmAgEkM=; b=Kj6TN5hYCL/owKbOgoKj
	TlRvmVAjSesFm6BUNmSVcmdqrKGjp4SiNtHUon2d9IlIx4juMfpZ67Ux4U9NY1ca
	WzHoHdRhgPXMOPn5W1C00/8L4T3RmW8qudYl1h+cmKDu9NXbcmmLgTh1O8xctW2E
	6kWwY3f6HpH9B3Y6tsztOMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=D7IDRMyWr40GGeni7CZscC2hJZvC9N/GcBHiHG2gQC9H6F
	gHo8pL1w8moxvgxYOOSVmvIuObrV2zqHLg53d7vOZesnqTvmg3naHdoHQH7f3q7a
	jpH+WG3li+ee0xY9IxbEPcVGbEu3STCbNEYkhr252DeO2OFNuvwXaUHKXHlgk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1FFB7750;
	Thu,  5 Apr 2012 17:01:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08ADD7746; Thu,  5 Apr 2012
 17:01:44 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D360D56-7F62-11E1-BC0F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194810>

Neil Horman <nhorman@tuxdriver.com> writes:

> Subject: Re: [PATCH 3/5] git-cherry-pick: Add ignore-if-made-empty option [v2]

Please don't do this.  The tools do not strip the garbage at the end.

Instead, do it like either one of these:

	Subject: [PATCH 3/5 (v2)] mumble mumble...
	Subject: [PATCH v2 3/5] mumble mumble...

The latter is more appropriate when resending everything, including the
ones that did not change from the earlier round.

> Since we'll be using git-cherry-pick to enhance git-rebase's ability to preserve
> empty commits, we open ourselves to the possibility of preserving commits that
> are made empty by a previous merge as well, which is almost certainly not what
> we want (most of the time).  To handle this, we can add the ignore-if-made-empty
> option.  If enabled, it will look at cherry-picked commits, and if the origional
> sha1 has the same tree as its parent, then the cherry-pick is comitted as an
> empty commit, otherwise the commit is skipped (because it previously made
> changes to the tree, but no longer does).
>
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>

> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> index c283d8c..bb7eb4a 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -103,7 +103,7 @@ effect to your index in a row.
>  	cherry-pick'ed commit, then a fast forward to this commit will
>  	be performed.
>  
> ---allow-empty:
> +--allow-empty:::

A single colon is already buggy, but three colons is equally bad.  Please
fix that in the original point this bug was introduced.  I guess it was
2/5 of this series?

> @@ -112,6 +112,14 @@ effect to your index in a row.
>  	commits that meet the "fast-forward" requirement will be kept
>  	even without this option.
>  
> +--ignore-if-made-empty::
> +	If the --allow-empty option is used, all empty commits are kept,

Literal strings the user may type are typically set in tt font
(i.e. `--allow-empty`).

> +	including those which were made empty due to a previous change.
> +	While this may be desireable, likely it is not.

Mental note.  Up to this point, the reader is told that "--allow-empty"
alone is likely to do a wrong thing.

> +	This option
> +	restricts the scope of --allow-empty to only those commits which
> +	were created as empty commits ...

And the user is asked to give "--ignore-if-made-empty" in addition to
"--allow-empty" to get a saner and more likely to be useful behaviour.
Isn't that backwards?  This "the other option is insane, and please make
it saner" option needs a lot more typing than the more insane option.

I would expect that "--allow-empty" would by default filter ones that are
originally non-empty but are made unnecessary (we are allowing empty
commits in the original history to be cherry-picked, but the general
principle that unnecessary commits must not be picked still is in effect).
If you want to give a user the other more insane mode of operation, it is
OK to let the user give a different option *instead* *of* the saner
"--allow-empty".

Perhaps name that "--keep-unnecessary-commit" (it is no longer about
allowing empty commits in the original history to be picked; it is about
keeping unnecessary and irrelevant commits in the resulting history).

And error out if both options are given.

> +static int run_git_commit(const char *defmsg, struct replay_opts *opts, int empty)
> +{
> +	struct argv_array array;
> +	int rc;
> +
> +	argv_array_init(&array);
> +	argv_array_push(&array, "commit");
> +	argv_array_push(&array, "-n");
> +
> +	if ((!empty) && (opts->ignore_if_made_empty)) {

Style: lose the extra and unnecessary parentheses, especially when the
expression inside them are so trivial, i.e.

	if (!empty && opts->ignore_if_made_empty) {

although I suspect that redesign of the command line interface might make
it a moot point to polish this part of the code without major rethinking.

> +		/* Note: This implies --dry-run */
> +		argv_array_push(&array, "--porcelain");
> +		if (run_command_v_opt(array.argv, RUN_GIT_CMD) == 1) {

The only thing you want to check at this point is if the contents of the
index being committed is the same as the tree of HEAD.  Why do we even
want to incur this much overhead?

Isn't running "diff-index --cached HEAD" sufficient?

> +			/* The dry run exit code of 1 tells us this is
> + 			 * an empty commit, just skip it.
> + 			 */

	/*
         * Our multi-line comments are
         * formatted this way.
         */

> +			argv_array_clear(&array);
> +			return 0;
> +		}
> +		argv_array_pop(&array, 1);
> +	}
> +
>  
>  	if (opts->signoff)
> +		argv_array_push(&array, "-s");
>  	if (!opts->edit) {
> +		argv_array_push(&array, "-F");
> +		argv_array_push(&array, defmsg);
>  	}
> +	
>  	if (opts->allow_empty)
> +		argv_array_push(&array, "--allow-empty");
> +
> +
> +	rc = run_command_v_opt(array.argv, RUN_GIT_CMD);
> +	argv_array_clear(&array);
> +	return rc;
> +}
> +
> +static int is_origional_commit_empty(struct commit *commit)

What is origional?

Is there a reason why this series is not marked as WIP or RFC?

I am starting to wonder if it is worth spending time on careful reviewing,
or it would be sufficient to give a cursory review quickly to give you
more time to polish your re-roll.

> +{
> +	struct argv_array argv_array;
> +	struct child_process cp;
> +	char ptree[41], pptree[41];
> +	int pipefd[2];
> +	FILE *output;
> +	int ret = 0;
> +
> +	if (pipe2(pipefd, 0) < 0)
> +		return 0;
> +
> +	output = xfdopen(pipefd[0], "r");
> +
> +	argv_array_init(&argv_array);
> +	memset(&cp, 0, sizeof(struct child_process));
>  
> -	args[i] = NULL;
> +	argv_array_push(&argv_array, "rev-parse");
> +	argv_array_pushf(&argv_array, "%s^{tree}", sha1_to_hex(commit->object.sha1));
>  
> -	return run_command_v_opt(args, RUN_GIT_CMD);
> +	cp.git_cmd = 1;
> +	cp.no_stdin = 1;
> +	cp.no_stderr = 1;
> +	cp.out = pipefd[1];
> +	cp.argv = argv_array.argv;
> +
> +	if (start_command(&cp) < 0)
> +		goto out;
> +
> +	if (fscanf(output, "%s\n", ptree) < 1)
> +		goto out;
> +
> +	finish_command(&cp);
> +
> +	fclose(output);
> +	close(pipefd[0]);
> +	argv_array_clear(&argv_array);
> +
> +	if (pipe2(pipefd, 0) < 0)

Huh?  "man pipe2" and see if it is portable.

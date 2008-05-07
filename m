From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow local branching to set up rebase by default.
Date: Wed, 07 May 2008 09:22:22 -0700
Message-ID: <7vprrycce9.fsf@gitster.siamese.dyndns.org>
References: <1209502182-39800-1-git-send-email-dustin@spy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dustin Sallings <dustin@spy.net>
X-From: git-owner@vger.kernel.org Wed May 07 18:23:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtmQU-0006Mk-0I
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 18:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050AbYEGQWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 12:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754017AbYEGQWk
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 12:22:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbYEGQWh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 12:22:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 92DDA3C5A;
	Wed,  7 May 2008 12:22:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 369943C54; Wed,  7 May 2008 12:22:30 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CD74A4E0-1C51-11DD-9A82-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81461>

Dustin Sallings <dustin@spy.net> writes:

> Change cd67e4d4 introduced a new configuration parameter that told
> pull to automatically perform a rebase instead of a merge.  I use this
> feature quite a bit in topic branches and would like it to be the
> default behavior for a topic branch.
>
> If the parameter branch.autosetuprebase applies for a branch that's
> being created, that branch will have branch.<name>.rebase set to true.
>
> See the documentation for how this may be applied.
>
> New model.
> ---

The commit log message is both a sales pitch to get people interested in
your change and an explanation of why the change was needed once it gets
etched into the history.

The above starts out very nicely by stating the background of the change
in the first sentence.  However, "I use this ..." is too subjective and
makes others on the list who would comment on it go "Huh, you do?  So
what?" and lose interest in the patch.  You got no reactions, neither
positive nor negative, partly due to this sentence, I suspect.  It would
be better received if you make it less subjective (e.g. 'This can be used
to maintain tidy history of topic branches until they get merged, but
having to say "git pull --rebase" every time is a nuisance.").

With the background and motivation clearly explained, then you would
describe what the change solves and how.  The second paragraph is fine.

"See the documentation" is a key phrase to turn off people's interest; you
would never want to say it, for two reasons:

 (1) people are busy and first scan only the commit log message without
     reading diffs, so that they do not have to waste time on patches that
     are ill conceived.

 (2) once the change is committed, people read "git log" output to get
     overview of the history, and expect the commit log messages to be
     sufficient for that purpose.

"See the doc" tells the reader that "What I have here in the commit log is
insufficient and useless; you need to go to the documentation".  But that
is not the case for your commit log message --- you gave a very good
overview and ruined it by having this needless sentence.  Drop it.

"New model."???

I certainly went "Huh?" and stopped reading when I hit that line.

Please sign-off your patches (see Documentation/SubmittingPatches).

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 7a24f6e..1994895 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -393,6 +393,20 @@ branch.autosetupmerge::
>  	done when the starting point is either a local branch or remote
>  	branch. This option defaults to true.
>  
> +branch.autosetuprebase::
> +	When a new branch is created with `git-branch` or `git-checkout`
> +	that tracks another branch, this parameter tells git to set

This is probably not a "parameter" but a "variable".

> +	up pull to rebase instead of merge (see "branch.<name>.rebase")
> +	below.

"below"?

> +	When `never`, rebase is never automatically set to true.
> +	When `local`, rebase is set to true for tracked branches of
> +	other local branches.
> +	When `remote`, rebase is set to true for tracked branches of
> +	remote branches.
> +	When `always`, rebase will be set to true for all tracking
> +	branches.
> +	This option defaults to never.

How does this interact with a similarly named configuration option,
autosetupmerge, whose settings can be false, true, and always?

>  branch.<name>.remote::
>  	When in branch <name>, it tells `git fetch` which remote to fetch.
>  	If this option is not given, `git fetch` defaults to remote "origin".

This is not your fault, but can anybody guess what the exact command
sequence to cause the named branch to be advanced by rebasing, only by
reading this entry?

    branch.<name>.rebase::
            When true, rebase the branch <name> on top of the fetched branch,
            instead of merging the default branch from the default remote.

I can't.  Perhaps we would need "when "git pull" is run" or something at
the end.

> diff --git a/branch.c b/branch.c
> index daf862e..2a731e4 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -32,6 +32,25 @@ static int find_tracked_branch(struct remote *remote, void *priv)
>  	return 0;
>  }
>  
> +static int should_setup_rebase(struct tracking tracking) {

Style.

 - The "{" to start a function body comes at the beginning on its own
   line.

 - Pass struct (especially a read-only one) by a (const) pointer, not by
   value:

	static int foo(const struct tracking *tracking)
        {
        	...

> +	int rv=0;

Style.  s/=/ = /;

> +	switch(autorebase) {

Style. s/(/ (/;

> +	case AUTOREBASE_NEVER:
> +		rv = 0;
> +		break;
> +	case AUTOREBASE_LOCAL:
> +		rv = tracking.matches == 0;
> +		break;

Is this correct?  Earlier you said "local" is about a branch that trails
other local branches, but this seems to be checking only if the branch is
not tracking anything remote.  Would it be possible for this branch to be
not trailing anything, not even local?

	The answer turns out to be "no", only because this function
	implicitly relies on the fact that setup_tracking() never calls it
	if the branch does not track anything, but it was hard to guess
	during the first pass.

You might want to check how the setup_tracking() decides when to say
remote/local in its printf().

> +	case AUTOREBASE_REMOTE:
> +		rv = tracking.matches > 0;
> +		break;

This somehow feels awkward because (tracking->matches > 1) is an ambiguous
situation (perhaps a misconfiguration) that setup_tracking() rejects but
you are allowing it here.  Admittedly, the former would never call you
when it detects the case, but it still feels awkward...

> +	case AUTOREBASE_ALWAYS:
> +		rv = 1;
> +		break;
> +	}
> +	return rv;
> +}

After all you might be better off without a temporary variable rv and
return from within the switch().

> diff --git a/cache.h b/cache.h
> index 3fcc283..5c9aff8 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -433,7 +433,15 @@ enum branch_track {
>  	BRANCH_TRACK_EXPLICIT,
>  };
>  
> +enum rebase_setup_type {
> +	AUTOREBASE_NEVER = 0,
> +	AUTOREBASE_LOCAL,
> +	AUTOREBASE_REMOTE,
> +	AUTOREBASE_ALWAYS,
> +};
> +
>  extern enum branch_track git_branch_track;
> +extern enum rebase_setup_type autorebase;
>  
>  #define GIT_REPO_VERSION 0
>  extern int repository_format_version;
> diff --git a/config.c b/config.c
> index b0ada51..2959087 100644
> --- a/config.c
> +++ b/config.c
> @@ -487,6 +487,20 @@ int git_default_config(const char *var, const char *value)
>  		git_branch_track = git_config_bool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "branch.autosetuprebase")) {
> +		if (!strcmp(value, "never"))
> +			autorebase = AUTOREBASE_NEVER;

Have this in your .git/config:

        [branch]
                autosetuprebase

and you will strcmp(NULL, "never") here.

> +		else if (!strcmp(value, "local"))
> +			autorebase = AUTOREBASE_LOCAL;
> +		else if (!strcmp(value, "remote"))
> +			autorebase = AUTOREBASE_REMOTE;
> +		else if (!strcmp(value, "always"))
> +			autorebase = AUTOREBASE_ALWAYS;
> +		else
> +			die_bad_config(
> +				"Invalid value for branch.autosetupmerge");

A line slightly longer than 80-cols is better than this artificial line
split, I think.

> diff --git a/environment.c b/environment.c
> index 6739a3f..6fb3b97 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -38,6 +38,7 @@ int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
>  enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
>  unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
>  enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
> +enum rebase_setup_type autorebase = 0;

Do not initialize to 0; BSS takes care of it.  Explicitly initializing to
a symbolic constant, by using AUTOREBASE_NEVER, is very much Ok.

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index cb5f7a4..10bb429 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -224,4 +224,96 @@ test_expect_success 'avoid ambiguous track' '
>  	test -z "$(git config branch.all1.merge)"
>  '
>  
> +test_expect_success 'autosetuprebase local on a tracked local branch' \
> +	'git config remote.local.url . &&

Move the opening "'" to the end of the first line so you can lose
backslash there and it becomes easier to read.

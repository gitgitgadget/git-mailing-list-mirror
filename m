From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] pull --rebase: add --[no-]autostash flag
Date: Sat, 27 Feb 2016 11:26:12 -0800
Message-ID: <xmqqk2lqeyzv.fsf@gitster.mtv.corp.google.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pyokagan@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 20:26:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZkVS-0004HW-IE
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 20:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992500AbcB0T0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 14:26:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751389AbcB0T0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 14:26:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3C6C744F16;
	Sat, 27 Feb 2016 14:26:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EFKDqG9seW6a8Di9UER1uLu71ZM=; b=K1EnZy
	Q2XlPi4JjJRx86wMaYCMT/EuxxEJ78gTh1z0V5Kk3+surqFGYCdlkZ0uADwtEMqy
	myA2z61/D4k0sBtaX4HYbsnaefCbpc5E2qRied3V6UyQzMpn7M/SI+cJea9hOm59
	3P7pNJ/oTzRoXFmcSWVirF2I/y24Eal7fcRxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gCVz2m5sf0JFU3z5upSuxhq2q+nSPnLe
	8zGQcy29tOSLREHi3VMNfowNnN6fghHznsPqUHGfAXI5Z35vH3DKBqaNBSO3n3Ie
	CKsCWebyf8/gh4mqvbQOOgC3Ok5Ckbw/isC7suWigGlcVjYZDkw6mCiLPXzwkuct
	WROiYS+eKs4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 31A5444F15;
	Sat, 27 Feb 2016 14:26:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9640344F12;
	Sat, 27 Feb 2016 14:26:13 -0500 (EST)
In-Reply-To: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	(Mehul Jain's message of "Sat, 27 Feb 2016 23:11:41 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F6D72A6A-DD87-11E5-A49F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287726>

Mehul Jain <mehul.jain2029@gmail.com> writes:

> git pull --rebase understands --[no-]autostash flag.
>
> This flag overrides config variable "rebase.autoStash" 
> if set (default is false).

Is that a statement of a fact?  If so, is it true before this patch
is applied, or after?

Each project has local convention for log messages, and we do too.
A long log message typically start by explaining how the world is,
why that is not desirable, present a description of a possible world
that is better, and then give commands to somebody who is updating
the code telling him what to do to make that better world a reality
(and optionally how).

So perhaps (I am totally making this up; you need to fact check and
adjust):

    If you enable rebase.autoStash option in your repository, there
    is no way to override it for "git pull --rebase" from the
    command line.

    Teach "git pull" a new "--[no-]autostash" option so that a
    rebase.autoStash configuration can be overridden.  As "git
    rebase" already knows "--[no-]autostash" option, it is just the
    matter of passing one when we spawn the command as necessary.

or something.  The first one gives the readers how the current world
works, and why it is not ideal.  The proposed better world in this
case is too simple--the first paragraph complained that "we cannot
do X" and X is something reader would likely to agree is a good
thing to do, so it can be left unsaid that a better world is one in
which X can be done.

> When calling "git pull --rebase" with "--autostash",
> pull passes the "--autostash" option to rebase, 
> which then runs rebase on a dirty worktree.
>
> With "--no-autostash" option, the command will die
> if the worktree is dirty, before calling rebase.

These two paragraphs are too obvious and probably are better left
unsaid.  Especially the latter--you are changing "pull" and do not
control what "rebase" would do in the future.  It could be that a
better rebase in the future may be able to do its job in a dirty
worktree without doing an autostash.

> Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
> ---
>
> Thanks to Paul and Matthieu for comments on previous round.
> Changes:
>  	- --autostash flag added
> 	- OPT_COLOR_FLAG replaced by OPT_BOOL
> 	- Default value of opt_rebase changed
> 	- Few changes in code
> 	- Commit message improvements
> 	- Documentation added
> 	- Few tests removed as suggested by Paul
> 	- Added test for --autostash flag
> All tests passed: https://travis-ci.org/mehul2029/git 
>
>  builtin/pull.c          | 13 ++++++++-----
>  t/t5520-pull.sh         | 19 +++++++++++++++++++
>  t/t5521-pull-options.sh | 16 ++++++++++++++++
>  3 files changed, 43 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 10eff03..60b320e 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -85,6 +85,7 @@ static char *opt_squash;
>  static char *opt_commit;
>  static char *opt_edit;
>  static char *opt_ff;
> +static int opt_autostash = 0;

Do not explicitly initialize a static to 0 (or NULL).

>  static char *opt_verify_signatures;
>  static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
>  static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
> @@ -146,6 +147,8 @@ static struct option pull_options[] = {
>  	OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
>  		N_("abort if fast-forward is not possible"),
>  		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
> +	OPT_BOOL(0,"autostash",&opt_autostash,
> +		N_("automatically stash/stash pop before and after rebase")),
>  	OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
>  		N_("verify that the named commit has a valid GPG signature"),
>  		PARSE_OPT_NOARG),
> @@ -789,7 +792,8 @@ static int run_rebase(const unsigned char *curr_head,
>  	argv_array_pushv(&args, opt_strategy_opts.argv);
>  	if (opt_gpg_sign)
>  		argv_array_push(&args, opt_gpg_sign);
> -
> +	if(opt_autostash)

Style: control keywords are followed by a single SP before the next '('.

> +		argv_array_push(&args,"--autostash");

Style: a single SP after a comma.

How would --no-autostash defeat a configured rebase.autostash with this?

By the way, how would this affect "git pull --autostash" that is run
without "--rebase"?  If this is an option to "git pull", shouldn't
the stashing done even when you are not doing a rebase but making a
merge?

>  	argv_array_push(&args, "--onto");
>  	argv_array_push(&args, sha1_to_hex(merge_head));
>  
> @@ -813,6 +817,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  	if (!getenv("GIT_REFLOG_ACTION"))
>  		set_reflog_message(argc, argv);
>  
> +	git_config_get_bool("rebase.autostash",&opt_autostash);
> +

Why is this change even necessary?

>  	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
>  
>  	parse_repo_refspecs(argc, argv, &repo, &refspecs);
> @@ -835,13 +841,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  		hashclr(orig_head);
>  
>  	if (opt_rebase) {
> -		int autostash = 0;
> -
>  		if (is_null_sha1(orig_head) && !is_cache_unborn())
>  			die(_("Updating an unborn branch with changes added to the index."));
>  
> -		git_config_get_bool("rebase.autostash", &autostash);
> -		if (!autostash)
> +		if (!opt_autostash)
>  			die_on_unclean_work_tree(prefix);

I would have expected that

 * a global opt_autostash is initialized to -1 (unspecified);

 * opt_bool() would flip it to either 0 or 1 with --[no-]autostash;

 * existing "rebase.autostash" configuration check inside "git pull"
   code  gets removed;

 * and the code that builds "git rebase" invocation command line
   will do

   	if (opt_autostash < 0)
        	; /* do nothing */
	else if (opt_autostash == 0)
        	argv_array_push(&args, "--no-autostash");
	else
        	argv_array_push(&args, "--autostash");
        	
Then when "git pull --rebase" is run without "--[no-]autostash", the
underlying "git rebase" would be run without that option, and does its
usual thing, including reading rebase.autostash and deciding to do
"git stash".  And when "git pull" is run with "--[no-]autostash",
the underlying "git rebase" would be given the same option, and
would do what it was told to do, ignoring rebase.autostash setting.

So why does "git pull" still need to look at rebase.autostash
configuration after this change?

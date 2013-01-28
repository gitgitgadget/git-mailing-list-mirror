From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v3] add: warn when -u or -A is used without filepattern
Date: Mon, 28 Jan 2013 13:47:15 +0100
Message-ID: <51067353.2090006@drmicha.warpmail.net>
References: <vpqobg966cv.fsf@grenoble-inp.fr> <1359364593-10933-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jonathan Nieder <jrnieder@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jan 28 13:47:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzo7d-000165-Me
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 13:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761Ab3A1MrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 07:47:16 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37126 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751390Ab3A1MrP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jan 2013 07:47:15 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9D88820963;
	Mon, 28 Jan 2013 07:47:14 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Mon, 28 Jan 2013 07:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=wf2/+iJZbeGmWreFDHSoYS
	U6Ivc=; b=b3rZVpNQfW3huFjKck6qjKn4l1a7r7kRl/cJE5v1sklQdo+WqiD4qG
	dW111af3RghOXRnko0ovuyRiF3NiqsHaLU4E31T+LM0n3Kpk7g4ysDBIEiXHcnjT
	NgnM2L8xxDpgAaOommTN+2L/T3EaYyqumF134wiIBpaa2KcoRAbuA=
X-Sasl-enc: 5EbEL3oIRLox6UXPtM/rpplJhtL2dcL+P4QSQ4kGc0YF 1359377234
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 64A974824FD;
	Mon, 28 Jan 2013 07:47:13 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <1359364593-10933-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214834>

Matthieu Moy venit, vidit, dixit 28.01.2013 10:16:
> Most git commands that can be used with our without a filepattern are
> tree-wide by default, the filepattern being used to restrict their scope.
> A few exceptions are: 'git grep', 'git clean', 'git add -u' and 'git add -A'.

Since I didn't follow this thread, my first reaction was: "Huh? Aren't
they treewide?" (for the relative tree)

So, for someone reading just the commit message, it would be helpful to
say what the others do, i.e. default to the relative tree at pwd (rather
than defaulting to an empty tree, or all files whether tracked or not,
or...).

Otherwise, I'd rather switch sooner than later; it's so easy to take
"git add -u && git commit == git commit -a" for granted and to miss
staging some hunks. But 2.0 is around the corner anyway, isn't it ;)

> The inconsistency of 'git add -u' and 'git add -A' are particularly
> problematic since other 'git add' subcommands (namely 'git add -p' and
> 'git add -e') are tree-wide by default.
> 
> Flipping the default now is unacceptable, so this patch starts training
> users to type explicitely 'git add -u|-A :/' or 'git add -u|-A .', to prepare
> for the next steps:
> 
> * forbid 'git add -u|-A' without filepattern (like 'git add' without
>   option)
> 
> * much later, maybe, re-allow 'git add -u|-A' without filepattern, with a
>   tree-wide scope.
> 
> A nice side effect of this patch is that it makes the :/ special
> filepattern easier to discover for users.
> 
> When the command is called from the root of the tree, there is no
> ambiguity and no need to change the behavior, hence no need to warn.
> 
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Changes since v2:
> 
> * Typo consistant -> consistent
> 
> * Mention both short and long option names (Thanks Junio). I went for
>   a two-lines display which I find a bit nicer to read than Junio's
>   version, but I'm fine with both.
> 
>  Documentation/git-add.txt |  7 ++++---
>  builtin/add.c             | 44 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index fd9e36b..5333559 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -107,9 +107,10 @@ apply to the index. See EDITING PATCHES below.
>  	from the index if the corresponding files in the working tree
>  	have been removed.
>  +
> -If no <filepattern> is given, default to "."; in other words,
> -update all tracked files in the current directory and its
> -subdirectories.
> +If no <filepattern> is given, the current version of Git defaults to
> +"."; in other words, update all tracked files in the current directory
> +and its subdirectories. This default will change in a future version
> +of Git, hence the form without <filepattern> should not be used.
>  
>  -A::
>  --all::
> diff --git a/builtin/add.c b/builtin/add.c
> index 7cb6cca..7738025 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -321,6 +321,35 @@ static int add_files(struct dir_struct *dir, int flags)
>  	return exit_status;
>  }
>  
> +static void warn_pathless_add(const char *option_name, const char *short_name) {
> +	/*
> +	 * To be consistent with "git add -p" and most Git
> +	 * commands, we should default to being tree-wide, but
> +	 * this is not the original behavior and can't be
> +	 * changed until users trained themselves not to type
> +	 * "git add -u" or "git add -A". For now, we warn and
> +	 * keep the old behavior. Later, this warning can be
> +	 * turned into a die(...), and eventually we may
> +	 * reallow the command with a new behavior.
> +	 */
> +	warning(_("The behavior of 'git add %s (or %s)' with no path argument from a\n"
> +		  "subdirectory of the tree will change in Git 2.0 and should not be used anymore.\n"
> +		  "To add content for the whole tree, run:\n"
> +		  "\n"
> +		  "  git add %s :/\n"
> +		  "  (or git add %s :/)\n"
> +		  "\n"
> +		  "To restrict the command to the current directory, run:\n"
> +		  "\n"
> +		  "  git add %s .\n"
> +		  "  (or git add %s .)\n"
> +		  "\n"
> +		  "With the current Git version, the command is restricted to the current directory."),
> +		option_name, short_name,
> +		option_name, short_name,
> +		option_name, short_name);
> +}
> +
>  int cmd_add(int argc, const char **argv, const char *prefix)
>  {
>  	int exit_status = 0;
> @@ -331,6 +360,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  	int add_new_files;
>  	int require_pathspec;
>  	char *seen = NULL;
> +	const char *option_with_implicit_dot = NULL;
> +	const char *short_option_with_implicit_dot = NULL;
>  
>  	git_config(add_config, NULL);
>  
> @@ -350,8 +381,19 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  		die(_("-A and -u are mutually incompatible"));
>  	if (!show_only && ignore_missing)
>  		die(_("Option --ignore-missing can only be used together with --dry-run"));
> -	if ((addremove || take_worktree_changes) && !argc) {
> +	if (addremove) {
> +		option_with_implicit_dot = "--all";
> +		short_option_with_implicit_dot = "-A";
> +	}
> +	if (take_worktree_changes) {
> +		option_with_implicit_dot = "--update";
> +		short_option_with_implicit_dot = "-u";
> +	}
> +	if (option_with_implicit_dot && !argc) {
>  		static const char *here[2] = { ".", NULL };
> +		if (prefix)
> +			warn_pathless_add(option_with_implicit_dot,
> +					  short_option_with_implicit_dot);
>  		argc = 1;
>  		argv = here;
>  	}
> 

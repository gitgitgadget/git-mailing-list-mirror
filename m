From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help: include list of aliases in git-help --all
Date: Tue, 25 Feb 2014 11:15:21 -0800
Message-ID: <xmqqsir757hy.fsf@gitster.dls.corp.google.com>
References: <1393289315-28982-1-git-send-email-joel.nothman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joel Nothman <joel.nothman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 25 20:15:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WINTi-0003Dq-6q
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 20:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbaBYTP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 14:15:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46755 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753177AbaBYTPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Feb 2014 14:15:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 980186D695;
	Tue, 25 Feb 2014 14:15:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q0pqdycREUlxPcM6G1isXXk/Dgs=; b=ZduNMG
	qaiyLi21qoDnOhqOgXZY19isjrtBuTOcovcclJszz3iLQCifWFztxYnivvNX36r0
	kGSOaMqvuNM8pnMiqKSAN3UCfqh9GsZca3igTgdLe+edj2VVxfv3zQWnJZwv3C1M
	0GG7b1tTiBAHqbZb37kQ5uyv0vuFCFuWsINao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=njjfeKGQSlvXNPutQ4BXC6jzrn9uEDWo
	LVz84ttvtsDdlaWWpRyK0PdUYs3+cq07v51LhnxvkAgjSpGy9rBNsakDQEpjKD4m
	gTKGHfq+PeUunGKnqTqUp8o58Yia+yAA9F+11DFB+dy5AUiA09Jxv+s+iAsVEv8Q
	wyo305wURkA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D9C26D694;
	Tue, 25 Feb 2014 14:15:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8055F6D690;
	Tue, 25 Feb 2014 14:15:23 -0500 (EST)
In-Reply-To: <1393289315-28982-1-git-send-email-joel.nothman@gmail.com> (Joel
	Nothman's message of "Tue, 25 Feb 2014 11:48:34 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2CF97BA2-9E51-11E3-BFAF-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242680>

Joel Nothman <joel.nothman@gmail.com> writes:

> Git help --all had listed all git commands, but no configured aliases.
> This includes aliases as a separate listing, after commands in the main
> git directory and other $PATH directories.

... and why is this a good thing?

>
> Signed-off-by: Joel Nothman <joel.nothman <at> gmail.com>
> ---
>  Documentation/git-help.txt |  4 +--
>  builtin/help.c             |  7 ++---
>  help.c                     | 64 +++++++++++++++++++++++++++++++++++-----------
>  help.h                     |  7 ++++-
>  4 files changed, 61 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
> index b21e9d7..c9fe791 100644
> --- a/Documentation/git-help.txt
> +++ b/Documentation/git-help.txt
> @@ -40,8 +40,8 @@ OPTIONS
>  -------
>  -a::
>  --all::
> -	Prints all the available commands on the standard output. This
> -	option overrides any given command or guide name.
> +	Prints all the available commands and aliases on the standard output.
> +	This option overrides any given command or guide name.
>  
>  -g::
>  --guides::
> diff --git a/builtin/help.c b/builtin/help.c
> index 1fdefeb..d1dfecd 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -38,7 +38,7 @@ static int show_guides = 0;
>  static unsigned int colopts;
>  static enum help_format help_format = HELP_FORMAT_NONE;
>  static struct option builtin_help_options[] = {
> -	OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
> +	OPT_BOOL('a', "all", &show_all, N_("print all available commands and aliases")),
>  	OPT_BOOL('g', "guides", &show_guides, N_("print list of useful guides")),
>  	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
>  	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
> @@ -453,6 +453,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>  	int nongit;
>  	const char *alias;
>  	enum help_format parsed_help_format;
> +	struct cmdnames alias_cmds;
>  
>  	argc = parse_options(argc, argv, prefix, builtin_help_options,
>  			builtin_help_usage, 0);
> @@ -461,8 +462,8 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>  	if (show_all) {
>  		git_config(git_help_config, NULL);
>  		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
> -		load_command_list("git-", &main_cmds, &other_cmds);
> -		list_commands(colopts, &main_cmds, &other_cmds);
> +		load_commands_and_aliases("git-", &main_cmds, &other_cmds, &alias_cmds);
> +		list_commands(colopts, &main_cmds, &other_cmds, &alias_cmds);
>  	}
>  
>  	if (show_guides)
> diff --git a/help.c b/help.c
> index df7d16d..3c14af4 100644
> --- a/help.c
> +++ b/help.c
> @@ -86,7 +86,7 @@ static void pretty_print_string_list(struct cmdnames *cmds,
>  	int i;
>  
>  	for (i = 0; i < cmds->cnt; i++)
> -		string_list_append(&list, cmds->names[i]->name);
> +	    string_list_append(&list, cmds->names[i]->name);
>  	/*
>  	 * always enable column display, we only consult column.*
>  	 * about layout strategy and stuff
> @@ -202,8 +202,48 @@ void load_command_list(const char *prefix,
>  	exclude_cmds(other_cmds, main_cmds);
>  }
>  
> +static struct cmdnames aliases;
> +
> +static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
> +{
> +	int i;
> +	ALLOC_GROW(cmds->names, cmds->cnt + old->cnt, cmds->alloc);
> +
> +	for (i = 0; i < old->cnt; i++)
> +		cmds->names[cmds->cnt++] = old->names[i];
> +	free(old->names);
> +	old->cnt = 0;
> +	old->names = NULL;
> +}
> +
> +static int load_aliases_cb(const char *var, const char *value, void *cb)
> +{
> +	if (starts_with(var, "alias."))
> +		add_cmdname(&aliases, var + 6, strlen(var + 6));
> +	return 0;
> +}
> +
> +void load_commands_and_aliases(const char *prefix,
> +		struct cmdnames *main_cmds,
> +		struct cmdnames *other_cmds,
> +		struct cmdnames *alias_cmds)
> +{
> +	load_command_list(prefix, main_cmds, other_cmds);
> +
> +	/* reuses global aliases from unknown command functionality */
> +	git_config(load_aliases_cb, NULL);
> +
> +	add_cmd_list(alias_cmds, &aliases);
> +	qsort(alias_cmds->names, alias_cmds->cnt,
> +		  sizeof(*alias_cmds->names), cmdname_compare);
> +	uniq(alias_cmds);
> +	exclude_cmds(alias_cmds, main_cmds);
> +	exclude_cmds(alias_cmds, other_cmds);
> +}
> +
>  void list_commands(unsigned int colopts,
> -		   struct cmdnames *main_cmds, struct cmdnames *other_cmds)
> +		   struct cmdnames *main_cmds, struct cmdnames *other_cmds,
> +		   struct cmdnames *alias_cmds)
>  {
>  	if (main_cmds->cnt) {
>  		const char *exec_path = git_exec_path();
> @@ -219,6 +259,13 @@ void list_commands(unsigned int colopts,
>  		pretty_print_string_list(other_cmds, colopts);
>  		putchar('\n');
>  	}
> +
> +	if (alias_cmds->cnt) {
> +		printf_ln(_("aliases defined in git configuration"));
> +		putchar('\n');
> +		pretty_print_string_list(alias_cmds, colopts);
> +		putchar('\n');
> +	}
>  }
>  
>  void list_common_cmds_help(void)
> @@ -248,7 +295,6 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
>  }
>  
>  static int autocorrect;
> -static struct cmdnames aliases;
>  
>  static int git_unknown_cmd_config(const char *var, const char *value, void *cb)
>  {
> @@ -270,18 +316,6 @@ static int levenshtein_compare(const void *p1, const void *p2)
>  	return l1 != l2 ? l1 - l2 : strcmp(s1, s2);
>  }
>  
> -static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
> -{
> -	int i;
> -	ALLOC_GROW(cmds->names, cmds->cnt + old->cnt, cmds->alloc);
> -
> -	for (i = 0; i < old->cnt; i++)
> -		cmds->names[cmds->cnt++] = old->names[i];
> -	free(old->names);
> -	old->cnt = 0;
> -	old->names = NULL;
> -}
> -
>  /* An empirically derived magic number */
>  #define SIMILARITY_FLOOR 7
>  #define SIMILAR_ENOUGH(x) ((x) < SIMILARITY_FLOOR)
> diff --git a/help.h b/help.h
> index b21d7c9..3939bc6 100644
> --- a/help.h
> +++ b/help.h
> @@ -21,11 +21,16 @@ extern const char *help_unknown_cmd(const char *cmd);
>  extern void load_command_list(const char *prefix,
>  			      struct cmdnames *main_cmds,
>  			      struct cmdnames *other_cmds);
> +extern void load_commands_and_aliases(const char *prefix,
> +			      struct cmdnames *main_cmds,
> +			      struct cmdnames *other_cmds,
> +			      struct cmdnames *alias_cmds);
>  extern void add_cmdname(struct cmdnames *cmds, const char *name, int len);
>  /* Here we require that excludes is a sorted list. */
>  extern void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
>  extern int is_in_cmdlist(struct cmdnames *cmds, const char *name);
> -extern void list_commands(unsigned int colopts, struct cmdnames *main_cmds, struct cmdnames *other_cmds);
> +extern void list_commands(unsigned int colopts, struct cmdnames *main_cmds,
> +			  struct cmdnames *other_cmds, struct cmdnames *alias_cmds);
>  
>  /*
>   * call this to die(), when it is suspected that the user mistyped a

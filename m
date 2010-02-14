From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add an optional argument for --color options
Date: Sun, 14 Feb 2010 03:39:29 -0800
Message-ID: <7vmxzcoxla.fsf@alter.siamese.dyndns.org>
References: <1266098475-21929-1-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 12:40:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngcpy-0006CX-G9
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 12:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758461Ab0BNLkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 06:40:25 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33297 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758449Ab0BNLkX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 06:40:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D51219902A;
	Sun, 14 Feb 2010 06:39:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CROSWNAGk1FiNJx/8ToZqWx3iiM=; b=rpo9Xo
	UYOWd8a/Yzp2COo118K3aAxvgC5PDHhuNDkWJ5mGyyV4Cc2Znc3ZSYPPl3lVhPsa
	ZLoBpAg63AqhXqhO830Op+ozSfY1cR8BWnq4YPJ7zxl+cfAaI9pzQIwM+7iiScEP
	+AKm0+J8ul6BGGyqC1w3t2Tm9mCnVmscA03EI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rzwXtIYWtdBXt3BqYiFnf1MiweAWdU7I
	DDadUojZinnUchWW7HhDL4S3lOtrJqGf3/lqxWE5DKjnobh3Gsi98cpDDgkViAM0
	bCGsStGaN6V+pXeyJuyV1vFEf6jepksLj4FT2DoZzijsVNPJpevTwvQs0gs6On0n
	N08Wmlj/CeI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A425199029;
	Sun, 14 Feb 2010 06:39:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8C8199027; Sun, 14 Feb
 2010 06:39:30 -0500 (EST)
In-Reply-To: <1266098475-21929-1-git-send-email-lodatom@gmail.com> (Mark
 Lodato's message of "Sat\, 13 Feb 2010 17\:01\:15 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A03CE388-195D-11DF-9ECD-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139897>

Mark Lodato <lodatom@gmail.com> writes:

> diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
> index 50f9e9a..19d8436 100644
> --- a/Documentation/technical/api-parse-options.txt
> +++ b/Documentation/technical/api-parse-options.txt
> @@ -183,6 +186,15 @@ There are some macros to easily define options:
>  	arguments.  Short options that happen to be digits take
>  	precedence over it.
>  
> +`OPT_COLOR_FLAG(short, long, &int_var, description)`::
> +	Introduce an option that takes an optional argument that can
> +	have one of three values: "always", "never", or "auto".  If the
> +	argument is not given, it defaults to "always".  The +--no-+ form
> +	works like +--long=never+; it cannot take an argument.  If
> +	"always", set +int_var+ to 1; if "never", set +int_var+ to 0; if
> +	"auto", set +int_var+ to 1 if stdout is a tty or a pager,
> +	0 otherwise.
> +

Everybody else in the vicinity seems to write these like `--something` and
this new paragraph uses '+--something+'.  Why be original only to be
different?  Is the mark-up known to be understood by various versions of
AsciiDoc people use?

> diff --git a/builtin-show-branch.c b/builtin-show-branch.c
> index 9f13caa..32d862a 100644
> --- a/builtin-show-branch.c
> +++ b/builtin-show-branch.c
> @@ -6,7 +6,7 @@
>  #include "parse-options.h"
>  
>  static const char* show_branch_usage[] = {
> -    "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-order] [--current] [--color | --no-color] [--sparse] [--more=<n> | --list | --independent | --merge-base] [--no-name | --sha1-name] [--topics] [<rev> | <glob>]...",
> +    "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-order] [--current] [--color[=<when>] | --no-color] [--sparse] [--more=<n> | --list | --independent | --merge-base] [--no-name | --sha1-name] [--topics] [<rev> | <glob>]...",
>      "git show-branch (-g|--reflog)[=<n>[,<base>]] [--list] [<ref>]",
>      NULL
>  };

An unrelated topic, but we should clean this up.  I thought parseopt users
should say [options] in the short description?

> diff --git a/color.c b/color.c
> index 62977f4..790ac91 100644
> --- a/color.c
> +++ b/color.c
> @@ -138,6 +138,9 @@ int git_config_colorbool(const char *var, const char *value, int stdout_is_tty)
>  			goto auto_color;
>  	}
>  
> +	/* If var is not given, return an error */
> +	if (!var)
> +		return -1;

This is not a good comment for more than one reasons:

 * The natural callers of this function (i.e. git_config() callback
   functions) will _never_ give a NULL in var, hence it is obvious that
   !var is an error.  And you return negative which is the conventional
   way to signal error from git_config() callback functions.  The comment
   states the obvious without adding any useful information.

 * Worse yet, the callers that deliberately give NULL to this function are
   your new callers, and for them, !var is not an error condition at all.
   You expect that the earlier code in the function to switch on the given
   value and want the control reach this point from your new callers when
   the user gave you a wrong input.  This is to check if the caller is
   using a non-standard calling convention, and return -1 upon unknown
   input only for such callers.

 * Even worse, you do not even treat this -1 as an error consistently; one
   of your new callers takes it as 'dunno--ignore', and the other one
   issues an error message.

> diff --git a/diff.c b/diff.c
> index 381cc8d..110e63b 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2826,6 +2826,15 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
>  		DIFF_OPT_SET(options, FOLLOW_RENAMES);
>  	else if (!strcmp(arg, "--color"))
>  		DIFF_OPT_SET(options, COLOR_DIFF);
> +	else if (!prefixcmp(arg, "--color=")) {
> +		int value = git_config_colorbool(NULL, arg+8, -1);
> +		if (value == 0)
> +			DIFF_OPT_CLR(options, COLOR_DIFF);
> +		else if (value > 0)
> +			DIFF_OPT_SET(options, COLOR_DIFF);
> +		else
> +			return 0;

Earlier you said "git diff --blorb" says "error: invalid option: --blorb"
and that is unhelpful, but I do not understand why that justifies to
silently ignore "git diff --color=bogo".

> diff --git a/parse-options.c b/parse-options.c
> index d218122..20ce6e3 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -2,6 +2,7 @@
>  #include "parse-options.h"
>  #include "cache.h"
>  #include "commit.h"
> +#include "color.h"
>  
>  static int parse_options_usage(const char * const *usagestr,
>  			       const struct option *opts);
> @@ -599,6 +600,22 @@ int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
>  	return 0;
>  }
>  
> +int parse_opt_color_flag_cb(const struct option *opt, const char *arg,
> +			    int unset)
> +{
> +	int value;
> +	if (unset && arg)
> +		return opterror(opt, "takes no value", OPT_UNSET);
> +	if (!arg)
> +		arg = unset ? "never" :(const char *)opt->defval;

missing SP after colon.

> +	value = git_config_colorbool(NULL, arg, -1);
> +	if (value < 0)
> +		return opterror(opt, "expects \"always\", \"auto\", "
> +				"or \"never\"", 0);

Instead of breaking a string into two lines, please write it like this:

		return opterror(opt,
			"expects \"always\", \"auto\", or \"never\"", 0);

so that we can grep.                        

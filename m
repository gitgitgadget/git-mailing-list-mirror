From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] allow recovery from command name typos
Date: Sun, 05 Aug 2012 17:50:33 -0700
Message-ID: <7vehnk3kti.fsf@alter.siamese.dyndns.org>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1344192340-19415-1-git-send-email-rctay89@gmail.com>
 <1344192340-19415-2-git-send-email-rctay89@gmail.com>
 <1344192340-19415-3-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Jeff King" <peff@peff.net>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 02:50:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyBWt-0006v5-Dz
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 02:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216Ab2HFAui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 20:50:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45882 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755063Ab2HFAuh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 20:50:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C99E80D6;
	Sun,  5 Aug 2012 20:50:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wv8xA6l5iE9SwaDeN4bLC1cCq40=; b=vPXv7u
	komlUeyYt5vgVcFOf5n2zR7PMvi9Sq1iSCD0n6UkIp/duNWXYP58N0QpV1EI+WK+
	zdgx48BuAh1IJsDbsD2USEuG8r52Lx8uCWC0c+uGfn9e6byeX7p+QcZ+jpAHxstF
	5YbGlWpyx3BiwrxgJFi0FH4Y8awrfnkuRL/tU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=unnbvzVep48YO8H4hofAvR1jKCVvIe7Y
	R9GlexxMJIG/NmJwgU9Gsr6HKbtt7MG1xFfEaHfSN0+IT+5jrWugCQ6g2rQK8kWl
	WhxN1QfRNCNNh7i7coa70aLJ/vSkisJNyIc777sxyyv2yPkAjh+gYcTRtndz5JZS
	jKE6xTcUkNw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4985180D5;
	Sun,  5 Aug 2012 20:50:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D54580D2; Sun,  5 Aug 2012
 20:50:35 -0400 (EDT)
In-Reply-To: <1344192340-19415-3-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Mon, 6 Aug 2012 02:45:40 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB739B30-DF60-11E1-9B26-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202941>

Tay Ray Chuan <rctay89@gmail.com> writes:

> If suggestions are available (based on Levenshtein distance) and if the
> terminal isatty(), present a prompt to the user to select one of the
> computed suggestions.
>
> In the case where there is a single suggestion, present the prompt
> "[Y/n]", such that "" (ie. the default), "y" and "Y" as input leads git
> to proceed executing the suggestion, while everything else (possibly
> "n") leads git to terminate.
>
> In the case where there are multiple suggestions, number the suggestions
> 1 to <n> (the number of suggestions), and accept an integer as input,
> while everything else (possibly "n") leads git to terminate. In this
> case there is no default; an empty input leads git to terminate. A
> sample run:
>
>   $ git sh --pretty=oneline
>   git: 'sh' is not a git command. See 'git --help'.
>
>   Did you mean one of these?
>   1:    show
>   2:    push
>   [N/1/2/...]
>
> This prompt is enabled only if help.autocorrect is set to ask; if unset,
> advise the user about this ability.
>
> Helped-by: Thomas Rast <trast@student.ethz.ch>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
>
> Changed in v3:
>  - say do_* instead of shall_*
>  - use new terminal interface
>
>  Documentation/config.txt | 30 ++++++++++++++++-----
>  advice.c                 |  2 ++
>  advice.h                 |  1 +
>  help.c                   | 68 +++++++++++++++++++++++++++++++++++++++++++++---
>  4 files changed, 90 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0bcea8a..0bb175a 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -177,6 +177,10 @@ advice.*::
>  		Advice shown when you used linkgit:git-checkout[1] to
>  		move to the detach HEAD state, to instruct how to create
>  		a local branch after the fact.
> +	typoPrompt::
> +		Upon a mistyped command, if 'help.autocorrect' is unset
> +		advise that an interactive prompt can be displayed to
> +		recover from the typo.
>  --

I have a moderately strong reaction against this; "advice" is for
helping users out of common pitfalls, and we generally do not use
the "advise" mechanism to advertise random shiny features.

> @@ -1323,13 +1327,25 @@ help.format::
> ...
>  help.autocorrect::
> +	Specifies behaviour to recover from mistyped commands.
> ++
> +When set to `ask`, an interactive prompt is displayed, allowing the user
> +to select a suggested command for execution.
> ++
> +When set to `off`, no attempt to recover is made.

I notice that with the current code, even if help.autocorrect is set
to 0 to decline the guessing, we still get "did you mean one of
these" as long as the typo is similar enough to existing command.

I am guessing that this new value `off` is a way to remedy the
situation so that users can choose to decline any guessing, and just
get "no such subcommand".  If that is the case, I think it is a vast
improvement.

> +If a number is given, it will be interpreted as the deciseconds (0.1
> +sec) to wait before automatically correcting and executing the mistyped
> +command, with the following behaviour:
> ++
> +* If more than one command can be deduced from the entered text, nothing
> +  will be executed.

The above is from the original text, but I've always found the "can
be deduced" part hard to understand.  It is a quite roundabout way
to say we cannot guess with confidence what the user meant and avoid
committing to a wrong guess.  We may want to think a better way to
phrase the whole thing.  Perhaps something along this line:

	help.autocorrect::
		When you mistype the name of a subcommand during an
		interactive session, Git can try to guess which one
		of available subcommands you meant (Git does not
		waste cycles in a non-interactive session).  This
		configuration variable specifies what happens when
		there are one or more subcommands that you are
		likely to have meant.

        	- when set to 'ask', the choices are presented and
                  you can pick one to execute.  If the command is
                  used non-interactively,

		- when set to `off`, ...

This can be done after this patch series settles, of course.

> +* If the value of this option is negative, the corrected command will be
> +  executed immediately.
> +* If the value is 0 - the command will be just shown but not executed.
> ++
> +The default is to display a message suggesting that this option be set
> +to `ask`, without attempting to recover (see `advice.typoPrompt`).

My comment to 'advice.typoPrompt' leads me to suggest not to change
the default to `ask`, but leave it to 0, and remove the change to
the following two files.

> diff --git a/advice.c b/advice.c
> diff --git a/advice.h b/advice.h

> diff --git a/help.c b/help.c
> index c4285a5..cc13b92 100644
> --- a/help.c
> +++ b/help.c
> @@ -7,6 +7,7 @@
>  #include "string-list.h"
>  #include "column.h"
>  #include "version.h"
> +#include "compat/terminal.h"
>  
>  void add_cmdname(struct cmdnames *cmds, const char *name, int len)
>  {
> @@ -233,12 +234,30 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
>  }
>  
>  static int autocorrect;
> +static int do_advise = 1;
> +static int do_prompt;
> +static const char message_advice_prompt_ability[] =
> +	N_("I can display an interactive prompt to proceed with one of the above\n"
> +	   "suggestions; if you wish me to do so, use\n"
> +	   "\n"
> +	   "  git config --global help.autocorrect ask\n"
> +	   "\n"
> +	   "See 'git help config' and search for 'help.autocorrect' for further\n"
> +	   "information.\n");
>  static struct cmdnames aliases;

Nah.  No unsolicited advertisement, please.

>  static int git_unknown_cmd_config(const char *var, const char *value, void *cb)
>  {
> -	if (!strcmp(var, "help.autocorrect"))
> -		autocorrect = git_config_int(var,value);
> +	if (!strcmp(var, "help.autocorrect") && value) {
> +		do_advise = 0;
> +		if (!strcasecmp(value, "off"))
> +			;
> +		else if (!strcasecmp(value, "ask"))
> +			do_prompt = 1;
> +		else
> +			autocorrect = git_config_int(var, value);
> +	}

I think the current code diagnoses

	[help]
        	autocorrect

that tries to say "true" as a syntax error.  The above simply
ignores such an entry, no?

I was hoping "off" would be usable to bypass the whole levenstein
thing, but the above code does not suggest that the remainder of
this patch would be doing that X-<.

> @@ -366,13 +385,54 @@ const char *help_unknown_cmd(const char *cmd)
>  	fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
>  
>  	if (SIMILAR_ENOUGH(best_similarity)) {
> +		term_t term;
> +
>  		fprintf_ln(stderr,
>  			   Q_("\nDid you mean this?",
>  			      "\nDid you mean one of these?",
>  			   n));
>  
> -		for (i = 0; i < n; i++)
> -			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
> +		term = terminal_open();
> +		if (!term || !do_prompt) {
> +			for (i = 0; i < n; i++)
> +				fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);

It is the same as what is done with the current code, but if there
is no terminal available, do we even want to give this list?

> +			if (isatty(2) && do_advise && advice_typo_prompt) {
> +				fprintf(stderr, "\n");
> +				advise(_(message_advice_prompt_ability));
> +			}

Nah.  No unsolicited advertisement, please.

> +		} else if (n == 1) {
> +			char *in;
> +			const char *ret;
> +			fprintf(stderr, "\t%s\n", main_cmds.names[0]->name);
> +			in = terminal_prompt(term, "[Y/n] ", 1);
> +			terminal_close(term);
> +			switch (in[0]) {
> +			case 'y': case 'Y': case 0:
> +				ret = xstrdup(main_cmds.names[0]->name);
> +				clean_cmdnames(&main_cmds);
> +				return ret;

OK.

> +			/* otherwise, don't do anything */
> +			}

Indent the comment one level deeper?

> +		} else {
> +			char *in;
> +			const char *ret;
> +			int opt;
> +			for (i = 0; i < n; i++)

Can we have too many choices for this "prompt" codepath to be
practical?

> +				fprintf(stderr, "%d:\t%s\n", i + 1, main_cmds.names[i]->name);
> +			in = terminal_prompt(term, "[N/1/2/...] ", 1);

Would it be too much trouble to spell the actual choices out here,
instead of the ugly "/..."?

> +			terminal_close(term);
> +			switch (in[0]) {
> +			case 'n': case 'N': case 0:
> +				;
> +			default:
> +				opt = atoi(in);
> +				if (0 < opt && opt <= n) {
> +					ret = xstrdup(main_cmds.names[opt - 1]->name);
> +					clean_cmdnames(&main_cmds);
> +					return ret;
> +				}

When the user mistypes the choice (perhaps say '8' when there are
only 7 choices available), it might be more helpful to loop here to
give him another chance.  Would such an enhancement be worth it?

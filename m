From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: Re: [PATCH] git-prompt: make colors available in custom prompts
Date: Mon, 2 May 2016 08:40:07 +0200
Message-ID: <5726F647.6030805@xs4all.nl>
References: <1461301201-92142-1-git-send-email-andrew@schwartzmeyer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: erdavila@gmail.com
To: Andrew Schwartzmeyer <andrew@schwartzmeyer.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 08:40:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ax7Wo-0006eJ-Sc
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 08:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873AbcEBGkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 02:40:13 -0400
Received: from lb1-smtp-cloud3.xs4all.net ([194.109.24.22]:42555 "EHLO
	lb1-smtp-cloud3.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751629AbcEBGkL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2016 02:40:11 -0400
Received: from ahtec.fritz.box ([62.251.42.129])
	by smtp-cloud3.xs4all.net with ESMTP
	id pJg71s0062nCm1a01Jg80f; Mon, 02 May 2016 08:40:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
In-Reply-To: <1461301201-92142-1-git-send-email-andrew@schwartzmeyer.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293220>

Hi Andrew

sorry, I only noticed your request this morning...

On 22/04/16 07:00, Andrew Schwartzmeyer wrote:
> This was disabled in the original implementation, probably because it
> does not work if the __git_ps1 function is single-quoted. However, if
> you double-quote per the updated documentation, you can have colors in
> your custom Git prompt function, no problem.
>
> Signed-off-by: Andrew Schwartzmeyer <andrew@schwartzmeyer.com>
> ---
>   contrib/completion/git-prompt.sh | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index f18aedc73..ffe79168c 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -12,8 +12,8 @@
>   #        source ~/.git-prompt.sh
>   #    3a) Change your PS1 to call __git_ps1 as
>   #        command-substitution:
> -#        Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
> -#        ZSH:  setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
> +#        Bash: PS1="[\u@\h \W$(__git_ps1 ' (%s)')]\$ "
> +#        ZSH:  setopt PROMPT_SUBST ; PS1="[%n@%m %c$(__git_ps1 ' (%s)')]\$ "

I haven't tested this at all, but when using double quotes, you need to 
at least check all the escapings, like \$ should probably be: \\\$ when 
used in double quotes.

>   #        the optional argument will be used as format string.
>   #    3b) Alternatively, for a slightly faster prompt, __git_ps1 can
>   #        be used for PROMPT_COMMAND in Bash or for precmd() in Zsh
> @@ -82,8 +82,9 @@
>   #
>   # If you would like a colored hint about the current dirty state, set
>   # GIT_PS1_SHOWCOLORHINTS to a nonempty value. The colors are based on
> -# the colored output of "git status -sb" and are available only when
> -# using __git_ps1 for PROMPT_COMMAND or precmd.
> +# the colored output of "git status -sb". If you are using your own
> +# PROMPT_COMMAND function, you must use double-quotes when calling
> +# __git_ps1, e.g. PS1="$(__git_ps1 '%s ')".
>   #
>   # If you would like __git_ps1 to do nothing in the case when the current
>   # directory is set up to be ignored by git, then set
> @@ -499,8 +500,7 @@ __git_ps1 ()
>
>   	local z="${GIT_PS1_STATESEPARATOR-" "}"
>
> -	# NO color option unless in PROMPT_COMMAND mode
> -	if [ $pcmode = yes ] && [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
> +	if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
>   		__git_ps1_colorize_gitstring
>   	fi
>
>

The original reason for not using colors in command substitution mode 
was that the prompt string length was not calculated correctly by bash 
and it messed up the commandline with very long commands (relative to 
the terminal width), when browsing the command history.
However I think I've seen this effect even with the new code, but I've 
never dug into this.

Cheers

Simon

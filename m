From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Show the presence of untracked files in the bash
	prompt.
Date: Fri, 24 Jul 2009 08:03:17 -0700
Message-ID: <20090724150317.GW11191@spearce.org>
References: <20090721171445.GA25762@bug.science-computing.de> <20090721171952.GS11191@spearce.org> <20090722083134.GK24439@bug.science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Trstenjak <Daniel.Trstenjak@online.de>
To: Daniel Trstenjak <trsten@science-computing.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 17:03:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUMJA-0007iL-FN
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 17:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbZGXPDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 11:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752813AbZGXPDS
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 11:03:18 -0400
Received: from george.spearce.org ([209.20.77.23]:34707 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbZGXPDR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 11:03:17 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EA286381FD; Fri, 24 Jul 2009 15:03:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090722083134.GK24439@bug.science-computing.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123920>

Daniel Trstenjak <trsten@science-computing.de> wrote:
> 
> Added the envvar GIT_PS1_SHOWUNTRACKEDFILES to 'git-completion.bash'.
> When set to a nonempty value, then the char '%' will be shown next
> to the branch name in the bash prompt.
> 
> Signed-off-by: Daniel Trstenjak <daniel.trstenjak@science-computing.de>

Acked-by: Shawn O. Pearce <spearce@spearce.org>


> ---
>  contrib/completion/git-completion.bash |   15 +++++++++++++--
>  1 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 887731e..745b5fb 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -44,6 +44,10 @@
>  #       GIT_PS1_SHOWSTASHSTATE to a nonempty value. If something is stashed,
>  #       then a '$' will be shown next to the branch name.
>  #
> +#       If you would like to see if there're untracked files, then you can
> +#       set GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there're
> +#       untracked files, then a '%' will be shown next to the branch name.
> +#
>  # To submit patches:
>  #
>  #    *) Read Documentation/SubmittingPatches
> @@ -132,6 +136,7 @@ __git_ps1 ()
>  		local w
>  		local i
>  		local s
> +		local u
>  		local c
>  
>  		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
> @@ -156,12 +161,18 @@ __git_ps1 ()
>  			if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
>  			        git rev-parse --verify refs/stash >/dev/null 2>&1 && s="$"
>  			fi
> +
> +			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
> +			   if [ -n "$(git ls-files --others --exclude-standard)" ]; then
> +			      u="%"
> +			   fi
> +			fi
>  		fi
>  
>  		if [ -n "${1-}" ]; then
> -			printf "$1" "$c${b##refs/heads/}$w$i$s$r"
> +			printf "$1" "$c${b##refs/heads/}$w$i$s$u$r"
>  		else
> -			printf " (%s)" "$c${b##refs/heads/}$w$i$s$r"
> +			printf " (%s)" "$c${b##refs/heads/}$w$i$s$u$r"
>  		fi
>  	fi
>  }
> -- 
> 1.6.2
> 
> 
> -- 
>                                                                                                                                            
>  Daniel Trstenjak         Tel   : +49 (0)7071-9457-264
>  science + computing ag   FAX   : +49 (0)7071-9457-511
>  Hagellocher Weg 73       mailto: Daniel.Trstenjak@science-computing.de
>  D-72070 T?bingen         WWW   : http://www.science-computing.de/                                                                      
> -- 
> Vorstand/Board of Management:
> Dr. Bernd Finkbeiner, Dr. Roland Niemeier, 
> Dr. Arno Steitz, Dr. Ingrid Zech
> Vorsitzender des Aufsichtsrats/
> Chairman of the Supervisory Board:
> Michel Lepert
> Sitz/Registered Office: Tuebingen
> Registergericht/Registration Court: Stuttgart
> Registernummer/Commercial Register No.: HRB 382196 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Shawn.

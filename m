From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCHv2] bash completion: Support "divergence from upstream"
 warnings in __git_ps1
Date: Wed, 09 Jun 2010 11:17:26 +0200
Message-ID: <4C0F5C26.5080108@drmicha.warpmail.net>
References: <4C0AE640.3040503@pileofstuff.org> <201006062014.59386.trast@student.ethz.ch> <4C0C09BF.4070503@pileofstuff.org> <201006070942.34753.trast@student.ethz.ch> <4C0EB7F1.1030707@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Wed Jun 09 11:18:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMHQT-0003kU-GV
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 11:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756583Ab0FIJSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 05:18:16 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:55014 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755513Ab0FIJSP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 05:18:15 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 70A5BF849D;
	Wed,  9 Jun 2010 05:17:54 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 09 Jun 2010 05:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=+AQCv3HYxbzP3P8ivI2aWrezKSc=; b=lanvFX/6lFCK6sopZeQAdW9Z4CHD3skDeHq22xFxddJsNtVDn0DB7X5PwolatjzkrR3uxKTya4xaYbFW1NFiqstEncfJAterSkjjmBg1BtL+Itc4BFm6oXno2AtOUGgzWZKftNmQt1O8SysE36ATFc3MbD/yBD5WW3PC/7evsas=
X-Sasl-enc: 26zZ5NB3pJUOqlwT8wcVDjJISWItA825Bwe6gtRuA4Lb 1276075073
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5662E4E7B46;
	Wed,  9 Jun 2010 05:17:53 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100604 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <4C0EB7F1.1030707@pileofstuff.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148756>

[I haven't followed the previous discussion, just this RFC.]

Andrew Sayers venit, vidit, dixit 08.06.2010 23:36:
> Add a notification in the command prompt specifying whether you're ahead of
> (>), behind (<), diverged from (<>) or at (=) your upstream.  This is
> especially helpful in small teams that (forget to) push to each other very
> frequently.
> 
> Support git-svn upstream detection as a special case, as migraters from
> centralised version control systems are especially likely to forget to push.
> 
> Support for other types of upstream than SVN should be easy to add if anyone is
> so inclined.
> 
> Signed-off-by: Andrew Sayers <andrew-git@pileofstuff.org>
> ---
> 
> This patch includes Thomas Rast's feedback - thanks Thomas for the education :)
> 
> This patch makes unashamed use of shell arrays and substring expansion that
> would normally not be allowed.  As Jakub Narebski mentioned, this is probably ok
> in a bash-specific script.
> 
> Unlike other prompt options, I've put the divergence characters on the left of the
> branch name.  I'm really not sure about this, and I'd like to hear people's
> opinions.

I'd say it would make sense to you use the same order as "branch -vv"
and "status -s", i.e. after the branch name.

> 
> This patch produces output like this when I have unpushed commits:
> 
> [andrew@pc myrepo >master] # my master is ahead of upstream
> 
> Intuitively, I like having a ">" when I'm ahead, although it would be more
> logical to have something like this:

That is really illogical, please don't.

> 
> [andrew@pc myrepo <master] # upstream less-than master
> 
> Putting the symbol on the right makes this problem go away, but looks ridiculous
> if you use a prompt like PS1='\W:$(__git_ps1 "(%s)")> '

Patient: If I move my arm like this then it hurts.
Doctor: Then don't do that ;)

> 
> myrepo:master>> # master greater-than upstream
> myrepo:master<> # master less-than upstream
> myrepo:master<>> # master and upstream have diverged
> 
> I'd rather not rely on colour prompts to clear this up - using colour as the
> only way to convey important information to the user rarely ends well.
> 
> Adding a "u" to the symbol could also clear this up:
> 
> [andrew@pc myrepo u<master] # upstream less-than master
> 
> Using "u<", "u=", "u>" and "<>" would mean that the prompt always used either
> two or zero characters, which would keep prompts lined up over time.  But it
> would also eat horizontal space for an issue you'd stop seeing after a few
> minutes.
> 

I think a simple space would help already, i.e.
myrepo:master<> >

An alternative would be to use something like
myrepo:master+5-3

The numbers should make this distinguishable from the "--cached +". Of
course it eats up more space and is slightly confusing unless it is read
master = upstream + 5 -3.
OTOH it is very analogous to status -s and branch -vv.

> Finally, my apologies to anyone that tried to apply my previous patch - to make
> a long story short, it turns out I need this feature more than I realised :)
> 

;)

>  contrib/completion/git-completion.bash |   58 +++++++++++++++++++++++++++++++-
>  1 files changed, 57 insertions(+), 1 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 57245a8..1dc80fd 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -42,6 +42,14 @@
>  #       set GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there're
>  #       untracked files, then a '%' will be shown next to the branch name.
>  #
> +#       If you would like to see the difference bitween HEAD and its
> +#       upstream, set GIT_PS1_SHOWUPSTREAM to a nonempty value.
> +#       Unpushed commits (>), unmerged commits (<), both (<>) and
> +#       neither (=) will be shown on the left of the branch name.  You
> +#       can enable git-svn mode by setting GIT_PS1_SHOWUPSTREAM=svn
> +#       and set the value per-repository with the bash.showUpstream
> +#       variable.
> +#
>  # To submit patches:
>  #
>  #    *) Read Documentation/SubmittingPatches
> @@ -132,6 +140,7 @@ __git_ps1 ()
>  		local s
>  		local u
>  		local c
> +		local p
>  
>  		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
>  			if [ "true" = "$(git rev-parse --is-bare-repository 2>/dev/null)" ]; then
> @@ -159,10 +168,57 @@ __git_ps1 ()
>  			      u="%"
>  			   fi
>  			fi
> +
> +			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
> +
> +				# Note: 'p' is used as a temporary throughout this block,
> +				# before finally being assigned its correct value
> +
> +				if p="$(git config --get bash.showUpstream)"
> +				then
> +					GIT_PS1_SHOWUPSTREAM="$p"
> +				fi
> +
> +				local upstream
> +
> +				if [ "${GIT_PS1_SHOWUPSTREAM-}" = "svn" ]; then
> +
> +					# git-svn upstream checking
> +					p="$( git config --get svn-remote.svn.url )"
> +					upstream=( $( git log --first-parent -1 \
> +						--grep="^git-svn-id: $p" ) )
> +					upstream=${upstream[ ${#upstream[@]} - 2 ]}
> +					upstream=${upstream%@*}
> +					upstream=${upstream#*$p/}
> +
> +				else # git upstream checking
> +				  upstream="@{upstream}"
> +				fi
> +
> +				if p="$( git rev-list \
> +						--left-right "$upstream"...HEAD 2>/dev/null )"

Here you have all the info to do a "grep \<|wc -l" etc. instead of the
below if you go for the +5-3.

> +				then
> +					case "$p" in
> +						\<*\>*|\>*\<* ) p="<>" ;;
> +						*\<*          ) p="<"  ;;
> +						*\>*          ) p=">"  ;;
> +						""            ) p="="  ;;
> +
> +						# the following case shouldn't be possible
> +						# if you see this, please report it as a bug
> +						* ) p="?ERROR($p)?" ;;
> +
> +					esac
> +				else
> +					p=""
> +				fi
> +
> +			fi
> +
>  		fi
>  
>  		local f="$w$i$s$u"
> -		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r"
> +		printf "${1:- (%s)}" "$c$p${b##refs/heads/}${f:+ $f}$r"
>  	fi
>  }
>  

Cheers,
Michael

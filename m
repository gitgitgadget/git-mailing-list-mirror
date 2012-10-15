From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] show color hints based on state of the git tree
Date: Mon, 15 Oct 2012 10:23:13 +0200
Message-ID: <507BC7F1.3080506@drmicha.warpmail.net>
References: <7v8vbo7hmd.fsf@alter.siamese.dyndns.org> <20121005211030.GA5414@simaj.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, spearce@spearce.org,
	artagnon@gmail.com, schwab@linux-m68k.org, soosthoek@nieuwland.nl
To: Simon Oosthoek <s.oosthoek@xs4all.nl>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 10:23:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNfxQ-0002UF-OQ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 10:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447Ab2JOIXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 04:23:17 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45869 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751027Ab2JOIXP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2012 04:23:15 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 2EEA020619;
	Mon, 15 Oct 2012 04:23:15 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 15 Oct 2012 04:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=+MuYXI1BMH8oLKqegWYe0X
	XFzJo=; b=CIOzI6cCijteLDQmym1rNpdbAsc5QNUPqrRTwoEUCypUdmsRFO4Wts
	Tc7bNdbcKOII3QrER8m4vk1ImtnP5lRW1biMMXvvQHKdwu+Wt0tefXyTLFAu7r7d
	xAkRCOeUg5MPFY2ki8Fx4ka3gmFaJuKT38l0WdihY8lDIpJxSErFE=
X-Sasl-enc: jmQbxJR4ewSebYMu90UuajGXlcTEdsXBA9JCtQLTjuU9 1350289394
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0EF3D4827D0;
	Mon, 15 Oct 2012 04:23:13 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <20121005211030.GA5414@simaj.xs4all.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207725>

Sorry for being late ($DAYJOB and such), but I just noticed this is on
next already:

Simon Oosthoek venit, vidit, dixit 05.10.2012 23:10:
> By setting GIT_PS1_SHOW_COLORHINTS when using __git_ps1
> as PROMPT_COMMAND, you will get color hints in addition to
> a different character (*+% etc.)
> 
> Signed-off-by: Simon Oosthoek <soosthoek@nieuwland.nl>
> ---
>  contrib/completion/git-prompt.sh |   42 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index c50c94a..51285d7 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -53,6 +53,12 @@
>  # find one, or @{upstream} otherwise.  Once you have set
>  # GIT_PS1_SHOWUPSTREAM, you can override it on a per-repository basis by
>  # setting the bash.showUpstream config variable.
> +#
> +# If you would like a colored hint about the current dirty state, set
> +# GIT_PS1_SHOWCOLORHINTS to a nonempty value. When tracked files are
> +# modified, the branch name turns red, when all modifications are staged
> +# the branch name turns yellow and when all changes are checked in, the
> +# color changes to green. The colors are currently hardcoded in the function.
>  
>  # __gitdir accepts 0 or 1 arguments (i.e., location)
>  # returns location of .git repo
> @@ -201,11 +207,12 @@ __git_ps1_show_upstream ()
>  # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
>  # when called from PS1 using command substitution
>  # in this mode it returns text to add to bash PS1 prompt (includes branch name) or
> -# __git_ps1 accepts 0 or 2 arguments when called from PROMPT_COMMAND
> +# __git_ps1 accepts 0 or 2 arguments when called from PROMPT_COMMAND (pc)
>  # in that case it _sets_ PS1. The arguments are parts of a PS1 string.
>  # when both arguments are given, the first is prepended and the second appended
>  # to the state string when assigned to PS1, otherwise default start/end strings
>  # are used.
> +# In pcmode you can request colored hints using GIT_PS1_SHOWCOLORHINTS=true
>  __git_ps1 ()
>  {
>  	local pcmode=yes
> @@ -320,8 +327,37 @@ __git_ps1 ()
>  
>  		local f="$w$i$s$u"
>  		if [ $pcmode = yes ]; then
> -			PS1="$ps1pc_start($c${b##refs/heads/}${f:+ $f}$r$p)$ps1pc_end"
> -		elif [ $pcmode = no ]; then
> +			PS1="$ps1pc_start("
> +			if [ -n "${GIT_PS1_SHOWCOLORHINT-}" ]; then

You're missing the "S" here (HINTS).

> +				local c_red='\e[31m'
> +				local c_green='\e[32m'
> +				local c_yellow='\e[33m'
> +				local c_lblue='\e[1;34m'
> +				local c_purple='\e[35m'
> +				local c_cyan='\e[36m'
> +				local c_clear='\e[0m'
> +				local branchstring="$c${b##refs/heads/}"
> +				local branch_color="$c_green"
> +				local flags_color="$c_cyan"
> +
> +				if [ "$w" = "*" ]; then
> +					branch_color="$c_red"
> +				elif [ -n "$i" ]; then
> +					branch_color="$c_yellow"
> +				fi
> +
> +				# Setting PS1 directly with \[ and \] around colors
> +				# is necessary to prevent wrapping issues!
> +				PS1="$PS1\[$branch_color\]$branchstring\[$c_clear\]"
> +				if [ -n "$f" ]; then
> +					PS1="$PS1 \[$flags_color\]$f\[$c_clear\]"
> +				fi
> +			else
> +				PS1="$PS1$c${b##refs/heads/}${f:+ $f}$r$p"
> +			fi
> +			PS1="$PS1)$ps1pc_end"
> +		else
> +			# NO color option unless in PROMPT_COMMAND mode
>  			printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
>  		fi
>  	fi
> 

I'm afraid I don't like this coloring style at all because it is
inconsistent with the color usage of "git status -sb". First of all, the
colors are different, and second, the fact *what* is colored is
different. I had suggested following "git status -sb" for a good reason.
It colors a branch green and a detached head red. It colors "change"
(A/D/M/R) as red/green depending on non-cached/cached, so that's how */+
should be. Your call for $/% (I'd leave them uncolored).[*][**]

I think it's very confusing to have completely different schemes (not
just themes) for two versions of the same information: concise status
information.

So, please try and follow "git status -sb".

Michael

[*] Really, there's nothin "red" about a branch when there are cached or
non-cached changes. They are changes wrt. to what's in HEAD resp. the
index, no matter what HEAD is.

[**] Also, coloring the status characters opens the way to even using
the same characters as "status -sb" (ADM).

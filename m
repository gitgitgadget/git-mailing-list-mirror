From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: Re: git-prompt.sh vs leading white space in
 __git_ps1()::printf_format
Date: Wed, 12 Dec 2012 09:55:07 +0100
Message-ID: <20121212085507.GA32187@xs4all.nl>
References: <CAA01Cso1E4EC4W667FEU_af2=uGOfPuaWEB3y+zPCpB+bPzoaA@mail.gmail.com>
 <20121128132033.GA10082@xs4all.nl>
 <CAA01CspHAHN7se2oJ2WgcmpuRfoa+9Sx9sUvaPEmQ-Y+kDwHhA@mail.gmail.com>
 <50B66F41.1030305@xs4all.nl>
 <7vlidltpyj.fsf@alter.siamese.dyndns.org>
 <50C7B811.7030006@xs4all.nl>
 <7v7goo6vi3.fsf@alter.siamese.dyndns.org>
 <7vy5h45e7b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 09:56:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tii6h-0008BI-R3
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 09:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428Ab2LLIzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 03:55:43 -0500
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:1043 "EHLO
	smtp-vbr2.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359Ab2LLIzm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 03:55:42 -0500
Received: from xs8.xs4all.nl (xs8.xs4all.nl [194.109.21.8])
	by smtp-vbr2.xs4all.nl (8.13.8/8.13.8) with ESMTP id qBC8t8WO087946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Dec 2012 09:55:09 +0100 (CET)
	(envelope-from osimon@xs4all.nl)
Received: from xs8.xs4all.nl (IDENT:1251136@localhost [127.0.0.1])
	by xs8.xs4all.nl (8.14.3/8.14.3/Debian-9.4) with ESMTP id qBC8t7cX018106;
	Wed, 12 Dec 2012 09:55:08 +0100
Received: (from osimon@localhost)
	by xs8.xs4all.nl (8.14.3/8.14.3/Submit) id qBC8t7SW017845;
	Wed, 12 Dec 2012 09:55:07 +0100
Content-Disposition: inline
In-Reply-To: <7vy5h45e7b.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211334>

Hi Junio

This removes most of the ambiguities :-)
Ack from me!

I still have some minor nits, but I'll leave that for another time when I'm less busy.

BTW, I haven't tried this yet, but if you pass 2 arguments to __git_ps1 when called from command-substition mode, I suppose it will think it's in PC mode and overwrite the PS1!

At some point, I'd like to see this code split off into "pc" and "cs" functions which call a common function to get the git status. But that's a major rewrite and it may involve more overhead, since each function should process the output of the common function in a different way.

Cheers

Simon

* Junio C Hamano <gitster@pobox.com> [2012-12-11 16:03:36 -0800]:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Perhaps like this?
> 
> OK, this time with a log message.
> 
> -- >8 --
> Subject: [PATCH] git-prompt.sh: update PROMPT_COMMAND documentation
> 
> The description of __git_ps1 function operating in two-arg mode was
> not very clear.  It said "set PROMPT_COMMAND=__git_ps1" which is not
> the right usage for this mode, followed by "To customize the prompt,
> do this", giving a false impression that those who do not want to
> customize it can get away with no-arg form, which was incorrect.
> 
> Make it clear that this mode always takes two arguments, pre and
> post, with an example.
> 
> The straight-forward one should be listed as the primary usage, and
> the confusing one should be an alternate for advanced users.  Swap
> the order of these two.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  contrib/completion/git-prompt.sh | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index a8b53ba..9b074e1 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -10,14 +10,20 @@
>  #    1) Copy this file to somewhere (e.g. ~/.git-prompt.sh).
>  #    2) Add the following line to your .bashrc/.zshrc:
>  #        source ~/.git-prompt.sh
> -#    3a) In ~/.bashrc set PROMPT_COMMAND=__git_ps1
> -#        To customize the prompt, provide start/end arguments
> -#        PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
> -#    3b) Alternatively change your PS1 to call __git_ps1 as
> +#    3a) Change your PS1 to call __git_ps1 as
>  #        command-substitution:
>  #        Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
>  #        ZSH:  PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
> -#        the optional argument will be used as format string
> +#        the optional argument will be used as format string.
> +#    3b) Alternatively, if you are using bash, __git_ps1 can be
> +#        used for PROMPT_COMMAND with two parameters, <pre> and
> +#        <post>, which are strings you would put in $PS1 before
> +#        and after the status string generated by the git-prompt
> +#        machinery.  e.g.
> +#           PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
> +#        will show username, at-sign, host, colon, cwd, then
> +#        various status string, followed by dollar and SP, as
> +#        your prompt.
>  #
>  # The argument to __git_ps1 will be displayed only if you are currently
>  # in a git repository.  The %s token will be the name of the current
> -- 
> 1.8.1.rc1.128.gd8d1528
> 

From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] git-prompt.sh: Hide prompt for ignored pwd
Date: Tue, 14 Oct 2014 20:47:51 +0200
Message-ID: <543D6FD7.3090306@kdbg.org>
References: <1412795040-19267-1-git-send-email-jess.austin@gmail.com> <5435A8A7.2030008@bbn.com>  <CANp8Xb8ETG-ZFCqrOk=f-RbxtRxehBmAR1O5ozLH80zimWq_Gw@mail.gmail.com>  <CANp8Xb9MUbQCVZRNYibFBibzTFF=56BqNFFC1G2iTF7WGBNi7g@mail.gmail.com>  <54361F30.8020603@bbn.com> <CANp8Xb_kdpzYjWZxoWFtT+UWwMPpFD0znkoEKVpdukGf61Preg@mail.gmail.com>  <5437078B.6020307@bbn.com> <1413253924-8065-1-git-send-email-jess.austin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org
To: Jess Austin <jess.austin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 20:47:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xe78Z-0000Kh-GA
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 20:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbaJNSr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 14:47:56 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:14494 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753413AbaJNSrz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 14:47:55 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3jHQjb3pvBz5tlD;
	Tue, 14 Oct 2014 20:47:31 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 933DC19F5CD;
	Tue, 14 Oct 2014 20:47:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <1413253924-8065-1-git-send-email-jess.austin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.10.2014 um 04:32 schrieb Jess Austin:
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index c5473dc..d7559ff 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -84,6 +84,11 @@
>  # GIT_PS1_SHOWCOLORHINTS to a nonempty value. The colors are based on
>  # the colored output of "git status -sb" and are available only when
>  # using __git_ps1 for PROMPT_COMMAND or precmd.
> +#
> +# If you would like __git_ps1 to do nothing in the case when the current
> +# directory is set up to be ignored by git, then set
> +# GIT_PS1_HIDE_ON_IGNORED_PWD to a nonempty value, or set
> +# bash.hideOnIgnoredPwd to true in the repository configuration.
>  
>  # check whether printf supports -v
>  __git_printf_supports_v=
> @@ -501,6 +506,13 @@ __git_ps1 ()
>  	local f="$w$i$s$u"
>  	local gitstring="$c$b${f:+$z$f}$r$p"
>  
> +	if [ -n "$(git check-ignore .)" ] &&
> +	   ( [ -n "${GIT_PS1_HIDE_ON_IGNORED_PWD}" ] ||
> +	     [ "$(git config --bool bash.hideOnIgnoredPwd)" = "true" ] )

Ahem, no. Please do not punish users who are not interested in the new
feature with two new processes every time __git_ps() is run. Think of
Windows where fork() is really, *really* expensive.

BTW, you can write '{ foo || bar; }' to bracket a || chain without a
sub-process.

> +	then
> +		printf_format=""
> +	fi
> +
>  	if [ $pcmode = yes ]; then
>  		if [ "${__git_printf_supports_v-}" != yes ]; then
>  			gitstring=$(printf -- "$printf_format" "$gitstring")

-- Hannes

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH, properly formatted] git-commit: add a --interactive option
Date: Mon, 05 Mar 2007 00:54:02 -0800
Message-ID: <7v4pp0136d.fsf@assigned-by-dhcp.cox.net>
References: <45EBCD81.8020605@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Mon Mar 05 09:54:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO8xO-0005Oc-Ks
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 09:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbXCEIyF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 03:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbXCEIyF
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 03:54:05 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:63931 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbXCEIyD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 03:54:03 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070305085402.LYST26279.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Mon, 5 Mar 2007 03:54:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Wwu21W00C1kojtg0000000; Mon, 05 Mar 2007 03:54:03 -0500
In-Reply-To: <45EBCD81.8020605@lu.unisi.ch> (Paolo Bonzini's message of "Mon,
	05 Mar 2007 08:57:53 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41425>

Paolo Bonzini <paolo.bonzini@lu.unisi.ch> writes:

> ... Since
> interactive stuff does not require backward compatibility in general,
> I would ask to commit my patch anyway, assuming that in the future the
> feature is rewritten to conform to the flow you indicate...

I think people feel changes to interactive workflow is a big
deal.

> diff --git a/git-commit.sh b/git-commit.sh
> index be3677c..e8ec3b9 100755
> --- a/git-commit.sh
> +++ b/git-commit.sh
> ...
>  esac
>  unset only
> +case "$all,$interactive,$also,$#" in
> +*t,*t,*)
> +	die "Cannot use -a, --interactive or -i at the same time." ;;
>  t,,[1-9]*)
>  	die "Paths with -a does not make sense." ;;
> +,t,[1-9]*)
> +	die "Paths with --interactive does not make sense." ;;
> +,,t,0)
>  	die "No paths with -i does not make sense." ;;
>  esac

Clever.

> @@ -344,6 +352,9 @@ t,)
>  	) || exit
>  	;;
>  ,)
> +	if test "$interactive" = t; then
> +		git add --interactive || exit
> +	fi
>  	case "$#" in
>  	0)
>  		;; # commit as-is

If we were to do this, we probably would want a way to exit
non-zero from "git-add -i", but I guess we can say we already
have that way via ^C.

Will queue for 'next', but it's getting late here so it probably
would not appear on the public repository tonight.

Thanks.

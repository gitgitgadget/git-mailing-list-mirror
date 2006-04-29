From: Junio C Hamano <junkio@cox.net>
Subject: Re: fatal: git-write-tree: not able to write tree
Date: Sat, 29 Apr 2006 11:34:26 -0700
Message-ID: <7v1wvg8c3x.fsf@assigned-by-dhcp.cox.net>
References: <20060429132324.31638.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 29 20:34:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZuH1-00072v-2s
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 20:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWD2Se2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Apr 2006 14:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWD2Se2
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 14:34:28 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:5285 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750779AbWD2Se2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Apr 2006 14:34:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060429183427.JKRH27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 29 Apr 2006 14:34:27 -0400
To: colin@horizon.com
In-Reply-To: <20060429132324.31638.qmail@science.horizon.com>
	(colin@horizon.com's message of "29 Apr 2006 09:23:24 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19314>

colin@horizon.com writes:

> diff --git a/git-am.sh b/git-am.sh
> index eab4aa8..872145b 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -376,6 +376,13 @@ do
>  			echo "No changes - did you forget update-index?"
>  			stop_here $this
>  		fi
> +		unmerged=$(git-ls-files -u)
> +		if test -n "$unmerged"
> +		then
> +			echo "You still have unmerged paths in your index"
> +			echo "did you forget update-index?"
> +			stop_here $this
> +		fi
>  		apply_status=0
>  		;;
>  	esac
>
> Er... it's very non-obvious to me why you'd want to stick a workaround
> here when you could instead fix git-write-tree to do it.  That seems
> like The Right Thing.

As I said in an earlier message in the thread, I've considered
it, but that is a very risky thing to do, and write-tree is
definitely a wrong place to do it.  If we wanted to, the right
way would be to update-index using the output of "ls-files -u".

However, it would invite the user to mistakenly say --resolved
before resolving all paths.

> (It would also be helpful to mention at least one unmerged file by name.)

That is true.

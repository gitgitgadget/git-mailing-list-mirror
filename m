From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] bisect reset: Leave the tree in usable state if git-checkout failed
Date: Mon, 16 Oct 2006 03:02:32 +0200
Message-ID: <20061016010232.GX20017@pasky.or.cz>
References: <20061016005925.27019.38262.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 16 03:02:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZGsH-0006iS-SV
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 03:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWJPBCe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 21:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbWJPBCe
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 21:02:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:62618 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750892AbWJPBCe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Oct 2006 21:02:34 -0400
Received: (qmail 27432 invoked by uid 2001); 16 Oct 2006 03:02:32 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20061016005925.27019.38262.stgit@machine.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28940>

Dear diary, on Mon, Oct 16, 2006 at 02:59:25AM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> I had local modifications in the tree and doing bisect reset required me to
> manually edit .git/HEAD.
> 
> Signed-off-by: Petr Baudis <pasky@suse.cz>
> ---
> 
>  git-bisect.sh |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 06a8d26..09cd179 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -179,11 +179,12 @@ bisect_reset() {
>          *)
>  	    usage ;;
>  	esac
> -	git checkout "$branch" &&
> -	rm -fr "$GIT_DIR/refs/bisect"
> -	rm -f "$GIT_DIR/refs/heads/bisect" "$GIT_DIR/head-name"
> -	rm -f "$GIT_DIR/BISECT_LOG"
> -	rm -f "$GIT_DIR/BISECT_NAMES"
> +	if ! git checkout "$branch"; then

Doh, please drop the !. I had it that way before and added the negation
mark as a last-minute "fix". :/ Sorry. Not being too good at doing
random shell fixes in the middle of C coding.

> +		rm -fr "$GIT_DIR/refs/bisect"
> +		rm -f "$GIT_DIR/refs/heads/bisect" "$GIT_DIR/head-name"
> +		rm -f "$GIT_DIR/BISECT_LOG"
> +		rm -f "$GIT_DIR/BISECT_NAMES"
> +	fi
>  }
>  
>  bisect_replay () {

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)

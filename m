From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Properly git-bisect reset after bisecting from non-master head
Date: Sun, 12 Feb 2006 20:41:46 +0100
Message-ID: <20060212194146.GX31278@pasky.or.cz>
References: <20060212160614.GV31278@pasky.or.cz> <7vhd749xtl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 20:41:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8N5t-0004ee-Ck
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 20:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWBLTlK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 14:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbWBLTlK
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 14:41:10 -0500
Received: from w241.dkm.cz ([62.24.88.241]:14037 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750865AbWBLTlJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 14:41:09 -0500
Received: (qmail 26636 invoked by uid 2001); 12 Feb 2006 20:41:46 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhd749xtl.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16017>

Dear diary, on Sun, Feb 12, 2006 at 08:33:26PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > diff --git a/git-bisect.sh b/git-bisect.sh
> > index 51e1e44..3c024aa 100755
> > --- a/git-bisect.sh
> > +++ b/git-bisect.sh
> > @@ -49,9 +49,16 @@ bisect_start() {
> >  	die "Bad HEAD - I need a symbolic ref"
> >  	case "$head" in
> >  	refs/heads/bisect*)
> > -		git checkout master || exit
> > +		if [ -s "$GIT_DIR/head-name" ]; then
> > +		    branch=`cat "$GIT_DIR/head-name"`
> > +		else
> > +		    branch=master
> > +	        fi
> > +		git checkout $branch || exit
> >  		;;
> >  	refs/heads/*)
> > +		[ -s "$GIT_DIR/head-name" ] && die "won't bisect on seeked tree"
> > +		echo "$head" | sed 's#^refs/heads/##' >"$GIT_DIR/head-name"
> >  		;;
> 
> Hmph.  It seems that $GIT_DIR/head-name might want to be a
> symbolic ref?

That probably isn't a bad idea per se, but I can't think of anything
which that would improve either, and this has the plus of being
compatible with Cogito.

Anyway, if you want a symref, you should probably give it a different
name.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams

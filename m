From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Problem with cg-merge
Date: Sun, 29 May 2005 20:48:30 +0200
Message-ID: <20050529184830.GM1036@pasky.ji.cz>
References: <1117379092.7072.90.camel@pegasus> <20050529180742.GA31388@diku.dk> <1117390650.7072.100.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <fonseca@diku.dk>,
	GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 29 20:46:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcSng-0002U2-Ob
	for gcvg-git@gmane.org; Sun, 29 May 2005 20:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVE2Ssj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 14:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVE2Ssj
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 14:48:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:28800 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261400AbVE2Ssc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 14:48:32 -0400
Received: (qmail 13921 invoked by uid 2001); 29 May 2005 18:48:30 -0000
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1117390650.7072.100.camel@pegasus>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 29, 2005 at 08:17:30PM CEST, I got a letter
where Marcel Holtmann <marcel@holtmann.org> told me that...
> Hi Jonas,
> 
> > > I saw that earlier, but I don't have any idea what's wrong here. If I do
> > > a simple cg-update, I see something like this:
> > > 
> > > Tree change: cf1f29d97210d0594dcf5b2a734bdb714de6bf24:89a14a5bd2c880095d5c618a102319bb3dc03da9
> > > :100755 100755 ceda2c50fc2c2941daa34a57722df251bf892c38 fea239b99d351502d1acb098abd725557f0af202 M      cg-diff
> > > :100755 100755 cc0c17beef75db41da3ad4ef8983bd7e222ac739 5f0bff77eb2110d52892793e5bef104acde7be32 M      cg-help
> > > 
> > > Applying changes...
> > > Fast-forwarding cf1f29d97210d0594dcf5b2a734bdb714de6bf24 -> 89a14a5bd2c880095d5c618a102319bb3dc03da9
> > >         on top of cf1f29d97210d0594dcf5b2a734bdb714de6bf24...
> > > patching file cg-diff
> > > patching file cg-help
> > > cg-diff: needs update
> > > cg-help: needs update
> > > 
> > > This is a little bit odd, because if I call "git-diff-cache HEAD" after
> > > it, I will see that cg-diff and cg-help are modified. After calling
> > > cg-cancel everything looks fine again.
> > 
> > The following change fixes cg-update for me. This is in tree_timewarp().
> > 
> > --- 0ca4ae56fa7bbd8d10e2c2791e389bc19977e460/cg-Xlib  (mode:100755)
> > +++ uncommitted/cg-Xlib  (mode:100755)
> > @@ -66,7 +66,7 @@
> >  		# XXX: This may be suboptimal, but it is also non-trivial to keep
> >  		# the adds/removes properly.  So this is just a quick hack to get it
> >  		# working without much fuss.
> > -		cg-diff -r $branch >$patchfile
> > +		cg-diff >$patchfile
> >  	fi
> >  
> >  	git-read-tree -m "$branch" || die "$branch: bad commit"
> 
> this looks better now. Petr, please apply this patch.

Bah. Well if your imaginary friend in your head told you this is
obviously just a no-go workaround, (s)he was right for once. You just
broke cg-admin-uncommit with this one, the real fix is to tell
tree_timewarp to rollback the tree (or rather rollforth here ;-). This
way the right branch of this if will be invoked.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor

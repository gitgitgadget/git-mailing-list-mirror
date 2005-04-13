From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: Re: Remove need to untrack before tracking new branch
Date: Thu, 14 Apr 2005 00:19:37 +0200
Message-ID: <20050413221936.GI25711@pasky.ji.cz>
References: <20050411135758.GA3524@pasky.ji.cz> <1113310045.23299.15.camel@nosferatu.lan> <20050412130250.GG22614@pasky.ji.cz> <1113311595.23299.17.camel@nosferatu.lan> <20050412132307.GH22614@pasky.ji.cz> <1113375277.23299.25.camel@nosferatu.lan> <20050413075441.GD16489@pasky.ji.cz> <1113381672.23299.47.camel@nosferatu.lan> <20050413092656.GO16489@pasky.ji.cz> <1113394537.23299.51.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 00:17:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLqA0-0003il-VU
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 00:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVDMWTq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 18:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVDMWTq
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 18:19:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:5560 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261217AbVDMWTj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2005 18:19:39 -0400
Received: (qmail 18430 invoked by uid 2001); 13 Apr 2005 22:19:37 -0000
To: Martin Schlemmer <azarah@nosferatu.za.org>
Content-Disposition: inline
In-Reply-To: <1113394537.23299.51.camel@nosferatu.lan>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I didn't weed out the replies since this was not cc'd to the mailing
list and I believe it could contain some useful information for google
or whatever to pick. :-)

Dear diary, on Wed, Apr 13, 2005 at 02:15:37PM CEST, I got a letter
where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> On Wed, 2005-04-13 at 11:26 +0200, Petr Baudis wrote:
> > BTW, why aren't we cc'ing the list?
> > 
> 
> Hmm, no reason really.  If you want to, will do next time.
> 
> > Dear diary, on Wed, Apr 13, 2005 at 10:41:12AM CEST, I got a letter
> > where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > > On Wed, 2005-04-13 at 09:54 +0200, Petr Baudis wrote:
> > > PS: not having looked deeper yet, why does fsck-cache always find
> > > unreferenced blobs/commits (no matter what tree is tracked, they stay
> > > the same) ?  And trying to remove them leads to more, which leads to an
> > > empty .git/opjects/ =)  Also, leading to this, will adding an option to
> > > remove disconnected commits/blobs from local commits (that was
> > > disconnected with a pull) be a viable option to add?
> > 
> > fsck-cache is concerned only by the objects database, so all the HEADs
> > are unreferenced commits too. This is a right thing, the HEAD tracking
> > should stay purely in the scripts - if we want to make fsck-cache
> > smarter about that, we should implement git fsck or something.
> > 
> > Killing unreferenced blobs should be safe, I think.
> > 
> > > First, about the 'git diff' thing I asked yesterday .. what I meant, was
> > > should it actually output this:
> > > 
> > > ----
> > > COPYING:  fe2a4177a760fd110e78788734f167bd633be8de 33
> > > Makefile:  929aa49a3dbe683ad52094099797bc636a7949a6 33
> > > README:  46c6a9ea48ddd1dda45ca585f49975a6869ffe51 33
> > > ...
> > > ----
> > > 
> > > Shouldn't it just show actual changes?
> > 
> > This is an actual change. It's just that it's a change to metadata
> > (somewhat esotherically described by the "33"), not the file contents.
> > 
> > BTW, git diff does actually something completely different from git diff
> > with any arguments. It diffs to the directory cache, not to any tree! It
> > just wraps show-diff, which has also a different output format (not
> > outputting "git diffs"). The worst thing is that it requires a different
> > -p option to apply. Someone should purge this wart, I think.
> > 
> 
> Check applied patch (also in the new output).

Please send patches inline and properly signed off.

> > > Also on the same note .. should 'git ci' without listed files to be
> > > committed, really add a reference to all files as it currently do in the
> > > commit/blob/whatever info, instead of just the changed/added files (see
> > > the git-seperate-dir.patch you have not yet commented on for reference)?
> > 
> > ...
> > 
> 
> Patch will also resolve this.

I'm sorry - the ellipsis was there so that I'll write up a reply for
that later but I forgot.

Your patch is bad - it removes the pure metadata changes, but you
definitively do not want to do that! If you are annoyed by meaningless
time changes etc, do update-cache --refresh. Ignoring mode changes is a
pure disaster.

> > > Secondly, how about style/error issues?  Basically on the style front,
> > > currently some scripts use bash - how about pure bash for all:
> > > 
> > > ----
> > > [[ -n ${tracking} ]] && \
> > > ----
> > > 
> > > rather than:
> > > 
> > > ----
> > > [ "$tracking" ] && \
> > > ----
> > > 
> > > as you do not need the quotes, and for checking files, etc, it just do
> > > better handling than single quotes.  I am prepared to do patches if you
> > > like.
> > 
> > Well. I'm just not used to it and not quite sure about how it behaves
> > etc. So far I tried to make it as sh-like as possible, using bash
> > features only when absolutely necessary. I'm not saying this is the best
> > approach, but I wouldn't change it *now* (especially since it would slow
> > me down which I really don't want now) if someone doesn't give me some
> > really compelling arguments.
> > 
> 
> No problem.
> 
..snip..
> > > 2) Did not add the gitapply.sh that was new in your tree
> > 
> > This very bug should be fixed by introduction of gitapply.sh. ;-)
> > 
> > Actually I forgot to implement this. Fixed now.
> > 
> > > I guess I might have done things wrong (wrong way around)?  But the
> > > actual question is this .. when I tried to switch, it failed on the
> > > gitapply.sh hunk, but went on anyway ... how about doing a patch
> > > --dry-run first, and showing the user what would happen if that fails,
> > > asking for confirmation?
> > 
> > Just s/merge -b/diff/ on the command line and it will show precisely
> > what it is going to apply.  When we get the automatic base detection
> > something to just print the base could be indeed useful.
> > 
> > If that fails, all what will happen is that the user gets rejects. No
> > big deal. He can anytime just back out by
> > 
> > 	git diff | patch -p0 -R
> > 
> > So, what did it "went on" with? The merge (nor the tracked pull) never
> > commits anything. That's up to you, after you resolve the conflicts and
> > make sure everything is right.
> > 
> 
> Ah, right.
> 
> > > I know its in its infancy, but I am not sure on what scm you are basing
> > > it, so not sure how things should behave.
> > 
> > I'm trying to base it on common sense and principle of least surprise.
> > :-)
> > 
> 
> Ok, I'll just bug you then if I am not sure on how you want something ;p

Or do it somehow and I'll bug you back if I don't like it. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor

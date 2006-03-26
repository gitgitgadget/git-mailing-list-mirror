From: Petr Baudis <pasky@suse.cz>
Subject: Re: Following renames
Date: Sun, 26 Mar 2006 21:14:45 +0200
Message-ID: <20060326191445.GQ18185@pasky.or.cz>
References: <20060326014946.GB18185@pasky.or.cz> <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org> <44264426.8010608@michonline.com> <20060326014946.GB18185@pasky.or.cz> <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org> <20060326100717.GD18185@pasky.or.cz> <Pine.LNX.4.64.0603260829550.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 21:14:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNahG-00056x-18
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 21:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWCZTOd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 14:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWCZTOd
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 14:14:33 -0500
Received: from w241.dkm.cz ([62.24.88.241]:41112 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751234AbWCZTOd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 14:14:33 -0500
Received: (qmail 25859 invoked by uid 2001); 26 Mar 2006 21:14:45 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603260829550.15714@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18054>

Dear diary, on Sun, Mar 26, 2006 at 06:33:13PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> If you do
> 
> 	git-rev-list --parents --remove-empty $REV -- $filename
> 
> then you'll get the whole history for that filename. When it ends, you 
> know the file went away, and then you do basically _one_ "where the hell 
> did it go" thing.
> 
> And yes, it's not git-ls-tree (unless you only want to follow pure 
> renames), it's actually one "git-diff-tree -M $lastrev". Then you just 
> continue with the new filename (and do another "git-rev-list" until you 
> hit the next rename).

I wrote a long rant but then it all suddenly fit together and I have now
an idea how to implement it reasonably elegantly.

So only a bugreport remains:

My current target is to support this tree (letters are filenames,
numbers are commit ids; I'll translate any git output to those digits):

    2    4
    b -- d
1 /        \ 6
a            d
  \ 3    5 /
    c -- d

With the commits created in the numerical order (so log shows
1,2,3,4,5,6, and my target is cg-log d showing the same output). If
anyone wants the sample history, it's at

	http://pasky.or.cz/~xpasky/renametree1.git/

Curiously, git-rev-list does something totally strange when trying to
list per-file history at this point:

	$ git-rev-list HEAD -- d
	4

Huh? (It should list 6, 5, 4 instead.)

I worked it around by recording a change in d in the merge 6:

	http://pasky.or.cz/~xpasky/renametree2.git/

	$ git-rev-list --parents --remove-empty HEAD -- d
	6 4 5
	5
	4

Which is the expected output.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.

From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Question around git-shell usage in Everyday Git
Date: Thu, 2 Feb 2006 05:17:05 +0000
Message-ID: <200602020517.05827.alan@chandlerfamily.org.uk>
References: <200602012301.56141.alan@chandlerfamily.org.uk> <7vy80u64xf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602011530530.21884@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 06:17:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4WqF-0003uk-IO
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 06:17:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422932AbWBBFRI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 00:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422933AbWBBFRI
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 00:17:08 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:54190
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1422932AbWBBFRH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2006 00:17:07 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1F4Wq8-0000PN-Ha; Thu, 02 Feb 2006 05:17:04 +0000
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.9.1
In-Reply-To: <Pine.LNX.4.64.0602011530530.21884@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15483>

On Wednesday 01 February 2006 23:37, Linus Torvalds wrote:
> On Wed, 1 Feb 2006, Junio C Hamano wrote:
> > Do you mean to reuse single directory /home/gitu/ for user A, B, C,
> > and hang repositories /home/gitu/{X,Y,Z} for projects?  I'd
> > imagine things could be arranged that way.  User A and B but not
> > C may be in "projectX" group and /home/gitu/X is writable only
> > by projectX group members and such...
>
> That would work from a _git_ angle, but I don't think that was what Alan
> was talking about, and it would failr horribly from a "ssh" perspective
> (because "ssh" will want $HOME/.ssh/authorized_keys etc).
>
> So I _think_ what Alan was describing was just a
>
> 	/home/user-A/project.git
> 		     another-project.git
> 		     ya-project.git
> 	      user-B/myproject.git
> 	      user-C/..
>

Actually Junio was right in layout - but I am not sure he understands what I 
want to achieve.

What I have in mind is that I am a personal developer at home with my own 
server.  I have written various code in a number of projects whose public 
repositories are all located under /var/lib/git. 
(ie /var/lib/git/projectA.git, /var/lib/git/projectB.git) and they are all 
shareable.

git-daemon is run with base-path as /var/lib/git and have defined user "git" 
to have a home directory of /var/lib/git and git-shell as his shell, so 
anyone can clone from them

So, if my projects take off, and I have some outside developers helping me, I 
do not want to give them individual home directories on my server instead my 
plan_had_ been to collect their public keys at put them 
in /var/lib/git/.ssh/authorized_keys, and then tell them to push to the 
repository via

URL:git@home.chandlerfamily.org.uk:projectA.git

etc.

The downside of this approach is that all developers get access to all 
repositories - maybe I need better control.


Then I saw the howto on repository control with the update hook and was 
thinking that I could do it as follows

in /etc/password create an entry for each developer with a home directory 
of /var/lib/git and git shell. (so I DO NOT create a large number of /home 
directories at all) and make them members of group git.

Then each developer would access the repository via

URL:home.chandlerfamily.org.uk:projectx.git

but would be only allowed access if they were on a white list within each 
project.

Thats when I asked the question that started this thread.  

Since then I have realised that the downside of this is that its pretty easy 
to fake being someone else and getting access by just giving someone elses 
name.

So the third approach I am now contemplating is to actually create separate 
users for each project

so user projectA had a home directory of /var/lib/git/projectA.git with a 
subdirectory of .ssh for the authorized keys file.

Super users (e.g. ME) would have their keys 
in /var/lib/git/.ssh/authorized_keys

Individual project developers would have their keys in 

/var/lib/git/projectA.git/.ssh/authorized_keys etc

and would access the repository with

URL:ProjectA@home.chandlerfamily.org.uk:.

 
-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.

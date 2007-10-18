From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: git push bug?
Date: Thu, 18 Oct 2007 18:10:47 +0200
Organization: Transmode AB
Message-ID: <1192723847.9433.25.camel@gentoo-jocke.transmode.se>
References: <1192719040.9433.5.camel@gentoo-jocke.transmode.se>
	 <0DAC53EF-021D-441C-9520-9795AAB6DE54@zib.de>
	 <1192723269.9433.21.camel@gentoo-jocke.transmode.se>
Reply-To: joakim.tjernlund@transmode.se
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Oct 18 18:13:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiXzl-00029J-Dd
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 18:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756592AbXJRQNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 12:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758248AbXJRQM7
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 12:12:59 -0400
Received: from mail.transmode.se ([83.241.175.147]:22957 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750871AbXJRQM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 12:12:59 -0400
Received: mail.transmode.se 192.168.46.15 from 192.168.1.15 192.168.1.15 via HTTP with MS-WebStorage 6.0.6249
Received: from gentoo-jocke by mail.transmode.se; 18 Oct 2007 18:12:57 +0200
In-Reply-To: <1192723269.9433.21.camel@gentoo-jocke.transmode.se>
X-Mailer: Evolution 2.10.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61542>

On Thu, 2007-10-18 at 18:01 +0200, Joakim Tjernlund wrote:
> On Thu, 2007-10-18 at 17:14 +0200, Steffen Prohaska wrote:
> > On Oct 18, 2007, at 4:50 PM, Joakim Tjernlund wrote:
> > 
> > >
> > > I thougth I could create a new branch on the server using:
> > >
> > > # > git push ssh://devsrv/var/git/os2kernel.git linus:refs/linus
> > > Warning: No xauth data; using fake authentication data for X11  
> > > forwarding.
> > > updating 'refs/linus' using 'refs/heads/linus'
> > >  from 0000000000000000000000000000000000000000
> > >  to bbf25010f1a6b761914430f5fca081ec8c7accd1
> > > Generating pack...
> > > Done counting 0 objects.
> > > Writing 0 objects...
> > > Total 0 (delta 0), reused 0 (delta 0)
> > > error: refusing to create funny ref 'refs/linus' locally
> > > ng refs/linus funny refname
> > > error: failed to push to 'ssh://devsrv/var/git/os2kernel.git'
> > >
> > > but that doesn't work. Am I doing this wrong?
> > 
> > Include 'heads' in your remote refspec:
> > 
> >     git push ssh://devsrv/var/git/os2kernel.git linus:refs/heads/linus
> 
> Now the push went OK:
> git push  ssh://devsrv/var/git/os2kernel.git linus:refs/head/linus
> Warning: No xauth data; using fake authentication data for X11 forwarding.
> updating 'refs/head/linus' using 'refs/heads/linus'
>   from 0000000000000000000000000000000000000000
>   to   bbf25010f1a6b761914430f5fca081ec8c7accd1
> Generating pack...
> Done counting 0 objects.
> Writing 0 objects...
> Total 0 (delta 0), reused 0 (delta 0)
> refs/head/linus: 0000000000000000000000000000000000000000 -> bbf25010f1a6b761914430f5fca081ec8c7accd1
> 
> but there is no linus branch in the server repo!
> 
> However:
>  git push  ssh://devsrv/var/git/os2kernel.git linus
> 
> creates a linus branch in the server and 
> 
>  git push  ssh://devsrv/var/git/os2kernel.git :linus
>  Warning: No xauth data; using fake authentication data for X11 forwarding. 
>  deleting 'refs/heads/linus'
>  refs/heads/linus: bbf25010f1a6b761914430f5fca081ec8c7accd1 -> deleted
>  Everything up-to-date
> 
> deletes the linus branch on the server and so does
> git push  ssh://devsrv/var/git/os2kernel.git :refs/heads/linus
> 
> ahh, now I see. When creating the branch the refspec needs to be refs/heads/linus,
> not refs/head/linus
> 
> refs/head/linus will create just that on the server. git branch does not look
> there, only in refs/heads
> 
> Seems like it is a bit too easy to make mistakes here. Why can I delete
> a branch with :linus but not create one with linus:linus?
> Also confusing that git lets me create refs/head/linus when git branch
> cannot find it.
> 
>  Jocke

BTW this does not work either:

git reset --hard HEAD^
git push -f  ssh://devsrv/var/git/os2kernel.git +master:master
updating 'refs/heads/master'
  from 9c344d18d01221c8f25080cb58910e6b09efbf55
  to   5761a9e5924b34615c748fba2dcb977ed04c1243
Generating pack...
Done counting 0 objects.
Writing 0 objects...
Total 0 (delta 0), reused 0 (delta 0)
error: denying non-fast forward refs/heads/master (you should pull first)
ng refs/heads/master non-fast forward
error: failed to push to 'ssh://devsrv/var/git/os2kernel.git'

I thought the + in +master:master and the -f option should let me
do that.

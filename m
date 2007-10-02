From: Barry Fishman <barry_fishman@acm.org>
Subject: Re: Problems setting up bare repository (git 1.5.3.3)
Date: Tue, 02 Oct 2007 09:54:46 -0400
Message-ID: <m34ph9tye1.fsf@barry_fishman.acm.org>
References: <m3fy0u7bk3.fsf@barry_fishman.acm.org>
	<7vejgeqxd1.fsf@gitster.siamese.dyndns.org>
	<87bqbisae6.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0710021045430.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 15:55:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IciDN-0005OW-KH
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 15:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958AbXJBNzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 09:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752349AbXJBNzA
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 09:55:00 -0400
Received: from main.gmane.org ([80.91.229.2]:34159 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752082AbXJBNy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 09:54:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IciD7-0006SN-7T
	for git@vger.kernel.org; Tue, 02 Oct 2007 13:54:53 +0000
Received: from fl-71-0-147-208.dhcp.embarqhsd.net ([71.0.147.208])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 13:54:53 +0000
Received: from barry_fishman by fl-71-0-147-208.dhcp.embarqhsd.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 13:54:53 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: fl-71-0-147-208.dhcp.embarqhsd.net
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:FtmeSnoNFDOPKGQ+mn7GR9NQHbI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59691>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> Well, if the OP had used "git push <bla> master" instead of 
> "... master:master", it would have worked.  I am unaware of any tutorial 
> that suggests the latter, only of tutorials that suggest the former.

I did recheck the tutorials, and did not find the code I was
using.  So there was nothing incorrect in the documentation.

As for "master working where "master:master" didn't, this only exposes a
more complex set of rules.  I was not hoping for a more complex set of
rules to learn, as GIT tried to figure out what I meant.  I was hoping
for a simpler command that did what I told it to do, and I was given it
by Junio Hamano.

What distracted me was that after the "git --bare init", there seemed to
be a incompletely defined setup.  This sent me down the wrong path.

Although there was a master branch to which HEAD pointed, there was no
ref/heads/master file or even a "packed-refs".  This also confuses the
the "git branch" command, so that when I initial tried "git --bare
branch" it seemed unaware of any master branch.  I then tried:

$ git --bare branch refs/heads/master
fatal: Not a valid object name: 'master'.

If there isn't an initial master branch, then shouldn't "git branch" be
able to create one.  And if there is one, shouldn't the automatic rules
explained in git-rev-parse man page find it?  The error messages from
the branch command is what got me on the wrong logical path.

The man page for git-init says:

  This command creates an empty git repository - basically a .git directory
  with subdirectories for objects, refs/heads, refs/tags, and template
  files. An initial HEAD file that references the HEAD of the master branch
  is also created.

Which is true, but although there is a HEAD that references the
master branch, there isn't really any master branch.  It might
say something like:

  This command creates an empty git repository - basically a .git directory
  with subdirectories for objects, refs/heads, refs/tags, and template
  files. An initial HEAD file references the refs/heads/master branch
  which is created with the first commit.

This would at least somewhat explain "git branch" results.

The man page for git-push seems clear to me now.  I should have
more closely read the last example.  The first example might
be changed to say:

git push origin master
    Find a ref that matches master in the source repository (most
    likely, it would find refs/heads/master), and update (or create) the
    same ref, refs/heads/master, in the origin repository with it.

-- 
Barry Fishman

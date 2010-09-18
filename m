From: "Neal Kreitzinger" <nkreitzinger@gmail.com>
Subject: symlink impact: parent dir of working tree is a symlink
Date: Fri, 17 Sep 2010 20:11:30 -0500
Message-ID: <i713k3$nco$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 18 07:05:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owpbu-0002lE-2N
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 07:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007Ab0IRFFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 01:05:05 -0400
Received: from lo.gmane.org ([80.91.229.12]:35472 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309Ab0IRFFF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 01:05:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Owpbj-0002gH-Sw
	for git@vger.kernel.org; Sat, 18 Sep 2010 07:05:03 +0200
Received: from 24-155-210-59.dyn.grandenetworks.net ([24.155.210.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 18 Sep 2010 07:05:03 +0200
Received: from nkreitzinger by 24-155-210-59.dyn.grandenetworks.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 18 Sep 2010 07:05:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 24-155-210-59.dyn.grandenetworks.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156430>

      What is the impact if the parent directory of a git repo is a symlink?

      In the git release notes I've noticed a trend of symlinks not playing 
well with git.  I don't normally use symlinks, but my impression is that the 
git release notes were referring to the scenario when a subset of files in 
your working tree are symlinks.  I have a symlink scenario I now have to 
deal with and I'm not sure what impact it will have on my git results.  Here 
is the scenario:

      *At this time, all of our git repos reside on the root partition of a 
single linux server.
      *We have two systems under development and they have separate 
"development environments":
      (a)One dev environment uses the linux command line to maneuver the 
file system and to run their git commands.
      (b)The other dev environment uses an in-house developed menu system 
that is text-based using bash scripts to run the git commands.  The users 
are not supposed to run any git commands from command line in this dev 
environment (This was not my decision so please don't hold it against me.)
      *System (a) gets periodically merged into (b) by rebasing (a) onto 
(b).  (a) is the legacy system and (b) is the future system.  (a) resides 
under /home/user/ where there are several users, and (b) resides under 
/opt/xyz/
      *We have a goldbox (baremetal linux server) that contains several git 
repos and they are all full copy clones made with the file:/// url.  The 
goldbox is a "powerful" box.
      *We have a betabox (baremetal linux server) that is for testing risky 
procedures before implementing them on the goldbox.  The betabox is a 
"weaker" box.
      *I need to bring the betabox up-to-date with the goldbox, but the 
development environment on the root partition of the goldbox is too big to 
fit on the root partition of the betabox.  Therefore, we have symlinked the 
/opt/xyz/ and /home/ directories to the /u/ partition (which resides on the 
same hard-disk as the root partition) which has plenty of space to hold the 
development environment.
      *As a result, the scripts that point to /opt/xyz/ and /home/user/ to 
find the git repos on the root partition of the goldbox will still work on 
the betabox, but on the betabox these paths are symlinked to /u/ partition.
      */opt/xyz/ and /home/ are the only symlinks.  There are no symlinks in 
the working trees or .git directories or git template directories.  None of 
the "external" git files, e.g. gitconfig, .gitconfig, or template files are 
symlinks.
      *Is this betabox setup still valid for a beta test for the goldbox? 
Has this symlink setup that I've introduced on the betabox introduced  a 
difference that could cause git to produce different results?  If I have 
introduced a such a difference, how much impact do you think it will have? 
How valid do you think the results on such a betabox would be for proving 
their safety on the goldbox?

      If this betabox setup with symlinks is a valid beta test for the 
goldbox, this would save us from having to rebuild the betabox with a larger 
root partition.  Thanks!

      v/r,
      Neal

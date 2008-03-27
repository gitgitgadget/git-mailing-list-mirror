From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: symbolic link management in git-archive
Date: Thu, 27 Mar 2008 12:11:48 +0000 (UTC)
Message-ID: <loom.20080327T115110-82@post.gmane.org>
References: <loom.20080327T112740-539@post.gmane.org> <20080327114024.GR14567@genesis.frugalware.org> <alpine.LSU.1.00.0803271244420.3802@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 13:13:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeqyP-0004Ru-Rm
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 13:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756478AbYC0MMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 08:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756070AbYC0MMG
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 08:12:06 -0400
Received: from main.gmane.org ([80.91.229.2]:52159 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834AbYC0MMF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 08:12:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jeqxc-0006xi-Uf
	for git@vger.kernel.org; Thu, 27 Mar 2008 12:12:01 +0000
Received: from host45-62-dynamic.6-87-r.retail.telecomitalia.it ([87.6.62.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Mar 2008 12:12:00 +0000
Received: from sergio.callegari by host45-62-dynamic.6-87-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Mar 2008 12:12:00 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.6.62.45 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.12) Gecko/20080207 Ubuntu/7.10 (gutsy) Firefox/2.0.0.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78347>

Johannes Schindelin <Johannes.Schindelin <at> gmx.de> writes:

> 
> Hi,
> 
> On Thu, 27 Mar 2008, Miklos Vajna wrote:
> 
> > On Thu, Mar 27, 2008 at 11:29:28AM +0000, Sergio Callegari <sergio.callegari
<at> gmail.com> wrote:
> > > I guess the answer is "no" or "not yet", but is there a way to tell the zip
> > > backend of git-archive to follow symbolic links rather than to store them?
> > 
> > how would that handle a '. -> foo' symlink? following such a recursion
> > would lead to an infinite loop, i guess.
> 
> Don't forget '/ -> foo'.
> 
> Ciao,
> Dscho
> 
> 

My question was inspired by the fact that the unix version of the zip program
has a switch, precisely to decide whether to follow or to store links.
I believe that the reason why this switch exist is clear: for some mysterious
reason the world is populated by OSs that do not understand symlinks and while
someone finds out why it is sensible to have workarounds. Obviously zip archives
with stored links are completely useless on these OSs.
BTW, note that also tar has a similar switch.
 
I believe that cases like the foo -> . or the foo -> /  (or even foo -> ..) can
be solved by either:

- limiting the symlink dereferentiation only to symlinks pointing to plain files

or

- leaving it to the user not to ask for link following when he knows that he has
such types of links

Personally I prefer the second. In the end:
- If these types of link exist, it is clear that the git-managed-stuff is not
made for certain OSs, so the user should know that asking for link following
makes no sense
- The user should know that there are some commands that might be dangerous
(think rm -fr ~), just warn them in the manual.
- The maximum risk here is to have the command never stop and fill the disk.

Sergio

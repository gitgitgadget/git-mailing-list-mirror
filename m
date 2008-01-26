From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] pull --rebase: be cleverer with rebased upstream
 branches
Date: Sat, 26 Jan 2008 19:49:13 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801261945210.23907@racer.site>
References: <alpine.LSU.1.00.0801211542150.5731@racer.site> <7vir1nxcoh.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801261801360.23907@racer.site> <7vk5lwz8ia.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 20:50:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIr2Q-00020k-1A
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 20:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbYAZTt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 14:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752870AbYAZTt3
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 14:49:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:33235 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752650AbYAZTt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 14:49:29 -0500
Received: (qmail invoked by alias); 26 Jan 2008 19:49:27 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp030) with SMTP; 26 Jan 2008 20:49:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18F7Gl6kj4FvGPNNSNKQgXKnM1mpHfnsdAyo4v/AN
	S5tPanBrEw9uI7
X-X-Sender: gene099@racer.site
In-Reply-To: <7vk5lwz8ia.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71788>

Hi,

On Sat, 26 Jan 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > When the upstream branch is tracked, we can detect if that branch was 
> > rebased since it was last fetched.  Teach git to use that information 
> > to rebase from the old remote head onto the new remote head.
> 
> This is certainly nicer than the original (which is not in 1.5.3, so 
> even this late in the cycle it is "fixing up a new feature we will be 
> introducing in 1.5.4" category that I will apply).  But I think a bit of 
> caution and perhaps an illustration or two in the doucmentation would 
> help.

Well, I half expected it to be post-1.5.4.

> If you do "git fetch" from the origin since the last time you ran "pull 
> --rebase" for the remote, we will have the same issue.

Yes, that occurred to me, too.

> So it might make sense to make the logic to figure out B, given
> your local history that leads from 0 to x's (and nothing else),
> a bit cleverer than looking at the tracking branch.  We can look
> at reflog for example.  "git log -g --pretty=oneline" may have
> entries of this form:
> 
>     * branch: Created from B
>     * rebase finished <branch> onto B
> 
> and the latest (i.e. younguest) entry is where the part of your current 
> history to be rebased (i.e. base commit) starts.  This is much more 
> reliable than looking at the tracking branch, whose answer may or may 
> not match B at all.

I did not want to do that, because it is quite possible that the reflogs 
were disabled, or that the relevant reflogs were already expired.

However, I think that it might be a good approach to try reflogs first, 
and fallback to what I sent if there are no reflogs (or if it is detected 
that the reflog entry is not possibly the correct one, since what was 
rebased to is no longer an ancestor of the current branch).

Ciao,
Dscho

From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH/RFC] Allow "git remote --mirror" to mirror stashes
Date: Fri, 28 Mar 2008 11:45:43 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803281124240.19665@iabervon.org>
References: <1205499956.7589.4.camel@gentoo-jocke.transmode.se> <1205604534.7589.20.camel@gentoo-jocke.transmode.se> <7vbq4z4bl1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, joakim.tjernlund@transmode.se
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 16:47:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfGnC-0003NZ-3w
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 16:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754298AbYC1PqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 11:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754296AbYC1PqO
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 11:46:14 -0400
Received: from iabervon.org ([66.92.72.58]:32901 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754246AbYC1PqN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 11:46:13 -0400
Received: (qmail 23150 invoked by uid 1000); 28 Mar 2008 15:45:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Mar 2008 15:45:43 -0000
In-Reply-To: <7vbq4z4bl1.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78421>

On Thu, 27 Mar 2008, Junio C Hamano wrote:

> When you have "remote.$there.fetch = refs/*:refs/*" and the remote has a
> ref directly under refs/ (e.g. "stash"), "git fetch" still errored out
> even with fixes in -rc1.

In particular, it would fail to request "refs/stash", and then be 
surprised that it didn't get the object that points to. (This would be a 
helpful thing to mention in the commit message)

> This should hopefully fix it.

Maybe it shouldn't do any filtering here, and instead do it in 
cmd_fetch_pack? If the transport code gets to this point and anything gets 
filtered out by this function, the transport code or builtin-fetch will 
have to be terribly confused and fail with a mysterious error message, 
AFAICT.

>  * Rather than failing, it would be better to allow "git fetch" to succeed
>    by doing this, but on the other hand, stash is purely a local matter,
>    so it might make more sense to avoid exposing it from the uploader.

This is also true, although I'm not too sure that we won't want to do 
things like having "refs/default" in a public repository be the 
repository's suggestion for the default branch (to replace "HEAD", 
because, in a world where people use lots of branches, the "current 
branch" idea and the "default branch" idea aren't really the same idea, 
although there's no technical conflict since only one of these ideas is 
really important in any given repository). So we probably want a whitelist 
or blacklist for refs to serve when we avoid exposing things in the 
uploader, rather than using the level, in which case it's definitely 
important to have fetch-pack just ignore stuff.

	-Daniel
*This .sig left intentionally blank*

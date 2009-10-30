From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH 06/19] Factor ref updating out of fetch_with_import
Date: Fri, 30 Oct 2009 03:10:18 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910300221290.14365@iabervon.org>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com> <1256839287-19016-7-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 08:10:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ld3-0006qK-Vi
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 08:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756176AbZJ3HKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 03:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756146AbZJ3HKP
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 03:10:15 -0400
Received: from iabervon.org ([66.92.72.58]:47899 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754845AbZJ3HKO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 03:10:14 -0400
Received: (qmail 24351 invoked by uid 1000); 30 Oct 2009 07:10:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Oct 2009 07:10:18 -0000
In-Reply-To: <1256839287-19016-7-git-send-email-srabbelier@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131676>

On Thu, 29 Oct 2009, Sverre Rabbelier wrote:

> Also allow the new update_refs to actually update the refs set, this
> way the remote helper can set the value of previously unknown refs.
> 
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> ---
> 
> 	Daniel, if we can get wanted_peer_refs to keep HEAD as a
> 	wanted ref somehow this patch could be a lot simpler.

Actually, I think the problem is that builtin-clone will always default to 
setting up a refspec of "refs/heads/*:refs/remotes/origin/*", but that 
doesn't actually make any sense if the source repository isn't presented 
as having refs names like "refs/heads/*". The immediate problem that you 
don't get HEAD because it's a symref to something outside the pattern is 
somewhat secondary to the general problem that you don't get anything at 
all, because everything's outside the pattern.

I don't really think that presenting the real refs in refs/<vcs>/*, and 
having the list give symrefs to them from refs/heads/* and refs/tags/* 
really makes sense; I think it would be better to rework fetch_with_import 
and the list provided by a foreign vcs helper such that it can present 
refs with normal names (refs/heads/*, refs/tags/*, etc) if the foreign vcs 
has standards that correspond to branches and tags. Then "clone" would 
work normally.

Or, perhaps, there should be some other way of allowing git users to take 
advantage of foreign vcs standards; I don't have a good perspective on 
this, since I only presently use git and a foreign vcs without any useful
standards. But I think it should be such that the transport user sees as 
close as possible to a native git layout, and clone continues to rely on 
the layout being normal, instead of presenting a weird layout mapped into 
a normal layout or something like that and working around transport users 
not expecting this.

	-Daniel
*This .sig left intentionally blank*

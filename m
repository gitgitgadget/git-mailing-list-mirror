From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/3] Support config-based names
Date: Tue, 12 Jun 2007 00:13:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706112354330.5848@iabervon.org>
References: <Pine.LNX.4.64.0706112244210.5848@iabervon.org>
 <20070612033134.GS6073@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 06:14:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxxm5-0006Oi-RF
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 06:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbXFLENp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 00:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752462AbXFLENp
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 00:13:45 -0400
Received: from iabervon.org ([66.92.72.58]:1126 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858AbXFLENo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 00:13:44 -0400
Received: (qmail 2697 invoked by uid 1000); 12 Jun 2007 04:13:42 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jun 2007 04:13:42 -0000
In-Reply-To: <20070612033134.GS6073@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49917>

On Mon, 11 Jun 2007, Shawn O. Pearce wrote:

> Daniel Barkalow <barkalow@iabervon.org> wrote:
> > It can be useful to refer to commits in remotes based on their configured 
> > relationship to local branches. For example, "git log HEAD^[push]..HEAD" 
> > would, when pushing is set up, show what hasn't been pushed yet.
> 
> Interesting.
> 
> What about `git diff master^[push]@{3.days.ago}^{tree} master` ?
> 
> Can anyone even understand that?  Can Git even understand it?
> As I follow your code I don't think it would, as the ^[push]
> operator seems like it needs to be on the very end of the string,
> and it assumes everything to the left of the ^[ is the branch name.

Ah, but the code actually peels off parts and parses the part under, so 
HEAD^[push]^{tree} actually works. However, it doesn't treat HEAD^[push] 
as an alias for a branch, so it doesn't find the reflog.

> So I also couldn't phrase that as:
> 
>   git diff master@{3.days.ago}^[push]^{tree} master
> 
> More interesting is just what do you want going on here with the
> reflog query and the ^[push] query.  Should the reflog operator apply
> before the ^[push] translation, or after?  Or should it depend on
> the order of them in the statement?  I can see where you would want
> to look at your local tracking branch for the current branch 3 days
> ago, which might be "HEAD^[push]@{3.days.ago}".  But I'm not really
> sure what the meaning of "HEAD@{3.days.ago}^[push]" is.  Is that
> the branch that HEAD was on 3 days ago's push branch?  Huh?  ;-)

Whatever that means, I bet we don't track the necessary information. I 
think ^[push] only applies to ref names. But it should probably resolve as 
a ref name itself, so that HEAD^[push]@{3.days.ago} would work. Not sure 
how to write the code for that, though.

> In general it seems our "operators" are ^{foo} or @{foo}, so I wonder
> why not ^{push}.  push is not a valid object type, and probably
> never will be, so peeling the onion back to get to what ^{push}
> means (even though its not an object type) is probably OK.

^{push} and ^{merge} are certainly possible, if the namespace of object 
types and the namespace of functions aren't going to overlap. I wasn't 
sure if this would be true in general with future additions to both 
namespaces.

	-Daniel
*This .sig left intentionally blank*

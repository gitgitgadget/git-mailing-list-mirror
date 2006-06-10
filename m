From: Jakub Narebski <jnareb@gmail.com>
Subject: Lazy clone ideas
Date: Sat, 10 Jun 2006 10:58:41 +0200
Organization: At home
Message-ID: <e6e1jm$tes$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Jun 10 10:58:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FozIq-0007J3-Af
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 10:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWFJI6l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 04:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWFJI6l
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 04:58:41 -0400
Received: from main.gmane.org ([80.91.229.2]:31373 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751418AbWFJI6l (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jun 2006 04:58:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FozIj-0007HT-SK
	for git@vger.kernel.org; Sat, 10 Jun 2006 10:58:37 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Jun 2006 10:58:37 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Jun 2006 10:58:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21602>

I've started new thread for lazy clone ideas,
splitting from "Figured out how to get Mozilla into git"

Rogan Dawes wrote:
> Here's an idea. How about separating trees and commits from the actual 
> blobs (e.g. in separate packs)? My reasoning is that the commits and 
> trees should only be a small portion of the overall repository size, and 
> should not be that expensive to transfer. (Of course, this is only a 
> guess, and needs some numbers to back it up.)
> 
> So, a shallow clone would receive all of the tree objects, and all of 
> the commit objects, and could then request a pack containing the blobs 
> represented by the current HEAD.

That would be _lazy_ clone (with on-demand pack downloading from "master"
full history repository), rather than shallow clone.

I had an idea for having all the commit objects (without all the tree
objects) below the soft-grafts line (beyond the line we cut-off full
history and start being lazy).
 
> In this way, the user has a history that will show all of the commit 
> messages, and would be able to see _which_ files have changed over time 
> e.g. gitk would still work - except for the actual file level diff, "git 
> log" should also still work, etc
> 
> This would also enable other optimisations.
> 
> For example, documentation people would only need to get the objects 
> under the doc/ tree, and would not need to actually check out the 
> source. Git could detect any actual changes by checking whether it has 
> the previous blob in its local repository, and whether the file exists 
> locally. Creating a patch would obviously require that the person checks 
> out the previous version, but one could theoretically commit a new blob 
> to a repo without having the previous one (not saying that this would be 
> a good idea, of course)

Something akin to CVS's modules, or rather to how CVS modules can be abused?
Something called, I think, partial checkout?

This is a separate idea and I think worth implementing even for full
repository.

> This would probably require Eric Biederman's "direct access to blob" 
> patches, I guess, in order to be feasible.

And it would need place to store URI from where to doenload objects
on-demand: perhaps 'remote alternatives'?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: lost history with directory move?
Date: Mon, 28 Jan 2008 21:21:41 -0500
Message-ID: <20080129022141.GF24004@spearce.org>
References: <66024.57523.qm@web52812.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Perrin Meyer <perrinmeyer@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 03:22:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJg7N-0004AQ-8U
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 03:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756459AbYA2CVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 21:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754290AbYA2CVs
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 21:21:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47024 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991AbYA2CVr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 21:21:47 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JJg6Q-0000gR-51; Mon, 28 Jan 2008 21:21:34 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9F21920FBAE; Mon, 28 Jan 2008 21:21:41 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <66024.57523.qm@web52812.mail.re2.yahoo.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71916>

Perrin Meyer <perrinmeyer@yahoo.com> wrote:
> $ mv doc/ Documentation/
> $ git commit -a 
> where I see a lot of deletes
> 
> $ git add Documentation/
> $ git commit -a
> and I see that a all my doc files added, as expected. 
> 
> But when I got to look at the history of the Documentation/ directory
> 
> $ git log Documentation/
> 
> I only see one commit message 
> 
> $ git log --follow Documentation/

--follow only works on a single file.  So you cannot use
it for an entire directory.
 
> $ git log --follow README
> 
> I only see the single rename commit, not any history. 

Right, because the file came into existance in that commit and we
cannot find any deleted path in that same commit that is "highly
similar" to the file now called Documentation/README.  So we don't
call it a rename.
 
> I'm guessing, in hindsight, that I probably should have done
> 
> $ mv doc/ Documentation/
> $ git add Documentation/
> $ git commit -a 

Correct.  Rename detection works by looking for an add/delete pair
_in the same commit_ that have file content that is higly similar
between the two paths.  You broke that by doing the two changes in
two different commits.
 
> but is there anyway to get my history back given what I have done? 

I can't think of one other than to squash the two commits together
with a tool like `git rebase -i` and then force push it back to
your upstream repository.  Note that doing this would change the
commit SHA-1 names so anyone who has built on top of these changes
would also need to rebase their changes.

-- 
Shawn.

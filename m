From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Don't try and percent-escape existing percent escapes in git-svn URIs
Date: Sun, 9 Mar 2008 18:15:23 -0700
Message-ID: <20080310011523.GB17484@mayonaise>
References: <1205018447-18344-1-git-send-email-kevin@sb.org> <20080309091240.GA17484@mayonaise> <0FE6BDE6-961E-4671-B9EC-EFA25389DF54@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 02:16:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYWcq-0003IT-Fo
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 02:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbYCJBP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 21:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752633AbYCJBP1
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 21:15:27 -0400
Received: from hand.yhbt.net ([66.150.188.102]:59276 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752237AbYCJBP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 21:15:26 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id E891E7F4153;
	Sun,  9 Mar 2008 18:15:23 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 09 Mar 2008 18:15:23 -0700
Content-Disposition: inline
In-Reply-To: <0FE6BDE6-961E-4671-B9EC-EFA25389DF54@sb.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76688>

Kevin Ballard <kevin@sb.org> wrote:
> On Mar 9, 2008, at 5:12 AM, Eric Wong wrote:
> 
> >Kevin Ballard <kevin@sb.org> wrote:
> >>git-svn: project names are percent-escaped ever since f5530b.
> >>Unfortunately this breaks the scenario where the user hands git-svn
> >>an already-escaped URI. Fix the regexp to skip over what looks like
> >>existing percent escapes, and test this scenario.
> >
> >What happens when something that _looks_ like a percent escape is
> >actually a part of the URL and not really an escape?
> 
> Have you ever seen a URL like that? I haven't. However, what is fairly  
> common is for URLs to contain spaces, and such URLs are always stored  
> already-escaped.

No, but I wouldn't be surprised if they existed (as people are already
crazy enough to put spaces in URLs).

> The standard situation that triggers this issue is pulling a URL from  
> `svn info`. Such a URL is already escaped, which means you can't feed  
> it into `git svn clone` directly, you have to de-escape it first. This  
> is a problem. Here's an example:
> 
> http://macromates.com/svn/Bundles/trunk/Bundles/Ruby%20on%20Rails.tmbundle
> 
> I tried cloning that and it failed, because it turned that into
> 
> http://macromates.com/svn/Bundles/trunk/Bundles/Ruby%2520on%2520Rails.tmbundle
> 
> However, my friend who was still on v1.5.3.7 cloned that no problem,  
> since that was before the escaping code.

OK, I'll accept this.  If they really want to represent '%', they should
use "%25".  But this should only be done for http/https URLs as
svn(+ssh):// and file:// repositories aren't subject to the same rules
http/https are.

-- 
Eric Wong

From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: name-rev --stdin is slow
Date: Thu, 19 Jun 2008 18:03:59 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806191755510.19665@iabervon.org>
References: <485ACB34.2020901@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 00:06:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9SFe-0003Vn-16
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 00:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbYFSWEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 18:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbYFSWEB
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 18:04:01 -0400
Received: from iabervon.org ([66.92.72.58]:45451 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702AbYFSWEA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 18:04:00 -0400
Received: (qmail 14052 invoked by uid 1000); 19 Jun 2008 22:03:59 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Jun 2008 22:03:59 -0000
In-Reply-To: <485ACB34.2020901@gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85546>

On Thu, 19 Jun 2008, Lea Wiemann wrote:

> name-rev --stdin has some really high start-up time.  The example below is on
> my git.git branch.  Is this unavoidable to make name-rev fast for naming high
> numbers of revisions -- i.e. is it about amortization? Still, 0.7 seconds
> seems pretty excessive, and on linux-2.6 it even takes 6 seconds.
> 
> Anyone care to look into it?

Actually, I think it's the reverse: without --stdin, name-rev can do a 
first pass that lets it eliminate a lot of data from consideration; with 
--stdin, it doesn't know if an item it hasn't seen is going to need some 
data, and so it's conservative and doesn't eliminate anything, which means 
that each request is slower, at least until it's cached everything that 
you turn out to care about.

	-Daniel
*This .sig left intentionally blank*

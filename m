From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Kernel headers git tree
Date: Fri, 14 Jul 2006 02:27:35 +0100
Message-ID: <1152840456.31372.75.camel@shinybook.infradead.org>
References: <1152835150.31372.23.camel@shinybook.infradead.org>
	 <7v4pxlt3xg.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0607131800520.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 03:27:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1CSY-0003hu-NX
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 03:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161166AbWGNB1M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 21:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161167AbWGNB1L
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 21:27:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17841 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161166AbWGNB1K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 21:27:10 -0400
Received: from shinybook.infradead.org ([81.187.2.165])
	by pentafluge.infradead.org with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1G1CSQ-0002NC-6M; Fri, 14 Jul 2006 02:27:06 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607131800520.5623@g5.osdl.org>
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23866>

On Thu, 2006-07-13 at 18:05 -0700, Linus Torvalds wrote:
> 
> On Thu, 13 Jul 2006, Junio C Hamano wrote:
> > 
> > I am not sure what function incparent() is trying to do with
> > this:
> > 
> > 	git rev-list --max-count=1 --topo-order $1 -- .
> 
> Yeah, that looks strange.
> 
> The "--topo-order" in particular looks pointless, and just slows things 
> down.
> 
> The default ordering from git-rev-list (and all other revision listing 
> things, ie "git log" etc) _does_ guarantee that we never show a child 
> before _one_ of its parents has been shown (although "parent" in this case 
> may be the command line).

Does it? I thought at one point it sorted on some random criterion like
alphabetically by author, or some other cosmetic information which isn't
really part of the git structure -- like the timestamp or something?
We still don't enforce monotonicity, do we? The timestamps are still
just fluff?

> But that thing is doubly strange, because it uses "." as a path specifier. 
> If this is done in the top-most directory, that should mean "all changes", 
> which in turn means that the whole thing should be equivalent to
> 
> 	git rev-parse "$1^0"
> 
> since all commits should make _some_ change, and thus the first revision 
> in the list should always be the top commit - the one you passed in as an 
> argument.

In this case, I really do have commits in the intermediate tree which
don't actually change anything, and I want to filter them out -- I
couldn't see a simple way to do it all in one pass.

-- 
dwmw2

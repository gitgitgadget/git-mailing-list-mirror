From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/8] Clean up work-tree handling
Date: Sat, 28 Jul 2007 01:56:23 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707280152120.14781@racer.site>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
 <Pine.LNX.4.64.0707271956420.14781@racer.site> <7vk5sly3h9.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707280115370.14781@racer.site> <7vejitwe8m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, matled@gmx.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 02:56:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEabm-0000vj-Px
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 02:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbXG1A4g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 20:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbXG1A4g
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 20:56:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:59925 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965020AbXG1A4f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 20:56:35 -0400
Received: (qmail invoked by alias); 28 Jul 2007 00:56:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 28 Jul 2007 02:56:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX187jjAx1LU7xmJIxbq419qGw48EUWUY6yp+x8d45M
	tf08OGi/wSyPzO
X-X-Sender: gene099@racer.site
In-Reply-To: <7vejitwe8m.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53984>

Hi,

On Fri, 27 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> This changes semantics, I think.
> >> 
> >> It used to be relative "up" path when no funny work-tree stuff
> >> is used, but get_git_work_tree() now seems to return absolute,
> >> hence this option as well.  If it introduces regression to
> >> existing callers is up to what the caller does to the resulting
> >> path, though.  If it only is used to prefix other things
> >> (i.e. path="$(git rev-parse --show-cdup)$1"), the caller would
> >> be safe, but if the caller counted number of ../ in the return
> >> value to see how deep it is, or if the caller expected to see
> >> empty string in order to see if the process is at the toplevel,
> >> this change would become a regression.
> >
> > I am somewhat negative on keeping _that_ much backwards compatibility.  
> > Scripts which depend on show-cdup being a relative path _will_ be broken 
> > by work-tree.  Is it worth it to detect those errors late?
> 
> Well, one of the conditions to accept the worktree stuff was not
> to break anybody who never ever uses worktree.  So if we can
> keep the UP-ness of cdup, it would be much better.

One could record if the work tree was changed from the default one, and 
do the old thing in that case.

But I really have to wonder what other use people concocted for 
"--show-cdup"?  Potentially some directory-counting?  But --show-prefix 
would be much better at that.

I'll try to flange something into the code to detect unchanged working 
tree, but that is rather ugly, so I'd prefer not to.

Ciao,
Dscho

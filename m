From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/8] Clean up work-tree handling
Date: Sat, 28 Jul 2007 20:38:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707282033120.14781@racer.site>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
 <Pine.LNX.4.64.0707271956420.14781@racer.site> <7vk5sly3h9.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707280115370.14781@racer.site> <7vejitwe8m.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707280152120.14781@racer.site> <7vlkd1umwf.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707280956510.14781@racer.site> <7vd4ycsrrt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, matled@gmx.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 21:39:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEs83-0002PR-Ot
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 21:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbXG1Tir (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 15:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753574AbXG1Tiq
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 15:38:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:53093 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752679AbXG1Tip (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 15:38:45 -0400
Received: (qmail invoked by alias); 28 Jul 2007 19:38:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 28 Jul 2007 21:38:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+StIIv896SdNSa59IeNYZcEG9tzsT5ZaBjX6PdCo
	PU3BiVZcdW2HsJ
X-X-Sender: gene099@racer.site
In-Reply-To: <7vd4ycsrrt.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54053>

Hi,

On Sat, 28 Jul 2007, Junio C Hamano wrote:

> Outside of a work tree, I think the only two semi-sensible behaviours 
> exist.  Either tell the user that we cannot understand what "." should 
> mean in that context and error out (IOW, "Not inside a work tree"), or 
> assume that the user meant "from the top".  So in such a case, if we do 
> not want to error out to make things more "convenient", one possibility 
> would be:
> 
>  * give empty as prefix;
> 
>  * give absolute or cwd relative path to the work tree for cdup
>    (it would not be a sequence of ../ anyway in this case).

I am happy that you agree with the way I implemented it...

> I think this is in line with the traditional behaviour when GIT_DIR is 
> explicitly given.  We assume the cwd is the toplevel, and return empty 
> prefix and empty cdup.

Yes, I want that behaviour.

> Having said that, I am not convinced that "assume toplevel outside of a 
> work tree" is a win for the end users.  If the command errors out with a 
> message telling the user that relative path does not make sense from 
> outside a work tree, the user would understand.  If the command does not 
> error out but always works relative to the toplevel without explanation, 
> it might confuse the user more until the he realizes "assume toplevel 
> outside of a work tree" is the rule that is applying to his case.

There are two reasons against that...

- it is really convenient to be able to say "git add .vimrc" (think Martin 
  Krafft's desired setup).  Let's just put some uppercase warning at the 
  side of --work-tree in git-init.txt to tell the user about the 
  behaviour.

- the implementation of "you are not in the worktree" would not be 
  elegant: "git log" should succeed, "git log dir/file" should not.

Ciao,
Dscho

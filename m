From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] checkout-index needs a working tree
Date: Sun, 5 Aug 2007 02:33:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708050229200.14781@racer.site>
References: <Pine.LNX.4.64.0708042319470.14781@racer.site>
 <7vvebuj4nw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 03:34:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHV0L-0000o9-Ex
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 03:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765401AbXHEBdp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 21:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765395AbXHEBdp
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 21:33:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:38653 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765390AbXHEBdo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 21:33:44 -0400
Received: (qmail invoked by alias); 05 Aug 2007 01:33:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp003) with SMTP; 05 Aug 2007 03:33:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/PXr8BGAnPLgdcU7U/GZcfAffy6egozsZ2vYlRVp
	Ry5JH/7HOKqCPU
X-X-Sender: gene099@racer.site
In-Reply-To: <7vvebuj4nw.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54923>

Hi,

On Sat, 4 Aug 2007, Junio C Hamano wrote:

> I wonder if it would help us to catch similar breakages if we change 
> git.c::run_command() so that we do not pass prefix (or pass a bogus 
> pointer ((const char *)1)) for commands that do not ask for 
> NEED_WORK_TREE.

I tried that, but we have some places where we ask "if (prefix && 
*prefix)", for example in ls-tree.  It does not _require_ a work tree, but 
it certainly uses it when it is available -- which is fine.

Other users are more tricky, such as ls-files and update-index, which need 
a working tree only in some cases.

I'll probably write a patch on Monday (if nobody else is faster) to 
provide a function "require_work_tree()" in environment.c, which does the 
obvious (with caching).  Then comes the tedious part: identifying all 
those options that need a working tree...

Ciao,
Dscho

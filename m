From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-rm: don't remove newly added file without -f
Date: Mon, 26 Mar 2007 18:22:39 -0400
Message-ID: <20070326222239.GA3498@coredump.intra.peff.net>
References: <8aa486160703260759v438d445ev82161600d8e8bf02@mail.gmail.com> <20070326185539.GA1650@coredump.intra.peff.net> <7v1wjbwvzl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0703262314090.4045@wbgn013.biozentrum.uni-wuerzburg.de> <7vslbrvgf1.fsf@assigned-by-dhcp.cox.net> <8aa486160703260759v438d445ev82161600d8e8bf02@mail.gmail.com> <20070326185539.GA1650@coredump.intra.peff.net> <7v1wjbwvzl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 00:22:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVxaR-0004t2-5n
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 00:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933338AbXCZWWn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 18:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933347AbXCZWWn
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 18:22:43 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2509 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933338AbXCZWWm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 18:22:42 -0400
Received: (qmail 15054 invoked from network); 26 Mar 2007 22:23:11 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 26 Mar 2007 22:23:11 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2007 18:22:39 -0400
Content-Disposition: inline
In-Reply-To: <7vslbrvgf1.fsf@assigned-by-dhcp.cox.net> <7v1wjbwvzl.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43193>

On Mon, Mar 26, 2007 at 02:11:42PM -0700, Junio C Hamano wrote:

> Unstaging request would have looked like "git reset HEAD new",
> wouldn't it?

Yes, I think I am still in the habit of using "git rm" from its old
usage. I unstage so rarely that I don't think my fingers have adjusted.

> "git rm" later is reverting that intent.  Jeff's patch does
> exactly the same thing for new files what we already do for
> existing ones --- we ask for a confirmation when "git rm" is

Yes, regardless of how git-rm is "supposed" to be used, I think this
patch is worth it for two reasons:
  1. consistency; we should treat newly added files just like existing
     files (after all, content is content, right?)
  2. safety; I work under the assumption that I can do whatever I want
     with git-rm, and it will _never_ lose my data unless I use -f.
     Granted, without this patch my data would still be available
     somewhere in the object database, but it is hard to find and
     susceptible to pruning.

> Having said that, we do _not_ ask for confirmation when you do
> "git add existing-file" after doing "edit ; git add", which is
> theoretically inconsistent, but rm is special so that is
> probably Ok.

Hmm, yes, I agree that is inconsistent. However, it's such a common
workflow that forcing a '-f' would become meaningless. And you _can_
rescue the blob from the object database in a pinch, though finding it
can be tedious.

-Peff

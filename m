From: Jeff King <peff@peff.net>
Subject: Re: BUG:git-log --follow <path> should never trim output WRT
	equivalent git-log <path>
Date: Mon, 24 Mar 2008 21:45:04 -0400
Message-ID: <20080325014504.GA15864@coredump.intra.peff.net>
References: <loom.20080324T161602-184@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Santiago Gala <sgala@apache.org>
X-From: git-owner@vger.kernel.org Tue Mar 25 02:45:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdyEX-0007Cu-AP
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 02:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994AbYCYBpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 21:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754022AbYCYBpI
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 21:45:08 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3530 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753552AbYCYBpH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 21:45:07 -0400
Received: (qmail 32246 invoked by uid 111); 25 Mar 2008 01:45:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 24 Mar 2008 21:45:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Mar 2008 21:45:04 -0400
Content-Disposition: inline
In-Reply-To: <loom.20080324T161602-184@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78143>

On Mon, Mar 24, 2008 at 04:19:01PM +0000, Santiago Gala wrote:

> $ git log  -M -C -C --color --stat --follow -- gitk-git/po/de.po | wc -l
> 0
> sgala@marlow ~/newcode/git/git (master)$ git log  -M -C -C --color --stat --
> gitk-git/po/de.po | wc -l
> 31
> $ git --version
> git version 1.5.4.4
> 
> I find very strange that --follow makes git log to stop outputting the first
> entries.

I think the tricky thing here is that every one of those commits is a
merge, which doesn't actually "introduce" any content, and that probably
confuses the "--follow" code.

The thing is that getting the history of gitk-git specifically is a bit
tricky. All of the commits actually happen to, e.g., the file 'gitk' in
the main gitk repository, and then Junio merges it into git using a
special "subtree" merge as 'gitk-git/gitk'. So looking at a path in
'gitk-git' will always just turn up merge commits; the actual commits
took place on a different path.

But I haven't looked too closely at what's going on, so I may be way off
base. My two cents.

-Peff

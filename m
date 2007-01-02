From: Jeff King <peff@peff.net>
Subject: Re: confusion over the new branch and merge config
Date: Tue, 2 Jan 2007 09:49:40 -0500
Message-ID: <20070102144940.GA23932@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home> <7vd56cam66.fsf@assigned-by-dhcp.cox.net> <20061223051210.GA29814@segfault.peff.net> <7vbqlvuoi4.fsf@assigned-by-dhcp.cox.net> <7vbqlvrldk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 15:50:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1kxj-0000tE-IX
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 15:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270AbXABOto (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 09:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755281AbXABOtn
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 09:49:43 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4289 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755290AbXABOtn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 09:49:43 -0500
Received: (qmail 27607 invoked from network); 2 Jan 2007 09:49:49 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 2 Jan 2007 09:49:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jan 2007 09:49:40 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbqlvrldk.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35789>

On Sat, Dec 23, 2006 at 01:51:03AM -0800, Junio C Hamano wrote:

> If you (or other people) use branch.*.merge, with its value set
> to remote name _and_ local name, and actually verify that either
> form works without confusion, please report back and I'll apply.

This [using tracking branches in branch.*.merge] seems to be working for
me, but it is possible to get some confusing results with it. Try this
config:

[remote "origin"]
  url = /my/other/git/repo
  fetch = refs/heads/master:refs/heads/origin
  fetch = refs/heads/origin:refs/heads/junio
[branch "master"]
  remote = origin
  merge = refs/heads/origin

That is, we have a local tracking branch 'X' which has the same name as
a remote branch 'X'. When we fetch, both will be marked for merge in
FETCH_HEAD, and git-pull will attempt to do an octopus.

Is this too convoluted a config to worry about (no, I don't actually do
this in my repository -- I just constructed the most plausible reason I
could think of for having conflicting names). I actually think having a
branch.*.mergelocal would make just as much sense and would be more
robust (plus, it should be safe and sensible for "git-checkout -b foo
bar" to point branch.foo.mergelocal to refs/heads/bar).

-Peff

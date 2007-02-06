From: Jeff King <peff@peff.net>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Tue, 6 Feb 2007 03:12:05 -0500
Message-ID: <20070206081205.GA31948@coredump.intra.peff.net>
References: <87odognuhl.wl%cworth@cworth.org> <87y7nbdeaw.wl%cworth@cworth.org> <20070206072820.GC23866@coredump.intra.peff.net> <7vy7nbiv90.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 06 09:12:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HELR2-0007ce-TD
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 09:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbXBFIMJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 03:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbXBFIMJ
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 03:12:09 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4613 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751315AbXBFIMI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 03:12:08 -0500
Received: (qmail 24041 invoked from network); 6 Feb 2007 03:12:08 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 6 Feb 2007 03:12:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Feb 2007 03:12:05 -0500
Content-Disposition: inline
In-Reply-To: <7vy7nbiv90.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38822>

On Mon, Feb 05, 2007 at 11:46:19PM -0800, Junio C Hamano wrote:

> I think the abstraction is wrong -- why do you even need to
> iterate over .git/remotes (and .git/config remote.*) when the
> only thing this cares about is refs under refs/remotes/*
> hierarchy?

Well, you obviously can't look in the directory because of packed refs.
You can enumerate all refs with for_each_remote_ref and try to match
against "refs/remotes/*/$ref". But how do you handle '/' in a remote
name or a branch name?  If I have a remote "foo/bar" with branch "baz",
should I match it while looking up "bar/baz"? What about having the
remote "foo" and the branch "bar/baz"? Should a lookup for "baz" find
that?

If I'm just given the collapsed "remote/branch" text, I don't know which
parts are remote and which parts are branch, unless I make the
assumption that remotes have no '/' in them (which I did not think we
were making).

-Peff

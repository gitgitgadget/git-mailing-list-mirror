From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] cogito: Avoid slowness when timewarping large trees.
Date: Fri, 24 Mar 2006 06:22:46 -0500
Message-ID: <20060324112246.GA5220@coredump.intra.peff.net>
References: <20060324084423.GA30213@coredump.intra.peff.net> <7vd5gc16u2.fsf@assigned-by-dhcp.cox.net> <20060324105543.GA2543@coredump.intra.peff.net> <7v3bh814z4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 12:22:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMkNY-0000S2-Iz
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 12:22:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbWCXLWs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 06:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbWCXLWs
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 06:22:48 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1995 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S1751660AbWCXLWr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 06:22:47 -0500
Received: (qmail 28440 invoked from network); 24 Mar 2006 11:22:46 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 24 Mar 2006 11:22:46 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Mar 2006 06:22:46 -0500
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v3bh814z4.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17912>

On Fri, Mar 24, 2006 at 03:01:35AM -0800, Junio C Hamano wrote:

> >   git-read-tree --reset "$base"
> Exactly.  That's what I meant.  Thanks.

Hmm. That doesn't actually work, though. If I have a history like this:

$ cg-init -m "initial"
$ cg-tag initial
$ echo contents >file
$ cg-add file
$ cg-commit -m "added file"

and I try this:
$ echo changes >file
$ git-read-tree --reset master
$ git-read-tree -m -u master initial

I get this:
fatal: Entry 'file' not uptodate. Cannot merge.

If I do an update-index before the second read-tree, then I simply get:
fatal: Entry 'file' would be overwritten by merge. Cannot merge.

Is there something I'm missing, or is a 'git reset --hard' really what
we want here (in that case, the fact that git reset changes the HEAD
might be a problem)?

-Peff

From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH (WIP)] git-svn: cache SVN::Ra functions in a more Perl GC-friendly way
Date: Tue, 24 Apr 2007 23:40:53 -0700
Message-ID: <20070425064053.GA4310@muzzle>
References: <4623F613.5010108@midwinter.com> <20070417093743.GA9222@muzzle> <20070417094000.GA2778@muzzle> <462D544C.8010206@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 08:40:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgbBS-0000Wi-8b
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 08:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161356AbXDYGky (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 02:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161616AbXDYGky
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 02:40:54 -0400
Received: from hand.yhbt.net ([66.150.188.102]:32782 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161356AbXDYGkx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 02:40:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 641A52DC032;
	Tue, 24 Apr 2007 23:40:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <462D544C.8010206@midwinter.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45499>

Steven Grimm <koreth@midwinter.com> wrote:
> FYI, with this patch, it actually dies more often. The stack seems to be 
> corrupted so I can't give you a useful stack trace, but here's what gdb 
> says:

Yikes.

Thanks for the feedback.  Sorry, I've still been busy with another big
project and haven't been able to track down this nasty bug.

If somebody wants to take a stab at working around it: hack up a patch
that forks a new child (reusing the main connection) for every revision
it needs to fetch.  It should still be as fast as normal on *nix
machines because fork() is fast and it won't have to renegotiate the
connection in every child, but memory leaks and corruption won't have a
chance to accumulate.

-- 
Eric Wong

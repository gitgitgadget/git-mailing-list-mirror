From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Change set based shallow clone
Date: Thu, 07 Sep 2006 23:51:45 +0200
Organization: At home
Message-ID: <edq48l$1tm$3@sea.gmane.org>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com> <edpuut$dns$1@sea.gmane.org> <9e4733910609071341u7e430214j71ddcbefa26810ca@mail.gmail.com> <20060907213306.GA10781@sigio.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Sep 07 23:52:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLRnJ-0005zk-0f
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 23:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbWIGVwP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 17:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbWIGVwP
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 17:52:15 -0400
Received: from main.gmane.org ([80.91.229.2]:980 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751847AbWIGVwO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Sep 2006 17:52:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GLRmb-0005pM-7x
	for git@vger.kernel.org; Thu, 07 Sep 2006 23:51:37 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 23:51:37 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 23:51:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26660>

Jeff King wrote:

> Many operations that look at history are going to fail with a very short
> history (e.g., finding a merge base). Some operations can work with a
> short history, but the results are probably not useful (seeing the last
> 10 commits from git-log is probably not interesting). If you just want
> the latest snapshot, the remote git-archive work going on right now will
> probably take care of that.

That is the source of the idea of _sparse_ clone, which would include e.g.
top 10 commits from each of selected branches, all commits pointed by
branches and tags, and all merge bases, and roots, joined using grafts.

E.g. if the full history looks like this.

                                    -*.|.......... head  
                                   /   |
         -*--*--*-         -*--*--x--*-|-*--*--*-- head
        /         \       /            |
 *--*--*--*--*--*--*--*--*--*--*--*--*-|-*--*--*-- head
                       \...............|.......... tag
                                       |
                                       \- [cut-off]

then the sparse clone history would look like that:
(---) denotes parentage, (...) denotes grafts below


                                       |
                           ,......x....|.*--*--*-- head
                          :            |
 *....................*--*.............|.*--*--*-- head
                       \...............|.......... tag
                                       |
                                       \- [cut-off]

of course assuming that we have no earlier commits (i.e. sparse clone, not
sparse fetch).

Of course, that solves only some of troubles...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

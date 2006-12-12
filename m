X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-pull from git.git - no remote ref for pu or next?
Date: Tue, 12 Dec 2006 13:26:12 -0800
Message-ID: <20061212212612.GA22497@localdomain>
References: <863b7l83o9.fsf@blue.stonehenge.com> <86y7pd6oz7.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612120949230.3535@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Dec 2006 21:26:31 +0000 (UTC)
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612120949230.3535@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34145>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuF8t-0002zE-Ix for gcvg-git@gmane.org; Tue, 12 Dec
 2006 22:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932371AbWLLV0Y (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 16:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWLLV0Y
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 16:26:24 -0500
Received: from hand.yhbt.net ([66.150.188.102]:54137 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932371AbWLLV0X
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 16:26:23 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 546677DC02A; Tue, 12 Dec 2006 13:26:21 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 12 Dec 2006
 13:26:12 -0800
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> > And then it mysteriously fixed itself a few minutes later.
> > Is there some sort of publishing failure, or intermittent race condition?
> 
> But because the public sites just mirror using rsync, and aren't really 
> aware of git repositories etc at that stage, what can happen is that a 
> mirroring is on-going when Junio does a push, and then the changes to the 
> "refs/" directory might get rsync'ed before the "object/" directory does, 
> and you end up with the public sites having references to objects that 
> don't even _exist_ on those public sites any more.
> 
> And once the mirroring completes, the issue just goes away, which explains 
> why it just magically works five minutes later.

If kernel.org isn't using it already, I've found the --delay-updates
option of rsync works reasonably well and can cut down the
race-condition window.  It does use more memory and disk space, however.
atomic-rsync (a perl front-end distributed with the rsync source) takes
even more disk space but works across an entire subdirectory all at once
(with 2 renames)

-- 

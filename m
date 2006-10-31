X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: [PATCH] Continue traversal when rev-list --unpacked finds a packed commit.
Date: Mon, 30 Oct 2006 21:17:39 -0500
Message-ID: <20061031021739.GH3617@delft.aura.cs.cmu.edu>
References: <20061029093754.GD3847@spearce.org> <Pine.LNX.4.64.0610301332440.11384@xanadu.home> <20061030202611.GA5775@spearce.org> <20061030205200.GA20236@delft.aura.cs.cmu.edu> <7v3b95wjmg.fsf@assigned-by-dhcp.cox.net> <20061030225500.GG3617@delft.aura.cs.cmu.edu> <7vhcxltmit.fsf@assigned-by-dhcp.cox.net> <20061031013749.GA19885@delft.aura.cs.cmu.edu> <7vk62hs1ct.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 02:18:14 +0000 (UTC)
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <7vk62hs1ct.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30561>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GejCK-0005E9-CQ for gcvg-git@gmane.org; Tue, 31 Oct
 2006 03:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965525AbWJaCRl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 21:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965530AbWJaCRl
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 21:17:41 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:21967 "EHLO
 delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP id S965525AbWJaCRl
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 21:17:41 -0500
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 4.63)
 (envelope-from <jaharkes@cs.cmu.edu>) id 1GejC7-0006Jg-Qc; Mon, 30 Oct 2006
 21:17:39 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Mon, Oct 30, 2006 at 05:47:14PM -0800, Junio C Hamano wrote:
> Jan Harkes <jaharkes@cs.cmu.edu> writes:
> 
> > When getting the list of all unpacked objects by walking the commit history,
> > we would stop traversal whenever we hit a packed commit. However the fact
> > that we found a packed commit does not guarantee that all previous commits
> > are also packed. As a result the commit walkers did not show all reachable
> > unpacked objects.
> >
> > Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
> 
> Thanks.
> 
> With this, I think revs->unpacked should not mean "limited", so
> I suspect this is also needed, no?

I'm not familiar enough with the code to know for sure, but my gut
feeling is that that would be needed. Let me check...

When that flag is set, the code calls limit_list, which no longer stops
traversal when we hit a packed commit. So we end up with a list of all
commits in memory. If the flag is not set, the list is kept minimal and
parents are only traversed as they are encountered.

So it looks like not setting the flag reduces memory usage we traverse
all parents in both cases. Yes, you are correct.

Jan

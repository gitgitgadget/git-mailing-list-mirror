From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 22:47:25 +0200
Organization: linutronix
Message-ID: <1115930845.11872.79.camel@tglx>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com>
	 <1115854733.22180.202.camel@tglx> <428297DB.8030905@zytor.com>
	 <1115858022.22180.256.camel@tglx> <7vekcdmd16.fsf@assigned-by-dhcp.cox.net>
	 <1115884637.22180.277.camel@tglx> <7vvf5ogxdu.fsf@assigned-by-dhcp.cox.net>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 22:39:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWKSS-0000uc-8x
	for gcvg-git@gmane.org; Thu, 12 May 2005 22:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbVELUqm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 16:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVELUqm
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 16:46:42 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:49036
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262109AbVELUqe
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 16:46:34 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 4F0BB65C003;
	Thu, 12 May 2005 22:46:30 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id C1904282B8;
	Thu, 12 May 2005 22:46:29 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf5ogxdu.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-05-12 at 10:35 -0700, Junio C Hamano wrote:
> Thanks for a very clear explanation.  The situation is
> intriguing in that both R and M after converging end up with
> exactly the same HEAD with the same set of objects but still
> would want to see history leading to the HEAD differently.

Yes, thats what I wanted to achieve first hand with the repository id. I
think my first attempt is far from perfect and I agree with hpa on
having a .git/repoid file. 

> I wonder what happens to a third person S, who pulls from both R
> and M.  What does S see?  
> Does the commit order observed by S depend on which one S pulls
> from first?  That is, if S pulls from R then at that point Mn-1
> and Mn comes after Rn-1 in S's history?  And after that what
> hapens if S pulls from M (which is obviously a no-op except that
> it would update .git/refs/heads/M)?  Does the history for S
> change?

That's an interesting question. Of course, if you change the head you
see the tree from a different POV, but you can detect this when S pulls
from M after a pull from R. So the tool can ask the user, if he really
wants to change the commit order or not. You might even argue that they
could refuse to do the head change

> The answer to the above could be "the merge order history is per
> tree and not something to be exported or given away to other
> trees", in which case it may make sense from S's point of view
> that Mn and Rn-1 are compares solely based on their commit
> timestamps.  You will get consistent history and switching which
> tree is being tracked would not change the history.  Is the goal
> here to give the merge order history from R and M to S?

The goal from my side is to preserve the merge order history of R, M and
S in the individual way of commit order per repository, which includes
the merge order R->S, M->S or the other way round. See above

> If that is not needed, then you can record in an auxiliary file
> that is local to each tree the timestamp of when merge happened
> in that tree along with set of foreign commit objects, and teach
> rev-tree or rev-list to read from that auxiliary file and use
> that timestamp for foreign commit objects instead of commit time
> recorded in them when sorting by time is needed.

As I said before timestamps can be a horrid source of information. Also
if you keep a list of commits merges and head forwards in timed order it
is simple to read the repository history, but in case of corruption you
have to reconstruct it manually. There is no way to do so with the
information available.

Repository id's can be lost, but are simple to replace as they are
recorded in the commit blob.

tglx





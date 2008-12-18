From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Odd merge behaviour involving reverts
Date: Thu, 18 Dec 2008 15:58:37 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812181534310.14014@localhost.localdomain>
References: <1229642734.5770.25.camel@rotwang.fnordora.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alan <alan@clueserver.org>
X-From: git-owner@vger.kernel.org Fri Dec 19 01:01:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDSnq-00026v-5C
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 01:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbYLRX7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 18:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbYLRX7x
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 18:59:53 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44063 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751480AbYLRX7x (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Dec 2008 18:59:53 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBINwc2s001281
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Dec 2008 15:58:39 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBINwbKH006312;
	Thu, 18 Dec 2008 15:58:38 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1229642734.5770.25.camel@rotwang.fnordora.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.424 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103511>



On Thu, 18 Dec 2008, Alan wrote:
> 
> What am i doing wrong here?

Reverting a merge is your problem.

You can do it, but you seem to have done it without understanding what it 
causes.

A revert of a merge becomes a regular commit that just undoes everything 
that the merge did in your branch. When you then do the next merge, you'll 
do that merge with that in mind, so now git will essentially consider the 
previous merge to be the base line, but your revert undid everything that 
that one brought in, so the new merge will really only contain the new 
stuff from the branch you are merging. 

So if a merge causes problems, you generally should either undo it 
_entirely_ (ie do a 'git reset --hard ORIG_HEAD'), not revert it. 

Of course, if you had already made the merged state public, or done 
development on top of it, you can't really do that. In which case a revert 
works, but if you want it back, you should revert the revert, not merge 
the branch again - because what you merged last time you threw away, and 
won't be applied again.

		Linus

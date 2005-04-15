From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 16:53:24 +0200
Message-ID: <20050415145324.GA4677@elte.hu>
References: <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org> <7v64ypsqev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org> <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz> <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org> <1113556448.12012.269.camel@baythorne.infradead.org> <20050415093649.GA28077@elte.hu> <1113559533.12012.296.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 16:51:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMS9I-0006bv-Qw
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 16:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVDOOxw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 10:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVDOOxv
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 10:53:51 -0400
Received: from mx2.elte.hu ([157.181.151.9]:31431 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261827AbVDOOxk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 10:53:40 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id A7284319722;
	Fri, 15 Apr 2005 16:52:44 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id DD1CE1FC2; Fri, 15 Apr 2005 16:53:34 +0200 (CEST)
To: David Woodhouse <dwmw2@infradead.org>
Content-Disposition: inline
In-Reply-To: <1113559533.12012.296.camel@baythorne.infradead.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* David Woodhouse <dwmw2@infradead.org> wrote:

> On Fri, 2005-04-15 at 11:36 +0200, Ingo Molnar wrote:
> > do such cases occur frequently? In the kernel at least it's not too 
> > typical. 
> 
> Isn't it? I thought it was a fairly accurate representation of the 
> process "I make a whole bunch of changes to files I maintain, pulling 
> from Linus while occasionally asking him to pull from my tree. 
> Sometimes my files are changed by someone else in Linus' tree, and 
> sometimes I change files that I don't actually own.".

but the specific scenario you described would require _Linus'_ tree to 
be in limbo for a long time, and have uncommitted half-done edits. I.e.:

   (A1B2)--(A2B2)--(A2'B3)
    /  \   /            \
   /    \ /              \
 (A1B1)  X               (...)
   \    / \              /
    \  /   \            /
   (A2B1)--(A2B2)--(A3B2')

in the above scenario Linus' tree needs to 'cross' with a maintainer's 
tree.  (maintainer's tree wont cross with another maintainer's tree, as 
maintainer-to-maintainer merges rare.)

but for the scenario to occur, i think there needs to be a prolongued 
"limbo" period in Linus' tree for a 'crossing' to happen. But Linus' 
merges are typically almost atomic: they are done then they are pushed 
out. It's definitely not in the 'days, sometimes weeks' timescale as 
maintainer trees are.

so for the scenario to occur, a maintainer, from whom Linus has just 
pulled an update and Linus is merging the tree manually without 
comitting, has to pull a file from the earlier Linus tree, and then 
Linus has to modify that same file again. This does not seem to be a 
common scenario.

so i think to avoid the scenario, maintainers should not pull from each 
other - they should only pull/push to/from Linus' tree. Maybe this is an 
unacceptable limitation?

	Ingo

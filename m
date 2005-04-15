From: Ingo Molnar <mingo@elte.hu>
Subject: Re: another perspective on renames.
Date: Fri, 15 Apr 2005 10:27:59 +0200
Message-ID: <20050415082759.GA26112@elte.hu>
References: <Pine.LNX.4.61.0504141759440.7261@cag.csail.mit.edu> <20050414221626.10c6c0e7.pj@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "C. Scott Ananian" <cscott@cscott.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 10:28:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMMAX-0004Ug-Gw
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 10:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVDOIaT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 04:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbVDOIaT
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 04:30:19 -0400
Received: from mx1.elte.hu ([157.181.1.137]:50068 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261779AbVDOI23 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 04:28:29 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id BDC5231CB5E;
	Fri, 15 Apr 2005 10:27:27 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 6CB0E1FC2; Fri, 15 Apr 2005 10:28:03 +0200 (CEST)
To: Paul Jackson <pj@engr.sgi.com>
Content-Disposition: inline
In-Reply-To: <20050414221626.10c6c0e7.pj@engr.sgi.com>
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


* Paul Jackson <pj@engr.sgi.com> wrote:

> Scott wrote:
> > Anyway, maybe it's worth thinking a little about an SCM in which this is a 
> > feature, instead of (or in addition to) automatically assuming this is a 
> > bug we need to add infrastructure to work around.
> 
> Agreed.
> 
> To me, the main purpose in tracking renames is to obtain a deeper
> history of the line-by-line changes in a file.
> 
>   ==> But that doesn't seem relevant here.
> 
> Last I looked, git has no such history.  A given file contents is the 
> indivisable atom of the git world, with no fine structure.
> 
> This is quite unlike classic SCM's, built on file formats that track 
> source lines, not files, as the atomic unit.

i believe the fundamental thing to think about is not file or line or 
namespace, but 'tracking developer intent'. While keeping in mind that 
GIT is not an SCM, all SCMs boil down to this single thing: being able 
to track what the developer did and why he did it - to be a useful tool 
later on. (SCMs are for humans with bad limitations, who have this 
fundamental design bug and keep forgetting things.)

the basic question is, how much to track. The most extreme form of 
tracking (just for the sake of visualizing it) would be to have an 
eye-position recognizing software attached to a webcam looking at the 
developer, and then exactly mapping what he did, how long did he look at 
one particular line of code and exactly what did he type when doing 
that. [ Perhaps also a thought-reader module in addition, once one is 
available. (combined with another module that removes all the swearing)]

but i think Linus is on the right track to suggest that "the file names 
dont matter all that much, it's all about the content". Global diffs 
might track most types of plain renames, and if it gets it wrong - do we 
care? Misdetection of renames can happen, but realistically only with 
small files and trivial code, which wont have alot of history.

The only serious type of misdetection would be if two large modules in 
two different places in the namespace happen to have exactly the same 
content but have a different history (because e.g. they were merged in 
via two separate trees, one came from one tree, the other from the other 
tree), and the developer renamed both of them in the same commit: in 
such a case the global diff would have no way to figure out what the 
proper thread of history is. But is this a realistic scenario?  If the 
two files are nontrivial and have the same content, why werent they 
merged in the namespace in the first place?

the moment we allow 'namespace' into the picture, things get complex and 
ugly. Directory recursion is already a complexity that would have been 
nice to avoid.

	Ingo

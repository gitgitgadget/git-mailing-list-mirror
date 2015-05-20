From: Philippe De Muyter <phdm@macq.eu>
Subject: Re: identical hashes on two branches, but holes in git log
Date: Wed, 20 May 2015 15:13:59 +0200
Message-ID: <20150520131359.GA7043@frolo.macqel>
References: <20150519132958.GA21130@frolo.macqel> <20150519233925.GA22748@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 20 15:14:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv3p3-00006H-PV
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 15:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbbETNOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 09:14:05 -0400
Received: from smtp2.macqel.be ([109.135.2.61]:50513 "EHLO smtp2.macqel.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752494AbbETNOE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 09:14:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp2.macqel.be (Postfix) with ESMTP id 07883130CDD;
	Wed, 20 May 2015 15:14:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at macqel.be
Received: from smtp2.macqel.be ([127.0.0.1])
	by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AStlf8zdpa4q; Wed, 20 May 2015 15:13:59 +0200 (CEST)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
	by smtp2.macqel.be (Postfix) with ESMTP id 63F80130CBF;
	Wed, 20 May 2015 15:13:59 +0200 (CEST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
	id 42C76DF06BF; Wed, 20 May 2015 15:13:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150519233925.GA22748@peff.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269460>

Hi Jeff,

On Tue, May 19, 2015 at 07:39:25PM -0400, Jeff King wrote:
> On Tue, May 19, 2015 at 03:29:58PM +0200, Philippe De Muyter wrote:
> 
> > Trying to understand, I have eventually done "git log" on my branch and
> > on v3.15 with the following commands :
> > 
> > git log v3.15 --full-history --decorate=short | grep '^commit' > /tmp/3.15.commits
> > git log --full-history --decorate=short | grep '^commit' > /tmp/mybranch.commits
> > 
> > I compare then the two histories with
> > 
> > diff -u /tmp/3.15.commits /tmp/mybranch.commits
> > 
> > and I get (excerpt) :
> > 
> > --- /tmp/3.15.commits      2015-05-19 13:19:59.665205514 +0200
> > +++ /tmp/mybranch.commits     2015-05-19 13:19:52.452081328 +0200
> > @@ -1,3780 +1,84 @@
> > -commit 1860e379875dfe7271c649058aeddffe5afd9d0d (tag: v3.15)
> > -commit ...
> > ...
> > -commit fad01e866afdbe01a1f3ec06a39c3a8b9e197014 (tag: v3.15-rc8)
> > ...
> > ...
> > -commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5 (tag: v3.15-rc1)
> > ...
> > -commit 57673c2b0baa900dddae3b9eb3d7748ebf550eb3
> > +commit a1fb433346cb5733945b5fc243f7334744bae4fd (HEAD, macq_boards-3.14.0)
> > +commit ...
> > ...
> > +commit 2be7b20bbb337e0031e0f0d39c9a4845b6bbf3b8
> 
> It looks like v3.15 is ahead of your branch. And I _think_ your question
> is: since they both contain v3.14, shouldn't they also contain all of
> the ancestors of v3.14?

Thanks for understanding and clarifying my question.

> 
> The answer is yes. But from your output here:
> 
> >  commit 455c6fdbd219161bd09b1165f11699d6d73de11c (tag: v3.14)	==== identical commit
> > -commit c32fc9c803f8ed90a7548810de48ca33a3020168		==== commit missing in my branch
> >  commit fedc1ed0f11be666de066b0c78443254736a942e		==== more identical commits
> 
> I think what you are saying is: c32fc9c803 comes after v3.14, so it
> should be an ancestor, right?
> 
> And the answer is no. Git's traversal order does not necessarily reflect
> the true topology if you have multiple lines of development. And in this
> case, they do not have a direct ancestry relationship (i.e., they are on
> separate branches, and neither is an ancestor of the other).

Thanks for the explanation.  Would that also be true (that unrelated commits
could come in the output) with a simple 'git log' ?

My initial problem (still unresolved/unanswered) is that some commits
that appeared between v3.14-rc1 and v3.14-rc2 (specifically
817c27a128e18aed840adc295f988e1656fed7d1) are present in v3.15, but not
in my branch.

I have just checked online the v3.14 version on 

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/arch/arm/boot/dts/imx6qdl.dtsi 

and I see also the same "problem": the commit removing 738 lines is in the log
817c27a128e18aed840adc295f988e1656fed7d1
"ARM: dts: imx6qdl: make pinctrl nodes board specific",
but the v3.14 version of the file still contains the 738 removed line,
and I see no commit restoring those lines.

I do not understand why those 738 lines are still present in v3.14 although
they were removed between v3.14-rc1 and v3.14-rc2 :(

Philippe

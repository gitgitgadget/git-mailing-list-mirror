From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bug: segfault during git-prune
Date: Thu, 28 Jun 2007 15:31:27 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706281525460.8675@woody.linux-foundation.org>
References: <200706281134.58453.andyparkins@gmail.com>
 <alpine.LFD.0.98.0706280844460.8675@woody.linux-foundation.org>
 <200706282321.44244.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 00:31:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I42WX-0003ei-Po
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 00:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764026AbXF1Wbg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 18:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763628AbXF1Wbg
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 18:31:36 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51795 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763626AbXF1Wbf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jun 2007 18:31:35 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5SMVXMT002077
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Jun 2007 15:31:34 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5SMVReb003015;
	Thu, 28 Jun 2007 15:31:28 -0700
In-Reply-To: <200706282321.44244.andyparkins@gmail.com>
X-Spam-Status: No, hits=-2.624 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51136>



On Thu, 28 Jun 2007, Andy Parkins wrote:
> 
> I had hoped that git-prune wouldn't be a risk because I have:
> 
>  * -- * -- * -- * -- * (ffmpeg-svn)
> 
>       * -- * -- * -- * (libswscale-svn)

Ok. If all subproject branches are also visible in the superproject as 
refs, then "git prune" should work fine, and you can apply my patch and it 
should just work very naturally: the reachability analysis will find the 
subprojects not through the superproject link, but simply through the 
direct refs to the subproject.

> > (General rule: never *ever* prune a shared object repository!)
> 
> Even when I'm sure that every object of interest is behind a head ref?

So yes, in that case, you're ok.

This is not unlike just having two different repositories sharing the same 
object directory: as long as the two different repositories both have the 
appropriate refs, pruning is fine. In other words, you can see them as 
just independent branches in the same repo.

And in fact, subprojects are obviously very much *designed* to work that 
way: a subproject is basically a "different repository". So the basic rule 
is that if it would work with totally independent repos, it works with 
subprojects.

[ That's all aside from the kind of bug that you found, where some code 
  that parses the tree structures hadn't been updated for subprojects, of 
  course ]

Anyway, if that patch works for you, I'd suggest you just pass it on to 
Junio (and feel free to add my "Signed-off-by:" on it - but conditional on 
you having actually tested it).

		Linus

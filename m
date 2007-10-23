From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: unmerging feature branches
Date: Tue, 23 Oct 2007 12:46:51 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710231239300.30120@woody.linux-foundation.org>
References: <20071023152445.GA10070@piper.oerlikon.madduck.net>
 <alpine.LFD.0.999.0710230922240.30120@woody.linux-foundation.org>
 <20071023171611.GA18783@piper.oerlikon.madduck.net>
 <alpine.LFD.0.999.0710231026011.30120@woody.linux-foundation.org>
 <20071023180825.GA20343@piper.oerlikon.madduck.net>
 <alpine.LFD.0.999.0710231115060.30120@woody.linux-foundation.org>
 <20071023191738.GA24575@piper.oerlikon.madduck.net>
 <alpine.LFD.0.999.0710231221530.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Oct 23 21:47:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkPia-0004TC-E3
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 21:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbXJWTrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 15:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752279AbXJWTq7
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 15:46:59 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34825 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752220AbXJWTq7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Oct 2007 15:46:59 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9NJkpMC002972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 23 Oct 2007 12:46:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9NJkpqg003434;
	Tue, 23 Oct 2007 12:46:51 -0700
In-Reply-To: <alpine.LFD.0.999.0710231221530.30120@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.72 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62153>



On Tue, 23 Oct 2007, Linus Torvalds wrote:
>
> > by shape you mean the actual graph, and when 'branch' is merged into
> > master at m2, Git goes back in time to conclude that master...L must
> > already be present in master due to the intersection of the two
> > lines at m, and thus finds commit F as the "oldest direct
> > descendant" of m2. L is an older descendant of m2, but it's not
> > direct in the sense that there are multiple paths from m2 to L. Thus
> > Git will only merge F..T at m2.
> 
> Exactly.

Side note: strictly speaking, git will not merge "F..T" in the sense that 
it never actually even _looks_ at any of the commits in that range per se.

So what it really does is to look at state of the common point ('L') and 
then the states of the end-points, and merge things based purely based on 
that state, and then join the histories up.

Yes, that *effectively* means merging all the changes from 'F'..'T', but I 
want again to point out that the actual changes done by any of the 
individual commits in that range are never even looked at. They really are 
totally irrelevant on their own.

So if 'F' did a lot of changes and 'T' undid most of them, the merge 
algorithm will not ever even *see* those changes. They were irrelevant. 
It's not that git sees the changes and then sees that 'T' undid them: git 
will literally never actually even look at them in the first place!

That's what I mean by only taking "state" into account. It didn't matter 
what any individual commit did. Git won't even have looked at the commit, 
other than to find its parent. When git merges, it literally looks at just 
the end results, and the last common state(s).

So history matters a great deal to merging, but it only matters in the 
global "shape" sense, never in the "per-commit" sense.

			Linus

From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Why doesn't git-apply remove empty file
Date: Fri, 15 Aug 2008 08:53:07 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808150843320.3324@nehalem.linux-foundation.org>
References: <38b2ab8a0808120917h10f15c81v4d1f04c0174dc994@mail.gmail.com> <7vod3xpxq2.fsf@gitster.siamese.dyndns.org> <38b2ab8a0808130048t506dbb7ah1d6fcd6bd4f3c90c@mail.gmail.com> <48A357BA.8060003@lsrfire.ath.cx> <alpine.LFD.1.10.0808131602200.3462@nehalem.linux-foundation.org>
 <38b2ab8a0808141242k4bd6867dt8ef54f160713061f@mail.gmail.com> <alpine.LFD.1.10.0808141246190.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141258180.3324@nehalem.linux-foundation.org> <20080814202159.GD7138@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Francis Moreau <francis.moro@gmail.com>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Aug 15 17:54:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU1dZ-0005sy-EA
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 17:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753AbYHOPxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 11:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759954AbYHOPxq
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 11:53:46 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47599 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753630AbYHOPxp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Aug 2008 11:53:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7FFrAvl030310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 15 Aug 2008 08:53:11 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7FFr7IX007210;
	Fri, 15 Aug 2008 08:53:08 -0700
In-Reply-To: <20080814202159.GD7138@leksak.fem-net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.413 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92490>



On Thu, 14 Aug 2008, Stephan Beyer wrote:
> 
> What I missed when I first used git-apply (git-am) with some not-so-
> well-done patches was something like a "simulated merge" (of course,
> only when you ask for it), i.e. something like a user-friendly
> --reject behavior:

It's really hard to do. Largely impossible, I think. The reason is that 
when a patch fails, you - by definition - don't really know where it is 
supposed to apply and what the original code is. Because if you did, the 
patch wouldn't fail!

Git *can* do it (git am -3, as people have said), when you have a git 
patch, and the patch indicates the original blob. Then git can just see 
what the original state was, reconstruct the patched file, and do a normal 
three-way merge. But it's not doable in general.

Now, we could do other things, like try to _search_ for an original blob 
that it applies cleanly to (or even have a "guessing mode" that does a 
really rough patch-application with the GNU patch defaults and then does a 
three-way merge of a fudged version with no fuzz as the base), so I'm not 
saying that it would be fundamentally impossible to try to go further than 
what we do now, but it's definitely not trivial to do.

> Instead of generating reject files it puts conflict markers into the file.
> (If no context matches at all, then perhaps just insert them at the lines
> that the hunk header says.)
> And then declaring the files as "unmerged", so that you can see it in
> git status.

I do agree that it would be very cool. I'm so used to editing patches to 
match the target files by hand that I don't personally mind. I absolutely 
detest reject files personally because of the way they mean that you have 
a half-way done thing, so I will literally always edit the original patch 
in place instead.

But I agree that what you describe would be absolutely lovely.

			Linus

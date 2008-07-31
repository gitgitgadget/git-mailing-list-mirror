From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Monotone workflow compared to Git workflow ( was RE: Git vs
 Monotone)
Date: Thu, 31 Jul 2008 13:09:09 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807311253140.3277@nehalem.linux-foundation.org>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com> <alpine.LFD.1.10.0807311211260.3277@nehalem.linux-foundation.org> <63BEA5E623E09F4D92233FB12A9F79430238A5EE@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sverre@rabbelier.nl, Git Mailinglist <git@vger.kernel.org>
To: "Craig L. Ching" <cching@mqsoftware.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 22:13:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOeWr-0008KV-S4
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 22:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbYGaUMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 16:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbYGaUMk
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 16:12:40 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59012 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750969AbYGaUMk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 16:12:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6VKC9hX020256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2008 13:12:10 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6VKC8mH009622;
	Thu, 31 Jul 2008 13:12:08 -0700
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F79430238A5EE@emailmn.mqsoftware.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.406 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90977>



On Thu, 31 Jul 2008, Craig L. Ching wrote:
> 
> We find ourselves constantly having to shift gears and work on other
> things in the middle of whatever it is we're currently working on.  For
> instance, in the scenario above, A might be branch that contains a
> feature going into our next release.  B might be a bugfix and takes
> priority over A, so you have to leave A as-is and start work on B.  When
> I come back to work on A, I have to rebuild A to continue working, and
> that's just too expensive for us.  So we use the monotone-like
> new-workdir which allows us to save those build artifacts.
> 
> So, that said, I ask again, am I missing something?  Is there a better
> way to do this?  How do the kernel developers do this, surely they're
> switching branches back and forth having to build in-between?

Sure, if you want to keep the build tree around, you would probably not 
use branches. 

But yes, then you'd likely do "git clone -s" with some single "common 
point" or use "git worktree". And even if you don't use "-s", you should 
_still_ effectively share at least all the old history (which tends to be 
the bulk) thanks to even a default "git clone" will just hardlink the 
pack-files.

So literally, if you do

	git clone <cntral-repo-over-network> <local>

and then do

	git clone <local> <otherlocal>
	git clone <local> <thirdlocal>

then all of those will all share the initial pack-file on-disk. Try it.

(You may then want to edit the "origin" branch info in the .git/config to 
point to the network one etc, of course).

Oh, and to make sure I'm not lying I actually did test this, but I also 
noticed that "git clone" no longer marks the initial pack-file with 
"keep", so it looks like "git gc" will then break the link. That's sad. I 
wonder when that changed, or maybe I'm just confused and it never did.

Junio?

		Linus

From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: merge renamed files/directories?
Date: Tue, 6 May 2008 09:10:06 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805060851470.32269@woody.linux-foundation.org>
References: <4819CF50.2020509@tikalk.com> <481D52CC.1030503@tikalk.com> <32541b130805050940x1297e907ofc67ee65494897eb@mail.gmail.com> <200805052349.35867.robin.rosenberg.lists@dewire.com> <alpine.LFD.1.10.0805051512060.32269@woody.linux-foundation.org>
 <ADDE27A8-6329-4C09-BC07-8EB023BA6D48@midwinter.com> <alpine.LFD.1.10.0805051724510.32269@woody.linux-foundation.org> <20080506154709.GF6918@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Grimm <koreth@midwinter.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Ittay Dror <ittayd@tikalk.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue May 06 18:12:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtPla-0004SA-7w
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 18:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761773AbYEFQKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 12:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760539AbYEFQKz
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 12:10:55 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33349 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762101AbYEFQKy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2008 12:10:54 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m46GA7WG019835
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 6 May 2008 09:10:08 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m46GA6iO015352;
	Tue, 6 May 2008 09:10:06 -0700
In-Reply-To: <20080506154709.GF6918@mit.edu>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.422 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81364>



On Tue, 6 May 2008, Theodore Tso wrote:
> 
> Actually, the directory rename hueristic *does* have relevance in at
> least some real-world cases.  For example, MySQL has plugin
> directories, and occasionally the plugins get renamed, for whatever
> reason.

I'm not saying that directory renames don't happen.

I don't even say that merges across directory renames don't happen.

I *am* saying that it's not a problem.

It's like data conflicts. Do they happen? Sure as hell. I can pretty much 
guarantee that any sane project will have more data conflicts than they 
will have rename conflicts (whether single-file or directory), and it's 
not only a problem, it's something that is absolutely *required* from a 
source control management system!

So are data conflicts a problem?

I claim that they aren't. They are a *positive* resource that you need to 
handle. Some of the "handling" is obviously going to be to try to avoid 
them, and if you get too much of them, the real "problem" is that you 
merge too seldom, or more commonly that you have a piece of code that is 
simply not done well enough, so many different people have to muck around 
in that area.

But fundamentally, you should always have data conflicts, and they aren't 
a problem in themselves. They are a problem only

 - If they are hard to understand and see, and *unexpected*. The SCM
   should explain what is going on, and explain why a conflict happens 
   (and that may perhaps mean after-the fact! I love "gitk --merge" 
   exactly because it tends to be very good at explaining what was going 
   on!).

 - If they are hard to fix.

   For example, one of the main problems I had with BK merging was the 
   fact that while the megetool was wonderful, you effectively *had* to 
   merge using it, and you couldn't sanely do an "incremental" merge 
   where you first did a first merge job, then checked that it at 
   least compiles, then tested it, and finally looked at the diffs from 
   both parents and looked at whether those all made sense, and you could 
   "refine" or fix the merge along the different phases.

   Of course, you hope that all merges are pretty obvious, and you can do 
   it right in one go, but no, they're not. They'll never be. They'll 
   never be fully automtic, but even when they aren't automatic, they'll 
   not even be trivially to do manually. But that's OK, as long as the 
   tool at least doesn't fight you, and lets you do whatever you want to 
   do a part of fixing things up.

Now, take a look back at directory renames.

Do they happen?

Yes.

Do they potentially mis-merge?

Yes.

But are they common and/or hard to fix and handle?

No.

And that's why I don't think people should call them "problems". The only 
_real_ issue here, I think, is that git just does things differently from 
other SCM's. Git does a _lot_ of things differently. You get used to it.

			Linus

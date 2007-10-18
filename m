From: lmage11@twcny.rr.com
Subject: Proposed git mv behavioral change
Date: Thu, 18 Oct 2007 11:47:32 -0400
Message-ID: <c594999b2337.2337c594999b@nyroc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 17:47:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiXbA-0004aV-IP
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 17:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756214AbXJRPrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 11:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbXJRPrg
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 11:47:36 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:43241 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755971AbXJRPrf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 11:47:35 -0400
Received: from ms-mss-05 (ms-mss-05-smtp-b [10.10.4.35])
	by ms-smtp-03.nyroc.rr.com (8.13.6/8.13.6) with ESMTP id l9IFlW65025261
	for <git@vger.kernel.org>; Thu, 18 Oct 2007 11:47:34 -0400 (EDT)
Received: from nyroc.rr.com (localhost [127.0.0.1]) by ms-mss-05.nyroc.rr.com
 (iPlanet Messaging Server 5.2 HotFix 2.10 (built Dec 26 2005))
 with ESMTP id <0JQ400MHJ6J89L@ms-mss-05.nyroc.rr.com> for git@vger.kernel.org;
 Thu, 18 Oct 2007 11:47:32 -0400 (EDT)
Received: from [10.10.6.25] (Forwarded-For: [170.158.82.52])
 by ms-mss-05.nyroc.rr.com (mshttpd); Thu, 18 Oct 2007 11:47:32 -0400
X-Mailer: iPlanet Messenger Express 5.2 HotFix 2.10 (built Dec 26 2005)
Content-language: en
Content-disposition: inline
X-Accept-Language: en
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61538>

Hey, all...

Based on a question I asked on freenode's #git channel a few days ago, it seems that most 
people only use git 
mv when the file they're moving is clean. Those that don't have become accustomed to the 
behavior that git-mv 
uses when the file is dirty - to pull all unstaged changes into the index. As far as I can tell, 
this behavior is 
largely historical. When git-mv was written in bash (or perl, or whatever it was initially written 
in), it was most 
convenient to implement it as "mv oldname newname; git add newname;", or something 
similar, which would 
result in pulling in all wd changes. However, it seems to me that this behavior violates git's 
consistency. Usually 
when I do something with git, I expect it to do only what it says it will do, and nothing more. 
The 
documentation for git-mv says "The index is updated after successful completion", but I 
would tend to assume 
that this was referring to the name change and not the change in the actual contents of the 
file.

In my situation, I have some changes to a file that I'm not yet ready to commit. In the 
meantime, I've started 
working on another unrelated change that involves renaming one of the files which contain 
unstaged changes. 
I'd like to be able to perform this move without having my unstaged changes implicitly 
staged without my 
knowledge. When I want information put into the index, I either use git update-index if I 
want to explicitly 
stage an entire file or I use git add -i's patch command to explicitly stage individual chunks. I 
like having very 
fine-grained control over what goes into the index and what doesn't.

Therefore, I propose that git mv's behavior be changed. I think it would make far more sense 
for a move to only 
change the actual name of the file and to not pull in unstaged changes. In other words, I'd 
like the index entry 
for the original file name to be removed and an index entry to be added with a different 
name, but using the 
exact same blob hash as the original file. I don't know exactly how git manages the index 
internally, but a 
shortcut for this would be to simply rename the index entry in place.

I'm willing to look into what changes would need to be made to the code for this change to 
happen; I'm not 
asking for someone to do all the work for me. :)

So... Yeah. I'd like to know what people think about this before I put a significant amount of 
effort into it. After 
all, we know how lazy programmers are... :)

Thanks,
   Ari

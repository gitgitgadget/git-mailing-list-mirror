From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: rm and mv commands: should I use them?
Date: Sun, 6 Jan 2008 11:22:50 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801061108320.2811@woody.linux-foundation.org>
References: <379EDA94-A67B-483A-BC5F-E961DD52AD0C@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jon Hancock <redstarling@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 20:23:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBb5d-0003zE-GX
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 20:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbYAFTWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 14:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752651AbYAFTWx
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 14:22:53 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50421 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752396AbYAFTWx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jan 2008 14:22:53 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m06JMpuL009400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 Jan 2008 11:22:52 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m06JMoGb023019;
	Sun, 6 Jan 2008 11:22:51 -0800
In-Reply-To: <379EDA94-A67B-483A-BC5F-E961DD52AD0C@gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.724 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69740>



On Sun, 6 Jan 2008, Jon Hancock wrote:
> 
> So, do I need to use git's mv and rm commands?

Nope.

They are there only to

 (a) make people who are used to do "svn mv" not complain

 (b) simplify things a little teeny bit, by avoiding having to "git add" 
     the new file.

So if you do just a rename, you can do either

	git mv old-file new-file
	git commit

or you can do

	mv old-file new-file
	git add new-file
	git commit -a

and the *result* will be the same (the "git commit -a" is there to 
automatically pick up the fact that "old-file" went away: you could have 
done it with "git rm old-file" too, or "git add -u" or any number of 
other ways that update the index).

> Can't I just rename, add, and remove files using any means I like and 
> then just ensure my "index" is staged properly when I do a commit?

Absolutely. And depending on your workflow, that may well be the right 
thing to do. 

In particular, this all means that it's perfectly fine to make changes to 
a git repository using *any* non-git-aware tools, including things like 
graphical file managers etc.


> Additionally, is there a simple procedure with git to say: "I want to 
> version exactly what is in my working tree.  If I removed something or 
> added something, just handle it".  This is sort of what "git add ." 
> does, but "git add" doesn't handling things I removed or moved, correct?

You should be able to do that with either

	git add .
	git commit -a

or if you don't want to do a commit, you can do a

	git add -u
	git add .

where the "git add -u" will look at any files git already knows and update 
them (which includes removing them if they are gone), and then "git add ." 
will add any new files.

		Linus

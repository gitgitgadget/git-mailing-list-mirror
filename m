From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How to list files that are pending for commit from a merge,
 including  hand modified files
Date: Sat, 21 Feb 2009 15:29:23 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902211523280.3111@localhost.localdomain>
References: <e38bce640902211520j3f3c2787y28640b0ebcba5e27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 00:31:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lb1Je-0001IS-Ia
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 00:31:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518AbZBUX35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 18:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754503AbZBUX35
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 18:29:57 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52424 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754490AbZBUX34 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Feb 2009 18:29:56 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1LNTN1J014357
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 21 Feb 2009 15:29:24 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1LNTN8q012953;
	Sat, 21 Feb 2009 15:29:23 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <e38bce640902211520j3f3c2787y28640b0ebcba5e27@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.456 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110986>



On Sat, 21 Feb 2009, Brent Goodrick wrote:
> 
> Is there some way in which to get a listing of the files that git-status 
> shows in its "changes to be committed" section, but not the "Untracked 
> files" section, short of postprocessing the git-status output with 
> sed/awk gymnastics?

Just do variations on

	git diff --name-only HEAD

and the reason I say "variations on" is that depending on exactly what you 
want you may want to use slightly different diffs.

For example, the command line above will list all files that are changed 
in the working tree wrt HEAD. But if you want to see only the files that 
you have actually updated in the index (ie the ones that would be 
committed without using "-a"), you should add "--cached" to the command 
line, so that it does the diff from HEAD to index, not HEAD to working 
tree.

And if you want to see what files are different in the working tree from 
the index, then drop the "HEAD" part, since that's the default behavior 
for "git diff".

Finally, use "--name-status" if you want to see if they are new, modified, 
or deleted - rather than just the name.

And if you care about renames, and want to see them as such, use -C or -M, 
of course.

So "git ls-files" is not at all what you want. That will give you 
information about the current index, but doesn't talk at all about how it 
differs from the previous commit or from the working tree. It can be 
useful for another thing, though: if you're in the middle of a merge, then 
you can ask for which files are marked as being unmerged in the index.

		Linus

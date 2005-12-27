From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cannot handle more than 29 refs
Date: Tue, 27 Dec 2005 11:18:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512271113290.14098@g5.osdl.org>
References: <Pine.LNX.4.63.0512270840410.6812@gheavc.wnzcbav.cig>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 27 20:19:28 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErKLz-0001XI-Uq
	for gcvg-git@gmane.org; Tue, 27 Dec 2005 20:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVL0TTH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Dec 2005 14:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVL0TTH
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Dec 2005 14:19:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25241 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751133AbVL0TTF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Dec 2005 14:19:05 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBRJIxDZ006813
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Dec 2005 11:19:00 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBRJIwxS028143;
	Tue, 27 Dec 2005 11:18:59 -0800
To: Jon Nelson <jnelson-git@jamponi.net>
In-Reply-To: <Pine.LNX.4.63.0512270840410.6812@gheavc.wnzcbav.cig>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14081>



On Tue, 27 Dec 2005, Jon Nelson wrote:
> 
> I get this message whenever I use --tags with git-pull with certain 
> repositories.

You shouldn't "pull" tags. You should just "fetch" them.

The error message comes from the fact that the pull is a "fetch + merge", 
and the merge logic tries to figure out what the common parent is with 
"git-show-branch". And the common parent finding is limited to 29 commits.

(Which is a very reasonable limit: the normal case is 2, and doing an 
octopus-merge with more than four or five parents is already insane. Much 
less 30 parents).

> The git repository is one, and so is my local repository. 
> I googled and got nothing. I grepped the git archive and got only 
> show-branch.c.  Can this be safely ignored? Is it a known shortcoming, 
> or something else entirely?

Well, it's a known shortcoming, but it really ends up being a sign of you 
doing the wrong thing and trying to merge all the tags together. The merge 
would almost certainly fail, btw, regardless of anything else.

Junio - I think we should make "git pull" refuse to merge more than one 
head. If somebody wants to do an octopus merge, they can use "git merge" 
instead. Hmm?

		Linus

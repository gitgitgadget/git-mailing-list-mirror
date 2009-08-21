From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Raw commands to add object to existing tree
Date: Fri, 21 Aug 2009 15:49:52 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908211546250.3158@localhost.localdomain>
References: <ef72456d0908211531m5e261805p2f67d3a8a16a0b5@mail.gmail.com> <32541b130908211539ke64bd2bif0aa7cff6bc6ae8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: D Sundstrom <sunds@peapod.net>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 00:50:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mecvv-0006jC-6T
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 00:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932731AbZHUWt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 18:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbZHUWt6
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 18:49:58 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52772 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932696AbZHUWt5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2009 18:49:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7LMnrBr007168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 21 Aug 2009 15:49:54 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7LMnqRM027176;
	Fri, 21 Aug 2009 15:49:53 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <32541b130908211539ke64bd2bif0aa7cff6bc6ae8f@mail.gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126770>



On Fri, 21 Aug 2009, Avery Pennarun wrote:

> (Warning: untested code follows)
> 
> export GIT_INDEX_FILE=/tmp/my-temp-index
> git read-tree PREVIOUS_COMMIT_OR_TREE_ID
> hash=$(git hash-object NEW_FILE)
> git update-index --cacheinfo "0644 $hash path/of/file/in/tree"
> commitid=$(echo COMMIT MESSAGE | git commit-tree $(git write-tree))
> git update-ref refs/heads/BRANCHNAME $commitid PREVIOUS_COMMIT_OR_TREE_ID

Looks roughly correct, but you need to add a a "-p $PREVIOUS_COMMIT" to 
that git commit-tree thing. Otherwise the new commit will be a root 
commit. Which _might_ be what you want, of course, but I kind of expect it 
wasn't.

And no, I didn't test that either, so there may be other things that need 
fixing too.

Looking at that thing, I have ugly flashbacks to my git scripts in 2005 ;)

			Linus

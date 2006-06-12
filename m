From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: svn to git, N-squared?
Date: Sun, 11 Jun 2006 20:31:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606112028010.5498@g5.osdl.org>
References: <9e4733910606111902l709c71ccyf45070d55112739e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 12 05:31:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fpd9J-0002l9-HB
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 05:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWFLDba (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 23:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWFLDba
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 23:31:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12776 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750772AbWFLDb3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 23:31:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5C3VRgt016050
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Jun 2006 20:31:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5C3VQtb007213;
	Sun, 11 Jun 2006 20:31:27 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606111902l709c71ccyf45070d55112739e@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21683>



On Sun, 11 Jun 2006, Jon Smirl wrote:
>
> I have Mozilla CVS in a SVN repository. I've been using git-svnimport
> to import it. This time I am letting it run to completion; but the
> import has been running for four days now and it is only up to 2004.
> The import task is stable at 570MB and it is using about 50% of my
> CPU. It is constantly spawning off git write-tree, read-tree,
> hash-object, update-index. It is not doing excessive disk activity.

This sounds like _exactly_ what happens if you don't repack occasionally. 
Expecially if you are using a filesystem without hashed filename lookup, 
but it's true to some degree even with that - the filesystem tends to end 
up spending tons of time in kernel space, trying to find a place to put 
new objects.

I don't think git-svnimport has the repack logic in it, so that would be 
it.

You can probably stop it with ^Z, do a "git repack -a -d", and then let it 
continue.

(The only reason for stopping it is actually to let "git repack" remove 
most of the object directories - many filesystems, including ext3, don't 
even speed up all that much if the directories are emptied after they've 
grown big, and it's much better if the object directories get totally 
removed and re-created)

			Linus

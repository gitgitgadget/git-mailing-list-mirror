From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: why git-reset needed after "cp -a" of a git repo?
Date: Wed, 22 Aug 2007 12:11:14 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708221208090.30176@woody.linux-foundation.org>
References: <200708221857.l7MIv5tD011053@agora.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Erez Zadok <ezk@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Wed Aug 22 21:11:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INvc7-00025V-AD
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 21:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757306AbXHVTLc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 15:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753056AbXHVTLb
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 15:11:31 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40562 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750709AbXHVTLa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 15:11:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7MJBKmp029204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Aug 2007 12:11:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7MJBEYU032081;
	Wed, 22 Aug 2007 12:11:15 -0700
In-Reply-To: <200708221857.l7MIv5tD011053@agora.fsl.cs.sunysb.edu>
X-Spam-Status: No, hits=-2.748 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.28__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56408>



On Wed, 22 Aug 2007, Erez Zadok wrote:
> 
> However, I noticed that after I copy a git repo (using v1.5.2.2), the index
> entries are all out of sync, and I need to run git-reset.  Why?  What's in
> the index file that changes after a cp -a or rsync that git depends on?  Is
> it atime's and if so, aren't they copied by cp -a or rsync?

ctime/mtime and inode numbers too.

If you use hardlinks to copy the working tree, *and* you reset ctime 
afterwards, you'd be ok. But basically, git tries to be *really* anal in 
noticing any possible change to the inode, so anything it can do to notice 
that the index file might be stale, it does.

But you don't need to do a "git reset", you're actually better off just 
doing a "git status" instead. That will refresh the index.

		Linus

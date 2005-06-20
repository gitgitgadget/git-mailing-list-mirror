From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 'git commit' duplicates parents?
Date: Sun, 19 Jun 2005 19:24:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506191921270.2268@ppc970.osdl.org>
References: <42B59CF7.3080509@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 04:16:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkBqG-0005qN-J5
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 04:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVFTCWj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 22:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVFTCWj
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 22:22:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8148 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261386AbVFTCWf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2005 22:22:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5K2MWjA025250
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 19 Jun 2005 19:22:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5K2MVoa003958;
	Sun, 19 Jun 2005 19:22:31 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42B59CF7.3080509@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 19 Jun 2005, Jeff Garzik wrote:
> 
> I just checked in a change with 'git commit' (no arguments).  Two 
> strange things occurred:
> 
> 1) git-whatchanged does not list the change at all.  However,
> 	a) I verified that my change is indeed top-of-tree
> 	b) git-changes-script (attached) does show the change

Your commit is a merge. A corrupted one.

> 2) git-changes-script shows the parents in a readable fashion, and it 
> shows two duplicate parent entries.  In contrast, other changes do not 
> have two parents:
> 
> my change:
> > commit 4864989199fa62c7044be2258550ddc561411ab6
> 		^^^ top of tree aka .git/HEAD
> > tree b40996c7a0a5446875aa3664045af7e377451bf6
> > parent 7df551254add79a445d2e47e8f849cef8fee6e38
> > parent 7df551254add79a445d2e47e8f849cef8fee6e38

Notice: two times the same head.

You had a MERGE_HEAD in your tree, and "git commit" warned you about it in 
big bold letters and told you what to do, but you ignored it.

"git commit" said:

                echo "#"
                echo "# It looks like your may be committing a MERGE."
                echo "# If this is not correct, please remove the file"
                echo "# $GIT_DIR/MERGE_HEAD"
                echo "# and try again"
                echo "#"

and if you had just done as it asked you, you'd have been ok.

As to why you had a .git/MERGE_HEAD in your tree, it's probably because 
your merge scripts haven't kept up with mine.

		Linus

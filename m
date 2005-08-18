From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-whatchanged -p anomoly?
Date: Thu, 18 Aug 2005 15:10:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508181503200.3412@g5.osdl.org>
References: <200508182049.j7IKn7TA010456@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 00:11:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5saz-0006AO-2o
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 00:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbVHRWKk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 18:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbVHRWKk
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 18:10:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60316 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932489AbVHRWKj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2005 18:10:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7IMAbjA013343
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 18 Aug 2005 15:10:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7IMAYYI011476;
	Thu, 18 Aug 2005 15:10:36 -0700
To: "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <200508182049.j7IKn7TA010456@agluck-lia64.sc.intel.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 18 Aug 2005, Luck, Tony wrote:
> 
> The spurious changes reported by "git-whatchanged -p" are:
> 
> >  Documentation/acpi-hotkey.txt              |    3 
> >  Documentation/kernel-parameters.txt        |    5 
> >  drivers/acpi/osl.c                         |    6 
> >  fs/jfs/inode.c                             |    4 


Ehh. These are all from:

	Author: Alex Williamson <alex.williamson@hp.com>

	    [IA64, X86_64] fix swiotlb sizing

in commit b63d6e09b432e6873d072a767c87218f8e73e66c.

And you've signed off on it.

Do a

	git-diff-tree -p --pretty b63d6e09b432e6873d072a767c87218f8e73e66c | less -S

to see it in all its glory.

Now, I suspect you didn't mean to commit that thing: it really looks like 
you've mixed up your patches somehow, because the commit message seems to 
match only a very small portion of the patch.

Did you perhaps have a failed merge or something that was in your index 
when you applied that patch? If you have a dirty index when you do 
"git-applymbox", it the commit done as part of the applymbox might commit 
other state too.

(git-applymbox _does_ verify that the files that it patches are up-to-date 
in the index, but it does _not_ verify that the index matches the current 
HEAD. I guess I could add a sanity check for that...)

> Is this a bug, or am I just confused about how "git-whatchanged" works?

It's definitely not a bug in git-whatchanged, and I don't think you're 
confused about how git-whatchanged is supposed to work. But I think you've 
committed a bad patch.

		Linus

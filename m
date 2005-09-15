From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: getting a list of changes I commited
Date: Thu, 15 Sep 2005 11:38:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509151128170.26803@g5.osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F046625FC@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 20:41:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFyeB-0008Bv-Ib
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 20:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030567AbVIOSie (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 14:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030568AbVIOSie
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 14:38:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18136 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030567AbVIOSid (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 14:38:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8FIcTBo008528
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Sep 2005 11:38:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8FIcPBd016956;
	Thu, 15 Sep 2005 11:38:27 -0700
To: "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F046625FC@scsmsx401.amr.corp.intel.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8622>



On Thu, 15 Sep 2005, Luck, Tony wrote:
> 
> So I think that what I want is to produce a list of changes
> that I commited when I push a new tree out to kernel.org.
> But ... such a push usually contains lots of flow-through
> changes that I pulled from Linus ... so a simple:
> 
>  $ git-rev-list --no-merges newhead ^oldhead
> 
> gives a long list of changes.

Why not just _also_ limit it by what is already merged in my tree?

Ie just do

	git fetch linus
	git-rev-list --no-merges newhead ^oldhead ^linus

The problem with your approach:

>				 I'd like to filter out
> all the ones that weren't commited by me.  Is there an
> argument to git-rev-list that will just print the entries
> where I'm listed as the commiter, or do I have to use
> "--pretty-full" and write a little script to do the trim?

This is what "--header" (and it's zero termination) is designed for: you
can do

	git-rev-list --header --no-merges newhead ^oldhead |
		grep -z "committer .*tony\.luck"

and it will give a nice NUL-terminated output list of just your commits. 
No complex script necessary.

HOWEVER. The reason I suggest adding the ^linus instead is that I suspect
people really wants to see the development stuff, and that's what they'd
get if you just run the script often enough (and daily is certainly often
enough). Also, the "grep the committer" approach fundamentally doesn't
work if you ever plan on having sub-lieutenants that work with you and
that you use git to merge with.

But hey, that grep thing certainly works too. The output is trivial to 
parse.

(Oh, and I think "-z" is a GNU grep extension.)

			Linus

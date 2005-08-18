From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: git-whatchanged -p anomoly?
Date: Thu, 18 Aug 2005 16:04:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508181555370.3412@g5.osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F042C819D@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 01:05:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5tR6-0006uz-Pv
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 01:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVHRXEd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 19:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbVHRXEd
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 19:04:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2474 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932361AbVHRXEc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2005 19:04:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7IN4UjA017841
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 18 Aug 2005 16:04:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7IN4R3p014943;
	Thu, 18 Aug 2005 16:04:29 -0700
To: "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F042C819D@scsmsx401.amr.corp.intel.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 18 Aug 2005, Luck, Tony wrote:
> 
> Yes I had a failed merge ... I thought that I had cleaned up from it, but
> clearly I hadn't.  Bother.

The simplest way of cleaning up after a failed merge is just a simple "git
reset", which will also tell you if you need to perhaps clean up
afterwards (equally easily done with "git checkout -f" if you just want to 
blow all the changes away.

> I guess I have a bit of tree maintenance to do ... But I think that it
> should be easy ... I can just step "test" back to before I merged in
> the Alex patch.  Redo the Alex patch properly.  Then re-merge all the
> branches that happened after this.  Followed by crossing my fingers and
> running "git prune".
> 
> Maybe I'll try all that in a *copy" of my GIT tree first!

Yup. Think of it as a good exercise in git ;)

Btw, it's a shame that git has all these "git rebase" etc helper scripts, 
which rebase whole series of patches, but the simple "git re-do" which 
basically ends up being a

	git-diff-tree -p $old | git-apply --index &&
		git commit --reedit=$old

doesn't have a nice helper script.

Anyway, the easiest approach may be to just do

	git branch new-test-branch <good-point>
	git format-patch -o patchdir --mbox <good-point>
	git checkout new-test-branch
	.. edit the individual patches in patchdir/* to taste ..
	cat git-applymbox patchdir/* | git-applymbox

or similar. 

		Linus

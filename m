From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix branch ancestry calculation
Date: Fri, 24 Mar 2006 07:46:28 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603240739360.26286@g5.osdl.org>
References: <Pine.LNX.4.64.0603221723230.9196@g5.osdl.org> <44240619.20103@dm.cobite.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Mansfield <cvsps@dm.cobite.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 24 16:46:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMoUv-000408-Lv
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 16:46:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWCXPqm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 10:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWCXPqm
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 10:46:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25513 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751070AbWCXPqm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 10:46:42 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2OFkTDZ011636
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 24 Mar 2006 07:46:29 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2OFkSOQ013646;
	Fri, 24 Mar 2006 07:46:29 -0800
To: David Mansfield <centos@dm.cobite.com>
In-Reply-To: <44240619.20103@dm.cobite.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17923>



On Fri, 24 Mar 2006, David Mansfield wrote:
> 
> Anyway, I'd like to nail down some of the other nagging ancestry/branch point
> problems if possible.

What I considered doing was to just ignore the branch ancestry that cvsps 
gives us, and instead use whatever branch that is closest (ie generates 
the minimal diff). That's really wrong too (the data just _has_ to be in 
CVS somehow), but I just don't know how CVS handles branches, and it's how 
we'd have to do merges if we were to ever support them (since afaik, the 
merge-back information simply doesn't exists in CVS).

I actually went back to read some of the original CVS papers, and realized 
that CVS _without_ branches actually makes perfect sense.

Suddenly it was a perfectly reasonable system: the fact that you can only 
merge once (between working tree and repo) is perfectly reasonable when 
there is only one branch and checking in requires you to have updated 
first. All the things I really hated about CVS just go away if you don't 
do any branches at all.

Of course, it's a much less powerful thing without branches, but what I'm 
getting at is that the whole branch support seems to have been a total 
crock added later on top of something that was never designed for it, and 
where the data-structures aren't even set up for it.

Live and learn. (Of course, maybe I'm wrong, and the thing doesn't make 
sense even without branches).

			Linus

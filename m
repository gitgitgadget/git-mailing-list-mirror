From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/4] Tweak diff output further to make it a bit less
 distracting.
Date: Tue, 17 May 2005 08:20:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505170812060.18337@ppc970.osdl.org>
References: <7vvf5kqj9l.fsf@assigned-by-dhcp.cox.net> <20050516220559.GC8609@pasky.ji.cz>
 <7vsm0mn5s1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505161556260.18337@ppc970.osdl.org>
 <20050517070158.GA10031@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 17:19:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY3pj-00055d-H5
	for gcvg-git@gmane.org; Tue, 17 May 2005 17:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVEQPSf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 11:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVEQPSf
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 11:18:35 -0400
Received: from fire.osdl.org ([65.172.181.4]:26012 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261553AbVEQPS3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 11:18:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4HFIMU3002000
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 May 2005 08:18:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4HFILv0004835;
	Tue, 17 May 2005 08:18:22 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050517070158.GA10031@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.39__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 17 May 2005, Petr Baudis wrote:
> > 
> > 	diff -git a/kernel/sched.c b/kernel/sched.c.old
> > 	rename kernel/sched.c kernel/sched.c.old
> 
> Actually, if the git diff format is fixed, do we even need the explicit
> rename line? It could be enough if the filenames on the diff line would
> be just different. Or you want it because of clarity?

Yes, it's something we can glean from the header itself (or the ---/+++
lines), but I'd prefer it just to make things really obvious. Especially
as all the other pathnames involved (both on the "diff" header line and on
the ---/+++ lines) are in non-canonical -p1 format. So the "rename" line
would be the only one that is actually in canonical form.

There's also a real technical reason for this: since the rename format
would not be a valid patch for a traditional "patch" program, and if we
ever want to actually teach "patch" to handle it, we really need to be
explicit. There are tons of traditional patches around that say

	diff -Nur a/kernel/sched.c.old b/kernel/sched.c
	--- a/kernel/sched.c.old
	+++ b/kernel/sched.c
	...

and clearly the above is _not_ a rename from "sched.c.old" to "sched.c",
so if we want to teach "patch" about the magic git rules, we'd have to
have something unambiguous that a GNU patch maintainer might be willing to
trigger on. The combination of the "diff -git " and "rename" markers might
be such a thing.

So it's a combination of clarity, canonical names, and "patch" issues.

		Linus

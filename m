From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 2 Feb 2007 08:42:05 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702020835550.15057@woody.linux-foundation.org>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
 <200702010058.43431.jnareb@gmail.com> <20070201003429.GQ10108@waste.org>
 <200702021055.49428.jnareb@gmail.com> <slrnes6mmr.3l6.mdw@metalzone.distorted.org.uk>
 <epvnln$fmn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, mercurial@selenic.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 17:42:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD1UQ-0001sb-Dn
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 17:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945911AbXBBQmP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 11:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945959AbXBBQmP
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 11:42:15 -0500
Received: from smtp.osdl.org ([65.172.181.24]:57764 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945911AbXBBQmO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 11:42:14 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l12Gg743008958
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 2 Feb 2007 08:42:08 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l12Gg52m012390;
	Fri, 2 Feb 2007 08:42:06 -0800
In-Reply-To: <epvnln$fmn$1@sea.gmane.org>
X-Spam-Status: No, hits=-0.422 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38514>



On Fri, 2 Feb 2007, Jakub Narebski wrote:
> 
> Gaaah. Why anyone would want to have non-propagated tags?

That's *definitely* not the mistake.

I use private tags (and branches, for that matter) all the time. I'd be 
very upset indeed if all my tags were always pushed out when I push 
something out.

The mistake seems to be to think that tags get "versioned", and are part 
of the tree history. That's insane. It means that you can never have a tag 
to a newer tree than the one you are on.

Tags are *independent* of history. They must be. They are "outside" 
history, since the whole point of tags are to point to history.

The same is obviously true of branches. The fact that my "master" branch 
is at some point in time should *not* version my "other" branch. So 
branches - like tags - must not be "inside" the history.

> > If I may be opinionated for a bit: this is barking for two reasons:
> > 
> >   * The tags files grow by having lines added to the bottom.  Files of
> >     this kind are almost ideal for causing merge conflicts, and there's
> >     no automatic means for resolving them.  (I actually wrote a custom
> >     tags merger recently -- if anyone wants it, just mail me.)
> 
> Such a merger (merge strategy) would be also useful for other log-like
> files, e.g. ChangeLogs and such.

Yeah. I think per-file merge strategies are fine. We may not do them in 
git (nothing fundamental, it just hasn't come upas a real issue, although 
I think somebody was talking about how he ended up just using a special 
"merge" program that looked at the filename), but there is definitely 
nothing wrong with the concept.

And it solves that particular problem for tag-files, but it doesn't change 
the fact that keeping tags inside of history is insane in the first place 
(so it's not a problem that *should* be solved!)

			Linus

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] Git wiki
Date: Fri, 05 May 2006 12:49:59 -0700
Message-ID: <7vr738w8t4.fsf@assigned-by-dhcp.cox.net>
References: <20060505005659.9092.qmail@science.horizon.com>
	<20060505181540.GB27689@pasky.or.cz>
	<Pine.LNX.4.64.0605051123420.3622@g5.osdl.org>
	<20060505185445.GD27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 21:50:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc6JY-0008Gg-3b
	for gcvg-git@gmane.org; Fri, 05 May 2006 21:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWEETuE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 15:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbWEETuE
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 15:50:04 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:24747 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750991AbWEETuB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 May 2006 15:50:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060505195000.SQRM27327.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 5 May 2006 15:50:00 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060505185445.GD27689@pasky.or.cz> (Petr Baudis's message of
	"Fri, 5 May 2006 20:54:45 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19637>

Petr Baudis <pasky@suse.cz> writes:

> I doubt this in fact happens that often (to a degree the automatic
> rename detection would catch). And if it happens, then the user has to
> tell Git - I have never heard that _this_ would be any problem in other
> version control systems.

It does not become an issue only because users accept it as a
fact of life.  When Linus was moving most of the contents in
rev-list.c to create a new revision.c, I already had some tweaks
to rev-list.c published before he sent me a patch for the code
movement, and I am sure he needed to re-roll the patch by
merging the change I did to rev-list.c back into his revision.c
file.  No SCM may handle that automatically, and no user
accustomed to existing SCM (including git) expect that to work
automatically.  But that does not necessarily mean a tool that
notices it and tells user what is going on is a bad thing.

However it is a different story to try recording "what is going on"
whether it comes from the tool's guess or directly from the user.

Having a way to affect the inprecise "guess" the tool makes when
that guesswork is needed might make sense.  If you (think you)
know arch/i386/foo.h was copied to create arch/x86-64/foo.h but
the detector does not detect it and seeing a creation patch for
arch/x86-64/foo.h frustrates you, you may want to have a way to
explicitly say "compare arch/i386/foo.h with arch/x86-64/foo.h
in that commit -- I want to examine the change needed to adjust
foo to x86-64 architecture".

But we have "git diff v2.6.14:arch/i386/foo.h v2.6.14:arch/x86-64/foo.h"
for that ;-).

> Then the automated renames detection will miss it given that the other
> accumulated differences are large enough, and the suggested workarounds
> _are_ precisely walking the commit chain.

The HEAD may _not_ have anything to do with v1.3.0 in which case
you would get nothing from walking the ancestry.

> If you use persistent file ids, you never miss it _AND_ you DO NOT WALK
> THE COMMIT CHAIN! You still just match file ids in the two trees.

It is unworkable.

Which one should inherit the persistent id of the old
rev-list.c?  New rev-list.c, or revision.c that has most of the
old contents split out?

Oh, and did you know there was a different revision.h that is
not related to the current revision.h in the history of git?
Should its persistent id have any relation with the persistent
id of the current revision.h?  When would you decide to make the
id inherited and when not to?  If I remove revision.h by mistake
in a commit and resurrect it in the next commit, should it get
the same id back?  If I forget to tell the tool that those two
"disappeared and then reappeared" are related and should get the
same persistent id when I make the resurrection commit, and keep
piling other commits on top, do I have to rewind the ancestry
chain all the way to correct the mistake?

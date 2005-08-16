From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Alternate object pool mechanism updates.
Date: Tue, 16 Aug 2005 12:07:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508161156430.3553@g5.osdl.org>
References: <7vmznmp5ja.fsf@assigned-by-dhcp.cox.net> <20050813120815.GC5608@pasky.ji.cz>
 <7v1x4wcca0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0508141726390.3553@g5.osdl.org>
 <7vr7cw7ypt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 21:09:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E56mw-0006iH-QI
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 21:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbVHPTHw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 15:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbVHPTHw
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 15:07:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17079 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932348AbVHPTHv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 15:07:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7GJ7hjA020596
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 Aug 2005 12:07:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7GJ7ggC007705;
	Tue, 16 Aug 2005 12:07:42 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7cw7ypt.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 14 Aug 2005, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > I think this is great - especially for places like kernel.org, where a lot 
> > of repos end up being related to each other, yet independent.
> 
> Yes.  There is one shortcoming in the current git-clone -s in
> the proposed updates branch.  If the parent repository has
> alternates on its own, that information should be copied to the
> cloned one as well (e.g. Jeff has alternates pointing at you,
> and I clone from Jeff with -s flag --- I should list not just
> Jeff but also you to borrow from in my alternates file).

Btw, looking at the code, it strikes me that using ":" to separate the 
alternate object directories in the file is rather strange.

Maybe allow a different format for the file? Or at least allow '\n' as an 
alternate separator (but it would be nice to allow comments too).

Finally, I have to say that that "info" directory is confusing. Namely,
there's two of them - the "git info" and the "object info" directories are
totally different directories - maybe logical, but to me it smells like
"info" is here a code-name for "misc files that don't make sense anywhere
else".

Anyway, I don't think "alternates" is necessarily sensible as a "object"  
information. Sure, it's about alternate objects, but the thing is, object 
directories can be shared across many projects, but "alternates" to me 
makes more sense as a per-project thing.

What this all is leading up to is that I think we'd be better off with a 
totally new "git config" file, in ".git/config", and we'd have all the 
startup configuration there. Including things like alternate object 
directories, perhaps standard preferences for that particular repo, and 
things like the "grafts" thing.

Wouldn't that be nice?

		Linus

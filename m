From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: A note on merging conflicts..
Date: Fri, 30 Jun 2006 20:54:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 01 05:54:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwWZ8-0001Nl-Jx
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 05:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbWGADyj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 23:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932765AbWGADyj
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 23:54:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1515 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932704AbWGADyi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 23:54:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k613sYnW025361
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 30 Jun 2006 20:54:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k613sYux009547;
	Fri, 30 Jun 2006 20:54:34 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7vedntn.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23039>



On Fri, 30 Jun 2006, Junio C Hamano wrote:
> 
> Heh, that's why I kept saying I want somebody to teach rev-list
> a new notation, A...B, to mean $(merge-base A B)..B ;-).

I actually don't think that expression makes any sense.

	$(merge-base A B)..B

as an expression only makes sense if there is a single point of forking, 
and no contact apart from that. In that case, what you suggest makes 
sense, because doing

	git diff A...B

is exactly what you want. 

HOWEVER. If there has been any other merges in between (but they aren't 
merge-bases because either branch _also_ did other things), your A...B
expression is meaningless, I think. To do a diff in that case, you really 
need to do my "merge+diff" thing, and no amount of "A...B" expressions on 
a commit relationship level can be meaningful.

Now, the expression

	A...B == B...A == A B --not $(git-merge-base --all A B)

is meaningful (and the one I want for merges), but it's largely useless 
for anything else. It just means "the set of all commits that aren't 
trivially in both" (it's not strictly a valid set operation, but it
approaches being an "xor" instead of a union or an intersection or a 
difference).

But the above isn't useful for "git diff" and friends any more, it's 
mainly just for merging.

			Linus

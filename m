From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Fri, 5 May 2006 08:10:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605050806370.3622@g5.osdl.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net> <7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
 <87mzdx7mh9.wl%cworth@cworth.org> <7v1wv92u7o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 17:11:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc1xM-0007Bd-EM
	for gcvg-git@gmane.org; Fri, 05 May 2006 17:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWEEPK6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 11:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWEEPK6
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 11:10:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44468 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751135AbWEEPK5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 May 2006 11:10:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k45FAptH002495
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 5 May 2006 08:10:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k45FAoE4004568;
	Fri, 5 May 2006 08:10:50 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wv92u7o.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19611>



On Thu, 4 May 2006, Junio C Hamano wrote:
> 
> Jokes aside, I think listing the updated conversation elements
> like you did above is a good step forward.
> 
> The vocabulary we would want from the requestor side is probably
> (at least):
> 
> 	I WANT to have these
>         I HAVE these
>         I'm MISSING these
>         Don't bother with these this time around (--since, ^v2.6.16, ...)

Actually, I think we can do something simpler that _most_ people might be 
happy with.

Namely just have a mode to "git-send-pack" that uses the "--no-walk" flag 
to generate the object list to send.

What that does is to never walk the object history: so it will just use 
the "I HAVE THESE" and "I WANT THESE" commit references to directly 
generate the list of commits, and then walks the trees to generate the 
list of trees/blobs that differ between the particular end-points.

We already have the "no_walk" flag internally, we just don't expose it.

So what you'd get is a _really_ cut down history that doesn't contain any 
commit history at all (just distinct "points in commit history time"), but 
that _does_ contain all the objects that the commits point to.

		Linus

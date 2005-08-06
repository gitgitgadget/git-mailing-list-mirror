From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: My Itchlist
Date: Fri, 5 Aug 2005 19:39:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508051924390.3258@g5.osdl.org>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 04:40:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1Eao-0000Gf-80
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 04:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263146AbVHFCjN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Aug 2005 22:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263148AbVHFCjN
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Aug 2005 22:39:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38608 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263146AbVHFCjL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2005 22:39:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j762d4jA001603
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 5 Aug 2005 19:39:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j762d2Bn026595;
	Fri, 5 Aug 2005 19:39:03 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 5 Aug 2005, Junio C Hamano wrote:
> 
> - Teach fetch-pack reference renaming.

Well, the fetch side at least needs it less.

Right now the renaming means that you can only really fetch _one_ head at 
a time, but that's at least a fairly common and important case, and you 
can do the rest from there.

And doing only one means that git-fetch-pack can just return the result
SHA1 of the head it was asked to fetch. In fact, even that could just be
extended to returning multiple heads: just return each SHA1 in order. No 
"renaming" necessary, since it's then up to the user what to do with the 
results.

In fact, many users don't even want to write the result to a ref _at_all_: 
they just use the raw name - no refs - to merge.

So arguably it is _wrong_ to make git-fetch-pack write refs, because that 
just leads to the problem with temporary refs etc. "Local variables are 
good".

> These are not 1.0 showstopper items but what I personally would
> love to see.
> 
> - teach mailsplit/mailinfo basic MIME (attachments and quoted-printable)
> 
>   Some people send patches in MIME quoted-printable.  I could
>   drop them on the floor and ask the sender to resend, but I've
>   been being a nice guy, which currently involves manual
>   intervention.

This really is a nasty problem. People add their own commentary etc, and 
the fact is, the maintainer _needs_ to edit it.

Otherwise you'll have people saying "Hi there, I really like this thing, 
but I have this problem which this patch fixes" etc, which is all very 
nice, but dammit, that's simply not changelog material.

Also, I definitely myself end up editing patches occasionally: fixing 
things up. Again, this is simply a major pain if the patch comes in as an 
attachment.

So there are tons of reasons to just try to teach people that attachments 
are painful. Much better to teach people not to use them than having 
people use them and the tools "working" with them.

> - teach git-apply "reverse" and possibly "fuzz".
> 
>   I think this might help Porcelain; currently they have to
>   interpret git extended diff headers themselves.

Reverse would definitely be useful. "fuzz" is really pretty dangerous. I 
think that once a a patch doesn't apply, you really want to have helper 
tools like a graphical "wiggle" etc, and that really means that it's not 
"git-apply", it's something totally different.

And quite frankly, if you have a tool that can handle unified diffs 
already, then extending it for the git rename stuff should be pretty easy. 
It's not like we haven't wanted renaming patches for at least a _decade_ 
already, it's just that nobody ever did them. 

So I'm hoping that git can act as a impetus for people to just finally 
have a standard way of saying "rename". EVERYBODY wants it. Anybody who 
ever sees a rename as a patch will always go "damn, it would be nice to 
have renames". And dammit, we have them, so let's try to push out the 
concept.

And if that means that we should use rename patches and let non-git users 
have some pain until they say "ok, ok, it's a good idea, I'll do it. 
Uncle, uncle!", then maybe the world will be a better place. It's not like 
they can't see how git-apply does it already ;)

			Linus

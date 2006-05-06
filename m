From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Sat, 6 May 2006 18:23:03 +1200
Message-ID: <46a038f90605052323o29f8bfadr7426f97d8dfc2319@mail.gmail.com>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	 <7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
	 <87mzdx7mh9.wl%cworth@cworth.org>
	 <7v1wv92u7o.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0605050806370.3622@g5.osdl.org>
	 <e3fqb9$hed$1@sea.gmane.org>
	 <Pine.LNX.4.64.0605050848230.3622@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 06 08:23:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcGC5-0004lQ-SF
	for gcvg-git@gmane.org; Sat, 06 May 2006 08:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWEFGXG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 02:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWEFGXG
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 02:23:06 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:59098 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750806AbWEFGXE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 May 2006 02:23:04 -0400
Received: by wr-out-0506.google.com with SMTP id 68so676631wri
        for <git@vger.kernel.org>; Fri, 05 May 2006 23:23:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CR+NhImqZqaI2LlFHOhfUcGkE2D4rOcpROaYN2eCWamfdV0Y2vOhAYdUOWu5D21hUvAqV7OpQV2QpH0Nj0Fv8WhmnihbyIOKmsR4HDeZFG/Lp27JSIGOfDrsJGCY9UAM2xcpyRjD1SyqLRJw+EI/92CbCeeuMWSK1/gXfdzzNwU=
Received: by 10.54.82.15 with SMTP id f15mr14781wrb;
        Fri, 05 May 2006 23:23:04 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Fri, 5 May 2006 23:23:03 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605050848230.3622@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19648>

On 5/6/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Of course, that would require another slight difference to "rev-list.c",
> where we'd only recurse into trees of selected commit objects (ie we'd
> have to mark the HAVE/WANT commits specially, but it's not exactly
> complex either).

Would it make sense to make all the shallow clone clone machinery walk
everything and trim only blob objects? In that case, all the machinery
that walks commits/trees would remain intact -- we only have to deal
with the case of not having blob objects, which affects less
codepaths.

It means that for a merge or checkout involving stuff we "don't have",
it's trivial to know we are missing, and so we can  attempt a fetch of
the missing objects or tell the user how to request them them before
retrying.

And in any case commits and trees are lightweight and compress well...

> Of course, the complexity of _both_ of these approaches is really in the
> fsck stage, and all the crud you need to then do other things with these
> pared-down repos. For example, do you allow cloning? And do you just
> automatically notice that you're cloning a shallow repo, and only do a
> shallow clone. Etc etc..

Definitely.

cheers,


martin

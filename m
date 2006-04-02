From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] pack-objects: be incredibly anal about stdio semantics
Date: Sun, 2 Apr 2006 14:21:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604021417301.23419@g5.osdl.org>
References: <824.1144007555@lotus.CS.Berkeley.EDU> <Pine.LNX.4.64.0604021312510.3050@g5.osdl.org>
 <Pine.LNX.4.64.0604021328380.3050@g5.osdl.org> <7vmzf3k7m9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 02 23:21:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQA0Y-0003nX-UB
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 23:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbWDBVVM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 17:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbWDBVVM
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 17:21:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12729 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965028AbWDBVVL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 17:21:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k32LL6EX021593
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 2 Apr 2006 14:21:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k32LL6Bi023458;
	Sun, 2 Apr 2006 14:21:06 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzf3k7m9.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18287>



On Sun, 2 Apr 2006, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > This is the "letter of the law" version of using fgets() properly in the
> > face of incredibly broken stdio implementations.  We can work around the
> > Solaris breakage with SA_RESTART, but in case anybody else is ever that
> > stupid, here's the "safe" (read: "insanely anal") way to use fgets.
> 
> Did you mean this as a real change or a demonstration?  The
> sigaction change is a real fix, but somehow I find this one
> similar to the "(void*) NULL" thing you objected earlier (which
> was not merged because I agreed with your argument)...

I don't have any really strong opinions on it. I think that any libc that 
needs the "ferror()" test + EINTR loopback is totally broken. I would 
happily say that people should just not use a development platform that is 
that horrible.

But the fact that Solaris actually had that as a real problem (never mind 
that we could work around it another way) just makes me go "Hmm..".

So I _think_ we're safe with just the "sigaction()" diff.  Neither of the 
patches _should_ make any difference at all on a sane platform. 

		Linus

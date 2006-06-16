From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Security problem
Date: Thu, 15 Jun 2006 19:28:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606151831470.5498@g5.osdl.org>
References: <200606151709.22752.lan@academsoft.ru> <7vbqsuc60q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alexander Litvinov <lan@academsoft.ru>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 16 04:29:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fr459-0002EF-J3
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 04:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWFPC24 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 22:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWFPC24
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 22:28:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18912 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750718AbWFPC2z (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jun 2006 22:28:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5G2Sigt002865
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Jun 2006 19:28:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5G2Sh95002873;
	Thu, 15 Jun 2006 19:28:43 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqsuc60q.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21925>



On Thu, 15 Jun 2006, Junio C Hamano wrote:
>
> Alexander Litvinov <lan@academsoft.ru> writes:
> 
> > Why does not git-checkout check if file content match name of the object ?
> 
> Good point.  We could do a few things:

I missed the original mail. What's the problem?

If this is about the remote end lying about the SHA1 name, it's a total 
non-issue for any of the native protocols, since the native protocols 
don't actually send SHA1 names at all, they just send the data (and we 
re-create the SHA1 name on receipt).

So there's no way to have the name of an object not match its content, 
unless you have actual corruption (which is for git-fsck-object to find, 
not somethign that should slow down any normal operation), or if you use 
one of the dumb protocols.

And if you use the dumb protocols, the data should probably be validated 
_there_ (by fetch(), rather than anywhere else). And for "rsync", you 
really don't have much choice apart from doing a full fsck, I suspect.

So I don't see the security issue, unless you don't trust the local 
filesystem, in which case nothing git can do matters at all..

		Linus

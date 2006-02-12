From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix object re-hashing
Date: Sun, 12 Feb 2006 11:39:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602121137330.3691@g5.osdl.org>
References: <Pine.LNX.4.64.0602120956130.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602121006360.3691@g5.osdl.org> <7vaccwbf6v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602121037460.3691@g5.osdl.org> <Pine.LNX.4.64.0602121101040.3691@g5.osdl.org>
 <7vlkwg9ye0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 20:40:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8N4q-0004Jq-Ih
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 20:40:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWBLTkF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 14:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWBLTkE
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 14:40:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62858 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750841AbWBLTkD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 14:40:03 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1CJdxDZ018904
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Feb 2006 11:40:00 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1CJdx18017209;
	Sun, 12 Feb 2006 11:39:59 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkwg9ye0.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16016>



On Sun, 12 Feb 2006, Junio C Hamano wrote:
> 
> > Btw, as it currently stands, I worry a tiny tiny bit about the
> >
> > 	obj_allocs = (obj_allocs < 32 ? 32 : 2 * obj_allocs)
> >
> > thing, because I think that second "32" needs to be a "64" to be really 
> > safe (ie guarantee that the new obj_allocs value is always at least twice 
> > the old one).
> 
> obj_allocs starts out as 0 so the first value it gets is 32 when
> you need to insert the first element.

Yes. The point being that the code is "conceptually wrong", not that it 
doesn't work in practice. If we somehow could get into the situation that 
we had a hash size of 31, resizing it to 32 would be incorrect.

Of course, if we just make it a rule that the hash size must always be a 
power-of-two (add a comment, and enforce the rule by changing the modulus 
into a bitwise "and"), then that issue too goes away.

			Linus

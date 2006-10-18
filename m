From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Wed, 18 Oct 2006 14:48:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610181434510.3962@g5.osdl.org>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net> <7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171251210.1971@xanadu.home> <7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171437250.1971@xanadu.home> <20061017233630.72a0aae5.vsu@altlinux.ru>
 <Pine.LNX.4.64.0610171615340.1971@xanadu.home> <Pine.LNX.4.64.0610171339030.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171706260.1971@xanadu.home> <Pine.LNX.4.64.0610171440080.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171959070.1971@xanadu.home> <Pine.LNX.4.64.0610171754040.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610172140270.1971@xanadu.home> <Pine.LNX.4.64.0610171959180.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610172242430.17253@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0610180752500.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610180845040.18388@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0610180938540.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610181407040.18885@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Sergey Vlasov <vsu@altlinux.ru>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 23:49:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaJHw-0003ec-Qg
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 23:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423033AbWJRVtN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 17:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423023AbWJRVtN
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 17:49:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52425 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423033AbWJRVtH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 17:49:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9ILmiaX018490
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Oct 2006 14:48:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9ILmhjZ019631;
	Wed, 18 Oct 2006 14:48:43 -0700
To: Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <Pine.LNX.4.64.0610181407040.18885@alien.or.mcafeemobile.com>
X-Spam-Status: No, hits=-0.47 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29279>



On Wed, 18 Oct 2006, Davide Libenzi wrote:
> 
> The hash value (hence the hash bucket index) simply directs you to the 
> bucket where a real record-compare loop is performed.

As far as I can tell not all loops do a real "record-compare" thing.

Some of the hash loops _only_ look at the hash, and as such a bad hash 
will do more than just cause bad performance, it will actually degrade the 
diff itself. Isn't that what XDL_MAX_EQLIMIT effectively does?

Btw, the binary delta generator doesn't seem to have this issue at all: it 
uses "unsigned int" for the hash values, so the xdiff delta generation 
will give the same exact results on 32-bit and 64-bit architectures.

Or was that one of the changes by Nico? (I only looked at the git version 
of that code)

		Linus

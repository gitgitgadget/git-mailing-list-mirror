From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFH] xdiff shows trivially redundant diff.
Date: Sun, 2 Apr 2006 17:52:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604021749580.23419@g5.osdl.org>
References: <7v4q1cmj7l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604021035130.30097@alien.or.mcafeemobile.com>
 <7vzmj3k7x9.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604021454560.30205@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 02:52:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQDIi-0007QL-L5
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 02:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWDCAwI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 20:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWDCAwI
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 20:52:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63457 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964779AbWDCAwH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 20:52:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k330q3EX029312
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 2 Apr 2006 17:52:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k330q2TT028861;
	Sun, 2 Apr 2006 17:52:02 -0700
To: Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <Pine.LNX.4.64.0604021454560.30205@alien.or.mcafeemobile.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18299>



On Sun, 2 Apr 2006, Davide Libenzi wrote:
> 
> Yes, it does even vanilla libxdiff ;) It's not a problem though, since it is
> created in xdl_cleanup_records() that tries to do a fast pass over the records
> to try to simplify the real diff operation. In trying to be fast, only hashes
> are compared, and it happens that the hash for "'')" collides with another one
> (try to replace one of the "'')" chars with another one). Why is this not a
> problem? Because what this lead to is only lines to be marked as changed, with
> a probability of about N/2^(8 * sizeof(long) - 1), even though they are not.
> And this happens only during sequential groups of lines changed, that is when
> the hash-colliding line is either at the begin or the end of the run.

Hmm. It's still ugly, though. No possibility to have a "clean up identical 
initial and final lines" stage to get rid of extraneous bogus diffs?

I look at diffs a lot, and while this may be rare, if I were to end up 
having to wonder what the difference is and it turns out that it's just 
due to a libxdelta thing, I'd be a bit irritated and wish it gave me a 
proper diff..

		Linus

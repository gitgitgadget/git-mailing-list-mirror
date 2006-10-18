From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Tue, 17 Oct 2006 17:57:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610171754040.3962@g5.osdl.org>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171134130.1971@xanadu.home> <7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171251210.1971@xanadu.home> <7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171437250.1971@xanadu.home> <20061017233630.72a0aae5.vsu@altlinux.ru>
 <Pine.LNX.4.64.0610171615340.1971@xanadu.home> <Pine.LNX.4.64.0610171339030.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171706260.1971@xanadu.home> <Pine.LNX.4.64.0610171440080.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171959070.1971@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sergey Vlasov <vsu@altlinux.ru>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 02:57:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZzkK-0006pq-R8
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 02:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWJRA5W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 20:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWJRA5V
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 20:57:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32390 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751214AbWJRA5V (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 20:57:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9I0v9aX013617
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Oct 2006 17:57:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9I0v4RH013662;
	Tue, 17 Oct 2006 17:57:06 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0610171959070.1971@xanadu.home>
X-Spam-Status: No, hits=-0.471 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29168>



On Tue, 17 Oct 2006, Nicolas Pitre wrote:
> > 
> > .. and it sorts _differently_ on a big-endian vs little-endian thing, 
> > doesn't it?
> 
> Sure.  But who cares?  The sorting is just there to 1) perform binary 
> searches on the list of deltas based from a given object, and 2) find a 
> list of all deltas with the same base object.

_I_ care.

The new code is messy. It's fragile, and already showed one very 
fundamental bug which depended on architectures.

These things matter. We have had very few bugs in git, and one of the 
reasons is (I believe) that we haven't had ad-hoc code. I get _very_ 
nervous when you mix up SHA1 names with somethign totally different 
without even a flag to say which one it is. That's just nasty. The fact 
that the code then behaves (and behave_d_) differently on different 
architectures is just a sign of the problem.

"Who cares?" is not a good question to ask for a SCM. 

		Linus

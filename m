From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] git-split: Split the history of a git repository by
 subdirectories and ranges
Date: Mon, 23 Oct 2006 14:06:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610231402560.3962@g5.osdl.org>
References: <451A30E4.50801@freedesktop.org> <7vlko5d3bx.fsf@assigned-by-dhcp.cox.net>
 <453C96C9.4010005@freedesktop.org> <Pine.LNX.4.64.0610230846420.3962@g5.osdl.org>
 <453D17B5.6070203@freedesktop.org> <Pine.LNX.4.64.0610231237080.3962@g5.osdl.org>
 <453D2B98.8010903@freedesktop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 23:07:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc70h-0007Tc-UV
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 23:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbWJWVHB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 17:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbWJWVHA
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 17:07:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39386 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751999AbWJWVHA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 17:07:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9NL6oaX007044
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 Oct 2006 14:06:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9NL6n4p006362;
	Mon, 23 Oct 2006 14:06:50 -0700
To: Josh Triplett <josh@freedesktop.org>
In-Reply-To: <453D2B98.8010903@freedesktop.org>
X-Spam-Status: No, hits=-0.978 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29882>



On Mon, 23 Oct 2006, Josh Triplett wrote:
> 
> Or have I misunderstood the case you have concerns about?  Why would the
> "nice" format incur additional cost?

Try it. The default "extreme" simplification is a _hell_ of a lot faster 
than doing the full history.

	[torvalds@g5 linux]$ time git-rev-list --full-history --parents HEAD -- kernel/sched.c >/dev/null

	real    0m4.660s
	user    0m4.612s
	sys     0m0.044s

	[torvalds@g5 linux]$ time git-rev-list --parents HEAD -- kernel/sched.c >/dev/null
	
	real    0m1.684s
	user    0m1.680s
	sys     0m0.004s

and the "nice" thing will be much slower still: just trying to figure out 
whether a commit is a parent of another commit is expensive. Doing so for 
_each_ merge is more expensive still. I think it's O(n^3), but what do I 
know..

			Linus

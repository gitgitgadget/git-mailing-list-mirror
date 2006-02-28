From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/3] Tie it all together: "git log"
Date: Tue, 28 Feb 2006 12:59:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602281251390.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0602281115110.22647@g5.osdl.org>
 <Pine.LNX.4.64.0602281126340.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Feb 28 21:59:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEBwH-0004Af-2k
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 21:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbWB1U7R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 15:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbWB1U7R
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 15:59:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26343 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932554AbWB1U7Q (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2006 15:59:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1SKxCDZ012574
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Feb 2006 12:59:12 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1SKx3Wf029873;
	Tue, 28 Feb 2006 12:59:07 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0602281126340.22647@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16953>



On Tue, 28 Feb 2006, Linus Torvalds wrote:
> 
> Again, this may not do exactly what the current "git log" does. That's not 
> the point. The point is to introduce the fundamental functionality, so 
> that people can play with this and improve on it, and fix any of my stupid 
> bugs.

Btw, before anybody even pipes up: the missing piece here is the nasty 
"filter_commit()" that rev-list.c does, and that really should be moved 
into revision.c, and this is where I hit on the "--merge-order" issues.

So for example, if you do "git log -- <filename>" with the new git, it 
won't filter out the commits that just change the passed-in <filename> 
properly, because the filtering code still exists only in git-rev-list 
(even if revision.c now does the traversal).

Same goes for the max-count-based filtering, for the same reason.

So the "process_commit()" handling should be moved into "get_revision()", 
but since the merge-order code also hooks into it...

Anyway, apart from that issue (which I think should be trivial to sort out 
if we accept breaking --merge-order), the rest looks like it should just 
get more testing and handling of the few missing flags from rev-parse in 
revision.c, and it should be good.

		Linus

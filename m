From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] Make gc a builtin.
Date: Mon, 12 Mar 2007 18:20:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703121815411.9690@woody.linux-foundation.org>
References: <11736508181273-git-send-email-jbowes@dangerouslyinc.com>
 <20070312025736.GA28505@thunk.org> <Pine.LNX.4.63.0703121222350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070312133612.GD4372@thunk.org> <Pine.LNX.4.64.0703121202560.9690@woody.linux-foundation.org>
 <et4s76$9u3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 02:20:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQvgf-0004mI-W3
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 02:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbXCMBUV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 21:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752989AbXCMBUU
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 21:20:20 -0400
Received: from smtp.osdl.org ([65.172.181.24]:54872 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752974AbXCMBUS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 21:20:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2D1KGo4032640
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Mar 2007 18:20:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2D1KFZq019523;
	Mon, 12 Mar 2007 17:20:15 -0800
In-Reply-To: <et4s76$9u3$1@sea.gmane.org>
X-Spam-Status: No, hits=-0.985 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42103>



On Tue, 13 Mar 2007, Jakub Narebski wrote:

> Linus Torvalds wrote:
> 
> > Another thing I find annoying (even as a UNIX user) is that whenever I do 
> > any tracing for performance data, shell is absolutely horrid. It's *so* 
> > much nicer to do 'strace' on built-in programs that it's not even funny.
> 
> Isn't that what GIT_TRACE was made for?

That just shows the high-level git commands.

If you look for performance issues or correctness issues (like when I 
tried to figure out if O_LARGEFILE was set for "git clone"), GIT_TRACE 
does nothing. You want to do "strace -f -o trace-file".

And shell scripts look horrible there, and make it much harder to follow 
things. In fact, it doesn't even need to be shell per se, but fork/exec 
already makes things harder to see, shell just tends to (a) make it even 
more so (try stracing though a shell startup, ugh) and (b) cause tons of 
fork/exec cases.

For example, when we made patch generation a built-in, it suddenly became 
*hugely* easier to follow what was going on in the traces, because it got 
much more streamlined. In general I find that "high performance" == "easy 
to trace".

		Linus

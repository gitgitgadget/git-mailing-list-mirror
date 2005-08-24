From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix git-rev-parse breakage
Date: Wed, 24 Aug 2005 12:03:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508241200500.3317@g5.osdl.org>
References: <Pine.LNX.4.58.0508231908170.3317@g5.osdl.org>
 <7v4q9fdv5w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 21:06:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E80Xg-0004Go-Gb
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 21:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbVHXTD7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 15:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbVHXTD6
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 15:03:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48825 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751400AbVHXTD6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2005 15:03:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7OJ3qjA025319
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 24 Aug 2005 12:03:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7OJ3kEN031770;
	Wed, 24 Aug 2005 12:03:49 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q9fdv5w.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7723>



On Wed, 24 Aug 2005, Junio C Hamano wrote:
> that is not a right thing so get rid of that assumption" (which
> I agree is a good change", and the last sentense says
> opposite...

Well, the patch makes it an _explicit_ assumption, instead of a very 
subtly hidden one from the code-flow. It was the non-obvious hidden 
assumption that caused the bug.

> Here is my thinking, requesting for a sanity check.
> 
> * git-whatchanged wants to use it to tell rev-list arguments
>   from rev-tree arguments.  You _do_ want to pick --max-count=10
>   or --merge-order in this case, and --revs-only implying
>   --no-flags would make this impossible.

Fair enough. However, there are two kinds of flags: the "revision flags", 
and the "-p" kind of flags.

And the problem was that "git-whatchanged -p" didn't work any more,
because we passed "-p" along to "git-rev-list". Gaah.

			Linus

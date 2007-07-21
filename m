From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: gitk problems: can't unset "idinlist(...)"
Date: Fri, 20 Jul 2007 22:53:10 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707202226130.27249@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0707201554540.27249@woody.linux-foundation.org>
 <20070721050912.GB20622@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <junkio@cox.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 21 07:53:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC7uB-0000cE-1t
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 07:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756676AbXGUFxX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 01:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757405AbXGUFxX
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 01:53:23 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53910 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756269AbXGUFxW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 01:53:22 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6L5rGJU023751
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Jul 2007 22:53:17 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6L5rAn6002897;
	Fri, 20 Jul 2007 22:53:11 -0700
In-Reply-To: <20070721050912.GB20622@coredump.intra.peff.net>
X-Spam-Status: No, hits=-2.715 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53140>



On Sat, 21 Jul 2007, Jeff King wrote:
> 
> Interestingly, I repeatably get the exact same error but with a
> different commit:
> 
>   7ed40918a386afc2e14a6d3da563ea6d13686c25
> 
> which looks like a totally uninteresting commit.

It seems to depend on the path limiter.

With "arch/i386", I get the 7ed409 one, with "arch/i386 arch/x86_64" I get 
a complaint about 57d1c91fa. In neither case do I see the reason.

But I think I found a clue. One thing special about that 57d1c91fa is that 
when you do

	git log --topo-order --parents --pretty=one arch/i386/ arch/x86_64/

and search for it, it first shows up as a parent for commit 9fdb62af92: 
and not just _one_ parent, but three! So it looks like the parent 
simplification is broken, and maybe gitk is unhappy for that reason.

The same is true of 7ed40918a38, btw, so yeah, I think that's it.

Junio, didn't we have some parent simplification patches recently?

			Linus

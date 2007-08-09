From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git and larger trees, not so fast?
Date: Thu, 9 Aug 2007 10:54:38 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708091051290.25146@woody.linux-foundation.org>
References: <20070809163026.GD568@mbox.bz>
 <alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: moe <moe-git@mbox.bz>
X-From: git-owner@vger.kernel.org Thu Aug 09 19:55:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJCEE-0007b8-QB
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 19:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbXHIRyt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 13:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753464AbXHIRyt
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 13:54:49 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50323 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753392AbXHIRys (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Aug 2007 13:54:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l79HsipN011207
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Aug 2007 10:54:45 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l79HscPo011484;
	Thu, 9 Aug 2007 10:54:39 -0700
In-Reply-To: <alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.685 required=5 tests=AWL,BAYES_00,TW_BW
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55463>



On Thu, 9 Aug 2007, Linus Torvalds wrote:
> 
> We seem to spend a lot of our time in memcpy:
> 
> 	samples  %        image name               app name                 symbol name
> 	200527   25.4551  libc-2.6.so              libc-2.6.so              _wordcopy_bwd_aligned
> 	104505   13.2660  libc-2.6.so              libc-2.6.so              _wordcopy_fwd_aligned

Sorry, that was a bogus trace with some old stuff in it.

The real profile was this one.

	102343   73.1377  libc-2.6.so              libc-2.6.so              _wordcopy_bwd_aligned
	3573      2.5534  git                      git                      cache_name_compare
	2328      1.6637  git                      git                      index_name_pos
	...

which matches the rest of my emails.. (the "73%" is actually really 
supposed to be about 95%, but I had X running and doing stuff at the same 
time, so it was only 73% of all the other CPU activity that was going on 
over the time I profiled).

		Linus

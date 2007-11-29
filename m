From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: problem with git detecting proper renames
Date: Thu, 29 Nov 2007 11:27:02 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711291122050.8458@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0711291050440.1711@blarg.am.freescale.net> <alpine.LFD.0.9999.0711290934260.8458@woody.linux-foundation.org> <28BD703B-24D3-41D6-8360-240A884B1305@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 20:27:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixp2m-0002yh-83
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 20:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933071AbXK2T1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 14:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933007AbXK2T1G
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 14:27:06 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:32933 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932936AbXK2T1F (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Nov 2007 14:27:05 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lATJR23T009637
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Nov 2007 11:27:03 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lATJR2D9003337;
	Thu, 29 Nov 2007 11:27:02 -0800
In-Reply-To: <28BD703B-24D3-41D6-8360-240A884B1305@kernel.crashing.org>
X-Spam-Status: No, hits=-2.727 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66554>



On Thu, 29 Nov 2007, Kumar Gala wrote:
> 
> In the case of multiple identical matches can we look at the file name as a
> possible heuristic?

We already do. But we only do the base-name part and check it for 
exactness, since moving across directories is very common, and we 
explicitly want to pick up files that have the same base name.

However, in your case, not only did you have the same content, you had the 
same basename too! So git considered your renames to be totally identical 
wrt scoring with the current heuristics, and just picked one source at 
random. 

And the current heuristics don't even have any "if you already found a 
rename, avoid picking the same one twice", so it would pick the *same* 
source both times, which is why it looked like "two copies and one 
delete".

This is why I'd like to have a real-life example. I can change the 
heuristics, and I even know what are likely to be better heuristics, but I 
still want to actually see and play with an example so that when I send 
Junio a patch, I can explain it and say I've tested it with something 
real..

			Linus

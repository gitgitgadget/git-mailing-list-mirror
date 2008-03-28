From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git clone out of memory. alternatives?
Date: Thu, 27 Mar 2008 20:04:18 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803272001120.14670@woody.linux-foundation.org>
References: <beb5fde90803271929u40a98915ifd05234476ab92f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeffrey Chang <jeffrey.chang@duke.edu>
X-From: git-owner@vger.kernel.org Fri Mar 28 04:05:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jf4tw-0003iC-4Y
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 04:05:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755860AbYC1DE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 23:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755571AbYC1DEZ
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 23:04:25 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43011 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755456AbYC1DEZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2008 23:04:25 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2S34JtT032116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 27 Mar 2008 20:04:20 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2S34IrN002938;
	Thu, 27 Mar 2008 20:04:19 -0700
In-Reply-To: <beb5fde90803271929u40a98915ifd05234476ab92f9@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.345 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78382>



On Thu, 27 Mar 2008, Jeffrey Chang wrote:
> 
> Is there any way to get around this problem?  For example:
> - Can I run git clone in a way that uses less memory, such as cloning
> a piece of the repository at a time?

Cloning really is pretty memory-intensive, because it involves going 
through every single object.

What you *can* do is to limit cloning to the rsync protocol, which is 
strictly quite horrible (none of the inherent sanity-checks of the native 
protocol), but it avoids the server-side costs.

However, you'll eventually hit other problems, like the fact that you also 
won't be able to do a full repack on the server side (because a full 
repack does the same thing).

> - Can I export the entire repository as a file that can be loaded on
> my target machine, like "svnadmin dump" for subversion?

That's essentially what a repack does. See above about the problem.

> - Can I just rsync the repository from another computer that already has a copy?

Yes. You can. And you can also repack on another host and then rsync the 
results back to the server. It's not pretty, but it should work.

		Linus

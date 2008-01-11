From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Re-casing directories on case-insensitive systems
Date: Fri, 11 Jan 2008 13:25:37 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801111318570.3148@woody.linux-foundation.org>
References: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org> <CCDF6298-4F17-4F70-AF00-E63F2C2A2816@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 22:26:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDROC-0006xU-Af
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 22:26:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759264AbYAKVZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 16:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbYAKVZl
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 16:25:41 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59075 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750794AbYAKVZk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jan 2008 16:25:40 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0BLPc0U015536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Jan 2008 13:25:39 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0BLPbnv024188;
	Fri, 11 Jan 2008 13:25:37 -0800
In-Reply-To: <CCDF6298-4F17-4F70-AF00-E63F2C2A2816@sb.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70207>



On Fri, 11 Jan 2008, Kevin Ballard wrote:
>
> Wow, it's even worse. I made a tmp branch and used git-filter-branch to remove
> the commit that introduced CS4536, leaving only the cs4536 directory. But now
> if I try and run `git co master` it refuses, as it thinks it's going to
> overwrite the untracked file CS4536/introduction.txt. I believe it's actually
> seeing the tracked file cs4536/introduction.txt.

If you don't have any dirty state, I'd suggest removing your working tree 
before doing a "git checkout". That's needed anyway to make sure that your 
working tree has the same case as your index and git trees, because 
otherwise since the crazy filesystem thinks that CS4536/cs4536 ar ethe 
same, you might end up having all the wrong names.

Case differences are hard anyway, but you probably made them even harder 
by them using a rename that actually meant that the old name still 
*existed* in the filesystem (since the new name would always map to the 
old name thanks to your crazy filesystem).

I'm sure you can get into even more trouble with case-independent 
filesystems, but I think you did a pretty good job of hitting on one of 
the craziest cases ;)

		Linus

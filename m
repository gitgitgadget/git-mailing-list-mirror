From: Daniel Barkalow <barkalow@iabervon.org>
Subject: RE: git performance
Date: Thu, 23 Oct 2008 14:31:16 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0810231346520.19665@iabervon.org>
References: <000801c93483$2fdad340$8f9079c0$@com> <20081022203624.GA4585@coredump.intra.peff.net> <000901c93490$e0c40ed0$a24c2c70$@com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Edward Ned Harvey <git@nedharvey.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 20:32:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt4z6-0000n3-0J
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 20:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbYJWSbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 14:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755990AbYJWSbS
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 14:31:18 -0400
Received: from iabervon.org ([66.92.72.58]:45435 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529AbYJWSbS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 14:31:18 -0400
Received: (qmail 8137 invoked by uid 1000); 23 Oct 2008 18:31:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Oct 2008 18:31:16 -0000
In-Reply-To: <000901c93490$e0c40ed0$a24c2c70$@com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98980>

On Wed, 22 Oct 2008, Edward Ned Harvey wrote:

> Out of curiosity, what are they talking about, when they say "git is 
> fast?"  Just the fact that it's all local disk, or is there more to it 
> than that?  I could see - git would probably outperform perforce for 
> versioning of large files (let's say iso files) to benefit from 
> sustained local disk IO, while perforce would probably outperform 
> anything I can think of, operating on thousands of tiny files, because 
> it will never walk the tree. 

It shouldn't be too hard to make git work like perforce with respect to 
walking the tree. git keeps an index of the stat() info it saw when it 
last looked at files, and only looks at the contents of files whose stat() 
info has changed. In order to have it work like perforce, it would just 
need to have a flag in the stat() info index for "don't even bother", 
which it would use for files that aren't "open"; for files with this flag, 
the check for index freshness would always say it's fresh without looking 
at the filesystem. Then you'd just have a config option to check out files 
as "not open" (and not writeable), and have a "git open" program that 
would chmod files and get their real stat info.

Of course, git is tuned for cases where the modify/build/test cycle 
requires stat() (or worse) on every file.

	-Daniel
*This .sig left intentionally blank*

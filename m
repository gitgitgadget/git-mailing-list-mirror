From: Shaun Ruffell <sruffell@digium.com>
Subject: Re: Files that cannot be added to the index
Date: Sat, 27 Aug 2011 14:26:55 -0500
Message-ID: <20110827192655.GA14333@digium.com>
References: <CAMvu5bLuRWinMYNc4NoRKQKiLCWLcwkpowEFT4GQ0mcJYj6eOg@mail.gmail.com>
 <4E57A93A.6090405@drmicha.warpmail.net>
 <20110826205919.GB8107@sooty-2.local>
 <20110826211233.GB3093@digium.com>
 <20110827060718.GA28136@sigill.intra.peff.net>
 <20110827184009.GA12767@digium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	seanh <snhmnd@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 27 21:27:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxOXD-0007Um-DP
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 21:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506Ab1H0T1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 15:27:08 -0400
Received: from mail.digium.com ([216.207.245.2]:38958 "EHLO mail.digium.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216Ab1H0T1G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 15:27:06 -0400
Received: from zimbra.digium.internal ([10.24.55.203] helo=zimbra.hsv.digium.com)
	by mail.digium.com with esmtp (Exim 4.69)
	(envelope-from <sruffell@digium.com>)
	id 1QxOX1-0002ZC-13; Sat, 27 Aug 2011 14:27:03 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.hsv.digium.com (Postfix) with ESMTP id E0B8CD82A5;
	Sat, 27 Aug 2011 14:27:02 -0500 (CDT)
Received: from zimbra.hsv.digium.com ([127.0.0.1])
	by localhost (zimbra.hsv.digium.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4HGM3mrxB2w7; Sat, 27 Aug 2011 14:27:02 -0500 (CDT)
Received: from digium.com (sruffell.digium.internal [10.19.134.249])
	by zimbra.hsv.digium.com (Postfix) with ESMTPSA id DEC13D8024;
	Sat, 27 Aug 2011 14:27:01 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20110827184009.GA12767@digium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180242>

On Sat, Aug 27, 2011 at 01:40:09PM -0500, Shaun Ruffell wrote:
> 
> So, in summary, it looks like this is fixed.

Actually, after playing with it a little more on OSX, I think it was
just operator error on my part and that, for this, the versions are
behaving the same.

Adding a non-existent file produces an error:
  $ git add adjaskdj
  fatal: pathspec 'adjaskdj' did not match any files

Adding a file that is on the filesystem but only differs in case with a
file in the index silently fails:

  $ mv Makefile makefile
  $ echo "hello" >> makefile
  $ git ls-files -m
  Makefile
  $ git add makefile

And then when you try to commit the file you just added it fails:

  $ git commit
  # On branch master
  # Changes not staged for commit:
  #   (use "git add <file>..." to update what will be committed)
  #   (use "git checkout -- <file>..." to discard changes in working directory)
  #
  #	modified:   Makefile
  #
  no changes added to commit (use "git add" and/or "git commit -a")

Adding a file that is in the index, but only differs by case with a file
in the filesystem works:

  $ git add Makefile
  $ git commit -m "test"
  [master 8de0bd6] test
   1 files changed, 1 insertions(+), 0 deletions(-)

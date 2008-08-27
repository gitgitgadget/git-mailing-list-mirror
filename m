From: Garry Dolley <gdolley@arpnetworks.com>
Subject: Re: git-shortlog hangs on bare repo without --bare option
Date: Wed, 27 Aug 2008 15:15:45 -0700
Message-ID: <20080827221544.GA12459@garry-thinkpad.arpnetworks.com>
References: <20080827195233.GA2477@garry-thinkpad.arpnetworks.com> <48B5C9E4.4030807@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ren?? Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Aug 28 00:17:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYTJr-0001m6-6I
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 00:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbYH0WPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 18:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752546AbYH0WPq
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 18:15:46 -0400
Received: from mail.arpnetworks.com ([205.134.237.79]:51709 "HELO
	penguin.filetron.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752495AbYH0WPp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 18:15:45 -0400
Received: (qmail 21225 invoked from network); 27 Aug 2008 22:14:01 -0000
Received: from unknown (HELO garry-thinkpad.arpnetworks.com) (gdolley@arpnetworks.com@205.134.237.48)
  by mail.arpnetworks.com with SMTP; 27 Aug 2008 22:14:01 -0000
Content-Disposition: inline
In-Reply-To: <48B5C9E4.4030807@lsrfire.ath.cx>
X-PGP-Key: http://scie.nti.st/pubkey.asc
X-PGP-Fingerprint: A4C2 A268 0A00 1C26 94BC  9690 4255 E69B F65A 9900
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93967>

On Wed, Aug 27, 2008 at 11:40:52PM +0200, Ren?? Scharfe wrote:
> Garry Dolley schrieb:
> > I didn't see this happen with git 1.5.x, but if you do git-shortlog on a bare 
> > repo, without specifying --bare, the command will seemingly hang indefinitely.
> 
> FWIW, I tried git 1.5.0 and it hangs, too.  Which exact version did work
> for you?  Could you, based on it, bisect the commit that introduced this
> behaviour?

I just tried it with 1.5.6.2, and it hung.  Unfortunately, I had
several versions of git inside my ~/src as I upgraded over the
months, and just last week I decided to blow away the old ones, so I
don't know what version it was that I saw this work. :(

Either way, it's too big a deal, I just wanted to point out what I
saw.

If it helps, this is the last few lines of strace before it hangs:

stat(".git", 0x7fff6e44dd90)            = -1 ENOENT (No such file or directory)
open(".git/config", O_RDONLY)           = -1 ENOENT (No such file or directory)
pipe([3, 4])                            = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f7a6642d790) = 12674
dup2(3, 0)                              = 0
close(3)                                = 0
close(4)                                = 0
select(1, [0], NULL, [0], NULL

So looks like it is waiting to be fed some input?  It's hungry :)

> As a workaround, you can use "git log | git shortlog".

Also, 'git --bare shortlog' works too.

-- 
Garry Dolley
http://scie.nti.st
ARP Networks, Inc.
818-206-0181
Los Angeles County REACT, Unit 336
WQGK336

From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Tue, 27 Sep 2005 13:34:45 -0400
Message-ID: <20050927173445.GC23034@mythryan2.michonline.com>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz> <20050926212536.GF26340@pasky.or.cz> <4338F3F6.8040401@michonline.com> <Pine.LNX.4.58.0509270821590.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 27 19:38:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKJM1-0001hT-4W
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 19:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbVI0Rey (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 13:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbVI0Rey
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 13:34:54 -0400
Received: from mail.autoweb.net ([198.172.237.26]:6365 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S965027AbVI0Rex (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2005 13:34:53 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1EKJLp-0002zJ-Lq; Tue, 27 Sep 2005 13:34:45 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1EKJLp-00017b-00; Tue, 27 Sep 2005 13:34:45 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1EKJLp-0006Nz-Er; Tue, 27 Sep 2005 13:34:45 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509270821590.3308@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9409>

On Tue, Sep 27, 2005 at 08:34:22AM -0700, Linus Torvalds wrote:
> On Tue, 27 Sep 2005, Ryan Anderson wrote:
> > 
> > git-rev-parse $tagname^0
> 
> You need "--verify". Otherwise git-rev-parse will think that you just have 
> a strange filename or other random thing:
> 
> 	prompt$ git-rev-parse 000^0
> 	000^0

Hmm:

$ cat .git/refs/tags/v2.6.13-rc4
7eab951de91d95875ba34ec4c599f37e1208db93
$ git-rev-parse v2.6.13-rc4
7eab951de91d95875ba34ec4c599f37e1208db93
$ git-rev-parse v2.6.13-rc4^0
63953523341bcafe5928bf6e99bffd7db94b471e
$ git-rev-parse 63953523341bcafe5928bf6e99bffd7db94b471e^0
63953523341bcafe5928bf6e99bffd7db94b471e

# The typo that demonstrates what you did:
$ git-rev-parse 7eab951de91d95875ba34ec4c599f37e1208db93^-
7eab951de91d95875ba34ec4c599f37e1208db93^-

$ git-rev-parse 7eab951de91d95875ba34ec4c599f37e1208db93^0
63953523341bcafe5928bf6e99bffd7db94b471e

So I think --verify is beneficial if you want errors returned, but if
you know you have real tags or commits, git-rev-parse without the
--verify seems to do the right thing.

Or, at the very least, in the case where I used this
(linux/scripts/setlocalversion), this behavior is fine.

-- 

Ryan Anderson
  sometimes Pug Majere

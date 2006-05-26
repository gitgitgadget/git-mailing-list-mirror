From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Slow fetches of tags
Date: Fri, 26 May 2006 16:42:39 +0100
Message-ID: <20060526154239.GA20839@linux-mips.org>
References: <20060524131022.GA11449@linux-mips.org> <Pine.LNX.4.64.0605240931480.5623@g5.osdl.org> <Pine.LNX.4.64.0605240947580.5623@g5.osdl.org> <7v64jv8fdx.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605241200110.5623@g5.osdl.org> <Pine.LNX.4.64.0605241641250.5623@g5.osdl.org> <7vd5e23n5a.fsf@assigned-by-dhcp.cox.net> <7vd5e21zh9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 26 17:43:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjeSe-0005QF-Ox
	for gcvg-git@gmane.org; Fri, 26 May 2006 17:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWEZPmp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 11:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWEZPmp
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 11:42:45 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:4744 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1750920AbWEZPmp
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 May 2006 11:42:45 -0400
Received: from localhost.localdomain ([127.0.0.1]:30386 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133784AbWEZPmn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 May 2006 17:42:43 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4QFge3Z020943;
	Fri, 26 May 2006 16:42:41 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4QFgdcQ020942;
	Fri, 26 May 2006 16:42:39 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5e21zh9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20815>

On Wed, May 24, 2006 at 09:48:34PM -0700, Junio C Hamano wrote:

> I think the right fix for this is to change upload-pack to
> traverse reachability chain from the "want" heads as it gets
> "have" from the downloader, and stop responding "continue" when
> all "want" heads can reach some "have" commits.  This would not
> prevent it from going down all the way to the root commit if
> what is wanted does not have anything to do with what the other
> end has (e.g. if you have only my main project branches, and you
> ask for html head for the first time), but it would have
> prevented Ralf's tree from getting "continue" after he asked
> only for v2.6.16.18 tag and said he has 2.6.16.18 commit and its
> ancestors.  It should not be too difficult to do this, but here
> is an alternative, client-side workaround.
> 
> -- >8 --
> [PATCH] fetch-pack: give up after getting too many "ack continue"

So I did test your patch.  In the big, slow repository it cuts down the
time for a

  git fetch git://www.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git master:v2.6.16-stable

from like 6min to about 7s.

Thanks!

  Ralf

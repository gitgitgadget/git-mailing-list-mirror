From: Junio C Hamano <junkio@cox.net>
Subject: Re: git checkout -f branch doesn't remove extra files
Date: Fri, 12 Aug 2005 13:27:41 -0700
Message-ID: <7v8xz6uchu.fsf@assigned-by-dhcp.cox.net>
References: <B8E391BBE9FE384DAA4C5C003888BE6F04214AC7@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 22:28:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3g82-0003AT-5M
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 22:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbVHLU1o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 16:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbVHLU1o
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 16:27:44 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:5257 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750788AbVHLU1n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 16:27:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050812202742.WHDG17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 12 Aug 2005 16:27:42 -0400
To: "Luck, Tony" <tony.luck@intel.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

"Luck, Tony" <tony.luck@intel.com> writes:

> I see that when I switch view to a different
> branch with:
>
> 	$ git checkout -f someoldbranch
>
> that any files that exist in my previous branch view
> but not in "someoldbranch" are not deleted.
>
> ... I wondered whether this was a deliberate choice

Not really.

When possible, please use "git checkout" without -f.  That form
uses "git-read-tree -u -m", which can tell from your current
index file what's changed and what's going away.  This is only
possible if read-tree can rely on what is in your index file
actually matches the status of your working tree, and the -f
flag to checkout is to work around cases where you cannot give
that guarantee to read-tree and would want/need to start over
from scratch.  With -f flag, you are telling git-read-tree to
ignore what is currently recorded in your index file, hence what
should be in your working tree before checkout.  There is no way
for git-read-tree to tell which are source files that exist only
in the old thing you had checked out before (i.e. should be
removed) and which are files your build procedure left and/or
files you made by hand outside of SCM control (i.e. should be
kept) without that information, so that is why those files were
left behind.

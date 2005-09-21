From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: add Update menu item.
Date: Thu, 22 Sep 2005 09:46:43 +1000
Message-ID: <17201.61667.465005.53654@cargo.ozlabs.ibm.com>
References: <20050920122423.GA4228MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 02:11:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIEec-0008OW-Qk
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 02:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965186AbVIVAJc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 20:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965188AbVIVAJc
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 20:09:32 -0400
Received: from ozlabs.org ([203.10.76.45]:12505 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965186AbVIVAJb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 20:09:31 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 98311682FA; Thu, 22 Sep 2005 10:09:30 +1000 (EST)
To: Sven Verdoolaege <skimo@kotnet.org>
In-Reply-To: <20050920122423.GA4228MdfPADPa@greensroom.kotnet.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9087>

Sven Verdoolaege writes:

> Update will redraw the commits if any commits have been added to any
> of the selected heads.  The new commits appear on the top.

I like the idea but I am not sure if you have implemented it the best
way.

Are we sure that all the commits we had before doing the update will
still be there after the update?  What if I had checked in some
changes and run gitk, and then decided that the commit I just created
was wrong, and so I set HEAD to HEAD^1 and did a git prune, then told
gitk to update - shouldn't I see the top commit disappear?

Maybe it would be better to just clean out everything and re-read all
the commits from scratch.

Also, I'm not convinced that doing ^$id for all tags, heads and other
refs is correct.  Although we have read the reference and know the ID,
that doesn't mean we have seen that commit and displayed it.

The more general problem is to provide a way for the user to change
the set of commits displayed using a dialog box.  That would require
gitk to understand its command-line arguments so that the elements of
the dialog box could be initialized properly, though.

Some other comments:

> +    .bar.file add command -label "Update" -command "updatecommits [list $rargs]"

This would be better as:

    .bar.file add command -label "Update" -command [list updatecommits $rargs]

> +    rereadrefs

We don't need the redrawing part of rereadrefs, just the bit that
unsets tagids etc. and calls readrefs.

Regards,
Paul.

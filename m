From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Fix several places where diff.renames in config can be problematic
Date: Sat, 8 Jul 2006 01:41:22 -0700
Message-ID: <20060708084121.GD29036@hand.yhbt.net>
References: <11522670452824-git-send-email-normalperson@yhbt.net> <11522670473116-git-send-email-normalperson@yhbt.net> <7v7j2p3eac.fsf@assigned-by-dhcp.cox.net> <20060707110123.GA23400@soma> <7vpsghzmr1.fsf@assigned-by-dhcp.cox.net> <7v64i9zk0j.fsf@assigned-by-dhcp.cox.net> <20060708015844.GA13769@soma> <7vsllcr077.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 08 10:42:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fz8OH-00037v-LM
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 10:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWGHIlZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 04:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWGHIlZ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 04:41:25 -0400
Received: from hand.yhbt.net ([66.150.188.102]:12224 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751272AbWGHIlY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 04:41:24 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 30BDF7DC021; Sat,  8 Jul 2006 01:41:22 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vsllcr077.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23483>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > -my @files = safe_pipe_capture('git-diff-tree', '-r', $parent, $commit);
> > +my @files = safe_pipe_capture('git-diff-tree','--no-renames','-r',
> > +				$parent, $commit);
> 
> I changed my mind.
> 
> -- >8 --
> diff: do not use configuration magic at the core-level
> 
> The Porcelainish has become so much usable as the UI that there
> is not much reason people should be using the core programs by
> hand anymore.  At this point we are better off making the
> behaviour of the core programs predictable by keeping them
> unaffected by the configuration variables.  Otherwise they will
> become very hard to use as reliable building blocks.
> 
> For example, "git-commit -a" internally uses git-diff-files to
> figure out the set of paths that need to be updated in the
> index, and we should never allow diff.renames that happens to be
> in the configuration to interfere (or slow down the process).
> 
> The UI level configuration such as showing renamed diff and
> coloring are still honored by the Porcelainish ("git log" family
> and "git diff"), but not by the core anymore.

Full ack on this.  I was ready to let my diff.renames patch drop
if there were too many potential incompatibilities/breakages,
but this should alleviate that.

I should work on breaking out of the habit of using git
diff-{index,tree} in my day-to-day use and finally start using git diff
more to save some keystrokes.

-- 
Eric Wong

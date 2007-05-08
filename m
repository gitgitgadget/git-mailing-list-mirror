From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Change all git-status output to be "comments"
Date: Tue, 08 May 2007 14:07:12 -0700
Message-ID: <7v3b272fen.fsf@assigned-by-dhcp.cox.net>
References: <20070508021355.GA22383@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 08 23:07:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlWu4-0004fk-HL
	for gcvg-git@gmane.org; Tue, 08 May 2007 23:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032162AbXEHVHR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 17:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967944AbXEHVHQ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 17:07:16 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:40916 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967923AbXEHVHO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 17:07:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070508210714.GXPX26353.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 8 May 2007 17:07:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id wl7D1W0011kojtg0000000; Tue, 08 May 2007 17:07:13 -0400
In-Reply-To: <20070508021355.GA22383@spearce.org> (Shawn O. Pearce's message
	of "Mon, 7 May 2007 22:13:56 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46627>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> You wouldn't believe how many of my merge commits end with
> the following message from git-status:
>
>   "nothing to commit (working directory clean)"
>
> This happens because of the way I sometimes create (and resolve)
> some types of merges.  My commit message buffer gets prepped with
> the output of git-status, which has this nice message way down at the
> bottom of the file, below a large-ish block of lines that start with
> "#".  Since git-commit strips those lines, I always fail to see the
> trailing line that doesn't start with "#" and consequently fail to
> see that "nothing to commit ..." will be part of my merge message.
>
> So always comment out the output of git-status.

I think a better change would be to remove the 'nothing to
commit' when recording a merge.  The tool strongly discourage
creating an empty commit (iow, "diff-tree it^ it" is empty) for
a single parent case, while a merge that ends up (even when you
did not use "ours" strategy but resolved "fixing the same bug,
but differently" conflicts by hand) nullifying everything the
other side did is a perfectly normal merge.

I do not have a strong feeling against saying '# ' in front of
'nothing to commit' in the non-merge cases, other than that the
current one makes the 'nothing to commit' message itself stand
out in 'git status' output.  There also is a small issue of
updating the documentation and retraining people.  We need to
grep and replace them in the documentation and tutorial, and
start telling people who learn older copies of documentation
google finds that the older git said things slightly
differently.

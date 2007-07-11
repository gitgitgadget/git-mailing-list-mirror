From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-merge: run commit hooks when making merge commits
Date: Wed, 11 Jul 2007 14:26:09 -0700
Message-ID: <7vd4yy4opa.fsf@assigned-by-dhcp.cox.net>
References: <11841499201242-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Jul 11 23:26:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8jhp-0007ny-1K
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 23:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755435AbXGKV0O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 17:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754142AbXGKV0N
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 17:26:13 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:59370 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754437AbXGKV0K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 17:26:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070711212610.CQVY1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Wed, 11 Jul 2007 17:26:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NMS81X00Z1kojtg0000000; Wed, 11 Jul 2007 17:26:09 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52205>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> git-merge.sh was not running the commit hooks, so run them in the two
> places where we go to commit.
>
> Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
> ---
>    Not sure if it should call these or some specialist hooks, like
>    git-am does.

I suspect some people have pre-commit scripts that have been
meant to catch style errors for their own commits, and invoking
that on merge would wreak havoc --- there is not much you can do
if you want to get the work done by somebody else at that point.
Introducing a new pre-merge-commit hook would probably be safer;
if one wants to use the same check as one's pre-commit does, the
new hook in the repository can exec $GIT_DIR/hooks/pre-commit.

The commit-msg hook I have no clue what people usually use it
for in the real world, but a merge commit message tends to be
quite different from the message you would give to your own
straight line commits, so custom reformatting rules people have
in commit-msg hook may not apply to merge commit messages.

Same for post-commit, but probably to lessor extent, as I
suspect people use that mostly for per-commit notification
mechanism.

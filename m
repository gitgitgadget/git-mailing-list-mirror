From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach 'git-apply --whitespace=strip' to remove empty lines at the end of file
Date: Sun, 20 May 2007 11:36:50 -0700
Message-ID: <7v1whbmjel.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550705200251j3dd9b377je7ae5bafac988060@mail.gmail.com>
	<7vabvzq0bb.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550705200334pef694cn1a7842c23e2672f5@mail.gmail.com>
	<7vabvzoij8.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550705200545kcf1f7f9n4f3f6d7d25955e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 20:37:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpqHM-00045W-AI
	for gcvg-git@gmane.org; Sun, 20 May 2007 20:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757349AbXETSgx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 14:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757171AbXETSgx
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 14:36:53 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:40039 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757349AbXETSgw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 14:36:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070520183651.PWXU19731.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 20 May 2007 14:36:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1Wcq1X00e1kojtg0000000; Sun, 20 May 2007 14:36:51 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47883>

"Marco Costalba" <mcostalba@gmail.com> writes:

> Ok. This is take 3. It works correctly on standard patches and also on
> u0 example that you gave above.
>
> This patch is on top of git 1.5.2
>
> Please check it.

I think the checks and actions are at the right places (I
haven't looked very closely nor tried to run it yet).

> builtin-apply.c |   34 ++++++++++++++++++++++++++++++++++
> 1 files changed, 34 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-apply.c b/builtin-apply.c
> index 0399743..6032f78 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> ...
> @@ -1770,6 +1800,10 @@ static int apply_one_fragment(struct buffer_desc *desc,
> 		if (match_beginning && offset)
> 			offset = -1;
> 		if (offset >= 0) {
> +
> +			if (desc->size - oldsize - offset == 0) /* end of file? */
> +				newsize -= trailing_added_lines;
> +
> 			int diff = newsize - oldsize;
> 			unsigned long size = desc->size + diff;
> 			unsigned long alloc = desc->alloc;

But we have kept our sources -Wdeclaration-after-statement
clean so far, and this hunk needs a trivial adjustment.

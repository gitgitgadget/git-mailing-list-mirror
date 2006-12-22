From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] hooks/commit-msg: add example to add Signed-off-by line to message
Date: Thu, 21 Dec 2006 21:45:24 -0800
Message-ID: <7v64c47abv.fsf@assigned-by-dhcp.cox.net>
References: <7vejqufonm.fsf@assigned-by-dhcp.cox.net>
	<200612210924.17357.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Dec 22 06:45:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxdDl-0002Nf-2D
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 06:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945939AbWLVFp0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 00:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945949AbWLVFp0
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 00:45:26 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:56754 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945939AbWLVFpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 00:45:25 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222054524.DORM15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 00:45:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1hki1W0071kojtg0000000; Fri, 22 Dec 2006 00:44:42 -0500
To: git@vger.kernel.org
In-Reply-To: <200612210924.17357.andyparkins@gmail.com> (Andy Parkins's
	message of "Thu, 21 Dec 2006 09:24:17 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35132>

Andy Parkins <andyparkins@gmail.com> writes:

> +# Uncomment the below to add a Signed-off-by line to the message.
> +#SOB=$(git var GIT_AUTHOR_IDENT | \
> +#	sed -n "s/^\(.*\) [0-9]\+ [-+][0-9]\+$/Signed-off-by: \1/p")
> +#grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"

I suspect this sed script is quite wrong.  Did you test it?

 * quoting with dq means you are losing one level of backslash
   to the shell and sed is not seeing them.

 * one-or-more regexp '+' is typically not found in sed.

Also if this is meant to also handle cases where somebody
commits a patch received from an e-mail chain that multiple
people signed off their own changes to the patch, your name may
already appear earlier in the chain of existing Signed-off-by:
lines to sign off an earlier edition of the patch, but what you
are committing now would include your own changes you just made
on top of what all these people did, and you would want to sign
off that new change as well, I think.  So checking the last
instance of the existing signed-off-by line, ignoring earlier
ones, may be more preferrable.

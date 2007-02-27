From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] cvsserver: Remove trailing "\n" from commithash in checkin function
Date: Tue, 27 Feb 2007 15:45:49 -0800
Message-ID: <7vwt239nbm.fsf@assigned-by-dhcp.cox.net>
References: <200702210908.59579.andyparkins@gmail.com>
	<200702271249.09596.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 00:45:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMC13-0007Qh-Vq
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 00:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbXB0Xpv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 18:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbXB0Xpv
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 18:45:51 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:33317 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbXB0Xpu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 18:45:50 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227234550.UAOS2670.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 18:45:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Unlp1W00l1kojtg0000000; Tue, 27 Feb 2007 18:45:50 -0500
In-Reply-To: <200702271249.09596.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 27 Feb 2007 12:49:09 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40850>

Andy Parkins <andyparkins@gmail.com> writes:

> The commithash for updating the ref is obtained from a call to
> git-commit-tree.  However, it was returned (and stored) with the
> trailing newline.  This meant that the later call to git-update-ref that
> was trying to update to $commithash was including the newline in the
> parameter - obviously that hash would never exist, and so git-update-ref
> would always fail.
>
> The solution is to chomp() the commithash as soon as it is returned by
> git-commit-tree.
>
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>
>      my $commithash = `git-commit-tree $treehash -p $parenthash < $msg_filename`;
> +	chomp($commithash);
>      $log->info("Commit hash : $commithash");
>  

Thanks.  Do we need to compensate with a trailing LF in the $log
line?

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix overwriting of files when applying contextually independent diffs
Date: Wed, 18 Apr 2007 15:32:20 -0700
Message-ID: <7vtzvde2kr.fsf@assigned-by-dhcp.cox.net>
References: <20070418215856.GA2477@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 00:32:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeIhO-00014J-Lh
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 00:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992891AbXDRWcW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 18:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992893AbXDRWcW
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 18:32:22 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:63477 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992892AbXDRWcV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 18:32:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418223221.MHZC1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Apr 2007 18:32:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id omYL1W00b1kojtg0000000; Wed, 18 Apr 2007 18:32:21 -0400
In-Reply-To: <20070418215856.GA2477@steel.home> (Alex Riesen's message of
	"Wed, 18 Apr 2007 23:58:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44959>

Alex Riesen <raa.lkml@gmail.com> writes:

> Noticed by applying two diffs of different contexts to the same file.
>
> The check for existence of a file was wrong: the test assumed it was
> a directory and reset the errno (twice: directly and by calling
> lstat). So if an entry existed and was _not_ a directory no attempt
> was made to rename into it, because the errno (expected by renaming
> code) was already reset to 0. This resulted in error:
>
>     fatal: unable to write file file mode 100644
>
> For Linux, removing "errno = 0" is enough, as lstat wont modify errno
> if it was successful. The behavior should not be depended upon,
> though, so modify the "if" as well.
>
> The test simulates this situation.

Ok.  I briefly thought this might disable a more important
safety to refuse overwriting an untracked working tree file with
a creation patch, but that is caught much earlier in an
independent codepath already, so this should be safe to apply.

Thanks.

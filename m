From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Speed up git-svn fetch
Date: Fri, 25 Apr 2008 00:15:40 -0700
Message-ID: <20080425071540.GA3589@untitled>
References: <1208978273-98146-1-git-send-email-aroben@apple.com> <480F8BB5.2040605@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Brian Downing <bdowning@lavos.net>
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 09:16:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpIAX-0000Zu-Pw
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 09:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbYDYHPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 03:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752272AbYDYHPm
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 03:15:42 -0400
Received: from hand.yhbt.net ([66.150.188.102]:39662 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbYDYHPl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 03:15:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 4F5542DC08B;
	Fri, 25 Apr 2008 00:15:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <480F8BB5.2040605@apple.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80329>

Adam Roben <aroben@apple.com> wrote:
> Adam Roben wrote:
> >I first sent this patch series 6 months ago today [1], then resent it after
> >some comments from Junio, Johannes, and Brian [2].
> 
> Here are those links:
> 
> [1] http://thread.gmane.org/gmane.comp.version-control.git/62098/focus=62102
> [2] http://thread.gmane.org/gmane.comp.version-control.git/62295/focus=62298

Thanks for following up on this, the Perl bits look good to me[1].

I commented in a separate email about the shell incompatibilities
I experienced.

I still the following gcc warnings when building it:

> hash-object.c: In function 'hash_stdin_paths':
> hash-object.c:43: warning: implicit declaration of function 'unquote_c_style'

Trivial fix:
--- a/hash-object.c
+++ b/hash-object.c
@@ -6,6 +6,7 @@
  */
 #include "cache.h"
 #include "blob.h"
+#include "quote.h"

> hash-object.c:51: warning: control reaches end of non-void function

This can probably just be a void.

> builtin-cat-file.c: In function 'cmd_cat_file':
> builtin-cat-file.c:224: warning: suggest parentheses around && within ||

Ugh, you added long (>80 char) lines to this and I'm having trouble
following it.  I believe the git (like Linux) coding style calls for 80
char lines unless there is really no other way[2].  This is also a
problem for me in some of the shell tests, too.

> builtin-cat-file.c:151: warning: 'contents' may be used uninitialized in this function

gcc isn't smart here.


[1] - disclaimer, I'm not in my best mental state at this point in the
night/morning so maybe some things have slipped :)

[2] - Looking at your email address, I notice you work for a company that
pushes widescreen monitors, but I remain firmly on the side of dead tree
publishers whom I believe got line-wrapping right centuries ago :)

-- 
Eric Wong

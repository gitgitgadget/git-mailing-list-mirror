From: Junio C Hamano <junkio@cox.net>
Subject: Re: Diff output from a rewrite of a function
Date: Thu, 08 Mar 2007 15:24:06 -0800
Message-ID: <7vbqj38gkp.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0703082049060.19974@kivilampi-30.cs.helsinki.fi>
	<200703082301.35774.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@helsinki.fi>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 00:24:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPRy2-000556-Pa
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 00:24:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161126AbXCHXYK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 18:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161132AbXCHXYK
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 18:24:10 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:39548 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161126AbXCHXYI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 18:24:08 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070308232408.IYKH24587.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 8 Mar 2007 18:24:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id YPQ61W00j1kojtg0000000; Thu, 08 Mar 2007 18:24:07 -0500
In-Reply-To: <200703082301.35774.robin.rosenberg.lists@dewire.com> (Robin
	Rosenberg's message of "Thu, 8 Mar 2007 23:01:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41776>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> Increase the context size from the default three lines.  Something like
> diff -U 7 old new will require larger chunks of unchanged code for diff
> break up a hunk. With git you can do 
>
> GIT_DIFF_OPTS=-u7 git-diff-....

I think you can say "git diff -U7" to do what you are
describing, but I do not think that does what you want.  I think
what you want is a "negative context", which says "do not
consider group of lines less than N lines as matching between
preimage and postimage".  What Ilpo wants is to see something
like this:

-	Deleted 1
-	Deleted 2
-	Deleted 3
...
-	Deleted 400
+	Added 1
+	Added 2
+	Added 3
...
+	Added 500
	/* happens to match because this was left intact,too */
-	Deleted 401
-	Deleted 402
-	Deleted 403
+	Added 501

as if the small context lines that happen to match are also part
of the change, like this:

-	Deleted 1
-	Deleted 2
-	Deleted 3
...
-	Deleted 400
-	/* happens to match because this was left intact,too */
-	Deleted 401
-	Deleted 402
-	Deleted 403
+	Added 1
+	Added 2
+	Added 3
...
+	Added 500
+	/* happens to match because this was left intact,too */
+	Added 501

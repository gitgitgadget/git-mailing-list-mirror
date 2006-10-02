From: Junio C Hamano <junkio@cox.net>
Subject: Re: ANSWER
Date: Mon, 02 Oct 2006 00:40:00 -0700
Message-ID: <7v7izjxj1r.fsf@assigned-by-dhcp.cox.net>
References: <200610011138.06823.alan@chandlerfamily.org.uk>
	<200610011253.03169.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 02 09:40:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUIPJ-0006h5-SX
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 09:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWJBHkE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 03:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750696AbWJBHkE
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 03:40:04 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:41121 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750711AbWJBHkB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Oct 2006 03:40:01 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061002074000.QMBZ21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Mon, 2 Oct 2006 03:40:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id VKfv1V0051kojtg0000000
	Mon, 02 Oct 2006 03:39:55 -0400
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <200610011253.03169.alan@chandlerfamily.org.uk> (Alan Chandler's
	message of "Sun, 1 Oct 2006 12:53:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28220>

Alan Chandler <alan@chandlerfamily.org.uk> writes:

> On Sunday 01 October 2006 11:38, Alan Chandler wrote:
>
>> I have a .git/remotes/public file which contains
>>
>> URL:roo.home:/var/lib/git/akclib.git
>> Push:master
>
> The URL: and Push: need spaces before the detail
>
> This used to work, so somewhere along the line (when the builtin was 
> introduced?) the need for the space has arisen.

True.  I did not notice it before but this indeed is a breakage
when builtin-push.c was done.

Totally untested, but it looks obvious enough...

-- >8 --
git-push: .git/remotes/ file does not require SP after colon

Although most people would have one after colon if only for
readability, we never required it in git-parse-remote, so let's
not require one only in git-push.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/builtin-push.c b/builtin-push.c
index c43f256..f5150ed 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -78,12 +78,12 @@ static int get_remotes_uri(const char *r
 		int is_refspec;
 		char *s, *p;
 
-		if (!strncmp("URL: ", buffer, 5)) {
+		if (!strncmp("URL:", buffer, 4)) {
 			is_refspec = 0;
-			s = buffer + 5;
-		} else if (!strncmp("Push: ", buffer, 6)) {
+			s = buffer + 4;
+		} else if (!strncmp("Push:", buffer, 5)) {
 			is_refspec = 1;
-			s = buffer + 6;
+			s = buffer + 5;
 		} else
 			continue;
 

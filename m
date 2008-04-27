From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Use perl instead of tac
Date: Sun, 27 Apr 2008 02:55:50 -0400
Message-ID: <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com> <20080427064250.GA5455@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 27 08:57:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq0ok-0001hK-Im
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 08:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbYD0Gzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 02:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752268AbYD0Gzz
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 02:55:55 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:52617 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbYD0Gzy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 02:55:54 -0400
Received: from [192.168.1.7] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id B2DD11FFC250;
	Sun, 27 Apr 2008 06:55:38 +0000 (UTC)
In-Reply-To: <20080427064250.GA5455@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80424>

Subject: [PATCH] Use perl instead of tac

tac is part of GNU coreutils and not portable.  Use perl's reverse
function instead, since we already require it.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

On Apr 27, 2008, at 2:42 AM, Jeff King wrote:

> I know the list will be shocked to hear that Solaris has neither.

I am shocked and horrified.  But then again, that's mostly just my  
reaction to Solaris in general. ;-D

> An easy perl replacement is:
>
>  perl -e 'print reverse <>'
>
> which should work fine for small-ish input (since it puts the whole
> thing in memory).

Something like this?

And I'm having problems with t3404.13 now (mark :0 invalid).  And it's  
too late for me to track it down.

  git-rebase--interactive.sh |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 1751b08..303b754 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -469,7 +469,7 @@ create_extended_todo_list () {
  	test -n "${last_parent:-}" -a "${last_parent:-}" != $SHORTUPSTREAM  
&& \
  		echo reset $last_parent
  	) | \
-	tac | \
+	perl -e 'print reverse <>' | \
  	while read cmd args
  	do
  		: ${commit_mark_list:=} ${last_commit:=000}
-- 
1.5.5.111.g180d

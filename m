From: Junio C Hamano <junkio@cox.net>
Subject: Re: warning merge message
Date: Thu, 21 Dec 2006 22:00:39 -0800
Message-ID: <7v1wms79mg.fsf@assigned-by-dhcp.cox.net>
References: <867728.44872.qm@web31814.mail.mud.yahoo.com>
	<7vr6us92m2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 22 07:01:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxdSj-0004kF-Bj
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 07:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423072AbWLVGAm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 01:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423176AbWLVGAl
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 01:00:41 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:44740 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423072AbWLVGAl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 01:00:41 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222060040.PFKJ9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 01:00:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1hzx1W00K1kojtg0000000; Fri, 22 Dec 2006 00:59:58 -0500
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <7vr6us92m2.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 21 Dec 2006 16:49:09 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35133>

Junio C Hamano <junkio@cox.net> writes:

> Luben Tuikov <ltuikov@yahoo.com> writes:
>
>> Can we please eliminate this message:
>> Warning: No merge candidate found because value of config option
>>          "branch.master.merge" does not match any remote branch fetched.
>
> The above message was meant only for "git pull", but was leaked
> even when you did "git fetch"; it was a bug and was corrected
> already (hopefully).

Gaah... it turns out that it was not fixed properly.

Let's do this until we figure out what the correct fix would be.

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index ea7511e..871c08f 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -141,8 +141,7 @@ canon_refs_list_for_fetch () {
 			curr_branch=$(git-symbolic-ref HEAD | \
 			    sed -e 's|^refs/heads/||')
 			merge_branches=$(git-repo-config \
-			    --get-all "branch.${curr_branch}.merge") ||
-			merge_branches=.this.would.never.match.any.ref.
+			    --get-all "branch.${curr_branch}.merge")
 		fi
 		set x $(expand_refs_wildcard "$@")
 		shift

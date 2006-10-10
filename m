From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-revert in branch next
Date: Mon, 09 Oct 2006 19:21:20 -0700
Message-ID: <7vu02c9ahr.fsf@assigned-by-dhcp.cox.net>
References: <20061010011134.58584.qmail@web31809.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 04:21:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX7FF-0007Xn-Ig
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 04:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbWJJCVX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 22:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932812AbWJJCVW
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 22:21:22 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:21475 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932611AbWJJCVW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 22:21:22 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061010022121.ZKLU12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Mon, 9 Oct 2006 22:21:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YSMQ1V00C1kojtg0000000
	Mon, 09 Oct 2006 22:21:24 -0400
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20061010011134.58584.qmail@web31809.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Mon, 9 Oct 2006 18:11:34 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28595>

Luben Tuikov <ltuikov@yahoo.com> writes:

> --- Luben Tuikov <ltuikov@yahoo.com> wrote:
>> Has anyone successfully used "git-revert" from branch next, lately?

Yes, and it is actually in "master".  Thanks for noticing before
I declared -rc2.

-- >8 --
Fix git-revert

Defaulting to $replay for the sake of fixing cherry-pick was not
done conditionally, which broke git-revert.

Noticed by Luben.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-revert.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-revert.sh b/git-revert.sh
index 0784f74..4fd81b6 100755
--- a/git-revert.sh
+++ b/git-revert.sh
@@ -7,9 +7,11 @@ #
 case "$0" in
 *-revert* )
 	test -t 0 && edit=-e
+	replay=
 	me=revert
 	USAGE='[--edit | --no-edit] [-n] <commit-ish>' ;;
 *-cherry-pick* )
+	replay=t
 	edit=
 	me=cherry-pick
 	USAGE='[--edit] [-n] [-r] [-x] <commit-ish>'  ;;
@@ -18,7 +20,7 @@ case "$0" in
 esac
 . git-sh-setup
 
-no_commit= replay=t
+no_commit=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
-- 
1.4.2.3.g2c59

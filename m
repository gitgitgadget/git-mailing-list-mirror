From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Check that a tag exists using show-ref instead of looking for the ref file.
Date: Tue, 03 Oct 2006 02:09:29 -0700
Message-ID: <7vlknxrcja.fsf@assigned-by-dhcp.cox.net>
References: <20061001223304.d37df36f.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 11:09:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUgHN-0006eS-TW
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 11:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWJCJJb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 05:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWJCJJb
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 05:09:31 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:27902 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030265AbWJCJJa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 05:09:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061003090930.QWNE13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Tue, 3 Oct 2006 05:09:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Vl9Y1V00F1kojtg0000000
	Tue, 03 Oct 2006 05:09:32 -0400
To: Christian Couder <chriscool@tuxfamily.org>
In-Reply-To: <20061001223304.d37df36f.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sun, 1 Oct 2006 22:33:04 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28256>

Thanks.  We also need this to avoid refetching already packed
tags.

-- >8 --
[PATCH] git-fetch: do not look into $GIT_DIR/refs to see if a tag exists.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-fetch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index f1522bd..e8a7668 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -417,7 +417,7 @@ case "$no_tags$tags" in
 		sed -ne 's|^\([0-9a-f]*\)[ 	]\(refs/tags/.*\)^{}$|\1 \2|p' |
 		while read sha1 name
 		do
-			test -f "$GIT_DIR/$name" && continue
+			git-show-ref --verify --quiet -- $name && continue
 			git-check-ref-format "$name" || {
 				echo >&2 "warning: tag ${name} ignored"
 				continue
-- 
1.4.2.3.gd1e9e

From: Jeff King <peff@peff.net>
Subject: Re: git cherry-pick --continue?
Date: Wed, 10 Feb 2010 16:24:08 -0500
Message-ID: <20100210212408.GB7728@coredump.intra.peff.net>
References: <fabb9a1e1002101237i60a0b2c5j6d1e52b33dacbaa2@mail.gmail.com>
 <20100210210419.GA7728@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 22:24:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfK2h-0000eR-Ui
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 22:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756300Ab0BJVYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 16:24:10 -0500
Received: from peff.net ([208.65.91.99]:52451 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755303Ab0BJVYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 16:24:09 -0500
Received: (qmail 8419 invoked by uid 107); 10 Feb 2010 21:24:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 10 Feb 2010 16:24:14 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Feb 2010 16:24:08 -0500
Content-Disposition: inline
In-Reply-To: <20100210210419.GA7728@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139552>

On Wed, Feb 10, 2010 at 04:04:19PM -0500, Jeff King wrote:

> [1] On the other hand, I usually mistype that as "git am --continue",
> which _does_ make sense, since you are applying a sequence of patches.
> Maybe "am" should support both.

Hmm. I was thinking "am" was the odd man out, but really there are only
two sequencer commands that I noted: rebase and am. So you could perhaps
argue that rebase should also learn "--resolved". Or am I forgetting
one?

I find the patch below convenient. I dunno if anybody else actually
cares.

-- >8 --
Subject: [PATCH] am: allow --continue as a synonym for --resolved

Rebase calls this same function "--continue", which means
users may be trained to type it. There is no reason to
deprecate --resolved (or -r), but adding this synonym is
friendly to users.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-am.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index c8b9cbb..88cef39 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -26,6 +26,7 @@ patch-format=   format the patch(es) are in
 reject          pass it through git-apply
 resolvemsg=     override error message when patch failure occurs
 r,resolved      to be used after a patch failure
+continue        synonym for --resolved
 skip            skip the current patch
 abort           restore the original branch and abort the patching operation.
 committer-date-is-author-date    lie about committer date
@@ -318,7 +319,7 @@ do
 		scissors=t ;;
 	--no-scissors)
 		scissors=f ;;
-	-r|--resolved)
+	-r|--resolved|--continue)
 		resolved=t ;;
 	--skip)
 		skip=t ;;
-- 
1.7.0.rc2.22.g0716c.dirty

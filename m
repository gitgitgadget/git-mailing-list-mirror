From: Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCH] git-am: fix "Applying" message when applypatch-hook was
 run
Date: Thu, 21 Mar 2013 03:40:17 +0100
Message-ID: <20130321024017.GA17205@ruderich.org>
References: <7v1ub9d3xw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 03:40:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIVQu-0007iz-VY
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 03:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754241Ab3CUCkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 22:40:21 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:56390 "EHLO
	zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298Ab3CUCkU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 22:40:20 -0400
Received: from localhost (p54B5F8CF.dip.t-dialin.net [::ffff:84.181.248.207])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Thu, 21 Mar 2013 03:40:18 +0100
  id 000000000000003C.00000000514A7312.00005845
Content-Disposition: inline
In-Reply-To: <7v1ub9d3xw.fsf@alter.siamese.dyndns.org>
 <vpqli9hmyov.fsf@grenoble-inp.fr>
User-Agent: Mutt/1.5.21 (2013-03-19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218692>

applypatch-hook can modify the commit message. Display the updated
commit message instead of the original one.

Signed-off-by: Simon Ruderich <simon@ruderich.org>
---

On Thu, Mar 21, 2013 at 12:36:00AM +0100, Matthieu Moy wrote:
> Please, read SubmittingPatches in the Documentation directory of Git's
> source tree. Your text above should be a commit message (hence, no
> hello), and should not be below the --- line.
>
> Also, read about signed-off-by in the same document.

Hello Matthieu,

Thank you for the suggestions. I've adapted the patch message and
added the signed-off.

> This copy/paste a piece of code that is already a few lines above. Is
> there any reason not to _move_ the assignment to FIRSTLINE after the "if
> test -x "$GIT_DIR"/hooks/applypatch-msg", to avoid duplicating?

No, there wasn't a reason not to move the code. I just wasn't
sure if it had any side effects. But I rechecked and it should
work fine. Updating version attached.

On Wed, Mar 20, 2013 at 04:52:43PM -0700, Junio C Hamano wrote:
> More importantly, is this change even desirable?
>
> The original motivation behind the "Applying:" message was to help
> the user identify which one of the 100+ patches being fed to the
> command, and it was not about showing what we ended up committing.
> When you are running the command interactively, we do grab the
> edited result since f23272f3fd84 (git-am -i: report rewritten title,
> 2007-12-04), but I tend to feel that the automated munging done by
> applypatch-msg falls into a different category.

When I first used the applypatch-msg hook I was confused because
the messages were different and I thought the hook wasn't
working, hence the patch.

I'm not sure how extensive most applypatch-msg hooks modify the
commit message (in my case just a number prepended), but I think
it's more natural and less confusing to see the message which is
being applied.

If the original behaviour is preferred, a short comment in
githooks(5) should prevent any confusion.

Regards
Simon

 git-am.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 202130f..c092855 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -778,13 +778,6 @@ To restore the original branch and stop patching run \"\$cmdline --abort\"."
 	    action=yes
 	fi
 
-	if test -f "$dotest/final-commit"
-	then
-		FIRSTLINE=$(sed 1q "$dotest/final-commit")
-	else
-		FIRSTLINE=""
-	fi
-
 	if test $action = skip
 	then
 		go_next
@@ -797,6 +790,13 @@ To restore the original branch and stop patching run \"\$cmdline --abort\"."
 		stop_here $this
 	fi
 
+	if test -f "$dotest/final-commit"
+	then
+		FIRSTLINE=$(sed 1q "$dotest/final-commit")
+	else
+		FIRSTLINE=""
+	fi
+
 	say "$(eval_gettext "Applying: \$FIRSTLINE")"
 
 	case "$resolved" in
-- 
1.8.2

-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

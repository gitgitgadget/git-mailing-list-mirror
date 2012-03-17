From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: [fixup PATCH] push: Provide situational hints for non-fast-forward
 errors
Date: Sat, 17 Mar 2012 18:10:35 +0100
Message-ID: <4F64C58B.4000207@in.waw.pl>
References: <20120313232256.GA49626@democracyinaction.org> <vpqipi7zh3n.fsf@bauges.imag.fr> <7vty1rqek5.fsf@alter.siamese.dyndns.org> <7vlin1gl9l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	peff@peff.net, Clemens Buchacher <drizzd@aon.at>
To: Junio C Hamano <gitster@pobox.com>,
	Christopher Tiwald <christiwald@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 18:10:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8x9X-0002rL-Mr
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 18:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030755Ab2CQRKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 13:10:46 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:55858 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030379Ab2CQRKp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 13:10:45 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S8x9N-000351-15; Sat, 17 Mar 2012 18:10:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <7vlin1gl9l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193341>

On 03/16/2012 06:36 AM, Junio C Hamano wrote:
> +static const char message_advice_pull_before_push[] =
> +	N_("Update was rejected because the tip of your current branch is behind\n"
> +	   "the remote. Merge the remote changes (e.g. 'git pull') before\n"
> +	   "pushing again. See the 'Note about fast-forwards' section of\n"
> +	   "'git push --help' for details.");
> +
> +
> +static const char message_advice_use_upstream[] =
> +	N_("Some of your local branches were stale with respect to their\n"
> +	   "remote counterparts. If you did not intend to push these branches,\n"
> +	   "you may want to set the 'push.default' configuration variable to\n"
> +	   "'current' or 'upstream' to push only the current branch.");
> +
> +static const char message_advice_checkout_pull_push[] =
> +	N_("Updates were rejected because the tip of some of your branches are\n"
> +	   "behind the remote. Check out the branch and merge the remote\n"
> +	   "changes (e.g. 'git pull') before pushing again. See the\n"
> +	   "'Note about fast-forwards' section of 'git push --help'\n"
> +	   "for details.");

Hi,

Clemens' observation that there are unnecessary differences between
"message_advice_use_upstream" and "message_advice_checkout_pull_push"
is valid. There also was a grammatical error in message_advice_checkout_pull_push
("the tip ... are behind") and some tense/number inconsistencies.

I think the following can be squashed into 'fixup push-non-ff advice':

- always start with "Updates were rejected", i.e. explain what is why
  git is talking
- consistently use present tense to talk about stuff which is still true
- mention that branches to be pushed can be specified (add
  " explicitly specify branches to push or" in
  "you may want to set the 'push.default' configuration variable")
- use the simpler "tip of your branch is behind the remote" instead of the more 
  complicated and longer "some of your branches are stale with respect to their 
  remote counterparts".
- resolve the "tip ... are" problem by using singular and talking about
  a single branch. This way there is no conflict with the following 
  sentence which talks about checking out a single branch.
- rewrap the text to 72 lines (standard TeX paragraph width).
  (One line is 73 characters, but it seems better than the 
  alternative which makes the text take an extra line).

[I know that this mixes whitespace/layout changes with the rest, but the texts were mostly rewritten anyway.]

Zbyszek

------ 8< --------
From ef8d15494d518df809e4a822af0d0e1c4008c91e Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Date: Sat, 17 Mar 2012 18:00:42 +0100
Subject: [PATCH] fixup! fixup push-non-ff advice

---
 builtin/push.c |   25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 511a3ba..4c5b52b 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -142,24 +142,21 @@ static void setup_default_push_refspecs(struct remote *remote)
 }
 
 static const char message_advice_pull_before_push[] =
-	N_("Update was rejected because the tip of your current branch is behind\n"
-	   "the remote. Merge the remote changes (e.g. 'git pull') before\n"
-	   "pushing again. See the 'Note about fast-forwards' section of\n"
-	   "'git push --help' for details.");
-
+	N_("Update was rejected because the tip of your current branch is behind the\n"
+	   "remote. Merge the remote changes (e.g. 'git pull') before pushing again.\n"
+	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
 static const char message_advice_use_upstream[] =
-	N_("Some of your local branches were stale with respect to their\n"
-	   "remote counterparts. If you did not intend to push these branches,\n"
-	   "you may want to set the 'push.default' configuration variable to\n"
-	   "'current' or 'upstream' to push only the current branch.");
+	N_("Updates were rejected because a tip of your branch is behind the remote.\n"
+	   "If you did not intend to push that branch, you may want to explicitly\n"
+	   "specify branches to push or set the 'push.default' configuration variable"
+	   "to 'current' or 'upstream' to always push only the current branch.");
 
 static const char message_advice_checkout_pull_push[] =
-	N_("Updates were rejected because the tip of some of your branches are\n"
-	   "behind the remote. Check out the branch and merge the remote\n"
-	   "changes (e.g. 'git pull') before pushing again. See the\n"
-	   "'Note about fast-forwards' section of 'git push --help'\n"
-	   "for details.");
+	N_("Updates were rejected because a tip of your branch is behind the remote.\n"
+	   "Check out this branch and merge the remote changes (e.g. 'git pull')\n"
+	   "before pushing again.\n"
+	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
 static void advise_pull_before_push(void)
 {
-- 
1.7.10.rc0.162.g5dce3

------ >8 --------

From: Christopher Tiwald <christiwald@gmail.com>
Subject: Re: [PATCH v2] push: Provide situational hints for non-fast-forward
 errors
Date: Mon, 19 Mar 2012 18:22:25 -0400
Message-ID: <20120319222225.GA36860@gmail.com>
References: <20120319074944.GA18489@democracyinaction.org>
 <7vbonsbepx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, zbyszek@in.waw.pl,
	Matthieu.Moy@grenoble-inp.fr, drizzd@aon.at
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 23:22:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9kyK-0004h3-2E
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 23:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757612Ab2CSWWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 18:22:32 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:52964 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757405Ab2CSWWa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 18:22:30 -0400
Received: by qcqw6 with SMTP id w6so1471314qcq.19
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 15:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5PvgRLFbkMqADmhCn7z1USC1QbiguhUKTA+yTGoPE7k=;
        b=cMLhEaO5rwhDiLDXJjS0rK1KBfkpUS6UqP4pKzewh+D7WEjr/VuDI0Q+ZL7j/kmwly
         Tg/bvl7G5ynIqVxOBFMMRcu8C961tOdvdcyCRI2dOv8AMfdujcVJqYYk7keBTTdCt90d
         EgFzvie+ri+YQL7Qg5LXp9KJM0HnQu41b/kIKoPuoLIq7NhHYGxUpVD05Y0etcz/UwvM
         gvajPlGWg55Eur+F173qBmJ76bhV2b4qc3d7HdTtF6ciggVVVIMdqu1VxRRcOHnw4PwS
         pGGYyRadW0vYkwye7WJaUNaG7yTsWlRxmY1U7nk1XqvGVab/w2RDylrhSpRbQqU6TlyL
         RQaQ==
Received: by 10.224.105.79 with SMTP id s15mr2432106qao.35.1332195750135;
        Mon, 19 Mar 2012 15:22:30 -0700 (PDT)
Received: from gmail.com (cpe-74-66-248-47.nyc.res.rr.com. [74.66.248.47])
        by mx.google.com with ESMTPS id 1sm6718489qac.3.2012.03.19.15.22.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Mar 2012 15:22:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vbonsbepx.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193468>

On Mon, Mar 19, 2012 at 11:58:02AM -0700, Junio C Hamano wrote:
> Christopher Tiwald <christiwald@gmail.com> writes:
> 
> > Pushing a non-fast-forward update to a remote repository will result in
> > an error, but the hint text doesn't provide the correct resolution in
> > every case. Give better resolution advice in three push scenarios:
> >
> > 1) If you push a non-fast-forward update to your current branch, you
> > should merge remote changes with 'git pull' before pushing again.
> 
> I have always found "update *to* your current branch" very strange
> phrasing (the earlier one said "to HEAD", but it amounts to the same
> thing).  You do not push *to* your branch.  You push your branch to
> somewhere else (namely, remote).  I would understand if it said "If your
> push of your current branch triggers a non-ff error, ...", though.

Ah. Yeah. I can see the problem with my phrasing now. How about something
like the following?

"If you push your current branch and it triggers a non-fast-forward
error, you should merge remote changes with 'git pull' before pushing
again."

> She never gets a chance to see the other checkout-pull-push message, does
> she?
> 
> >  There is one aspect about this patch about which I'm unsure: What to
> >  do with users who've set "advice.pushNonFastForward = false" already.
> 
> The change in this patch is merely clarifying what pushNonFastForward
> advise has already taught them ("Non-ff was rejected; the manual will tell
> you what you wanted to do") by dividing them into three categories and
> giving different advices to these categories.  As the user says he
> understood what he is doing, I think squelching all of them is a sane
> choice.

How about the something like the following fixup? This introduces two
changes to v2:

- It breaks the new advice into three config variables. Users
  who might benefit from the advice can't accidentally shut a message
  off before being confronted with the situation it's designed to
  advise.
- It leaves pushNonFastForward in place, and if a user sets
  'advice.pushNonFastForward = false', it'll disable all three pieces
  of advice.

--
Christopher Tiwald
--- 8< ---
Signed-off-by: Christopher Tiwald <christiwald@gmail.com>
---
 Documentation/config.txt |   19 +++++++++++++++----
 advice.c                 |    8 ++++++--
 advice.h                 |    4 +++-
 builtin/push.c           |    6 +++---
 4 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a2329b5..fb386ab 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -137,13 +137,24 @@ advice.*::
 	can tell Git that you do not need help by setting these to 'false':
 +
 --
+	pushNonFastForward::
+		Set this variable to 'false' if you want to disable
+		'pushNonFFCurrent', 'pushNonFFDefault', and
+		'pushNonFFMatching' simultaneously.
 	pushNonFFCurrent::
 		Advice shown when linkgit:git-push[1] fails due to a
 		non-fast-forward update to the current branch.
-	pushNonFFOther::
-		Advice shown when linkgit:git-push[1] fails due to a
-		non-fast-forward update to a branch other than the
-		current one.
+	pushNonFFDefault::
+		Advice to set 'push.default' to 'upstream' or 'current'
+		when you ran linkgit:git-push[1] and pushed 'matching
+		refs' by default (i.e. you did not provide an explicit
+		refspec, and no 'push.default' configuration was set)
+		and it resulted in a non-fast-forward error.
+	pushNonFFMatching::
+		Advice shown when you ran linkgit:git-push[1] and pushed
+		'matching refs' explicitly (i.e. you used ':', or
+		specified a refspec that isn't your current branch) and
+		it resulted in a non-fast-forward error.
 	statusHints::
 		Directions on how to stage/unstage/add shown in the
 		output of linkgit:git-status[1] and the template shown
diff --git a/advice.c b/advice.c
index ee62e1b..a492eea 100644
--- a/advice.c
+++ b/advice.c
@@ -1,7 +1,9 @@
 #include "cache.h"
 
+int advice_push_nonfastforward = 1;
 int advice_push_non_ff_current = 1;
-int advice_push_non_ff_other = 1;
+int advice_push_non_ff_default = 1;
+int advice_push_non_ff_matching = 1;
 int advice_status_hints = 1;
 int advice_commit_before_merge = 1;
 int advice_resolve_conflict = 1;
@@ -12,8 +14,10 @@ static struct {
 	const char *name;
 	int *preference;
 } advice_config[] = {
+	{ "pushnonfastforward", &advice_push_nonfastforward },
 	{ "pushnonffcurrent", &advice_push_non_ff_current },
-	{ "pushnonffother", &advice_push_non_ff_other },
+	{ "pushnonffdefault", &advice_push_non_ff_default },
+	{ "pushnonffmatching", &advice_push_non_ff_matching },
 	{ "statushints", &advice_status_hints },
 	{ "commitbeforemerge", &advice_commit_before_merge },
 	{ "resolveconflict", &advice_resolve_conflict },
diff --git a/advice.h b/advice.h
index 98c675e..f3cdbbf 100644
--- a/advice.h
+++ b/advice.h
@@ -3,8 +3,10 @@
 
 #include "git-compat-util.h"
 
+extern int advice_push_nonfastforward;
 extern int advice_push_non_ff_current;
-extern int advice_push_non_ff_other;
+extern int advice_push_non_ff_default;
+extern int advice_push_non_ff_matching;
 extern int advice_status_hints;
 extern int advice_commit_before_merge;
 extern int advice_resolve_conflict;
diff --git a/builtin/push.c b/builtin/push.c
index 3de2737..a0ffbb3 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -138,21 +138,21 @@ static const char message_advice_checkout_pull_push[] =
 
 static void advise_pull_before_push(void)
 {
-	if (!advice_push_non_ff_current)
+	if (!advice_push_non_ff_current | !advice_push_nonfastforward)
 		return;
 	advise(_(message_advice_pull_before_push));
 }
 
 static void advise_use_upstream(void)
 {
-	if (!advice_push_non_ff_other)
+	if (!advice_push_non_ff_default | !advice_push_nonfastforward)
 		return;
 	advise(_(message_advice_use_upstream));
 }
 
 static void advise_checkout_pull_push(void)
 {
-	if (!advice_push_non_ff_other)
+	if (!advice_push_non_ff_matching | !advice_push_nonfastforward)
 		return;
 	advise(_(message_advice_checkout_pull_push));
 }
-- 
1.7.10.rc1.23.g2a051.dirty

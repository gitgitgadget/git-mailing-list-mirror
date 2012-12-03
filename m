From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 2/2] push: allow already-exists advice to be disabled
Date: Sun,  2 Dec 2012 21:27:51 -0600
Message-ID: <1354505271-25657-3-git-send-email-chris@rorvick.com>
References: <7vmwxwka6f.fsf@alter.siamese.dyndns.org>
 <1354505271-25657-1-git-send-email-chris@rorvick.com>
Cc: git@vger.kernel.org, Chris Rorvick <chris@rorvick.com>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 04:29:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfMiq-0003ff-Oc
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 04:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198Ab2LCD3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2012 22:29:09 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:37158 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755185Ab2LCD3H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2012 22:29:07 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so1849795iay.19
        for <git@vger.kernel.org>; Sun, 02 Dec 2012 19:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=dINAH3xC7xt/S5YBd2jIigC5A32L88QIzd7PlPMLfus=;
        b=qqrzKcVGsEN9eJtbBUrHutWM4bpXkzMGREZuhPzf/z4nvq3AA5JBZp6esv2KMFI9w+
         DcYn0pU+/5SlQY7AVaV7QogKKj8E2/VosWKWmU5hoyNBrM+ngPygui/cP6ppj731LKEq
         xuBVpdeCvNFrW7vpcxGk9OS0pdGLxq7sUSk1/DIUTf8s6CavkBborRILYg7CEtmYIM9P
         TvNSNukJ8qUg0RD62A3OWvHFT9VUmYQNMgh6fGK1L8Y9lxZE7BKS9beLEQkrbV3sr+3e
         93DY9sfKeI5BhZwWMGz37KOUkG48gWIPtAK/BqL/Y7vJ66gBuZR3XsCRFOGfyfWHR/FQ
         f3CQ==
Received: by 10.50.195.168 with SMTP id if8mr4964656igc.71.1354505346747;
        Sun, 02 Dec 2012 19:29:06 -0800 (PST)
Received: from marlin.localdomain ([70.131.98.170])
        by mx.google.com with ESMTPS id fa6sm6610808igb.2.2012.12.02.19.29.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Dec 2012 19:29:05 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1.541.g73be2da
In-Reply-To: <1354505271-25657-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211025>

Add 'advice.pushAlreadyExists' option to disable the advice shown when
an update is rejected for a reference that is not allowed to update at
all (verses those that are allowed to fast-forward.)

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 Documentation/config.txt | 8 ++++++--
 advice.c                 | 2 ++
 advice.h                 | 1 +
 builtin/push.c           | 2 ++
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 92903f2..90e7d10 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -142,8 +142,9 @@ advice.*::
 --
 	pushUpdateRejected::
 		Set this variable to 'false' if you want to disable
-		'pushNonFFCurrent', 'pushNonFFDefault', and
-		'pushNonFFMatching' simultaneously.
+		'pushNonFFCurrent', 'pushNonFFDefault',
+		'pushNonFFMatching', and 'pushAlreadyExists'
+		simultaneously.
 	pushNonFFCurrent::
 		Advice shown when linkgit:git-push[1] fails due to a
 		non-fast-forward update to the current branch.
@@ -158,6 +159,9 @@ advice.*::
 		'matching refs' explicitly (i.e. you used ':', or
 		specified a refspec that isn't your current branch) and
 		it resulted in a non-fast-forward error.
+	pushAlreadyExists::
+		Shown when linkgit:git-push[1] rejects an update that
+		does not qualify for fast-forwarding (e.g., a tag.)
 	statusHints::
 		Show directions on how to proceed from the current
 		state in the output of linkgit:git-status[1] and in
diff --git a/advice.c b/advice.c
index 329e077..d287927 100644
--- a/advice.c
+++ b/advice.c
@@ -4,6 +4,7 @@ int advice_push_update_rejected = 1;
 int advice_push_non_ff_current = 1;
 int advice_push_non_ff_default = 1;
 int advice_push_non_ff_matching = 1;
+int advice_push_already_exists = 1;
 int advice_status_hints = 1;
 int advice_commit_before_merge = 1;
 int advice_resolve_conflict = 1;
@@ -18,6 +19,7 @@ static struct {
 	{ "pushnonffcurrent", &advice_push_non_ff_current },
 	{ "pushnonffdefault", &advice_push_non_ff_default },
 	{ "pushnonffmatching", &advice_push_non_ff_matching },
+	{ "pushalreadyexists", &advice_push_already_exists },
 	{ "statushints", &advice_status_hints },
 	{ "commitbeforemerge", &advice_commit_before_merge },
 	{ "resolveconflict", &advice_resolve_conflict },
diff --git a/advice.h b/advice.h
index c28ef8a..8bf6356 100644
--- a/advice.h
+++ b/advice.h
@@ -7,6 +7,7 @@ extern int advice_push_update_rejected;
 extern int advice_push_non_ff_current;
 extern int advice_push_non_ff_default;
 extern int advice_push_non_ff_matching;
+extern int advice_push_already_exists;
 extern int advice_status_hints;
 extern int advice_commit_before_merge;
 extern int advice_resolve_conflict;
diff --git a/builtin/push.c b/builtin/push.c
index cf5ecfa..8491e43 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -247,6 +247,8 @@ static void advise_checkout_pull_push(void)
 
 static void advise_ref_already_exists(void)
 {
+	if (!advice_push_already_exists || !advice_push_update_rejected)
+		return;
 	advise(_(message_advice_ref_already_exists));
 }
 
-- 
1.8.0.1.541.g73be2da

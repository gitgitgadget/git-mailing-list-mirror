From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 1/2] push: rename config variable for more general use
Date: Sun,  2 Dec 2012 21:27:50 -0600
Message-ID: <1354505271-25657-2-git-send-email-chris@rorvick.com>
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
X-From: git-owner@vger.kernel.org Mon Dec 03 04:29:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfMih-0003Ri-96
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 04:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224Ab2LCD3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2012 22:29:06 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:37158 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755246Ab2LCD3E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2012 22:29:04 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so1849795iay.19
        for <git@vger.kernel.org>; Sun, 02 Dec 2012 19:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=7LlIiDKos0NCDVZDRy0AI80Q2tLcWkp+ip6kCX/PBAc=;
        b=a0kp1D9IhmeIMKPyPWc18LM4Ooy3MUtkYx7hWGdNcRaqNRiObYVAaMod2XHkqOAh6R
         OZ1OvfDZ3/nFGp6ehVS5TFENSMpgNGG8cdV6BjK15nZrD8eklSgOr8F/JIejLkQ5ALcX
         K2QFp0FdcUeNCSkjNRO+XVDowvwLXZa8FTMULdhtn+YpsG/SVFxrq3oDtkte4koJ9xOx
         iPb7sYNTXs8HAATjPDtBlq5CJADYxm9hKadhhEea9TNdz/3IdFQULUlHgKY30wEzowN3
         nkv3ONdYEQodzTz02Q1uq3CMP4oWrKgpmOrAdxENQTz2Jde7CHUlbzDxlFKVIhDj2OZL
         BuWQ==
Received: by 10.43.125.133 with SMTP id gs5mr6780252icc.54.1354505344477;
        Sun, 02 Dec 2012 19:29:04 -0800 (PST)
Received: from marlin.localdomain ([70.131.98.170])
        by mx.google.com with ESMTPS id fa6sm6610808igb.2.2012.12.02.19.29.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Dec 2012 19:29:03 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1.541.g73be2da
In-Reply-To: <1354505271-25657-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211024>

The 'pushNonFastForward' advice config can be used to squelch several
instances of push-related advice.  Rename it to 'pushUpdateRejected' to
cover other reject scenarios that are unrelated to fast-forwarding.
Retain the old name for compatibility.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 Documentation/config.txt | 2 +-
 advice.c                 | 7 +++++--
 advice.h                 | 2 +-
 builtin/push.c           | 6 +++---
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9a0544c..92903f2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -140,7 +140,7 @@ advice.*::
 	can tell Git that you do not need help by setting these to 'false':
 +
 --
-	pushNonFastForward::
+	pushUpdateRejected::
 		Set this variable to 'false' if you want to disable
 		'pushNonFFCurrent', 'pushNonFFDefault', and
 		'pushNonFFMatching' simultaneously.
diff --git a/advice.c b/advice.c
index edfbd4a..329e077 100644
--- a/advice.c
+++ b/advice.c
@@ -1,6 +1,6 @@
 #include "cache.h"
 
-int advice_push_nonfastforward = 1;
+int advice_push_update_rejected = 1;
 int advice_push_non_ff_current = 1;
 int advice_push_non_ff_default = 1;
 int advice_push_non_ff_matching = 1;
@@ -14,7 +14,7 @@ static struct {
 	const char *name;
 	int *preference;
 } advice_config[] = {
-	{ "pushnonfastforward", &advice_push_nonfastforward },
+	{ "pushupdaterejected", &advice_push_update_rejected },
 	{ "pushnonffcurrent", &advice_push_non_ff_current },
 	{ "pushnonffdefault", &advice_push_non_ff_default },
 	{ "pushnonffmatching", &advice_push_non_ff_matching },
@@ -23,6 +23,9 @@ static struct {
 	{ "resolveconflict", &advice_resolve_conflict },
 	{ "implicitidentity", &advice_implicit_identity },
 	{ "detachedhead", &advice_detached_head },
+
+	/* make this an alias for backward compatibility */
+	{ "pushnonfastforward", &advice_push_update_rejected }
 };
 
 void advise(const char *advice, ...)
diff --git a/advice.h b/advice.h
index f3cdbbf..c28ef8a 100644
--- a/advice.h
+++ b/advice.h
@@ -3,7 +3,7 @@
 
 #include "git-compat-util.h"
 
-extern int advice_push_nonfastforward;
+extern int advice_push_update_rejected;
 extern int advice_push_non_ff_current;
 extern int advice_push_non_ff_default;
 extern int advice_push_non_ff_matching;
diff --git a/builtin/push.c b/builtin/push.c
index 83a3cc8..cf5ecfa 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -226,21 +226,21 @@ static const char message_advice_ref_already_exists[] =
 
 static void advise_pull_before_push(void)
 {
-	if (!advice_push_non_ff_current || !advice_push_nonfastforward)
+	if (!advice_push_non_ff_current || !advice_push_update_rejected)
 		return;
 	advise(_(message_advice_pull_before_push));
 }
 
 static void advise_use_upstream(void)
 {
-	if (!advice_push_non_ff_default || !advice_push_nonfastforward)
+	if (!advice_push_non_ff_default || !advice_push_update_rejected)
 		return;
 	advise(_(message_advice_use_upstream));
 }
 
 static void advise_checkout_pull_push(void)
 {
-	if (!advice_push_non_ff_matching || !advice_push_nonfastforward)
+	if (!advice_push_non_ff_matching || !advice_push_update_rejected)
 		return;
 	advise(_(message_advice_checkout_pull_push));
 }
-- 
1.8.0.1.541.g73be2da

From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 10/10] push: switch default from "matching" to "simple"
Date: Fri,  4 Jan 2013 22:53:08 -0800
Message-ID: <1357368788-28035-11-git-send-email-gitster@pobox.com>
References: <1357368788-28035-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 05 07:54:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrNdt-0001Cn-JM
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 07:54:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754509Ab3AEGxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 01:53:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56571 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754352Ab3AEGxa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 01:53:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C90CD8D14
	for <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ZtKQ
	mi7IpAEEXcXFhzu4srKMTFA=; b=Sjo77/FfwphJA5QqK8QFLdSg/QlFZKKt87FA
	Im3zJPoZtAbYFH8xu8CH7XSp/D1HC5asWvyE/FxzLH0bEZzBK0+g4rT4l+NPswcW
	YqbxGElDlWkwle1oFjEOTKKFZ3l0S6AVDrTNu/ZyTPKIX9mD+Kz1hytwW7R0geNP
	04oxdmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=LKD64X
	kea3VEPd68X7sDdMD4td7Wgk8F8a1nwlGD8XHr7szLt1s7bSFaFmnRZ+iViLdXR+
	DjecJL+JmYvgtU593VczBjQfOHaPoeh6R6LyyrvjTjllaQSgb2rDFaCAZ7z2HGu4
	6hm/9zgnYKVK1Ao07KRv64HEu63sJZ9CHn7LE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B99C08D13
	for <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 191308D12 for
 <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:29 -0500 (EST)
X-Mailer: git-send-email 1.8.1.299.gc73b41f
In-Reply-To: <1357368788-28035-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9C775B7E-5704-11E2-9372-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212676>

We promised to change the behaviour of lazy "git push [there]" that
does not say what to push on the command line from "matching" to
"simple" in Git 2.0.

This finally flips that bit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |  6 +++---
 builtin/push.c           | 31 +++++++------------------------
 2 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bf8f911..770eefe 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1750,15 +1750,15 @@ push.default::
   since locally stalled branches will attempt a non-fast forward push
   if other users updated the branch.
   +
-  This is currently the default, but Git 2.0 will change the default
-  to `simple`.
+  This used to be the default, and stale web sites may still say so,
+  but Git 2.0 has changed the default to `simple`.
 * `upstream` - push the current branch to its upstream branch.
   With this, `git push` will update the same remote ref as the one which
   is merged by `git pull`, making `push` and `pull` symmetrical.
   See "branch.<name>.merge" for how to configure the upstream branch.
 * `simple` - like `upstream`, but refuses to push if the upstream
   branch's name is different from the local one. This is the safest
-  option and is well-suited for beginners. It will become the default
+  option and is well-suited for beginners. It has become the default
   in Git 2.0.
 * `current` - push the current branch to a branch of the same name.
 --
diff --git a/builtin/push.c b/builtin/push.c
index db9ba30..9f7c252 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -24,7 +24,6 @@ static int progress = -1;
 static const char **refspec;
 static int refspec_nr;
 static int refspec_alloc;
-static int default_matching_used;
 
 static void add_refspec(const char *ref)
 {
@@ -148,9 +147,9 @@ static void setup_push_upstream(struct remote *remote, int simple)
 }
 
 static char warn_unspecified_push_default_msg[] =
-N_("push.default is unset; its implicit value is changing in\n"
+N_("push.default is unset; its implicit value has changed in\n"
    "Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
-   "and maintain the current behavior after the default changes, use:\n"
+   "and maintain the traditional behavior, use:\n"
    "\n"
    "  git config --global push.default matching\n"
    "\n"
@@ -175,14 +174,14 @@ static void setup_default_push_refspecs(struct remote *remote)
 {
 	switch (push_default) {
 	default:
-	case PUSH_DEFAULT_UNSPECIFIED:
-		default_matching_used = 1;
-		warn_unspecified_push_default_configuration();
-		/* fallthru */
 	case PUSH_DEFAULT_MATCHING:
 		add_refspec(":");
 		break;
 
+	case PUSH_DEFAULT_UNSPECIFIED:
+		warn_unspecified_push_default_configuration();
+		/* fallthru */
+
 	case PUSH_DEFAULT_SIMPLE:
 		setup_push_upstream(remote, 1);
 		break;
@@ -208,12 +207,6 @@ static const char message_advice_pull_before_push[] =
 	   "before pushing again.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
-static const char message_advice_use_upstream[] =
-	N_("Updates were rejected because a pushed branch tip is behind its remote\n"
-	   "counterpart. If you did not intend to push that branch, you may want to\n"
-	   "specify branches to push or set the 'push.default' configuration variable\n"
-	   "to 'simple', 'current' or 'upstream' to push only the current branch.");
-
 static const char message_advice_checkout_pull_push[] =
 	N_("Updates were rejected because a pushed branch tip is behind its remote\n"
 	   "counterpart. Check out this branch and merge the remote changes\n"
@@ -227,13 +220,6 @@ static void advise_pull_before_push(void)
 	advise(_(message_advice_pull_before_push));
 }
 
-static void advise_use_upstream(void)
-{
-	if (!advice_push_non_ff_default || !advice_push_nonfastforward)
-		return;
-	advise(_(message_advice_use_upstream));
-}
-
 static void advise_checkout_pull_push(void)
 {
 	if (!advice_push_non_ff_matching || !advice_push_nonfastforward)
@@ -272,10 +258,7 @@ static int push_with_options(struct transport *transport, int flags)
 		advise_pull_before_push();
 		break;
 	case NON_FF_OTHER:
-		if (default_matching_used)
-			advise_use_upstream();
-		else
-			advise_checkout_pull_push();
+		advise_checkout_pull_push();
 		break;
 	}
 
-- 
1.8.1.299.gc73b41f

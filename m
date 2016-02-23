From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] push: shorten "push.default is unset" warning message
Date: Tue, 23 Feb 2016 14:59:04 +0000
Message-ID: <000001530ea408ed-2b71a34a-32bb-434c-bba5-fdac28193e9c-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 16:19:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYEkZ-0002gX-6n
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 16:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbcBWPTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 10:19:38 -0500
Received: from a6-247.smtp-out.eu-west-1.amazonses.com ([54.240.6.247]:52509
	"EHLO a6-247.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752555AbcBWPTh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2016 10:19:37 -0500
X-Greylist: delayed 1230 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Feb 2016 10:19:37 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1456239544;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=0481EHIxKBKXjYdVoh/n7vogJLWu1z3fRLVyf3VNLz4=;
	b=E3dLESrC6UMFvt/0wCBceq9fnGi0s4iIrMnIKDhZIoB/9n63EvSYHD8XVPxHuogR
	9OvJJXiFVGMhaU4iIdD9LlgtUHj/m7h05pheE7+2EkpmvSXvjEfQ/YXypWOkDrrEcjQ
	rQlW3+QcC8M34IQXB+wpBayA/DAYfylYDOMQBtwE=
X-SES-Outgoing: 2016.02.23-54.240.6.247
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287082>

From: Matthieu Moy <matthieu.moy@imag.fr>

The warning was purposely long, both to explain the situation properly
and to give a strong incentive to set push.default explicitly. This was
important before the 2.0 transition, and remained important for a while
after, so that new users get push.default explicitly in their
configuration and do not experience inconsistent behavior if they ever
used an older version of Git.

The warning has been there since version 1.8.0 (Oct 2012), hence we can
expect the vast majority of current Git users to have been exposed to
it, and most of them have already set push.default explicitly. The
switch from 'matching' to 'simple' was planned for 2.0 (May 2014), but
actually happened only for 2.3 (Feb 2015).

The warning is mostly seen by beginners, who have not set their
push.default configuration (yet). For many of them, the warning is
confusing because it talks about concepts that they have not learned and
asks them a choice that they are not able to make yet. See for example

  http://stackoverflow.com/questions/13148066/warning-push-default-is-unset-its-implicit-value-is-changing-in-git-2-0

(1260 votes for the question, 1824 for the answer as of writing)

Shorten the warning and mention only the way to remove the warning
without changing the behavior. Keep a pointer to the documentation so
that people willing to learn can still find the alternative behaviors
easily.

Eventually, the warning should be removed completely, but this can wait
a couple more releases or years.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/push.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 960ffc3..00eba2f 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -205,26 +205,12 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
 }
 
 static char warn_unspecified_push_default_msg[] =
-N_("push.default is unset; its implicit value has changed in\n"
-   "Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
-   "and maintain the traditional behavior, use:\n"
-   "\n"
-   "  git config --global push.default matching\n"
-   "\n"
-   "To squelch this message and adopt the new behavior now, use:\n"
+N_("push.default is unset; its default value has changed in Git 2.0 from\n"
+   "'matching' to 'simple'. To squelch this message and adopt the new behavior, use:\n"
    "\n"
    "  git config --global push.default simple\n"
    "\n"
-   "When push.default is set to 'matching', git will push local branches\n"
-   "to the remote branches that already exist with the same name.\n"
-   "\n"
-   "Since Git 2.0, Git defaults to the more conservative 'simple'\n"
-   "behavior, which only pushes the current branch to the corresponding\n"
-   "remote branch that 'git pull' uses to update the current branch.\n"
-   "\n"
-   "See 'git help config' and search for 'push.default' for further information.\n"
-   "(the 'simple' mode was introduced in Git 1.7.11. Use the similar mode\n"
-   "'current' instead of 'simple' if you sometimes use older versions of Git)");
+   "See 'git help config' and search for 'push.default' for further information.");
 
 static void warn_unspecified_push_default_configuration(void)
 {

--
https://github.com/git/git/pull/201

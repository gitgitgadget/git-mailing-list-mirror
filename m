From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] add: make "add -u/-A" update full tree without pathspec
 (step 2)
Date: Wed,  6 Apr 2011 18:16:35 -0700
Message-ID: <1302138996-10006-4-git-send-email-gitster@pobox.com>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 03:17:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7dqK-0006sC-FO
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 03:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757198Ab1DGBQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 21:16:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45084 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756123Ab1DGBQs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 21:16:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 35DF74C21
	for <git@vger.kernel.org>; Wed,  6 Apr 2011 21:18:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=DGNC
	+nYGOmIg/mm5MJVEjkPYMlE=; b=O6dMIYAViuD14Nbg+OHIBM/5cEouSf17fR/D
	jGo0n9SmIPOw1USV0HT51QkfRP23usG191EpF7XYNm35ndVvfI8wWNbXnrgiIrJX
	vzOZqKjFrDtqlVtVtERtNbV8I+UOSXAy7rUZaoy+GwEwv03hYDiCcBS4eLSm/eGB
	wb6NNUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=q+gDdE
	2c5AgGnsgbtTeRnAnlbFaGFdmQHihtb3Dg0fGcDVT0lAueFY22Bsz3d98/MZm87b
	YlIZ7BWUbDq/irU1Z4tga3Zu3cE2QBs1HP9CpyY78bI+HBHMsugKI+HRQofH1+Cc
	IaB9EShrIyL8PeugF85IpGyrhEdxCxtfhxEd0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 335FC4C20
	for <git@vger.kernel.org>; Wed,  6 Apr 2011 21:18:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8EF254C1E for
 <git@vger.kernel.org>; Wed,  6 Apr 2011 21:18:40 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.rc1
In-Reply-To: <1302138996-10006-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: F922321A-60B4-11E0-8E9C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171036>

Flip the default behaviour when "git add -u/-A" is run without a
pathspec from a subdirectory to tree-wide, and reword the advice
message.

We will need to keep the advice message for a while to help people
who skipped the 1.8.0 boundary.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/add.c         |    8 ++++----
 t/t2200-add-update.sh |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index f58d1cf..6e6cdc0 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -360,13 +360,13 @@ static int add_files(struct dir_struct *dir, int flags)
 }
 
 static const char *warn_add_uA_180_migration_msg[] = {
-	"In release 1.8.0, running 'git add -u' (or 'git add -A') from",
-	"a subdirectory without giving any pathspec WILL take effect",
+	"Since release 1.8.0, running 'git add -u' (or 'git add -A')",
+	"from a subdirectory without giving any pathspec takes effect",
 	"on the whole working tree, not just the part under the current",
 	"directory. Please make it a habit to add '.' when you want to",
 	"limit the operation to the current directory and below.",
 	"You can use ':/' at the end of the command to affect the operation",
-	"on the whole working tree.",
+	"on the whole working tree, if you want to be explicit.",
 };
 
 static int warn_180_migration(void)
@@ -374,7 +374,7 @@ static int warn_180_migration(void)
 	int i;
 	for (i = 0; i < ARRAY_SIZE(warn_add_uA_180_migration_msg); i++)
 		warning("%s", warn_add_uA_180_migration_msg[i]);
-	return 0; /* default to "no" (not tree-wide, i.e. local) */
+	return 1; /* default to "true" (tree-wide, i.e. not local) */
 }
 
 int cmd_add(int argc, const char **argv, const char *prefix)
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index f7711ba..a601394 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -91,7 +91,7 @@ test_expect_success 'update from a subdirectory without pathspec' '
 		git add -u 2>../expect.warning
 	) &&
 	git diff-files --name-only dir1 check >actual &&
-	echo check >expect &&
+	: >expect &&
 	test_cmp expect actual &&
 	grep warning expect.warning
 '
-- 
1.7.5.rc1

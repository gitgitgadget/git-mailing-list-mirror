From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] builtin/add.c: simplify boolean variables
Date: Sat,  9 Mar 2013 00:22:36 -0800
Message-ID: <1362817358-24356-2-git-send-email-gitster@pobox.com>
References: <1362817358-24356-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 09 09:23:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEF3m-0003sY-VY
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 09:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756548Ab3CIIWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 03:22:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48014 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365Ab3CIIWm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 03:22:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 826C79FAE
	for <git@vger.kernel.org>; Sat,  9 Mar 2013 03:22:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=zEUV
	MOlp6qdDHN0uXkXzI9+a1y8=; b=rDvM13skRDyB2cOZehwKcEpr5DPclwxYkbEx
	mEWaFcnNhhtxFYndNlb9Gr6HZBo2yTpgzOSvJhho4I3wVz+l6cMJvEQs2r4TgUZQ
	VA/ZC91bBgMq2dh9bkAIfQc3NBXX/VJ6os0qREpyBEwDT/FjXGyIJ5A4jtSUpr1D
	k6VuX3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=a9soWA
	kztTL2cKN52GN55UZ3JjiYaL/fSAwhrTXIh5sYB1YixYnz1TFLCo1OAiZbIQK9sN
	nbzxeucx7xhxUT69NbHu/rhJ4Ytr9PZvSN5AnaCSAMx55vMcXgL2I7Vp8iV7tYRy
	1IkK8Qz8+clQntp+tVxS912ooXT7lYFutWMx0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 777CB9FAD
	for <git@vger.kernel.org>; Sat,  9 Mar 2013 03:22:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EEF069FAC for
 <git@vger.kernel.org>; Sat,  9 Mar 2013 03:22:41 -0500 (EST)
X-Mailer: git-send-email 1.8.2-rc3-203-gc9aaab5
In-Reply-To: <1362817358-24356-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 830DBD62-8892-11E2-9F36-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217705>

Do not to explicitly initialize static variables to 0 and instead
let BSS take care of it.  Also use OPT_BOOL() to let the command
line arguments set these variables to 0 or 1, instead of the
deprecated OPT_BOOLEAN() aka OPT_COUNTUP().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/add.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 0dd014e..220321b 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -270,23 +270,23 @@ static struct lock_file lock_file;
 static const char ignore_error[] =
 N_("The following paths are ignored by one of your .gitignore files:\n");
 
-static int verbose = 0, show_only = 0, ignored_too = 0, refresh_only = 0;
-static int ignore_add_errors, addremove, intent_to_add, ignore_missing = 0;
+static int verbose, show_only, ignored_too, refresh_only;
+static int ignore_add_errors, addremove, intent_to_add, ignore_missing;
 
 static struct option builtin_add_options[] = {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
 	OPT__VERBOSE(&verbose, N_("be verbose")),
 	OPT_GROUP(""),
-	OPT_BOOLEAN('i', "interactive", &add_interactive, N_("interactive picking")),
-	OPT_BOOLEAN('p', "patch", &patch_interactive, N_("select hunks interactively")),
-	OPT_BOOLEAN('e', "edit", &edit_interactive, N_("edit current diff and apply")),
+	OPT_BOOL('i', "interactive", &add_interactive, N_("interactive picking")),
+	OPT_BOOL('p', "patch", &patch_interactive, N_("select hunks interactively")),
+	OPT_BOOL('e', "edit", &edit_interactive, N_("edit current diff and apply")),
 	OPT__FORCE(&ignored_too, N_("allow adding otherwise ignored files")),
-	OPT_BOOLEAN('u', "update", &take_worktree_changes, N_("update tracked files")),
-	OPT_BOOLEAN('N', "intent-to-add", &intent_to_add, N_("record only the fact that the path will be added later")),
-	OPT_BOOLEAN('A', "all", &addremove, N_("add changes from all tracked and untracked files")),
-	OPT_BOOLEAN( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
-	OPT_BOOLEAN( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
-	OPT_BOOLEAN( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
+	OPT_BOOL('u', "update", &take_worktree_changes, N_("update tracked files")),
+	OPT_BOOL('N', "intent-to-add", &intent_to_add, N_("record only the fact that the path will be added later")),
+	OPT_BOOL('A', "all", &addremove, N_("add changes from all tracked and untracked files")),
+	OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
+	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
+	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
 	OPT_END(),
 };
 
-- 
1.8.2-rc3-203-gc9aaab5

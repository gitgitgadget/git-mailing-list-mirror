From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/7] builtin/notes.c: mark file-scope functions as static
Date: Sat, 15 Sep 2012 14:10:46 -0700
Message-ID: <1347743452-2487-1-git-send-email-gitster@pobox.com>
References: <5054AA62.2040603@ramsay1.demon.co.uk>
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 23:11:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCzdr-0004pG-Nr
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 23:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370Ab2IOVK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 17:10:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61750 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542Ab2IOVKz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 17:10:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89D858551;
	Sat, 15 Sep 2012 17:10:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=FerU
	yjPGrZk1vntr/+S3+arxxAI=; b=wm97d2FGPeUUyVeXAszUWfF59pK/vfXw8aBq
	WucpSh0iDNtzg3X/icgLga7dpI/XKouYibYKsVMJnsKorEBS5AECmSa2vmlOn+mu
	bNph84j6mbqHwnuSWBGbPTABcxVBW55ruvYlWSs5l2w9tfvh2Qn+nqA5f8JwHQGi
	BrlKnN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	KHJAvKJIAY18EKIM8LLBIGxFUn575aW4f+vcsVplzJl/kM4DJXLmrUZMsrmllh8c
	XQLC4nR+6Xe7n6aRFir5Pt52+9GdTg4jbbbKsoEf3SbgS9dPVnC289nplBK+OUj8
	Y0JFBEoRgClhpvNmzYupZwpWFz0+ZE7ueFy29kDOKkM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76D0C8550;
	Sat, 15 Sep 2012 17:10:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB2C48545; Sat, 15 Sep 2012
 17:10:53 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.508.g4d78187
In-Reply-To: <5054AA62.2040603@ramsay1.demon.co.uk>
X-Pobox-Relay-ID: D5A64492-FF79-11E1-AF63-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205574>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin.h       | 2 --
 builtin/notes.c | 7 +++++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin.h b/builtin.h
index 8e37752..95116b8 100644
--- a/builtin.h
+++ b/builtin.h
@@ -21,7 +21,6 @@ struct fmt_merge_msg_opts {
 
 extern int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 			 struct fmt_merge_msg_opts *);
-extern void commit_notes(struct notes_tree *t, const char *msg);
 
 struct notes_rewrite_cfg {
 	struct notes_tree **trees;
@@ -33,7 +32,6 @@ struct notes_rewrite_cfg {
 	int mode_from_env;
 };
 
-combine_notes_fn parse_combine_notes_fn(const char *v);
 struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd);
 int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
 			  const unsigned char *from_obj, const unsigned char *to_obj);
diff --git a/builtin/notes.c b/builtin/notes.c
index 554c801..453457a 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -19,6 +19,9 @@
 #include "string-list.h"
 #include "notes-merge.h"
 
+static void commit_notes(struct notes_tree *t, const char *msg);
+static combine_notes_fn parse_combine_notes_fn(const char *v);
+
 static const char * const git_notes_usage[] = {
 	N_("git notes [--ref <notes_ref>] [list [<object>]]"),
 	N_("git notes [--ref <notes_ref>] add [-f] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
@@ -288,7 +291,7 @@ static int parse_reedit_arg(const struct option *opt, const char *arg, int unset
 	return parse_reuse_arg(opt, arg, unset);
 }
 
-void commit_notes(struct notes_tree *t, const char *msg)
+static void commit_notes(struct notes_tree *t, const char *msg)
 {
 	struct strbuf buf = STRBUF_INIT;
 	unsigned char commit_sha1[20];
@@ -312,7 +315,7 @@ void commit_notes(struct notes_tree *t, const char *msg)
 	strbuf_release(&buf);
 }
 
-combine_notes_fn parse_combine_notes_fn(const char *v)
+static combine_notes_fn parse_combine_notes_fn(const char *v)
 {
 	if (!strcasecmp(v, "overwrite"))
 		return combine_notes_overwrite;
-- 
1.7.12.508.g4d78187

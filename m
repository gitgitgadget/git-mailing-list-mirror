Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5306E1366
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 05:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KSQlJstU"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FBFBD
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 22:10:38 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 43A7C1AFC66;
	Mon, 30 Oct 2023 01:10:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=kAwq7cZCCVUHGItbMramBrPNx
	eGQACRZ+s5EM1eNJj0=; b=KSQlJstUyUrQhCVHQ7e4SVXdi8CnAwD6wl+vTpYJK
	2zNrCIZFyLCUFHrONYtIK7o77kG5ZKs4DuUrhkWb5OxLoHsO+HfiwwY3zZLTFocs
	/y23eHYhFmr0jJpC+KZo7xUpZiRNZHsS2WhrxYC91ibKCZpGy+rLDXQ3o7dBuK3U
	O8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3AC741AFC65;
	Mon, 30 Oct 2023 01:10:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 876761AFC63;
	Mon, 30 Oct 2023 01:10:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/2] strbuf_commented_addf(): drop the comment_line_char parameter
Date: Mon, 30 Oct 2023 14:10:33 +0900
Message-ID: <20231030051034.2295242-2-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-526-g3130c155df
In-Reply-To: <20231030051034.2295242-1-gitster@pobox.com>
References: <20231030051034.2295242-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 A9A20A1A-76E2-11EE-9B37-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

All the callers of this function supply the global variable
comment_line_char as an argument to its second parameter.  Remove
the parameter to allow us in the future to change the reference to
the global variable with something else, like a function call.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 add-patch.c          | 8 ++++----
 builtin/branch.c     | 2 +-
 builtin/merge.c      | 8 ++++----
 builtin/tag.c        | 4 ++--
 rebase-interactive.c | 2 +-
 sequencer.c          | 4 ++--
 strbuf.c             | 3 ++-
 strbuf.h             | 4 ++--
 wt-status.c          | 2 +-
 9 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index bfe19876cd..471a0037be 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1106,11 +1106,11 @@ static int edit_hunk_manually(struct add_p_state =
*s, struct hunk *hunk)
 	size_t i;
=20
 	strbuf_reset(&s->buf);
-	strbuf_commented_addf(&s->buf, comment_line_char,
+	strbuf_commented_addf(&s->buf,
 			      _("Manual hunk edit mode -- see bottom for "
 				"a quick guide.\n"));
 	render_hunk(s, hunk, 0, 0, &s->buf);
-	strbuf_commented_addf(&s->buf, comment_line_char,
+	strbuf_commented_addf(&s->buf,
 			      _("---\n"
 				"To remove '%c' lines, make them ' ' lines "
 				"(context).\n"
@@ -1119,13 +1119,13 @@ static int edit_hunk_manually(struct add_p_state =
*s, struct hunk *hunk)
 			      s->mode->is_reverse ? '+' : '-',
 			      s->mode->is_reverse ? '-' : '+',
 			      comment_line_char);
-	strbuf_commented_addf(&s->buf, comment_line_char, "%s",
+	strbuf_commented_addf(&s->buf, "%s",
 			      _(s->mode->edit_hunk_hint));
 	/*
 	 * TRANSLATORS: 'it' refers to the patch mentioned in the previous
 	 * messages.
 	 */
-	strbuf_commented_addf(&s->buf, comment_line_char,
+	strbuf_commented_addf(&s->buf,
 			      _("If it does not apply cleanly, you will be "
 				"given an opportunity to\n"
 				"edit again.  If all lines of the hunk are "
diff --git a/builtin/branch.c b/builtin/branch.c
index 2ec190b14a..b2f171e10b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -668,7 +668,7 @@ static int edit_branch_description(const char *branch=
_name)
 	exists =3D !read_branch_desc(&buf, branch_name);
 	if (!buf.len || buf.buf[buf.len-1] !=3D '\n')
 		strbuf_addch(&buf, '\n');
-	strbuf_commented_addf(&buf, comment_line_char,
+	strbuf_commented_addf(&buf,
 		    _("Please edit the description for the branch\n"
 		      "  %s\n"
 		      "Lines starting with '%c' will be stripped.\n"),
diff --git a/builtin/merge.c b/builtin/merge.c
index d748d46e13..8f0e8be7c3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -857,15 +857,15 @@ static void prepare_to_commit(struct commit_list *r=
emoteheads)
 		strbuf_addch(&msg, '\n');
 		if (cleanup_mode =3D=3D COMMIT_MSG_CLEANUP_SCISSORS) {
 			wt_status_append_cut_line(&msg);
-			strbuf_commented_addf(&msg, comment_line_char, "\n");
+			strbuf_commented_addf(&msg, "\n");
 		}
-		strbuf_commented_addf(&msg, comment_line_char,
+		strbuf_commented_addf(&msg,
 				      _(merge_editor_comment));
 		if (cleanup_mode =3D=3D COMMIT_MSG_CLEANUP_SCISSORS)
-			strbuf_commented_addf(&msg, comment_line_char,
+			strbuf_commented_addf(&msg,
 					      _(scissors_editor_comment));
 		else
-			strbuf_commented_addf(&msg, comment_line_char,
+			strbuf_commented_addf(&msg,
 				_(no_scissors_editor_comment), comment_line_char);
 	}
 	if (signoff)
diff --git a/builtin/tag.c b/builtin/tag.c
index 3918eacbb5..a85a0d8def 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -314,10 +314,10 @@ static void create_tag(const struct object_id *obje=
ct, const char *object_ref,
 			struct strbuf buf =3D STRBUF_INIT;
 			strbuf_addch(&buf, '\n');
 			if (opt->cleanup_mode =3D=3D CLEANUP_ALL)
-				strbuf_commented_addf(&buf, comment_line_char,
+				strbuf_commented_addf(&buf,
 				      _(tag_template), tag, comment_line_char);
 			else
-				strbuf_commented_addf(&buf, comment_line_char,
+				strbuf_commented_addf(&buf,
 				      _(tag_template_nocleanup), tag, comment_line_char);
 			write_or_die(fd, buf.buf, buf.len);
 			strbuf_release(&buf);
diff --git a/rebase-interactive.c b/rebase-interactive.c
index d9718409b3..3f33da7f03 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -71,7 +71,7 @@ void append_todo_help(int command_count,
=20
 	if (!edit_todo) {
 		strbuf_addch(buf, '\n');
-		strbuf_commented_addf(buf, comment_line_char,
+		strbuf_commented_addf(buf,
 				      Q_("Rebase %s onto %s (%d command)",
 					 "Rebase %s onto %s (%d commands)",
 					 command_count),
diff --git a/sequencer.c b/sequencer.c
index d584cac8ed..5d348a3f12 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -675,11 +675,11 @@ void append_conflicts_hint(struct index_state *ista=
te,
 	}
=20
 	strbuf_addch(msgbuf, '\n');
-	strbuf_commented_addf(msgbuf, comment_line_char, "Conflicts:\n");
+	strbuf_commented_addf(msgbuf, "Conflicts:\n");
 	for (i =3D 0; i < istate->cache_nr;) {
 		const struct cache_entry *ce =3D istate->cache[i++];
 		if (ce_stage(ce)) {
-			strbuf_commented_addf(msgbuf, comment_line_char,
+			strbuf_commented_addf(msgbuf,
 					      "\t%s\n", ce->name);
 			while (i < istate->cache_nr &&
 			       !strcmp(ce->name, istate->cache[i]->name))
diff --git a/strbuf.c b/strbuf.c
index 7827178d8e..15550b2619 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex-ll.h"
 #include "strbuf.h"
@@ -372,7 +373,7 @@ void strbuf_add_commented_lines(struct strbuf *out, c=
onst char *buf,
 	add_lines(out, prefix1, prefix2, buf, size);
 }
=20
-void strbuf_commented_addf(struct strbuf *sb, char comment_line_char,
+void strbuf_commented_addf(struct strbuf *sb,
 			   const char *fmt, ...)
 {
 	va_list params;
diff --git a/strbuf.h b/strbuf.h
index e959caca87..981617dc77 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -378,8 +378,8 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, =
...);
  * Add a formatted string prepended by a comment character and a
  * blank to the buffer.
  */
-__attribute__((format (printf, 3, 4)))
-void strbuf_commented_addf(struct strbuf *sb, char comment_line_char, co=
nst char *fmt, ...);
+__attribute__((format (printf, 2, 3)))
+void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...);
=20
 __attribute__((format (printf,2,0)))
 void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
diff --git a/wt-status.c b/wt-status.c
index 9f45bf6949..54b2775730 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1102,7 +1102,7 @@ void wt_status_append_cut_line(struct strbuf *buf)
 {
 	const char *explanation =3D _("Do not modify or remove the line above.\=
nEverything below it will be ignored.");
=20
-	strbuf_commented_addf(buf, comment_line_char, "%s", cut_line);
+	strbuf_commented_addf(buf, "%s", cut_line);
 	strbuf_add_commented_lines(buf, explanation, strlen(explanation), comme=
nt_line_char);
 }
=20
--=20
2.42.0-526-g3130c155df


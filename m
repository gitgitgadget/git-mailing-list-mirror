From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] pretty-print: add --pretty=noexpand
Date: Thu, 17 Mar 2016 16:16:21 -0700
Message-ID: <xmqqoaacy9tm.fsf_-_@gitster.mtv.corp.google.com>
References: <alpine.LFD.2.20.1603160926060.13030@i7>
	<xmqq7fh25mkc.fsf@gitster.mtv.corp.google.com>
	<CA+55aFxV5PWdSn9Gj=zV464TtJo=QvciZrhc5Pwe+Qfyqt8sXw@mail.gmail.com>
	<xmqqwpp243sb.fsf@gitster.mtv.corp.google.com>
	<xmqqoaae4340.fsf@gitster.mtv.corp.google.com>
	<CA+55aFwbNXJnwEYrKE5dDRk_6eZeGT6Z11uSQS8RmCSq43PkdA@mail.gmail.com>
	<xmqqk2l23xzc.fsf@gitster.mtv.corp.google.com>
	<CA+55aFwbev52kTV1wNMTsxR3kWvhXxTkjVy-KQOEO_2jX3RrAQ@mail.gmail.com>
	<xmqq37rozoic.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 18 00:16:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agh9a-0002Op-H6
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 00:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030916AbcCQXQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 19:16:26 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934758AbcCQXQY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 19:16:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA9304CCB5;
	Thu, 17 Mar 2016 19:16:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T0YHRkXxFT3vSFIkcfvJuhy0GM8=; b=gkDfVS
	YswFJTTvxw/fQv/VZQ9/b+iP/gY0866WsoJ9PJYFKbh2BX4m3qZUIFaTgRQztbrr
	aQmfu8FA8aIwlMgVBkS6SJOWzuBDImwypzaqdDfUOevFtQlZ3jNkZ9VJvMgNm3KY
	XYkCRD9GHhgFZuEF5IisYZWrS3loEY8qjbBZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UAWERVMwmD6eOnuxrblI2YCR8tRC7bg/
	vU+5oMAeFtXBPX7IcZalcnlTXpJB7ULHskbF0U16kvh5xq+2GEu7ziDHClxqwd0W
	5lCAQT1s7Mt1VG8BxBPY5oEB/8l9+pU/Z7wPXiFjHrstkwuI4sIe3VcsdBO1ftlU
	GpXeBV35xF8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B192B4CCB4;
	Thu, 17 Mar 2016 19:16:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 330ED4CCB3;
	Thu, 17 Mar 2016 19:16:23 -0400 (EDT)
In-Reply-To: <xmqq37rozoic.fsf_-_@gitster.mtv.corp.google.com> (Junio
	C. Hamano's message of "Thu, 17 Mar 2016 16:13:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 43D9A5DC-EC96-11E5-8410-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289169>

It is reasonable for tweak the default output mode for "git log" to
untabify the commit log message, it sometimes may be necessary to
see the output without tab expansion.

Invent a new --pretty option to do this.  Use this to unbreak the
test breakages, where "git shortlog" and output are tested.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/pretty-formats.txt | 10 ++++++++++
 Documentation/pretty-options.txt |  2 +-
 commit.h                         |  1 +
 pretty.c                         | 12 +++++++++---
 t/t4201-shortlog.sh              |  6 +++---
 5 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 671cebd..173b932 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -39,6 +39,16 @@ This is designed to be as compact as possible.
 
 	      <title line>
 
+	      <full commit message, tab-expanded>
+
+* 'noexpand'
+
+	  commit <sha1>
+	  Author: <author>
+	  Date:   <author date>
+
+	      <title line>
+
 	      <full commit message>
 
 * 'full'
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 4b659ac..7032b1a 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -3,7 +3,7 @@
 
 	Pretty-print the contents of the commit logs in a given format,
 	where '<format>' can be one of 'oneline', 'short', 'medium',
-	'full', 'fuller', 'email', 'raw', 'format:<string>'
+	'full', 'fuller', 'email', 'raw', 'noexpand', 'format:<string>'
 	and 'tformat:<string>'.  When '<format>' is none of the above,
 	and has '%placeholder' in it, it acts as if
 	'--pretty=tformat:<format>' were given.
diff --git a/commit.h b/commit.h
index 5d58be0..d511c61 100644
--- a/commit.h
+++ b/commit.h
@@ -126,6 +126,7 @@ enum cmit_fmt {
 	CMIT_FMT_RAW,
 	CMIT_FMT_MEDIUM,
 	CMIT_FMT_DEFAULT = CMIT_FMT_MEDIUM,
+	CMIT_FMT_NOEXPAND,
 	CMIT_FMT_SHORT,
 	CMIT_FMT_FULL,
 	CMIT_FMT_FULLER,
diff --git a/pretty.c b/pretty.c
index 717ceed..8b533dc 100644
--- a/pretty.c
+++ b/pretty.c
@@ -89,6 +89,7 @@ static void setup_commit_formats(void)
 	struct cmt_fmt_map builtin_formats[] = {
 		{ "raw",	CMIT_FMT_RAW,		0 },
 		{ "medium",	CMIT_FMT_MEDIUM,	0 },
+		{ "noexpand",	CMIT_FMT_NOEXPAND,	0 },
 		{ "short",	CMIT_FMT_SHORT,		0 },
 		{ "email",	CMIT_FMT_EMAIL,		0 },
 		{ "fuller",	CMIT_FMT_FULLER,	0 },
@@ -1685,11 +1686,16 @@ static void strbuf_add_tabexpand(struct strbuf *sb,
  * the whole line (without the final newline), after
  * de-tabifying.
  */
-static void pp_handle_indent(struct strbuf *sb, int indent,
+static void pp_handle_indent(struct pretty_print_context *pp,
+			     struct strbuf *sb,
+			     int indent,
 			     const char *line, int linelen)
 {
 	strbuf_addchars(sb, ' ', indent);
-	strbuf_add_tabexpand(sb, line, linelen);
+	if (pp->fmt == CMIT_FMT_MEDIUM)
+		strbuf_add_tabexpand(sb, line, linelen);
+	else
+		strbuf_add(sb, line, linelen);
 }
 
 void pp_remainder(struct pretty_print_context *pp,
@@ -1716,7 +1722,7 @@ void pp_remainder(struct pretty_print_context *pp,
 
 		strbuf_grow(sb, linelen + indent + 20);
 		if (indent)
-			pp_handle_indent(sb, indent, line, linelen);
+			pp_handle_indent(pp, sb, indent, line, linelen);
 		else
 			strbuf_add(sb, line, linelen);
 		strbuf_addch(sb, '\n');
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 987b708..34a9fed 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -93,7 +93,7 @@ test_expect_success 'output from user-defined format is re-wrapped' '
 	test_cmp expect log.predictable
 '
 
-test_expect_failure !MINGW 'shortlog wrapping' '
+test_expect_success !MINGW 'shortlog wrapping' '
 	cat >expect <<\EOF &&
 A U Thor (5):
       Test
@@ -114,8 +114,8 @@ EOF
 	test_cmp expect out
 '
 
-test_expect_failure !MINGW 'shortlog from non-git directory' '
-	git log HEAD >log &&
+test_expect_success !MINGW 'shortlog from non-git directory' '
+	git log --pretty=noexpand HEAD >log &&
 	GIT_DIR=non-existing git shortlog -w <log >out &&
 	test_cmp expect out
 '
-- 
2.8.0-rc3-175-g64dcf62

From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] check-ignore: the name of the character is NUL, not NULL
Date: Thu, 11 Jul 2013 23:18:44 -0700
Message-ID: <1373609927-3244-2-git-send-email-gitster@pobox.com>
References: <1373609927-3244-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 08:19:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxWgx-0006km-JM
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 08:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934Ab3GLGSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 02:18:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36852 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480Ab3GLGSv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 02:18:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E93CF2B4E2
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 06:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=z7S0
	S6Gdahy0NCEf/WNXcHEMk/I=; b=uJWO/TKnyRMyMbOn6D24kvYu1dLLGjkFcBQ5
	Id15PxZqCvCioWU+SqdXjoTirx8Sxcftd2cAi+8+/7rrbI9RvAHrwVRKXKMhA84t
	48Zs2umPFeQW/E6YuJtI97CyQnAujACLHITkbplmLiKscEBvpuO3aS5GpHTozEET
	n52mEMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=nyVx37
	TNFvPRpK4fGqoKakZNxN6jiveg0p5znsjVyQztDpaw/6fk/VIbye4KBIz4EYsmhn
	cWoxbqClrITAXudVu8VynQ+CoTLGU6aUiXnxeITqfH+99FR8x6Hd1b6QlYO62mRQ
	y7tUy9gXhCdSaOL1AXlD3ySh2laH2t2fM57Ac=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0AB02B4E1
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 06:18:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56C1D2B4DD
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 06:18:50 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-911-g2c4daa5
In-Reply-To: <1373609927-3244-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: EB191278-EABA-11E2-8228-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230167>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/check-ignore.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 0240f99..be22bce 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -12,7 +12,7 @@ static const char * const check_ignore_usage[] = {
 NULL
 };
 
-static int null_term_line;
+static int nul_term_line;
 
 static const struct option check_ignore_options[] = {
 	OPT__QUIET(&quiet, N_("suppress progress reporting")),
@@ -20,8 +20,8 @@ static const struct option check_ignore_options[] = {
 	OPT_GROUP(""),
 	OPT_BOOLEAN(0, "stdin", &stdin_paths,
 		    N_("read file names from stdin")),
-	OPT_BOOLEAN('z', NULL, &null_term_line,
-		    N_("input paths are terminated by a null character")),
+	OPT_BOOLEAN('z', NULL, &nul_term_line,
+		    N_("input paths are terminated by a NUL character")),
 	OPT_END()
 };
 
@@ -29,7 +29,7 @@ static void output_exclude(const char *path, struct exclude *exclude)
 {
 	char *bang  = exclude->flags & EXC_FLAG_NEGATIVE  ? "!" : "";
 	char *slash = exclude->flags & EXC_FLAG_MUSTBEDIR ? "/" : "";
-	if (!null_term_line) {
+	if (!nul_term_line) {
 		if (!verbose) {
 			write_name_quoted(path, stdout, '\n');
 		} else {
@@ -111,7 +111,7 @@ static int check_ignore_stdin_paths(const char *prefix)
 	struct strbuf buf, nbuf;
 	char **pathspec = NULL;
 	size_t nr = 0, alloc = 0;
-	int line_termination = null_term_line ? 0 : '\n';
+	int line_termination = nul_term_line ? 0 : '\n';
 	int num_ignored;
 
 	strbuf_init(&buf, 0);
@@ -150,7 +150,7 @@ int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 		if (argc > 0)
 			die(_("cannot specify pathnames with --stdin"));
 	} else {
-		if (null_term_line)
+		if (nul_term_line)
 			die(_("-z only makes sense with --stdin"));
 		if (argc == 0)
 			die(_("no path specified"));
-- 
1.8.3.2-911-g2c4daa5

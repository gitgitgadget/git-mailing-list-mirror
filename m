From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/7] builtin/log.c: drop redundant "numbered_files" parameter
 from make_cover_letter()
Date: Sat, 22 Dec 2012 00:33:27 -0800
Message-ID: <1356165212-5611-3-git-send-email-gitster@pobox.com>
References: <1356165212-5611-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 09:34:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmKWz-0007tg-Of
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 09:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188Ab2LVIdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 03:33:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64845 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181Ab2LVIdi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 03:33:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18B3C8281
	for <git@vger.kernel.org>; Sat, 22 Dec 2012 03:33:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=FRQe
	QT2rnWT4gPKsLn/xS4N7esY=; b=DmM6neY1BRPRokS/f1pJf+u5xKGF5RCEX6O5
	W/qAiEEzU8TuGobWQjrWvPRpcCO1KX17zR4SNw4avzzgyI36GaLhL1+T16TzhlzE
	lg1MHkWlhNcwqpUuKWwTRm1n2ZYAqmoNI0TJFgZ0/9GkQRwQBf9O6GoSXEzaKK1W
	iEQuDVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=b+ub97
	+2EJGmeR+ORYZBGTitZ6711QKOcI1RHSIX4enGJsHpyq/8zvj1V31x64FK5Zj3Gh
	5XIrWuT6RBuuQxtdn5OMbEKGOpUVsC4uUI2arf0hJnAcOCSMPSBIzl8sZpW1uMSC
	jPqeJ4IWeC3sjBCrwoX9wZkTTjklGOEf73Ib4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 070568280
	for <git@vger.kernel.org>; Sat, 22 Dec 2012 03:33:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85FF0827F for
 <git@vger.kernel.org>; Sat, 22 Dec 2012 03:33:37 -0500 (EST)
X-Mailer: git-send-email 1.8.1.rc2.227.g7335c9f
In-Reply-To: <1356165212-5611-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 47FEF19E-4C12-11E2-8681-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212039>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 28d9063..f1d086e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -768,7 +768,6 @@ static void add_branch_description(struct strbuf *buf, const char *branch_name)
 }
 
 static void make_cover_letter(struct rev_info *rev, int use_stdout,
-			      int numbered_files,
 			      struct commit *origin,
 			      int nr, struct commit **list, struct commit *head,
 			      const char *branch_name,
@@ -791,7 +790,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	committer = git_committer_info(0);
 
 	if (!use_stdout &&
-	    reopen_stdout(NULL, numbered_files ? NULL : "cover-letter", rev, quiet))
+	    reopen_stdout(NULL, rev->numbered_files ? NULL : "cover-letter", rev, quiet))
 		return;
 
 	log_write_email_headers(rev, head, &pp.subject, &pp.after_subject,
@@ -1045,7 +1044,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int nr = 0, total, i;
 	int use_stdout = 0;
 	int start_number = -1;
-	int numbered_files = 0;		/* _just_ numbers */
+	int just_numbers = 0;
 	int ignore_if_in_upstream = 0;
 	int cover_letter = 0;
 	int boundary_count = 0;
@@ -1070,7 +1069,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    N_("print patches to standard out")),
 		OPT_BOOLEAN(0, "cover-letter", &cover_letter,
 			    N_("generate a cover letter")),
-		OPT_BOOLEAN(0, "numbered-files", &numbered_files,
+		OPT_BOOLEAN(0, "numbered-files", &just_numbers,
 			    N_("use simple number sequence for output file names")),
 		OPT_STRING(0, "suffix", &fmt_patch_suffix, N_("sfx"),
 			    N_("use <sfx> instead of '.patch'")),
@@ -1338,12 +1337,12 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		const char *msgid = clean_message_id(in_reply_to);
 		string_list_append(rev.ref_message_ids, msgid);
 	}
-	rev.numbered_files = numbered_files;
+	rev.numbered_files = just_numbers;
 	rev.patch_suffix = fmt_patch_suffix;
 	if (cover_letter) {
 		if (thread)
 			gen_message_id(&rev, "cover");
-		make_cover_letter(&rev, use_stdout, numbered_files,
+		make_cover_letter(&rev, use_stdout,
 				  origin, nr, list, head, branch_name, quiet);
 		total++;
 		start_number--;
@@ -1390,7 +1389,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		}
 
 		if (!use_stdout &&
-		    reopen_stdout(numbered_files ? NULL : commit, NULL, &rev, quiet))
+		    reopen_stdout(rev.numbered_files ? NULL : commit, NULL, &rev, quiet))
 			die(_("Failed to create output files"));
 		shown = log_tree_commit(&rev, commit);
 		free(commit->buffer);
-- 
1.8.0.6.gd28b5d4.dirty

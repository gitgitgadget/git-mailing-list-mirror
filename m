From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/6] diff: remove "diff-files -q" at Git 2.0 version boundary
Date: Thu, 18 Jul 2013 20:20:37 -0700
Message-ID: <7vvc47z14q.fsf_-_@alter.siamese.dyndns.org>
References: <7vvc496ruf.fsf@alter.siamese.dyndns.org>
	<1374107406-14357-1-git-send-email-gitster@pobox.com>
	<1374107406-14357-7-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 19 05:20:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V01FO-0001DS-Kd
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 05:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933493Ab3GSDUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 23:20:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62261 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759599Ab3GSDUl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 23:20:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FE2D264A9;
	Fri, 19 Jul 2013 03:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=73Lr5FRRsFW2loNlJZuu2ugff3w=; b=j0JOqL
	hN11sTFdFC4JEEDQEvTBwEf02c8d0L1X0cOKz6ei6uOyaULFVaZzX5s0G8n4/WJK
	c4tOn4yc8JNi4SLD2pieXqv76f42vnnPX6Zb8xFZhJ3dGYwWaqZavv4NTWLjjA1c
	Hf5d03rF9nixwLhCxArWXIvoe5PlT+xXRIR5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H+frIdPTA40uhMhNudjcyke55ZpiM0zd
	zLygm9XP6jMeXUmKIjVvS37xCBQQrZOZ5n+EGbFbBaDkB4YeUDsg6GTu9kNIIHkW
	qdaqdhvSxVILCDv3v4XWghSYAj+ZR6loTY6vLdqbclzKuJXusXtax0bi7Jplz5h5
	ifCVQorlg9A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52917264A8;
	Fri, 19 Jul 2013 03:20:40 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44C92264A7;
	Fri, 19 Jul 2013 03:20:39 +0000 (UTC)
In-Reply-To: <1374107406-14357-7-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Wed, 17 Jul 2013 17:30:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F9CDD28-F022-11E2-9E91-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230775>

This was inherited from "show-diff -q" that was invented to tell
comparison between the index and the working tree to ignore only
removals in 2005.

These days, it is spelled as "--diff-filter=d".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * And this is the endgame.

 diff-lib.c      | 3 ---
 diff-no-index.c | 8 --------
 diff.c          | 8 --------
 diff.h          | 2 --
 4 files changed, 21 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 4634b29..872643f 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -89,9 +89,6 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 	unsigned ce_option = ((option & DIFF_RACY_IS_MODIFIED)
 			      ? CE_MATCH_RACY_IS_DIRTY : 0);
 
-	if (option & DIFF_SILENT_ON_REMOVED)
-		handle_deprecated_show_diff_q(&revs->diffopt);
-
 	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
 
 	if (diff_unmerged_stage < 0)
diff --git a/diff-no-index.c b/diff-no-index.c
index a788a5f..98a9cf1 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -187,7 +187,6 @@ void diff_no_index(struct rev_info *revs,
 {
 	int i, prefixlen;
 	int no_index = 0;
-	unsigned deprecated_show_diff_q_option_used = 0;
 	const char *paths[2];
 
 	/* Were we asked to do --no-index explicitly? */
@@ -224,10 +223,6 @@ void diff_no_index(struct rev_info *revs,
 		int j;
 		if (!strcmp(argv[i], "--no-index"))
 			i++;
-		else if (!strcmp(argv[i], "-q")) {
-			deprecated_show_diff_q_option_used = 1;
-			i++;
-		}
 		else if (!strcmp(argv[i], "--"))
 			i++;
 		else {
@@ -260,9 +255,6 @@ void diff_no_index(struct rev_info *revs,
 	revs->max_count = -2;
 	diff_setup_done(&revs->diffopt);
 
-	if (deprecated_show_diff_q_option_used)
-		handle_deprecated_show_diff_q(&revs->diffopt);
-
 	setup_diff_pager(&revs->diffopt);
 	DIFF_OPT_SET(&revs->diffopt, EXIT_WITH_STATUS);
 
diff --git a/diff.c b/diff.c
index 78819ba..2d0b5e3 100644
--- a/diff.c
+++ b/diff.c
@@ -3570,14 +3570,6 @@ static int parse_diff_filter_opt(const char *optarg, struct diff_options *opt)
 	return 0;
 }
 
-/* Used only by "diff-files" and "diff --no-index" */
-void handle_deprecated_show_diff_q(struct diff_options *opt)
-{
-	warning("'diff -q' and 'diff-files -q' are deprecated.");
-	warning("Use 'diff --diff-filter=d' instead to ignore deleted filepairs.");
-	parse_diff_filter_opt("d", opt);
-}
-
 int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 {
 	const char *arg = av[0];
diff --git a/diff.h b/diff.h
index 5237d63..a367207 100644
--- a/diff.h
+++ b/diff.h
@@ -341,8 +341,6 @@ extern int parse_rename_score(const char **cp_p);
 
 extern long parse_algorithm_value(const char *value);
 
-extern void handle_deprecated_show_diff_q(struct diff_options *);
-
 extern int print_stat_summary(FILE *fp, int files,
 			      int insertions, int deletions);
 extern void setup_diff_pager(struct diff_options *);
-- 
1.8.3.3-1001-gcfc78f3

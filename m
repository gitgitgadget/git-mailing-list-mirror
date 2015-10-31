From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 5/5] wt-status: use skip_prefix() to get rid of magic string
 length constants
Date: Sat, 31 Oct 2015 18:37:43 +0100
Message-ID: <5634FC67.20001@web.de>
References: <5634FB59.1000506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 31 18:37:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zsa6D-0004V1-1q
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 18:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbbJaRht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 13:37:49 -0400
Received: from mout.web.de ([212.227.17.11]:51754 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639AbbJaRhs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 13:37:48 -0400
Received: from [192.168.178.36] ([79.253.163.201]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Lh6QF-1aE7Cg13JP-00oUQE; Sat, 31 Oct 2015 18:37:45
 +0100
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <5634FB59.1000506@web.de>
X-Provags-ID: V03:K0:/20itrd8Yo1UYzyOCnJ7oYfg5hjTbaMtFQYBxDYjfIdVdWnfyJy
 ESVWDaGMvQ+nzF+v4pfBWaXWkStVDfjlSMyATJ2dtN+kDzYRAC2o8ADkcI5ezyGgkis4l++
 sTpUPcHl+qmjhrruJ/eDf+nqiI+e0aBCfEBrrFcUU0YdvNKixryB8nQ1tlUOgFp4aKOB7JV
 2tQEi5fOYtAy72aZhTWEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:u916P0xAo8g=:OWynB1iC5Lw06DBJ1EJ2OL
 cugj6ND1L98pIpNHcNgcgcI4Nqa3zzLQB1VL/U16dbFXt+5wQh86MCz9aCy6TlBc4YeTHYaKZ
 gw/trNB+f9RuaPKXx3rZeSWw8pKvotfUMBLl5uIKosN83nuXfpC6PYDt6/WXuzgADkZWK+bPO
 CzEa3cuZSlJHr4kkiw+hE6c2RjpH+yL7JMI3MrgMZQcXoO19Pw76hSQIubNeO5Io3tL97c485
 J1hSxk60FfepFlBi074sBC6RhtlPDhTFdgL7pMG349y58RxD7Yl7tlbJ7yWkAko8+meELbICL
 nB+MQWoOXeEPFzItseb6V1EIT2ABuDfxFRkI6QBO1KTfvDm9XNHVEoTFw/QCt2Pgl54sRO/b4
 iXMRkDDV1sMOB8qu9YNzn0mF7KY5AxEy5UV0iiY8O+y82Fkptb9NO/u8x/GSlXieF3An7djuZ
 UTmtT0h4NDGiN0uVrnw2NbfMpnJm91rthv5erqVRusegVrIXsiGDrrTIt9do/97MTy8KC6sMC
 kBrXnxPs81mlk5cFJ2l6jj/9LBaiCUlZwDLw3Ga5K9PowogpwVjriRdj5JI/rmjzeKIaOLaRE
 g7ukRs7L51ayuRHj3Bj4jb3OZb7UWTyJ9oVYmFiNWPlshrZfjw7dA+0NNvvSslD5rxGbnDl5J
 GOovFXQBFJ4bFrnVP/sc24JtcqrLh2nP97TKNpY8demSuRl0hI8n76DSa/AU0QaNnI/kX1jBb
 cEwfFcjA3qp6RaEv4bM3APADT3C0TRS9BFeJJAO2gAjAGeCXmavat7F/XOJUgyE8AK/sUjyd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280591>

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 wt-status.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 42ea15e..435fc28 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -897,15 +897,15 @@ static void wt_status_print_verbose(struct wt_status *s)
 static void wt_status_print_tracking(struct wt_status *s)
 {
 	struct strbuf sb = STRBUF_INIT;
-	const char *cp, *ep;
+	const char *cp, *ep, *branch_name;
 	struct branch *branch;
 	char comment_line_string[3];
 	int i;
 
 	assert(s->branch && !s->is_initial);
-	if (!starts_with(s->branch, "refs/heads/"))
+	if (!skip_prefix(s->branch, "refs/heads/", &branch_name))
 		return;
-	branch = branch_get(s->branch + 11);
+	branch = branch_get(branch_name);
 	if (!format_tracking_info(branch, &sb))
 		return;
 
@@ -1268,6 +1268,7 @@ static char *read_and_strip_branch(const char *path)
 {
 	struct strbuf sb = STRBUF_INIT;
 	unsigned char sha1[20];
+	const char *branch_name;
 
 	if (strbuf_read_file(&sb, git_path("%s", path), 0) <= 0)
 		goto got_nothing;
@@ -1276,8 +1277,8 @@ static char *read_and_strip_branch(const char *path)
 		strbuf_setlen(&sb, sb.len - 1);
 	if (!sb.len)
 		goto got_nothing;
-	if (starts_with(sb.buf, "refs/heads/"))
-		strbuf_remove(&sb,0, strlen("refs/heads/"));
+	if (skip_prefix(sb.buf, "refs/heads/", &branch_name))
+		strbuf_remove(&sb, 0, branch_name - sb.buf);
 	else if (starts_with(sb.buf, "refs/"))
 		;
 	else if (!get_sha1_hex(sb.buf, sha1)) {
@@ -1308,9 +1309,8 @@ static int grab_1st_switch(unsigned char *osha1, unsigned char *nsha1,
 	struct grab_1st_switch_cbdata *cb = cb_data;
 	const char *target = NULL, *end;
 
-	if (!starts_with(message, "checkout: moving from "))
+	if (!skip_prefix(message, "checkout: moving from ", &message))
 		return 0;
-	message += strlen("checkout: moving from ");
 	target = strstr(message, " to ");
 	if (!target)
 		return 0;
@@ -1348,14 +1348,10 @@ static void wt_status_get_detached_from(struct wt_status_state *state)
 	     /* perhaps sha1 is a tag, try to dereference to a commit */
 	     ((commit = lookup_commit_reference_gently(sha1, 1)) != NULL &&
 	      !hashcmp(cb.nsha1, commit->object.sha1)))) {
-		int ofs;
-		if (starts_with(ref, "refs/tags/"))
-			ofs = strlen("refs/tags/");
-		else if (starts_with(ref, "refs/remotes/"))
-			ofs = strlen("refs/remotes/");
-		else
-			ofs = 0;
-		state->detached_from = xstrdup(ref + ofs);
+		const char *from = ref;
+		if (!skip_prefix(from, "refs/tags/", &from))
+			skip_prefix(from, "refs/remotes/", &from);
+		state->detached_from = xstrdup(from);
 	} else
 		state->detached_from =
 			xstrdup(find_unique_abbrev(cb.nsha1, DEFAULT_ABBREV));
@@ -1442,9 +1438,7 @@ void wt_status_print(struct wt_status *s)
 	if (s->branch) {
 		const char *on_what = _("On branch ");
 		const char *branch_name = s->branch;
-		if (starts_with(branch_name, "refs/heads/"))
-			branch_name += 11;
-		else if (!strcmp(branch_name, "HEAD")) {
+		if (!strcmp(branch_name, "HEAD")) {
 			branch_status_color = color(WT_STATUS_NOBRANCH, s);
 			if (state.rebase_in_progress || state.rebase_interactive_in_progress) {
 				if (state.rebase_interactive_in_progress)
@@ -1462,7 +1456,8 @@ void wt_status_print(struct wt_status *s)
 				branch_name = "";
 				on_what = _("Not currently on any branch.");
 			}
-		}
+		} else
+			skip_prefix(branch_name, "refs/heads/", &branch_name);
 		status_printf(s, color(WT_STATUS_HEADER, s), "%s", "");
 		status_printf_more(s, branch_status_color, "%s", on_what);
 		status_printf_more(s, branch_color, "%s\n", branch_name);
@@ -1653,8 +1648,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 		goto conclude;
 	}
 
-	if (starts_with(branch_name, "refs/heads/"))
-		branch_name += 11;
+	skip_prefix(branch_name, "refs/heads/", &branch_name);
 
 	branch = branch_get(branch_name);
 
-- 
2.6.2

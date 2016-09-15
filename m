Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01F712070F
	for <e@80x24.org>; Thu, 15 Sep 2016 18:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752666AbcIOSbj (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 14:31:39 -0400
Received: from mout.web.de ([212.227.15.4]:57097 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752627AbcIOSbh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 14:31:37 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M9XbT-1brzYZ0XNP-00D2u2; Thu, 15 Sep 2016 20:31:16
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] use strbuf_addstr() for adding constant strings to a strbuf,
 part 2
Message-ID: <f7294ac5-8302-03fb-d756-81a1c029a813@web.de>
Date:   Thu, 15 Sep 2016 20:31:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:TwiYhwxFEU9XvUuXir5zvXACEykz/vQwRZcnk2PXNG21ZsW/KGC
 +k+gaJCECcWvmr0TybH8IaLeNdEiSXHvk8sCbt+VYlI7A/0kLWq2WiJevhZB7qbjFgIMOX3
 Yd3so02vckPsBZZ+OSU7A2fX4f+MY+phWvuu9ACfCgoZXATk/6PXuEhbwZ9QRzj9ideqBtF
 38Sot4ld9dUzOwZoztvzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:utnr5/zxJgE=:l4u5MjqxM58RwJuFbORhnb
 MHw5al67ohhFJElsXVdC4gkNona2PsQrZmmabxoQyyykOKs+zNZulX3JiRlYKjb3Lz3uWoiRR
 lodTJtzFjSmyVKKoYgR+34jqrWtYHP0Sfa0LfkKGip8qvVs4x1C58uwfe9DUt4LPvaQPCBgho
 LLhE65cJ7AJN95DCwTehROV/PZIJhDQ5L7qdagHPEF5Q0193Q8YeYSIM3JntFo5nofvDonJ/b
 9vcvb2HVZp3hKp1FJQadLxFkLO5M9y0rSdVIaM0OyR9tgnpxLPceJ+CfgURDL0Cgr1GO4v0m+
 0k/iXJLVqDc12gzg068yv1KQaSusiSotR6mlqRr26MD0ZstnuJcH3a3mDoNSpbUqUKN5Dx0cN
 M/Scjgr/14K5b/wrO4YcDgiS5eatFfcVw+/M7ulLR1CAPmLFnINV91dEDDJV6AmhFE+LuLdBY
 ZECjDfzBYcA+dBIFxXQK9snMe2XlqwVnBRoaA0saK8PYOnjbu9ImqudwtbCqa5AB6AgAZmDY/
 5mdLCgNWzUxUAd/WM7gVADqBN/r3PdaQYrtFcAcsZXxk/vnpMuN8eokQDtHT4pcR3/u29/dG/
 iY7TnZ5/kZgGoSuTvIvswnunqMBkX8gMOOtd4X7UT88N4RewlszL+qXmH9XmzOxMwGmIN5Qy6
 DrchFgMg7G2EnYFtkRVHOivajSA/5SpIiuVnfBaIvQ6ZVpdXLJpEMnMEu81gu6ByP+fHZT0a9
 RiIZv1y+1bPaLq664i2G/bI5cgde0Bm+mkLzUt3UdHqjEDXmdLV+VWg0/SxffC++HFfUttt7H
 0gY7pUy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace uses of strbuf_addf() for adding strings with more lightweight
strbuf_addstr() calls.  This makes the intent clearer and avoids
potential issues with printf format specifiers.

02962d36845b89145cd69f8bc65e015d78ae3434 already converted six cases,
this patch covers eleven more.

A semantic patch for Coccinelle is included for easier checking for
new cases that might be introduced in the future.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Silly question: Is there a natural language that uses percent signs
as letters or e.g. instead of commas? :)

 builtin/fmt-merge-msg.c         | 2 +-
 builtin/merge.c                 | 2 +-
 builtin/submodule--helper.c     | 5 +++--
 contrib/coccinelle/strbuf.cocci | 5 +++++
 merge-recursive.c               | 2 +-
 remote.c                        | 8 ++++----
 wt-status.c                     | 6 +++---
 7 files changed, 18 insertions(+), 12 deletions(-)
 create mode 100644 contrib/coccinelle/strbuf.cocci

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index ac84e99..dc2e9e4 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -395,7 +395,7 @@ static void shortlog(const char *name,
 
 	for (i = 0; i < subjects.nr; i++)
 		if (i >= limit)
-			strbuf_addf(out, "  ...\n");
+			strbuf_addstr(out, "  ...\n");
 		else
 			strbuf_addf(out, "  %s\n", subjects.items[i].string);
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 0ae099f..a8b57c7 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -940,7 +940,7 @@ static void write_merge_state(struct commit_list *remoteheads)
 
 	strbuf_reset(&buf);
 	if (fast_forward == FF_NO)
-		strbuf_addf(&buf, "no-ff");
+		strbuf_addstr(&buf, "no-ff");
 	write_file_buf(git_path_merge_mode(), buf.buf, buf.len);
 }
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9d79f19..ad23155 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -859,8 +859,9 @@ static int update_clone_get_next_task(struct child_process *child,
 		ce = suc->failed_clones[index];
 		if (!prepare_to_clone_next_submodule(ce, child, suc, err)) {
 			suc->current ++;
-			strbuf_addf(err, "BUG: submodule considered for cloning,"
-				    "doesn't need cloning any more?\n");
+			strbuf_addstr(err, "BUG: submodule considered for "
+					   "cloning, doesn't need cloning "
+					   "any more?\n");
 			return 0;
 		}
 		p = xmalloc(sizeof(*p));
diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.cocci
new file mode 100644
index 0000000..7932d48
--- /dev/null
+++ b/contrib/coccinelle/strbuf.cocci
@@ -0,0 +1,5 @@
+@@
+expression E1, E2;
+@@
+- strbuf_addf(E1, E2);
++ strbuf_addstr(E1, E2);
diff --git a/merge-recursive.c b/merge-recursive.c
index e349126..d2b191b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -206,7 +206,7 @@ static void output_commit_title(struct merge_options *o, struct commit *commit)
 			find_unique_abbrev(commit->object.oid.hash,
 				DEFAULT_ABBREV));
 		if (parse_commit(commit) != 0)
-			strbuf_addf(&o->obuf, _("(bad commit)\n"));
+			strbuf_addstr(&o->obuf, _("(bad commit)\n"));
 		else {
 			const char *title;
 			const char *msg = get_commit_buffer(commit, NULL);
diff --git a/remote.c b/remote.c
index d29850a..ad6c542 100644
--- a/remote.c
+++ b/remote.c
@@ -2073,7 +2073,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 			_("Your branch is based on '%s', but the upstream is gone.\n"),
 			base);
 		if (advice_status_hints)
-			strbuf_addf(sb,
+			strbuf_addstr(sb,
 				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
 	} else if (!ours && !theirs) {
 		strbuf_addf(sb,
@@ -2086,7 +2086,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 			   ours),
 			base, ours);
 		if (advice_status_hints)
-			strbuf_addf(sb,
+			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
 	} else if (!ours) {
 		strbuf_addf(sb,
@@ -2097,7 +2097,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 			   theirs),
 			base, theirs);
 		if (advice_status_hints)
-			strbuf_addf(sb,
+			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
 	} else {
 		strbuf_addf(sb,
@@ -2110,7 +2110,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 			   ours + theirs),
 			base, ours, theirs);
 		if (advice_status_hints)
-			strbuf_addf(sb,
+			strbuf_addstr(sb,
 				_("  (use \"git pull\" to merge the remote branch into yours)\n"));
 	}
 	free(base);
diff --git a/wt-status.c b/wt-status.c
index 539aac1..f928f0f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -367,11 +367,11 @@ static void wt_longstatus_print_change_data(struct wt_status *s,
 		if (d->new_submodule_commits || d->dirty_submodule) {
 			strbuf_addstr(&extra, " (");
 			if (d->new_submodule_commits)
-				strbuf_addf(&extra, _("new commits, "));
+				strbuf_addstr(&extra, _("new commits, "));
 			if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
-				strbuf_addf(&extra, _("modified content, "));
+				strbuf_addstr(&extra, _("modified content, "));
 			if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
-				strbuf_addf(&extra, _("untracked content, "));
+				strbuf_addstr(&extra, _("untracked content, "));
 			strbuf_setlen(&extra, extra.len - 2);
 			strbuf_addch(&extra, ')');
 		}
-- 
2.10.0


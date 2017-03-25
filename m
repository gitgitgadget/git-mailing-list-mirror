Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D82F92095E
	for <e@80x24.org>; Sat, 25 Mar 2017 12:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbdCYMRC (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 08:17:02 -0400
Received: from mout.web.de ([212.227.15.14]:61072 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751088AbdCYMRB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 08:17:01 -0400
Received: from [192.168.178.36] ([79.237.59.215]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0McneT-1caMEG3ypF-00Hsup; Sat, 25
 Mar 2017 13:16:46 +0100
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] pretty: add extra headers and MIME boundary directly
Message-ID: <6f3d0b54-7a9f-8088-3675-bd2980f69735@web.de>
Date:   Sat, 25 Mar 2017 13:16:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:+8BNQTK1/ttAPR478kNZEa2Dxwqy51QNudMQwt2ous0U/FWRxWY
 HGBGJzfL/gM7HmD9iQ4I55S78uGjoaBU0MRt4q4Ng4hiqMAknTClEzqJ/qWFxXwYcTAAGNC
 Xu13zQh0yhyqGrSG+a7WE0/PxsDCAHKZ7CACY33sRuNiawiKFkX4slqbpcVPCZUh//MYjb1
 J7Zlt3nIYIsstsMWp7Z8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sHd166VAN0M=:jyGP2TIEtX5zDENz05xxVe
 QYs2JMz1k27phJjKxhVEQyS4+3x70WGvCxHrUPVtYs+KaEwe9+uioX8spQODJcHbPdfgxn8dz
 baO+q4En0VkU++Z4Fbm/hcSoh6FoXJTGuIC5B7n/ToD6dXijTNPq5x9Tq+7Dk491GL344T+8P
 +HDw5xC48nMvA5MK0GK834Ya1U7v+ZHt8cRGTnqomU45CZhNqLw61PMMbLldFhQAhVsdGJuU+
 ZNOQQgWcuWjb6KB3C4pdgfoBtVBCOUpjNTcf99dQm7PeFfasIYSMQa1gDZeuhZ042c+aXVbtD
 rYJyb9aRO91FS4ARZJ5TOeNxFisBhfNfoK9PxihzlXDC2Oljkgrfr92Dt2Xk1cUNTAe1RV1pr
 HcyisKKJjw2bip6aNxj6n137Xt8ErliK5FqESyCsKQYzU4JqMlaafHHkgSD2xQ8xMEQjHMsL7
 fKM79MHRzSFoEJ9ozJtHHS1Zi+4XEGYfhzhMsu5GtYg28yWOGlzH6W2Nhczar9Cb2UTesze12
 S1+OEquZv3XXk9p4AddkAer/ufNYz3Yvyi+pGbpAK+lzuzecdpHigX5EgiQ5wxpCYCbRjY41b
 3j4LmNQLw7wm94xvMKKWjbDZjfG3fqOrOxrG3M5Zw9ycqbem/YzGxsESMDncuQJgrJf1JU7iA
 HIiSQiEDHFIGkvdYYMBgddeZGkfuy922K7e4l/E3zK5HCbShqTrJzHHPoUhmuyp5B9AXRr8um
 EmqeipOaGOCBnxq08ZTAlT+A6+yH1mGQVWKWqMZUoSNaJ+t3BnCbNvpChXgAlXePwn/lTqBwN
 0TBnsRY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the after_subject member of struct pretty_print_context to pass the
extra_headers unchanged, and construct and add the MIME boundary headers
directly in pretty.c::pp_title_line() instead of writing both to a
static buffer in log-tree.c::log_write_email_headers() first.  That's
easier, quicker and gets rid of said static buffer.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/log.c |  3 ++-
 log-tree.c    | 26 ++------------------------
 log-tree.h    |  1 -
 pretty.c      | 15 +++++++++++++++
 4 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 281af8c1ec..be564039c1 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -989,7 +989,8 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	    open_next_file(NULL, rev->numbered_files ? NULL : "cover-letter", rev, quiet))
 		return;
 
-	log_write_email_headers(rev, head, &pp.after_subject, &need_8bit_cte);
+	log_write_email_headers(rev, head, &need_8bit_cte);
+	pp.after_subject = rev->extra_headers;
 
 	for (i = 0; !need_8bit_cte && i < nr; i++) {
 		const char *buf = get_commit_buffer(list[i], NULL);
diff --git a/log-tree.c b/log-tree.c
index 4618dd04ca..7049a17781 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -349,10 +349,8 @@ void fmt_output_email_subject(struct strbuf *sb, struct rev_info *opt)
 }
 
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
-			     const char **extra_headers_p,
 			     int *need_8bit_cte_p)
 {
-	const char *extra_headers = opt->extra_headers;
 	const char *name = oid_to_hex(opt->zero_commit ?
 				      &null_oid : &commit->object.oid);
 
@@ -374,26 +372,9 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		graph_show_oneline(opt->graph);
 	}
 	if (opt->mime_boundary) {
-		static char subject_buffer[1024];
 		static char buffer[1024];
 		struct strbuf filename =  STRBUF_INIT;
 		*need_8bit_cte_p = -1; /* NEVER */
-		snprintf(subject_buffer, sizeof(subject_buffer) - 1,
-			 "%s"
-			 "MIME-Version: 1.0\n"
-			 "Content-Type: multipart/mixed;"
-			 " boundary=\"%s%s\"\n"
-			 "\n"
-			 "This is a multi-part message in MIME "
-			 "format.\n"
-			 "--%s%s\n"
-			 "Content-Type: text/plain; "
-			 "charset=UTF-8; format=fixed\n"
-			 "Content-Transfer-Encoding: 8bit\n\n",
-			 extra_headers ? extra_headers : "",
-			 mime_boundary_leader, opt->mime_boundary,
-			 mime_boundary_leader, opt->mime_boundary);
-		extra_headers = subject_buffer;
 
 		if (opt->numbered_files)
 			strbuf_addf(&filename, "%d", opt->nr);
@@ -413,7 +394,6 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		opt->diffopt.stat_sep = buffer;
 		strbuf_release(&filename);
 	}
-	*extra_headers_p = extra_headers;
 }
 
 static void show_sig_lines(struct rev_info *opt, int status, const char *bol)
@@ -537,7 +517,6 @@ void show_log(struct rev_info *opt)
 	struct log_info *log = opt->loginfo;
 	struct commit *commit = log->commit, *parent = log->parent;
 	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : 40;
-	const char *extra_headers = opt->extra_headers;
 	struct pretty_print_context ctx = {0};
 
 	opt->loginfo = NULL;
@@ -597,8 +576,7 @@ void show_log(struct rev_info *opt)
 	 */
 
 	if (cmit_fmt_is_mail(opt->commit_format)) {
-		log_write_email_headers(opt, commit, &extra_headers,
-					&ctx.need_8bit_cte);
+		log_write_email_headers(opt, commit, &ctx.need_8bit_cte);
 		ctx.rev = opt;
 		ctx.print_email_subject = 1;
 	} else if (opt->commit_format != CMIT_FMT_USERFORMAT) {
@@ -672,7 +650,7 @@ void show_log(struct rev_info *opt)
 	ctx.date_mode = opt->date_mode;
 	ctx.date_mode_explicit = opt->date_mode_explicit;
 	ctx.abbrev = opt->diffopt.abbrev;
-	ctx.after_subject = extra_headers;
+	ctx.after_subject = opt->extra_headers;
 	ctx.preserve_subject = opt->preserve_subject;
 	ctx.reflog_info = opt->reflog_info;
 	ctx.fmt = opt->commit_format;
diff --git a/log-tree.h b/log-tree.h
index 48f11fb740..7f9c4f22b5 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -22,7 +22,6 @@ void format_decorations_extended(struct strbuf *sb, const struct commit *commit,
 			     format_decorations_extended((strbuf), (commit), (color), " (", ", ", ")")
 void show_decorations(struct rev_info *opt, struct commit *commit);
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
-			     const char **extra_headers_p,
 			     int *need_8bit_cte_p);
 void load_ref_decorations(int flags);
 
diff --git a/pretty.c b/pretty.c
index d0f86f5d85..56e668781a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1641,6 +1641,21 @@ void pp_title_line(struct pretty_print_context *pp,
 	if (pp->after_subject) {
 		strbuf_addstr(sb, pp->after_subject);
 	}
+	if (pp->print_email_subject && pp->rev && pp->rev->mime_boundary) {
+		strbuf_addf(sb,
+			    "MIME-Version: 1.0\n"
+			    "Content-Type: multipart/mixed;"
+			    " boundary=\"%s%s\"\n"
+			    "\n"
+			    "This is a multi-part message in MIME "
+			    "format.\n"
+			    "--%s%s\n"
+			    "Content-Type: text/plain; "
+			    "charset=UTF-8; format=fixed\n"
+			    "Content-Transfer-Encoding: 8bit\n\n",
+			    mime_boundary_leader, pp->rev->mime_boundary,
+			    mime_boundary_leader, pp->rev->mime_boundary);
+	}
 	if (cmit_fmt_is_mail(pp->fmt)) {
 		strbuf_addch(sb, '\n');
 	}
-- 
2.12.2


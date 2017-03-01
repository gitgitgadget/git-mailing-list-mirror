Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD3EB1F5FB
	for <e@80x24.org>; Wed,  1 Mar 2017 11:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752735AbdCALoZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 06:44:25 -0500
Received: from mout.web.de ([212.227.15.14]:58492 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751962AbdCALn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 06:43:58 -0500
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ls92l-1cJNNF0NyB-013tSZ; Wed, 01
 Mar 2017 12:36:42 +0100
Subject: [PATCH 1/2] log-tree: factor out fmt_output_email_subject()
To:     Jeff King <peff@peff.net>, Adrian Dudau <Adrian.Dudau@enea.com>
References: <1488297556.2955.11.camel@enea.com>
 <20170228181719.t67abnnnsdcx2xfd@sigill.intra.peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <e3de1725-99c3-d5a2-2cab-a05aa8546efb@web.de>
Date:   Wed, 1 Mar 2017 12:36:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20170228181719.t67abnnnsdcx2xfd@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:zBRZI4/yp40QhonKY+LA2esw3uLWejt2BASKPjrUTPnPIIFjQOc
 cdApX78Hba2OoKY4UfKrK8AdcbasReOuk/9wvuYUUzZHCR19ksSihheGvfv89x/2cs25KMQ
 M7UAp4UKmLytI1TAbTDgcWLAQGgD2CMmMlkXsZ9BFpR48q/UF1V+1eOgohj8ZxXvLO/gfu4
 lVkO6O+YiPZhEwU2hDMoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q7SGeYtAN+A=:86jL2H82szPVIFUTOq6vwp
 HAxhTYaltzEn4V8i4xnzmMlklNXBTiycHFMeiS17mGQV/eIDd8cWL5RDFR4UK6HBWZko/oqT+
 FhkMid+whT8RNmKy3+jhcuBqLsQb/luyDsNIUR4CFxqhEskbncx+GLUcFcog0kW44zK0U7mxH
 XJSeNJBD21KG4dDNyrp3dE0pdwDQA/hDwOPylWehif1uvjlVyGHLoMtfUejFcxC05fR/9M7s3
 lHhXi2AnKJP5pUE+PqRm3/1wtrKAkZZ5ODVA84P7VS+T7+/Kp09E/vU4REoihGoo9oVsmvAhS
 byLxeJYaOHxdTt8MlkquIEnd9hrGD75/Kko/OmlbxJsOkAzcDUtsWju4b8gqDgnl3CGEFDaP3
 hAT/4TcTchKqZPob6+mObrNwdK1pCjnqcPYrjhMqVxoXy9dA+fJZRYFijjElAs2RqtuYJdY8v
 zDWldcuoQ35RFnBLRW92Th5qNmmuglAnqhCOQd31in0luenVjztGbB9MPVcBuCiOX/D4808H6
 IYDxP2rBC+EMyD2ocTM9omN7C8FsTqHLfZtG/cRNhTzZEpqmZCWw5L23z05W5do7aNoMPmbmC
 ybuIx//bPeLHYDoj+2nXfpfiQPAcrjxrnCgkvkjnZuDWhy7NmXwzM/1aoMvUcywIN7FdWhrtM
 Nthgvo8FRoRBPnjkNYBGTFYVmVdI0M5mWp079im3mHbOOpp/knkCDLO4PtzIpKnLOm36PWxT9
 jBD/+IUbTEKcoQ55NOCrKh7vErE3IaNygQkGRXOGR8bIWGV3ErTu8zNR9Zu2N5FL/feHSHySB
 aaj3Irn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use a strbuf to store the subject prefix string and move its
construction into its own function.  This gets rid of two arbitrary
length limits and allows the string to be added by callers directly.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 log-tree.c | 40 ++++++++++++++++++++--------------------
 log-tree.h |  1 +
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 8c2415747a..44febb75ab 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -332,35 +332,33 @@ void fmt_output_commit(struct strbuf *filename,
 	strbuf_release(&subject);
 }
 
+void fmt_output_email_subject(struct strbuf *sb, struct rev_info *opt)
+{
+	if (opt->total > 0) {
+		strbuf_addf(sb, "Subject: [%s%s%0*d/%d] ",
+			    opt->subject_prefix,
+			    *opt->subject_prefix ? " " : "",
+			    digits_in_number(opt->total),
+			    opt->nr, opt->total);
+	} else if (opt->total == 0 && opt->subject_prefix && *opt->subject_prefix) {
+		strbuf_addf(sb, "Subject: [%s] ",
+			    opt->subject_prefix);
+	} else {
+		strbuf_addstr(sb, "Subject: ");
+	}
+}
+
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     const char **subject_p,
 			     const char **extra_headers_p,
 			     int *need_8bit_cte_p)
 {
-	const char *subject = NULL;
+	static struct strbuf subject = STRBUF_INIT;
 	const char *extra_headers = opt->extra_headers;
 	const char *name = oid_to_hex(opt->zero_commit ?
 				      &null_oid : &commit->object.oid);
 
 	*need_8bit_cte_p = 0; /* unknown */
-	if (opt->total > 0) {
-		static char buffer[64];
-		snprintf(buffer, sizeof(buffer),
-			 "Subject: [%s%s%0*d/%d] ",
-			 opt->subject_prefix,
-			 *opt->subject_prefix ? " " : "",
-			 digits_in_number(opt->total),
-			 opt->nr, opt->total);
-		subject = buffer;
-	} else if (opt->total == 0 && opt->subject_prefix && *opt->subject_prefix) {
-		static char buffer[256];
-		snprintf(buffer, sizeof(buffer),
-			 "Subject: [%s] ",
-			 opt->subject_prefix);
-		subject = buffer;
-	} else {
-		subject = "Subject: ";
-	}
 
 	fprintf(opt->diffopt.file, "From %s Mon Sep 17 00:00:00 2001\n", name);
 	graph_show_oneline(opt->graph);
@@ -417,7 +415,9 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		opt->diffopt.stat_sep = buffer;
 		strbuf_release(&filename);
 	}
-	*subject_p = subject;
+	strbuf_reset(&subject);
+	fmt_output_email_subject(&subject, opt);
+	*subject_p = subject.buf;
 	*extra_headers_p = extra_headers;
 }
 
diff --git a/log-tree.h b/log-tree.h
index c8116e60cd..dd75dd7770 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -30,5 +30,6 @@ void load_ref_decorations(int flags);
 #define FORMAT_PATCH_NAME_MAX 64
 void fmt_output_commit(struct strbuf *, struct commit *, struct rev_info *);
 void fmt_output_subject(struct strbuf *, const char *subject, struct rev_info *);
+void fmt_output_email_subject(struct strbuf *, struct rev_info *);
 
 #endif
-- 
2.12.0


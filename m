Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DDCF201CF
	for <e@80x24.org>; Thu, 18 May 2017 19:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757716AbdERTiS (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 15:38:18 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35109 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757700AbdERTiM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 15:38:12 -0400
Received: by mail-pg0-f44.google.com with SMTP id q125so27306387pgq.2
        for <git@vger.kernel.org>; Thu, 18 May 2017 12:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Oek9udo4yHqBuUqj0M9XlGN1z/D7CWNUSvSP6Oep9oU=;
        b=KAP4XljYcWIi6egJ/008FhgUQqBqI9YQajeOu1yZvWRoUbdEtbg/HUgkPHzhVbFVAH
         JdCH7yklmPD/OOG9TEK6AW4bh192Y/r3SWlHfdT0TNkM2GB6R7zprFvpY8yAFgwPhAKu
         d6o1kQ/LSxOWHokzL5e7IpPaOo4x5Pix3aam5oL7gqfuNlkcfRITQgDqJqvaee1pR8Kh
         SESdPVjTsjY5K+Sey//BJRlICEiyR6rWM5OMQXdasIKpxzuu3wfxUO5duVNddc5Kv4YS
         w9k/pMF2sFPS29sZI3SuFG2fhJLvVNl6UjpbBtkqMKqj8i3SkOQcXofrYgxOS35sux9t
         ATKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Oek9udo4yHqBuUqj0M9XlGN1z/D7CWNUSvSP6Oep9oU=;
        b=ZU0N0YHNM0VsVSk3QNBoIf4UVqUDpP1+oUCI/FK00epn5HOL/3kq9Pf0iJ0lVroZnQ
         q3bTMurQn+yGtg6kXcEtgT4ShOn9Ktsu1EV+tT7rxhZmr9YQzSrc6ZDPFMtgoE+DRMXS
         uefwsh3dxuDEtTei/KHnzsZM/cLfRaMeF75TBLspaRdgDDEXXmHKNChsNpndAe3bZBTq
         yK3rBDkdZ0+z6VCgdHjGAZHozI2rexx48mtAtnmY6wpenz4lVN6tD24Q6zXXfcXRDb2s
         /q3ldHp5yxXuNBNKIfm4lpH98ReIu5mCoVbJfxae1/SspsTcovMHBl7NEvH3LB6jLt8O
         4SOA==
X-Gm-Message-State: AODbwcAV3fTuzvLGaUdqVXprFcFFaM9UthugR5O+wDe0F747scm55k48
        UTQhJL/z3qF03/4G
X-Received: by 10.99.146.30 with SMTP id o30mr6156028pgd.61.1495136286227;
        Thu, 18 May 2017 12:38:06 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7013:588c:5765:703d])
        by smtp.gmail.com with ESMTPSA id z21sm11830040pgc.15.2017.05.18.12.38.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 May 2017 12:38:05 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net
Subject: [PATCHv3 10/20] diff.c: convert emit_rewrite_diff to use emit_line_*
Date:   Thu, 18 May 2017 12:37:36 -0700
Message-Id: <20170518193746.486-11-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170518193746.486-1-sbeller@google.com>
References: <20170517025857.32320-1-sbeller@google.com>
 <20170518193746.486-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch, I want to propose an option to detect&color
moved lines in a diff, which cannot be done in a one-pass over
the diff. Instead we need to go over the whole diff twice,
because we cannot detect the first line of the two corresponding
lines (+ and -) that got moved.

So to prepare the diff machinery for two pass algorithms
(i.e. buffer it all up and then operate on the result),
move all emissions to places, such that the only emitting
function is emit_line_0.

This covers emit_rewrite_diff.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/diff.c b/diff.c
index 4fa976d43c..3dda9f3c8e 100644
--- a/diff.c
+++ b/diff.c
@@ -704,17 +704,17 @@ static void remove_tempfile(void)
 	}
 }
 
-static void print_line_count(FILE *file, int count)
+static void add_line_count(struct strbuf *out, int count)
 {
 	switch (count) {
 	case 0:
-		fprintf(file, "0,0");
+		strbuf_addstr(out, "0,0");
 		break;
 	case 1:
-		fprintf(file, "1");
+		strbuf_addstr(out, "1");
 		break;
 	default:
-		fprintf(file, "1,%d", count);
+		strbuf_addf(out, "1,%d", count);
 		break;
 	}
 }
@@ -768,7 +768,7 @@ static void emit_rewrite_diff(const char *name_a,
 	char *data_one, *data_two;
 	size_t size_one, size_two;
 	struct emit_callback ecbdata;
-	const char *line_prefix = diff_line_prefix(o);
+	struct strbuf out = STRBUF_INIT;
 
 	if (diff_mnemonic_prefix && DIFF_OPT_TST(o, REVERSE_DIFF)) {
 		a_prefix = o->b_prefix;
@@ -806,20 +806,23 @@ static void emit_rewrite_diff(const char *name_a,
 	ecbdata.lno_in_preimage = 1;
 	ecbdata.lno_in_postimage = 1;
 
+	emit_line_fmt(o, metainfo, reset, 1, "--- %s%s\n", a_name.buf, name_a_tab);
+	emit_line_fmt(o, metainfo, reset, 1, "+++ %s%s\n", b_name.buf, name_b_tab);
+
 	lc_a = count_lines(data_one, size_one);
 	lc_b = count_lines(data_two, size_two);
-	fprintf(o->file,
-		"%s%s--- %s%s%s\n%s%s+++ %s%s%s\n%s%s@@ -",
-		line_prefix, metainfo, a_name.buf, name_a_tab, reset,
-		line_prefix, metainfo, b_name.buf, name_b_tab, reset,
-		line_prefix, fraginfo);
+
+	strbuf_addstr(&out, "@@ -");
 	if (!o->irreversible_delete)
-		print_line_count(o->file, lc_a);
+		add_line_count(&out, lc_a);
 	else
-		fprintf(o->file, "?,?");
-	fprintf(o->file, " +");
-	print_line_count(o->file, lc_b);
-	fprintf(o->file, " @@%s\n", reset);
+		strbuf_addstr(&out, "?,?");
+	strbuf_addstr(&out, " +");
+	add_line_count(&out, lc_b);
+	strbuf_addstr(&out, " @@\n");
+	emit_line(o, fraginfo, reset, 1, 0, out.buf, out.len);
+	strbuf_release(&out);
+
 	if (lc_a && !o->irreversible_delete)
 		emit_rewrite_lines(&ecbdata, '-', data_one, size_one);
 	if (lc_b)
-- 
2.13.0.18.g7d86cc8ba0


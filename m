Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C4B61F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 21:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753228AbeGCVwD (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 17:52:03 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41858 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbeGCVwC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 17:52:02 -0400
Received: by mail-oi0-f67.google.com with SMTP id k12-v6so6804308oiw.8
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 14:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mPnWLlaaxQHcg1P6E71V5VYxO28KUnrEX+UXLKPQ2Qo=;
        b=Su9DC2GOMiqDx8K+r3uo2QNx/9+7sMp7XiGV2ZHiqQP8Xe+r9j8ax2Cft+w5VEi2Md
         yto2OPQku+HZ8LkdAti1I/EoFoqqYtqyaQbu1XVhwZtpUOJbQGWDYokRWdosZZRM7suF
         wmDi/b7YqI/3XQDG6Vjo6+BPTVgjUKRsHAS0yvXaL2Tby4y0lfChSQf5GijObeoplZbt
         N/W59btXM1HMuyS8mu+PXTvstzmX21xdkLDDai97KfRylW1rlHt+G2pL/aqrq1ns8Tgg
         Xko2vXKBlJ/oQ4YWL2KdqcYtQXtZN7OGxvubq6DzW/Y9Kqoj0UhAd9AThPt/zUkb3Zqn
         XgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mPnWLlaaxQHcg1P6E71V5VYxO28KUnrEX+UXLKPQ2Qo=;
        b=e08VQSPkFq2JUuoeDc60WGDMJsA005cWFpgKL3C2KS7IL2TW1M2leIVC+Or8LHgR+J
         BHaVweyowF4dxWapIgYxGfv0Qjz8yMgOag9q2R2PECpNy8loq66641sG4ZbiR+pzdfzc
         nAy2PGoL1JsTEbbWSKn7CgZn9DmGnNgH3YNq05YhLstm9Q7XJSInDxZN0l+/NBpen/II
         pAV4Db/DeDUox1lcQuYu9bi0u1s8cDmc9OScdn9EJJUEoYQRueaYwYTGn3bo1IqV3DG7
         6fTp/Vu2EWRoF+2uaBY/xRV6NiERCXjAiSHEgvOVM2TZDfZsKK0vtCUKEiFOqhEcHnXP
         c7eg==
X-Gm-Message-State: APt69E0RDsTeH4rPBINWTzOpMKnJZsPcuVPU4No/5fLWRBFZKLy9DGVt
        9++wk6WHKSx6OQvCgpYCiFZIqoQFIX8=
X-Google-Smtp-Source: AAOMgpc7R2mu0tnQHMgCl9aniwnEZZZMOqLmEHugiF61/toyiW5dKA2I9BQeyfYu+25fB8darx5I0w==
X-Received: by 2002:aca:b954:: with SMTP id j81-v6mr24371174oif.356.1530654721408;
        Tue, 03 Jul 2018 14:52:01 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id n20-v6sm890237otf.35.2018.07.03.14.51.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 14:52:00 -0700 (PDT)
Date:   Tue, 3 Jul 2018 16:51:56 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, avarab@gmail.com
Subject: [PATCH v3 1/2] grep.c: extract show_line_header()
Message-ID: <62e19e5583e30117b6754be5de5582a07c9e78dc.1530654455.git.me@ttaylorr.com>
References: <cover.1529961706.git.me@ttaylorr.com>
 <cover.1530654455.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1530654455.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The grep code invokes show_line() to display the contents of a matched
or context line in its output. Part of this execution is to print a line
header that includes information such as the kind, the line- and
column-number and etc. of that match.

To prepare for the addition of an option to print only the matching
component(s) of a non-context line, we must prepare for the possibility
that a single line may contain multiple matching parts, and thus will
need multiple headers printed for a single line.

Extracting show_line_header allows us to do just that. In the subsequent
commit, it will be used within the colorization loop to print out only
the matching parts of a line, optionally with LFs delimiting
sub-matches.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 grep.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/grep.c b/grep.c
index 992673fe7e..4ff8a73043 100644
--- a/grep.c
+++ b/grep.c
@@ -1410,26 +1410,9 @@ static int next_match(struct grep_opt *opt, char *bol, char *eol,
 	return hit;
 }
 
-static void show_line(struct grep_opt *opt, char *bol, char *eol,
-		      const char *name, unsigned lno, ssize_t cno, char sign)
+static void show_line_header(struct grep_opt *opt, const char *name,
+			     unsigned lno, ssize_t cno, char sign)
 {
-	int rest = eol - bol;
-	const char *match_color, *line_color = NULL;
-
-	if (opt->file_break && opt->last_shown == 0) {
-		if (opt->show_hunk_mark)
-			opt->output(opt, "\n", 1);
-	} else if (opt->pre_context || opt->post_context || opt->funcbody) {
-		if (opt->last_shown == 0) {
-			if (opt->show_hunk_mark) {
-				output_color(opt, "--", 2, opt->color_sep);
-				opt->output(opt, "\n", 1);
-			}
-		} else if (lno > opt->last_shown + 1) {
-			output_color(opt, "--", 2, opt->color_sep);
-			opt->output(opt, "\n", 1);
-		}
-	}
 	if (opt->heading && opt->last_shown == 0) {
 		output_color(opt, name, strlen(name), opt->color_filename);
 		opt->output(opt, "\n", 1);
@@ -1457,6 +1440,29 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		output_color(opt, buf, strlen(buf), opt->color_columnno);
 		output_sep(opt, sign);
 	}
+}
+
+static void show_line(struct grep_opt *opt, char *bol, char *eol,
+		      const char *name, unsigned lno, ssize_t cno, char sign)
+{
+	int rest = eol - bol;
+	const char *match_color, *line_color = NULL;
+
+	if (opt->file_break && opt->last_shown == 0) {
+		if (opt->show_hunk_mark)
+			opt->output(opt, "\n", 1);
+	} else if (opt->pre_context || opt->post_context || opt->funcbody) {
+		if (opt->last_shown == 0) {
+			if (opt->show_hunk_mark) {
+				output_color(opt, "--", 2, opt->color_sep);
+				opt->output(opt, "\n", 1);
+			}
+		} else if (lno > opt->last_shown + 1) {
+			output_color(opt, "--", 2, opt->color_sep);
+			opt->output(opt, "\n", 1);
+		}
+	}
+	show_line_header(opt, name, lno, cno, sign);
 	if (opt->color) {
 		regmatch_t match;
 		enum grep_context ctx = GREP_CONTEXT_BODY;
-- 
2.18.0


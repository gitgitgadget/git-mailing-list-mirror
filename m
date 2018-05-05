Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90016200B9
	for <e@80x24.org>; Sat,  5 May 2018 04:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750765AbeEEEDQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 00:03:16 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41360 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeEEEDP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 00:03:15 -0400
Received: by mail-pf0-f193.google.com with SMTP id v63so18859800pfk.8
        for <git@vger.kernel.org>; Fri, 04 May 2018 21:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VfiqxJRfylXaasjow5MlH4uPsrzD0Rms8nSUWtkQhmQ=;
        b=hzLPyI0SFFLi8+EueTXx4E7tUfXz+rE0WHQNPhGlFOJ1Y58yxfTO+TFhoKyZXzRbG4
         ym/wiM7uRvfHlbrLyK8/Jm5E6oxfJrkeJr6qE5SLN4rCzOjxlHA9K+GwL2L8FQTtQVYx
         RiVoo5KBUM2NjKH4pwnmBjVNt9wCJv6in3hvERnBum1J2JEhaWuqpm8Rx0EydF9BAQz1
         ZXwjpi2ULypvP6PyuI1JMdpbUdV3kWGzoJs5B5/eA5f1UM31oKXd2Hhcc9+lALVMT9lE
         QzFErFkuoeV//k/G/lFdHJuVyDFN6dnx1R14ZTnB1fqe10S0lUlquIpwZiF1yMueyn2M
         kDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VfiqxJRfylXaasjow5MlH4uPsrzD0Rms8nSUWtkQhmQ=;
        b=bGpejC8scYZPaiK18uartJ8aZVN6ahIgV8Jr6raTCJV+8k4dhedMNgTbcWs24m+urV
         sOPoRzBjMJV/2JYFTMR5uUx8hgeuA6wgrH9AJWxDFOPunvoMjgiP8+mi5jpk6jp/rIhh
         ZOCEAvaWgaSrbCdv1APXD/P3RGhjXhhNrS6CrMbp+z3hzH8p6eEIXNDVpKLAcLNTm9hr
         Bwk6ZJKVMtWVCH/0VXyMdKFm3sMxhkhGHFQuZI5ySlom+U6+vA00Nkp7EEDN9j1R/9wx
         +BJcB8I1Sp19DVc0tYt4hJGibEWkOxehezDRUr0O1Rd9o0CRoiMwLUjWrxKJ2zapPDMz
         Bmuw==
X-Gm-Message-State: ALQs6tB6neJ1Qm+p/LpkxzjJP3ZJqWCbrAXyAG+YbUin6H9j/0nrKzyS
        4nKXJSly56dd8dMMiZJCcpbxG2wkx8g=
X-Google-Smtp-Source: AB8JxZpTtUIgtk280wScvdBbIoJc2tgqZWqsRUDo9CpcLVp5oqND6uEQXUNBq5UJ2wgRPau5G/JdHg==
X-Received: by 2002:a63:b203:: with SMTP id x3-v6mr23852986pge.266.1525492993712;
        Fri, 04 May 2018 21:03:13 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:a961:c277:c90f:2435])
        by smtp.gmail.com with ESMTPSA id z83sm2215229pfd.103.2018.05.04.21.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 May 2018 21:03:12 -0700 (PDT)
Date:   Fri, 4 May 2018 21:03:11 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH 1/2] grep.c: extract show_line_header()
Message-ID: <9dc758e3517681691e0809d9e9bcca03fbdad1cc.1525492696.git.me@ttaylorr.com>
References: <cover.1525492696.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1525492696.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach 'git-grep(1)' how to print a line header multiple times from
show_line() in preparation for it learning '--only-matching'.

show_line_header() comprises of the code in show_line() executed in
order to produce a line header. It is a one-for-one extraction of the
existing implementation.

For now, show_line_header() provides no benefit over the change before
this patch. The following patch will call conditionally call
show_line_header() multiple times per invocation to show_line(), which
is the desired benefit of this change.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 grep.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/grep.c b/grep.c
index 37bb39a4a8..89dd719e4d 100644
--- a/grep.c
+++ b/grep.c
@@ -1369,26 +1369,9 @@ static int next_match(struct grep_opt *opt, char *bol, char *eol,
 	return hit;
 }
 
-static void show_line(struct grep_opt *opt, char *bol, char *eol,
-		      const char *name, unsigned lno, unsigned cno, char sign)
+static void show_line_header(struct grep_opt *opt, const char *name,
+                             unsigned lno, unsigned cno, char sign)
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
@@ -1416,6 +1399,29 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		output_color(opt, buf, strlen(buf), opt->color_columnno);
 		output_sep(opt, sign);
 	}
+}
+
+static void show_line(struct grep_opt *opt, char *bol, char *eol,
+		      const char *name, unsigned lno, unsigned cno, char sign)
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
2.17.0


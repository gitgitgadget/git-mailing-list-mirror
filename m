Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 280F81F516
	for <e@80x24.org>; Mon,  2 Jul 2018 20:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbeGBUJD (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 16:09:03 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40189 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbeGBUJC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 16:09:02 -0400
Received: by mail-oi0-f67.google.com with SMTP id w126-v6so11437004oie.7
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 13:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mPnWLlaaxQHcg1P6E71V5VYxO28KUnrEX+UXLKPQ2Qo=;
        b=WVyeZNmoeuWwmULcwvqM5qYNlhRet+89QdTfR3LkK3CqpaKTugTQEnGzARckJAHaXN
         j7SqnUh8gpGSes/oyMF3cneStYhPoOUBTYxQG4PBy9f4usvV86GGev2J7SMSmZmJtzhf
         Zul9zi0f1N+TxlwLKL8++BTYO9btJD4ywmPAgw6BgTs3Ik81q8LNV/Ncz6g1bK29RJuW
         uUAZQtIpn6gE646j2ufhRLa0W5n2FNnTJR1SJwmnC/0VaEzgAdttz/UFRIBJb89VSNuw
         bi99y4WlSocjixVUdJtEr0jVSXsqBdbN/o1loE7zS+SL6QCSYZRrsW47f2m2oXF4wmVG
         FdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mPnWLlaaxQHcg1P6E71V5VYxO28KUnrEX+UXLKPQ2Qo=;
        b=OsFJDhdNtVlnB4FscwfG+/iZZgzP+UkILoozjGZu+BHmKFtFU5uXKvXNVQhO3Tgc0+
         sPh+h85ra6X++bXTp05TSkFnhgJ5rOhxHkUB+t2ZDrShiZIuIHRtCEsP4X9eEa5as6Im
         btSGN4oRMigXO8DuPNoOWdohmo8eAxy1Itvc6hb75ShNBJrCU7fcbguTSA0J2IiliVzE
         k+hF3MyfgaZRg7zXfVtS9BAvRe2qEPSvY6okJKHA8HvvE0SctjHTqUz6oDVOkID0hGSV
         OTtuq6DFlSKuTLZZBArFqo8Ymsa3XVZh3T5Bt7mZvicFN42IVagPvHEMyV5lo8w+JeqF
         xvwg==
X-Gm-Message-State: APt69E1z9Mn+0ASk6SkCK6dse8qIrlJyyzwnIHIwxllepDqQrwFpmuMX
        k3UwcfuxAV+pFTEKt+j2AzRQpJ3hnpc=
X-Google-Smtp-Source: AAOMgpfYNvvteG9iOyCj7/hNFvzd38OqMXV4qAXX1V4O0Ozmv4d2iiL/upYx9+dbywBqwpkdXyw1nw==
X-Received: by 2002:aca:5489:: with SMTP id i131-v6mr14174865oib.340.1530562140648;
        Mon, 02 Jul 2018 13:09:00 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id o65-v6sm8422745oia.35.2018.07.02.13.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 13:08:59 -0700 (PDT)
Date:   Mon, 2 Jul 2018 15:08:58 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, avarab@gmail.com
Subject: [PATCH v2 1/2] grep.c: extract show_line_header()
Message-ID: <62e19e5583e30117b6754be5de5582a07c9e78dc.1530562110.git.me@ttaylorr.com>
References: <cover.1529961706.git.me@ttaylorr.com>
 <cover.1530562110.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1530562110.git.me@ttaylorr.com>
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


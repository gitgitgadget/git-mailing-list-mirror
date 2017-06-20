Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E747C1FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbdFTCsn (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:48:43 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33074 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbdFTCsk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:40 -0400
Received: by mail-pf0-f180.google.com with SMTP id 83so62782355pfr.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TwUgOmO7YzsH+qrCvXwJEw3CS7QK7UDjTQw6bFejIlw=;
        b=GnN2HAfzLEF13RZvmmmyLKWPNZz2Bkppp0ZbAQG3AnilrVyvANphLu/GseNB4tvjj0
         ECUHGwbtwozdndeYWCfL/dKnW6aJrImi7Y15rsdkOFCUKgDb24hQQZKRi95mG65xQ41z
         HqfA2FLbNcmNvlw5xODqzP5V+7Jn1KYMOt0ZzFL/RIupoUqUKsf13a+8eySawvD1SnDg
         JgXpNSmH+/R7zdDaZ/ygGTnmWTNrjCNn2slCOCLLkm8hWGzldxSTjzypd6VyXd2bxG0z
         AX8hIn0LbE2ehLNJluKruOwWOrfFJmfFZhiY2edThguniaIArrTNGpTqi1CgYCQRSZ5m
         uhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TwUgOmO7YzsH+qrCvXwJEw3CS7QK7UDjTQw6bFejIlw=;
        b=EH4uHBlFoeuCcb/fUedaT0SEPnYj0Ef0sCDX9T+CiaPHTLT4cBayGyx12zdkmBfCpy
         wjfoBYqNgh8uJWjVYQJtb3tSkz85haUl6jv2bPdeBaIbFN9aCm00L3mBiKnBiSJ63Yot
         d3bLFwxsPIXmxWcD6KR4qjeDe6sqMP7m/DJOH+ifG1bCGxc0tvoTaioTuBTVBm90M6n2
         Vu20mrQgJhw/ckjtmIHI60l1/rVkHpyxR4OhbOucypp2nlpzvNRZH6+26xjz50+EwUF6
         8WG1kOiSO9P3wx4h1lnTNLHHeddEjSvwpyvEl0WWnpRsIRoS6u6Dfjo9FPdRUB209UX6
         8WiQ==
X-Gm-Message-State: AKS2vOwH/C9wYQq2BL4puzd6fbfvuk8pPoAlYbHm/fCHzQt6B4VsWxap
        FeuRcSPyayaq5CF2
X-Received: by 10.84.247.16 with SMTP id n16mr32311792pll.74.1497926910175;
        Mon, 19 Jun 2017 19:48:30 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id l4sm23379514pgn.34.2017.06.19.19.48.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:29 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 04/26] diff.c: introduce emit_diff_symbol
Date:   Mon, 19 Jun 2017 19:47:54 -0700
Message-Id: <20170620024816.20021-5-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170620024816.20021-1-sbeller@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 2f9722b382..89466018e5 100644
--- a/diff.c
+++ b/diff.c
@@ -559,6 +559,24 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 	emit_line_0(o, set, reset, line[0], line+1, len-1);
 }
 
+enum diff_symbol {
+	DIFF_SYMBOL_SEPARATOR,
+};
+
+static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
+			     const char *line, int len)
+{
+	switch (s) {
+	case DIFF_SYMBOL_SEPARATOR:
+		fprintf(o->file, "%s%c",
+			diff_line_prefix(o),
+			o->line_termination);
+		break;
+	default:
+		die("BUG: unknown diff symbol");
+	}
+}
+
 static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
 {
 	if (!((ecbdata->ws_rule & WS_BLANK_AT_EOF) &&
@@ -4833,9 +4851,7 @@ void diff_flush(struct diff_options *options)
 
 	if (output_format & DIFF_FORMAT_PATCH) {
 		if (separator) {
-			fprintf(options->file, "%s%c",
-				diff_line_prefix(options),
-				options->line_termination);
+			emit_diff_symbol(options, DIFF_SYMBOL_SEPARATOR, NULL, 0);
 			if (options->stat_sep) {
 				/* attach patch instead of inline */
 				fputs(options->stat_sep, options->file);
-- 
2.12.2.575.gb14f27f917


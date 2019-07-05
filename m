Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ACEE1F461
	for <e@80x24.org>; Fri,  5 Jul 2019 17:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfGERHN (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 13:07:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43096 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbfGERHL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 13:07:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so10588516wru.10
        for <git@vger.kernel.org>; Fri, 05 Jul 2019 10:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bunykNaHGdrBJ0t7SVGYq/jV9WCVTSz1n9AuYq76KD8=;
        b=esHJ7iTIIMAMm2fmAVV+G6d0QKKfT27p77PHEckxlb7KUMFi47wTuwxhbpsyhbxM0m
         L6UxoGIvp9G+psZm2LWgA7VPXH93dAVLDN0UUph5OPGlk+iXlgyjFzYIpP3mLyZ1hxfK
         JL/27A6fevO4jMxGkDF1Yk2HeEqO0uddSDKJsPRQ+CryqM6LIENzBqTLOWAqfaOr7qtA
         0brgIfExYMCJYpe7gjUoyVQX2hpAn6lv3C+gTiqY/AptNHkYLX6DbJuyrfbugmFP/jHW
         Im8QV4JP5nCIedcd0IxU5za+mMGUt0duM03aiD5G02hpAKVyqtcAbvYHUZQ+zBFU/eqt
         EQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bunykNaHGdrBJ0t7SVGYq/jV9WCVTSz1n9AuYq76KD8=;
        b=tLWLrH9CaB/cCW7tfzKGgPyycNifVB9pKFuseqD2+WJ+W79UNCRDSE6iCwGZSmW2bW
         qZuCY2t4s3qXxF+jc0Zs7s3xf6pw1sid6DcGSqchiGl7LnKuLCfpuWWOBYTd6xIIRaNd
         oPHMyNGYHN1XoGzWpUhJGPsF1mrKtsGLt9aeeHkEtwX//ZXDEcvdY5idG7nH1VblJCCw
         tTav5zvxrEngl5ejoqdg7j1cMsaigtNmjes3LlxPzDMLaAKcMIzNaYcY+MFjKDmJMvmp
         Wmt1lXBOyhmVHmvir+JW4Ap54H81hZjFFiwe8F3mFUeuSvTOWeXZTktUjjaIzNhiXfu3
         baOA==
X-Gm-Message-State: APjAAAXOqN1ss4HlpiiQjBzOCK+qmQH7UclSfESl+Q2HQ8hYQXDnfWg1
        zP+Toa6LYS0n7qvT9zNAFgx9+YGJ
X-Google-Smtp-Source: APXvYqzDBGHsraIhHsJG/SgtVZAV8/IZwEAvigQWxj5UTJXeMnAQjRpezLZJN3kNIDS7Z3Q3ajvIag==
X-Received: by 2002:a5d:4ac3:: with SMTP id y3mr5053607wrs.187.1562346427843;
        Fri, 05 Jul 2019 10:07:07 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id g14sm9452104wro.11.2019.07.05.10.07.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 10:07:07 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 11/14] range-diff: suppress line count in outer diff
Date:   Fri,  5 Jul 2019 18:06:27 +0100
Message-Id: <20190705170630.27500-12-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190705170630.27500-1-t.gummerer@gmail.com>
References: <20190414210933.20875-1-t.gummerer@gmail.com/>
 <20190705170630.27500-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The line count in the outer diff's hunk headers of a range diff is not
all that interesting.  It merely shows how far along the inner diff
are on both sides.  That number is of no use for human readers, and
range-diffs are not meant to be machine readable.

In a subsequent commit we're going to add some more contextual
information such as the filename corresponding to the diff to the hunk
headers.  Remove the unnecessary information, and just keep the "@@"
to indicate that a new hunk of the outer diff is starting.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 diff.c                |  5 ++++-
 diff.h                |  1 +
 range-diff.c          |  1 +
 t/t3206-range-diff.sh | 16 ++++++++--------
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index ec5c095199..9c28ff0a92 100644
--- a/diff.c
+++ b/diff.c
@@ -1672,7 +1672,10 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	if (ecbdata->opt->flags.dual_color_diffed_diffs)
 		strbuf_addstr(&msgbuf, reverse);
 	strbuf_addstr(&msgbuf, frag);
-	strbuf_add(&msgbuf, line, ep - line);
+	if (ecbdata->opt->flags.suppress_hunk_header_line_count)
+		strbuf_add(&msgbuf, atat, sizeof(atat));
+	else
+		strbuf_add(&msgbuf, line, ep - line);
 	strbuf_addstr(&msgbuf, reset);
 
 	/*
diff --git a/diff.h b/diff.h
index c9db9825bb..49913049f9 100644
--- a/diff.h
+++ b/diff.h
@@ -98,6 +98,7 @@ struct diff_flags {
 	unsigned stat_with_summary;
 	unsigned suppress_diff_headers;
 	unsigned dual_color_diffed_diffs;
+	unsigned suppress_hunk_header_line_count;
 };
 
 static inline void diff_flags_or(struct diff_flags *a,
diff --git a/range-diff.c b/range-diff.c
index 484b1ec5a9..b31fbab026 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -480,6 +480,7 @@ int show_range_diff(const char *range1, const char *range2,
 			opts.output_format = DIFF_FORMAT_PATCH;
 		opts.flags.suppress_diff_headers = 1;
 		opts.flags.dual_color_diffed_diffs = dual_color;
+		opts.flags.suppress_hunk_header_line_count = 1;
 		opts.output_prefix = output_prefix_cb;
 		strbuf_addstr(&indent, "    ");
 		opts.output_prefix_data = &indent;
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index aebd4e3693..9f89af7178 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -99,7 +99,7 @@ test_expect_success 'changed commit' '
 	1:  4de457d = 1:  a4b3333 s/5/A/
 	2:  fccce22 = 2:  f51d370 s/4/A/
 	3:  147e64e ! 3:  0559556 s/11/B/
-	    @@ -10,7 +10,7 @@
+	    @@
 	      9
 	      10
 	     -11
@@ -109,7 +109,7 @@ test_expect_success 'changed commit' '
 	      13
 	      14
 	4:  a63e992 ! 4:  d966c5c s/12/B/
-	    @@ -8,7 +8,7 @@
+	    @@
 	     @@ A
 	      9
 	      10
@@ -158,7 +158,7 @@ test_expect_success 'changed commit with sm config' '
 	1:  4de457d = 1:  a4b3333 s/5/A/
 	2:  fccce22 = 2:  f51d370 s/4/A/
 	3:  147e64e ! 3:  0559556 s/11/B/
-	    @@ -10,7 +10,7 @@
+	    @@
 	      9
 	      10
 	     -11
@@ -168,7 +168,7 @@ test_expect_success 'changed commit with sm config' '
 	      13
 	      14
 	4:  a63e992 ! 4:  d966c5c s/12/B/
-	    @@ -8,7 +8,7 @@
+	    @@
 	     @@ A
 	      9
 	      10
@@ -191,7 +191,7 @@ test_expect_success 'changed message' '
 	sed s/Z/\ /g >expected <<-EOF &&
 	1:  4de457d = 1:  f686024 s/5/A/
 	2:  fccce22 ! 2:  4ab067d s/4/A/
-	    @@ -2,6 +2,8 @@
+	    @@
 	    Z
 	    Z    s/4/A/
 	    Z
@@ -210,7 +210,7 @@ test_expect_success 'dual-coloring' '
 	sed -e "s|^:||" >expect <<-\EOF &&
 	:<YELLOW>1:  a4b3333 = 1:  f686024 s/5/A/<RESET>
 	:<RED>2:  f51d370 <RESET><YELLOW>!<RESET><GREEN> 2:  4ab067d<RESET><YELLOW> s/4/A/<RESET>
-	:    <REVERSE><CYAN>@@ -2,6 +2,8 @@<RESET>
+	:    <REVERSE><CYAN>@@<RESET>
 	:     <RESET>
 	:         s/4/A/<RESET>
 	:     <RESET>
@@ -220,7 +220,7 @@ test_expect_success 'dual-coloring' '
 	:      --- a/file<RESET>
 	:      +++ b/file<RESET>
 	:<RED>3:  0559556 <RESET><YELLOW>!<RESET><GREEN> 3:  b9cb956<RESET><YELLOW> s/11/B/<RESET>
-	:    <REVERSE><CYAN>@@ -10,7 +10,7 @@<RESET>
+	:    <REVERSE><CYAN>@@<RESET>
 	:      9<RESET>
 	:      10<RESET>
 	:    <RED> -11<RESET>
@@ -230,7 +230,7 @@ test_expect_success 'dual-coloring' '
 	:      13<RESET>
 	:      14<RESET>
 	:<RED>4:  d966c5c <RESET><YELLOW>!<RESET><GREEN> 4:  8add5f1<RESET><YELLOW> s/12/B/<RESET>
-	:    <REVERSE><CYAN>@@ -8,7 +8,7 @@<RESET>
+	:    <REVERSE><CYAN>@@<RESET>
 	:    <CYAN> @@ A<RESET>
 	:      9<RESET>
 	:      10<RESET>
-- 
2.22.0.510.g264f2c817a


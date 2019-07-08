Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 685751F461
	for <e@80x24.org>; Mon,  8 Jul 2019 16:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732775AbfGHQiL (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 12:38:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33509 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730469AbfGHQiI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 12:38:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so17910320wru.0
        for <git@vger.kernel.org>; Mon, 08 Jul 2019 09:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MBG8XPPKz8ibxbYni/vjeLuUiVvXX0RsyKnVNaocxMY=;
        b=FLWSBrIQmB3II4N5gjOgMdjENxwgxeQIoa8px0LYIkxC4HBxfI2xUSfXDnuxX9p5Li
         CPKd++RK+WneljgkFR3/0zJ+FAG0ohl1QuJ06GkvxBi6DDnkoh7ILKMXsnqXU50LZwOp
         KGVBzJpuz5k195VxJr+vlqf3NbMu0p5LYKHFeltfDrUTx33oLJy/P9FnsaR9rIztfbNY
         z5Q1udGM+kFDVrafD7bAYx3Fo3Xqn5W6CRb4cjjc8E9T+tkjnUcU8Gh/y2v2XyEOEk/c
         Uh1V/7q44IMa2mIQwF9k4Wru2y+R4HGMRexsz4uQgg5kFPwS0lvgca3BCpeDwqj+6CtJ
         tCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MBG8XPPKz8ibxbYni/vjeLuUiVvXX0RsyKnVNaocxMY=;
        b=JU4whZYF6QWvXXhwGn54HQiqgkO00WEvfHxDuVv11Zbg8vSLDwXuAUfFSTrHX3CGve
         Z//ejKuX69nmdpC8APeaUPIDAN/FYVxAMQr3xgpLnJiQG+HcVWY2QUge0dHECSEurStP
         z09gIswPtljpckzIaS7GwUz/tuxQnxmPI8uv4hxzBA+hg6UqHzPY+EY9HOx49hFD5jLd
         Kjb5kAnzw15o3YBFS3FFB2KP8E7MSEwl/7qkDe6iaD/rxwedqJJ2gCplEHHYYzW8vREy
         lI7nz5/NxMEomHpeZUMm2BjpcgIGbNBd/qWKHXU8e/vf9MHLJEXXd3exRdxr/esP4oTt
         eSeQ==
X-Gm-Message-State: APjAAAVHJm8vuwqBWEn9bOf1LnQE+ZkqeSa6nEblcpj2f2GRppJbA1HP
        +XFlJBIAF9riahaeyq0BapRAXyjg
X-Google-Smtp-Source: APXvYqwVs0eVVM8NvQ4p1Cjb5qA+wUygufuJvaEEdeaAvQLomJZYK4VvwfCIYnrJiieQpX0XBHBwCA==
X-Received: by 2002:a5d:4ec1:: with SMTP id s1mr18500297wrv.19.1562603886446;
        Mon, 08 Jul 2019 09:38:06 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id z2sm15327934wrt.41.2019.07.08.09.38.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:38:05 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 11/14] range-diff: suppress line count in outer diff
Date:   Mon,  8 Jul 2019 17:33:12 +0100
Message-Id: <20190708163315.29912-12-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190708163315.29912-1-t.gummerer@gmail.com>
References: <20190705170630.27500-1-t.gummerer@gmail.com>
 <20190708163315.29912-1-t.gummerer@gmail.com>
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
index a5202d8b6c..f4a90b33b8 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -486,6 +486,7 @@ int show_range_diff(const char *range1, const char *range2,
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


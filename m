Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AC1E20179
	for <e@80x24.org>; Sun, 26 Jun 2016 17:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbcFZRQ1 (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 13:16:27 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36012 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbcFZRQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 13:16:25 -0400
Received: by mail-lf0-f65.google.com with SMTP id a2so26531565lfe.3
        for <git@vger.kernel.org>; Sun, 26 Jun 2016 10:16:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S925x320g/KpzmxZwnRvRsvKgIa+ob5G2EXGxMH5jpg=;
        b=zx2umEOZ8ncE9+IW76offViq0Yng4vrl2GAMiIHoGb0N7oS50CUd2VJRuYVRRxztmm
         ylQxsyr9RJac4oRfrKLMhBFMqJTEPE0eQS1Fvp1vExWwX5Q1XRtmcHjPwg2xqGCamy7j
         OCC/fvjfMUt4gFRI+zTsc1hOue+04Tb6siU4L/E0Yu4wMfDnQw2CocIFxv5Sq6cb4ctl
         qnNDEGVnHxyFMQvb24k0wURHkk5arAFy9xJvRxerNEJT0dz0QrXmtPpQlgMzZL064jmZ
         KmPTdMBGde57nkmjVU68hDUs6pgiqagmqZDWIk2954J86i8k1Zm/0V4Vn7iumz7PczMR
         auzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S925x320g/KpzmxZwnRvRsvKgIa+ob5G2EXGxMH5jpg=;
        b=m6+Q00ReYQI3D7vWFCOAcO2Yf/XJ43M605gAosvzKe77u7GmCqerPY275uJcqEhuox
         bRnqyeXt2fK+P2tGoy4LD10v7PniEF8jlRmPEvxEvCaFlEncA7a2xghqDZ8y0q1xCos0
         FtrXaPgBP7zWt/0e5wJZygZTsBtBq/RZoUkd/3iZ8KsRYZdHpxEApKzZHxyTHQ49aSzE
         NyxCW9+EihnU5dy6CwTwtitfWtxEIhxQQTEVskX6NNjutb1eDrDDTvtwga8YhTfPG59O
         1cabi3Fl4xhd3QAZ7X+NI2ycf2C1f00De3KmPlVifvqRgHF+sEiV3+HyVKmtckBkCLPs
         SEsw==
X-Gm-Message-State: ALyK8tJwffMmmJ3isPb9MQNve/Z6IReARxMLzVY4Otuxw+XzFYaMoqYuprbBfEMloj5ooQ==
X-Received: by 10.46.1.166 with SMTP id f38mr4025722lji.25.1466961383936;
        Sun, 26 Jun 2016 10:16:23 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 76sm2624773lfu.26.2016.06.26.10.16.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 Jun 2016 10:16:23 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] diff.c: refactor strip_prefix()
Date:	Sun, 26 Jun 2016 19:16:14 +0200
Message-Id: <20160626171616.27948-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.531.gd073806
In-Reply-To: <20160626171616.27948-1-pclouds@gmail.com>
References: <20160626171616.27948-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

By passing "struct diff_options *" to strip_prefix(), we can do some
more intelligent and repeated logic at one place. The removal of
"if (opt->prefix_length)" is just the beginning.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index fa78fc1..b4949a2 100644
--- a/diff.c
+++ b/diff.c
@@ -3147,8 +3147,15 @@ static void diff_fill_sha1_info(struct diff_filespec *one)
 		hashclr(one->sha1);
 }
 
-static void strip_prefix(int prefix_length, const char **namep, const char **otherp)
+static void strip_prefix(struct diff_options *opt,
+			 const char **namep,
+			 const char **otherp)
 {
+	int prefix_length = opt->prefix_length;
+
+	if (!prefix_length)
+		return;
+
 	/* Strip the prefix but do not molest /dev/null and absolute paths */
 	if (*namep && **namep != '/') {
 		*namep += prefix_length;
@@ -3175,8 +3182,7 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 	name  = p->one->path;
 	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
 	attr_path = name;
-	if (o->prefix_length)
-		strip_prefix(o->prefix_length, &name, &other);
+	strip_prefix(o, &name, &other);
 
 	if (!DIFF_OPT_TST(o, ALLOW_EXTERNAL))
 		pgm = NULL;
@@ -3230,8 +3236,7 @@ static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
 	name = p->one->path;
 	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
 
-	if (o->prefix_length)
-		strip_prefix(o->prefix_length, &name, &other);
+	strip_prefix(o, &name, &other);
 
 	diff_fill_sha1_info(p->one);
 	diff_fill_sha1_info(p->two);
@@ -3254,8 +3259,7 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
 	attr_path = other ? other : name;
 
-	if (o->prefix_length)
-		strip_prefix(o->prefix_length, &name, &other);
+	strip_prefix(o, &name, &other);
 
 	diff_fill_sha1_info(p->one);
 	diff_fill_sha1_info(p->two);
@@ -4133,14 +4137,14 @@ static void diff_flush_raw(struct diff_filepair *p, struct diff_options *opt)
 		const char *name_a, *name_b;
 		name_a = p->one->path;
 		name_b = p->two->path;
-		strip_prefix(opt->prefix_length, &name_a, &name_b);
+		strip_prefix(opt, &name_a, &name_b);
 		write_name_quoted(name_a, opt->file, inter_name_termination);
 		write_name_quoted(name_b, opt->file, line_termination);
 	} else {
 		const char *name_a, *name_b;
 		name_a = p->one->mode ? p->one->path : p->two->path;
 		name_b = NULL;
-		strip_prefix(opt->prefix_length, &name_a, &name_b);
+		strip_prefix(opt, &name_a, &name_b);
 		write_name_quoted(name_a, opt->file, line_termination);
 	}
 }
@@ -4345,7 +4349,7 @@ static void flush_one_pair(struct diff_filepair *p, struct diff_options *opt)
 		const char *name_a, *name_b;
 		name_a = p->two->path;
 		name_b = NULL;
-		strip_prefix(opt->prefix_length, &name_a, &name_b);
+		strip_prefix(opt, &name_a, &name_b);
 		write_name_quoted(name_a, opt->file, opt->line_termination);
 	}
 }
-- 
2.8.2.531.gd073806


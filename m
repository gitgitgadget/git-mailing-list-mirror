Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 466B61F51C
	for <e@80x24.org>; Wed, 30 May 2018 08:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937244AbeE3IEb (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 04:04:31 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55943 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936051AbeE3IEP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 04:04:15 -0400
Received: by mail-it0-f68.google.com with SMTP id 144-v6so22013361iti.5
        for <git@vger.kernel.org>; Wed, 30 May 2018 01:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aKXCYg+8/8yOFx3wCWH994xLx/BfLXiOinjf2ZzvOFc=;
        b=FhtHT0nf0RjDZEHJPaEoXJ9K/3Nh3Rw/2VGiEgqFtrYbvKK+oiVuqp+oqS48rdkFqe
         40vffjIiFJBjy6dpXfXtO4e+MWnFF/otShkccjVUjln7tt17zJUW5QtN4I6GUI1nh7Ju
         TP+RFa00K4S48CgkXHlcW5Ule5p+4opkG98O1Mkpezcz3zqVbv1REJzQNLlKW2w2OL0O
         YhBIR2VziIhuV+dUQ0taabntH/8zZsKX0DkWy5eUZUZlxnu7FTZ2y+ZgGSVt01LdPK+q
         Al2dj1vABvptzvrZp/K2ebP2GHj+XLxXz7hkmUiPDRh4FFhej6xObld/vQS0enb9eU+H
         oFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=aKXCYg+8/8yOFx3wCWH994xLx/BfLXiOinjf2ZzvOFc=;
        b=MXn3pf9roOCjkvVYVp6NhQOAmUkUCl4vSewbMo2JEU4Si767/x5WL8cL4tbQjdgmdN
         PGNWt6x6ryWCoVnTpE0XEco9zBqpn3G+4ngBiErEWOnCGyzzvLUFxvtcyqhWf673GUxV
         41AS1u7Y+/Y4+d4MlEIL2CxhZGi6RpysLbV5VvBFXXShFu5dXIRj4XNVouiZ8zH6lCd0
         VHfGF/+I+/Vin+r60lB/jj+Kbd60/irGoSrBwCqFpfBoqSRJugllCWJpCKykCdJkex8s
         h1RmQoIADr6alrsxggMKg2mqE0vFrcoysV0z5p+i8hdqUTyfs9EbPVlgTp57fiprtzn4
         yCvA==
X-Gm-Message-State: APt69E2YfQyLLFAY5BlFen73QqXXemJjvQOR9IkmF2mFoW7iCTWTT6PY
        LRPwWQZUZmvAE977zmsoYpMH6g==
X-Google-Smtp-Source: ADUXVKI1GrRfNmgaFN/FAnbh6fz/bT7vFaNFgYIiut16KLHbwZlpDEc/vpoXIf9hyevtZh5PpPX6iw==
X-Received: by 2002:a24:1a85:: with SMTP id 127-v6mr656420iti.143.1527667453097;
        Wed, 30 May 2018 01:04:13 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id t9-v6sm17447561ioa.82.2018.05.30.01.04.12
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 30 May 2018 01:04:12 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [RFC PATCH 1/5] format-patch: allow additional generated content in make_cover_letter()
Date:   Wed, 30 May 2018 04:03:21 -0400
Message-Id: <20180530080325.37520-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.17.1.1235.ge295dfb56e
In-Reply-To: <20180530080325.37520-1-sunshine@sunshineco.com>
References: <20180530080325.37520-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

make_cover_letter() returns early when it lacks sufficient state to emit
a diffstat, which makes it difficult to extend the function to reliably
emit additional generated content. Work around this shortcoming by
factoring diffstat-printing logic out to its own function and calling it
as needed without otherwise inhibiting normal control flow.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/log.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 71f68a3e4f..e01a256c11 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -992,6 +992,26 @@ static char *find_branch_name(struct rev_info *rev)
 	return branch;
 }
 
+static void emit_diffstat(struct rev_info *rev,
+			  struct commit *origin, struct commit *head)
+{
+	struct diff_options opts;
+
+	memcpy(&opts, &rev->diffopt, sizeof(opts));
+	opts.output_format = DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
+	opts.stat_width = MAIL_DEFAULT_WRAP;
+
+	diff_setup_done(&opts);
+
+	diff_tree_oid(&origin->tree->object.oid,
+		      &head->tree->object.oid,
+		      "", &opts);
+	diffcore_std(&opts);
+	diff_flush(&opts);
+
+	fprintf(rev->diffopt.file, "\n");
+}
+
 static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			      struct commit *origin,
 			      int nr, struct commit **list,
@@ -1005,7 +1025,6 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	struct strbuf sb = STRBUF_INIT;
 	int i;
 	const char *encoding = "UTF-8";
-	struct diff_options opts;
 	int need_8bit_cte = 0;
 	struct pretty_print_context pp = {0};
 	struct commit *head = list[0];
@@ -1055,25 +1074,9 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 
 	shortlog_output(&log);
 
-	/*
-	 * We can only do diffstat with a unique reference point
-	 */
-	if (!origin)
-		return;
-
-	memcpy(&opts, &rev->diffopt, sizeof(opts));
-	opts.output_format = DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
-	opts.stat_width = MAIL_DEFAULT_WRAP;
-
-	diff_setup_done(&opts);
-
-	diff_tree_oid(&origin->tree->object.oid,
-		      &head->tree->object.oid,
-		      "", &opts);
-	diffcore_std(&opts);
-	diff_flush(&opts);
-
-	fprintf(rev->diffopt.file, "\n");
+	/* We can only do diffstat with a unique reference point */
+	if (origin)
+		emit_diffstat(rev, origin, head);
 }
 
 static const char *clean_message_id(const char *msg_id)
-- 
2.17.1.1235.ge295dfb56e


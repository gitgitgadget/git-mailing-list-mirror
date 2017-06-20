Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FD231FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbdFTCtb (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:49:31 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33828 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbdFTCsq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:46 -0400
Received: by mail-pf0-f179.google.com with SMTP id s66so62711260pfs.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Lj0OdFZRjXKttXF086iMB6tPRl13lD0Im3HYn2bLPA=;
        b=NtSOaI2zA1voOAAPbbITOqE/NTnCtVPnPUEyE0njMzeYaEYks2UXolyJhrZueEgwJI
         KZwpFeWHKp33nfa2NsvwXwqTHley02crPcWqOwrXDmvrfU6b+nOs1sqxxe4fnG4IUXW6
         RqYsStU4UN7x9yV5KJmpeybL768/ZbxJ/v2Z9ZygHJMSPhIw/vT8yUIA+yvVMtWbGwh9
         hW5CnD75yAQcjQFBf9bKgzyf4DsBSNYuurU5nepEkBjy6GquVvXPYLNnaKgCNj+Tigu4
         MhJN7uE4rK1Lzunb1WBjVPmJBQ10mKJlvJDnxZ5SthP7wXdJGdM4fv83MOc2TdP3YBP7
         L9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Lj0OdFZRjXKttXF086iMB6tPRl13lD0Im3HYn2bLPA=;
        b=LT1shn4oV4w8UKrAICFVJIgwXkPf7DAFGCcmSu6SkIjgL6OWVHmeCG2cxZo6EPBZrV
         7hXt48qyAACQEDodliW4V3Blog7Eo43HOiCv4Hvzm50//g6s2eoLV6b1QF5rntrurcJQ
         C0mMIT7fQm7zbHYBR4WP6KIIDZAbXHwLZ8qiN+fMjTxq3bC1mpgP3NvV7nemlvVgvpTM
         5lLeHq1oI8Wkyd2tlHze82vyt+uf2V2dD9HyL/7fL39FBR87zYvrUoBgAseUXkW2zm7D
         68u4gjWIh6Mv4ZwP/NDZ0YVTHzjOhteuM6j40qZuH0NKkxiJin/cSiWYvu+2id5CeEz2
         3lcA==
X-Gm-Message-State: AKS2vOzBulCcEYAjwWFKbGWUZ3sVZN+qPzRSwcZ0PfqurPiL4dtz4jxa
        q9oU6M4pWbx/XrU6
X-Received: by 10.98.215.23 with SMTP id b23mr27615777pfh.95.1497926920580;
        Mon, 19 Jun 2017 19:48:40 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id g78sm21897115pfb.122.2017.06.19.19.48.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:39 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 13/26] diff.c: emit_diff_symbol learns about DIFF_SYMBOL_BINARY_FILES
Date:   Mon, 19 Jun 2017 19:48:03 -0700
Message-Id: <20170620024816.20021-14-sbeller@google.com>
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
 diff.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 95f11ea86f..e56962b844 100644
--- a/diff.c
+++ b/diff.c
@@ -572,6 +572,7 @@ enum diff_symbol {
 	DIFF_SYMBOL_WORDS,
 	DIFF_SYMBOL_FILEPAIR,
 	DIFF_SYMBOL_HEADER,
+	DIFF_SYMBOL_BINARY_FILES,
 };
 /*
  * Flags for content lines:
@@ -689,6 +690,10 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 	case DIFF_SYMBOL_HEADER:
 		fprintf(o->file, "%s", line);
 		break;
+	case DIFF_SYMBOL_BINARY_FILES:
+		fprintf(o->file, "%sBinary files %s differ\n",
+			diff_line_prefix(o), line);
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
@@ -2537,6 +2542,7 @@ static void builtin_diff(const char *name_a,
 	} else if (!DIFF_OPT_TST(o, TEXT) &&
 	    ( (!textconv_one && diff_filespec_is_binary(one)) ||
 	      (!textconv_two && diff_filespec_is_binary(two)) )) {
+		struct strbuf sb = STRBUF_INIT;
 		if (!one->data && !two->data &&
 		    S_ISREG(one->mode) && S_ISREG(two->mode) &&
 		    !DIFF_OPT_TST(o, BINARY)) {
@@ -2549,8 +2555,10 @@ static void builtin_diff(const char *name_a,
 			}
 			emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
 					 header.buf, header.len, 0);
-			fprintf(o->file, "%sBinary files %s and %s differ\n",
-				line_prefix, lbl[0], lbl[1]);
+			strbuf_addf(&sb, "%s and %s", lbl[0], lbl[1]);
+			emit_diff_symbol(o, DIFF_SYMBOL_BINARY_FILES,
+					 sb.buf, sb.len, 0);
+			strbuf_release(&sb);
 			goto free_ab_and_return;
 		}
 		if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
@@ -2567,9 +2575,12 @@ static void builtin_diff(const char *name_a,
 		strbuf_reset(&header);
 		if (DIFF_OPT_TST(o, BINARY))
 			emit_binary_diff(o->file, &mf1, &mf2, line_prefix);
-		else
-			fprintf(o->file, "%sBinary files %s and %s differ\n",
-				line_prefix, lbl[0], lbl[1]);
+		else {
+			strbuf_addf(&sb, "%s and %s", lbl[0], lbl[1]);
+			emit_diff_symbol(o, DIFF_SYMBOL_BINARY_FILES,
+					 sb.buf, sb.len, 0);
+			strbuf_release(&sb);
+		}
 		o->found_changes = 1;
 	} else {
 		/* Crazy xdl interfaces.. */
-- 
2.12.2.575.gb14f27f917


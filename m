Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 352C61F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeHKBVe (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:21:34 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:36245 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeHKBVd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:21:33 -0400
Received: by mail-qk0-f201.google.com with SMTP id c27-v6so10883541qkj.3
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KcvDfM4h56GMHCsACiz3eCiMFIK43yUKhwICuNUL7ss=;
        b=BmqbBFLlK3xRq58l9Gt66cu2IwG+H1u4B1ePVZzfsQ7Pq3X9r0JI4hcj6sGB1n8WUl
         uOpU4rFGTP5Q7qwN2S4+AvihDeCNgzCHe0HhsANkGF7W2VlUjiQUch5cEnvZa1uUIoOP
         GetAX38VAaMK6idbBJo96BIabeXn5HqzEtJ0DIlRx9mFBdwVBEdQuuDhonAS73Ieijtp
         dzhBNNclDu1+LxhO6jwtk1GARlTCc4JNAM7kI6jEhv1xW5NsYD3dqgTQJbmIVnpWciAX
         YLplNs6xDO9hTi8AMBNs9JjDTL5SNkdQ2LKRx2+J1z4Fjob32iHEmXd3m3yDjRDewAiY
         8O/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KcvDfM4h56GMHCsACiz3eCiMFIK43yUKhwICuNUL7ss=;
        b=cWca8fz/KAVciHeAh3e9zC+7HqNlSNmivMOI4+cjrF+64FDsXJOQZIFSXiBG3XWu20
         YAVwZSbceym6vISeKZbRII+uUFetuVvMKwNmYwrsm95Bgp4AT6CULgj6QHwrpk1ZGlBh
         Sm1s7v5p9FFy6OG+F1IGLRmVFdHKwna8fsQG+2zUV/vatqqhnQo8Vy0VjHp4NUQ36nkK
         /1q9Up/urbC2veiRi3EX6v572WUFafLio/Ddqb2JOMn7hJEJV7r6IFTywSvymcI6mb22
         2tU7O8Giof5P+RYrEb2gGcNXIsEZ5VrqP+aHWOwqf5y6nIwsaDN1U8EK9JkaS5yYtybC
         TSwQ==
X-Gm-Message-State: AOUpUlErZlrntFMdDg6NQOnTeptL1JU8C/kig3Ff8COgxBZrCMVnE5n6
        mZe4FfPBx0kYerB3GCYGudnvdh7uhbu1
X-Google-Smtp-Source: AA+uWPx6HZhBDwtb6y2qjJgkBF30IURen33xM4nFkeqaWgodYM459PyFHjuHw9W0zWDxQIwx4dNFDCYC6XEt
X-Received: by 2002:ac8:44d2:: with SMTP id b18-v6mr4575179qto.51.1533941380547;
 Fri, 10 Aug 2018 15:49:40 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:49:21 -0700
In-Reply-To: <20180810224923.143625-1-sbeller@google.com>
Message-Id: <20180810224923.143625-3-sbeller@google.com>
Mime-Version: 1.0
References: <20180810224923.143625-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 2/4] diff.c: add --output-indicator-{new, old, context}
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will prove useful in range-diff in a later patch as we will be able to
differentiate between adding a new file (that line is starting with +++
and then the file name) and regular new lines.

It could also be useful for experimentation in new patch formats, i.e.
we could teach git to emit moved lines with lines other than +/-.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 21 +++++++++++++++++----
 diff.h |  5 +++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index b3cb73eb69a..b75eb085cb3 100644
--- a/diff.c
+++ b/diff.c
@@ -1237,7 +1237,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 					 struct emitted_diff_symbol *eds)
 {
 	static const char *nneof = " No newline at end of file\n";
-	const char *context, *reset, *set, *set_sign, *meta, *fraginfo;
+	const char *context, *reset, *set, *set_sign, *meta, *fraginfo, *first;
 	struct strbuf sb = STRBUF_INIT;
 
 	enum diff_symbol s = eds->s;
@@ -1288,7 +1288,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			else if (c == '-')
 				set = diff_get_color_opt(o, DIFF_FILE_OLD);
 		}
-		emit_line_ws_markup(o, set_sign, set, reset, " ", line, len,
+		first = o->output_indicators[OI_CONTEXT] ?
+			o->output_indicators[OI_CONTEXT] : " ";
+		emit_line_ws_markup(o, set_sign, set, reset, first, line, len,
 				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
 		break;
 	case DIFF_SYMBOL_PLUS:
@@ -1331,7 +1333,10 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 				set = diff_get_color_opt(o, DIFF_CONTEXT_BOLD);
 			flags &= ~DIFF_SYMBOL_CONTENT_WS_MASK;
 		}
-		emit_line_ws_markup(o, set_sign, set, reset, "+", line, len,
+
+		first = o->output_indicators[OI_NEW] ?
+			o->output_indicators[OI_NEW] : "+";
+		emit_line_ws_markup(o, set_sign, set, reset, first, line, len,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
 				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
 		break;
@@ -1374,7 +1379,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			else
 				set = diff_get_color_opt(o, DIFF_CONTEXT_DIM);
 		}
-		emit_line_ws_markup(o, set_sign, set, reset, "-", line, len,
+		first = o->output_indicators[OI_OLD] ?
+			o->output_indicators[OI_OLD] : "-";
+		emit_line_ws_markup(o, set_sign, set, reset, first, line, len,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
 		break;
 	case DIFF_SYMBOL_WORDS_PORCELAIN:
@@ -4876,6 +4883,12 @@ int diff_opt_parse(struct diff_options *options,
 		 options->output_format |= DIFF_FORMAT_DIFFSTAT;
 	} else if (!strcmp(arg, "--no-compact-summary"))
 		 options->flags.stat_with_summary = 0;
+	else if (skip_prefix(arg, "--output-indicator-new=", &arg))
+		options->output_indicators[OI_NEW] = arg;
+	else if (skip_prefix(arg, "--output-indicator-old=", &arg))
+		options->output_indicators[OI_OLD] = arg;
+	else if (skip_prefix(arg, "--output-indicator-context=", &arg))
+		options->output_indicators[OI_CONTEXT] = arg;
 
 	/* renames options */
 	else if (starts_with(arg, "-B") ||
diff --git a/diff.h b/diff.h
index e1e54256c18..2d4097df1c7 100644
--- a/diff.h
+++ b/diff.h
@@ -194,6 +194,11 @@ struct diff_options {
 	FILE *file;
 	int close_file;
 
+#define OI_NEW 0
+#define OI_OLD 1
+#define OI_CONTEXT 2
+	const char *output_indicators[3];
+
 	struct pathspec pathspec;
 	pathchange_fn_t pathchange;
 	change_fn_t change;
-- 
2.18.0.865.gffc8e1a3cd6-goog


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62E17202F2
	for <e@80x24.org>; Thu, 23 Nov 2017 15:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752841AbdKWPnK (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 10:43:10 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36254 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752611AbdKWPnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 10:43:09 -0500
Received: by mail-qt0-f195.google.com with SMTP id a19so28366105qtb.3
        for <git@vger.kernel.org>; Thu, 23 Nov 2017 07:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Gcm+pkM5dJqpehe8aF5e0n2u8r+x05C16siOviuGxv8=;
        b=n2M4uRzRGir22B3S1E3szSJ1Cx6mFzoJXyrnnDnSTKdvayuT4se7UXS+U9FFrNu5oG
         ICzp5+zE4sQ9s83koRWWxsMUO9AbeKMG7ZNQ6JRyZO/GVOQYLZor/9GXHP7VInBYgp/8
         dUJyncamTHa5h3QaNX3WNEoDFGemspwo3mEp4Yxw71kLORHNQOce8QxusM51lzPb0Vhp
         jkxIUVHPEsoIxJ1kqsL6S+XKY+UIxVIbKE+H2F7sfEKjkpGRNoAkCfrNlqcvRHEJSoBQ
         zFVSdBuRQ90i5U48SivIyfBX/OqL/SKsm6+099qvrxp83/ztgdL19JLHJiAyqozmIceB
         7X8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Gcm+pkM5dJqpehe8aF5e0n2u8r+x05C16siOviuGxv8=;
        b=HkeC/zpVBLTflrWQgvY9S+Ql4sU3tqdC8H6371VBc9mfLdzOr1Aim6A/PT65jeXL/h
         GPPOjZT3MUdZqsdfR2ShBYlf8HunVcRSOmED2auZnQSWQDuaH4XiNemjsxiapjtlNZuc
         dZYl37uiCZ4K6uLYH3tP4oV74wG3R0TgrxvLKLfbjpI2siV7VUMhcoFab4C3PK8NARRv
         1wyiFXlV4jUwj4wdOaI0s3/qJApnST71q1hyN/lyiOq6QtjIr5A0A1vZ6ICEkjCX6N4f
         vhdZrFt5bSK+ud6puSBznmX+XIXAtUCAnp9QwgeFi3rGbBCYyTmXDnYBMMOvCka0EczS
         podw==
X-Gm-Message-State: AJaThX4eiq4N+ffSFmR+T09796LOtvu9yL1L27CpkT+V0LQb/jowqc2Y
        UP+1D8kwhUdmf6s1HNJKan2CY6rr
X-Google-Smtp-Source: AGs4zMYPcJv3ztzbXtiD/ofnkMiAA69E/9hirf5nL0jxqOUjSPcBxpbC5xT7ZZEB/5+pmzqBeQnk0Q==
X-Received: by 10.200.35.248 with SMTP id r53mr37465991qtr.110.1511451787975;
        Thu, 23 Nov 2017 07:43:07 -0800 (PST)
Received: from ogre.lan (modemcable022.17-70-69.static.videotron.ca. [69.70.17.22])
        by smtp.gmail.com with ESMTPSA id z7sm13091823qtz.40.2017.11.23.07.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Nov 2017 07:43:07 -0800 (PST)
From:   Marc-Antoine Ruel <maruel@chromium.org>
To:     git@vger.kernel.org
Cc:     Marc-Antoine Ruel <maruel@chromium.org>
Subject: [PATCH] grep: Add option --max-line-len
Date:   Thu, 23 Nov 2017 10:41:59 -0500
Message-Id: <20171123154159.17408-1-maruel@chromium.org>
X-Mailer: git-send-email 2.15.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This tells git grep to skip files longer than a specified length,
which is often the result of generators and not actual source files.

Signed-off-by: Marc-Antoine Ruel <maruel@chromium.org>
---
 Documentation/git-grep.txt | 5 +++++
 builtin/grep.c             | 2 ++
 grep.c                     | 4 ++++
 grep.h                     | 1 +
 t/t7810-grep.sh            | 5 +++++
 5 files changed, 17 insertions(+)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 18b494731..75081defb 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git grep' [-a | --text] [-I] [--textconv] [-i | --ignore-case] [-w | --word-regexp]
+	   [-M | --max-line-len <num>]
 	   [-v | --invert-match] [-h|-H] [--full-name]
 	   [-E | --extended-regexp] [-G | --basic-regexp]
 	   [-P | --perl-regexp]
@@ -127,6 +128,10 @@ OPTIONS
 	beginning of a line, or preceded by a non-word character; end at
 	the end of a line or followed by a non-word character).
 
+-M<num>::
+--max-line-len<num>::
+	Match the pattern only for line shorter or equal to this length.
+
 -v::
 --invert-match::
 	Select non-matching lines.
diff --git a/builtin/grep.c b/builtin/grep.c
index 5a6cfe6b4..cc5c70be5 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -796,6 +796,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			N_("case insensitive matching")),
 		OPT_BOOL('w', "word-regexp", &opt.word_regexp,
 			N_("match patterns only at word boundaries")),
+		OPT_INTEGER('M', "max-line-len", &opt.max_line_length,
+			N_("ignore lines longer than <n>")),
 		OPT_SET_INT('a', "text", &opt.binary,
 			N_("process binary files as text"), GREP_BINARY_TEXT),
 		OPT_SET_INT('I', NULL, &opt.binary,
diff --git a/grep.c b/grep.c
index d0b9b6cdf..881078b82 100644
--- a/grep.c
+++ b/grep.c
@@ -36,6 +36,7 @@ void init_grep_defaults(void)
 	opt->relative = 1;
 	opt->pathname = 1;
 	opt->max_depth = -1;
+	opt->max_line_length = -1;
 	opt->pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED;
 	color_set(opt->color_context, "");
 	color_set(opt->color_filename, "");
@@ -151,6 +152,7 @@ void grep_init(struct grep_opt *opt, const char *prefix)
 	opt->pattern_type_option = def->pattern_type_option;
 	opt->linenum = def->linenum;
 	opt->max_depth = def->max_depth;
+	opt->max_line_length = def->max_line_length;
 	opt->pathname = def->pathname;
 	opt->relative = def->relative;
 	opt->output = def->output;
@@ -1273,6 +1275,8 @@ static int match_line(struct grep_opt *opt, char *bol, char *eol,
 	struct grep_pat *p;
 	regmatch_t match;
 
+	if (opt->max_line_length > 0 && eol-bol > opt->max_line_length)
+		return 0;
 	if (opt->extended)
 		return match_expr(opt, bol, eol, ctx, collect_hits);
 
diff --git a/grep.h b/grep.h
index 399381c90..0e76c0a19 100644
--- a/grep.h
+++ b/grep.h
@@ -151,6 +151,7 @@ struct grep_opt {
 	int null_following_name;
 	int color;
 	int max_depth;
+	int max_line_length;
 	int funcname;
 	int funcbody;
 	int extended_regexp_option;
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 2a6679c2f..c514bd388 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -766,6 +766,11 @@ test_expect_success 'grep -W shows no trailing empty lines' '
 	test_cmp expected actual
 '
 
+test_expect_success 'grep skips long lines' '
+	git grep -M18 -W include >actual &&
+	test_cmp expected actual
+'
+
 cat >expected <<EOF
 hello.c=	printf("Hello world.\n");
 hello.c:	return 0;
-- 
2.15.0


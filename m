Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B2D51F403
	for <e@80x24.org>; Mon, 18 Jun 2018 23:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937031AbeFRXnR (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 19:43:17 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33547 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937005AbeFRXnO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 19:43:14 -0400
Received: by mail-ot0-f196.google.com with SMTP id h6-v6so20560572otj.0
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 16:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X5+yHcmvxVJW/TH6i/tbrDhBU9y2BpAc5WapgN83PrU=;
        b=eakbip80O0fIgplVeYL2edn1aOnLiCXOv7AXE6CvcbJZcFDo/g3TPqdQIv3M2rriho
         Qz+KK0sSPtvs3cuSlskoCzxOjYW3UeP0hmmJkNEkx9mmGoMHhRQ5UBB7wDmnYeGhuW+6
         nF/b6ezVLnz4MUClEpY5eDS5WgsiPj/3hgkQh2bwxAb0HLF8M9yZZxqzAwpX6E3CeyNl
         sOT/+wyMkJ32hZzU8s0BDf+/zOC6RTHnRsxvzOY1OEqogP5B9XcjBrC+KO3C1smuP2qL
         9toA64fLGyrZaEzhsw+pzIaGkFKZ/YCPHyyQAhf1Vld+9vJ081wZaTRfK4DWjg77CnlE
         fp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X5+yHcmvxVJW/TH6i/tbrDhBU9y2BpAc5WapgN83PrU=;
        b=sMgUnS6hK8sWGqNNYfXlAExKudB9euzjYO3YT0qc8GflwxPQXf74mFRv7ahLyImMcL
         ucekerw5YN/eXPFa9ZzV98ZnbxQt9XHd64YMxWjhMVaI3JA7fB/ivEXUGaZ33vM8/hbU
         KqnOzxSTLckM34X5I56NoQtPv7fndOSSrGve4Ko/YRWnI0HjeQMjQ1DVAPRARLGQAK6N
         2haWzKoUQUbbrUFesncF9SVvDitY9rrTEVprVPVHlKPTwiipDhIeHUI8X4vqqjPmqWC2
         gMEtTLGfWMNf1wI0PwwDJh3Ywz2/JwYsWMepWg0IOB9Y2tuMa2R2s03l0s+9Td4Q99+W
         WhZw==
X-Gm-Message-State: APt69E3dcVnJMiXUrL9SYhLhtJ/ik9rq1nRwVRMuTXac+RwuKEVABkSb
        p46GX0hubKk+y7/zWBFEQg0aGdRGZSw=
X-Google-Smtp-Source: ADUXVKJgFVX6wXCKLo/dgg7UasO0RhCYraS+4XaSGURzlUsGn5Deh8+W57pa9vfV0TfT3abrW2v34g==
X-Received: by 2002:a9d:5f09:: with SMTP id f9-v6mr9624346oti.386.1529365393783;
        Mon, 18 Jun 2018 16:43:13 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id p44-v6sm8504900ota.19.2018.06.18.16.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 16:43:12 -0700 (PDT)
Date:   Mon, 18 Jun 2018 18:43:11 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH 3/7] grep.[ch]: extend grep_opt to allow showing matched
 column
Message-ID: <4b22c427f14c4e0a17f04b41788f38ff366f1ad4.1529365072.git.me@ttaylorr.com>
References: <cover.1529365072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529365072.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To support showing the matched column when calling 'git-grep(1)', teach
'grep_opt' the normal set of options to configure the default behavior
and colorization of this feature.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 grep.c | 3 +++
 grep.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/grep.c b/grep.c
index 19c782aa9d..33f8572e6d 100644
--- a/grep.c
+++ b/grep.c
@@ -46,6 +46,7 @@ void init_grep_defaults(void)
 	color_set(opt->color_filename, "");
 	color_set(opt->color_function, "");
 	color_set(opt->color_lineno, "");
+	color_set(opt->color_columnno, "");
 	color_set(opt->color_match_context, GIT_COLOR_BOLD_RED);
 	color_set(opt->color_match_selected, GIT_COLOR_BOLD_RED);
 	color_set(opt->color_selected, "");
@@ -155,6 +156,7 @@ void grep_init(struct grep_opt *opt, const char *prefix)
 	opt->extended_regexp_option = def->extended_regexp_option;
 	opt->pattern_type_option = def->pattern_type_option;
 	opt->linenum = def->linenum;
+	opt->columnnum = def->columnnum;
 	opt->max_depth = def->max_depth;
 	opt->pathname = def->pathname;
 	opt->relative = def->relative;
@@ -164,6 +166,7 @@ void grep_init(struct grep_opt *opt, const char *prefix)
 	color_set(opt->color_filename, def->color_filename);
 	color_set(opt->color_function, def->color_function);
 	color_set(opt->color_lineno, def->color_lineno);
+	color_set(opt->color_columnno, def->color_columnno);
 	color_set(opt->color_match_context, def->color_match_context);
 	color_set(opt->color_match_selected, def->color_match_selected);
 	color_set(opt->color_selected, def->color_selected);
diff --git a/grep.h b/grep.h
index 399381c908..08a0b391c5 100644
--- a/grep.h
+++ b/grep.h
@@ -127,6 +127,7 @@ struct grep_opt {
 	int prefix_length;
 	regex_t regexp;
 	int linenum;
+	int columnnum;
 	int invert;
 	int ignore_case;
 	int status_only;
@@ -159,6 +160,7 @@ struct grep_opt {
 	char color_filename[COLOR_MAXLEN];
 	char color_function[COLOR_MAXLEN];
 	char color_lineno[COLOR_MAXLEN];
+	char color_columnno[COLOR_MAXLEN];
 	char color_match_context[COLOR_MAXLEN];
 	char color_match_selected[COLOR_MAXLEN];
 	char color_selected[COLOR_MAXLEN];
-- 
2.17.0.582.gccdcbd54c


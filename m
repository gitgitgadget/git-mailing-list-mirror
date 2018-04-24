Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C1781F424
	for <e@80x24.org>; Tue, 24 Apr 2018 05:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755754AbeDXFHt (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 01:07:49 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38592 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755709AbeDXFHp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 01:07:45 -0400
Received: by mail-pf0-f193.google.com with SMTP id o76so6528406pfi.5
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 22:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LOL8hxCc7m4rnbzhgjqL8Nx/yPAETdgL748ftH9Fzj4=;
        b=p4Zr+OzR7zk9zgrvQ1roe0/Ofy2zr7OMxg/h/qPsrVfDCeNhbxrmYaLLGH9xVBAtq+
         oQo6HohOG/b/6gnr4rhwkgQ4cBFSxsauQES5htcoldDHWypOFhZris2zH2AZcnRPRzmy
         afANZHO0Q/moFiqSLr/wf4O9/IiP9pqHXcaNEllobbDdngG/pO7Y5lH6VUWwOiXrC+Zq
         5XQsfxzT2aCv0cxsRo7gYkE4Pern5MDmHamwTEmWhYbZOgydJPtIXzG0VwR/Q3twaIqm
         xIUOh+3Y466ap1KqSpPc6wHwTJUdMyFMyJ3kb0m+/PWEDVe2mI1NFRFmQK6t/4qdW/1n
         OUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LOL8hxCc7m4rnbzhgjqL8Nx/yPAETdgL748ftH9Fzj4=;
        b=l/CKutErEGhGdf2bLy+xMv5NHlpxkDv8hQ2syc2qkwaB9M699tYcXC6nsX3DOCtrdD
         atztXMtyL99oWdT5zIqZRKS6BwOeum+vVtw+FQFwEBcqa/cjyUv5agSKMuU1dk5VmtEa
         UsfJouN97Pyk/1EXM+K7DRUQ7Mc5QCM/0p+gpMhMgIA5Rtxbl+DXhXNbjv7cOUiAs80y
         XtY4DvLA1JAJwtiFf7+PQ8/MMLfaCZ3f8pwXsiVPrexoHDY033RUyETHTSa4Yfd4eLYL
         +kMcRuUvuoCuz/dxjrFwrt/cn9/VtyJR/kh76X3HE4jK83kcBh//yCW5cIjKOae8JtZq
         uvyw==
X-Gm-Message-State: ALQs6tC2Xooz/JBnD8SyFTQ6HYGNO32EimZPo6vMSMam86l3VA1TYHHp
        JrNSTHbJ8of+KoDNI/KGvdVbVSF2fo+P4A==
X-Google-Smtp-Source: AIpwx4+KIniv4/FFT8v5yLdS+20nVr4MxHEEcR/6Sa7JNuq774NYpWO38NlKpyZjam8USl99Khf+kA==
X-Received: by 2002:a17:902:780d:: with SMTP id p13-v6mr23609822pll.281.1524546463738;
        Mon, 23 Apr 2018 22:07:43 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:3dfa:3e1b:ab89:1ffb])
        by smtp.gmail.com with ESMTPSA id c3sm27987712pfd.28.2018.04.23.22.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 22:07:42 -0700 (PDT)
Date:   Mon, 23 Apr 2018 22:07:41 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v3 3/7] grep.[ch]: extend grep_opt to allow showing matched
 column
Message-ID: <49579b4ce7b0964c156435cb0314184e6e7d7a13.1524545768.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1524545768.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524545768.git.me@ttaylorr.com>
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
index 1c25782355..fb0fa23231 100644
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
2.17.0


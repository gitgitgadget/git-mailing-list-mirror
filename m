Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A6FB1F424
	for <e@80x24.org>; Sun, 22 Apr 2018 20:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753639AbeDVUrg (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 16:47:36 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46727 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753587AbeDVUrd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 16:47:33 -0400
Received: by mail-pg0-f65.google.com with SMTP id t12so6908183pgp.13
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 13:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jZ0MeqK2hfeuQoi2IjGQdoYsAAD/WFWwYUjdSScIbNs=;
        b=mr12wwkYdhP94gvBjI8DvJnrtcc5gpMTU4uzi63of/0YF0kC+UHA3hwRSIfxY8Iaak
         jjHAFazuQooewA6WAMt2Lq4FZ+LizLlz+6OaT+rI4VUeWgJ57UJhoxso7Mlk/PxqW4k4
         pryTF1rjbwvphk7qGIQh0noLHuNmRmPtRgqAVfoAQmsyzf6ROjq5mHgi5IkCqCz9U0Dl
         m3Fs6AyaPbJFmyMbLn6cQlkQghq+sdhGGwkTFen7k7v/O4GfHyPqiV62zgU2RFfbjz1G
         cP/HzgBN3JEjD0ZKPtO5eBe9jOBWuqxkv+guEvAa1pCAyn7ng242qDUsj5663ZNhIv0N
         dgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jZ0MeqK2hfeuQoi2IjGQdoYsAAD/WFWwYUjdSScIbNs=;
        b=tsf8ROz8Zc9goZEtJE4z82L168kZT9wAU8DVU5YvKVyfVMLExc9jUcod5nGS62IqlP
         pj0HZT1qAS/1aT++xxcaIfg8/CYOwBtggCJZq8Eehh/k8ZaAzczxwvVSl1dAdw5zHzPf
         Yj6Ml/9i1wNG1JXP5vb6cDY1TRF026GUwAdESyqzUg3xuCnqV8KAtsWpiKF0GixGBJpr
         S7MVKvlbb5yaoZ62NsrJHYsqyaHLSgFoK0izFOHO/NhWjhaLIagSQsfTIP5bJnQ6CNrR
         Ypyb0FyfDnbkVuMpmTaGDolK3u9T0a0gqZ5F+vJ8eZezSIF6+fNFZfPpzS64c7bC8W3G
         dcuw==
X-Gm-Message-State: ALQs6tCcRVer0+D2P4BAozT+wQrDjSzyNAPSKf91xS/S208xYTeHznAN
        r0RJ7pkCrltLt/YgNa2xru3DnML9rOY=
X-Google-Smtp-Source: AIpwx4+TAQ2U1KB7OkosjPG7ithQtutum10ypG3s4xqDo9DY7siFuaQTh8XdUhMC5sXQnup4ykKo9Q==
X-Received: by 10.99.120.195 with SMTP id t186mr7094907pgc.97.1524430052347;
        Sun, 22 Apr 2018 13:47:32 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e8b3:eaad:c134:baec])
        by smtp.gmail.com with ESMTPSA id r8sm16103194pgn.19.2018.04.22.13.47.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Apr 2018 13:47:31 -0700 (PDT)
Date:   Sun, 22 Apr 2018 13:47:30 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, l.s.r@web.de, martin.agren@gmail.com,
        peff@peff.net
Subject: [PATCH v2 3/6] grep.[ch]: teach columnnum, color_columnno to grep_opt
Message-ID: <47f06ae36ce6af48fca06b140bdb5af2582116e1.1524429778.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1524429778.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524429778.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation of adding --column-number to 'git-grep(1)', we extend
grep_opt to take in the requisite new members.

We additionally teach the 'grep.columnnumber' and
'color.grep.columnnumber' configuration variables to configure showing
and coloring the column number, respectively. (These options remain
undocumented until 'git-grep(1)' learns the --column option in a
forthcoming commit.)

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 grep.c | 8 ++++++++
 grep.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/grep.c b/grep.c
index 29bc799ecf..922ab92eff 100644
--- a/grep.c
+++ b/grep.c
@@ -95,6 +95,10 @@ int grep_config(const char *var, const char *value, void *cb)
 		opt->linenum = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "grep.columnnumber")) {
+		opt->columnnum = git_config_bool(var, value);
+		return 0;
+	}
 
 	if (!strcmp(var, "grep.fullname")) {
 		opt->relative = !git_config_bool(var, value);
@@ -111,6 +115,8 @@ int grep_config(const char *var, const char *value, void *cb)
 		color = opt->color_function;
 	else if (!strcmp(var, "color.grep.linenumber"))
 		color = opt->color_lineno;
+	else if (!strcmp(var, "color.grep.columnnumber"))
+		color = opt->color_columnno;
 	else if (!strcmp(var, "color.grep.matchcontext"))
 		color = opt->color_match_context;
 	else if (!strcmp(var, "color.grep.matchselected"))
@@ -155,6 +161,7 @@ void grep_init(struct grep_opt *opt, const char *prefix)
 	opt->extended_regexp_option = def->extended_regexp_option;
 	opt->pattern_type_option = def->pattern_type_option;
 	opt->linenum = def->linenum;
+	opt->columnnum = def->columnnum;
 	opt->max_depth = def->max_depth;
 	opt->pathname = def->pathname;
 	opt->relative = def->relative;
@@ -164,6 +171,7 @@ void grep_init(struct grep_opt *opt, const char *prefix)
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


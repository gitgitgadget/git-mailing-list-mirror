Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A6771F404
	for <e@80x24.org>; Sat, 21 Apr 2018 03:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeDUDpj (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 23:45:39 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:47047 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeDUDpi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 23:45:38 -0400
Received: by mail-pg0-f67.google.com with SMTP id t12so4770021pgp.13
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 20:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O9VjAaTrL6m+hwIaeAeRtS7fuYoMbFEFL7gGddyv+qU=;
        b=RPmBMvrASLzvfhY0vydxFsc2b9y4kGwGgcb/OKhJ3duYbMrgZEiU5P8RpMc1QMe9++
         +zrAzhnQ0WnC0fv/YhfQO80pK2E82RAXEPW2fJrxDrBXVXh4j+fawts/tduT+Po/o+ok
         VQ57w2zCDcMRqTI3LU3vcL/RgRvQDRwKBUQwbK0azQPBU8ip43I40S5Fw4rY746gF5be
         lfGf+ImiSvS7ojw065ntElfHh9sGKAcaM9xTGoHt1FXH8OOmg4Yz0ec48+YQz6QGLDsB
         8jhmpoHj7UjGcbtmeo/a3g/WilNu+xS6ahFd0GluJ6J/mVFceFhdrw/UubHCUyzdJAuK
         eMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O9VjAaTrL6m+hwIaeAeRtS7fuYoMbFEFL7gGddyv+qU=;
        b=qZkp/56YQT4iQ3hJkq2kxU5ssAeD8PJ0gh9mhPXCTHRvhalWZu4d71F7PCUWpx4SzS
         9mP+o++PWIlO/3xe5NUXoccee+h+cLd8AJ3gHdgVVEPYOMJjB+y6BLCty9Tnk1C/Faf/
         AQu9zMOrx28dctmpdK0swF66WN9H01mR8Wn/O2yB/aob1eY+5j5YOl4fV5LmQBvenOoI
         oE7T35+nBG2tzwmajVKlwjZlxaBk4EIuOqV3c7sUbvNSJgu4AlPdH6ytQllDvERKlH4k
         iFNPlwI2QsMtc4CRmbSBUEycIrLH9yGpPJFeZepFtJzytMbA/qjpQZ2NRHq7EPpbyiTA
         Gy+g==
X-Gm-Message-State: ALQs6tCUxmjqPezcsjFod3MbAxqH56ArEmalhbd7b/JjzcYiTHvF94ul
        Xr3pgu0zJp5ZLvi5SY927//UIX937OY=
X-Google-Smtp-Source: AIpwx49qD7lFEUGTemI5bj8JOs5wZIN7LXBZl1h3Ql2kG45ngyez2ohP6XXLgO4jEJVrXTENwyuJEA==
X-Received: by 10.101.65.195 with SMTP id b3mr10324181pgq.118.1524282337132;
        Fri, 20 Apr 2018 20:45:37 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:ddb8:3db2:8ad2:955])
        by smtp.gmail.com with ESMTPSA id a4sm18132019pfj.107.2018.04.20.20.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Apr 2018 20:45:36 -0700 (PDT)
Date:   Fri, 20 Apr 2018 20:45:35 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, l.s.r@web.de, peff@peff.net
Subject: [PATCH 3/6] grep.[ch]: teach columnnum, color_columnno to grep_opt
Message-ID: <20180421034535.GD24606@syl.local>
References: <cover.1524281843.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524281843.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation of adding --column-number to 'git-grep(1)', we extend
grep_opt to take in the requisite new members.

We additionally teach the 'grep.columnnumber' and
'color.grep.columnumber' configuration variables to configure showing
and coloring the column number, respectively. (These options remain
undocumented until 'git-grep(1)' learns the --column option in a
forthcoming commit.)

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 grep.c | 8 ++++++++
 grep.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/grep.c b/grep.c
index 29bc799ecf..7872a5d868 100644
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
+	else if (!strcmp(var, "color.grep.columnumber"))
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


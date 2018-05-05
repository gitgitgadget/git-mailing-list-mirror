Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0C06200B9
	for <e@80x24.org>; Sat,  5 May 2018 02:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeEECnC (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 22:43:02 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35886 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbeEECnA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 22:43:00 -0400
Received: by mail-pg0-f66.google.com with SMTP id z129-v6so12426092pgz.3
        for <git@vger.kernel.org>; Fri, 04 May 2018 19:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LOL8hxCc7m4rnbzhgjqL8Nx/yPAETdgL748ftH9Fzj4=;
        b=S5qipOmp0Og2/rMUWHUWEv2VYuLWhvSx0B8RqpSlDKsXcXejLRIbDdTz/g0KdbHKae
         UrjygB8cVPV2AzlVDpVhhjVQYBdYt8QqUkh0zd9Mkw9/xyi5mztTK63Qd4MO5WeyTrmx
         t4clKqIogASn62o607KOinlH9wzB8HqofUre3rHm845FTVth37FU8FzY1QTlP620uby8
         XWED87drTbJw/yZ0znlKuuGrSS93sS029GmPeH16eCxt9QxYGFyPD7OfdrYwn2D0UaJO
         Y1WGxwe9obHL6J+MZLcNTB+wIUDHFgmqrnnTlq2gNUSYeE8fMVuYcWiDkMUzgYS8eNY/
         6H4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LOL8hxCc7m4rnbzhgjqL8Nx/yPAETdgL748ftH9Fzj4=;
        b=J2B6YRRRGfXbeYdZjFb+SeXhtJf5s9Q9Uj5XXwBJ0HM6gjfKAPSkAFTTQrzAHDqyGp
         4rZCo8vhS0OpFTpThC90MNNVbeCF9PVyxwyneeJ/LUvqD9oOfBYNdT13gQR8vfe7Mr+2
         9/U0OOik5shtHBuwcJ9DYTmuS6S4KW6UhEwvjKkMxKUs0izoG09WcBVZLLvItSkRCpWU
         06/67eXjKKU0MGN8quYS0tVd61vM0REPI2vSWeeg1tK2N1XzWZME8ebdwfjfAY8BWMku
         NDZvywia3dSSD+iiA0FEVhXgOivgzRo4XFipzRocee2rZqt1HIc2wlo4Y+WpDqFmUN8k
         rvFg==
X-Gm-Message-State: ALQs6tC/XRuTiEU5FI+Gg4/lkZOakz2A6nVFFdkZfpLmzFAjrvOKi8qr
        Gqr6NENTGbtDwx3/nHOHr7v6InHtwlUzbw==
X-Google-Smtp-Source: AB8JxZrZbt9OqFmBN8zzLzuIllwspcBflZxwdD92M6R4KMB/5SetCYsGWt0fF4JgfKHK9aBkuC/rpw==
X-Received: by 10.167.131.5 with SMTP id t5mr203865pfm.198.1525488179547;
        Fri, 04 May 2018 19:42:59 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:a961:c277:c90f:2435])
        by smtp.gmail.com with ESMTPSA id d4sm39480510pfl.24.2018.05.04.19.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 May 2018 19:42:58 -0700 (PDT)
Date:   Fri, 4 May 2018 19:42:57 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v4 3/7] grep.[ch]: extend grep_opt to allow showing matched
 column
Message-ID: <d03ab96629e6cd001d738d3f35d9cd4b42fa848b.1525488108.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1525488108.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1525488108.git.me@ttaylorr.com>
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


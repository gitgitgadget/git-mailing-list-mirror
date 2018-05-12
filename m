Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B1991F406
	for <e@80x24.org>; Sat, 12 May 2018 03:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbeELDLM (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 23:11:12 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36370 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeELDLK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 23:11:10 -0400
Received: by mail-pg0-f68.google.com with SMTP id z70-v6so3180529pgz.3
        for <git@vger.kernel.org>; Fri, 11 May 2018 20:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LOL8hxCc7m4rnbzhgjqL8Nx/yPAETdgL748ftH9Fzj4=;
        b=vV6w1vIy5WMGBQS3YnYzMr0aQab8JuU9p9FC31VNHlzfw1NKtlBldnD+vlXZ1uPqeJ
         sKVNgnavtgkfkPO4BTj5ZRfLwCRsQS66AsFHlfqZUlZfrWW8hUHtm9/Fklbd8tvJcGo9
         s4X/xErPg6ss8TQd7owUyQ7QPr24MXQb/0HpkD/YcjqhiaZogybnojEJQASmotchGL4i
         Kz/0DYLCzgQUNxSBIxy4BoA2S4bzo51eZChxdHNXsHgZE8fiZNtbRIkA8nLYmzEsJjB4
         4o6kV1BvQoki2cFnjAGl9i8gnflap2kqncz+bKsIDKCWECFloHOzpUHWqe1g517s4CgV
         IjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LOL8hxCc7m4rnbzhgjqL8Nx/yPAETdgL748ftH9Fzj4=;
        b=aPJbp3NyJb6acbjYRtbXIh9jK3o4uxp13XAYrlAX/8ySFj2tc7K0ytuKvzkjMl0bRc
         GXbBXkTc2lS8TKBsmGgVkqVfkbp4mNSC91raWZmiRsNUwKhdhiqk8pqhzph+agJj1HMr
         VFCpK2Ir60qv+aK1iStEilSKcwbNkGB5zXTtcps5EOQNRAw9bfhgxKfHCSGHxKKVDZAs
         cRXlMGMo+z1C3+dljbrJgwMepIgXnLB8wUnThKLskUbnz86kI1Nye38njE9I1R0sHod8
         VW7tgVcydj4JaBITumPiLdbieUEHzIp3f+cYx9LUlj5S/WQKzmzndLqeVh51T8pUl4RV
         U6Mw==
X-Gm-Message-State: ALKqPwe0BcTQD9Q0zchoOIaCK5/9Mfx9Ek1hcdX8c2ff7khfr5w6V0E9
        LXYNJkwSAQdntypqlzKV0TaWYZaMlQA=
X-Google-Smtp-Source: AB8JxZp3dgWiM3A4iBHjqpdrVBFTOhc4AsQ6H2uzXir8z6TeLrvfX2jT+PB1pZmsRNNpmQ6bFbHirg==
X-Received: by 2002:a62:6105:: with SMTP id v5-v6mr1371433pfb.197.1526094669091;
        Fri, 11 May 2018 20:11:09 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:81b:33bd:f4a4:78cd])
        by smtp.gmail.com with ESMTPSA id i186-v6sm7176269pge.40.2018.05.11.20.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 20:11:08 -0700 (PDT)
Date:   Fri, 11 May 2018 20:11:06 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, l.s.r@web.de, martin.agren@gmail.com,
        peff@peff.net, phillip.wood@talktalk.net
Subject: [PATCH v6 3/7] grep.[ch]: extend grep_opt to allow showing matched
 column
Message-ID: <d03ab96629e6cd001d738d3f35d9cd4b42fa848b.1526094383.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1526094383.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1526094383.git.me@ttaylorr.com>
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


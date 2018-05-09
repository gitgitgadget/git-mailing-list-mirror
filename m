Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 411E11F424
	for <e@80x24.org>; Wed,  9 May 2018 02:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933556AbeEICNk (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 22:13:40 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44654 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933185AbeEICNh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 22:13:37 -0400
Received: by mail-pl0-f65.google.com with SMTP id e6-v6so3344764plt.11
        for <git@vger.kernel.org>; Tue, 08 May 2018 19:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LOL8hxCc7m4rnbzhgjqL8Nx/yPAETdgL748ftH9Fzj4=;
        b=H55+4omXPREv2UBZekJ3QvoLYW4efVjcgkRQ5sRXKdNnQtVf9586RDkvqSrVmI98bM
         DaxFNbIzchV5COM++QVNeP9ayVk5mxl+IbynsPMmG4SxLyF1wsp0NGzZBVFKTCdPM5Bx
         J3kD5cE+t97RtN7BO/CEv1oipe2B5SCQ8dAU6D8vliJnsCHHXiedBLc9YA/f7EKh2Dqm
         qoublIpquDKQJSQDrfPXWBgHTSH26i/eza1Uesm7lPzZhTpfNbvXu5e4am6HGLMiB5a4
         qUGHewEdc4KYuwEfCQH2uP9wZ9Lfw8mOK19XspsHdpC/9YUA9pNqT7Q/r2t0saWMpG1E
         FLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LOL8hxCc7m4rnbzhgjqL8Nx/yPAETdgL748ftH9Fzj4=;
        b=KE4/+CwwqdOq1cDoEk8KImNxDg8d86nw0OIN9wPIeKbvo6VKn4uMCzH1U+xva/Gami
         HDF0rinpN8HSYRVN4YiXQ235DLd1/CgPdQfr8crBuAsNkV/E1you2HYRhQ65Ks2E4RCG
         8S+4VSdv4xvlnCsh3xjwWdGWnX0FS8gSAYl7KPLyr6+RxtZ2dz3lNwOXt5tccRjc4+Qc
         rug6Jg5TCTGakogaesAkeZNXYsucN4i8MqpzMyMmJasEVg+mC+FrBqCcoLh9188Kbb4R
         916zr9UFJUibDLSZme1VWH+jiPECkE857HCoRzd+UUlLy6sn4Um5rpgg95WXrpDd/LPI
         qmSA==
X-Gm-Message-State: ALQs6tAt+1CdMkthe2TZ3lmrr1C0Rp5i8dOEyFM7fdN4YPkbV1MptF4g
        3GFUWc+55aZVaKIXrH0OFI7GGJj7XcZWpA==
X-Google-Smtp-Source: AB8JxZorTu4ed8CxU6ey9NzYAOc7LSzZeLwJvxN8f+W3rWUR5/e1W9pVP62uE/YPL5Hn6+MMZsL95w==
X-Received: by 2002:a17:902:5948:: with SMTP id e8-v6mr44631569plj.121.1525832015941;
        Tue, 08 May 2018 19:13:35 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:d537:72d4:95b0:7812])
        by smtp.gmail.com with ESMTPSA id x71sm65074616pfe.47.2018.05.08.19.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 May 2018 19:13:34 -0700 (PDT)
Date:   Tue, 8 May 2018 19:13:34 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, pclouds@gmail.com, peff@peff.net,
        phillip.wood@talktalk.net, sunshine@sunshineco.com
Subject: [PATCH v5 3/7] grep.[ch]: extend grep_opt to allow showing matched
 column
Message-ID: <d03ab96629e6cd001d738d3f35d9cd4b42fa848b.1525831201.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1525831201.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1525831201.git.me@ttaylorr.com>
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


Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D82C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 13:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41752073D
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 13:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYlPG89t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfLINKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 08:10:51 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:46984 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbfLINKv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 08:10:51 -0500
Received: by mail-pj1-f65.google.com with SMTP id z21so5869725pjq.13
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 05:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7Hs6iPjuAzxu1HDfiDVtnKiBpXM1/OYAobjKPOzsFkc=;
        b=WYlPG89txJcK3GvVMKFPxMab/DQaSeb78WbvGux1kUsMr99vqz7PEn+VYaSJ3JpGAL
         anrs5mLA2eo7LK32EsXmoo4Vpkepbz27yN3yC0RA1zbDGjXsQrIUoFz5Ms4EjMHoX9YF
         uURzYJ9N5N6URtaoJVudN+exLzgt5Q7Vjb3NiSY87WA7CZRp4+jIux8KT+t1UIHOfoY2
         LWtvgqY5tfSC2fuxT2T3KT2IvsAcojeHgL+Ah4FFBDC6YrtJLKwB7Jc/XaFdJ90x8sRu
         UjreADkmDGtRHfoYj5U8HtSXESddoKeKd3C0NBTwMHs4mYM96zrOEdX0LMLf5pLCB61z
         rh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Hs6iPjuAzxu1HDfiDVtnKiBpXM1/OYAobjKPOzsFkc=;
        b=fqrBXkHBxXjuo0rS/bLwB0R67i+ylqq5zuyvycOadWzZeTb8gpiAgUY78PLHd/PJvG
         BFYWeS0zFvg2z5GBaTgK6BPX4OEEMypPVL5JUAX4t3a4Yq7tf6bfuIKoLBB73uFkChzP
         WbhkEQ0XLpTGNSxsKa7WsXMlUOcftKj354BPsmKMPJpY2RMZhx4UJe5PJjIVUx+9k6j8
         K0qbjFgqafazdCdKetlHg+CproyhC9jqALls7vFtZWxR+kj9pALgL1jfTkj1yHkRs8wf
         SVZgXPZk6osVJjJwDpk9u8+d9bNcZHcORfzlKE+QFpabh2y3TUXP3BSar6uF+oydBOzT
         2K/Q==
X-Gm-Message-State: APjAAAXrfTfCKoYLUr2gsHud3xEbZrTo+22kdevTpYW9Lp3qDrX/6mPF
        P7xCuyuFJkhSmk4PdqzuVF60hALK
X-Google-Smtp-Source: APXvYqwxnjn+InzGQnUFdBJXW/trDGtZDbzQxs9Wt3kkZnh6tkEs65dblV1xGvsBIcxCtZz/Dwxz1Q==
X-Received: by 2002:a17:902:599a:: with SMTP id p26mr29388221pli.312.1575897050680;
        Mon, 09 Dec 2019 05:10:50 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id n15sm25670970pgf.17.2019.12.09.05.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 05:10:50 -0800 (PST)
Date:   Mon, 9 Dec 2019 05:10:48 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Pavel Roskin <plroskin@gmail.com>
Subject: [PATCH 5/5] format-patch: move git_config() before
 repo_init_revisions()
Message-ID: <709565e734820fcb6d5db027dcf644f53ce2d4c9.1575896661.git.liu.denton@gmail.com>
References: <cover.1575896661.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575896661.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 13cdf78094 (format-patch: teach format.notes config option,
2019-05-16), the order in which git_config() and repo_init_revisions()
were swapped so that `rev.notes_opt` would be initialized before
git_config() was called. This is problematic, however, as git_config()
should generally be called before repo_init_revisions().

Break this circular dependency by creating `show_notes` and `notes_opt`
which git_config() reads into. Then, copy these values over to
`rev.show_notes` and `rev.notes_opt` after repo_init_revisions() is
called.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/log.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 1f0405f72b..4225615e7f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -769,6 +769,8 @@ static const char *signature = git_version_string;
 static const char *signature_file;
 static int config_cover_letter;
 static const char *config_output_directory;
+static int show_notes;
+static struct display_notes_opt notes_opt;
 
 enum {
 	COVER_UNSET,
@@ -779,8 +781,6 @@ enum {
 
 static int git_format_config(const char *var, const char *value, void *cb)
 {
-	struct rev_info *rev = cb;
-
 	if (!strcmp(var, "format.headers")) {
 		if (!value)
 			die(_("format.headers without value"));
@@ -868,7 +868,7 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp(var, "format.notes")) {
 		int b = git_parse_maybe_bool(value);
-		rev->show_notes = set_display_notes(&rev->notes_opt, b, b < 0 ? value : NULL);
+		show_notes = set_display_notes(&notes_opt, b, b < 0 ? value : NULL);
 		return 0;
 	}
 
@@ -1624,8 +1624,11 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	extra_to.strdup_strings = 1;
 	extra_cc.strdup_strings = 1;
 	init_log_defaults();
+	init_display_notes(&notes_opt);
+	git_config(git_format_config, NULL);
 	repo_init_revisions(the_repository, &rev, prefix);
-	git_config(git_format_config, &rev);
+	rev.show_notes = show_notes;
+	memcpy(&rev.notes_opt, &notes_opt, sizeof(notes_opt));
 	rev.commit_format = CMIT_FMT_EMAIL;
 	rev.expand_tabs_in_log_default = 0;
 	rev.verbose_header = 1;
-- 
2.24.0.627.geba02921db


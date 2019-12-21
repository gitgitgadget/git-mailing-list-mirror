Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE73DC2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13A2206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLWGRnxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfLUWmF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 17:42:05 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34780 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfLUWmE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 17:42:04 -0500
Received: by mail-ed1-f68.google.com with SMTP id l8so12074477edw.1
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 14:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KRkm/LiztitDHXWrlD6aP0f08UEO8OxIJInpLRlUWNs=;
        b=sLWGRnxxMhh5clNfnPj2NmfFOFugI91kJStWGzsJZvG8Rb5f7hiDoAsuMKJVrzkaKs
         lePMITzSXByB8AM3sOlsezyMUwyiGtzYBDgJaePfg53NaBi6tCzK4YTKhWIVz7DS8fji
         OVAKgUufVhK5OKP+W/i1M4ocIoBGi1cRatwFN27EnfCXVR4CFrwRKEqFseUMXywmvlYO
         Q7X2l49++9m+xZg5P/NEp9yDt4LSal/t27UQpau+EHeWZHM3+JOzVzE4/3UGneSQORp4
         DWzDwXoWmlkqk3FmINAUpfsktThJ+Sc2jEKn1dk8+/7uT4U/fcn0av1aJi3VbMtRrC1d
         EFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KRkm/LiztitDHXWrlD6aP0f08UEO8OxIJInpLRlUWNs=;
        b=squC/wKx8Srgiijho1PUTX/fjJ+yhmyfWaXXdUkk2eYM5Qu6FDhe2HtVdzF1JdnMql
         4bIoU+BI85gkpm9oChvHbR8CkrGK1DGeWPmSQD8G7qCbE1jYrNqirRDGJlA5qJ5FEUpw
         GLXwO1Metd8R5kOT+qW+OXh/VpV25/h1mXi6kPNBPTvDFyHpXf6lZ0bh9fClt+ULYtjc
         KrzZ2+o35qJ5yiFPaAGajkFqKTyy7vEX8eN8yx3rsBLKRToJO6A2yXrOJJcm/QOF8HgK
         It7T6/B7ftic2jOQG1oOkYBVU5epKH0mMjx8lieWVxqxJH3fSAl+Y6yeB0Lf/k005sol
         Psqw==
X-Gm-Message-State: APjAAAUC7vreyUQiWwtdJ9bubEcFvdjRVxEB1EPwPCzbYxT5W4fyC3jR
        r/1GM9ikoEYIZjmjw8qwvDLafLmO
X-Google-Smtp-Source: APXvYqz0oBoH/6OwtdTP6CPOZq5zAo6OYjKjt0MdSFdeRxMrYRGFqGyCQZS7jlGb21/77IrBe5vh4g==
X-Received: by 2002:a17:906:cc8b:: with SMTP id oq11mr24416588ejb.193.1576968122374;
        Sat, 21 Dec 2019 14:42:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id nq3sm1712674ejb.73.2019.12.21.14.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Dec 2019 14:42:02 -0800 (PST)
Message-Id: <a7355776d6aef9d731de27c02caca728ff579bac.1576968120.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.git.1576968120.gitgitgadget@gmail.com>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Dec 2019 22:41:52 +0000
Subject: [PATCH 1/9] built-in add -p: support interactive.diffFilter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The Perl version supports post-processing the colored diff (that is
generated in addition to the uncolored diff, intended to offer a
prettier user experience) by a command configured via that config
setting, and now the built-in version does that, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 12 ++++++++++++
 add-interactive.h |  3 +++
 add-patch.c       | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/add-interactive.c b/add-interactive.c
index 0e753d2acc..00c3bc9a1b 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -52,6 +52,17 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 		diff_get_color(s->use_color, DIFF_FILE_OLD));
 	init_color(r, s, "new", s->file_new_color,
 		diff_get_color(s->use_color, DIFF_FILE_NEW));
+
+	FREE_AND_NULL(s->interactive_diff_filter);
+	git_config_get_string("interactive.difffilter",
+			      &s->interactive_diff_filter);
+}
+
+void clear_add_i_state(struct add_i_state *s)
+{
+	FREE_AND_NULL(s->interactive_diff_filter);
+	memset(s, 0, sizeof(*s));
+	s->use_color = -1;
 }
 
 /*
@@ -1149,6 +1160,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 	strbuf_release(&print_file_item_data.worktree);
 	strbuf_release(&header);
 	prefix_item_list_clear(&commands);
+	clear_add_i_state(&s);
 
 	return res;
 }
diff --git a/add-interactive.h b/add-interactive.h
index 4895ed1df5..7299cf6e04 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -15,9 +15,12 @@ struct add_i_state {
 	char context_color[COLOR_MAXLEN];
 	char file_old_color[COLOR_MAXLEN];
 	char file_new_color[COLOR_MAXLEN];
+
+	char *interactive_diff_filter;
 };
 
 void init_add_i_state(struct add_i_state *s, struct repository *r);
+void clear_add_i_state(struct add_i_state *s);
 
 struct repository;
 struct pathspec;
diff --git a/add-patch.c b/add-patch.c
index 2ad18dc3cb..73bf2caca2 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -397,6 +397,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 
 	if (want_color_fd(1, -1)) {
 		struct child_process colored_cp = CHILD_PROCESS_INIT;
+		const char *diff_filter = s->s.interactive_diff_filter;
 
 		setup_child_process(s, &colored_cp, NULL);
 		xsnprintf((char *)args.argv[color_arg_index], 8, "--color");
@@ -406,6 +407,24 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 		argv_array_clear(&args);
 		if (res)
 			return error(_("could not parse colored diff"));
+
+		if (diff_filter) {
+			struct child_process filter_cp = CHILD_PROCESS_INIT;
+
+			setup_child_process(s, &filter_cp,
+					    diff_filter, NULL);
+			filter_cp.git_cmd = 0;
+			filter_cp.use_shell = 1;
+			strbuf_reset(&s->buf);
+			if (pipe_command(&filter_cp,
+					 colored->buf, colored->len,
+					 &s->buf, colored->len,
+					 NULL, 0) < 0)
+				return error(_("failed to run '%s'"),
+					     diff_filter);
+			strbuf_swap(colored, &s->buf);
+		}
+
 		strbuf_complete_line(colored);
 		colored_p = colored->buf;
 		colored_pend = colored_p + colored->len;
@@ -530,6 +549,9 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 						   colored_pend - colored_p);
 			if (colored_eol)
 				colored_p = colored_eol + 1;
+			else if (p != pend)
+				/* colored shorter than non-colored? */
+				goto mismatched_output;
 			else
 				colored_p = colored_pend;
 
@@ -554,6 +576,15 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 		 */
 		hunk->splittable_into++;
 
+	/* non-colored shorter than colored? */
+	if (colored_p != colored_pend) {
+mismatched_output:
+		error(_("mismatched output from interactive.diffFilter"));
+		advise(_("Your filter must maintain a one-to-one correspondence\n"
+			 "between its input and output lines."));
+		return -1;
+	}
+
 	return 0;
 }
 
@@ -1611,6 +1642,7 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	    parse_diff(&s, ps) < 0) {
 		strbuf_release(&s.plain);
 		strbuf_release(&s.colored);
+		clear_add_i_state(&s.s);
 		return -1;
 	}
 
@@ -1629,5 +1661,6 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	strbuf_release(&s.buf);
 	strbuf_release(&s.plain);
 	strbuf_release(&s.colored);
+	clear_add_i_state(&s.s);
 	return 0;
 }
-- 
gitgitgadget


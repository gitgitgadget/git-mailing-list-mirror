Return-Path: <SRS0=LPWw=2P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C294AC2D0DB
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 11:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4682075B
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 11:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPtfdAnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfLYL5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Dec 2019 06:57:05 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38142 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfLYL5F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Dec 2019 06:57:05 -0500
Received: by mail-ed1-f65.google.com with SMTP id i16so19768407edr.5
        for <git@vger.kernel.org>; Wed, 25 Dec 2019 03:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iNgdJu33yWmrC3CO0xyJZ8AewEp6xJw0yMtoc0eSul0=;
        b=HPtfdAnUb95g1bze0jDWV29jLxh/vg0YloPUE8NPBfp1dtaeEGizdxa/ghrwgt99IL
         iGSw2lrK+z8AlpsQoeRcUMR6RXmj39JqhAbyJ7p66OmWksMtaqMEe5LzrPJ0K9UeV4/d
         veDYlTme/FYFHKNlAQoj5epWrVgNcSntPAdOp8gzTWy3nuhsD8CdsBsr/hGRRTOHiSBD
         1zp+0t+pfwyD0Lq+ZewRmg3T6pGZPBMMWF36Vlwwz8Q+OVsWOelxFjRc2b2ogvItqrXp
         6Up9eycEWhIQp+rL0L+4se803TrWCFZkX9YSFHhepl28N00Jgm4Di2TB0O9ZY2GjRGXb
         ctJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iNgdJu33yWmrC3CO0xyJZ8AewEp6xJw0yMtoc0eSul0=;
        b=Thoih83KWGpqunwC4ZSA4uSVGDKGlPdBI9hZ3pMFyCdZInZ/J5Kdc/Y3/S9DZg8G3f
         xB8vZzI+wV/DVDKz5Gz+HsmwwVAw+rmSJ6aZ5vXfTBaJNvYMINEOWfZ3O0DymsLGnIiQ
         vvZ1ROOXeIQIKr5Y3Xi4BvztnZ7zg6WYurE0Hcd0xQYcnmn4kTa+Ztq0xF8Rj56fU0gR
         U/TZkJw68aocKEumITes5Sh1u0tKxmVFT8h2T/wLbiDGSJ4/LLubIslWSoJ2zcKFeHp0
         YZyffIb6to4PYpeqZKV0Q/sXb+1zTNOtEHhqkDdymlmIL6v3xlFlkKT/t7avo0z9y9uh
         qz5w==
X-Gm-Message-State: APjAAAXZvsd5RhEVWn0qymb8qWKtqJQBgDpF2S51moCsZvc6umkvuKds
        WImU7MaRXXoifaBh+hLYaymHLoCO
X-Google-Smtp-Source: APXvYqx9y/QaaGB1JwKYUeNKoK2E05QNwLQorh6lor67IC3/ocFiy0+zNVZidJsw2m33qPM5c/VOBQ==
X-Received: by 2002:aa7:d898:: with SMTP id u24mr45415896edq.53.1577275022733;
        Wed, 25 Dec 2019 03:57:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bm18sm3070107edb.97.2019.12.25.03.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Dec 2019 03:57:02 -0800 (PST)
Message-Id: <f45ff08bd0a0a2e2aba9ae929b6e5ecb3bdd4e07.1577275020.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
        <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Dec 2019 11:56:52 +0000
Subject: [PATCH v2 1/9] built-in add -p: support interactive.diffFilter
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
index a5bb14f2f4..1786ea29c4 100644
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
index b2f23479c5..46c73867ad 100644
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
index 46c6c183d5..78bde41df0 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -398,6 +398,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 
 	if (want_color_fd(1, -1)) {
 		struct child_process colored_cp = CHILD_PROCESS_INIT;
+		const char *diff_filter = s->s.interactive_diff_filter;
 
 		setup_child_process(s, &colored_cp, NULL);
 		xsnprintf((char *)args.argv[color_arg_index], 8, "--color");
@@ -407,6 +408,24 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
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
@@ -531,6 +550,9 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 						   colored_pend - colored_p);
 			if (colored_eol)
 				colored_p = colored_eol + 1;
+			else if (p != pend)
+				/* colored shorter than non-colored? */
+				goto mismatched_output;
 			else
 				colored_p = colored_pend;
 
@@ -555,6 +577,15 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
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
 
@@ -1612,6 +1643,7 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	    parse_diff(&s, ps) < 0) {
 		strbuf_release(&s.plain);
 		strbuf_release(&s.colored);
+		clear_add_i_state(&s.s);
 		return -1;
 	}
 
@@ -1630,5 +1662,6 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	strbuf_release(&s.buf);
 	strbuf_release(&s.plain);
 	strbuf_release(&s.colored);
+	clear_add_i_state(&s.s);
 	return 0;
 }
-- 
gitgitgadget


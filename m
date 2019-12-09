Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E97C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 13:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3561D2073D
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 13:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pp22Ebwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfLINKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 08:10:43 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40419 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfLINKn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 08:10:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so5792785plp.7
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 05:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zjT/6rJDnAs2GlWdX8xKF++Y4AzU9qYkTwqgcLJMsto=;
        b=Pp22Ebwm9WTiLR+2ODEJ4y+rnzFVkStfySSn8iH7Y8OuqMOAmMnmc14r6uCTDonYQe
         DqL3Jcp2wp4Vy4llxlkjK8cvEfaJ7coFjCidRoo9mhyTU1iEqwl7lZXi89P1iRI/H4xd
         SWHjjagHwUvIUh5fqXHdCsV8m2qVisL2fLpSKjMcFYgpMq0YsvD7xmJjfsKhySlddqyl
         h1I6XRGNJB65hCmbdun32/JaHTwB4DPJ/ivx31SyIltltFhF6lFhGcj6xoBP01Npf2GH
         0K8LozRSD8NpajONegcj2iDmmSqHqIw182Q4B4EHijLCP4Rq7vGz7ULYJj520zMhTMHw
         HMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zjT/6rJDnAs2GlWdX8xKF++Y4AzU9qYkTwqgcLJMsto=;
        b=FuoyMcPWQVjdESv+i4m6+ZZ1xiDi6mOYDt20j6SBV3Yc1z041Fo/k2NQFGM+PLX91H
         iub5qJg3p6JnftyopOTHuOY31peRF98WaoDMDHGrzD5rXmiCkHjC+mL/QV4NyECDBrU4
         7UB+MN7bnU/AAVj6q7JS9bb5ob/3+heqV4kzczxOwLmO9+6DEwQLeY6BFJovScW+fXDx
         NBJlsn+dvW05n2t9q5KOlIe7cQjPngPrbk/Tv4aPWoZ/x3YCyYGJ406ilnjJIaLDwRmy
         LKjZnc1bTw1gC/z4lfX7qkXEYndtBTpokI4ncRtXDVmXrw4m/qw4ISdGbPXu/cxQcWap
         rbMA==
X-Gm-Message-State: APjAAAUcP9S9aKyhDziTpqza9s36pZ4g7TyNHwW2FUtSwphQdrptVfvM
        zPD1Pg9d5r4+1so68QMt0IiB4V0g
X-Google-Smtp-Source: APXvYqw2sOkE4F3V8CX8bV5nJZKi4dVi9v4BrSLzXgX/bcmhUckb/gc2pLXD9tBxFvJ8JO/vr2D1/A==
X-Received: by 2002:a17:902:d691:: with SMTP id v17mr19973256ply.150.1575897041362;
        Mon, 09 Dec 2019 05:10:41 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id b65sm26451089pgc.18.2019.12.09.05.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 05:10:40 -0800 (PST)
Date:   Mon, 9 Dec 2019 05:10:39 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Pavel Roskin <plroskin@gmail.com>
Subject: [PATCH 1/5] notes: rename to load_display_notes()
Message-ID: <4132d5bb7b354355a6dbe8049601f166b5de8fa8.1575896661.git.liu.denton@gmail.com>
References: <cover.1575896661.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575896661.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to the function comment, init_display_notes() was supposed to
"Load the notes machinery for displaying several notes trees." Rename
this function to load_display_notes() so that its use is more accurately
represented.

This is done because, in a future commit, we will reuse the name
init_display_notes().

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/log.c | 4 ++--
 notes.c       | 2 +-
 notes.h       | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index dad63cffc6..622d6a6cb1 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -202,7 +202,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	if (!rev->show_notes_given && (!rev->pretty_given || w.notes))
 		rev->show_notes = 1;
 	if (rev->show_notes)
-		init_display_notes(&rev->notes_opt);
+		load_display_notes(&rev->notes_opt);
 
 	if ((rev->diffopt.pickaxe_opts & DIFF_PICKAXE_KINDS_MASK) ||
 	    rev->diffopt.filter || rev->diffopt.flags.follow_renames)
@@ -1749,7 +1749,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		rev.diffopt.flags.binary = 1;
 
 	if (rev.show_notes)
-		init_display_notes(&rev.notes_opt);
+		load_display_notes(&rev.notes_opt);
 
 	if (!output_directory && !use_stdout)
 		output_directory = config_output_directory;
diff --git a/notes.c b/notes.c
index 532ec37865..fd6cef14a3 100644
--- a/notes.c
+++ b/notes.c
@@ -1039,7 +1039,7 @@ struct notes_tree **load_notes_trees(struct string_list *refs, int flags)
 	return trees;
 }
 
-void init_display_notes(struct display_notes_opt *opt)
+void load_display_notes(struct display_notes_opt *opt)
 {
 	char *display_ref_env;
 	int load_config_refs = 0;
diff --git a/notes.h b/notes.h
index 414bc6855a..1ce528442a 100644
--- a/notes.h
+++ b/notes.h
@@ -272,18 +272,18 @@ struct display_notes_opt {
  * - extra_notes_refs may contain a list of globs (in the same style
  *   as notes.displayRef) where notes should be loaded from.
  */
-void init_display_notes(struct display_notes_opt *opt);
+void load_display_notes(struct display_notes_opt *opt);
 
 /*
  * Append notes for the given 'object_sha1' from all trees set up by
- * init_display_notes() to 'sb'.  The 'flags' are a bitwise
+ * load_display_notes() to 'sb'.  The 'flags' are a bitwise
  * combination of
  *
  * - NOTES_SHOW_HEADER: add a 'Notes (refname):' header
  *
  * - NOTES_INDENT: indent the notes by 4 places
  *
- * You *must* call init_display_notes() before using this function.
+ * You *must* call load_display_notes() before using this function.
  */
 void format_display_notes(const struct object_id *object_oid,
 			  struct strbuf *sb, const char *output_encoding, int raw);
-- 
2.24.0.627.geba02921db


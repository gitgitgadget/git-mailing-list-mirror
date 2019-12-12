Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933A7C43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 00:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9BB208C3
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 00:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+RI9UBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfLLAst (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 19:48:49 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43687 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfLLAst (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 19:48:49 -0500
Received: by mail-pf1-f194.google.com with SMTP id h14so161756pfe.10
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 16:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wvuKFYYEnHDuKll2b5v/FZdwx+Ad+SvuVFlsQELaOFY=;
        b=i+RI9UBY2zvNQzX3wnwjGlEEu6X8RqrcOPU4HE7+hklLa0nd/NUkzFYKkDjlmbnqDz
         u2l5NVkxq56XXunrZND8hJ8ImxHniLfxwv4z1o9u0VG2S7FxF4ltXJkkQSerzHtwVY5j
         VVmIy4k1gV4zwQM8+AkyM/AmuBoCBcKDn7a0O2UH65GvGVELsxGZ1u6nZHPJ8HGCguHf
         UqLC1swUVmeuJHv9dOEZXJtQEIYiHDhDeXdtsgRtY1LXNim8+hG/PwMvNKuL4eXTPhM0
         N0ZgLKtvp/WL2MQQW3WNXOk1SceFXcJQsFqAMogKfSetdEbWuUNaDptvueqpjTdB3orc
         6qxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wvuKFYYEnHDuKll2b5v/FZdwx+Ad+SvuVFlsQELaOFY=;
        b=rvqeirt5YYjbHmnN9t4PVZL/FSUoIZWxPnsXUs43XEWtUce1ka4OmpSoAXAn1rwV7a
         mY96+/DBmYpYc+MFCJDGsrRJFsKpm/Sx/MeK6nvtSowk7vNavEZGRO1oAYLTpY1eeAgR
         orNMUgjEqlezzCvHndrhWlUbJVj52MY5TQYOew1w9DuShOOApaGLOu1HGviciwvDRk1r
         SugbmPvQrWxz+dq/d1vaSAfrONeE7WNlgngn6TrDObLsUHOvP9AxlPfqTKj28p08f56y
         Y+S3OuMgeTNIrTwy8BRSQfglKKN2SWyCNU8fnJrgXYXF8QoZZDrR3zb2LNuLhgT7XVhM
         U0CQ==
X-Gm-Message-State: APjAAAX6gecjCk8piVRn/AcWA/ztYh7am/oJ+iInQxhHPvsJwT9AZn6L
        Lu8+YHJA/FtaJaDiDpNm/PJzFPEx
X-Google-Smtp-Source: APXvYqwP4z3Mf3emsHuU6x5f3M2f1T4M5UxAX2ycIm0heq+pTUOoLbQGuniyLKVSvGsGWFKFCxpEOA==
X-Received: by 2002:aa7:9afb:: with SMTP id y27mr6874763pfp.91.1576111727986;
        Wed, 11 Dec 2019 16:48:47 -0800 (PST)
Received: from generichostname ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id d13sm3477250pjx.21.2019.12.11.16.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 16:48:47 -0800 (PST)
Date:   Wed, 11 Dec 2019 16:49:50 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH 2/2] notes: break set_display_notes() into smaller functions
Message-ID: <96b908c91c19bc11da9f8d3b0d6e853517284540.1576111643.git.liu.denton@gmail.com>
References: <cover.1576111643.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1576111643.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 8164c961e1 (format-patch: use --notes behavior for format.notes,
2019-12-09), we introduced set_display_notes() which was a monolithic
function with three mutually exclusive branches. Break the function up
into three small and simple functions that each are only responsible for
one task.

This family of functions accepts an `int *show_notes` instead of
returning a value suitable for assignment to `show_notes`. This is for
two reasons. First of all, this guarantees that the external
`show_notes` variable changes in lockstep with the
`struct display_notes_opt`. Second, this prompts future developers to be
careful about doing something meaningful with this value. In fact, a
NULL check is intentionally omitted because causing a segfault here
would tell the future developer that they are meant to use the value for
something meaningful.

One alternative was making the family of functions accept a
`struct rev_info *` instead of the `struct display_notes_opt *`, since
the former contains the `show_notes` field as well. This does not work
because we have to call git_config() before repo_init_revisions().
However, if we had a `struct rev_info`, we'd need to initialize it before
it gets assigned values from git_config(). As a result, we break the
circular dependency by having standalone `int show_notes` and
`struct display_notes_opt notes_opt` variables which temporarily hold
values from git_config() until the values are copied over to `rev`.

To implement this change, we need to get a pointer to
`rev_info::show_notes`. Unfortunately, this is not possible with
bitfields and only direct-assignment is possible. Change
`rev_info::show_notes` to a non-bitfield int so that we can get its
address.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/log.c |  7 ++++++-
 notes.c       | 43 +++++++++++++++++++++++--------------------
 notes.h       | 19 ++++++++++++-------
 revision.c    |  6 +++---
 revision.h    |  2 +-
 5 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 4225615e7f..b6d43a4a47 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -868,7 +868,12 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp(var, "format.notes")) {
 		int b = git_parse_maybe_bool(value);
-		show_notes = set_display_notes(&notes_opt, b, b < 0 ? value : NULL);
+		if (b < 0)
+			enable_ref_display_notes(&notes_opt, &show_notes, value);
+		else if (b)
+			enable_default_display_notes(&notes_opt, &show_notes);
+		else
+			disable_display_notes(&notes_opt, &show_notes);
 		return 0;
 	}
 
diff --git a/notes.c b/notes.c
index c93feff4ab..3133bb181f 100644
--- a/notes.c
+++ b/notes.c
@@ -1045,28 +1045,31 @@ void init_display_notes(struct display_notes_opt *opt)
 	opt->use_default_notes = -1;
 }
 
-int set_display_notes(struct display_notes_opt *opt, int show_notes, const char *opt_ref)
+void enable_default_display_notes(struct display_notes_opt *opt, int *show_notes)
 {
-	if (show_notes) {
-		if (opt_ref) {
-			struct strbuf buf = STRBUF_INIT;
-			strbuf_addstr(&buf, opt_ref);
-			expand_notes_ref(&buf);
-			string_list_append(&opt->extra_notes_refs,
-					   strbuf_detach(&buf, NULL));
-		} else {
-			opt->use_default_notes = 1;
-		}
-	} else {
-		opt->use_default_notes = -1;
-		/* we have been strdup'ing ourselves, so trick
-		 * string_list into free()ing strings */
-		opt->extra_notes_refs.strdup_strings = 1;
-		string_list_clear(&opt->extra_notes_refs, 0);
-		opt->extra_notes_refs.strdup_strings = 0;
-	}
+	opt->use_default_notes = 1;
+	*show_notes = 1;
+}
 
-	return !!show_notes;
+void enable_ref_display_notes(struct display_notes_opt *opt, int *show_notes,
+		const char *ref) {
+	struct strbuf buf = STRBUF_INIT;
+	strbuf_addstr(&buf, ref);
+	expand_notes_ref(&buf);
+	string_list_append(&opt->extra_notes_refs,
+			strbuf_detach(&buf, NULL));
+	*show_notes = 1;
+}
+
+void disable_display_notes(struct display_notes_opt *opt, int *show_notes)
+{
+	opt->use_default_notes = -1;
+	/* we have been strdup'ing ourselves, so trick
+	 * string_list into free()ing strings */
+	opt->extra_notes_refs.strdup_strings = 1;
+	string_list_clear(&opt->extra_notes_refs, 0);
+	opt->extra_notes_refs.strdup_strings = 0;
+	*show_notes = 0;
 }
 
 void load_display_notes(struct display_notes_opt *opt)
diff --git a/notes.h b/notes.h
index a476bfa066..3e78448181 100644
--- a/notes.h
+++ b/notes.h
@@ -266,14 +266,19 @@ struct display_notes_opt {
 void init_display_notes(struct display_notes_opt *opt);
 
 /*
- * Set a display_notes_opt to a given state. 'show_notes' is a boolean
- * representing whether or not to show notes. 'opt_ref' points to a
- * string for the notes ref, or is NULL if the default notes should be
- * used.
- *
- * Return 'show_notes' normalized to 1 or 0.
+ * This family of functions enables or disables the display of notes. In
+ * particular, 'enable_default_display_notes' will display the default notes,
+ * 'enable_default_display_notes' will display the notes ref 'ref' and
+ * 'disable_display_notes' will disable notes, including those added by previous
+ * invocations of the 'enable_*_display_notes' functions.
+ *
+ * 'show_notes' is a points to a boolean which will be set to 1 if notes are
+ * displayed, else 0. It must not be NULL.
  */
-int set_display_notes(struct display_notes_opt *opt, int show_notes, const char *opt_ref);
+void enable_default_display_notes(struct display_notes_opt *opt, int *show_notes);
+void enable_ref_display_notes(struct display_notes_opt *opt, int *show_notes,
+		const char *ref);
+void disable_display_notes(struct display_notes_opt *opt, int *show_notes);
 
 /*
  * Load the notes machinery for displaying several notes trees.
diff --git a/revision.c b/revision.c
index c2d8d24939..1b12ed742b 100644
--- a/revision.c
+++ b/revision.c
@@ -2172,7 +2172,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 			die("'%s': not a non-negative integer", arg);
 		revs->expand_tabs_in_log = val;
 	} else if (!strcmp(arg, "--show-notes") || !strcmp(arg, "--notes")) {
-		revs->show_notes = set_display_notes(&revs->notes_opt, 1, NULL);
+		enable_default_display_notes(&revs->notes_opt, &revs->show_notes);
 		revs->show_notes_given = 1;
 	} else if (!strcmp(arg, "--show-signature")) {
 		revs->show_signature = 1;
@@ -2191,10 +2191,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		if (starts_with(arg, "--show-notes=") &&
 		    revs->notes_opt.use_default_notes < 0)
 			revs->notes_opt.use_default_notes = 1;
-		revs->show_notes = set_display_notes(&revs->notes_opt, 1, optarg);
+		enable_ref_display_notes(&revs->notes_opt, &revs->show_notes, optarg);
 		revs->show_notes_given = 1;
 	} else if (!strcmp(arg, "--no-notes")) {
-		revs->show_notes = set_display_notes(&revs->notes_opt, 0, NULL);
+		disable_display_notes(&revs->notes_opt, &revs->show_notes);
 		revs->show_notes_given = 1;
 	} else if (!strcmp(arg, "--standard-notes")) {
 		revs->show_notes_given = 1;
diff --git a/revision.h b/revision.h
index 4134dc6029..72520780f4 100644
--- a/revision.h
+++ b/revision.h
@@ -177,10 +177,10 @@ struct rev_info {
 			always_show_header:1;
 
 	/* Format info */
+	int		show_notes;
 	unsigned int	shown_one:1,
 			shown_dashes:1,
 			show_merge:1,
-			show_notes:1,
 			show_notes_given:1,
 			show_signature:1,
 			pretty_given:1,
-- 
2.24.0.627.geba02921db


Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E216CC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 13:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A792073D
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 13:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJT4gIty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfLINKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 08:10:47 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39993 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbfLINKr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 08:10:47 -0500
Received: by mail-pf1-f194.google.com with SMTP id q8so7215358pfh.7
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 05:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XH/sgDUQtCXKlc9E4CK08KoTojOxZXbO6Z4gmwxFd7E=;
        b=aJT4gItyuANebFCv3KC/Bs49TiVIpjNkrjswOBsVKxmNBa0b4pk1LRvfm22nx51wUa
         GdPxB7ZBWhu3iLP7Z56BDBMtmkrfvo5YCVuYq6mItYvL8r5RTwO7fSxagHRHmEOQexyH
         +nswmSlj9N290Oocz7uxrB9IukL+bEwc3lD4QEYHHgmQmQkEVuaDzFkkhX9l+PuOC1TF
         YbNmv/YZ/QhzKxhEIAv/UNocR6UWn5vO+22m9muWBeLQRUI3NX92on6BrHKx7D/WAKme
         z4VW6HQD0xmTz87ewg+hOIbVf8QgFKAi5UgMBXy9NGP0e8Ka9bPdLwp9X84Vh6opJI58
         Kziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XH/sgDUQtCXKlc9E4CK08KoTojOxZXbO6Z4gmwxFd7E=;
        b=tSvdamiXHV2B0VF2hH/vuMsRVcdYGnwsbqDOTP6tmZFfLvfJzI/kJCBIg+IINfmTf+
         lNcSc0iJo7bWvImB/EaZN2FVQsOV9rGDmo+sSqAQ/lnK5Vl52au2AH+b7fIRDl2b1Aw2
         8rJrrLq3dNGtl8jD0iLQ5NENOCtxM0utMXKBcE0bnrHnViv7I3HcVnToPgClYDNoTqUB
         WcZAkOtjCmgUNbeyymezLZjmU7oiT0I8xUvoD8Owf57hFSfve3O6cvYI/xu3faJauzq6
         zqc4hU1HssOlmwD2xbIL5smDsLMb9yQDqAqrg71HCiJLu9fZVncsBYaRBm4f99+s41bM
         ea5w==
X-Gm-Message-State: APjAAAXWHe+SQbiU1DZ59HrMtqRk985iRo9Zjs99al4esLYTXQyEk8YB
        1xTv+tIbXS/xDiQ+eE0Ima6aIm82
X-Google-Smtp-Source: APXvYqxfX08100/IODfaoEYHrG/Ux0pdvZRFwXkmJiGFyA0SaCTQqIf2mXg8JvNEtmF9wMztLchVUQ==
X-Received: by 2002:a63:cb48:: with SMTP id m8mr19186840pgi.128.1575897046222;
        Mon, 09 Dec 2019 05:10:46 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id q9sm12863173pgc.5.2019.12.09.05.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 05:10:45 -0800 (PST)
Date:   Mon, 9 Dec 2019 05:10:44 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Pavel Roskin <plroskin@gmail.com>
Subject: [PATCH 3/5] notes: extract logic into set_display_notes()
Message-ID: <62543250c4ea0e0327f974cb90b294c60b525982.1575896661.git.liu.denton@gmail.com>
References: <cover.1575896661.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575896661.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of open coding the logic that tweaks the variables in
`struct display_notes_opt` within handle_revision_opt(), abstract away the
logic into set_display_notes() so that it can be reused.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 notes.c    | 24 ++++++++++++++++++++++++
 notes.h    | 10 ++++++++++
 revision.c | 20 ++++----------------
 3 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/notes.c b/notes.c
index 53d1e7767c..c93feff4ab 100644
--- a/notes.c
+++ b/notes.c
@@ -1045,6 +1045,30 @@ void init_display_notes(struct display_notes_opt *opt)
 	opt->use_default_notes = -1;
 }
 
+int set_display_notes(struct display_notes_opt *opt, int show_notes, const char *opt_ref)
+{
+	if (show_notes) {
+		if (opt_ref) {
+			struct strbuf buf = STRBUF_INIT;
+			strbuf_addstr(&buf, opt_ref);
+			expand_notes_ref(&buf);
+			string_list_append(&opt->extra_notes_refs,
+					   strbuf_detach(&buf, NULL));
+		} else {
+			opt->use_default_notes = 1;
+		}
+	} else {
+		opt->use_default_notes = -1;
+		/* we have been strdup'ing ourselves, so trick
+		 * string_list into free()ing strings */
+		opt->extra_notes_refs.strdup_strings = 1;
+		string_list_clear(&opt->extra_notes_refs, 0);
+		opt->extra_notes_refs.strdup_strings = 0;
+	}
+
+	return !!show_notes;
+}
+
 void load_display_notes(struct display_notes_opt *opt)
 {
 	char *display_ref_env;
diff --git a/notes.h b/notes.h
index c0b712371c..a476bfa066 100644
--- a/notes.h
+++ b/notes.h
@@ -265,6 +265,16 @@ struct display_notes_opt {
  */
 void init_display_notes(struct display_notes_opt *opt);
 
+/*
+ * Set a display_notes_opt to a given state. 'show_notes' is a boolean
+ * representing whether or not to show notes. 'opt_ref' points to a
+ * string for the notes ref, or is NULL if the default notes should be
+ * used.
+ *
+ * Return 'show_notes' normalized to 1 or 0.
+ */
+int set_display_notes(struct display_notes_opt *opt, int show_notes, const char *opt_ref);
+
 /*
  * Load the notes machinery for displaying several notes trees.
  *
diff --git a/revision.c b/revision.c
index 24ad974590..c2d8d24939 100644
--- a/revision.c
+++ b/revision.c
@@ -2172,9 +2172,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 			die("'%s': not a non-negative integer", arg);
 		revs->expand_tabs_in_log = val;
 	} else if (!strcmp(arg, "--show-notes") || !strcmp(arg, "--notes")) {
-		revs->show_notes = 1;
+		revs->show_notes = set_display_notes(&revs->notes_opt, 1, NULL);
 		revs->show_notes_given = 1;
-		revs->notes_opt.use_default_notes = 1;
 	} else if (!strcmp(arg, "--show-signature")) {
 		revs->show_signature = 1;
 	} else if (!strcmp(arg, "--no-show-signature")) {
@@ -2189,25 +2188,14 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->track_first_time = 1;
 	} else if (skip_prefix(arg, "--show-notes=", &optarg) ||
 		   skip_prefix(arg, "--notes=", &optarg)) {
-		struct strbuf buf = STRBUF_INIT;
-		revs->show_notes = 1;
-		revs->show_notes_given = 1;
 		if (starts_with(arg, "--show-notes=") &&
 		    revs->notes_opt.use_default_notes < 0)
 			revs->notes_opt.use_default_notes = 1;
-		strbuf_addstr(&buf, optarg);
-		expand_notes_ref(&buf);
-		string_list_append(&revs->notes_opt.extra_notes_refs,
-				   strbuf_detach(&buf, NULL));
+		revs->show_notes = set_display_notes(&revs->notes_opt, 1, optarg);
+		revs->show_notes_given = 1;
 	} else if (!strcmp(arg, "--no-notes")) {
-		revs->show_notes = 0;
+		revs->show_notes = set_display_notes(&revs->notes_opt, 0, NULL);
 		revs->show_notes_given = 1;
-		revs->notes_opt.use_default_notes = -1;
-		/* we have been strdup'ing ourselves, so trick
-		 * string_list into free()ing strings */
-		revs->notes_opt.extra_notes_refs.strdup_strings = 1;
-		string_list_clear(&revs->notes_opt.extra_notes_refs, 0);
-		revs->notes_opt.extra_notes_refs.strdup_strings = 0;
 	} else if (!strcmp(arg, "--standard-notes")) {
 		revs->show_notes_given = 1;
 		revs->notes_opt.use_default_notes = 1;
-- 
2.24.0.627.geba02921db


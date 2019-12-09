Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260D3C00454
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 13:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2A22073D
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 13:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxWwoHa4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfLINKp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 08:10:45 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:43120 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfLINKo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 08:10:44 -0500
Received: by mail-pj1-f65.google.com with SMTP id g4so5879164pjs.10
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 05:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ks8eZSHvh7qET3gZ4zemF1h7mW7pJrNk+Ou3vtulXA4=;
        b=TxWwoHa4FgXxf6hVHt2mzsYii2FjO8aOMDic6coJR0P3gI+ayx8+oDwJh+XpYYdik4
         gTvf8E+U1rKzcGWsNV+zZ5jXoifKPzobnDORHByPcFq26StSpKloD5/I0csyMhjPj7Oe
         kS+M58nGdbWNc9gXrn9A8QrKiOwdlKpmM+6bBzBV358GH3d/xeAtkC1LeREVZrnc1WMZ
         CwvN3Gfr3Na6vLhh4v159H2TJ7NzwrlIqca9nLdVCBSjJz+ghzp9Yc90s1nL/SleVZh5
         X8vGsb2ZwaMZSUKKJDHoOju9/diobMmpCr7orW4QNVsxTH4L1PY6g21pJlnVEJxyqOZk
         FlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ks8eZSHvh7qET3gZ4zemF1h7mW7pJrNk+Ou3vtulXA4=;
        b=C6P0EDelF+1G4xlGsZd9Q7pSQa8HSFSWVhDntTtdzQAzJ/F/cKcLvH9VyA7p/nZ/x4
         rRzrClmnBiGqYptWN6yqYImjOFPvRj+YEyqoiK56hLYY0BNxfHfZLS/OwiSJBi/DT44D
         h2kDOWIT1S4R0k7GQwGJ2jAdlIddhcls4/KrcKHfEL53znqaYuHU+4KfzpUrG/igOc5l
         br6+6VSpZO+3454cahc3WdxAsCA8igqDJqLGUQ+K7FSmdlJvTsNhjebGVphSmkK0ARy2
         pd/OM7z2yXxaLBLaWHM1A42ynjIa7WwH0M/rt//qSdS6fsEvTF6sQcJM8ITtaVQY9P++
         tN3A==
X-Gm-Message-State: APjAAAXMe0USb6QdE7O1oFjBBoZO+BoMQZ/OyotrGRSXZ2scR4ehY417
        ySbK2uXIcru0ge3a5isfUMVV/GeS
X-Google-Smtp-Source: APXvYqz1QTpzZQsk0WH4FkXqrGvVUPqCECPon8dhyO6zc/su588HzMSKRyrk+5kn5TUqA2ekzdkoew==
X-Received: by 2002:a17:902:104:: with SMTP id 4mr30448398plb.130.1575897043925;
        Mon, 09 Dec 2019 05:10:43 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id 2sm24813113pgo.79.2019.12.09.05.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 05:10:43 -0800 (PST)
Date:   Mon, 9 Dec 2019 05:10:41 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Pavel Roskin <plroskin@gmail.com>
Subject: [PATCH 2/5] notes: create init_display_notes() helper
Message-ID: <bb66c95f43e2cb727a9aafbce8c70f25df513a13.1575896661.git.liu.denton@gmail.com>
References: <cover.1575896661.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575896661.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We currently open code the initialization for revs->notes_opt. Abstract
this away into a helper function so that the logic can be reused in a
future commit.

This is slightly wasteful as we memset the struct twice but this is only
run once so it shouldn't have any major effect.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 notes.c    | 6 ++++++
 notes.h    | 5 +++++
 revision.c | 2 +-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/notes.c b/notes.c
index fd6cef14a3..53d1e7767c 100644
--- a/notes.c
+++ b/notes.c
@@ -1039,6 +1039,12 @@ struct notes_tree **load_notes_trees(struct string_list *refs, int flags)
 	return trees;
 }
 
+void init_display_notes(struct display_notes_opt *opt)
+{
+	memset(opt, 0, sizeof(*opt));
+	opt->use_default_notes = -1;
+}
+
 void load_display_notes(struct display_notes_opt *opt)
 {
 	char *display_ref_env;
diff --git a/notes.h b/notes.h
index 1ce528442a..c0b712371c 100644
--- a/notes.h
+++ b/notes.h
@@ -260,6 +260,11 @@ struct display_notes_opt {
 	struct string_list extra_notes_refs;
 };
 
+/*
+ * Initialize a display_notes_opt to its default value.
+ */
+void init_display_notes(struct display_notes_opt *opt);
+
 /*
  * Load the notes machinery for displaying several notes trees.
  *
diff --git a/revision.c b/revision.c
index d4aaf0ef25..24ad974590 100644
--- a/revision.c
+++ b/revision.c
@@ -1637,7 +1637,7 @@ void repo_init_revisions(struct repository *r,
 		revs->diffopt.prefix_length = strlen(prefix);
 	}
 
-	revs->notes_opt.use_default_notes = -1;
+	init_display_notes(&revs->notes_opt);
 }
 
 static void add_pending_commit_list(struct rev_info *revs,
-- 
2.24.0.627.geba02921db


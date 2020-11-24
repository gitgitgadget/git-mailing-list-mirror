Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E03C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 21:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6118320789
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 21:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hu9HH4kg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgKXVEv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 16:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbgKXVEu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 16:04:50 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8081DC0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 13:04:50 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id d20so20239lfe.11
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 13:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MpzEtaiZqKT0T5CsKXtV24LR2pR24pv/lx03VIGA7iI=;
        b=Hu9HH4kg3PLbutx2eZZwW8jQWOR2EQKJjS9V05lQw2gGN9kFrwTBFHkKTgE2rIUcQ+
         IjwAIm+zHeFEzBaPN0VyZ6WCkGSricEFt9ziKFaQEmb5syUo4CmZw+gMe4742W6T1CCI
         iHO4pj9Cau9wg9PASw3kG5/TA7wR935heMCwrbWakqubxYry5NJH0vNdyd+IRr2ZIfPd
         E1CdkU+dBs27vHVEPa/xRhmdXmus5RKaBGl8iJsEzgrcMU8xEwnJ+0srll4j0S/wwMs8
         6nRbIGawl9LIP9G4EqYPPvEDcpQN3qUZqEhYQFFP0K59TkIwdKUwp93d62aGEJLrMINr
         AYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MpzEtaiZqKT0T5CsKXtV24LR2pR24pv/lx03VIGA7iI=;
        b=j+6TbMNPA827jvEr9uInDmnnwtGrCwiOJ2rtLS0K9xsRyHS+UdEzd8ZDDbk6HhTUe/
         EXZkf6gHN8fHcy9v31aTw0xu6GQe9FSxaJb3S11JwDi2f21LBevDNrILdWHIB6T/ZlxC
         SoxbMzlYZDdNOJ75qWvyKlMk/8Mqd0waM4ErZRQDS5BQAdIfQD37kYT4GbLIky4LEHGH
         o6NQAPB4xcvmvif5tImkySTYCDTZaXn6HFqHiXlL2a3MJagwOSDkh9plUZpvuKhaeu0t
         Vr8PVYN+/Fa2stVyjzVMeZbNpYKLy+UyILBDpDVuACU2ylUDJAzjBX1XrOI1aIWWGmFH
         r6Kw==
X-Gm-Message-State: AOAM533+fekvJ62nJf/SbiD6AsB02AoImK/aRkkOAowlMjKQ2FdiPdkT
        pHTKJ/0EKSihTs8zemn3PnAn6bU54pGyWA==
X-Google-Smtp-Source: ABdhPJy/X6MA7vI4+fkILqcPfZS3EbU+EdR44HnFwOiYtzQnOqEZ/lEMY9s28AI2HmjHary06/UyZA==
X-Received: by 2002:a19:ca0a:: with SMTP id a10mr4250lfg.121.1606251888654;
        Tue, 24 Nov 2020 13:04:48 -0800 (PST)
Received: from localhost.localdomain (h-79-136-116-123.NA.cust.bahnhof.se. [79.136.116.123])
        by smtp.gmail.com with ESMTPSA id z20sm22911ljm.138.2020.11.24.13.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 13:04:48 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 1/4] grep: don't set up a "default" repo for grep
Date:   Tue, 24 Nov 2020 22:04:13 +0100
Message-Id: <56c00645c55f0e2cb3d21b19e397f449968b869d.1606251357.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2
In-Reply-To: <cover.1606251357.git.martin.agren@gmail.com>
References: <cover.1605972564.git.martin.agren@gmail.com> <cover.1606251357.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`init_grep_defaults()` fills a `static struct grep_opt grep_defaults`.
This struct is then used by `grep_init()` as a blueprint for other such
structs. Notably, `grep_init()` takes a `struct repo *` and assigns it
into the target struct.

As a result, it is unnecessary for us to take a `struct repo *` in
`init_grep_defaults()` as well. We assign it into the default struct and
never look at it again. And in light of how we return early if we have
already set up the default struct, it's not just unnecessary, but is
also a bit confusing: If we are called twice and with different repos,
is it a bug or a feature that we ignore the second repo?

Drop the repo parameter for `init_grep_defaults()`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/MyFirstObjectWalk.txt | 2 +-
 grep.h                              | 2 +-
 builtin/grep.c                      | 2 +-
 builtin/log.c                       | 2 +-
 grep.c                              | 3 +--
 revision.c                          | 2 +-
 6 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index c3f2d1a831..85434d1938 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -394,7 +394,7 @@ First some setup. Add `init_grep_defaults()` to `init_walken_defaults()` and add
 ----
 static void init_walken_defaults(void)
 {
-	init_grep_defaults(the_repository);
+	init_grep_defaults();
 }
 
 ...
diff --git a/grep.h b/grep.h
index 9115db8515..1c5478f381 100644
--- a/grep.h
+++ b/grep.h
@@ -170,7 +170,7 @@ struct grep_opt {
 	void *output_priv;
 };
 
-void init_grep_defaults(struct repository *);
+void init_grep_defaults(void);
 int grep_config(const char *var, const char *value, void *);
 void grep_init(struct grep_opt *, struct repository *repo, const char *prefix);
 void grep_destroy(void);
diff --git a/builtin/grep.c b/builtin/grep.c
index e58e57504c..2b96efa8c2 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -950,7 +950,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	init_grep_defaults(the_repository);
+	init_grep_defaults();
 	git_config(grep_cmd_config, NULL);
 	grep_init(&opt, the_repository, prefix);
 
diff --git a/builtin/log.c b/builtin/log.c
index 49eb8f6431..eee4beca4d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -131,7 +131,7 @@ static int log_line_range_callback(const struct option *option, const char *arg,
 
 static void init_log_defaults(void)
 {
-	init_grep_defaults(the_repository);
+	init_grep_defaults();
 	init_diff_ui_defaults();
 
 	decoration_style = auto_decoration_style();
diff --git a/grep.c b/grep.c
index 54af9f813e..b351449f7f 100644
--- a/grep.c
+++ b/grep.c
@@ -57,7 +57,7 @@ static void color_set(char *dst, const char *color_bytes)
  * We could let the compiler do this, but without C99 initializers
  * the code gets unwieldy and unreadable, so...
  */
-void init_grep_defaults(struct repository *repo)
+void init_grep_defaults(void)
 {
 	struct grep_opt *opt = &grep_defaults;
 	static int run_once;
@@ -67,7 +67,6 @@ void init_grep_defaults(struct repository *repo)
 	run_once++;
 
 	memset(opt, 0, sizeof(*opt));
-	opt->repo = repo;
 	opt->relative = 1;
 	opt->pathname = 1;
 	opt->max_depth = -1;
diff --git a/revision.c b/revision.c
index aa62212040..f35ea1db11 100644
--- a/revision.c
+++ b/revision.c
@@ -1834,7 +1834,7 @@ void repo_init_revisions(struct repository *r,
 	revs->commit_format = CMIT_FMT_DEFAULT;
 	revs->expand_tabs_in_log_default = 8;
 
-	init_grep_defaults(revs->repo);
+	init_grep_defaults();
 	grep_init(&revs->grep_filter, revs->repo, prefix);
 	revs->grep_filter.status_only = 1;
 
-- 
2.29.2.454.gaff20da3a2


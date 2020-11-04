Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F33C388F9
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 15:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5822A2074F
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 15:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLUFkQAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbgKDP3w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 10:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbgKDP3t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 10:29:49 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9674C0613D4
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 07:29:48 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id n18so22479423wrs.5
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 07:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7P9hAwTawxl1QRpgSseEa6fuJdtQ4i65raTjuP5+wEQ=;
        b=PLUFkQAnJu6j+BMs4AJzZiyDtHOejvdnomOuv378udhtg6c9kptAEG9ZWOoCCzzdJl
         ArfM1u3qU373WGFnRanN4VljgHwXUkL8N5fno/brZ64ZuCq2+raK6hoxKfLnTcw1yX6A
         XDGSfEteHYoocZvxnHQ3BS76IknLCpnz1CQJieNtlzWrvHnvDO34iPtJNM5vLv7++TYy
         MTg/QAR67+bPeUh3KFph1WYkQR+D80FrGETD45NW0Llwcf+6uydhtZuTjYLYBG0t71Wc
         GQSB8xYPWYmSpiixrWQIVRtuPKI9JknVQUXiG6+UYds/WsEBz9CaCf2AGIHtDnzVIsIb
         3wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7P9hAwTawxl1QRpgSseEa6fuJdtQ4i65raTjuP5+wEQ=;
        b=kn4i4Yr/tepcAI5XZccxXSaUG08CMoYMjBioOuIjVd/wMxjrYh0OVtnEs/JlIaOsHr
         4syglfTsALRoQo9SRN4hbWomKG7gkFKKzUSoQIh20IiCN7rFOFEv3JZC5PNDHpa+aCT5
         EG5RnlQ8uecUyj8WS2MYlMq7OwJAeUZDvNbNHpBWtZmCyM2ShtTLBsMNknnqAuWWJo3y
         81jsu38a1A7iDkBYT8nlSu5FdgFF69hx6QSldJxQtXNY2QOeYazoJXmxvQhN2giBCTzD
         VZJE31HuFo+RZbWe9/JPU90lXu+xPoi42nsW54xlsS8E3Y446i6bxn4W0agBdjYVhBI2
         c/lw==
X-Gm-Message-State: AOAM531B/tF6rbfU2dbTFPTadLYfZQBKfzUwWUQUGAeGfetKGVDuOxZV
        AxYH5G0QipaTJ0UWpoAkTVNVYuiEVeo=
X-Google-Smtp-Source: ABdhPJyEbxI9PuUqY2mY1eDocJqCQXf0C+8quhfFGhlseoAVP+FjSjc6QDTTVKqF3Vt+dKACv6McZQ==
X-Received: by 2002:a5d:6287:: with SMTP id k7mr32430692wru.402.1604503785968;
        Wed, 04 Nov 2020 07:29:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b63sm2971784wme.9.2020.11.04.07.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 07:29:45 -0800 (PST)
Message-Id: <076d212915c9a1706d18c5b1829bf0bf22bf5095.1604503780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.773.v2.git.1604503780.gitgitgadget@gmail.com>
References: <pull.773.git.1603807337.gitgitgadget@gmail.com>
        <pull.773.v2.git.1604503780.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Nov 2020 15:29:39 +0000
Subject: [PATCH v2 3/4] rebase -i: use struct object_id when writing state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Rather than passing a string around pass the struct object_id that the
string was created from call oid_hex() when we write the file.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 5 +++--
 sequencer.c      | 5 +++--
 sequencer.h      | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 4e4a5e774e..28e7b7f5ce 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -296,7 +296,8 @@ static int get_revision_ranges(struct commit *upstream, struct commit *onto,
 }
 
 static int init_basic_state(struct replay_opts *opts, const char *head_name,
-			    struct commit *onto, const char *orig_head)
+			    struct commit *onto,
+			    const struct object_id *orig_head)
 {
 	FILE *interactive;
 
@@ -340,7 +341,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 
 	if (init_basic_state(&replay,
 			     opts->head_name ? opts->head_name : "detached HEAD",
-			     opts->onto, head_hash)) {
+			     opts->onto, &opts->orig_head)) {
 		free(revisions);
 		free(shortrevisions);
 
diff --git a/sequencer.c b/sequencer.c
index f79c3df861..2037f0ba66 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2692,7 +2692,7 @@ static void write_strategy_opts(struct replay_opts *opts)
 }
 
 int write_basic_state(struct replay_opts *opts, const char *head_name,
-		      struct commit *onto, const char *orig_head)
+		      struct commit *onto, const struct object_id *orig_head)
 {
 	if (head_name)
 		write_file(rebase_path_head_name(), "%s\n", head_name);
@@ -2700,7 +2700,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_onto(), "%s\n",
 			   oid_to_hex(&onto->object.oid));
 	if (orig_head)
-		write_file(rebase_path_orig_head(), "%s\n", orig_head);
+		write_file(rebase_path_orig_head(), "%s\n",
+			   oid_to_hex(orig_head));
 
 	if (opts->quiet)
 		write_file(rebase_path_quiet(), "%s", "");
diff --git a/sequencer.h b/sequencer.h
index ea56825488..cf201f2406 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -227,7 +227,7 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 		       int allow_missing);
 void parse_strategy_opts(struct replay_opts *opts, char *raw_opts);
 int write_basic_state(struct replay_opts *opts, const char *head_name,
-		      struct commit *onto, const char *orig_head);
+		      struct commit *onto, const struct object_id *orig_head);
 void sequencer_post_commit_cleanup(struct repository *r, int verbose);
 int sequencer_get_last_command(struct repository* r,
 			       enum replay_action *action);
-- 
gitgitgadget


Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2B7C388F9
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 18:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B54B520773
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 18:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqpAWhE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1827192AbgJ0SWC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 14:22:02 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:37910 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753812AbgJ0OCY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 10:02:24 -0400
Received: by mail-wr1-f49.google.com with SMTP id n18so2052841wrs.5
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 07:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S6HMBHnVySI2rqEgBg3+alOlWIeaRuyc4pqh+3dqsIo=;
        b=iqpAWhE6SKTjx5wWxksBwYVAZFwLshED81tqkzcPRPav6FO8+vgpNaYO35GmLzjc76
         FWqsTPFkIHEBekQIoGTtyeIL7uFzk6vH2kMftoWV0XaEDhsIIaoOoyHV4Fn2u82fyEwo
         qia49YCRUavgWwwArnSXG3RGb7wv4/2nE6AQcjasm3+IPkDjLaGA74X767aeuF8x0iZO
         5nohGHeysL35SAqCoeHVa5dmZy7wQHbuATwVUWv4Fk3ecSw47miqUq5p0trkFxLMqAXO
         w46DgT6LmwAUmxc8oq6CJCHfRVDnGWg/n0GDXrRFepSWa6F7gxJvm9M3P8UiuKky2XGJ
         j4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S6HMBHnVySI2rqEgBg3+alOlWIeaRuyc4pqh+3dqsIo=;
        b=MS/ail8EM8YW6FTEypkcdNhbWZYOaeGONoW3QO21ua7TE6hslJQlpz+XA9BO82Qbso
         jT2V2VkeGx+JDyU8jxjWGeQCfm/9QxSi/YOU+LueSODW/gQZIv69KExCe3GW1H+m078i
         ei/i82TnRz0dXI1xKb5B5EwsAqvKyMAd5G63Sj/JOaoljqD3WNeUKBXpHC8ThpAiASlK
         jzPi70mq30e2kvR6SxTImVnJ95YFS3v5CCTOSxolXOUCg8thiR0XKySu4GJM5ITJjaGN
         xe68NiEJVxHhbs55QKSXllc5SKSP9s991oxHcRfIRf6npNdb20ET/aPqiCkh8nnuAJev
         OZqQ==
X-Gm-Message-State: AOAM531oaHkL3XNPw973an0+yYlcpiKKNXMbD1gHArzaU6YN+UQZmgK2
        b/1uHv0luBrzlILmfm/xE5k15+087X4=
X-Google-Smtp-Source: ABdhPJz5M4s3Ieheb2INCWTjbMJFEsyVo9U2iLDU5C7Fec/48949Fm9Zx23yfw6HXe9BoxZW9ANymQ==
X-Received: by 2002:adf:fc8b:: with SMTP id g11mr3107788wrr.300.1603807342018;
        Tue, 27 Oct 2020 07:02:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e7sm2376021wrm.6.2020.10.27.07.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 07:02:21 -0700 (PDT)
Message-Id: <11494a7b79cd5b6fbef51720e7111a94e7bd650e.1603807338.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.773.git.1603807337.gitgitgadget@gmail.com>
References: <pull.773.git.1603807337.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Oct 2020 14:02:16 +0000
Subject: [PATCH 3/4] rebase -i: use struct object_id when writing state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Caspar Duregger <herr.kaste@gmail.com>,
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
 builtin/rebase.c | 3 ++-
 sequencer.c      | 5 +++--
 sequencer.h      | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index d975918de6..f94f9fe307 100644
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


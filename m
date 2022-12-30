Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2088FC4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 07:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbiL3H23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 02:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbiL3H2W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 02:28:22 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C9218B2F
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 23:28:20 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id ja17so14658221wmb.3
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 23:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEXsZGMKbnCOmMrqSxpq6j3rMj3iJt7KtJfq/5ZEi3s=;
        b=DrGBKfDga/UbjMpZdx7Eh50R5+ILvWouhFJmyaqg8IE9Q38wiFWca5fUfG1dUwPjvC
         4gMZheNMYP37P6lugsjElpSmZqdVYpslYMSwXXh5vbNO4dhV7agQMouazNSpB4dnlbnp
         kV/2wUCAHDFL9RQtVLIgaPCEG/UN9t5CdTMxHIXTD2tt9jIPRCxzJEG/ajMpHZJlmmsN
         GGdYt12o07petMRssnVVKlx9JlXpH+OoH6QlMCmn65Yq6lwU3Ta2D+UPJWsvNjHTHuUD
         FwTTbRmlLD8VqmIaWWVduuH5nI/Ocf/tV7iVoZ/HwD7ICH1EMFhO9WugKWB0m7IEBHHy
         6mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEXsZGMKbnCOmMrqSxpq6j3rMj3iJt7KtJfq/5ZEi3s=;
        b=1g03/PMiaY+CdDLST/ESHXzenNygeFvnHw1rvDkUXkC/S93B17wWEH+Vd2E3k8ZAip
         br5BHUwfCXnxQB5rmKqdKItXphBR94Qysyhwd/4INa4OpW+bbMWpEOBAAdtC69JqW3h1
         THynCl0MY0PA7Uv7f/N2z9CF5vP6EauRYl3cm93x2PBPIt33Tm8aTgo++WN8+NEnAzB2
         a1WED3WmhM5on6R2PpPxK9v+64CFC4crOdehZ5RHAYiDMDP13q3pM1dg8jQi9vHFyFoz
         yvg2xDSl9EhwhxZjnCn7Id8G37avCrWxbPcU1v1aovzrK9bZkmf//zfJMoBtY8hYo2Hg
         n+zQ==
X-Gm-Message-State: AFqh2kqr/O3ZrdiN/BaAnyxjhQ1yTE2u0X0HtGIazQKdbBiBSzTcq3Pl
        qZ697mFLSTnYOd2MH9T6nJwB7JI1jxg77g==
X-Google-Smtp-Source: AMrXdXuzwUga5KaVrJEJHaoOXRas39v7sUy66GCCh1cJDy6G6iciAp+mAofupr61yFHZYr46lEPeqw==
X-Received: by 2002:a05:600c:4e51:b0:3cf:7b8b:6521 with SMTP id e17-20020a05600c4e5100b003cf7b8b6521mr21436519wmq.32.1672385299213;
        Thu, 29 Dec 2022 23:28:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b003d998412db6sm6526449wmn.28.2022.12.29.23.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 23:28:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/10] rebase: use "cleanup" pattern in do_interactive_rebase()
Date:   Fri, 30 Dec 2022 08:28:06 +0100
Message-Id: <patch-01.10-f3a4ed79c7d-20221230T071741Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use a "goto cleanup" pattern in do_interactive_rebase(). This
eliminates some duplicated free() code added in 0609b741a43 (rebase
-i: combine rebase--interactive.c with rebase.c, 2019-04-17), and sets
us up for a subsequent commit which'll make further use of the
"cleanup" label.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 1481c5b6a5b..7141fd5e0c1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -256,7 +256,7 @@ static void split_exec_commands(const char *cmd, struct string_list *commands)
 
 static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 {
-	int ret;
+	int ret = -1;
 	char *revisions = NULL, *shortrevisions = NULL;
 	struct strvec make_script_args = STRVEC_INIT;
 	struct todo_list todo_list = TODO_LIST_INIT;
@@ -265,16 +265,12 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 
 	if (get_revision_ranges(opts->upstream, opts->onto, &opts->orig_head->object.oid,
 				&revisions, &shortrevisions))
-		return -1;
+		goto cleanup;
 
 	if (init_basic_state(&replay,
 			     opts->head_name ? opts->head_name : "detached HEAD",
-			     opts->onto, &opts->orig_head->object.oid)) {
-		free(revisions);
-		free(shortrevisions);
-
-		return -1;
-	}
+			     opts->onto, &opts->orig_head->object.oid))
+		goto cleanup;
 
 	if (!opts->upstream && opts->squash_onto)
 		write_file(path_squash_onto(), "%s\n",
@@ -304,6 +300,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 			opts->autosquash, opts->update_refs, &todo_list);
 	}
 
+cleanup:
 	string_list_clear(&commands, 0);
 	free(revisions);
 	free(shortrevisions);
-- 
2.39.0.1153.g589e4efe9dc


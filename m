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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376A3C433FE
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 00:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A0CA60E9B
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 00:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbhILARZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 20:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbhILARW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 20:17:22 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365E6C061757
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 17:16:09 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m9so8496747wrb.1
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 17:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZVygsSuXHuZJi9knm7pqlmkVdykROSUGvWUOAWL3Z94=;
        b=UDp1Ug4bIgKr1NB6HFAzZB0r0R2e2Q86IzYex21spvTSep78CRp7LeaYdxspz1FPXx
         vIW9/LMhFbaqOqBxgHLVf5GMRkTnMJAhrb+sGKDfXVwOJ1tnviPfWnM51t02AgpNZHQN
         G8/s9zyjIt6wzxu2X5MKG4wziel7Gmo4+v2SMPKQ6WyfFKjcD5WKXIoesfdDjQSgvv+h
         ajEnjNlXAarQof+3iEaIirFlpJqiiibzVy0dt9RS5x3nR1eLNGAEof17HhFuz2AAN0c5
         QFtWjL70CgycpwxYvqxPcgxMUu/0V+SpfMgFan+3cLKSeKKrwuBfCLlTFfuk4Boe6yGG
         8fVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZVygsSuXHuZJi9knm7pqlmkVdykROSUGvWUOAWL3Z94=;
        b=P/2RUcTb0wf+I2XO6GR7938fDKt1x2eMXIB9oQWmTh/9ZhWfYOjPKOJrHYD2MRxqZf
         1lPGpmtG0ytwyxAJ37l5jObUffuvIQIyUl9RzmZ1151YoQH+9yAxxotbiDd34V6AqkCd
         /+tVbLnjrSM2lolUMMVxL7SCe/soP6xjFU6NiGsRN0CJholD0+8bqTEY26Knj/hjXm2k
         moKEtC55FXSQ+ASMDFgyPEi6lYdkTJo0bmRypjXVIhDAOJekYRWig1E4d0VEZvCwSJ8T
         9x+azajUJXXmgmvocjbpIWrHUJTCUlVQYggdvG2uYUlj4IrmezCgE004748TeXP/uCeg
         F9nA==
X-Gm-Message-State: AOAM531gksl1ksQXXCcx5LZK159kHgwZ/AOrBct2HtBAF4WraWllu3jk
        2FhvHfkJ1ZPNZx0KmHHWrQN+5f5uCByP5A==
X-Google-Smtp-Source: ABdhPJxFIhrk4XwVo434GXW+MZOFZc+ag9ci8JOufgWejMECdm7WXcKpc/38o05LI4EcaugmF3CAUA==
X-Received: by 2002:a5d:6792:: with SMTP id v18mr5098378wru.416.1631405767615;
        Sat, 11 Sep 2021 17:16:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p5sm3301078wrd.25.2021.09.11.17.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 17:16:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/7] sequencer.[ch]: pass "struct strvec *" instead of int/char ** pair
Date:   Sun, 12 Sep 2021 02:15:51 +0200
Message-Id: <patch-v2-3.7-c35cfb9c9c5-20210912T001420Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.998.ga4d44345d43
In-Reply-To: <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com>
References: <5e5e7fd9-83d7-87f7-b1ef-1292912b6c00@iee.email> <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As in the preceding commit, prepare for the "nr" member of "struct
strvec" changing from an "int" to a "size_t". These are the same sorts
of changes to pass a "struct strvec *" further down instead of passing
args->nr and args->v.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c | 3 +--
 sequencer.c      | 6 +++---
 sequencer.h      | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index eb01f4d790b..27669880918 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -363,8 +363,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 			     oid_to_hex(&opts->restrict_revision->object.oid));
 
 	ret = sequencer_make_script(the_repository, &todo_list.buf,
-				    make_script_args.nr, make_script_args.v,
-				    flags);
+				    &make_script_args, flags);
 
 	if (ret)
 		error(_("could not generate todo list"));
diff --git a/sequencer.c b/sequencer.c
index 68316636921..a4ba434f173 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5355,8 +5355,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	return 0;
 }
 
-int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
-			  const char **argv, unsigned flags)
+int sequencer_make_script(struct repository *r, struct strbuf *out,
+			  struct strvec *args, unsigned flags)
 {
 	char *format = NULL;
 	struct pretty_print_context pp = {0};
@@ -5390,7 +5390,7 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 	pp.fmt = revs.commit_format;
 	pp.output_encoding = get_log_output_encoding();
 
-	if (setup_revisions(argc, argv, &revs, NULL) > 1)
+	if (setup_revisions(args->nr, args->v, &revs, NULL) > 1)
 		return error(_("make_script: unhandled options"));
 
 	if (prepare_revision_walk(&revs) < 0)
diff --git a/sequencer.h b/sequencer.h
index 2088344cb37..36f67164f86 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -158,8 +158,8 @@ int sequencer_remove_state(struct replay_opts *opts);
 #define TODO_LIST_REAPPLY_CHERRY_PICKS (1U << 7)
 #define TODO_LIST_WARN_SKIPPED_CHERRY_PICKS (1U << 8)
 
-int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
-			  const char **argv, unsigned flags);
+int sequencer_make_script(struct repository *r, struct strbuf *out,
+			  struct strvec *args, unsigned flags);
 
 void todo_list_add_exec_commands(struct todo_list *todo_list,
 				 struct string_list *commands);
-- 
2.33.0.998.ga4d44345d43


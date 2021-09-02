Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56213C4320A
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E2CE6108E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345209AbhIBNOK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345182AbhIBNNt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:13:49 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FDFC0611BC
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:12:14 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id e26so1251745wmk.2
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=olypxuI2oX+Z9/4FTiGEAEVgrnYFdmv2uO5BZ0kFp7k=;
        b=Tc1lZu9KqTVlUd2TC7uhKn0UWaLIid4FrInenJyRUVK6+ZJlI9r0EU/nwZ/h/CTvcU
         0ZO4DbB+nIv4mzKRKW4drrAbz2nf8FKGasNWkMyi+MbW7qBj+1lKNinApUpdrnt0ltxv
         zvTJ11Pil5cK+cttGMrnydSuJ98ITpmdBU6myL9ghvggHTwZUOauxeBWILXcRxjdbjxk
         p3rOnRdKys9gWpQr1m8Wy3SYf/grO56Qk+X4y4dDuS+oyo/DiEKKl3x63dOYIS6AldeX
         MCc5OBMUFpu4F7CvZzlDw/ENQ54r74o5mgbGYfC8ofFpRXjTlvhmKw4dqoML6xg0jXgg
         S4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=olypxuI2oX+Z9/4FTiGEAEVgrnYFdmv2uO5BZ0kFp7k=;
        b=kzIRPAtBWdKsxATyNdSXgCofK74W/SXE7nuR2Bq6fKuY8NDBoFYwKmij76e6tCVLFh
         Vy+uKOqey2uKvWqTgj/sO6J02LFoM2RJ57KqJpC1yz//By253uFmxIiW0JcQ58ub/qM8
         UZzUXaCar4f4NTdZKvttRBTCpn0ajveEOrRkXXFZOLwUI2zqTMfb39HsSzgN9qDvIAJm
         9B55PX21oaz2MHgeIZEXFGHrAt/a3Znq3FhJ7GISHa1MWSg9rUO/r1EXPH+cjO2rep/S
         2ulb7tEmcKrW6Fx07MVxRkGx2ZbUTd1l2ucqwyNT+LlxZaBU/Zrd3mYDLO/FchCEY4pb
         VO0g==
X-Gm-Message-State: AOAM533xybWNqkNVsTLV3aahyaoyBMqxsf4eBnAdjPFoBPzkA4NvCoHF
        OfGvAjB2aUzR49a0N0P01YuQsd4Srst60g==
X-Google-Smtp-Source: ABdhPJx4D4MoRmt8GgdgXeaioHSRWHI9gNzublcmKmNNeYeuBeyrD6wW4Mzbm7mkTeri6pr9IVYCRQ==
X-Received: by 2002:a7b:c4cb:: with SMTP id g11mr3144367wmk.80.1630588332652;
        Thu, 02 Sep 2021 06:12:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:12:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 27/36] transport: convert pre-push hook to hook.h
Date:   Thu,  2 Sep 2021 15:11:27 +0200
Message-Id: <patch-v5-27.36-af6b9292aaa-20210902T125111Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com> <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the pre-push hook away from run-command.h to and over to the new
hook.h library.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 transport.c | 56 ++++++++++++++---------------------------------------
 1 file changed, 14 insertions(+), 42 deletions(-)

diff --git a/transport.c b/transport.c
index 77e196f75f5..4ca8fc0391d 100644
--- a/transport.c
+++ b/transport.c
@@ -1203,63 +1203,35 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
 static int run_pre_push_hook(struct transport *transport,
 			     struct ref *remote_refs)
 {
-	int ret = 0, x;
+	int ret = 0;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	struct ref *r;
-	struct child_process proc = CHILD_PROCESS_INIT;
-	struct strbuf buf;
-	const char *argv[4];
-
-	if (!(argv[0] = find_hook("pre-push")))
-		return 0;
-
-	argv[1] = transport->remote->name;
-	argv[2] = transport->url;
-	argv[3] = NULL;
-
-	proc.argv = argv;
-	proc.in = -1;
-	proc.trace2_hook_name = "pre-push";
-
-	if (start_command(&proc)) {
-		finish_command(&proc);
-		return -1;
-	}
+	struct string_list to_stdin = STRING_LIST_INIT_NODUP;
 
-	sigchain_push(SIGPIPE, SIG_IGN);
-
-	strbuf_init(&buf, 256);
+	strvec_push(&opt.args, transport->remote->name);
+	strvec_push(&opt.args, transport->url);
 
 	for (r = remote_refs; r; r = r->next) {
+		struct strbuf buf = STRBUF_INIT;
+
 		if (!r->peer_ref) continue;
 		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
 		if (r->status == REF_STATUS_REJECT_STALE) continue;
 		if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) continue;
 		if (r->status == REF_STATUS_UPTODATE) continue;
 
-		strbuf_reset(&buf);
-		strbuf_addf( &buf, "%s %s %s %s\n",
+		strbuf_addf(&buf, "%s %s %s %s",
 			 r->peer_ref->name, oid_to_hex(&r->new_oid),
 			 r->name, oid_to_hex(&r->old_oid));
-
-		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
-			/* We do not mind if a hook does not read all refs. */
-			if (errno != EPIPE)
-				ret = -1;
-			break;
-		}
+		string_list_append(&to_stdin, strbuf_detach(&buf, NULL));
 	}
 
-	strbuf_release(&buf);
-
-	x = close(proc.in);
-	if (!ret)
-		ret = x;
-
-	sigchain_pop(SIGPIPE);
+	opt.feed_pipe = pipe_from_string_list;
+	opt.feed_pipe_ctx = &to_stdin;
 
-	x = finish_command(&proc);
-	if (!ret)
-		ret = x;
+	ret = run_hooks_oneshot("pre-push", &opt);
+	to_stdin.strdup_strings = 1;
+	string_list_clear(&to_stdin, 0);
 
 	return ret;
 }
-- 
2.33.0.816.g1ba32acadee


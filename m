Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B3AC4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 07:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbiL3H2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 02:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbiL3H2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 02:28:25 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C2A18B2F
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 23:28:24 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so12460896wms.0
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 23:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMJbdfDAUOntlmO+Tipo3vpuLC2gDe5+Ru/8sKKhi5w=;
        b=Tj/KgbSCFQgrJ0FG3cZhR9jy8DL8XZ/tlWb+76Vp1IJ9UCRY+ul6o+p1E1RqUP5ofO
         U9EpRhMPs3M7y8ZzoonmqFyCWLnysroH0f31w42gADwnYYCdX8KAvYh5BZyqZOjC1ae4
         7mQChD6fRsXCE/OYnWFuK9uoQq7CkHjtgekLAH6WEiE3SId4N0sSY6aYmrX1+fJ6EDh3
         MkVdfc9lz2X4k3++cztY/ekpSEmrGBnQ7lLK/+D+8hL1I0p2k2BbKbPdwIHaQ5q9kvGL
         AEURTTHlotuyIzUj29jUB79Bj6QW+tjYgRrSxJSyPEEEkH44jgrixXDksw/mn8XtA0aC
         e0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMJbdfDAUOntlmO+Tipo3vpuLC2gDe5+Ru/8sKKhi5w=;
        b=1B1OA8wUBVSF0a9Ldz0m8AmHsQSHl3N7Xa1qDXlRm5LhN1JhOUWkN3nmqZ295HbUp3
         pHYPF7Qg/Qh5T+qzmJnr73nYU6RSzrR97kDjDRYT/cqLuxesetmOZzxW2TazaPpSaqov
         AaeXrhkPN1KlC/QLNXqrb1LWMsJYi9AvNgY5xbKzezFiax24fLJua/l+UHARJErTiOQ7
         VT0+MSht1EUdkS24P1MFpIWEBaR5kpp98SKr6YdoEPyDh0/leB7NK6MgrVPvJGCz8YO8
         QZa4hZ1oMbDcJEUnm0iixyVVBkP0tZdzy5x36TK/zg/zvnvTch19Uioi6PtZN7qu5fRl
         RyIw==
X-Gm-Message-State: AFqh2kqwqoNuOckmznH7CXmY9G1f80j0G90vL//hGDbKV2giwn30+7uW
        UZPa7NzLx8fzGFvgWQGz9I4YwkcxmF4IpQ==
X-Google-Smtp-Source: AMrXdXvQQbLVWGJPf+nwA0SC9HibnGWk7TQzuNOiLElWYAzhqNXC92HgUMRe1Zeopy7yTP/7CQrCKg==
X-Received: by 2002:a05:600c:3c8c:b0:3d9:719b:bd1b with SMTP id bg12-20020a05600c3c8c00b003d9719bbd1bmr19900819wmb.33.1672385302164;
        Thu, 29 Dec 2022 23:28:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b003d998412db6sm6526449wmn.28.2022.12.29.23.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 23:28:21 -0800 (PST)
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
Subject: [PATCH 04/10] builtin/revert.c: refactor run_sequencer() return pattern
Date:   Fri, 30 Dec 2022 08:28:09 +0100
Message-Id: <patch-04.10-1e4e504c533-20221230T071741Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the return pattern in run_sequencer() to make it easier to
insert a "replay_opts_release()" call between the "fn(...)" invocation
and the eventual return.

Usually we'd name the "cbfun" here "fn", but by using this name we'll
nicely align all the "cmd == ?" comparisons.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/revert.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index f2d86d2a8f9..e956d125a2b 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -93,6 +93,15 @@ static void verify_opt_compatible(const char *me, const char *base_opt, ...)
 		die(_("%s: %s cannot be used with %s"), me, this_opt, base_opt);
 }
 
+static int sequencer_remove_branch_state(struct repository *r,
+					 struct replay_opts *opts)
+{
+	int ret = sequencer_remove_state(opts);
+	if (!ret)
+		remove_branch_state(the_repository, 0);
+	return ret;
+}
+
 static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 {
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
@@ -120,6 +129,8 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 		OPT_END()
 	};
 	struct option *options = base_options;
+	int (*cbfun)(struct repository *repo, struct replay_opts *opts);
+	int ret;
 
 	if (opts->action == REPLAY_PICK) {
 		struct option cp_extra[] = {
@@ -223,19 +234,13 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 		opts->strategy = xstrdup(getenv("GIT_TEST_MERGE_ALGORITHM"));
 	free(options);
 
-	if (cmd == 'q') {
-		int ret = sequencer_remove_state(opts);
-		if (!ret)
-			remove_branch_state(the_repository, 0);
-		return ret;
-	}
-	if (cmd == 'c')
-		return sequencer_continue(the_repository, opts);
-	if (cmd == 'a')
-		return sequencer_rollback(the_repository, opts);
-	if (cmd == 's')
-		return sequencer_skip(the_repository, opts);
-	return sequencer_pick_revisions(the_repository, opts);
+	cbfun = cmd == 'q' ? sequencer_remove_branch_state :
+		cmd == 'c' ? sequencer_continue :
+		cmd == 'a' ? sequencer_rollback :
+		cmd == 's' ? sequencer_skip :
+		sequencer_pick_revisions;
+	ret = cbfun(the_repository, opts);
+	return ret;
 }
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
-- 
2.39.0.1153.g589e4efe9dc


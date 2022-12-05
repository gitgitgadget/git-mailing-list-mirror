Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BD1C4321E
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 13:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiLENfn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 08:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiLENfk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 08:35:40 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB421C925
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 05:35:39 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id w37so10510428pga.5
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 05:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfw6tW2ZzUDdDl5zCS7GEmo4Y00stI9wapi5Hn6LzaI=;
        b=dfKzQF30bNXzzI/M2Cy+W+bM6AtHOzvDeOhEYr9qp84CTXM4ROSUewj7T1hvZq4VHz
         r/J80PlBn632trFXCYb3zIfCvDtpBZnqhbLWX/unj5uNK0zhdgaiPZE7MiHTXcfuBh1g
         KyXKsJfShoao1MXagaJgRM0aJ54qcY/t09n6senU3KNWyO1YmsBx2jbOZ3WfUf+xqPqx
         qroIu/0OHL6/h3WrjpT5uwvB8ZHWEQgBPgXFKqPnde5987dKhQW++hRojM645iOcmLIF
         rq4s+D15HjMj66vDuL55duh0+KfOSgjuHtfH9pbY4e2+Kb9qIu4Ot5H4xDujEJb7QJQR
         vzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfw6tW2ZzUDdDl5zCS7GEmo4Y00stI9wapi5Hn6LzaI=;
        b=UyOcnQekXVxat+C+C68bR0h+KhDhp+DAirOfhnuUWK4J1+xYZOTTWiZgPB0klvjfl+
         VbaIh7nRya08LqpYWfgM7xFpsOPK/CAdQsJ+Z/gLr2W9EJDi9ljl9GGXrR1XJul0Cnc7
         tv5BDKsE9aDq/2GmncKBZYxOhAm0rX2Sq8S/v8IybZ40PMWmIHKuhdgFJd5CWSyO4UVy
         jIweTz9brkrVUnQNRks0Uwf4r0czDqz5PZW0tDE/MGbAaiDag49X4NSdxDQA99LCzvOI
         tgCQ1s9wIC6R/yyOTlqiMYTsVvdxbkrEaEFJtZ+l3/putXRUFIvFgGnDGPmtJdFkmvi/
         tpdg==
X-Gm-Message-State: ANoB5pnnyWAUtHzBUCFRevYAfnRCuoPAVSKnEBzJqUxpXJ/4ne5Qr9Z6
        VOmT2bHHfskSA4hR1cqnWHS/5S40vMIVGA==
X-Google-Smtp-Source: AA0mqf61A7mFo1Eup8xrWLvd4HlsIfF1FU4cXItjzwjjoD9r0sLC3soiPWRCspofWcaszPSHsMn6mw==
X-Received: by 2002:a05:6a00:1647:b0:576:c5e1:9b13 with SMTP id m7-20020a056a00164700b00576c5e19b13mr8327669pfc.67.1670247337952;
        Mon, 05 Dec 2022 05:35:37 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id c15-20020a170903234f00b00186c3afb49esm2386636plh.209.2022.12.05.05.35.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2022 05:35:37 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     --cc=avarab@gmail.com, tenglong.tl@alibaba-inc.com,
        me@ttaylorr.com, Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH 1/1] push: introduce '--heads' option
Date:   Mon,  5 Dec 2022 21:35:25 +0800
Message-Id: <20221205133525.60464-2-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.0.rc1.5.ge01d593fc21.dirty
In-Reply-To: <20221205133525.60464-1-tenglong.tl@alibaba-inc.com>
References: <20221205133525.60464-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

The '--all' option of git-push built-in cmd support to push all branches
(refs under refs/heads) to remote. Under the usage, a user can easlily
work in some scenarios, for example, branches synchronization and batch
upload.

'--all' was introduced for a long time, meanwhile, git supports to
customize the storage location under "refs/". when a new git user see
the usage like, 'git push origin --all', we might feel like we're
pushing _all_ the refs instead of just branches without looking at the
documents until we found the related description of it or '--mirror'.

To ensure compatibility, we cannot rename '--all' to another name
directly, one way is, we can try to add a new option '--heads' which be
identical with the functionality of '--all' to let the user understand
the meaning of representation more clearly. Actually, We've more or less
named options this way already, for example, in 'git-show-ref' and 'git
ls-remote'.

At the same time, we fix a related issue about the wrong help
information of '--all' option in code.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-push.txt |  1 +
 builtin/push.c             | 13 +++++++------
 t/t5523-push-upstream.sh   | 19 ++++++++++++-------
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 5bb1d5aae25..a5d18fb90b6 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -147,6 +147,7 @@ already exists on the remote side.
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
 
 --all::
+--heads::
 	Push all branches (i.e. refs under `refs/heads/`); cannot be
 	used with other <refspec>.
 
diff --git a/builtin/push.c b/builtin/push.c
index 60ac8017e52..970cabaa78b 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -588,11 +588,12 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT__VERBOSITY(&verbosity),
 		OPT_STRING( 0 , "repo", &repo, N_("repository"), N_("repository")),
-		OPT_BIT( 0 , "all", &flags, N_("push all refs"), TRANSPORT_PUSH_ALL),
+		OPT_BIT( 0 , "all", &flags, N_("push all branches"), TRANSPORT_PUSH_ALL),
+		OPT_BIT( 0 , "heads", &flags, N_("push all branches"), TRANSPORT_PUSH_ALL),
 		OPT_BIT( 0 , "mirror", &flags, N_("mirror all refs"),
 			    (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE)),
 		OPT_BOOL('d', "delete", &deleterefs, N_("delete refs")),
-		OPT_BOOL( 0 , "tags", &tags, N_("push tags (can't be used with --all or --mirror)")),
+		OPT_BOOL( 0 , "tags", &tags, N_("push tags (can't be used with --all or --heads or --mirror)")),
 		OPT_BIT('n' , "dry-run", &flags, N_("dry run"), TRANSPORT_PUSH_DRY_RUN),
 		OPT_BIT( 0,  "porcelain", &flags, N_("machine-readable output"), TRANSPORT_PUSH_PORCELAIN),
 		OPT_BIT('f', "force", &flags, N_("force updates"), TRANSPORT_PUSH_FORCE),
@@ -635,7 +636,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	set_push_cert_flags(&flags, push_cert);
 
 	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
-		die(_("options '%s' and '%s' cannot be used together"), "--delete", "--all/--mirror/--tags");
+		die(_("options '%s' and '%s' cannot be used together"), "--delete", "--all/--heads/--mirror/--tags");
 	if (deleterefs && argc < 2)
 		die(_("--delete doesn't make sense without any refs"));
 
@@ -673,9 +674,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 
 	if (flags & TRANSPORT_PUSH_ALL) {
 		if (tags)
-			die(_("options '%s' and '%s' cannot be used together"), "--all", "--tags");
+			die(_("options '%s' and '%s' cannot be used together"), "--all/--heads", "--tags");
 		if (argc >= 2)
-			die(_("--all can't be combined with refspecs"));
+			die(_("--all/--heads can't be combined with refspecs"));
 	}
 	if (flags & TRANSPORT_PUSH_MIRROR) {
 		if (tags)
@@ -684,7 +685,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 			die(_("--mirror can't be combined with refspecs"));
 	}
 	if ((flags & TRANSPORT_PUSH_ALL) && (flags & TRANSPORT_PUSH_MIRROR))
-		die(_("options '%s' and '%s' cannot be used together"), "--all", "--mirror");
+		die(_("options '%s' and '%s' cannot be used together"), "--all/--heads", "--mirror");
 
 	if (!is_empty_cas(&cas) && (flags & TRANSPORT_PUSH_FORCE_IF_INCLUDES))
 		cas.use_force_if_includes = 1;
diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index fdb42920564..29d03b2f58b 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -60,13 +60,18 @@ test_expect_success 'push -u :topic_2' '
 	check_config topic_2 upstream refs/heads/other2
 '
 
-test_expect_success 'push -u --all' '
-	git branch all1 &&
-	git branch all2 &&
-	git push -u --all &&
-	check_config all1 upstream refs/heads/all1 &&
-	check_config all2 upstream refs/heads/all2
-'
+
+for option in 'all' 'heads'
+do
+
+	test_expect_success "push -u --$option" '
+		git branch "$option"1 &&
+		git branch "$option"2 &&
+		git push -u --"$option" &&
+		check_config "$option"1 upstream refs/heads/"$option"1 &&
+		check_config "$option"2 upstream refs/heads/"$option"2
+	'
+done
 
 test_expect_success 'push -u HEAD' '
 	git checkout -b headbranch &&
-- 
2.39.0.rc1.5.ge01d593fc21.dirty


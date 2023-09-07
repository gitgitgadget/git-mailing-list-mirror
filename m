Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D6BEC8743
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 17:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbjIGRNd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 13:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjIGRNc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 13:13:32 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F05110CA
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 10:13:08 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-986d8332f50so155393566b.0
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 10:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694106705; x=1694711505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/YweAa+/Xk3ac1g6f3K8q9nTvgdPe2k2YZfxUWpgTI=;
        b=cnzez44UdscFiNl2hRbF7JSrTU5//eszzSVNVgk24ELR2fsG6KEyl7XMaYctiohXmo
         fMMw2yNjD0R9gNy29lmbga5Dalt88YEoDKoGlQANtRvs8J2RJKtXImGXakBlgy78cqQx
         5ZdgYqWMaeQ4YEmpZMFP2KlDPqMD8IzpOToRY204VzoXPvzZxKsmsSR8+DiVjGXlqgsN
         aT8rFxFxavqS0szu0nIx3Secx4wfScHyZw3pFvV72eGZaNk77h2/bTLVcVNNWjCZJPd+
         VLzquKWjbUMFgW4TSQqRf/8Bopa5DoURTDUN39L3YS3PPZVvtRySVLaenwtFsOuMSlRH
         I4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694106705; x=1694711505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/YweAa+/Xk3ac1g6f3K8q9nTvgdPe2k2YZfxUWpgTI=;
        b=EnIVl8oKjNs+kuNcY90g9WKjoBcfBFAZ5bA5Ng9eV5sCRQ7qNd2D8FtghYM8lh9PlJ
         HEiuuxBL8I5av9nLaHC5T9VYBAH0gCmDJj7+ueb0mlDBbUOYy0ND9qhfGk0Q8jdxwiP8
         C2bE1mh8DQ7R3SOx1D19SZotP22u6gwHQUd43qmxVwqYlNijorueKafJOc/r8pA2rC9r
         TEcuRlPGhlCcBCcpbnBP+RKSabiprKoMPY2oMWcuQZIhlELfdhZUT6g70GaeNph+K4U2
         hFEd2uyKgn3+vX1VL7Pb34v2kesgfg+XGZkcNvnq9+NDl9BVuXdao+t5ANIjyNVss9CW
         ApRA==
X-Gm-Message-State: AOJu0Yy56qe8FD6XNzf4UlNpdeuoqEbmcdnACMSkbfN68gMIUVPfDN8d
        nuU732mZk+T2d386FcYKHBi5Pqd9jY4=
X-Google-Smtp-Source: AGHT+IEwPvHzh/iZMJLFATe2kQxhlPFRdzpf8/wvGO2c2XWNzjbBivnAox3XKiEjH3vAlkBfTw+iYg==
X-Received: by 2002:a7b:c7c7:0:b0:401:b2c7:34aa with SMTP id z7-20020a7bc7c7000000b00401b2c734aamr4138891wmk.33.1694078874481;
        Thu, 07 Sep 2023 02:27:54 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:3385:ce2d:69dd:303e])
        by smtp.gmail.com with ESMTPSA id y8-20020adff148000000b00317c742ca9asm22491522wro.43.2023.09.07.02.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:27:53 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 08/15] replay: remove progress and info output
Date:   Thu,  7 Sep 2023 11:25:14 +0200
Message-ID: <20230907092521.733746-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.126.gcf8c984877
In-Reply-To: <20230907092521.733746-1-christian.couder@gmail.com>
References: <20230602102533.876905-1-christian.couder@gmail.com>
 <20230907092521.733746-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The replay command will be changed in a follow up commit, so that it
will not update refs directly, but instead it will print on stdout a
list of commands that can be consumed by `git update-ref --stdin`.

We don't want this output to be polluted by its current low value
output, so let's just remove the latter.

In the future, when the command gets an option to update refs by
itself, it will make a lot of sense to display a progress meter, but
we are not there yet.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 47d695df93..b5c854c686 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -195,7 +195,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
 	init_merge_options(&merge_opt, the_repository);
 	memset(&result, 0, sizeof(result));
-	merge_opt.show_rename_progress = 1;
+	merge_opt.show_rename_progress = 0;
 	merge_opt.branch1 = "HEAD";
 	head_tree = repo_get_commit_tree(the_repository, onto);
 	result.tree = head_tree;
@@ -203,9 +203,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	while ((commit = get_revision(&revs))) {
 		struct commit *pick;
 
-		fprintf(stderr, "Rebasing %s...\r",
-			oid_to_hex(&commit->object.oid));
-
 		if (!commit->parents)
 			die(_("replaying down to root commit is not supported yet!"));
 		if (commit->parents->next)
@@ -224,7 +221,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		exit(128);
 
 	if (result.clean) {
-		fprintf(stderr, "\nDone.\n");
 		strbuf_addf(&reflog_msg, "finish rebase %s onto %s",
 			    oid_to_hex(&last_picked_commit->object.oid),
 			    oid_to_hex(&last_commit->object.oid));
@@ -238,7 +234,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
 			die(_("unable to update HEAD"));
 	} else {
-		fprintf(stderr, "\nAborting: Hit a conflict.\n");
 		strbuf_addf(&reflog_msg, "rebase progress up to %s",
 			    oid_to_hex(&last_picked_commit->object.oid));
 		if (update_ref(reflog_msg.buf, "HEAD",
-- 
2.42.0.126.gcf8c984877


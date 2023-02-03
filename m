Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AB7C61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 12:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjBCMQj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 07:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjBCMQd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 07:16:33 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99099DCAF
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 04:16:25 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id k4so14858559eje.1
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 04:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOxed2EOTlliBjFIR9X/w2ZZBkPbquWBQ1Fm3+vKPLk=;
        b=fbRpbGd8/7JXbZhUi3ya2hLW/wruuxZ12oVcNzoY+hYX0eOekuLRO51Af0XnZjdINB
         EX6SH7pQWAK3UvhGO0iRy7ZYrBsGy+nwCJxksxX5zgiTeV30vDAr8qV6UrYvhIxxvF4M
         8OeRndgvdOcx4X6t3MdcWTUJ4v1ABhjJ+58nLcBpVCyiiw3vkiU3xvQfTriHQx+7u6MD
         IaeaGIFHXvPf722RX4vmSIFS+kNuZ7LpKgURzxKl++u3RjUkoA++oqUqXQYz2DgBmFWL
         7BmHJvCv5E8BjmSprPPqAwO+6BqGv9D5SoFiQSA6y6XewTJMaNuMJxt9j5xID1AXzmJe
         C1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOxed2EOTlliBjFIR9X/w2ZZBkPbquWBQ1Fm3+vKPLk=;
        b=6igFIAUZI80Pt5fmN3++ha0J/2NFNqj4bZ0+FQJXC9E/eQXBiOj4U5ZFNEmbUrOa/2
         wt01+jQIbZJb2bDvUkLySMcUYx73ZdETXmdmtkTHSJEp4ZykNzuujAdkUS+OKIV40RHc
         pUonPCHmK8jm9q6QvTpNYQDOYCYD82fY6xdvs4tYk6s4a26oZNXfX+CqzJ/2xYevhiKI
         rTluzy7GVcAVzO6GD1hUHbiza7ezsPyZaOSRS2TC+eTOPcDYkTNrFgs6IrxcJcWk3W6k
         Md3OKSsPGJdIP1NmrpBB6unJclO2usTMA3IolJH+DsrpShOLQDBdMLMdIFlO7tE9bymS
         2zaQ==
X-Gm-Message-State: AO0yUKW2dsxysVMq+cgo3DchqdGANszZII38NUn6NYGsP+UwKo8Ieq0u
        3Ld583vpeVxdwN8yZqYVWtWN5lrebqfUuUwK
X-Google-Smtp-Source: AK7set+OKIkgTDpJJKrqZCFYEZqFRow4T6HIvaigOenVlrTh6qZ9Hkf0BK1UyVSQLN+VwGG9oHAXkw==
X-Received: by 2002:a17:907:9916:b0:887:915d:7502 with SMTP id ka22-20020a170907991600b00887915d7502mr11159995ejc.31.1675426583448;
        Fri, 03 Feb 2023 04:16:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m24-20020a170906849800b0088b24b3aff8sm1286313ejx.183.2023.02.03.04.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 04:16:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/5] sequencer: use the new hook API for the simpler "post-rewrite" call
Date:   Fri,  3 Feb 2023 13:15:34 +0100
Message-Id: <patch-v2-4.5-b96522d593f-20230203T104319Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1397.gbe42486b8a4
In-Reply-To: <cover-v2-0.5-00000000000-20230203T104319Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20230203T104319Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Change the invocation of the "post-rewrite" hook added in
795160457db (sequencer (rebase -i): run the post-rewrite hook, if
needed, 2017-01-02) to use the new hook API.

This leaves the more complex "post-rewrite" invocation added in
a87a6f3c98e (commit: move post-rewrite code to libgit, 2017-11-17)
here in sequencer.c unconverted.

Here we can pass in a file's via the "in" file descriptor, in that
case we don't have a file, but will need to write_in_full() to an "in"
provide by the API. Support for that will be added to the hook API in
the future, but we're not there yet.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sequencer.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3e4a1972897..d8d59d05dd4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4834,8 +4834,7 @@ static int pick_commits(struct repository *r,
 		if (!stat(rebase_path_rewritten_list(), &st) &&
 				st.st_size > 0) {
 			struct child_process child = CHILD_PROCESS_INIT;
-			const char *post_rewrite_hook =
-				find_hook("post-rewrite");
+			struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
 
 			child.in = open(rebase_path_rewritten_list(), O_RDONLY);
 			child.git_cmd = 1;
@@ -4845,18 +4844,9 @@ static int pick_commits(struct repository *r,
 			/* we don't care if this copying failed */
 			run_command(&child);
 
-			if (post_rewrite_hook) {
-				struct child_process hook = CHILD_PROCESS_INIT;
-
-				hook.in = open(rebase_path_rewritten_list(),
-					O_RDONLY);
-				hook.stdout_to_stderr = 1;
-				hook.trace2_hook_name = "post-rewrite";
-				strvec_push(&hook.args, post_rewrite_hook);
-				strvec_push(&hook.args, "rebase");
-				/* we don't care if this hook failed */
-				run_command(&hook);
-			}
+			hook_opt.path_to_stdin = rebase_path_rewritten_list();
+			strvec_push(&hook_opt.args, "rebase");
+			run_hooks_opt("post-rewrite", &hook_opt);
 		}
 		apply_autostash(rebase_path_autostash());
 
-- 
2.39.1.1397.g8c8c074958d


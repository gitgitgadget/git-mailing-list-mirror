Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0238DC00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiHUOCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiHUOBy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 10:01:54 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7471E24BC4
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:16 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a4so10316845wrq.1
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=WfEsiCR19Fhzyh3jiY+DPmHZCuRYHilFobJeBq0wZVI=;
        b=bySNkWLuAK+Xcsc5aZVyV1pNwOi1QDSAsW5rdOYxclZtP+Gt+tEiAqmmlUBT1nvNSB
         gwW9xknyxnp+GGGZxFD9kbbrBwAPQZhrItM+ghaxOMouuZqzbtZW+YslZFvN4GzoNYTj
         4PY/C7PbZDmAJgtg7wVoQzChoMRCSQ3rlh+DFmVIuS5nbt3YvW+5nHqORwOFscEHJySx
         myPF7ay7OVU9/MPXZGc+h1axdPpVXs4O1ab0ZQqc10xTeBUSCTRVilfbKP2SSNMgI6xl
         Azl25Vc8VUUDhUxuZxpUuDxYBancVu7lf5nbWvWIqe4c7ZV5C7x/2Y3pMZJCuEZRAeh3
         EE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WfEsiCR19Fhzyh3jiY+DPmHZCuRYHilFobJeBq0wZVI=;
        b=DUD5xYsFDOxw/IVC2m+Tyj4dNmFZor//Ahas3k19/gqZCP3NXO8RxXCkJ4aLWyHsqX
         MZhVXeftNFCbWnJk5ZhamFnaZu7LfKzqnSeWiMjonvOgC3SMbOpi1jZCclHyowLTXa3C
         10aI4yfxbl1XIl53mKfs161Rb0IlUZN0abvfrrDxp4lEZj0trN+V1zuTP8Tm2dNucEgf
         AzPa/xjcWhd6ilQQshuls6AsXYMLu+PJ2Pq8ppAzq3fOWKVLMkbNYVYPNm5TQ1OIaE/U
         1VEYbHd4LkeNogCqHwG8FGhvYxCm3VPTk5eQ2aUZukmWEaM0wtTZKNsmwecEZLPS0yHg
         6w0w==
X-Gm-Message-State: ACgBeo3fE/ATdb2F/t0Xu/NgcawpZPgGhwMyRgPConAE3teEfBGRjdsu
        /5CqC+ScIQiJceGh+Xmo0rjQK5Puow76QmkO
X-Google-Smtp-Source: AA6agR6tTDwelvQDqtxdxBXt3H4oX1MwFuYKwLetbOuIuv5Gz53RSdP42PEstLbHN0IQwnakqQM3Og==
X-Received: by 2002:a05:6000:69e:b0:225:c28:446f with SMTP id bo30-20020a056000069e00b002250c28446fmr8367534wrb.266.1661090475663;
        Sun, 21 Aug 2022 07:01:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q4-20020a1c4304000000b003a5c7a942edsm14449642wma.28.2022.08.21.07.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 07:01:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 12/17] submodule--helper: fix obscure leak in module_add()
Date:   Sun, 21 Aug 2022 15:59:36 +0200
Message-Id: <patch-v6-12.17-50d58bfb19b-20220821T130415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix an obscure leak in module_add(), if the "git add" command we were
piping to failed we'd fail to strbuf_release(&sb). This fixes a leak
introduced in a6226fd772b (submodule--helper: convert the bulk of
cmd_add() to C, 2021-08-10).

In fixing it move to a "goto cleanup" pattern, and since we need to
introduce a "ret" variable to do that let's also get rid of the
intermediate "exit_code" variable. The initialization to "-1" in
a6226fd772b has always been redundant, we'd only use the "exit_code"
value after assigning the return value of pipe_command() to it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d469c571d52..d952b9c8616 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3294,6 +3294,8 @@ static int module_add(int argc, const char **argv, const char *prefix)
 		N_("git submodule add [<options>] [--] <repository> [<path>]"),
 		NULL
 	};
+	struct strbuf sb = STRBUF_INIT;
+	int ret = 1;
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
@@ -3343,21 +3345,17 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	die_on_repo_without_commits(add_data.sm_path);
 
 	if (!force) {
-		int exit_code = -1;
-		struct strbuf sb = STRBUF_INIT;
 		struct child_process cp = CHILD_PROCESS_INIT;
 
 		cp.git_cmd = 1;
 		cp.no_stdout = 1;
 		strvec_pushl(&cp.args, "add", "--dry-run", "--ignore-missing",
 			     "--no-warn-embedded-repo", add_data.sm_path, NULL);
-		if ((exit_code = pipe_command(&cp, NULL, 0, NULL, 0, &sb, 0))) {
+		if ((ret = pipe_command(&cp, NULL, 0, NULL, 0, &sb, 0))) {
 			strbuf_complete_line(&sb);
 			fputs(sb.buf, stderr);
-			free(add_data.sm_path);
-			return exit_code;
+			goto cleanup;
 		}
-		strbuf_release(&sb);
 	}
 
 	if(!add_data.sm_name)
@@ -3372,15 +3370,17 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	add_data.progress = !!progress;
 	add_data.dissociate = !!dissociate;
 
-	if (add_submodule(&add_data)) {
-		free(add_data.sm_path);
-		return 1;
-	}
+	if (add_submodule(&add_data))
+		goto cleanup;
 	configure_added_submodule(&add_data);
+
+	ret = 0;
+cleanup:
 	free(add_data.sm_path);
 	free(to_free);
+	strbuf_release(&sb);
 
-	return 0;
+	return ret;
 }
 
 #define SUPPORT_SUPER_PREFIX (1<<0)
-- 
2.37.2.1279.g64dec4e13cf


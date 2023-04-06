Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478B6C7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 20:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240209AbjDFUiy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 16:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239578AbjDFUi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 16:38:29 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8796EC641
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 13:35:00 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n19-20020a05600c501300b003f064936c3eso3536831wmr.0
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 13:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680813298; x=1683405298;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I10vmwsYaVF22kO0zN74yjhLWonktj8+r8GJM1S6VIg=;
        b=YeSzUB1+hS/t1MUrlWrh+N8EKAuKENz0SEenLI2iqy+hcG80mi6MgayuvKBKesFBK2
         AuleicszlQnHhAvjBWvcDj9LjeiX1eAaYnKeYW8c6DEe7X2Lph7gxaCWekCsr0XveIK2
         EgasuPAsaM6IBvmtcCx69y6Yctn7Qd9HDN8X1QkCRUUcUzSx1A6Vi7f7PClHSBE1nLZX
         vvjyylmHTP6Cy27Pbe6cQFTR38kQ0t17jeb6DrYcMmuKY0BCmCBxmCxVIM0tTPO841aP
         JOTOnImgT/KR0IW2YTPyPSpNBNm/ok/q/2h3QO+M4b10hynUjB+Ov8t50PorjwxxnFnZ
         PJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813298; x=1683405298;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I10vmwsYaVF22kO0zN74yjhLWonktj8+r8GJM1S6VIg=;
        b=YegyZByUGh4wrTVwTMYCt2clfov2wFIavdXZUPFIPWI9SXOKjsWcV7qFRoIe1oIZ9T
         +x0oHkkKYVV738N4fTdEX0GGxicRoOwVRmNh6Bw5The85i1hVQ1k3TyrCtGtHiNcHi4y
         hHpjVzZa1MkS8G1hKzFLaZGy68gOdSNCKc0Ve155gY9AocmO/BEZeuV0v7gGxgZWi35f
         3iTIAwu3Ystbt8zSKeE6fLRKnaRhr94Ht+G/nlk2x10oNN+4rnxR4UVohLcsObrGVhdU
         Q5NeO1qITkceEH5j7EkM5lfAJJK2tPoh2ixId01Sd6pYQHX3POrRFocWAmMwoIwOOKPV
         q8BA==
X-Gm-Message-State: AAQBX9fBzu3hy3jNyGNzItFQW/2AXvQOLUyE+qbNrKRALInpU0zW/E47
        20R3ez83iZUDT/U9lbih3EDSuGqut+M=
X-Google-Smtp-Source: AKy350ZgpG/YRRki3J9sqOhDhNGps/dTNHH6ca4tF5F4TGE9OHbeSji5AshrminWoBI4tWItYBh6ag==
X-Received: by 2002:a05:600c:2b8c:b0:3f0:3a9a:516e with SMTP id j12-20020a05600c2b8c00b003f03a9a516emr8802907wmc.15.1680813298273;
        Thu, 06 Apr 2023 13:34:58 -0700 (PDT)
Received: from [192.168.2.52] (123.red-88-14-42.dynamicip.rima-tde.net. [88.14.42.123])
        by smtp.gmail.com with ESMTPSA id f8-20020adff448000000b002d75ef32032sm2619256wrp.68.2023.04.06.13.34.57
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 13:34:57 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH] coccinelle: add and apply branch_get() rules
Message-ID: <4cb4b69c-bd14-dfbd-6d06-59a7cd7e8c94@gmail.com>
Date:   Thu, 6 Apr 2023 22:34:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are three supported ways to obtain a "struct branch *" for the
currently checked out branch, in the current worktree, using the API
branch_get(): branch_get(NULL), branch_get("") and branch_get("HEAD").

The first one is the recommended [1][2] and optimal usage.  Let's add
two coccinelle rules to convert the latter two into the first one.

  1. f019d08ea6 (API documentation for remote.h, 2008-02-19)

  2. d27eb356bf (remote: move doc to remote.h and refspec.h, 2019-11-17)

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/fetch.c                     |  2 +-
 builtin/pull.c                      |  8 ++++----
 contrib/coccinelle/branch_get.cocci | 10 ++++++++++
 3 files changed, 15 insertions(+), 5 deletions(-)
 create mode 100644 contrib/coccinelle/branch_get.cocci

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7221e57f35..45d81c8e02 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1738,7 +1738,7 @@ static int do_fetch(struct transport *transport,
 	commit_fetch_head(&fetch_head);
 
 	if (set_upstream) {
-		struct branch *branch = branch_get("HEAD");
+		struct branch *branch = branch_get(NULL);
 		struct ref *rm;
 		struct ref *source_ref = NULL;
 
diff --git a/builtin/pull.c b/builtin/pull.c
index 56f679d94a..fbb1cbea0a 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -332,7 +332,7 @@ static const char *config_get_ff(void)
  */
 static enum rebase_type config_get_rebase(int *rebase_unspecified)
 {
-	struct branch *curr_branch = branch_get("HEAD");
+	struct branch *curr_branch = branch_get(NULL);
 	const char *value;
 
 	if (curr_branch) {
@@ -437,7 +437,7 @@ static int get_only_remote(struct remote *remote, void *cb_data)
  */
 static void NORETURN die_no_merge_candidates(const char *repo, const char **refspecs)
 {
-	struct branch *curr_branch = branch_get("HEAD");
+	struct branch *curr_branch = branch_get(NULL);
 	const char *remote = curr_branch ? curr_branch->remote_name : NULL;
 
 	if (*refspecs) {
@@ -710,7 +710,7 @@ static const char *get_upstream_branch(const char *remote)
 	if (!rm)
 		return NULL;
 
-	curr_branch = branch_get("HEAD");
+	curr_branch = branch_get(NULL);
 	if (!curr_branch)
 		return NULL;
 
@@ -774,7 +774,7 @@ static int get_rebase_fork_point(struct object_id *fork_point, const char *repo,
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf sb = STRBUF_INIT;
 
-	curr_branch = branch_get("HEAD");
+	curr_branch = branch_get(NULL);
 	if (!curr_branch)
 		return -1;
 
diff --git a/contrib/coccinelle/branch_get.cocci b/contrib/coccinelle/branch_get.cocci
new file mode 100644
index 0000000000..3ec5b59723
--- /dev/null
+++ b/contrib/coccinelle/branch_get.cocci
@@ -0,0 +1,10 @@
+@@
+@@
+- branch_get("HEAD")
++ branch_get(NULL)
+
+@@
+@@
+- branch_get("")
++ branch_get(NULL)
+
-- 
2.34.1

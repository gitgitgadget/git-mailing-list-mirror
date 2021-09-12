Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD4DC433EF
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2BD0610CE
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhILNZD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 09:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbhILNYy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 09:24:54 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A41FC061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:40 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t18so10317354wrb.0
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S+9e4DSe77dvVgiDAcpgdRbCJzwJrdluslPwAilivOc=;
        b=OP2isgEJ9XIvcPD6sEFvy8pcg2q8bcjOr1B5aRM9PW3K9pH3OYYdgHbs/8VuRJP4t+
         bmp0X3I+Ljct5q/njakoFAAaUf+ojdZGTjlOcs/ROJHynyYcmizvDVJfj0BolHwu9+QS
         UAb9DC3cLxZDAB7viaYWz7kW94MGFTSGOZ5fFf1qbb8SJaXM16e3CjOoaMxMtwhDyYt8
         qLzkPjXo+Lytp64+EVnDQbqC75WtEDC2WUtHnj9g5Q/eOQfQBrX7qJlrM1q+kOFhWaTU
         +jEV2WbX3YnTFZMsJCnd4lZsXDLJX46FqWyLVhnY2ErRuXCjEHLCLUvNC76wacfOjZRW
         Rlxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S+9e4DSe77dvVgiDAcpgdRbCJzwJrdluslPwAilivOc=;
        b=wpBOlZfKprOhdpI6UqIMElpivMgKuDjcedqmp+7rDTdM1HHaxkP7nf3C3Qz+WtxDa2
         TjS9CTkAX3TTvOkKiGhVuQ7YjwhKsBKCxGPkuRg84nD9/ydTiXlIg9EGySeiSmCAElAM
         IB1tBVau1KrI4GhGLp+nIsG7JXVCpIJuoc9N9FRS2ty5Xrf8mEAJae32xnm6U3RGqZE1
         L+XrOF19zWOLyNQ7piJ1V04Rrqpu5BYWAjbCx/Cgh2pNWtjhyXPcrmuIi8Nda4FH1lyL
         zmiJCYUjofruf88mHeBWaMDztcfuImd+Kqb5nwqD6tmldJfhTH3Hj467vz7EpnI7kK68
         5ymg==
X-Gm-Message-State: AOAM53012q2TsIeKKsizECTKN1QL/xGJ62AOthDdkORzuuwA2pszrmbX
        XD0OGrIdJhO/d1qGjMcRPQihAgBH6wo=
X-Google-Smtp-Source: ABdhPJxgmljMw9OflUNuiMtqBsVpGP5vPKIFZD7zoz7wCcrf19wzNZNIaahD3tqWaLISExKgpzoIow==
X-Received: by 2002:a5d:47a4:: with SMTP id 4mr7668311wrb.329.1631453018706;
        Sun, 12 Sep 2021 06:23:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h18sm4603376wrb.33.2021.09.12.06.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 06:23:38 -0700 (PDT)
Message-Id: <fb3f86efa9b2308883bad0b39057ef1e3eefd898.1631453010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
        <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 12 Sep 2021 13:23:27 +0000
Subject: [PATCH v2 11/14] rm: add --sparse option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

As we did previously in 'git add', add a '--sparse' option to 'git rm'
that allows modifying paths outside of the sparse-checkout definition.
The existing checks in 'git rm' are restricted to tracked files that
have the SKIP_WORKTREE bit in the current index. Future changes will
cause 'git rm' to reject removing paths outside of the sparse-checkout
definition, even if they are untracked or do not have the SKIP_WORKTREE
bit.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-rm.txt      |  6 ++++++
 builtin/rm.c                  |  8 ++++++--
 t/t3602-rm-sparse-checkout.sh | 12 ++++++++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 26e9b284704..81bc23f3cdb 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -72,6 +72,12 @@ For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 --ignore-unmatch::
 	Exit with a zero status even if no files matched.
 
+--sparse::
+	Allow updating index entries outside of the sparse-checkout cone.
+	Normally, `git rm` refuses to update index entries whose paths do
+	not fit within the sparse-checkout cone. See
+	linkgit:git-sparse-checkout[1] for more.
+
 -q::
 --quiet::
 	`git rm` normally outputs one line (in the form of an `rm` command)
diff --git a/builtin/rm.c b/builtin/rm.c
index 8a24c715e02..4208f3f9a5f 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -237,6 +237,7 @@ static int check_local_mod(struct object_id *head, int index_only)
 
 static int show_only = 0, force = 0, index_only = 0, recursive = 0, quiet = 0;
 static int ignore_unmatch = 0, pathspec_file_nul;
+static int include_sparse;
 static char *pathspec_from_file;
 
 static struct option builtin_rm_options[] = {
@@ -247,6 +248,7 @@ static struct option builtin_rm_options[] = {
 	OPT_BOOL('r', NULL,             &recursive,  N_("allow recursive removal")),
 	OPT_BOOL( 0 , "ignore-unmatch", &ignore_unmatch,
 				N_("exit with a zero status even if nothing matched")),
+	OPT_BOOL(0, "sparse", &include_sparse, N_("allow updating entries outside of the sparse-checkout cone")),
 	OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
 	OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
 	OPT_END(),
@@ -298,7 +300,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	ensure_full_index(&the_index);
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
-		if (ce_skip_worktree(ce))
+
+		if (!include_sparse && ce_skip_worktree(ce))
 			continue;
 		if (!ce_path_match(&the_index, ce, &pathspec, seen))
 			continue;
@@ -322,7 +325,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 				seen_any = 1;
 			else if (ignore_unmatch)
 				continue;
-			else if (matches_skip_worktree(&pathspec, i, &skip_worktree_seen))
+			else if (!include_sparse &&
+				 matches_skip_worktree(&pathspec, i, &skip_worktree_seen))
 				string_list_append(&only_match_skip_worktree, original);
 			else
 				die(_("pathspec '%s' did not match any files"), original);
diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
index e9e9a15c74c..493c8f636b8 100755
--- a/t/t3602-rm-sparse-checkout.sh
+++ b/t/t3602-rm-sparse-checkout.sh
@@ -43,6 +43,18 @@ test_expect_success 'recursive rm does not remove sparse entries' '
 	test_cmp expected actual
 '
 
+test_expect_success 'recursive rm --sparse removes sparse entries' '
+	git reset --hard &&
+	git sparse-checkout set "sub/dir" &&
+	git rm --sparse -r sub &&
+	git status --porcelain -uno >actual &&
+	cat >expected <<-\EOF &&
+	D  sub/d
+	D  sub/dir/e
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'rm obeys advice.updateSparsePath' '
 	git reset --hard &&
 	git sparse-checkout set a &&
-- 
gitgitgadget


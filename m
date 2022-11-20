Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DCDC4332F
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 19:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKTTUX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 14:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKTTUW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 14:20:22 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FC5248D6
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 11:20:19 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id x17so3509504wrn.6
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 11:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p0wssExpUkCnNGFteFir8gzls/UIHUwIRXW7eB7LqKY=;
        b=piyyLXF7NO0iE/FytSZPt8QFsDGxw9VjLdGzqvjoJNSJKF82Zcb8uuaPYmQG8bmNPp
         W5xyXefFA4e65jjB0314MEObYKqD9QuJ99bGsDNJMcvCP6qE4n1adaJ2UeOUcA8N1unY
         b2JhAcleiajeC1+CM4+G9FXHekwuIzbOOK2d0LfY1SCk/gNxNkcl3RFQ8PDGyEGapOs4
         OlG+3vQZPvlQkstfsxejF4QJCNsSm8Nz89diMHedn7GbnamRDUa9Xsd6w513uTwXhuGn
         utulam6kdohaZ291uhK2X/wAPHRj4YwVMqoZfAb1VyzjiIznS8n+A1rwJ5k4aDd4fSn3
         ARKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0wssExpUkCnNGFteFir8gzls/UIHUwIRXW7eB7LqKY=;
        b=6HO0NGjCjNOvgLCyzmSv/x2n3EqS+TQM7WO0V58JUvSLX/DKgUkieIIDQlm9Maq3xD
         BHG82hxUyn1cyHYinPCo0ZWQYmOjzfq2VN1jOdMlP4vDaq3+tHD+ioCvCohbUyGnTbDX
         nJXHsVwSRt7JEZ0Xo4y54IqS1CCpHDhds30LZ0DFiThhs/iKghVi7L4xB9ZtNCgEkWgj
         qLRvhSVCEawqRtsnLLskYe1+8N/sQ5/UOha6N5yXPBI/iGLCW631QAIMUSzctjmcavHe
         Jpsu+FjIUVeVEhSktz3FSTqSljxBHXLCNI+koqwqE/NZMYlaq7biA6RmsMZiqs8BOsD7
         EnFg==
X-Gm-Message-State: ANoB5pk4lqZw9xqZ7NWl/9KtSpkVTkRMnVcBoPgMSWHWcIIEOXLBLdhE
        pH5B2pey2sehCDmd5AC7Q105qdas0cg=
X-Google-Smtp-Source: AA0mqf7DXPsTDiuWKWe84ReTWXIyy7hDnW7YlbrpQ3Gd8hkjWorsquHG+5HbVx6dn3x72AbFVp9joQ==
X-Received: by 2002:adf:de08:0:b0:236:e271:ead4 with SMTP id b8-20020adfde08000000b00236e271ead4mr882598wrm.426.1668972018136;
        Sun, 20 Nov 2022 11:20:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17-20020adfcd11000000b0022e653f5abbsm9417097wrm.69.2022.11.20.11.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 11:20:17 -0800 (PST)
Message-Id: <pull.1424.git.1668972017089.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Nov 2022 19:20:16 +0000
Subject: [PATCH] var: add GIT_SEQUENCE_EDITOR variable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Allred <allred.sean@gmail.com>

Provides the same benefits to scripts as exposing GIT_EDITOR, but
allows distinguishing the 'sequence' editor from the 'core' editor.

See also 44fcb4977cbae67f4698306ccfe982420ceebcbf.

Signed-off-by: Sean Allred <allred.sean@gmail.com>
---
    var: add GIT_SEQUENCE_EDITOR variable
    
    In my case, I'm overriding the sequence editor in git rebase -i to do
    some pre-processing on the todo file, but I'd still like to open up the
    editor for further manipulation/verification of the todo steps. Just
    using GIT_EDITOR here will clobber folks' expectations that their
    custom-built sequence editor pops up (e.g. VSCode or Git Cola).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1424%2Fvermiculus%2Fsa%2Fgit-var-sequence-editor-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1424/vermiculus/sa/git-var-sequence-editor-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1424

 Documentation/git-var.txt |  7 +++++++
 builtin/var.c             | 11 +++++++++++
 t/t0007-git-var.sh        | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 6aa521fab23..764a94b2a1f 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -49,6 +49,13 @@ ifdef::git-default-editor[]
     The build you are using chose '{git-default-editor}' as the default.
 endif::git-default-editor[]
 
+GIT_SEQUENCE_EDITOR::
+    Text editor for use by Git sequencer commands. Like `GIT_EDITOR`,
+    the value is meant to be interpreted by the shell when it is used.
+    The order of preference is the `$GIT_SEQUENCE_EDITOR` environment
+    variable, then `sequence.editor` configuration, and then the value
+    of `git var GIT_EDITOR`.
+
 GIT_PAGER::
     Text viewer for use by Git commands (e.g., 'less').  The value
     is meant to be interpreted by the shell.  The order of preference
diff --git a/builtin/var.c b/builtin/var.c
index 491db274292..9a2d31dc4aa 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -19,6 +19,16 @@ static const char *editor(int flag)
 	return pgm;
 }
 
+static const char *sequence_editor(int flag)
+{
+	const char *pgm = git_sequence_editor();
+
+	if (!pgm && flag & IDENT_STRICT)
+		die("Terminal is dumb, but EDITOR unset");
+
+	return pgm;
+}
+
 static const char *pager(int flag)
 {
 	const char *pgm = git_pager(1);
@@ -41,6 +51,7 @@ static struct git_var git_vars[] = {
 	{ "GIT_COMMITTER_IDENT", git_committer_info },
 	{ "GIT_AUTHOR_IDENT",   git_author_info },
 	{ "GIT_EDITOR", editor },
+	{ "GIT_SEQUENCE_EDITOR", sequence_editor },
 	{ "GIT_PAGER", pager },
 	{ "GIT_DEFAULT_BRANCH", default_branch },
 	{ "", NULL },
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index e56f4b9ac59..3199285fa7b 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -47,6 +47,44 @@ test_expect_success 'get GIT_DEFAULT_BRANCH with configuration' '
 	)
 '
 
+test_expect_success 'get GIT_SEQUENCE_EDITOR without configuration' '
+	(
+		sane_unset GIT_SEQUENCE_EDITOR &&
+		git var GIT_EDITOR >expect &&
+		git var GIT_SEQUENCE_EDITOR >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'get GIT_SEQUENCE_EDITOR with configuration' '
+	test_config sequence.editor foo &&
+	(
+		sane_unset GIT_SEQUENCE_EDITOR &&
+		echo foo >expect &&
+		git var GIT_SEQUENCE_EDITOR >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'get GIT_SEQUENCE_EDITOR with environment variable' '
+	(
+		sane_unset GIT_SEQUENCE_EDITOR &&
+		echo bar >expect &&
+		GIT_SEQUENCE_EDITOR=bar git var GIT_SEQUENCE_EDITOR >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'get GIT_SEQUENCE_EDITOR with configuration and environment variable' '
+	test_config sequence.editor foo &&
+	(
+		sane_unset GIT_SEQUENCE_EDITOR &&
+		echo bar >expect &&
+		GIT_SEQUENCE_EDITOR=bar git var GIT_SEQUENCE_EDITOR >actual &&
+		test_cmp expect actual
+	)
+'
+
 # For git var -l, we check only a representative variable;
 # testing the whole output would make our test too brittle with
 # respect to unrelated changes in the test suite's environment.

base-commit: a0789512c5a4ae7da935cd2e419f253cb3cb4ce7
-- 
gitgitgadget

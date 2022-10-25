Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC98ECDFA1
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 23:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiJYXBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 19:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiJYXBd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 19:01:33 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B501BDB562
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 16:01:32 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z14so10039921wrn.7
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 16:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryCEKKKpMhielzYNmjw6rIxl4WR0dUUSixrrq9GuTz4=;
        b=KWR7a6ozRPP5daXvrvZ3ztchrfJngmR4khQ7/2uVZCtbpOPSHTUrpwJFzpct15PaOo
         nq8DsUy5bVW4hpF7zBdbVLnUdEIf9T7kHC8oiUreLp72sILJV4Df8+Z4+UbHz80Zw/oV
         Chx0S5nL68GZxL4mEV+eFkNL0uZa59vAvaFcfHFxvjuITBlQnolDyxfYQxtKIr6MkUwT
         AVPjCaHzvRpbi/JVmiMmclTUslEDm5WzsjQcTROuY2OnwfcI2L5C3u7n+NBN9eZtMAoV
         xzotF8KPsmkEQxXeLtu7baW0lizFf9x/jmDf5jR3loHpE7FRr2w5BFcasVqboapZKUZs
         Sy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryCEKKKpMhielzYNmjw6rIxl4WR0dUUSixrrq9GuTz4=;
        b=4Gzj5xV2r/gwxnDFj2B6AkCnv0Uc3K+s4kokPARFg6nOn8E1kdxlMjGIhnI4fu5/ra
         5LyNxog2nyzolFF38/2cNaeaaupS5u+KEaS1khvWi6WwE2l3hWDOL6jhJ5YPpkFjvEMO
         DyNALAFbZ6XmdhnCO+p9Eq7A9wB1nzXw/pRMmcTrQY4vEWCYK3wsnm9u+UTEuA1vtyR5
         Mbtx8LTPsBGK0PvBSaeVPt4S4nhPSixGtA5Dv/G6Y8br/wI7xjBJ3/k7tMTMDBdkie25
         ljnlnrvF+xtSBEfLRE7Fl8IhT6jkzVSCTyEdWaSO4lQmXNVEtBUy/74CrGYSJrPDhvrF
         NyoA==
X-Gm-Message-State: ACrzQf0QwdRBMx8+pr5w94syonULz9btlkV5/MgXDjF7duA1NdGBlBbh
        Vrloqdo+Qszwn52uQkahnSs160hcwa4=
X-Google-Smtp-Source: AMsMyM5gVVrB/rE4RAdFy8ycQpJrufmBrmmpsR2YmmNPe0oO2ez2PZ26duZbE7zT0OAdzgb2cetUZQ==
X-Received: by 2002:a05:6000:1a8b:b0:232:4311:4ff with SMTP id f11-20020a0560001a8b00b00232431104ffmr26205735wry.236.1666738891097;
        Tue, 25 Oct 2022 16:01:31 -0700 (PDT)
Received: from [192.168.2.52] (203.85-84-12.dynamic.clientes.euskaltel.es. [85.84.12.203])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b003c6f27d275dsm225555wmq.33.2022.10.25.16.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 16:01:30 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH] branch: error copying or renaming a detached HEAD
Message-ID: <0ac8cd48-08d7-9bdd-b074-c8d5ded522f6@gmail.com>
Date:   Wed, 26 Oct 2022 01:01:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In c847f53712 (Detached HEAD (experimental), 2007-01-01) an error
condition was introduced in rename_branch() to prevent renaming, later
also copying, a detached HEAD.

The condition used was checking for NULL in oldname, the source branch
to rename/copy.  That condition cannot be satisfied because if no source
branch is specified, HEAD is going to be used in the call.

The error issued instead is:

	fatal: Invalid branch name: 'HEAD'

Let's remove the condition in copy_or_rename_branch() (the current
function name) and check for HEAD before calling it, dying with the
original intended error if we're in a detached HEAD.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c  | 28 ++++++++--------------------
 t/t3200-branch.sh | 11 +++++++++++
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 407517ba68..c964ac7bb4 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -520,13 +520,6 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	const char *interpreted_newname = NULL;
 	int recovery = 0;
 
-	if (!oldname) {
-		if (copy)
-			die(_("cannot copy the current branch while not on any."));
-		else
-			die(_("cannot rename the current branch while not on any."));
-	}
-
 	if (strbuf_check_branch_ref(&oldref, oldname)) {
 		/*
 		 * Bad name --- this could be an attempt to rename a
@@ -827,24 +820,19 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 
 		return ret;
-	} else if (copy) {
-		if (!argc)
-			die(_("branch name required"));
-		else if (argc == 1)
-			copy_or_rename_branch(head, argv[0], 1, copy > 1);
-		else if (argc == 2)
-			copy_or_rename_branch(argv[0], argv[1], 1, copy > 1);
-		else
-			die(_("too many branches for a copy operation"));
-	} else if (rename) {
+	} else if (copy || rename) {
 		if (!argc)
 			die(_("branch name required"));
+		else if ((argc == 1) && filter.detached)
+			die(copy? _("cannot copy the current branch while not on any.")
+				: _("cannot rename the current branch while not on any."));
 		else if (argc == 1)
-			copy_or_rename_branch(head, argv[0], 0, rename > 1);
+			copy_or_rename_branch(head, argv[0], copy, copy + rename > 1);
 		else if (argc == 2)
-			copy_or_rename_branch(argv[0], argv[1], 0, rename > 1);
+			copy_or_rename_branch(argv[0], argv[1], copy, copy + rename > 1);
 		else
-			die(_("too many arguments for a rename operation"));
+			die(copy? _("too many branches for a copy operation")
+				: _("too many arguments for a rename operation"));
 	} else if (new_upstream) {
 		struct branch *branch;
 		struct strbuf buf = STRBUF_INIT;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 7d8edff9c3..38c57de71b 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -268,6 +268,17 @@ test_expect_success 'git branch -M topic topic should work when main is checked
 	git branch -M topic topic
 '
 
+test_expect_success 'git branch -M and -C fail on detached HEAD' '
+	git checkout HEAD^{} &&
+	test_when_finished git checkout - &&
+	echo "fatal: cannot rename the current branch while not on any." >expect &&
+	test_must_fail git branch -M must-fail 2>err &&
+	test_cmp expect err &&
+	echo "fatal: cannot copy the current branch while not on any." >expect &&
+	test_must_fail git branch -C must-fail 2>err &&
+	test_cmp expect err
+'
+
 test_expect_success 'git branch -v -d t should work' '
 	git branch t &&
 	git rev-parse --verify refs/heads/t &&
-- 
2.36.1


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B821AECAAD5
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 04:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIHEyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 00:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIHEx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 00:53:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329DFA5999
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 21:53:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b17so10652230wrq.3
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 21:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject:from:to:cc
         :subject:date;
        bh=q0WUXFkhA8WxqTPtmEGjgEqQwzjVAUphwOAA8ndeQ+o=;
        b=bEpC9oG3LmG90kXLad3Yc27yFAZCzeXh44lC4BoOhxX7zbO732loZY3BV1Y2lGK+Cs
         QilUKcRjJrlS3mJE5GN54krUg098X4CQ0ANxRg4fUwp/eer7ubp5pGaClnKCzuXal9zS
         Z3QOH6W/2grifXDeONVrgNMsUsSZjtfxOz8Hm1wLe7RUBTSQ5hqKE+UOaeU0it0eCcFM
         7ZpG+pJnGzRhKrA7tgqa3lOEUmenjN4Hx7txIY0+qOtS/2BBQ5niPG8i7BwYEkGQfNEH
         EZ93kPedSJ+YHeOnZE1zGym/awkHcYyLXdbE32SnVYa8h24wU5MZxmCz8Caw0ckuoipd
         y9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=q0WUXFkhA8WxqTPtmEGjgEqQwzjVAUphwOAA8ndeQ+o=;
        b=fzuaRwN9ooyZ24Yz3kIbiVXXndGBR/zAXApiKOvuOPBtkW9lHu6jwA3+R/tOqXO7ad
         dK8BZ63ZHdvK28Dw1HqZ5kY4rHABzRzKB91DtMeibc/oBPe+nkPTR7dXvKiddqzEHtq6
         TicIa0eWJ0/fsEhUkzU8xsa3HZtmBg+gT/7zDPwqrm8apJV3rp7xmt32rcZOoGsgNkaB
         vZHdT2OZEI9VQqHlCEB5JznYMdLemxSTT3Oobp/sNeiyMZVcX1uPs2Blj5kBwRhIneKT
         hkzF8wbQKD8z+dQUusXA9fmsmec5A1in2+v0kLcodohkeuzJ5+hDFBdtyaE+AKsTICgr
         pZlA==
X-Gm-Message-State: ACgBeo33A9cQJcJihj5AXATok86mGgYpoukf0YxOoe50P38lGzAnXbAM
        CDREmOdSo54nCNHZDiuJr3GRzNUqSic=
X-Google-Smtp-Source: AA6agR7aWS/93YKA3F8wnOazXVvSTlWGzWX3Pef4Mi3b4Do3pUyY/R79y9WaToSohaQl8UItcs1z3w==
X-Received: by 2002:adf:d1ec:0:b0:228:d9ea:d740 with SMTP id g12-20020adfd1ec000000b00228d9ead740mr3721257wrd.665.1662612835716;
        Wed, 07 Sep 2022 21:53:55 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id a11-20020a056000050b00b002205a5de337sm19894965wrf.102.2022.09.07.21.53.55
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 21:53:55 -0700 (PDT)
Subject: [PATCH v3 2/2] branch: support for shortcuts like @{-1} completed
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     git@vger.kernel.org
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
 <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
 <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
Message-ID: <c38eec87-a88b-761a-c58d-22b0566aa608@gmail.com>
Date:   Thu, 8 Sep 2022 06:53:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

branch command with options "edit-description", "set-upstream-to"
and "unset-upstream" expects a branch name.  Since ae5a6c3684
(checkout: implement "@{-N}" shortcut name for N-th last branch,
2009-01-17) a branch can be specified using shortcuts like @{-1}.
Those shortcuts need to be resolved when considering the
arguments.

Usage examples:

We can modify the description of the previously checked out branch
with:

$ git branch --edit--description @{-1}

We can modify the upstream of the previously checked out branch
with:

$ git branch --set-upstream-to upstream @{-1}
$ git branch --unset-upstream @{-1}

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c                      | 29 +++++++++++++++++++++------
 t/t3204-branch-name-interpretation.sh | 25 +++++++++++++++++++++++
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b1f6519cd9..a4069d27e0 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -791,14 +791,17 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	} else if (edit_description) {
 		const char *branch_name;
 		struct strbuf branch_ref = STRBUF_INIT;
+		struct strbuf buf = STRBUF_INIT;
 		int ret = 0;
 
 		if (!argc) {
 			if (filter.detached)
 				die(_("Cannot give description to detached HEAD"));
 			branch_name = head;
-		} else if (argc == 1)
-			branch_name = argv[0];
+		} else if (argc == 1) {
+			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			branch_name = buf.buf;
+		}
 		else
 			die(_("cannot edit description of more than one branch"));
 
@@ -814,6 +817,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			ret = 1;
 
 		strbuf_release(&branch_ref);
+		strbuf_release(&buf);
 		return ret;
 	} else if (copy) {
 		if (!argc)
@@ -834,9 +838,15 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		else
 			die(_("too many arguments for a rename operation"));
 	} else if (new_upstream) {
-		struct branch *branch = branch_get(argv[0]);
+		struct branch *branch;
+		struct strbuf buf = STRBUF_INIT;
 
-		if (argc > 1)
+		if (!argc)
+			branch = branch_get(NULL);
+		else if (argc == 1) {
+			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			branch = branch_get(buf.buf);
+		} else
 			die(_("too many arguments to set new upstream"));
 
 		if (!branch) {
@@ -853,11 +863,17 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		dwim_and_setup_tracking(the_repository, branch->name,
 					new_upstream, BRANCH_TRACK_OVERRIDE,
 					quiet);
+		strbuf_release(&buf);
 	} else if (unset_upstream) {
-		struct branch *branch = branch_get(argv[0]);
+		struct branch *branch;
 		struct strbuf buf = STRBUF_INIT;
 
-		if (argc > 1)
+		if (!argc)
+			branch = branch_get(NULL);
+		else if (argc == 1) {
+			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			branch = branch_get(buf.buf);
+		} else
 			die(_("too many arguments to unset upstream"));
 
 		if (!branch) {
@@ -870,6 +886,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!branch_has_merge_config(branch))
 			die(_("Branch '%s' has no upstream information"), branch->name);
 
+		strbuf_reset(&buf);
 		strbuf_addf(&buf, "branch.%s.remote", branch->name);
 		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
 		strbuf_reset(&buf);
diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
index 993a6b5eff..0a423298d6 100755
--- a/t/t3204-branch-name-interpretation.sh
+++ b/t/t3204-branch-name-interpretation.sh
@@ -133,4 +133,29 @@ test_expect_success 'checkout does not treat remote @{upstream} as a branch' '
 	expect_branch HEAD one
 '
 
+test_expect_success 'edit-description via @{-1}' '
+	git checkout main &&
+	git checkout - &&
+	write_script editor <<-\EOF &&
+		echo "Branch description" >"$1"
+	EOF
+	EDITOR=./editor git branch --edit-description @{-1} &&
+		write_script editor <<-\EOF &&
+		git stripspace -s <"$1" >"EDITOR_OUTPUT"
+	EOF
+	EDITOR=./editor git branch --edit-description @{-1} &&
+	echo "Branch description" >expect &&
+	test_cmp expect EDITOR_OUTPUT
+'
+
+test_expect_success 'modify branch upstream via "@{-1}" and "@{-1}@{upstream}"' '
+	git branch upstream-branch &&
+	git checkout -b upstream-other -t upstream-branch &&
+	git checkout - &&
+	git branch --set-upstream-to @{-1} @{-1}@{upstream} &&
+	test "$(git config branch.upstream-branch.merge)" = "refs/heads/upstream-other" &&
+	git branch --unset-upstream @{-1} &&
+	test_must_fail git config branch.upstream-other.merge
+'
+
 test_done
-- 
2.36.1

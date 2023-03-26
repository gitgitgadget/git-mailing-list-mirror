Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B640C7619A
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 22:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjCZWd1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Mar 2023 18:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCZWd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 18:33:26 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9089A5FC2
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 15:33:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id s13so4008952wmr.4
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 15:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679870000;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/DkrLXu7pjfDBF3lHvNI6Ice7JfF4XQfo/OLyP8uYI=;
        b=by0SOzqbfW70mUH4EfflnG/zXACv6NP8UidQmbqRLMOSUtRcFk2mplywkNjtLqfkD/
         jL8UeX+Z13OsCcjkahubSp/Nqb1sVUmj6UkFaVREOOmxXmi/dvHdHz3Jo7NnD7EI4Tos
         N3rQus+khy8UOtSoHFdVe6IcFDrydebXrnCJQbnCosQxcEBO32zoykAoe9b3TXqQw/SM
         i1xpIXB3Qjmsp3+gaWouMNEH9V7ODWQR8kJ75B3FeqOHA2Kq7N8IjNIsMkDDnmv/4hkR
         iRKJ0mNdeZFcUHCGQ/DWI0CWZGEyytj7qPss1Pmi7QRXP3g5aEDtF6RVTPNIf2QMPVfV
         YhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679870000;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/DkrLXu7pjfDBF3lHvNI6Ice7JfF4XQfo/OLyP8uYI=;
        b=qUwxqIL9A0/BT2aGNNkrm4ceArFB+IPnxeoCR4csGNGpCtj7rl607fx8CnJ08C4cYJ
         Lfxp8HPio0JztZ0RuGcot4KjaZMWVtztuOX2ciQzS0Qxru9wcRRVjfd0WkylE5fUOWs9
         Ts1WUSrK7xu9oB4aedc27y3tM+6q9rHU3sZmdZMLN3rRxXX4REA6sXrdYmvhGzkoXdkw
         5UiA+qqL5Um44T2xG6KYBFLAs1H5uBLkqaaWtWAW5euhVbVQ7FnK6Y81R6uNR9uqMwhk
         IpgGCmGYvJLDOeSpg5J6xmubhTuc+4/YpxfrjAEr0HRgozXW9M0G0QXuGjZG65PqRZ+5
         7pnw==
X-Gm-Message-State: AO0yUKUlT1NATTkOm22jDFlhst8hGvCjcQ9d9ITWW01KcF1SwM7faFJe
        08+tldg5NWT7cdZdrY9rQZjQEQ9tk+Y=
X-Google-Smtp-Source: AK7set+1PTTo5t5ii85A/K6tG6lz8nNoEBFMDJVsb8IBgKVLtZODf3IFnD6IoFv1aXKvGtc2Vfn5Og==
X-Received: by 2002:a7b:ce16:0:b0:3ed:9b20:c7c1 with SMTP id m22-20020a7bce16000000b003ed9b20c7c1mr7074620wmc.20.1679869999862;
        Sun, 26 Mar 2023 15:33:19 -0700 (PDT)
Received: from [192.168.2.52] (96.red-88-14-208.dynamicip.rima-tde.net. [88.14.208.96])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c4f1200b003ef67848a21sm4833596wmq.13.2023.03.26.15.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 15:33:19 -0700 (PDT)
Subject: [PATCH v5 3/5] branch: description for orphan branch errors
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
 <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
 <139555f1-21ab-d987-a58e-c7f04ce222d3@gmail.com>
 <f8e6447e-5cd3-98fa-f567-39e1c60dacb0@gmail.com>
Message-ID: <e22b661c-6f79-a980-23c6-4fe0200ead4d@gmail.com>
Date:   Mon, 27 Mar 2023 00:33:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f8e6447e-5cd3-98fa-f567-39e1c60dacb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In bcfc82bd48 (branch: description for non-existent branch errors,
2022-10-08) we checked the HEAD in the current worktree to detect if the
branch to operate with is an orphan branch, so as to avoid the confusing
error: "No branch named...".

If we are asked to operate with an orphan branch in a different working
tree than the current one, we need to check the HEAD in that different
working tree.

Let's extend the check we did in bcfc82bd48, to check the HEADs in all
worktrees linked to the current repository, using the helper introduced
in 31ad6b61bd (branch: add branch_checked_out() helper, 2022-06-15).

The helper, branch_checked_out(), does its work obtaining internally a
list of worktrees linked to the current repository.  Obtaining that list
is not a lightweight work because it implies disk access.

In copy_or_rename_branch() we already have a list of worktrees.  Let's
use that already obtained list, and avoid using here the helper.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c       | 21 ++++++++++++++++-----
 t/t3202-show-branch.sh | 18 ++++++++++++++++++
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index bac67c27d5..90dcbb0c6e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -538,13 +538,15 @@ static int replace_each_worktree_head_symref(struct worktree **worktrees,
 	return ret;
 }
 
+#define IS_HEAD 1
+
 static void copy_or_rename_branch(const char *oldname, const char *newname, int copy, int force)
 {
 	struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
 	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
 	const char *interpreted_oldname = NULL;
 	const char *interpreted_newname = NULL;
-	int recovery = 0;
+	int recovery = 0, oldref_usage = 0;
 	struct worktree **worktrees = get_worktrees();
 
 	if (strbuf_check_branch_ref(&oldref, oldname)) {
@@ -558,8 +560,17 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 			die(_("Invalid branch name: '%s'"), oldname);
 	}
 
-	if ((copy || strcmp(head, oldname)) && !ref_exists(oldref.buf)) {
-		if (copy && !strcmp(head, oldname))
+	for (int i = 0; worktrees[i]; i++) {
+		struct worktree *wt = worktrees[i];
+
+		if (wt->head_ref && !strcmp(oldref.buf, wt->head_ref)) {
+			oldref_usage |= IS_HEAD;
+			break;
+		}
+	}
+
+	if ((copy || !(oldref_usage & IS_HEAD)) && !ref_exists(oldref.buf)) {
+		if (oldref_usage & IS_HEAD)
 			die(_("No commit on branch '%s' yet."), oldname);
 		else
 			die(_("No branch named '%s'."), oldname);
@@ -838,7 +849,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
 		if (!ref_exists(branch_ref.buf))
-			error((!argc || !strcmp(head, branch_name))
+			error((!argc || branch_checked_out(branch_ref.buf))
 			      ? _("No commit on branch '%s' yet.")
 			      : _("No branch named '%s'."),
 			      branch_name);
@@ -883,7 +894,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		}
 
 		if (!ref_exists(branch->refname)) {
-			if (!argc || !strcmp(head, branch->name))
+			if (!argc || branch_checked_out(branch->refname))
 				die(_("No commit on branch '%s' yet."), branch->name);
 			die(_("branch '%s' does not exist"), branch->name);
 		}
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index ea7cfd1951..be20ebe1d5 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -221,4 +221,22 @@ test_expect_success 'fatal descriptions on non-existent branch' '
 	test_cmp expect actual
 '
 
+test_expect_success 'error descriptions on orphan branch' '
+	test_when_finished git worktree remove -f wt &&
+	git worktree add wt --detach &&
+	git -C wt checkout --orphan orphan-branch &&
+	test_branch_op_in_wt() {
+		test_orphan_error() {
+			test_must_fail git $* 2>actual &&
+			test_i18ngrep "No commit on branch .orphan-branch. yet.$" actual
+		} &&
+		test_orphan_error -C wt branch $1 $2 &&                # implicit branch
+		test_orphan_error -C wt branch $1 orphan-branch $2 &&  # explicit branch
+		test_orphan_error branch $1 orphan-branch $2           # different worktree
+	} &&
+	test_branch_op_in_wt --edit-description &&
+	test_branch_op_in_wt --set-upstream-to=ne &&
+	test_branch_op_in_wt -c new-branch
+'
+
 test_done
-- 
2.39.2

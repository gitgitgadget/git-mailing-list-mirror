Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD29C61DA4
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 22:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjBVWzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 17:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjBVWzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 17:55:09 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD41837F0C
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 14:55:05 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j2so9114064wrh.9
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 14:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZfD72psNc7r/O2lYEdvk62TmCEzOtjgiek7bbfbN6s=;
        b=LFvkHvIKP+Q/hvLqW+X1U9Psznzi3HSDwoQwP7cm6McIn5/CTRIIz/WoPkXvJoapW7
         NXKPbFJJeioLwpTOkndvt5qBS5hEcXviz8U4fSOgcCj6tQqo36yC52w04w57jHt1Q/+b
         QHLHT8kOFZLMBaQvjIFtVpAMULEPQQrfbj9GZlhBAkwQ8z+5hCBQXT7PFYqRLi86XWfm
         JbzQNHIYBgwbvb+p9VC9HqTHJ+QAcrytV2BJ0O8lc+EPcSFMqfY159A7MV1iz2lrD35F
         EUwbSb93v9rmYXejKbG9bgCUpysHMtvxDBemEsjrdRY/w70wJRj1wuQTGnYo0w2T61cw
         mi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZfD72psNc7r/O2lYEdvk62TmCEzOtjgiek7bbfbN6s=;
        b=4bJUy4qJ2n2VBstw6znQTTzB3YQcCQ4COeW+2igZQ/pcoo0IARonzwFHBCQkg0GG41
         Qv1jgwYnuxVbWIqvIRHk73HIhN6CyR9SWfxCeSkjKoyLc+ut3IpkHqb19rBllUIoZG7R
         leNhoXUztTGC1awZqG1+8f4FuFnQRI0p/XYgHlmNuLOlrsjQ0gVViFfDAq9BBCMKqaI0
         wzYp12bpkHyq53DyzQTtchiZhVbbgyqno7C2m3T+Hw7P4XdQpL4zPjN6fjv96HOottH5
         mnmPYmBtU7iN66QxHDbRO6S1av07gUY7o5st65w+jBjjKs6PSab9DZ1/cMLct/qUjupn
         1VuQ==
X-Gm-Message-State: AO0yUKXHtTTwcgFwZDSiL/o308d6zSVoI1C/dRT0NPwkaC8oTFuKzAbu
        7q+CWSudO2yY92N3KBuoxuQ=
X-Google-Smtp-Source: AK7set/8u8UX47JMqbK5XkhyXsp6AqoYBUWOmHp3NaDiZ74gymB44ceGrfRGUTpcnuQ/EUCzu0pSbw==
X-Received: by 2002:a05:6000:79a:b0:2bf:dcbc:c442 with SMTP id bu26-20020a056000079a00b002bfdcbcc442mr8287872wrb.24.1677106504316;
        Wed, 22 Feb 2023 14:55:04 -0800 (PST)
Received: from [192.168.2.52] (59.red-88-14-203.dynamicip.rima-tde.net. [88.14.203.59])
        by smtp.gmail.com with ESMTPSA id e7-20020adffc47000000b002c70f5627d5sm624961wrs.63.2023.02.22.14.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 14:55:03 -0800 (PST)
Subject: [PATCH v4 2/3] branch: description for orphan branch errors
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
 <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
 <139555f1-21ab-d987-a58e-c7f04ce222d3@gmail.com>
Message-ID: <76bac570-147e-7c74-c18c-1da88bc3d342@gmail.com>
Date:   Wed, 22 Feb 2023 23:55:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <139555f1-21ab-d987-a58e-c7f04ce222d3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In bcfc82bd48 (branch: description for non-existent branch errors,
2022-10-08) we checked the current HEAD to detect if the branch to
operate with is an orphan branch, so as to avoid the confusing error:
"No branch named...".

If we are asked to operate with an orphan branch in a different working
tree than the current one, we need to check the HEAD in that different
working tree.

Let's extend the check we did in bcfc82bd48, to all HEADs in the
repository, using the helper introduced in 31ad6b61bd (branch: add
branch_checked_out() helper, 2022-06-15)

We are already traversing all worktrees in "copy_or_rename_branch()"
checking if the branch to be copied or renamed is being bisected or
rebased.  Let's include also a check for being HEAD, and use this
information within the function rather than the helper.  This implies
doing the worktrees iteration earlier in the function; to keep the
user-visible behavior unchanged lets maintain the die("Branch foo is
being rebased/bisected...") in the same position within the function. 

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c       | 53 ++++++++++++++++++++++++++++--------------
 t/t3202-show-branch.sh | 18 ++++++++++++++
 2 files changed, 53 insertions(+), 18 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a32ae64006..aecf009993 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -486,6 +486,9 @@ static void print_current_branch_name(void)
 		die(_("HEAD (%s) points outside of refs/heads/"), refname);
 }
 
+#define IS_BISECTED 1
+#define IS_REBASED 2
+#define IS_HEAD 4
 
 static void copy_or_rename_branch(const char *oldname, const char *newname, int copy, int force)
 {
@@ -493,8 +496,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
 	const char *interpreted_oldname = NULL;
 	const char *interpreted_newname = NULL;
-	int recovery = 0;
+	int recovery = 0, oldref_usage = 0;
 	struct worktree **worktrees = get_worktrees();
+	struct worktree *oldref_wt = NULL;
 
 	if (strbuf_check_branch_ref(&oldref, oldname)) {
 		/*
@@ -507,8 +511,28 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 			die(_("Invalid branch name: '%s'"), oldname);
 	}
 
-	if ((copy || strcmp(head, oldname)) && !ref_exists(oldref.buf)) {
-		if (copy && !strcmp(head, oldname))
+	for (int i = 0; worktrees[i]; i++) {
+		struct worktree *wt = worktrees[i];
+
+		if (wt->head_ref && !strcmp(oldref.buf, wt->head_ref))
+			oldref_usage |= IS_HEAD;
+
+		if (!wt->is_detached)
+			continue;
+
+		if (is_worktree_being_rebased(wt, oldref.buf)) {
+			oldref_usage |= IS_REBASED;
+			oldref_wt = wt;
+		}
+
+		if (is_worktree_being_bisected(wt, oldref.buf)) {
+			oldref_usage |= IS_BISECTED;
+			oldref_wt = wt;
+		}
+	}
+
+	if ((copy || !(oldref_usage & IS_HEAD)) && !ref_exists(oldref.buf)) {
+		if (oldref_usage & IS_HEAD)
 			die(_("No commit on branch '%s' yet."), oldname);
 		else
 			die(_("No branch named '%s'."), oldname);
@@ -523,20 +547,13 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	else
 		validate_new_branchname(newname, &newref, force);
 
-	for (int i = 0; worktrees[i]; i++) {
-		struct worktree *wt = worktrees[i];
+	if (oldref_usage & IS_BISECTED)
+		die(_("Branch %s is being rebased at %s"),
+		    oldref.buf, oldref_wt->path);
 
-		if (!wt->is_detached)
-			continue;
-
-		if (is_worktree_being_rebased(wt, oldref.buf))
-			die(_("Branch %s is being rebased at %s"),
-			    oldref.buf, wt->path);
-
-		if (is_worktree_being_bisected(wt, oldref.buf))
-			die(_("Branch %s is being bisected at %s"),
-			    oldref.buf, wt->path);
-	}
+	if (oldref_usage & IS_REBASED)
+		die(_("Branch %s is being bisected at %s"),
+		    oldref.buf, oldref_wt->path);
 
 	if (!skip_prefix(oldref.buf, "refs/heads/", &interpreted_oldname) ||
 	    !skip_prefix(newref.buf, "refs/heads/", &interpreted_newname)) {
@@ -818,7 +835,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
 		if (!ref_exists(branch_ref.buf))
-			error((!argc || !strcmp(head, branch_name))
+			error((!argc || branch_checked_out(branch_ref.buf))
 			      ? _("No commit on branch '%s' yet.")
 			      : _("No branch named '%s'."),
 			      branch_name);
@@ -863,7 +880,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
2.34.1

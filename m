Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E58C3DA78
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 00:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjAPACv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 19:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjAPACt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 19:02:49 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132453C04
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 16:02:48 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h16so25956673wrz.12
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 16:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QeWmDjGbA9//gmhZhBC1lEEcZtNuQUCVJnU8ORPTPA=;
        b=AbZI1EjBkBFat+1jWLjwFBCeZ2fxwaEM1oXUh+yVTgETAdut0hI/9Z5bzK9qg7aCCD
         aE+MIA96bOuXdKOwBaOch0HwWiHJKGgL3ecq5WwZj+OK4rvB6oxt1O/66K7Bxb52e9jZ
         sDRt1jVTe8X3ykf7zlBKybPZqkURj/Go6sYbGdwMFXcVM0WzrzV0HMlPto6nhdH2JBzz
         q+GLOcpsxcGQxZHNETDYNhK9dYcF6tUv65i2OuzIEKenap7V0EcFQnxy/c9W189HmCi+
         U1rzCAQTAKOXXvUCCgE1UNu1dRJAogn6qGLTt+El37DluHYxmIBj3HUqTeppaPkm9NPx
         jWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7QeWmDjGbA9//gmhZhBC1lEEcZtNuQUCVJnU8ORPTPA=;
        b=43C4ksLrkgghLTdQspGx+l/tZ6sENba2EUPeD6kJUD6OkZRitZGht3VPjc6Rhw1XNT
         1oiVUs/p6G/CSMb4AD/BfFCO9pCk+4v0P9obknhkIq7VerHlbtTBLkuuSDijBheZn5g/
         hTpROLPYRdDs6Xcgj6uoyApUX5angsVWarXxobH7fxiZQWSmKzWnVczSOAKomMEEJT+7
         Lsr4eMzfofKH6bwyh1awr/2BLWgEoRKicndlXVd/ACW/fDXMqrM61B/6WYmjMkq6pESR
         R4thgELziKxxN2CW2IZRzsYDdwhScT6dYjRISFMNbzAYeevt2Fh7cjZYWgyJc+E/Ejnr
         8pTQ==
X-Gm-Message-State: AFqh2kpE38g6BocUmFIHyhyIuIFn9zxdnxZmgfTNDtpNsmO+59BYYq9+
        QuuxdPzoF1JCQvDNE+KsRG+cZL1GcF4=
X-Google-Smtp-Source: AMrXdXt2l3c2MhRaV5GQg5FepYYhJ7aBBPbwBpPWahoooYtndfvyJFOaSoqMiZwco1BRaDcBa4IXwA==
X-Received: by 2002:adf:fbc7:0:b0:2bd:befd:2061 with SMTP id d7-20020adffbc7000000b002bdbefd2061mr9920397wrs.21.1673827366388;
        Sun, 15 Jan 2023 16:02:46 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id s1-20020a5d4ec1000000b002882600e8a0sm24909012wrv.12.2023.01.15.16.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 16:02:46 -0800 (PST)
Subject: [PATCH v2 2/3] branch: description for orphan branch errors
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
Message-ID: <1d866847-7535-8905-a8ad-a1feb158fa36@gmail.com>
Date:   Mon, 16 Jan 2023 01:02:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In bcfc82bd48 (branch: description for non-existent branch errors,
2022-10-08) we check the current HEAD to detect if the branch to operate
with is an orphan branch, to avoid the confusing error: "No branch
named...".

If we are asked to operate with an orphan branch in a different working
tree than the current one, we need to check the HEAD in that different
working tree.

Let's extend the check we did in bcfc82db48, to all HEADs in the
repository, using the helper introduced in 31ad6b61bd (branch: add
branch_checked_out() helper, 2022-06-15)

"ishead_reject_rebase_or_bised_branch()" already returns whether the
branch to operate with is HEAD in any working tree in the repository.
Let's use this information in "copy_or_rename_branch()", instead of the
helper.

Note that we now call reject_rebase_or_bisect_branch() earlier, which
introduces a change in the error displayed when a combination of
unsupported conditions occur simultaneously: the desired destination
name is invalid, and the branch to operate on is being overrun or
bisected.  With "foo" being rebased or bisected, this:

	$ git branch -m foo HEAD
	fatal: 'HEAD' is not a valid branch name.

... becomes:

	$ git branch -m foo HEAD
	fatal: Branch refs/heads/foo is being ...

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c       | 25 +++++++++++--------------
 t/t3202-show-branch.sh | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a1ee728ca3..6bb5f50950 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -532,12 +532,12 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 			die(_("Invalid branch name: '%s'"), oldname);
 	}
 
-	if ((copy || strcmp(head, oldname)) && !ref_exists(oldref.buf)) {
-		if (copy && !strcmp(head, oldname))
-			die(_("No commit on branch '%s' yet."), oldname);
-		else
-			die(_("No branch named '%s'."), oldname);
-	}
+	ishead = ishead_and_reject_rebase_or_bisect_branch(oldref.buf);
+
+	if ((copy || !ishead) && !ref_exists(oldref.buf))
+		die(ishead
+		    ? _("No commit on branch '%s' yet.")
+		    : _("No branch named '%s'."), oldname);
 
 	/*
 	 * A command like "git branch -M currentbranch currentbranch" cannot
@@ -548,8 +548,6 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	else
 		validate_new_branchname(newname, &newref, force);
 
-	ishead = ishead_and_reject_rebase_or_bisect_branch(oldref.buf);
-
 	if (!skip_prefix(oldref.buf, "refs/heads/", &interpreted_oldname) ||
 	    !skip_prefix(newref.buf, "refs/heads/", &interpreted_newname)) {
 		BUG("expected prefix missing for refs");
@@ -810,7 +808,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
 		if (!ref_exists(branch_ref.buf))
-			error((!argc || !strcmp(head, branch_name))
+			error((!argc || branch_checked_out(branch_ref.buf))
 			      ? _("No commit on branch '%s' yet.")
 			      : _("No branch named '%s'."),
 			      branch_name);
@@ -854,11 +852,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die(_("no such branch '%s'"), argv[0]);
 		}
 
-		if (!ref_exists(branch->refname)) {
-			if (!argc || !strcmp(head, branch->name))
-				die(_("No commit on branch '%s' yet."), branch->name);
-			die(_("branch '%s' does not exist"), branch->name);
-		}
+		if (!ref_exists(branch->refname))
+			die((!argc || branch_checked_out(branch->refname))
+			    ? _("No commit on branch '%s' yet.")
+			    : _("branch '%s' does not exist"), branch->name);
 
 		dwim_and_setup_tracking(the_repository, branch->name,
 					new_upstream, BRANCH_TRACK_OVERRIDE,
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
2.39.0


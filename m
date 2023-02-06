Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208F9C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjBFXGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBFXGa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:06:30 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DF11CF68
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:06:28 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d14so11926956wrr.9
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJCf1xutCeCo8ubwaD3oEtA9eckTMa3e6O8UcGv8vOU=;
        b=h+DSeOruxHtpO7RKipwYeiEJQ0tCKCf0MUSoGlPaA2vifXzrxK/fecmq5qb+s85kJ4
         yyLSHW4MCs7l30q+KJv7JakRVjps0JhW4cWf18D0O+KIKMkAXTOp/7JHyFomZKIhaDjZ
         H/hM4RtJZ5GMeq5zqzie8pzeVZunIDD1XgwP0GtFQLoZ67J6SACrVjEeN2YYUbrzR7zP
         D8/qf4nJmnczhaSEnagZbPtPU/qSdc+PooLCc+y2/WFVRttxicgoirl3DWA1VivgJ/l4
         ogMb3yiN9cxp1/nee79xiNiWUU3UPA64OIa1TOu3tLifcf8d27emDNYFr82f0ONPwkIM
         E1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJCf1xutCeCo8ubwaD3oEtA9eckTMa3e6O8UcGv8vOU=;
        b=h59I94cAROADLBGV/+WKPzNxU2j05WUUZN6eSUmpOQbt9QkDeE2XrSzZdI/V6/eZaI
         Rdr/G5LSlQnROUaQc5c+QFjmnifebonKfN3a5FeG1zzM5uep622FKkQmIWqjGFszE1U8
         6ec/pNQ4Cw3wDrazLh+kmVSpF6y/h1NRXmoLa2AWQEfkbFTYXoQXHREP8Tt2h5idPDSr
         935rJZwvsS/5yPzsF4n24pNVAlf2ZqLsqsx+IDLvB81ZKB24SkIuYdFo4NieCZCFWOsp
         +DU/VqFe0G0rua+I4f0OfrUw8cA3Njc7m+H3fVmKA1fi+OvnmaetRd8x4aAckwM1BjtS
         VMSQ==
X-Gm-Message-State: AO0yUKXOVLdjLaXewnlMP+jXSKYG7I4vootNZKa6iAh8PSzTnlr4JiPo
        CXVZap/NNxxdhTHp7jqPNCjSeHMgEZ0=
X-Google-Smtp-Source: AK7set/8dTzhNJSMTsluo/b6KwHfn1Ff0NH200YsrNcZgRxEm8kb1+PN87x287bJFNpWFgbTyJm5dA==
X-Received: by 2002:adf:cd10:0:b0:2bf:baf3:b5c with SMTP id w16-20020adfcd10000000b002bfbaf30b5cmr490329wrm.48.1675724787316;
        Mon, 06 Feb 2023 15:06:27 -0800 (PST)
Received: from [192.168.2.52] (85.red-88-14-56.dynamicip.rima-tde.net. [88.14.56.85])
        by smtp.gmail.com with ESMTPSA id hg15-20020a05600c538f00b003df7b40f99fsm15020090wmb.11.2023.02.06.15.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 15:06:26 -0800 (PST)
Subject: [PATCH v3 2/3] branch: description for orphan branch errors
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
 <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
Message-ID: <6ba2caa4-1584-ac7f-c547-d7787be2930d@gmail.com>
Date:   Tue, 7 Feb 2023 00:06:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
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

Let's extend the check we did in bcfc82db48, to all HEADs in the
repository, using the helper introduced in 31ad6b61bd (branch: add
branch_checked_out() helper, 2022-06-15)

"die_if_branch_is_being_rebased_or_bisected()" already returns whether
the branch to operate with is HEAD in any worktree in the repository.
Let's use this information in "copy_or_rename_branch()", instead of the
helper.

Note that we now call "die_if_branch_is_being_rebased_or_bisected()"
earlier, which introduces a change in the error displayed when a
combination of unsupported conditions occur simultaneously: the desired
destination name is invalid, and the branch to operate with is being
rebased or bisected.  i.e. with "foo" being rebased or bisected, this:

	$ git branch -m foo /
	fatal: '/' is not a valid branch name.

... becomes:

	$ git branch -m foo /
	fatal: Branch refs/heads/foo is being ...

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c       | 25 +++++++++++--------------
 t/t3202-show-branch.sh | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 89198fa5bf..28cec344ad 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -536,12 +536,12 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 			die(_("Invalid branch name: '%s'"), oldname);
 	}
 
-	if ((copy || strcmp(head, oldname)) && !ref_exists(oldref.buf)) {
-		if (copy && !strcmp(head, oldname))
-			die(_("No commit on branch '%s' yet."), oldname);
-		else
-			die(_("No branch named '%s'."), oldname);
-	}
+	oldref_is_head = die_if_branch_is_being_rebased_or_bisected(oldref.buf);
+
+	if ((copy || !oldref_is_head) && !ref_exists(oldref.buf))
+		die(oldref_is_head
+		    ? _("No commit on branch '%s' yet.")
+		    : _("No branch named '%s'."), oldname);
 
 	/*
 	 * A command like "git branch -M currentbranch currentbranch" cannot
@@ -552,8 +552,6 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	else
 		validate_new_branchname(newname, &newref, force);
 
-	oldref_is_head = die_if_branch_is_being_rebased_or_bisected(oldref.buf);
-
 	if (!skip_prefix(oldref.buf, "refs/heads/", &interpreted_oldname) ||
 	    !skip_prefix(newref.buf, "refs/heads/", &interpreted_newname)) {
 		BUG("expected prefix missing for refs");
@@ -814,7 +812,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
 		if (!ref_exists(branch_ref.buf))
-			error((!argc || !strcmp(head, branch_name))
+			error((!argc || branch_checked_out(branch_ref.buf))
 			      ? _("No commit on branch '%s' yet.")
 			      : _("No branch named '%s'."),
 			      branch_name);
@@ -858,11 +856,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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

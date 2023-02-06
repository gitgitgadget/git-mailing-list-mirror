Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C15C05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBFXCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjBFXB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:01:59 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78C23250E
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:01:34 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j25so8398206wrc.4
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SocM0RmFScZiOzin6xmmwelzEVXD2rLQR5svNWGl+bA=;
        b=SwGjZEmtGNL36SLq+cIRlOH6Iss3J3Wddm1dgg1uietxLxO8tFSFcQYkpIL47F+3/V
         UzfpDH1wyMBzjYCnrPO08EUkiCPa6WHsU7dcJot/ZXAOKI7g3b7xcFCpWT1wU1yLnx0R
         xblO1WUgEgwbVKkMN/UjWR8LTTK9B/B3eSTls7zMggvrABmOrmzs5HiubyLaaQW5lKg+
         IZh7mSQIiUaxDuRzfrrBh+RYwzYhNaDOVPmhhSMhqD0ZFGzUw1ySAKy4cSV46Y5Jonfw
         vNx9wXAYxIYutwGfVbn1N+n0aj6y3ngGyjXb2zGotnPwZQfBJWc5L1ISscylRHyYWkva
         yhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SocM0RmFScZiOzin6xmmwelzEVXD2rLQR5svNWGl+bA=;
        b=YISZ3xvK+4WoYEatxQFOY/WODuRLbxrDoUO4uhqn6C5vMbwgSc5RzOl2DZv0thd/37
         P69Hc8oWoHSkYNjmRwrYCAROEVIP43ZiyVmezLtVNDOZOBFZsDsmEq9iiEwrO3CzEJKL
         XvZZTTRX45Zf2QuUNRLtZZDVLHmoEz+E7wr0zygGU1aXjPwn+UaF59iR0vPLUSc8fYNV
         /1WWJi0I/XYI++6vhrd6PJAFCR+DpWOSLsf5hNiJn3jOqXngGNL+ijjKvQqExHFjtR94
         yS+BIY6Ho28tprqI20z9MFoNgaQSr8NjWNK3HnSYnfqytkrOir4hpXgY4G3wQlAeuehb
         38zA==
X-Gm-Message-State: AO0yUKVpqsXC0DdB4snggFAI1+BIGI258P3cNDlLGY1/YzeCxh8r/1hD
        XFY0R0LC6WPnaUct3zmjSaEZqC+3zyE=
X-Google-Smtp-Source: AK7set8QIbHLd4ECZhsoxE8Ul7HuFkkl1XQFIhlThtUHgNFdd125zoB2073YRk0EQ6qNdH8Q6ST49A==
X-Received: by 2002:a5d:6147:0:b0:2c3:bc42:3008 with SMTP id y7-20020a5d6147000000b002c3bc423008mr780441wrt.42.1675724492379;
        Mon, 06 Feb 2023 15:01:32 -0800 (PST)
Received: from [192.168.2.52] (85.red-88-14-56.dynamicip.rima-tde.net. [88.14.56.85])
        by smtp.gmail.com with ESMTPSA id h4-20020a5d5044000000b002bdf3809f59sm9780774wrt.38.2023.02.06.15.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 15:01:30 -0800 (PST)
Subject: [PATCH v3 0/3] branch: operations on orphan branches
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
Message-ID: <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
Date:   Tue, 7 Feb 2023 00:01:27 +0100
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

Avoid some confusing errors operating with orphan branches when
working with worktrees.

Changes from v2:

 - Renamed "ishead_and_reject_rebase_or_bisect_branch()" to
   "die_if_branch_is_being_rebased_or_bisected()"

   A proposed name "die_if_branch_is_is_use()" has not been used because
   it could lead to confusion.  We don't yet support copying or renaming
   a branch being rebased or bisected, but we do under other uses.

 - Comments added and variables renamed to make more clear the intention and
   the functioning.


Rubén Justo (3):
  branch: avoid unnecessary worktrees traversals
  branch: description for orphan branch errors
  branch: rename orphan branches in any worktree

 builtin/branch.c       | 47 ++++++++++++++++++++++++------------------
 t/t3200-branch.sh      | 14 +++++++++++++
 t/t3202-show-branch.sh | 18 ++++++++++++++++
 3 files changed, 59 insertions(+), 20 deletions(-)

Range-diff against v2:
1:  d16819bc61 ! 1:  50fa7ed076 avoid unnecessary worktrees traversing
    @@ Metadata
     Author: Rubén Justo <rjusto@gmail.com>
     
      ## Commit message ##
    -    avoid unnecessary worktrees traversing
    +    branch: avoid unnecessary worktrees traversals
     
         "reject_rebase_or_bisect_branch()" was introduced [1] to prevent a
         branch under bisect or rebase from being renamed or copied.  It
         traverses all worktrees in the repository and dies if the specified
    -    branch is being rebased or bisected in any them.
    +    branch is being rebased or bisected in any of them.
     
         "replace_each_worktree_head_symref()" was introduced [2] to adjust the
         HEAD in all worktrees after a branch rename succeeded.  It traverses all
    @@ Commit message
         to the renamed ref, it adjusts it.
     
         If we could know in advance if the renamed branch is not HEAD in any
    -    worktree we could avoid calling "replace_each_worktree_head_symref()".
    +    worktree we could avoid calling "replace_each_worktree_head_symref()",
    +    and so avoid that unnecessary second traversing.
     
    -    Let's have "reject_rebase_or_bisect_branch()" check and return whether
    -    the specified branch is HEAD in any worktree, and use this information
    -    to avoid unnecessary calls to "replace_each_worktree_head_symref()".
    +    Let's rename "reject_rebase_or_bisect_branch()" to a more meaningful
    +    name "die_if_branch_is_being_rebased_or_bisected()" and make it return,
    +    if it does not die(), if the specified branch is HEAD in any worktree.
    +    Use this new information to avoid unnecessary calls to
    +    "replace_each_worktree_head_symref()".
     
           1.- 14ace5b (branch: do not rename a branch under bisect or rebase,
               2016-04-22)
    @@ builtin/branch.c: static void print_current_branch_name(void)
      }
      
     -static void reject_rebase_or_bisect_branch(const char *target)
    -+static int ishead_and_reject_rebase_or_bisect_branch(const char *target)
    ++/*
    ++ * Dies if the specified branch is being rebased or bisected.  Otherwise returns
    ++ * 0 or, if the branch is HEAD in any worktree, returns 1.
    ++ */
    ++static int die_if_branch_is_being_rebased_or_bisected(const char *target)
      {
      	struct worktree **worktrees = get_worktrees();
     -	int i;
    @@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const c
      	const char *interpreted_oldname = NULL;
      	const char *interpreted_newname = NULL;
     -	int recovery = 0;
    -+	int recovery = 0, ishead;
    ++	int recovery = 0, oldref_is_head;
      
      	if (strbuf_check_branch_ref(&oldref, oldname)) {
      		/*
    @@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const c
      		validate_new_branchname(newname, &newref, force);
      
     -	reject_rebase_or_bisect_branch(oldref.buf);
    -+	ishead = ishead_and_reject_rebase_or_bisect_branch(oldref.buf);
    ++	oldref_is_head = die_if_branch_is_being_rebased_or_bisected(oldref.buf);
      
      	if (!skip_prefix(oldref.buf, "refs/heads/", &interpreted_oldname) ||
      	    !skip_prefix(newref.buf, "refs/heads/", &interpreted_newname)) {
    @@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const c
      	}
      
     -	if (!copy &&
    -+	if (!copy && ishead &&
    ++	if (!copy && oldref_is_head &&
      	    replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf))
      		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
      
2:  bc0ac43932 ! 2:  ab277e5fcb branch: description for orphan branch errors
    @@ Commit message
         branch: description for orphan branch errors
     
         In bcfc82bd48 (branch: description for non-existent branch errors,
    -    2022-10-08) we check the current HEAD to detect if the branch to operate
    -    with is an orphan branch, to avoid the confusing error: "No branch
    -    named...".
    +    2022-10-08) we checked the current HEAD to detect if the branch to
    +    operate with is an orphan branch, so as to avoid the confusing error:
    +    "No branch named...".
     
         If we are asked to operate with an orphan branch in a different working
         tree than the current one, we need to check the HEAD in that different
    @@ Commit message
         repository, using the helper introduced in 31ad6b61bd (branch: add
         branch_checked_out() helper, 2022-06-15)
     
    -    "ishead_reject_rebase_or_bised_branch()" already returns whether the
    -    branch to operate with is HEAD in any working tree in the repository.
    +    "die_if_branch_is_being_rebased_or_bisected()" already returns whether
    +    the branch to operate with is HEAD in any worktree in the repository.
         Let's use this information in "copy_or_rename_branch()", instead of the
         helper.
     
    -    Note that we now call reject_rebase_or_bisect_branch() earlier, which
    -    introduces a change in the error displayed when a combination of
    -    unsupported conditions occur simultaneously: the desired destination
    -    name is invalid, and the branch to operate on is being overrun or
    -    bisected.  With "foo" being rebased or bisected, this:
    +    Note that we now call "die_if_branch_is_being_rebased_or_bisected()"
    +    earlier, which introduces a change in the error displayed when a
    +    combination of unsupported conditions occur simultaneously: the desired
    +    destination name is invalid, and the branch to operate with is being
    +    rebased or bisected.  i.e. with "foo" being rebased or bisected, this:
     
    -            $ git branch -m foo HEAD
    -            fatal: 'HEAD' is not a valid branch name.
    +            $ git branch -m foo /
    +            fatal: '/' is not a valid branch name.
     
         ... becomes:
     
    -            $ git branch -m foo HEAD
    +            $ git branch -m foo /
                 fatal: Branch refs/heads/foo is being ...
     
         Signed-off-by: Rubén Justo <rjusto@gmail.com>
    @@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const c
     -		else
     -			die(_("No branch named '%s'."), oldname);
     -	}
    -+	ishead = ishead_and_reject_rebase_or_bisect_branch(oldref.buf);
    ++	oldref_is_head = die_if_branch_is_being_rebased_or_bisected(oldref.buf);
     +
    -+	if ((copy || !ishead) && !ref_exists(oldref.buf))
    -+		die(ishead
    ++	if ((copy || !oldref_is_head) && !ref_exists(oldref.buf))
    ++		die(oldref_is_head
     +		    ? _("No commit on branch '%s' yet.")
     +		    : _("No branch named '%s'."), oldname);
      
    @@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const c
      	else
      		validate_new_branchname(newname, &newref, force);
      
    --	ishead = ishead_and_reject_rebase_or_bisect_branch(oldref.buf);
    +-	oldref_is_head = die_if_branch_is_being_rebased_or_bisected(oldref.buf);
     -
      	if (!skip_prefix(oldref.buf, "refs/heads/", &interpreted_oldname) ||
      	    !skip_prefix(newref.buf, "refs/heads/", &interpreted_newname)) {
3:  29f8b6044d ! 3:  9742b4ff1f branch: rename orphan branches in any worktree
    @@ Commit message
     
         In cfaff3aac (branch -m: allow renaming a yet-unborn branch, 2020-12-13)
         we added support for renaming an orphan branch, skipping rename_ref() if
    -    the branch to rename is an orphan branch, checking the current HEAD.
    +    the branch being renamed is an orphan branch; checking the current HEAD.
     
         But the orphan branch to be renamed can be an orphan branch in a
    -    different working tree than the current one, i.e. not the current HEAD.
    +    different worktree than the current one, i.e. not the current HEAD.
     
    -    Let's make "ishead_reject_rebase_or_bisect_branch()" return a flag
    -    indicating if the returned value refers to an orphan branch, and use it
    -    to extend what we did in cfaff3aac, to all HEADs in the repository.
    +    Let's make "die_if_branch_is_being_rebased_or_bisected()" return if the
    +    specified branch is HEAD and orphan, and use it to extend what we did in
    +    cfaff3aac, to check all HEADs in the repository.
     
         Signed-off-by: Rubén Justo <rjusto@gmail.com>
     
      ## builtin/branch.c ##
    -@@ builtin/branch.c: static int ishead_and_reject_rebase_or_bisect_branch(const char *target)
    +@@ builtin/branch.c: static void print_current_branch_name(void)
    + 
    + /*
    +  * Dies if the specified branch is being rebased or bisected.  Otherwise returns
    +- * 0 or, if the branch is HEAD in any worktree, returns 1.
    ++ * 0 or, if the branch is HEAD in any worktree, returns 1. If the branch is HEAD
    ++ * and also orphan, returns 2.
    +  */
    + static int die_if_branch_is_being_rebased_or_bisected(const char *target)
    + {
    +@@ builtin/branch.c: static int die_if_branch_is_being_rebased_or_bisected(const char *target)
      		struct worktree *wt = worktrees[i];
      
      		if (wt->head_ref && !strcmp(target, wt->head_ref))
     -			ret = 1;
    -+			ret = 1 + (is_null_oid(&wt->head_oid) ? 1 : 0);
    ++			ret = is_null_oid(&wt->head_oid) ? 2 : 1;
      
      		if (!wt->is_detached)
      			continue;
    +@@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const char *newname, int
    + 	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
    + 	const char *interpreted_oldname = NULL;
    + 	const char *interpreted_newname = NULL;
    +-	int recovery = 0, oldref_is_head;
    ++	int recovery = 0, oldref_is_head, oldref_is_orphan;
    + 
    + 	if (strbuf_check_branch_ref(&oldref, oldname)) {
    + 		/*
    +@@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const char *newname, int
    + 	}
    + 
    + 	oldref_is_head = die_if_branch_is_being_rebased_or_bisected(oldref.buf);
    ++	oldref_is_orphan = (oldref_is_head > 1);
    + 
    +-	if ((copy || !oldref_is_head) && !ref_exists(oldref.buf))
    +-		die(oldref_is_head
    ++	if ((copy || !oldref_is_head) &&
    ++	    (oldref_is_orphan || !ref_exists(oldref.buf)))
    ++		die(oldref_is_orphan
    + 		    ? _("No commit on branch '%s' yet.")
    + 		    : _("No branch named '%s'."), oldname);
    + 
     @@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const char *newname, int
      		strbuf_addf(&logmsg, "Branch: renamed %s to %s",
      			    oldref.buf, newref.buf);
      
     -	if (!copy &&
     -	    (!head || strcmp(oldname, head) || !is_null_oid(&head_oid)) &&
    -+	if (!copy && !(ishead > 1) &&
    ++	if (!copy && !oldref_is_orphan &&
      	    rename_ref(oldref.buf, newref.buf, logmsg.buf))
      		die(_("Branch rename failed"));
      	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
    @@ t/t3200-branch.sh: test_expect_success 'git branch -M and -C fail on detached HE
     +	test_when_finished git checkout - &&
     +	test_when_finished git worktree remove -f wt &&
     +	git worktree add wt --detach &&
    -+
     +	# rename orphan in another worktreee
     +	git -C wt checkout --orphan orphan-foo-wt &&
     +	git branch -m orphan-foo-wt orphan-bar-wt &&
     +	test orphan-bar-wt=$(git -C orphan-worktree branch --show-current) &&
    -+
     +	# rename orphan in the current worktree
     +	git checkout --orphan orphan-foo &&
     +	git branch -m orphan-foo orphan-bar &&
-- 
2.39.0

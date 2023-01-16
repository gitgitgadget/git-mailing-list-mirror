Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79914C46467
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 00:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjAPAEe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 19:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjAPAEa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 19:04:30 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5B33C08
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 16:04:29 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id q8so7126397wmo.5
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 16:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXI1bGYPQ45Alos3FcjXnRfoMg3pCfn62OLefjH9Q0w=;
        b=UR8UrnZNgVDt0O8vmU30vwdksRhUGgFlaH+wwq02n0K6XRP/yOIGAZgz2C7hL+h3LT
         jttHmzuvZagIvWxAATy4hAWcm7vN/wUcnqp6seXEQz9pVi5xCo97ynwA9T/O1XJfSWX2
         6p4XUTSYQV4utGroYI5uXtSw+uK4Chcai0hBqD1cDpAq7khKrtozCjSWXK0fyWI77GJd
         4NcGijbGrX1P1BCBeTu7PDKHNGsoeasILZkUK2Aar2etLjfzdAyXHjvWwVp+qXBrGHOG
         5ImIpWH6RYtX0hjbT/wpNk4q2ZXb83IQuwmljBT//OHJuReE7GbGArhvV9gbJ3Pk+k4d
         hoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXI1bGYPQ45Alos3FcjXnRfoMg3pCfn62OLefjH9Q0w=;
        b=j1paPKrW/OjV2CvC/OCz3ewkwvL2MJ67wPEmRLnWR65lD9k3fnWP1EhT3b8S0Ev+ij
         y+0b/mjZ4RPLht6IGe6GPeRFh04DYRge//5go/wCZyXrhYLalrc5MhjQpx1ySfECTt5U
         5csrhSjH6LT7oEcqHtkpKqFJzdhEIpW25ORcFdz9E0lTCpmPerrodnbI4VHY0BCsOOot
         BbHsOogm9NTt85wQAEWy6ouwJFt56CmeCwFK9abOlM+JX3ceGVusR9Tl5ikBkw+Ckiv1
         UknwYh6dTZl9I5L0iCho29aOlMuzWP2JOHBd9i8UF1TTdgpgV8Cd1P+Y1Q3Aq5WNeizV
         u0OA==
X-Gm-Message-State: AFqh2kpXkfAEFzWdS6tJCTnXirFaZyU7GinEbAMw6Aj8ZY2RkFIQdkSX
        +zMUr8nwsPzxK7YqR8VNm/FsJ2aV7sg=
X-Google-Smtp-Source: AMrXdXuX/17Tz4x97Gfm1o6WnXRMB+A9ylp9WEt7IMjMse7ckhJ1PCKN3e2pNcKyJfHLnOfy2bDCLw==
X-Received: by 2002:a7b:cb59:0:b0:3d3:5709:68e8 with SMTP id v25-20020a7bcb59000000b003d3570968e8mr65494469wmj.36.1673827467851;
        Sun, 15 Jan 2023 16:04:27 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id t14-20020adfeb8e000000b002baa780f0fasm24552934wrn.111.2023.01.15.16.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 16:04:27 -0800 (PST)
Subject: [PATCH 3/3] branch: rename orphan branches in any worktree
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
Message-ID: <a47ff192-db67-dc4c-ded3-cd1e7c197726@gmail.com>
Date:   Mon, 16 Jan 2023 01:04:26 +0100
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

In cfaff3aac (branch -m: allow renaming a yet-unborn branch, 2020-12-13)
we added support for renaming an orphan branch, skipping rename_ref() if
the branch to rename is an orphan branch, checking the current HEAD.

But the orphan branch to be renamed can be an orphan branch in a
different working tree than the current one, i.e. not the current HEAD.

Let's make "ishead_reject_rebase_or_bisect_branch()" return a flag
indicating if the returned value refers to an orphan branch, and use it
to extend what we did in cfaff3aac, to all HEADs in the repository.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c  |  5 ++---
 t/t3200-branch.sh | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 6bb5f50950..7e6baa291a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -495,7 +495,7 @@ static int ishead_and_reject_rebase_or_bisect_branch(const char *target)
 		struct worktree *wt = worktrees[i];
 
 		if (wt->head_ref && !strcmp(target, wt->head_ref))
-			ret = 1;
+			ret = 1 + (is_null_oid(&wt->head_oid) ? 1 : 0);
 
 		if (!wt->is_detached)
 			continue;
@@ -560,8 +560,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		strbuf_addf(&logmsg, "Branch: renamed %s to %s",
 			    oldref.buf, newref.buf);
 
-	if (!copy &&
-	    (!head || strcmp(oldname, head) || !is_null_oid(&head_oid)) &&
+	if (!copy && !(ishead > 1) &&
 	    rename_ref(oldref.buf, newref.buf, logmsg.buf))
 		die(_("Branch rename failed"));
 	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 5a169b68d6..966583dc7d 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -279,6 +279,22 @@ test_expect_success 'git branch -M and -C fail on detached HEAD' '
 	test_cmp expect err
 '
 
+test_expect_success 'git branch -m should work with orphan branches' '
+	test_when_finished git checkout - &&
+	test_when_finished git worktree remove -f wt &&
+	git worktree add wt --detach &&
+
+	# rename orphan in another worktreee
+	git -C wt checkout --orphan orphan-foo-wt &&
+	git branch -m orphan-foo-wt orphan-bar-wt &&
+	test orphan-bar-wt=$(git -C orphan-worktree branch --show-current) &&
+
+	# rename orphan in the current worktree
+	git checkout --orphan orphan-foo &&
+	git branch -m orphan-foo orphan-bar &&
+	test orphan-bar=$(git branch --show-current)
+'
+
 test_expect_success 'git branch -d on orphan HEAD (merged)' '
 	test_when_finished git checkout main &&
 	git checkout --orphan orphan &&
-- 
2.39.0

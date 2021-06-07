Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9A4C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 18:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2780610A1
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 18:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhFGSwj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 14:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhFGSwi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 14:52:38 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744A5C061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 11:50:47 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so4045695otl.0
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 11:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oIKHhBvC9KpigFjx/nBPFk0kxfiUSD4EacGKZnsW/KQ=;
        b=p0AY3O5A6O95kDBhcqFEHDlOLxtObGAKx11uwuPe+QkKhn2k9hQWVe6h7oBI2yAJPU
         O/LPfgtDFBdyn9hehs3E6fa/G0CUCUTnw7jv32eTm+BFSXhzG6n9mughoT5/VfIKC7mP
         Z+o+POixkLPd/uaYqkPd1+hcbzDUoud6uFT1cppcYbyvs15IcQfrfC5iW2FOM7yRuLmJ
         Or32x7g5T/qwvp86aSIZ7DBY1Fdewakr01cPQF0PcHgdCOnh5n0+bA/w/gYforAP2lfj
         O1+t1yDK3rW2/IfbXMRlpJT5MdVLNRhfUDXGINNkj8Xet3qtxLIDgCtfkavySaLf3EHa
         RhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oIKHhBvC9KpigFjx/nBPFk0kxfiUSD4EacGKZnsW/KQ=;
        b=GuaKFfzcSO2cp4bVXyD5BUfO066/3zb3rPFuA5DyHIoOK2jBbR16xN3tDMMTKZ1zrg
         tZSyji4sC08XGNZ8JaUVmTw55h1chP9sOblVm0DKCc3KnzTZfvvoRQuJDyQ/7YNFgpai
         GNFKvNrOPgBfVnTlZGXxJ2rdw+FsDrXGezg/Hc2E2BqNSK9l+7p/kZ20yuoOi4bFVNYC
         GyUOmEBcEJ20mA/tw7cTjKZAUi9nXOciBExgIDAsbR2Hq+shtYzycPL8TFrP8yWSwnM+
         EL0lURZfWecD+6pu5Jz+l8YT2j9CFj9P6ITt2lJY5gFU9wNrh1nfO/B1m6SfMpR1wXPa
         exTw==
X-Gm-Message-State: AOAM531Fe1RJge+B96xarcp7LAnug82FE1qSC/hnR24tqm2TtCW4sB7l
        0LkctWQGDFoeC8VWH4edQnsovCaYuWwxqg==
X-Google-Smtp-Source: ABdhPJweyqlDHcWuXKjk0OCO1Kq1RIid8MPMs7WycmgfIPbWXVOF5FJPj3EvPVTtqlu89vHcxMUpNg==
X-Received: by 2002:a9d:526:: with SMTP id 35mr14878605otw.176.1623091846457;
        Mon, 07 Jun 2021 11:50:46 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id e14sm2265501oow.11.2021.06.07.11.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 11:50:46 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2] branch: prioritize upstream in -v
Date:   Mon,  7 Jun 2021 13:50:43 -0500
Message-Id: <20210607185043.893205-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1.2.g0532ba4bf6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The two important pieces of information relevant to -v and -vv are the
upstream branch, and tracking status (ahead/behind).

Currently we give priority to the tracking stats (shown with -v) and
demote the upstream branch name (shown only with -vv).

However, showing "[ahead 10]" is not useful to most users, since they
will wonder: ahead of what?.

A lot of people set their upstream to the place they push to, not where
they base their branch on. In fact, many guides suggest the following to
set the upstream branch:

  git push --set-upstream github pull-request

Even more, when pushing a fresh branch git itself recommends that:

  % git clone $url .
  % git checkout -b fix
  ...
  % git push

  fatal: The current branch fix has no upstream branch.
  To push the current branch and set the remote as upstream, use

      git push --set-upstream origin fix

Therefore for many workflows `git branch -v` is not very useful.

Inevitably many users will need to know what @{upstream} is.

So let's make `git branch -v` output what is most useful:

  [myrepo/mybranch]

Before:

  * mybranch b2489a3735 [ahead 1] Hot fix

After:

  * mybranch b2489a3735 [myrepo/mybranch] Hot fix

An additional benefit is that `git branch -v` is faster: from 2 to 40
times (depending on the number of stale branches).

`git branch -vv` is unaffected.

Suggestions-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Since v1 I updated the title of the commit, and also the entire commit
message prompted by suggestions from Ævar.

In particupar I added the example git itself shows by default when
pushing a branch with no upstream:

    git push --set-upstream origin fix

This _obviously_ suggests people have configured upstream branches other
than origin/master.

I also updated the documentation, again, as Ævar suggested.

And I also left alone the workdir stuff. I think if we are going to show
upstream branches with -v, it makes sense to show workdirs too. However,
since this patch received more pushback than I expected, I decided to
minimize the changes.

Range-diff against v1:
1:  ade2eb0aba ! 1:  f309c75ea4 branch: make -v useful
    @@ Metadata
     Author: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## Commit message ##
    -    branch: make -v useful
    +    branch: prioritize upstream in -v
     
    -    Currently `git branch -v` shows something like "[ahead 10]", but ahead
    -    of what?
    +    The two important pieces of information relevant to -v and -vv are the
    +    upstream branch, and tracking status (ahead/behind).
     
    -    We git experts know ahead of what, but not what that what is set to. Just
    -    like "[@{upstream}: ahead 10]" would not be particularly useful to
    -    anyone that doesn't know, or remembers, what @{upstream} is set to.
    +    Currently we give priority to the tracking stats (shown with -v) and
    +    demote the upstream branch name (shown only with -vv).
     
    -    On the other hand "[master: ahead 10]" is perfectly clear to anyone.
    +    However, showing "[ahead 10]" is not useful to most users, since they
    +    will wonder: ahead of what?.
     
    -    This confusion only gets worse when you see "[ahead 10, behind 100]". Is
    -    it master? Is it next? Is it
    -    john/experimental-feature-i-based-my-branch-on?
    +    A lot of people set their upstream to the place they push to, not where
    +    they base their branch on. In fact, many guides suggest the following to
    +    set the upstream branch:
     
    -    Inevitably most users will need to know what @{upstream} is.
    +      git push --set-upstream github pull-request
    +
    +    Even more, when pushing a fresh branch git itself recommends that:
    +
    +      % git clone $url .
    +      % git checkout -b fix
    +      ...
    +      % git push
    +
    +      fatal: The current branch fix has no upstream branch.
    +      To push the current branch and set the remote as upstream, use
    +
    +          git push --set-upstream origin fix
    +
    +    Therefore for many workflows `git branch -v` is not very useful.
    +
    +    Inevitably many users will need to know what @{upstream} is.
     
         So let's make `git branch -v` output what is most useful:
     
    -      [master]
    +      [myrepo/mybranch]
     
         Before:
     
    -      * fc/branch/sane-colors b2489a3735 [ahead 1] branch: make -v useful
    +      * mybranch b2489a3735 [ahead 1] Hot fix
     
         After:
     
    -      * fc/branch/sane-colors b2489a3735 [master] branch: make -v useful
    +      * mybranch b2489a3735 [myrepo/mybranch] Hot fix
     
    -    An additional benefit is that `git branch -v` is slightly faster: 30ms
    -    vs. 60ms on my system.
    +    An additional benefit is that `git branch -v` is faster: from 2 to 40
    +    times (depending on the number of stale branches).
     
         `git branch -vv` is unaffected.
     
    +    Suggestions-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
    + ## Documentation/git-branch.txt ##
    +@@ Documentation/git-branch.txt: This option is only applicable in non-verbose mode.
    + --verbose::
    + 	When in list mode,
    + 	show sha1 and commit subject line for each head, along with
    +-	relationship to upstream branch (if any). If given twice, print
    +-	the path of the linked worktree (if any) and the name of the upstream
    ++	the upstream branch (if any). If given twice, print
    ++	the path of the linked worktree (if any) and the relationship to the upstream
    + 	branch, as well (see also `git remote show <remote>`).  Note that the
    + 	current worktree's HEAD will not have its path printed (it will always
    + 	be your current directory).
    +@@ Documentation/git-branch.txt: This option is only applicable in non-verbose mode.
    + 	`branch.<name>.merge` configuration entries to mark the
    + 	start-point branch as "upstream" from the new branch. This
    + 	configuration will tell git to show the relationship between the
    +-	two branches in `git status` and `git branch -v`. Furthermore,
    ++	two branches in `git status` and `git branch -vv`. Furthermore,
    + 	it directs `git pull` without arguments to pull from the
    + 	upstream when the new branch is checked out.
    + +
    +
      ## builtin/branch.c ##
     @@ builtin/branch.c: static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
    - 		strbuf_addstr(&local, branch_get_color(BRANCH_COLOR_RESET));
    - 		strbuf_addf(&local, " %s ", obname.buf);
    - 
    -+		strbuf_addf(&local, "%%(if:notequals=*)%%(HEAD)%%(then)%%(if)%%(worktreepath)%%(then)(%s%%(worktreepath)%s) %%(end)%%(end)",
    -+			    branch_get_color(BRANCH_COLOR_WORKTREE), branch_get_color(BRANCH_COLOR_RESET));
    - 		if (filter->verbose > 1)
    --		{
    --			strbuf_addf(&local, "%%(if:notequals=*)%%(HEAD)%%(then)%%(if)%%(worktreepath)%%(then)(%s%%(worktreepath)%s) %%(end)%%(end)",
    --				    branch_get_color(BRANCH_COLOR_WORKTREE), branch_get_color(BRANCH_COLOR_RESET));
    - 			strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
    - 				    "%%(then): %%(upstream:track,nobracket)%%(end)] %%(end)%%(contents:subject)",
      				    branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));
    --		}
    + 		}
      		else
     -			strbuf_addf(&local, "%%(if)%%(upstream:track)%%(then)%%(upstream:track) %%(end)%%(contents:subject)");
     +			strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s] %%(end)%%(contents:subject)",

 Documentation/git-branch.txt |  6 +++---
 builtin/branch.c             |  3 ++-
 t/t3201-branch-contains.sh   |  2 +-
 t/t6040-tracking-info.sh     | 12 ++++++------
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 94dc9a54f2..ebf5d69b68 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -183,8 +183,8 @@ This option is only applicable in non-verbose mode.
 --verbose::
 	When in list mode,
 	show sha1 and commit subject line for each head, along with
-	relationship to upstream branch (if any). If given twice, print
-	the path of the linked worktree (if any) and the name of the upstream
+	the upstream branch (if any). If given twice, print
+	the path of the linked worktree (if any) and the relationship to the upstream
 	branch, as well (see also `git remote show <remote>`).  Note that the
 	current worktree's HEAD will not have its path printed (it will always
 	be your current directory).
@@ -210,7 +210,7 @@ This option is only applicable in non-verbose mode.
 	`branch.<name>.merge` configuration entries to mark the
 	start-point branch as "upstream" from the new branch. This
 	configuration will tell git to show the relationship between the
-	two branches in `git status` and `git branch -v`. Furthermore,
+	two branches in `git status` and `git branch -vv`. Furthermore,
 	it directs `git pull` without arguments to pull from the
 	upstream when the new branch is checked out.
 +
diff --git a/builtin/branch.c b/builtin/branch.c
index b23b1d1752..ed3d0946a7 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -384,7 +384,8 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 				    branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));
 		}
 		else
-			strbuf_addf(&local, "%%(if)%%(upstream:track)%%(then)%%(upstream:track) %%(end)%%(contents:subject)");
+			strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s] %%(end)%%(contents:subject)",
+				    branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));
 
 		strbuf_addf(&remote, "%%(align:%d,left)%s%%(refname:lstrip=2)%%(end)%s"
 			    "%%(if)%%(symref)%%(then) -> %%(symref:short)"
diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 349a810cee..53e2d65e67 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -261,7 +261,7 @@ test_expect_success 'branch --merged with --verbose' '
 	git branch --verbose --merged topic >actual &&
 	cat >expect <<-EOF &&
 	  main  $(git rev-parse --short main) second on main
-	* topic $(git rev-parse --short topic ) [ahead 1] foo
+	* topic $(git rev-parse --short topic ) [main] foo
 	  zzz   $(git rev-parse --short zzz   ) second on main
 	EOF
 	test_cmp expect actual
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index a313849406..30f80ad61b 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -43,12 +43,12 @@ test_expect_success setup '
 
 t6040_script='s/^..\(b.\) *[0-9a-f]* \(.*\)$/\1 \2/p'
 cat >expect <<\EOF
-b1 [ahead 1, behind 1] d
-b2 [ahead 1, behind 1] d
-b3 [behind 1] b
-b4 [ahead 2] f
-b5 [gone] g
-b6 c
+b1 [origin/main] d
+b2 [origin/main] d
+b3 [origin/main] b
+b4 [origin/main] f
+b5 [brokenbase] g
+b6 [origin/main] c
 EOF
 
 test_expect_success 'branch -v' '
-- 
2.31.1.2.g0532ba4bf6


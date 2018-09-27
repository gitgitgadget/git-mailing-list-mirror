Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16B161F453
	for <e@80x24.org>; Thu, 27 Sep 2018 15:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbeI0VcX (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 17:32:23 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36647 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeI0VcX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 17:32:23 -0400
Received: by mail-qt1-f195.google.com with SMTP id e26-v6so3139347qtq.3
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 08:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=h7ZKPHuAZ05Zw2Jv81yNrx0jwoXcqDNVMGXClvhcClU=;
        b=npUsShIkEy6BFA+B5OiWTS5f7sMIaaA4+twGmO+d3gtNgWSoYoCznRaZDTUvzJlvem
         SAhgZ3K4eB6kNhJkKvtbv8iwdKKm8Rw85cWXlSrbO6pQifctQwAea7w0Z45IaQeWLizg
         kh7EolziJLHPe/33AKylSWYtzUDf0CxHDBcR9HG3GuGakPyMtlDhglK+XZYBs6fhiRhX
         7kyH9xvlwulRVW6IkMatIrZ4j9bLjAewUHmxd/caAC9+Xy9BSn8pRcIhzROIfDLTyZwc
         98mZ4CxG8thAy2x7c4U0PBLudFyITzq5iwkl3wdBjzJXnjcb+82NOehI1WCS4E6DqIAo
         gBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=h7ZKPHuAZ05Zw2Jv81yNrx0jwoXcqDNVMGXClvhcClU=;
        b=WEllvrAxbD3ipnhKrdcIuB/y+49UZEKTQWjtEW7jZgSE4Vtt4onbEq59KINcfTVRdu
         yhR11DHZxZky0Qr7+sTegSFC5Ehmv9NuVSff1VQBKw80s2UyRfyYEa4kA01rcMFPWEzM
         KNEkquljSOb3yGiZ785Thz2jsDReimTkb9P/zmaKlXnN9H8x8wbBrp3of7Dt0dGd0UJI
         Txp/JFmBF5+er4U03NpgcyH3ZlpjQRju77XQvo/WDG0B/ulgCE7t67UjBXI1BVgpe1Bk
         99BrdSOzB6OGVLVHL+fUfE38v0QJGM+NMkDRRNk9hpfVceXGokJLgWSu4VoUwOtOg7ow
         w/kQ==
X-Gm-Message-State: ABuFfohXgPyG3xqyTc1Eb6jTgZ4YA3OTTP1S9L4s60jvVBypknrbZnfv
        9sXKu7twGXnJjmL2LHpo2EXdLbALJAFj5tj/qqYqisVS
X-Google-Smtp-Source: ACcGV634WsYRDTJLvJu1taJSZS3yKp9wxooH/A5Y5VUDNZ8U7ETFyqsGHifKNCN5WgTlxKrTbzvrB9KPcxnrEJCrKUU=
X-Received: by 2002:a0c:8ab0:: with SMTP id 45-v6mr8430687qvv.159.1538061219705;
 Thu, 27 Sep 2018 08:13:39 -0700 (PDT)
MIME-Version: 1.0
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Thu, 27 Sep 2018 08:13:13 -0700
Message-ID: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
Subject: [PATCH] branch: colorize branches checked out in a linked working
 tree the same way as the current branch is colorized
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to more clearly display which branches are active, the output
of git branch is modified to colorize branches checked out in any linked
worktrees with the same color as the current branch.

This is meant to simplify workflows related to worktree, particularly
due to the limitations of not being able to check out the same branch in
two worktrees and the inability to delete a branch checked out in a
worktree. When performing branch operations like checkout and delete, it
would be useful to know more readily if the branches in which the user
is interested are already checked out in a worktree.

The git worktree list command contains the relevant information, however
this is a much less frquently used command than git branch.

Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
---

Notes:
    Travis CI results: https://travis-ci.org/nbelakovski/git/builds/432320949

 builtin/branch.c         | 35 ++++++++++++++++++++++++++++++-----
 t/t3203-branch-output.sh | 21 +++++++++++++++++++++
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 4fc55c350..65b58ff7c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -334,11 +334,36 @@ static char *build_format(struct ref_filter
*filter, int maxwidth, const char *r
        struct strbuf local = STRBUF_INIT;
        struct strbuf remote = STRBUF_INIT;

-       strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %s%%(end)",
-                   branch_get_color(BRANCH_COLOR_CURRENT),
-                   branch_get_color(BRANCH_COLOR_LOCAL));
-       strbuf_addf(&remote, "  %s",
-                   branch_get_color(BRANCH_COLOR_REMOTE));
+       // Prepend the current branch of this worktree with "* " and
all other branches with "  "
+       strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %%(else)  %%(end)");
+       // Prepend remote branches with two spaces
+       strbuf_addstr(&remote, "  ");
+       if(want_color(branch_use_color)) {
+               // Create a nested if statement to evaluate if the
current ref is equal to a HEAD ref from either
+               // the main or any linked worktrees. If so, color it
CURRENT, otherwise color it LOCAL
+               struct strbuf color = STRBUF_INIT;
+               struct worktree **worktrees = get_worktrees(0);
+               int i;
+               for (i = 0; worktrees[i]; ++i) {
+                       strbuf_addf(&color,
"%%(if:equals=%s)%%(refname)%%(then)%s%%(else)",
+                                   worktrees[i]->head_ref,
+                                   branch_get_color(BRANCH_COLOR_CURRENT));
+               }
+               // add one more check in the nested if-else to cover
the detached HEAD state
+               strbuf_addf(&color, "%%(if)%%(HEAD)%%(then)%s%%(else)%s%%(end)",
+                           branch_get_color(BRANCH_COLOR_CURRENT),
+                           branch_get_color(BRANCH_COLOR_LOCAL));
+               // close up the nested if-else
+               for (; i > 0; --i) {
+                       strbuf_addf(&color, "%%(end)");
+               }
+               free_worktrees(worktrees);
+               strbuf_addbuf(&local, &color);
+               strbuf_release(&color);
+
+               strbuf_addf(&remote, "%s",
+                           branch_get_color(BRANCH_COLOR_REMOTE));
+    }

        if (filter->verbose) {
                struct strbuf obname = STRBUF_INIT;
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index ee6787614..369a156c0 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -240,6 +240,27 @@ test_expect_success 'git branch --format option' '
        test_i18ncmp expect actual
 '

+test_expect_success '"add" a worktree' '
+       mkdir worktree_dir &&
+       git worktree add -b master_worktree worktree_dir master
+'
+
+cat >expect <<'EOF'
+* <GREEN>(HEAD detached from fromtag)<RESET>
+  ambiguous<RESET>
+  branch-one<RESET>
+  branch-two<RESET>
+  master<RESET>
+  <GREEN>master_worktree<RESET>
+  ref-to-branch<RESET> -> branch-one
+  ref-to-remote<RESET> -> origin/branch-one
+EOF
+test_expect_success TTY 'worktree colors correct' '
+       test_terminal git branch >actual.raw &&
+       test_decode_color <actual.raw >actual &&
+       test_cmp expect actual
+'
+
 test_expect_success "set up color tests" '
        echo "<RED>master<RESET>" >expect.color &&
        echo "master" >expect.bare &&

-- 
2.14.2

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9D0C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 02:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243846AbiBBCiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 21:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243847AbiBBChy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 21:37:54 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87476C06175A
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 18:37:49 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u15so35581471wrt.3
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 18:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WHxDyfRSomseEUeYcK3uIIfwY7bG5/mcAOhBCCfSPqo=;
        b=JjOLRUAojPNea78sbRoNX9Ro4gnmGR+pGV18IHxOxYNw5Fy9gC+6N+XxMHHoSuDEQ9
         vXqjCurIRoWovf7KqDjr83bWupnpykbRsENzIznYV+ulxFzRtWJl3k12pGZq74f++NM4
         mXKq2LIdz0C/X4+cWLcN/q6INxmy2aWGflhS2triqwWKBHnOGZ6P0eRIzuBYJtfh5Qo5
         Wt2u5uK/R5MJr3Dfa13VJi46dmpaVfM4sQwITrreKhO2KeYnpsPReYhcfK3F/kpA20ti
         iMiC7tLQ2f2wydJ70QF13MZ7n+Sqve7nYszW7MWI4WwrjJ5i+rrny/z3Tb4R5c7gThET
         zWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WHxDyfRSomseEUeYcK3uIIfwY7bG5/mcAOhBCCfSPqo=;
        b=rfBm2Welio3U3tRz7tf+2HOf4P0opsfRiPSTaL5VwtpNhhT8zZVqbWgFvFIKlr0JZv
         dDjyUmc13TdfeupvMaH6xq4fc97OurTUN3vmg3qpLMMc2hJHbYUVJE/+r6Ug+Cm3JzjI
         wh8U+xjB6lsi/qb5bAT7XxfaMvqPIyoYWa9bbgqkqEaigLuJzs5waKKJNVeMAmLEuSum
         NtR8O/Za8hsQ+hIGyb3zvqr58Ygp2tglQrxzgNNYyWx9IvCxTTati5cZYG8S5GYLdSzv
         fopJ4Wzdllu/Ff4JwBFMM+sjnzERz1Dd6txnl6pbYxEuOPC3v8SjaoLuWv1J9NP+fri8
         aLYQ==
X-Gm-Message-State: AOAM531YlE1iXSWfsdlpz0EmLiLIkS6fhJmwZlnZDspwNM3i3EN2Ke9N
        5spNUP+QFk0Iq4MSX787Mh4o1PrpJ80=
X-Google-Smtp-Source: ABdhPJxxXvbpYzkFcLrmYz1IkyqGNr1c30AuAtax9jaTV3QE0k6QZmraNYC27yBQR8fs8Oufo3ZoNQ==
X-Received: by 2002:a05:6000:2ad:: with SMTP id l13mr23142711wry.174.1643769467911;
        Tue, 01 Feb 2022 18:37:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y8sm3051066wrd.32.2022.02.01.18.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 18:37:47 -0800 (PST)
Message-Id: <59d12f213b25087fc610d1151f3bb790046fe6ca.1643769457.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v5.git.1643769457.gitgitgadget@gmail.com>
References: <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
        <pull.1103.v5.git.1643769457.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 02:37:37 +0000
Subject: [PATCH v5 10/10] diff-merges: avoid history simplifications when
 diffing merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Doing diffs for merges are special; they should typically avoid history
simplification.  For example, with

    git log --diff-merges=first-parent -- path

the default history simplification would remove merge commits from
consideration if the file "path" matched the second parent.  That is
counter to what the user wants when looking for first-parent diffs.
Similar comments can be made for --diff-merges=separate (which diffs
against both parents) and --diff-merges=remerge (which diffs against a
remerge of the merge commit).

However, history simplification still makes sense if not doing diffing
merges, and it also makes sense for the combined and dense-combined
forms of diffing merges (because both of those are defined to only show
a diff when the merge result at the relevant paths differs from *both*
parents).

So, for separate, first-parent, and remerge styles of diff-merges, turn
off history simplification.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff-merges.c           |  2 ++
 t/t4069-remerge-diff.sh | 58 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/diff-merges.c b/diff-merges.c
index 0af4b3f9191..a833fd747ad 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -24,6 +24,7 @@ static void set_separate(struct rev_info *revs)
 {
 	suppress(revs);
 	revs->separate_merges = 1;
+	revs->simplify_history = 0;
 }
 
 static void set_first_parent(struct rev_info *revs)
@@ -50,6 +51,7 @@ static void set_remerge_diff(struct rev_info *revs)
 {
 	suppress(revs);
 	revs->remerge_diff = 1;
+	revs->simplify_history = 0;
 }
 
 static diff_merges_setup_func_t func_by_opt(const char *optarg)
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index fd6bce64781..35f94957fce 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -227,7 +227,63 @@ test_expect_success 'remerge-diff w/ pathspec: limits to relevant file including
 	# with sha256
 	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
 
-	git show --oneline --remerge-diff --full-history resolution -- "letters*" >tmp &&
+	git show --oneline --remerge-diff resolution -- "letters*" >tmp &&
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup non-content conflicts' '
+	git switch --orphan newbase &&
+
+	test_write_lines 1 2 3 4 5 6 7 8 9 >numbers &&
+	git add numbers &&
+	git commit -m base &&
+
+	git branch newside1 &&
+	git branch newside2 &&
+
+	git checkout newside1 &&
+	test_write_lines 1 2 three 4 5 6 7 8 9 >numbers &&
+	git add numbers &&
+	git commit -m side1 &&
+
+	git checkout newside2 &&
+	test_write_lines 1 2 drei 4 5 6 7 8 9 >numbers &&
+	git add numbers &&
+	git commit -m side2 &&
+
+	git checkout -b newresolution newside1 &&
+	test_must_fail git merge newside2 &&
+	git checkout --theirs numbers &&
+	git add -u numbers &&
+	git commit -m resolved
+'
+
+test_expect_success 'remerge-diff turns off history simplification' '
+	git log -1 --oneline newresolution >tmp &&
+	cat <<-EOF >>tmp &&
+	diff --git a/numbers b/numbers
+	remerge CONFLICT (content): Merge conflict in numbers
+	index 070e9e7..5335e78 100644
+	--- a/numbers
+	+++ b/numbers
+	@@ -1,10 +1,6 @@
+	 1
+	 2
+	-<<<<<<< 96f1e45 (side1)
+	-three
+	-=======
+	 drei
+	->>>>>>> 4fd522f (side2)
+	 4
+	 5
+	 6
+	EOF
+	# We still have some sha1 hashes above; rip them out so test works
+	# with sha256
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
+
+	git show --oneline --remerge-diff newresolution -- numbers >tmp &&
 	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
 	test_cmp expect actual
 '
-- 
gitgitgadget

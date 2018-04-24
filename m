Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BCE31F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeDXV5K (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:57:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51714 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeDXV5J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:57:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id j4so3823158wme.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 14:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K7nylmUrx7xNcK/Uk5s31L/XY4AA5i7uOnaZsaByniI=;
        b=suXXWD6dzI74ZUxzrYC9zN2oGO/+ngXzq1+Xvladw/dbdjaO+i2M2zANgfnckXq44Q
         Zp7e09CSRTJMXC5+Q5Vl+QbPdjvXR5bAA1Zh1IFyXEr8iokydY5uRtKeJWzvdAoHy6ip
         LY9KmUS/yxq2E6h0q7CzGbiNLCK2yy15YSnVHXleXUb+JVOucqBpTN8m9nJb/4FIrfNL
         ifw3eKs2wsjchtmP2PfakSfFWNrCqTdLi3tGfmJDgUML96CJhBoHZpqDWiQecj8DNxFn
         8u7kgFvx6YkGY9FNVOXX7lV6Ydpy8q1gR4mHq890uzSuujgx4pLdWJFLw7gTLm011K77
         4GlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K7nylmUrx7xNcK/Uk5s31L/XY4AA5i7uOnaZsaByniI=;
        b=KmqltaAUIgxlfdGpTUAsLA3rERCWBizTANx94jPVbEpXKu3cLdh4o6cJl/b8njQ7uA
         Lo8p2pVJ2PSW7zQ3bnWhTdDhqvI6BxHt/zm+5m27vIVxKB6D93+b5VRyORbhWUXZl6Ev
         AITXJrvvNNgfKFLUyP3rgK5LfbAAbLJvGk1m1fUZ7H//184rqbj4wCuGAV9F/00zqkku
         XzG2epIspubSe/GmbX+pT/eMBnhpguQozO1dxU+yttTf6nfMKjnY3+qfzK/EZ5y86rxT
         aD6Gurp08cmDOfHAraF7Z+q7FR7eK/wpmboCxcDDkGhJPpKhj8PcEpWz6BYzu/KhpccR
         hUtQ==
X-Gm-Message-State: ALQs6tBe+uWgik33piE5v4cUOrfqy2M2h6T/n8ZNcROaKLHny0tk2gzV
        GVGR7BywrpdD8jShEInXPFgt/4JD
X-Google-Smtp-Source: AB8JxZpg/NtpC60eiZcpuYDORqy74ynAtlaRtZm71EHgxLmOSJvj2RT5t3WaME5t94/w5CXS3wLw0w==
X-Received: by 10.28.230.28 with SMTP id d28mr13784102wmh.92.1524607027690;
        Tue, 24 Apr 2018 14:57:07 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id r200sm16946799wmb.39.2018.04.24.14.57.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 14:57:06 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v9 0/4] worktree: teach "add" to check out existing branches
Date:   Tue, 24 Apr 2018 22:56:31 +0100
Message-Id: <20180424215635.9183-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.76.ga910c1dec4
In-Reply-To: <20180423193848.5159-1-t.gummerer@gmail.com>
References: <20180423193848.5159-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previous rounds are at <20180121120208.12760-1-t.gummerer@gmail.com>,
<20180204221305.28300-1-t.gummerer@gmail.com>,
<20180317220830.30963-1-t.gummerer@gmail.com>,
<20180317222219.4940-1-t.gummerer@gmail.com>,
<20180325134947.25828-1-t.gummerer@gmail.com>,
<20180331151804.30380-1-t.gummerer@gmail.com>,
<20180415202917.4360-1-t.gummerer@gmail.com> and
<20180423193848.5159-1-t.gummerer@gmail.com>.

Thanks Eric for the review and the suggestions on the previous round.

Changes since the previous round:

- UNLEAK new_branch after it was xstrndup'd
- update the commit message of 2/4 according to Eric's suggestions
- make force_new_branch a boolean flag in
  print_preparing_worktree_line, instead of using it as the branch
  name.  Instead use new_branch as the new branch name everywhere in
  that function.
- get rid of the ckeckout_existing_branch flag

Interdiff below:

diff --git a/builtin/worktree.c b/builtin/worktree.c
index d52495f312..d3aeb4877d 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -356,18 +356,15 @@ static int add_worktree(const char *path, const char *refname,
 static void print_preparing_worktree_line(int detach,
 					  const char *branch,
 					  const char *new_branch,
-					  const char *new_branch_force,
-					  int checkout_existing_branch)
+					  int force_new_branch)
 {
-	if (checkout_existing_branch) {
-		printf_ln(_("Preparing worktree (checking out '%s')"), branch);
-	} else if (new_branch_force) {
-		struct commit *commit = lookup_commit_reference_by_name(new_branch_force);
+	if (force_new_branch) {
+		struct commit *commit = lookup_commit_reference_by_name(new_branch);
 		if (!commit)
-			printf_ln(_("Preparing worktree (new branch '%s')"), new_branch_force);
+			printf_ln(_("Preparing worktree (new branch '%s')"), new_branch);
 		else
 			printf_ln(_("Preparing worktree (resetting branch '%s'; was at %s)"),
-				  new_branch_force,
+				  new_branch,
 				  find_unique_abbrev(commit->object.oid.hash,
 						     DEFAULT_ABBREV));
 	} else if (new_branch) {
@@ -390,19 +387,17 @@ static void print_preparing_worktree_line(int detach,
 	}
 }
 
-static const char *dwim_branch(const char *path, const char **new_branch,
-			       int *checkout_existing_branch)
+static const char *dwim_branch(const char *path, const char **new_branch)
 {
 	int n;
 	const char *s = worktree_basename(path, &n);
 	const char *branchname = xstrndup(s, n);
 	struct strbuf ref = STRBUF_INIT;
 
+	UNLEAK(branchname);
 	if (!strbuf_check_branch_ref(&ref, branchname) &&
 	    ref_exists(ref.buf)) {
-		*checkout_existing_branch = 1;
 		strbuf_release(&ref);
-		UNLEAK(branchname);
 		return branchname;
 	}
 
@@ -421,7 +416,6 @@ static int add(int ac, const char **av, const char *prefix)
 	struct add_opts opts;
 	const char *new_branch_force = NULL;
 	char *path;
-	int checkout_existing_branch = 0;
 	const char *branch;
 	const char *new_branch = NULL;
 	const char *opt_track = NULL;
@@ -469,8 +463,7 @@ static int add(int ac, const char **av, const char *prefix)
 	}
 
 	if (ac < 2 && !new_branch && !opts.detach) {
-		const char *s = dwim_branch(path, &new_branch,
-					    &checkout_existing_branch);
+		const char *s = dwim_branch(path, &new_branch);
 		if (s)
 			branch = s;
 	}
@@ -490,8 +483,7 @@ static int add(int ac, const char **av, const char *prefix)
 		}
 	}
 
-	print_preparing_worktree_line(opts.detach, branch, new_branch, new_branch_force,
-				      checkout_existing_branch);
+	print_preparing_worktree_line(opts.detach, branch, new_branch, !!new_branch_force);
 
 	if (new_branch) {
 		struct child_process cp = CHILD_PROCESS_INIT;

Thomas Gummerer (4):
  worktree: remove extra members from struct add_opts
  worktree: improve message when creating a new worktree
  worktree: factor out dwim_branch function
  worktree: teach "add" to check out existing branches

 Documentation/git-worktree.txt |   9 +++-
 builtin/worktree.c             | 103 ++++++++++++++++++++++++++++++-----------
 t/t2025-worktree-add.sh        |  26 ++++++++---
 3 files changed, 102 insertions(+), 36 deletions(-)

-- 
2.16.1.74.g7afd1c25cc.dirty


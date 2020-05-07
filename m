Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C481C4724C
	for <git@archiver.kernel.org>; Thu,  7 May 2020 13:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 057F920708
	for <git@archiver.kernel.org>; Thu,  7 May 2020 13:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmOl7qbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgEGNRx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 09:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726776AbgEGNRv (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 09:17:51 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCB9C05BD0B
        for <git@vger.kernel.org>; Thu,  7 May 2020 06:17:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v12so5028186wrp.12
        for <git@vger.kernel.org>; Thu, 07 May 2020 06:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vBH8GHoad1DqQohZ1/l1O0nAKoJlvUeNDjY0kA+rhC4=;
        b=JmOl7qbvunF4WLEC+LZC2+O6BsF7Ke3/E5w+svMZx18uHj6b41+L0vijz6XEmFCocQ
         1Mz+gARViKvU7H4raQ0nl8+y9Kykem/yWk5hihRXqTAby7/6+H/PsUNw1TJ5/w/fRAAs
         UW4TBNL3MJ5yjOaUcpkSKCl38uhO3cYEmLfX97aiLcZEloy3hvKldrEDjK9UVAHGhDgq
         XQ6Q0INVVsuVdkQnK2SL32T1nw+g1B+fXQteG5+Jsa1kYAUAJ8YfhdHLTNCEEi+cNX9a
         n5/r9c9NiZ7oeAWseZNXPXt9EdR33BYHgMz1bnGPNHwtM1jm7fS6cURavgWsNdp4Uoc3
         nqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vBH8GHoad1DqQohZ1/l1O0nAKoJlvUeNDjY0kA+rhC4=;
        b=MAwg/Lmq3ynUvicEYtnXQ08UTRCxOA8FxKJQ9+wzSgqnYnWfyC8ixYPftkfKqJdqZF
         5Hh6H8IP7DBSCc145ZMVQ4bKOKGe2ekohcFrZwgW31gsU1WNsAmzVsus0PQ8EHPcRg88
         ikys232ZUEVIlhSkQu5POQKcAZw3AY79EP2icdpNPDD91LNoeVgLV+e8x6vod9hEWtLE
         UumEi2QZHxzzaRBdAO8RiZ+PvZ4ZrrUZSc2Eo5vk5qN4FqpskixogaZBVtPhlkkH9sUP
         RS/3DgsRCOjQ8/e8Ubz7KS/VotFM7uqQLQ9ddWWnNlfkJ/NwnQ7HG7nWTgitD2+5oqSx
         C7xQ==
X-Gm-Message-State: AGi0PuZmqITFX7QYZeoPHALheN0FN7kjuEZL2avSQyS3d6O2b2C5RfOP
        dauanjcpwaMNxZqKsdpycf1GoEgj
X-Google-Smtp-Source: APiQypIgTvGMKEz6sl9HH5RCIXXHFgrPbooYo2mtGh6nZHEr8bqA2Cl1SbFkKe2uV3ThCkN6blwN9w==
X-Received: by 2002:adf:e802:: with SMTP id o2mr13655923wrm.110.1588857469130;
        Thu, 07 May 2020 06:17:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm8079025wrm.64.2020.05.07.06.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 06:17:48 -0700 (PDT)
Message-Id: <f55cd0fb3897db9ca22156347293ca830cdf018c.1588857462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.627.git.1588857462.gitgitgadget@gmail.com>
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 May 2020 13:17:39 +0000
Subject: [PATCH 07/10] sparse-checkout: define in-tree dependencies
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmaill.com, peff@peff.net, me@ttaylorr.com,
        jrnieder@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

As mentioned in the definition of the in-tree sparse-checkout
definitions, a large repository could have many different roles for the
users of that repository. That means that many different in-tree
sparse-checkout definitions need to exist. If a directory needs to be
added to many of these roles, then many of these files need to be
edited. This is too much work to scale properly.

Instead, let's make these definitions easier to maintain by following
basic principles of build dependencies. Add simple links between these
in-tree files using the new "sparse.inherit" config key. This multi-
valued config setting specifies more files that are needed to define the
sparse-checkout for a role. By separating out the common directories
into a base file, the more specialized roles can focus their files on
the directories only needed by those roles and leave the common
directories to that base file.

For example, suppose that .sparse/base has the following data:

	[sparse]
		dir = A
		dir = B/C
		dir = D/E/F

and .sparse/extra has the following data:

	[sparse]
		dir = D
		dir = X
		inherit = .sparse/base

Now, a user can run "git sparse-checkout set --in-tree .sparse/extra"
and the resulting directories will define their cone-mode
sparse-checkout patterns:

	A
	B/C
	D
	X

Thus, the resulting sparse-checkout definition is the union of the
definitions from .sparse/base and .sparse/extra, but the user only has
one value of sparse.inTree of ".sparse/extra".

It is simple to modify our existing logic to explore the directed graph
created by the sparse.inherit values. We simply need to append to the
string_list containing the list of in-tree files. Since we never repeat
parsing on the same blob oid, this will not lead to infinite loops or
exponential blowups in the parsing time.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt | 26 ++++++++++++++++++++++
 sparse-checkout.c                     | 27 ++++++++++++++++++-----
 sparse-checkout.h                     |  1 +
 t/t1091-sparse-checkout-builtin.sh    | 31 +++++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index c1713ebb1d2..941658e0011 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -238,6 +238,32 @@ definition according to the files available at the new commit. If any of
 the specified files do not exist at the new commit, then the sparse-checkout
 definition will not change.
 
+In a very large repository, there may be need to have multiple of these
+in-tree sparse-checkout definitions to fit the roles of multiple types of
+users. As each definition grows and the number of user types grow, it can
+be difficult to manage updating all of the definitions when a common core
+is modified somehow. For this reason, the in-tree pattern sets can inherit
+the directories from other in-tree pattern sets. Use the `sparse.inherit`
+option to specify other files in the tree.
+
+For example, suppose the file listed earlier is at `.sparse/core`. Another
+file could be stored as `.sparse/extra` with contents
+
+----------------------------------
+[sparse]
+	dir = X
+	dir = Y/Z
+	inherit = .sparse/core
+----------------------------------
+
+Then, if you run `git sparse-checkout set --in-tree .sparse/extra`, the
+sparse-checkout definition will include `X` and `Y/Z` from `.sparse/extra`
+as well as `A`, `B/C`, and `D/E/F` from `.sparse/core`. This is similar
+to specifying both `.sparse/core` and `.sparse/extra` in the `set`
+subcommand, but has a slight advantage. If the `.sparse/extra` file changes
+the set of `inherit` files, then your sparse-checkout definition will
+update accordingly as you switch between commits.
+
 
 SUBMODULES
 ----------
diff --git a/sparse-checkout.c b/sparse-checkout.c
index d01f4d7b525..4edeab49a10 100644
--- a/sparse-checkout.c
+++ b/sparse-checkout.c
@@ -66,12 +66,29 @@ static int sparse_dir_cb(const char *var, const char *value, void *data)
 	return 0;
 }
 
+static int sparse_inherit_cb(const char *var, const char *value, void *data)
+{
+	struct string_list *sl = (struct string_list *)data;
+
+	if (!strcmp(var, SPARSE_CHECKOUT_INHERIT))
+		string_list_append(sl, value);
+
+	return 0;
+}
+
 static int load_in_tree_from_blob(struct pattern_list *pl,
-				  struct object_id *oid)
+				  struct object_id *oid,
+				  struct string_list *inherit)
 {
-	return git_config_from_blob_oid(sparse_dir_cb,
-					SPARSE_CHECKOUT_DIR,
-					oid, pl);
+	if (git_config_from_blob_oid(sparse_dir_cb,
+				     SPARSE_CHECKOUT_DIR,
+				     oid, pl))
+		return 1;
+	if (git_config_from_blob_oid(sparse_inherit_cb,
+				     SPARSE_CHECKOUT_INHERIT,
+				     oid, inherit))
+		return 1;
+	return 0;
 }
 
 int load_in_tree_pattern_list(struct repository *r,
@@ -121,7 +138,7 @@ int load_in_tree_pattern_list(struct repository *r,
 			goto cleanup;
 		}
 
-		load_in_tree_from_blob(pl, oid);
+		load_in_tree_from_blob(pl, oid, sl);
 	}
 
 cleanup:
diff --git a/sparse-checkout.h b/sparse-checkout.h
index fb0ba48524a..8b766ea38fb 100644
--- a/sparse-checkout.h
+++ b/sparse-checkout.h
@@ -5,6 +5,7 @@
 #include "repository.h"
 
 #define SPARSE_CHECKOUT_DIR "sparse.dir"
+#define SPARSE_CHECKOUT_INHERIT "sparse.inherit"
 #define SPARSE_CHECKOUT_IN_TREE "sparse.intree"
 
 struct pattern_list;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index fdaafba5377..b2389e5b5e6 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -716,4 +716,35 @@ test_expect_success 'keep definition when in-tree file is missing' '
 	test_path_is_dir repo/.sparse
 '
 
+test_expect_success 'inherit definition from other files' '
+	cat >repo/.sparse/inherit <<-EOF &&
+	[sparse]
+		inherit = .sparse/sparse
+		inherit = .sparse/deep
+		inherit = .sparse/deeper1
+	EOF
+	git -C repo add .sparse &&
+	git -C repo commit -m "Add inherited file" &&
+	git -C repo sparse-checkout set --in-tree .sparse/inherit &&
+	check_files repo a deep folder1 &&
+	check_files repo/deep a deeper1 deeper2 &&
+	test_path_is_dir repo/.sparse &&
+	cat >repo/.sparse/sparse <<-EOF &&
+	[sparse]
+		dir = .sparse
+	EOF
+	git -C repo commit -a -m "drop folder1 from sparse" &&
+	check_files repo a deep &&
+	check_files repo/deep a deeper1 deeper2 &&
+	test_path_is_dir repo/.sparse
+'
+
+test_expect_success 'inherit files can have cycles' '
+	echo "\tinherit = .sparse/inherit" >>repo/.sparse/sparse &&
+	git -C repo commit -a -m "create inherit cycle" &&
+	check_files repo a deep &&
+	check_files repo/deep a deeper1 deeper2 &&
+	test_path_is_dir repo/.sparse
+'
+
 test_done
-- 
gitgitgadget


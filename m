Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 073781F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfHQSmK (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 14:42:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36043 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfHQSmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:42:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so4591015pgm.3
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LBkj3NMQq0zQs0xakJ9FWCnbbLrRMRMSBvog15+djNU=;
        b=maxqp/yKgkxT51q35a3vqlwV9HzpXWWMmTqbpdhSVyAIKPAkwnvsC2gb6sFdBXaDi2
         +ZSEMKxTttuvnCmpiC3PrlJrup9h0Z1BppwAh3vLMn8+Ld9EzQ3axDByAFa/5VFk56ER
         1qV4GtEqcVWE8kEjZAqrLHIHLJPzjXqJHGeMxsvIzzpppLPT76KVKHkfw5VCv33gIFTs
         nLVD/cWtKRFTWWd0nTt9md1Q+r6XJqFurIzEunYXC33baRwoTv01PwvqD1eg9PnAtjSD
         +d5o9XFOBWjFkDyk8SFcmHCZlXH5FxbBVrSRRXPCnfRmxVHWscYRt4HVXIKGYbsnPc6L
         tpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LBkj3NMQq0zQs0xakJ9FWCnbbLrRMRMSBvog15+djNU=;
        b=Pz9oQATCZZLRr/cKcXbZNp/z+icNKcMi0X8jgmMWh7kX3kpeZsUp/96a1Vj0oyfvfU
         YHS7DLH6d6BPh8zozaWqKtR4IbjXS2tI2zOUkGVqBj2AN/uFomyh/lAE+ctdYFWMP0MJ
         FrMG6m0ERNJDHsjJBCtHU5oUY22s1jNoAj2mk/IaR42FYAAZ3e/oit17xJQK/p0kI8kW
         +V/HwoWFn/qhs7P90sSXw9yHUVx1i1hNGKflEyAXinCnvGx6PaPieJ3xjgnCLlP1uj+h
         jClSSh9I2QfzdyHENM2zKhPsiNAknWbGCBj3mQ0CIcERWFzbIt3luPJIPHfEFxwWcQ/A
         p+VA==
X-Gm-Message-State: APjAAAVLQiKRB0rv6GIjsSC6dcCp/zbvbYgoYZ1ZPtjyqa/8W6sq6rY/
        v0W79dRoWwPm3tcGe3KpFOHGceAz
X-Google-Smtp-Source: APXvYqy4NTwWa3PXG558+8XB31Zy0Fg2CeeAqsBdnSKasfmT/n/iPxgxoHN2zZ/dMDqg8OjUTlki5A==
X-Received: by 2002:a63:2148:: with SMTP id s8mr12705259pgm.336.1566067327589;
        Sat, 17 Aug 2019 11:42:07 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j15sm9990422pfr.146.2019.08.17.11.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 11:42:07 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 08/24] Ensure index matches head before invoking merge machinery, round N
Date:   Sat, 17 Aug 2019 11:41:28 -0700
Message-Id: <20190817184144.32179-9-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.28.g5f89f15d7b.dirty
In-Reply-To: <20190817184144.32179-1-newren@gmail.com>
References: <20190815214053.16594-1-newren@gmail.com>
 <20190817184144.32179-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the bug that just won't die; there always seems to be another
form of it somewhere.  See the commit message of 55f39cf7551b ("merge:
fix misleading pre-merge check documentation", 2018-06-30) for a more
detailed explanation), but in short:

<quick summary>

builtin/merge.c contains this important requirement for merge
strategies:

    ...the index must be in sync with the head commit.  The strategies are
    responsible to ensure this.

This condition is important to enforce because there are two likely
failure cases when the index isn't in sync with the head commit:

  * we silently throw away changes the user had staged before the merge

  * we accidentally (and silently) include changes in the merge that
    were not part of either of the branches/trees being merged

Discarding users' work and mis-merging are both bad outcomes, especially
when done silently, so naturally this rule was stated sternly -- but,
unfortunately totally ignored in practice unless and until actual bugs
were found.  But, fear not: the bugs from this were fixed in commit
  ee6566e8d70d ("[PATCH] Rewrite read-tree", 2005-09-05)
through a rewrite of read-tree (again, commit 55f39cf7551b has a more
detailed explanation of how this affected merge).  And it was fixed
again in commit
  160252f81626 ("git-merge-ours: make sure our index matches HEAD", 2005-11-03)
...and it was fixed again in commit
  3ec62ad9ffba ("merge-octopus: abort if index does not match HEAD", 2016-04-09)
...and again in commit
  65170c07d466 ("merge-recursive: avoid incorporating uncommitted changes in a merge", 2017-12-21)
...and again in commit
  eddd1a411d93 ("merge-recursive: enforce rule that index matches head before merging", 2018-06-30)

...with multiple testcases added to the testsuite that could be
enumerated in even more commits.

Then, finally, in a patch in the same series as the last fix above, the
documentation about this requirement was fixed in commit 55f39cf7551b
("merge: fix misleading pre-merge check documentation", 2018-06-30), and
we all lived happily ever after...

</quick summary>

Unfortunately, "ever after" apparently denotes a limited time and it
expired today.  The merge-recursive rule to enforce that index matches
head was at the beginning of merge_trees() and would only trigger when
opt->call_depth was 0.  Since merge_recursive() doesn't call
merge_trees() until after returning from recursing, this meant that the
check wasn't triggered by merge_recursive() until it had first finished
all the intermediate merges to create virtual merge bases.  That is a
potentially HUGE amount of computation (and writing of intermediate
merge results into the .git/objects directory) before it errors out and
says, in effect, "Sorry, I can't do any merging because you have some
local changes that would be overwritten."

Trying to enforce that all of merge_trees(), merge_recursive(), and
merge_recursive_generic() checked the index == head condition earlier
resulted in a bunch of broken tests.  It turns out that
merge_recursive() has code to drop and reload the cache while recursing
to create intermediate virtual merge bases, but unfortunately that code
runs even when no recursion is necessary.  This unconditional dropping
and reloading of the cache masked a few bugs:

  * builtin/merge-recursive.c: didn't even bother loading the index.

  * builtin/stash.c: feels like a fake 'builtin' because it repeatedly
    invokes git subprocesses all over the place, mixed with other
    operations.  In particular, invoking "git reset" will reset the
    index on disk, but the parent process that invoked it won't
    automatically have its in-memory index updated.

  * t3030-merge-recursive.h: this test has always been broken in that it
    didn't make sure to make index match head before running.  But, it
    didn't care about the index or even the merge result, just the
    verbose output while running.  While commit eddd1a411d93
    ("merge-recursive: enforce rule that index matches head before
    merging", 2018-06-30) should have uncovered this broken test, it
    used a test_must_fail wrapper around the merge-recursive call
    because it was known that the merge resulted in a rename/rename
    conflict.  Thus, that fix only made this test fail for a different
    reason, and since the index == head check didn't happen until after
    coming all the way back out of the recursion, the testcase had
    enough information to pass the one check that it did perform.

So, load the index in builtin/merge-recursive.c, reload the in-memory
index in builtin/stash.c, and modify the t3030 testcase to correctly
setup the index and make sure that the test fails in the expected way
(meaning it reports a rename/rename conflict).  This makes sure that
all callers actually make the index match head.  The next commit will
then enforce the condition that index matches head earlier so this
problem doesn't return in the future.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge-recursive.c  | 4 ++++
 builtin/stash.c            | 2 ++
 t/t3030-merge-recursive.sh | 9 ++++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index 5b910e351e..a4bfd8fc51 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -1,3 +1,4 @@
+#include "cache.h"
 #include "builtin.h"
 #include "commit.h"
 #include "tag.h"
@@ -63,6 +64,9 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	if (argc - i != 3) /* "--" "<head>" "<remote>" */
 		die(_("not handling anything other than two heads merge."));
 
+	if (repo_read_index_unmerged(the_repository))
+		die_resolve_conflict("merge");
+
 	o.branch1 = argv[++i];
 	o.branch2 = argv[++i];
 
diff --git a/builtin/stash.c b/builtin/stash.c
index b5a301f24d..4aa47785f9 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -427,6 +427,8 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 				return error(_("could not save index tree"));
 
 			reset_head();
+			discard_cache();
+			read_cache();
 		}
 	}
 
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index ff641b348a..a37bcc58a0 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -667,15 +667,22 @@ test_expect_success 'merging with triple rename across D/F conflict' '
 test_expect_success 'merge-recursive remembers the names of all base trees' '
 	git reset --hard HEAD &&
 
+	# make the index match $c1 so that merge-recursive below does not
+	# fail early
+	git diff --binary HEAD $c1 -- | git apply --cached &&
+
 	# more trees than static slots used by oid_to_hex()
 	for commit in $c0 $c2 $c4 $c5 $c6 $c7
 	do
 		git rev-parse "$commit^{tree}"
 	done >trees &&
 
-	# ignore the return code -- it only fails because the input is weird
+	# ignore the return code; it only fails because the input is weird...
 	test_must_fail git -c merge.verbosity=5 merge-recursive $(cat trees) -- $c1 $c3 >out &&
 
+	# ...but make sure it fails in the expected way
+	test_i18ngrep CONFLICT.*rename/rename out &&
+
 	# merge-recursive prints in reverse order, but we do not care
 	sort <trees >expect &&
 	sed -n "s/^virtual //p" out | sort >actual &&
-- 
2.23.0.rc2.28.g5f89f15d7b.dirty


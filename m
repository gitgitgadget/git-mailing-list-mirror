Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E12E20376
	for <e@80x24.org>; Thu,  9 Mar 2017 22:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753528AbdCIWQE (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:16:04 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34882 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753324AbdCIWQD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:16:03 -0500
Received: by mail-pf0-f179.google.com with SMTP id j5so33707908pfb.2
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 14:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SzTm4eJdRWZWcsX/obkNX2KYdcUaJ+l1G5Y0r1WAHTg=;
        b=SRcAG3eTwSTmJN1I5GXGsF/jMvg2SrQEQ3NsrWuz3Dd3bJf90bMNE3e7IvLKdK1UDq
         aXOa46yXT7Pe76FGnzW4qCUyHLbKqNwkKc1GYBweqR746OacFdkEWbgIb+6GQEt0MCS0
         ZTQJvg7HYwmWfyxH8By5BavPknlQ8dDRr3cSMZ08e6HhSS9ho+82HB+oomRJ1y9V2Ads
         cfsiaqz1mdky1toyOsALqeDnJMOWGq2ZbH8IuZFQ4D+MypxKeefPZcXdNW5qPlzyWj+I
         6W0aQ6yEWMIMwR50j1N22wQm1jJu+vjGiylExcSPNKZXiqSWoI1ntkphcCI1tkHgDGmw
         5LnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SzTm4eJdRWZWcsX/obkNX2KYdcUaJ+l1G5Y0r1WAHTg=;
        b=lQyxokYEnTcccmkBx+ycohmX9fDi0Gbr3lqyVAVrxMkLIXDRxupsmLZJQ317ZWShNq
         56Q4Rw2s5nR3BH5x1i6ix2F3pOdtVn/pEpkxz5HQWCWqGWM0Nz10L75AKoBjpA77UJ43
         hjYChwu3qrH42Z6w4z8NZvXXf66fk8+MxtHl1b5CWrP88n+16Dw0b1Gs9xYNmDAXr8DV
         m6Anh1YUJjOTVW1NngJZlfd25YE2mHjOoX+6gv5Wi9tl9G0DbQd91V6dMha9gtyVv5wm
         s6eV4KdyT1pESuz3dj+Izn882mzp5LzdcuDYigODUYyTsqMFuyebDMm44L3nhJO6JSQA
         jEqw==
X-Gm-Message-State: AMke39n+OJljaeILCQMdt5DiRu8qHMoNc2fhDcI+XyUz77rSdr6MkjU22XCHyO3gwju0c1Yt
X-Received: by 10.84.128.65 with SMTP id 59mr20532040pla.167.1489097756527;
        Thu, 09 Mar 2017 14:15:56 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:7494:19e8:830b:a2d7])
        by smtp.gmail.com with ESMTPSA id 15sm14438124pgh.21.2017.03.09.14.15.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 14:15:55 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [RFCv8 PATCH 00/17] Checkout aware of Submodules!
Date:   Thu,  9 Mar 2017 14:15:26 -0800
Message-Id: <20170309221543.15897-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.45.gf291f29c2e
In-Reply-To: <20170306205919.9713-1-sbeller@google.com>
References: <20170306205919.9713-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

previous work:
https://public-inbox.org/git/20170306205919.9713-1-sbeller@google.com/

v8:
 * Thanks Ramsay; another variable is static now!
 * Thanks Junio; fixed typos (in comments and commit messages)!
 * dropped the patch touching read-cache.c; I realized it is bogus after
   inspecting it and trying to write a commit message.
 * All commits have commit messages now.
 * diff to Junios version below.
 
v7:
 * addressed Erics comment by fixing the bashism in t/lib-submodule-update.sh
diff to v6:
  diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
  index 5caae06bc5..949ebd546c 100755
  --- a/t/lib-submodule-update.sh
  +++ b/t/lib-submodule-update.sh
  @@ -255,7 +255,7 @@ test_superproject_content () {
   # Test that the given submodule at path "$1" contains the content according
   # to the submodule commit recorded in the superproject's commit "$2"
   test_submodule_content () {
  -       if test "$1" == "-C"
  +       if test x"$1" = "x-C"
          then
                  cd "$2"
                  shift; shift;
 * interdiff to v5 below
                  

v6:
 * added support for read-tree (see last patch) to see how generic the
   code of the previous patches is. I am pretty pleased with that patch.
 * marked two functions static. Thanks Ramsay!
 * fixed the recursive test; it still fails but it is the code that fails,
   not the test. For this I had to change the setup code slightly.
 * 2 new patches adding tiny refactoring to the submodule test lib.  
 * interdiff (to origin/sb/checkout-recurse-submodules, which is v5) below.

v5:
 * as v4 was the first version queued by Junio, we do have an interdiff below!
 * renamed functions
 * changed the API, now the caller has to take care of the submodule strategy
   themselves. (Note this can be different for different situations, e.g.
   when a submodule is deleted, we can do that for any strategy except none and
   !command. But for moving to a new state of the submodule we currently
   only implement "checkout" [unspecified defaults to checkout]. warning about
   the others, doing nothing there.)

v4:
 * addressed all comments of Brian, Junio and Brandon.
 Thanks!
 * one major point of change is the introduction of another patch
   "lib-submodule-update.sh: do not use ./. as submodule remote",
   as that took some time to track down the existing bug.
 
v3:
 * moved tests from t2013 to the generic submodule library.
 * factored out the refactoring patches to be up front
 * As I redid the complete implementation, I have the impression this time
   it is cleaner than previous versions.
 
 I think we still have to fix the corner cases of directory/file/submodule 
 conflicts before merging, but this serves as a status update on my current
 way of thinking how to implement the worktree commands being aware of
 submodules.
 
Thanks,
Stefan

v2:
* based on top of the series sent out an hour ago
  "[PATCHv4 0/5] submodule embedgitdirs"
* Try to embed a submodule if we need to remove it.
* Strictly do not change behavior if not giving the new flag.
* I think I missed some review comments from v1, but I'd like to get
  the current state out over the weekend, as a lot has changed so far.
  On Monday I'll go through the previous discussion with a comb to see
  if I missed something.
  
v1:
When working with submodules, nearly anytime after checking out
a different state of the projects, that has submodules changed
you'd run "git submodule update" with a current version of Git.

There are two problems with this approach:

* The "submodule update" command is dangerous as it
  doesn't check for work that may be lost in the submodule
  (e.g. a dangling commit).
* you may forget to run the command as checkout is supposed
  to do all the work for you.

Integrate updating the submodules into git checkout, with the same
safety promises that git-checkout has, i.e. not throw away data unless
asked to. This is done by first checking if the submodule is at the same
sha1 as it is recorded in the superproject. If there are changes we stop
proceeding the checkout just like it is when checking out a file that
has local changes.

The integration happens in the code that is also used in other commands
such that it will be easier in the future to make other commands aware
of submodule.

This also solves d/f conflicts in case you replace a file/directory
with a submodule or vice versa.

The patches are still a bit rough, but the overall series seems
promising enough to me that I want to put it out here.

Any review, specifically on the design level welcome!

Thanks,
Stefan
  
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 2dc5cc06da..23e212ee8c 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -21,7 +21,7 @@
 static int nr_trees;
 static int read_empty;
 static struct tree *trees[MAX_UNPACK_TREES];
-int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 
 static int list_tree(unsigned char *sha1)
 {
diff --git a/read-cache.c b/read-cache.c
index 9a2abacf7a..9054369dd0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -18,8 +18,6 @@
 #include "varint.h"
 #include "split-index.h"
 #include "utf8.h"
-#include "submodule.h"
-#include "submodule-config.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -522,22 +520,6 @@ int remove_index_entry_at(struct index_state *istate, int pos)
 	return 1;
 }
 
-static void remove_submodule_according_to_strategy(const struct submodule *sub)
-{
-	switch (sub->update_strategy.type) {
-	case SM_UPDATE_UNSPECIFIED:
-	case SM_UPDATE_CHECKOUT:
-	case SM_UPDATE_REBASE:
-	case SM_UPDATE_MERGE:
-		submodule_move_head(sub->path, "HEAD", NULL, \
-				    SUBMODULE_MOVE_HEAD_FORCE);
-		break;
-	case SM_UPDATE_NONE:
-	case SM_UPDATE_COMMAND:
-		; /* Do not touch the submodule. */
-	}
-}
-
 /*
  * Remove all cache entries marked for removal, that is where
  * CE_REMOVE is set in ce_flags.  This is much more effective than
@@ -550,13 +532,8 @@ void remove_marked_cache_entries(struct index_state *istate)
 
 	for (i = j = 0; i < istate->cache_nr; i++) {
 		if (ce_array[i]->ce_flags & CE_REMOVE) {
-			const struct submodule *sub = submodule_from_ce(ce_array[i]);
-			if (sub) {
-				remove_submodule_according_to_strategy(sub);
-			} else {
-				remove_name_hash(istate, ce_array[i]);
-				save_or_free_index_entry(istate, ce_array[i]);
-			}
+			remove_name_hash(istate, ce_array[i]);
+			save_or_free_index_entry(istate, ce_array[i]);
 		}
 		else
 			ce_array[j++] = ce_array[i];
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 949ebd546c..e195b590a1 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -954,7 +954,7 @@ test_submodule_switch_recursing () {
 		)
 	'
 
-	# ... and ignored files are ignroed
+	# ... and ignored files are ignored
 	test_expect_success "$command: replace submodule with a file works ignores ignored files in submodule" '
 		test_when_finished "rm submodule_update/.git/modules/sub1/info/exclude" &&
 		prolog &&

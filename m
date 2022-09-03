Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E62DECAAA1
	for <git@archiver.kernel.org>; Sat,  3 Sep 2022 00:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiICAiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 20:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiICAiS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 20:38:18 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5448F94F
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 17:38:17 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-11eb8b133fbso8896115fac.0
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 17:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=fmDeb9ARZt2QtFz1w76b5lE7Z0lbvSOrqqflQ8w1OBU=;
        b=m70lCsAzCQAE4k0WFLyvSuQVNC7O70vbvkGOis0JQSqd3yicCYjQhGADvUBYsHI3fx
         FBU7UNaMycqAebBS6wWOu0315jQFqfUNsCCTxIco2aqkDtQsi6gX+qlBxKLh7OZgghES
         6KVCfB6qfWZsTa8MUoiunrIsAkP80BVFUAcUodO30rKD7XDkHcvgHVWWvVLQgLx1eIFY
         AVXMwpg0gfWokDIcTjRu/RASY1pAcMq44lXO22rJ2aNfsnUmAlvKm8iErkomblJyYSxN
         d0pZR8xkBxogwPKGkmBcd4NkwDJOJJWIdVl5hEqJGWplre47afzPmieQAgBRAv2cIh73
         MWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fmDeb9ARZt2QtFz1w76b5lE7Z0lbvSOrqqflQ8w1OBU=;
        b=MG1RAdM3/HYWGkdE7Jz9jkanSfmd/m7M4nm11v8ClPLYUqT7NB9kPVLupzpZ/mM52Y
         /Fn4/n5NTb2UB6Srf1DLryJLKhaLjBm1tUlzj5lcUrX3DiLrIOvA8jUFmzpNXtIxek2q
         axf0zOEG4kn9DTbU/n/Ij2xcyuZPafj2VpdZ7rJAimp4fuaC3YkibICG6ikPuSH8gNFU
         vgtGzZJcpXSRIWPVZLrZuzCc7nmKgf/Fd2pyxDwC0HBzOfy5Quglxx2zlAJMLwikt+Mm
         pK63P4Ic30slsvWqJD+dQt3W2HQFkGRdleY13gEgScQ82xwsjn1eOb2zXB/EVRtnkX0s
         UCvQ==
X-Gm-Message-State: ACgBeo0c8TWzlgScqm4Dkng88NI7CNBYt/96d1dV09FDJcUAzU19lFHB
        gwWVjEqisqE3nj0AIxymS4imc8QPXUk=
X-Google-Smtp-Source: AA6agR4008ZVE2xuvuVX/cHijANC9dM2ojrscXHThdvHYdwr+yutchQl+MJxALwHpcexz0l01YuQDw==
X-Received: by 2002:a05:6870:5705:b0:11e:553:1a6f with SMTP id k5-20020a056870570500b0011e05531a6fmr3635616oap.97.1662165496090;
        Fri, 02 Sep 2022 17:38:16 -0700 (PDT)
Received: from ffyuanda.localdomain (99-110-131-145.lightspeed.irvnca.sbcglobal.net. [99.110.131.145])
        by smtp.gmail.com with ESMTPSA id n6-20020a4ad626000000b00435785e7b49sm1172472oon.19.2022.09.02.17.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 17:38:15 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v4 0/3] grep: integrate with sparse index
Date:   Fri,  2 Sep 2022 17:36:20 -0700
Message-Id: <20220903003623.64750-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Integrate `git-grep` with sparse-index and test the performance
improvement.

Changes since v3
----------------
* Shorten the perf result tables in commit message.

* Update the commit message to reflect the changes in the commit.

* Update the commit message to indicate the performance improvement
  is dependent on the pathspec.

* Stop passing `ce_mode` through `check_attr`. Instead, set the
  `base_len` to 0 to make the code more reasonable and less abuse of
  `check_attr`.

* Remove another invention of `base`. Use the existing `name` as the
  argument for `grep_tree()`, and reset it back to `ce->name` after
  `grep_tree()` returns.

* Update the p2000 test to use a more general pathspec for better
  compatibility (i.e. do not use git repository specific pathspec).

* Add tests to t1092 'grep is not expanded' to verify the change
  brought by "builtin/grep.c: walking tree instead of expanding index
  with --sparse": the index *never* expands.

Changes since v2
----------------

* Modify the commit message for "builtin/grep.c: integrate with sparse
  index" to make it obvious that the perf test results are not from
  p2000 tests, but from manual perf runs.

* Add tree-walking logic as an extra (the third) patch to improve the
  performance when --sparse is used. This resolved the left-over-bit
  in v2 [1].

[1] https://lore.kernel.org/git/20220829232843.183711-1-shaoxuan.yuan02@gmail.com/

Changes since v1
----------------

* Rewrite the commit message for "builtin/grep.c: add --sparse option"
  to be clearer.

* Update the documentation (both in-code and man page) for --sparse.

* Add a few tests to test the new behavior (when _only_ --cached is
  supplied).

* Reformat the perf test results to not look like directly from p2000
  tests.

* Put the "command_requires_full_index" lines right after parse_options().

* Add a pathspec test in t1092, and reword a few test documentations.

Shaoxuan Yuan (3):
  builtin/grep.c: add --sparse option
  builtin/grep.c: integrate with sparse index
  builtin/grep.c: walking tree instead of expanding index with --sparse

 Documentation/git-grep.txt               |  5 +++-
 builtin/grep.c                           | 31 ++++++++++++++++++---
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 26 ++++++++++++++++++
 t/t7817-grep-sparse-checkout.sh          | 34 +++++++++++++++++++-----
 5 files changed, 86 insertions(+), 11 deletions(-)

Range-diff against v3:
1:  1fa8c62d95 ! 1:  f1d8271a9b builtin/grep.c: add --sparse option
    @@ Commit message
         inspects paths outside of the sparse-checkout definition when paired
         with the '--cached' option.
     
    -    Helped-by: Derrick Stolee <derrickstolee@github.com>
         Suggested-by: Victoria Dye <vdye@github.com>
    +    Helped-by: Derrick Stolee <derrickstolee@github.com>
    +    Helped-by: Victoria Dye <vdye@github.com>
         Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
     
      ## Documentation/git-grep.txt ##
2:  ce4fba3c35 ! 2:  7aa4b8bc81 builtin/grep.c: integrate with sparse index
    @@ Commit message
         are then extracted from the time difference between "region_enter" and
         "region_leave" of label "do_read_index".
     
    +    Helped-by: Victoria Dye <vdye@github.com>
         Helped-by: Derrick Stolee <derrickstolee@github.com>
         Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
     
3:  240883aa11 ! 3:  6a2e753a19 builtin/grep.c: walking tree instead of expanding index with --sparse
    @@ Commit message
     
         - Summary:
     
    -    p2000 tests demonstrate a ~91% execution time reduction for
    -    `git grep --cached --sparse <pattern> -- <pathspec>` using tree-walking
    -    logic.
    -
    -    Test                                                                          HEAD~   HEAD
    -    ---------------------------------------------------------------------------------------------------
    -    2000.78: git grep --cached --sparse bogus -- f2/f1/f1/builtin/* (full-v3)     0.11    0.09 (≈)
    -    2000.79: git grep --cached --sparse bogus -- f2/f1/f1/builtin/* (full-v4)     0.08    0.09 (≈)
    -    2000.80: git grep --cached --sparse bogus -- f2/f1/f1/builtin/* (sparse-v3)   0.44    0.04 (-90.9%)
    -    2000.81: git grep --cached --sparse bogus -- f2/f1/f1/builtin/* (sparse-v4)   0.46    0.04 (-91.3%)
    +    p2000 tests demonstrate a ~71% execution time reduction for
    +    `git grep --cached --sparse bogus -- "f2/f1/f1/*"` using tree-walking
    +    logic. However, notice that this result varies depending on the pathspec
    +    given. See below "Command used for testing" for more details.
    +
    +    Test                              HEAD~   HEAD
    +    -------------------------------------------------------
    +    2000.78: git grep ... (full-v3)   0.35    0.39 (≈)
    +    2000.79: git grep ... (full-v4)   0.36    0.30 (≈)
    +    2000.80: git grep ... (sparse-v3) 0.88    0.23 (-73.8%)
    +    2000.81: git grep ... (sparse-v4) 0.83    0.26 (-68.6%)
     
         - Command used for testing:
     
    -            git grep --cached --sparse bogus -- f2/f1/f1/builtin/*
    +            git grep --cached --sparse bogus -- "f2/f1/f1/*"
     
         The reason for specifying a pathspec is that, if we don't specify a
         pathspec, then grep_tree() will walk all the trees and blobs to find the
    @@ Commit message
         logic will only walk the area of trees enclosed by the pathspec, and the
         time consumed is reasonably a lot less.
     
    +    Generally speaking, because the performance gain is acheived by walking
    +    less trees, which are specified by the pathspec, the HEAD time v.s.
    +    HEAD~ time in sparse-v[3|4], should be proportional to
    +    "pathspec enclosed area" v.s. "all area", respectively. Namely, the
    +    wider the <pathspec> is encompassing, the less the performance
    +    difference between HEAD~ and HEAD, and vice versa.
    +
         That is, if we don't specify a pathspec, the performance difference [1]
    -    is quite small: both methods walk all the trees and take generally same
    -    amount of time (even with the index construction time included for
    +    is indistinguishable: both methods walk all the trees and take generally
    +    same amount of time (even with the index construction time included for
         ensure_full_index()).
     
    -    [1] Performance test result without pathspec:
    +    [1] Performance test result without pathspec (hence walking all trees):
    +
    +            Command used:
    +
    +                    git grep --cached --sparse bogus
     
    -            Test                                                    HEAD~  HEAD
    -            -----------------------------------------------------------------------------
    -            2000.78: git grep --cached --sparse bogus (full-v3)     6.17   5.19 (≈)
    -            2000.79: git grep --cached --sparse bogus (full-v4)     6.19   5.46 (≈)
    -            2000.80: git grep --cached --sparse bogus (sparse-v3)   6.57   6.44 (≈)
    -            2000.81: git grep --cached --sparse bogus (sparse-v4)   6.65   6.28 (≈)
    +            Test                                HEAD~  HEAD
    +            ---------------------------------------------------
    +            2000.78: git grep ... (full-v3)     6.17   5.19 (≈)
    +            2000.79: git grep ... (full-v4)     6.19   5.46 (≈)
    +            2000.80: git grep ... (sparse-v3)   6.57   6.44 (≈)
    +            2000.81: git grep ... (sparse-v4)   6.65   6.28 (≈)
     
         Suggested-by: Derrick Stolee <derrickstolee@github.com>
         Helped-by: Derrick Stolee <derrickstolee@github.com>
    @@ builtin/grep.c: static int grep_cache(struct grep_opt *opt,
     +			struct tree_desc tree;
     +			void *data;
     +			unsigned long size;
    -+			struct strbuf base = STRBUF_INIT;
    -+
    -+			strbuf_addstr(&base, ce->name);
     +
     +			data = read_object_file(&ce->oid, &type, &size);
     +			init_tree_desc(&tree, data, size);
      
     -		if (S_ISREG(ce->ce_mode) &&
    -+			/*
    -+			 * sneak in the ce_mode using check_attr parameter
    -+			 */
    -+			hit |= grep_tree(opt, pathspec, &tree, &base,
    -+					 base.len, ce->ce_mode);
    -+			strbuf_release(&base);
    ++			hit |= grep_tree(opt, pathspec, &tree, &name, 0, 0);
    ++			strbuf_reset(&name);
    ++			strbuf_addstr(&name, ce->name);
     +			free(data);
     +		} else if (S_ISREG(ce->ce_mode) &&
      		    match_pathspec(repo->index, pathspec, name.buf, name.len, 0, NULL,
      				   S_ISDIR(ce->ce_mode) ||
      				   S_ISGITLINK(ce->ce_mode))) {
    -@@ builtin/grep.c: static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
    - 		int te_len = tree_entry_len(&entry);
    - 
    - 		if (match != all_entries_interesting) {
    --			strbuf_addstr(&name, base->buf + tn_len);
    -+			if (S_ISSPARSEDIR(check_attr)) {
    -+				// object is a sparse directory entry
    -+				strbuf_addbuf(&name, base);
    -+			} else {
    -+				// object is a commit or a root tree
    -+				strbuf_addstr(&name, base->buf + tn_len);
    -+			}
    -+
    - 			match = tree_entry_interesting(repo->index,
    - 						       &entry, &name,
    - 						       0, pathspec);
     
      ## t/perf/p2000-sparse-operations.sh ##
     @@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git read-tree -mu HEAD
      test_perf_on_all git checkout-index -f --all
      test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
      test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
    -+test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/builtin/*"
    ++test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
    + 
    + test_done
    +
    + ## t/t1092-sparse-checkout-compatibility.sh ##
    +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'grep is not expanded' '
    + 
    + 	# All files within the folder1/* pathspec are sparse,
    + 	# so this command does not find any matches
    +-	ensure_not_expanded ! grep a -- folder1/*
    ++	ensure_not_expanded ! grep a -- folder1/* &&
    ++
    ++	# test out-of-cone pathspec with or without wildcard
    ++	ensure_not_expanded grep --sparse --cached a -- "folder1/a" &&
    ++	ensure_not_expanded grep --sparse --cached a -- "folder1/*" &&
    ++
    ++	# test in-cone pathspec with or without wildcard
    ++	ensure_not_expanded grep --sparse --cached a -- "deep/a" &&
    ++	ensure_not_expanded grep --sparse --cached a -- "deep/*"
    + '
      
      test_done

base-commit: be1a02a17ede4082a86dfbfee0f54f345e8b43ac
-- 
2.37.0


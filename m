Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2ABECAAD3
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 00:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiIHATs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 20:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiIHATo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 20:19:44 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D39D28E3F
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 17:19:42 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-127ba06d03fso16618813fac.3
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 17:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=CqVSJlCdppoX7LLWBoNX0E1o8ssoX81g8KidDUlMe2A=;
        b=hVq3y71/tQrnDpw1yhOviaE4BdatOvwq2QUYaqXedxEBpGoArQ6RZeG/VHe5gCsbeJ
         byKXHOl61EiZA5MGzTCnN1bGrLHlxxAPOQwPhfVt9bRXDwCj6GM1lXFcDxCbY2vHFLs8
         jcHyQdJ6hyEtG4a5DtVnupjnRYw5DN32KxC5kSiPqPjxZkiZ0Z+GlCwaRIEXPLIydMhD
         YKxseZrI3AN1oaQOfW52RlZr4OW2t7b00MMGi34DLOyVIt5OqgRqrb0F0mn8XZFjNmcu
         ypkPi7IxSWJE6QlPofSz2zK4G6xNP6NZW5d4JIYUEvnLj/ogpemSByI1nsSPKOiVDG7L
         s3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CqVSJlCdppoX7LLWBoNX0E1o8ssoX81g8KidDUlMe2A=;
        b=KtO3a3twLFg+Nu/qrB3F9A/MfuTMsq9cKFXH1vTsvhABIGYegn+9UHNdZh4KQK4kPj
         IHHhtjrMD6OvGVxhFHuN0tehxlrrG+7hQpT1XhPZn2AXsi0KAsFjN+P+sbTJUQh2T2kR
         SobnAtl6Kq5Fo/zXN4K+/idOLns8of05b94LDgqwUFQ4t6pAKCB6FOiYXsDrbHzF5rvA
         hYD4LGdm+9D8tzdB3hSp8HlTswZ0IPk5paLTHJuJYvUI/CTpIRAiG8PmWJhMab13PS1h
         JXZI2E1IfcbC4iWWLpbus6gMzup66ylHrIzo6dCooxeO38kQBOYZFA+kcknVs9ki/R7s
         wQ9w==
X-Gm-Message-State: ACgBeo23B0G6uAomTHHZwTjDClUfXbyIQiLmI+Blwp+kjUphCwdBTq5Q
        DmK5hhAwL4gpovrXw88ipQubZpNjz3k=
X-Google-Smtp-Source: AA6agR4dh4fmLrk9PftTtDyYVdkWdW+nLTIhMMgFEP29v5HjrWYwVONMAn5HONZEDX1gtxCMe0lHFw==
X-Received: by 2002:a05:6870:9124:b0:127:e8b3:f427 with SMTP id o36-20020a056870912400b00127e8b3f427mr507385oae.41.1662596381368;
        Wed, 07 Sep 2022 17:19:41 -0700 (PDT)
Received: from ffyuanda.localdomain (99-110-131-145.lightspeed.irvnca.sbcglobal.net. [99.110.131.145])
        by smtp.gmail.com with ESMTPSA id j95-20020a9d17e8000000b00638dd127f54sm7662091otj.1.2022.09.07.17.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 17:19:40 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     derrickstolee@github.com, vdye@github.com, git@vger.kernel.org,
        gitster@pobox.com
Subject: [PATCH v5 0/3] grep: integrate with sparse index
Date:   Wed,  7 Sep 2022 17:18:51 -0700
Message-Id: <20220908001854.206789-1-shaoxuan.yuan02@gmail.com>
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

Changes since v4
----------------
* Reset the length of `struct strbuf name` back to `name_base_len`,
  instead of 0, after `grep_tree()` returns.

* Add test cases in t1092 for `grep` recursing into submodules.

* Add a few NEEDSWORK to explain the current problem with submodules.

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

 Documentation/git-grep.txt               |  5 +-
 builtin/grep.c                           | 58 +++++++++++++++++--
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 72 ++++++++++++++++++++++++
 t/t7817-grep-sparse-checkout.sh          | 34 +++++++++--
 5 files changed, 159 insertions(+), 11 deletions(-)

Range-diff against v4:
1:  00a8b3a68e = 1:  c3d33e487c builtin/grep.c: add --sparse option
2:  3e0786722c = 2:  c5366f51b8 builtin/grep.c: integrate with sparse index
3:  81afe2fcb3 ! 3:  52bb802eae builtin/grep.c: walking tree instead of expanding index with --sparse
    @@ Commit message
                 2000.80: git grep ... (sparse-v3)   6.57   6.44 (≈)
                 2000.81: git grep ... (sparse-v4)   6.65   6.28 (≈)
     
    +    --------------------------
    +    NEEDSWORK about submodules
    +
    +    There are a few NEEDSWORKs that belong to improvements beyond this
    +    topic. See the NEEDSWORK in builtin/grep.c::grep_submodule() for
    +    more context. The other two NEEDSWORKs in t1092 are also relative.
    +
         Suggested-by: Derrick Stolee <derrickstolee@github.com>
         Helped-by: Derrick Stolee <derrickstolee@github.com>
         Helped-by: Victoria Dye <vdye@github.com>
         Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
     
      ## builtin/grep.c ##
    +@@ builtin/grep.c: static int grep_submodule(struct grep_opt *opt,
    + 	 * subrepo's odbs to the in-memory alternates list.
    + 	 */
    + 	obj_read_lock();
    ++
    ++	/*
    ++	 * NEEDSWORK: when reading a submodule, the sparsity settings in the
    ++	 * superproject are incorrectly forgotten or misused. For example:
    ++	 *
    ++	 * 1. "command_requires_full_index"
    ++	 * 	When this setting is turned on for `grep`, only the superproject
    ++	 *	knows it. All the submodules are read with their own configs
    ++	 *	and get prepare_repo_settings()'d. Therefore, these submodules
    ++	 *	"forget" the sparse-index feature switch. As a result, the index
    ++	 *	of these submodules are expanded unexpectedly.
    ++	 *
    ++	 * 2. "core_apply_sparse_checkout"
    ++	 *	When running `grep` in the superproject, this setting is
    ++	 *	populated using the superproject's configs. However, once
    ++	 *	initialized, this config is globally accessible and is read by
    ++	 *	prepare_repo_settings() for the submodules. For instance, if a
    ++	 *	submodule is using a sparse-checkout, however, the superproject
    ++	 *	is not, the result is that the config from the superproject will
    ++	 *	dictate the behavior for the submodule, making it "forget" its
    ++	 *	sparse-checkout state.
    ++	 *
    ++	 * 3. "core_sparse_checkout_cone"
    ++	 *	ditto.
    ++	 *
    ++	 * Note that this list is not exhaustive.
    ++	 */
    + 	repo_read_gitmodules(subrepo, 0);
    + 
    + 	/*
     @@ builtin/grep.c: static int grep_cache(struct grep_opt *opt,
      	if (repo_read_index(repo) < 0)
      		die(_("index file corrupt"));
    @@ builtin/grep.c: static int grep_cache(struct grep_opt *opt,
      
     -		if (S_ISREG(ce->ce_mode) &&
     +			hit |= grep_tree(opt, pathspec, &tree, &name, 0, 0);
    -+			strbuf_reset(&name);
    ++			strbuf_setlen(&name, name_base_len);
     +			strbuf_addstr(&name, ce->name);
     +			free(data);
     +		} else if (S_ISREG(ce->ce_mode) &&
    @@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git read-tree -mu HEAD
      test_done
     
      ## t/t1092-sparse-checkout-compatibility.sh ##
    +@@ t/t1092-sparse-checkout-compatibility.sh: init_repos () {
    + 	git -C sparse-index sparse-checkout set deep
    + }
    + 
    ++init_repos_as_submodules () {
    ++	git reset --hard &&
    ++	init_repos &&
    ++	git submodule add ./full-checkout &&
    ++	git submodule add ./sparse-checkout &&
    ++	git submodule add ./sparse-index &&
    ++
    ++	git submodule status >actual &&
    ++	grep full-checkout actual &&
    ++	grep sparse-checkout actual &&
    ++	grep sparse-index actual
    ++}
    ++
    + run_on_sparse () {
    + 	(
    + 		cd sparse-checkout &&
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'grep is not expanded' '
      
      	# All files within the folder1/* pathspec are sparse,
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'grep is not expan
     +	# test in-cone pathspec with or without wildcard
     +	ensure_not_expanded grep --sparse --cached a -- "deep/a" &&
     +	ensure_not_expanded grep --sparse --cached a -- "deep/*"
    ++'
    ++
    ++# NEEDSWORK: when running `grep` in the superproject with --recurse-submodules,
    ++# Git expands the index of the submodules unexpectedly. Even though `grep`
    ++# builtin is marked as "command_requires_full_index = 0", this config is only
    ++# useful for the superproject. Namely, the submodules have their own configs,
    ++# which are _not_ populated by the one-time sparse-index feature switch.
    ++test_expect_failure 'grep within submodules is not expanded' '
    ++	init_repos_as_submodules &&
    ++
    ++	# do not use ensure_not_expanded() here, becasue `grep` should be
    ++	# run in the superproject, not in "./sparse-index"
    ++	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
    ++	git grep --sparse --cached --recurse-submodules a -- "*/folder1/*" &&
    ++	test_region ! index ensure_full_index trace2.txt
    ++'
    ++
    ++# NEEDSWORK: this test is not actually testing the code. The design purpose
    ++# of this test is to verify the grep result when the submodules are using a
    ++# sparse-index. Namely, we want "folder1/" as a tree (a sparse directory); but
    ++# because of the index expansion, we are now grepping the "folder1/a" blob.
    ++# Because of the problem stated above 'grep within submodules is not expanded',
    ++# we don't have the ideal test environment yet.
    ++test_expect_success 'grep sparse directory within submodules' '
    ++	init_repos_as_submodules &&
    ++
    ++	cat >expect <<-\EOF &&
    ++	full-checkout/folder1/a:a
    ++	sparse-checkout/folder1/a:a
    ++	sparse-index/folder1/a:a
    ++	EOF
    ++	git grep --sparse --cached --recurse-submodules a -- "*/folder1/*" >actual &&
    ++	test_cmp actual expect
      '
      
      test_done

base-commit: 79f2338b3746d23454308648b2491e5beba4beff
-- 
2.37.0


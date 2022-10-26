Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAFDC38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 20:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbiJZUNk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 16:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbiJZUNi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 16:13:38 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AFE143A77
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 13:13:36 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id b79so14554177iof.5
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 13:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6JFOq/s/q7Fb8lpl06yetR6M/Eo94dDK9JazP3PQUS4=;
        b=kthCRfPuQ7mWEBNloU75zQ5ECMmkSGu+WMPKQm4YBYpXEgH6WiCamvT2OAaYVmKkyS
         x75v7Fs8YeSSgevO5/t/n+tikN2+Ypw9hg42kYUnUDUvLSm3tbYmkoI3i3nua00115vk
         C6QYF6M0e1R7J5hFIc/t+lFjHBaSoHzmvd49gkoiaETiiDVSf35waWCTe5gLuMRnxtKh
         aQUxMb9GlT34rLlfXZeRmRYRczc2mPpYEtrDQnK2y+9BItsEWGBQTSnVM2/Qaj2hwpPq
         5xO/axgHC8guaM1qj2thuTuGA6YXKewmoHtCgZgNBz0+cu5Y1+OvTlFhkKPB66h5pYLQ
         0pEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6JFOq/s/q7Fb8lpl06yetR6M/Eo94dDK9JazP3PQUS4=;
        b=SdqFB1vFPpy0GnOToHT1TsJiYo0BPEJmo5gl1P+cmir7vSKxw2GJwS+PWMdDZoJeT6
         wfibogRG+8dEOrTJvDG2mefUtnJolL/3fdFU69Kn3oDbanSFBhGuYpNfArOXMrsr8Dw/
         OH0W4eUTUewyb39Nok71+fALADe1lYH8c1Lo0nMhSOreC9aIfUnabIz0R1M7F88eENoH
         KjJ4gbjY8w28+WZQ602oKmqgaSyl/AEfY28FOsPxJ6TS9RFsxF1zn0dkVXb+/3sPSWsP
         ci6aCv0iTY/aalTypTDrzCnzIy67jdwlFueN7vPGUrE3hf0Zr+jv8ZMTW7d7qMA39xta
         JC7A==
X-Gm-Message-State: ACrzQf3eWWImlkwWxkSiJjU8rnhkGcn1OXsPh/ASL8pi8UEL+u8EdNOc
        Ty2e/qPQsBTjz/YWMmvaRDxZLkEzEq9bTsa8
X-Google-Smtp-Source: AMsMyM6+5RtSgmZNhfOiGCrILO7rcrmHvRBAsa/xtwRczxYXp5I4wYnyLFCDloX4i0PUC9BZ3oyWUA==
X-Received: by 2002:a05:6602:2e8d:b0:6bd:543c:6fd7 with SMTP id m13-20020a0566022e8d00b006bd543c6fd7mr10865783iow.134.1666815215929;
        Wed, 26 Oct 2022 13:13:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n11-20020a056638110b00b003748d3552e1sm2283180jal.154.2022.10.26.13.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:13:35 -0700 (PDT)
Date:   Wed, 26 Oct 2022 16:13:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v2 0/2] gc: let feature.experimental imply gc.cruftPacks
Message-ID: <cover.1666815209.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a moderately-sized reroll of Emily's series from [1], which I
saw while sifting through old mail in my inbox.

That series was sent when I was on vacation, which is a likely
explanation for why I most likely missed it.

I'm sending a reroll out on Emily's behalf, since the series hasn't
received any activity in a few months, and I would like to see the
topic pushed forward.

Changes since last time are included in a range-diff below, but the
major points are:

  - extracted common components of the test script into helper
    functions
  - reordered the repository creation/teardown so that
    test_when_finished "rm -fr ..." happens before "git init"
  - and centralized checking feature.experimental into
    repo-settings.c

Thanks in advance for your review.

[1]: https://lore.kernel.org/git/20220803205721.3686361-1-emilyshaffer@google.com/

Emily Shaffer (2):
  gc: add tests for --cruft and friends
  config: let feature.experimental imply gc.cruftPacks=true

 Documentation/config/feature.txt |  3 ++
 builtin/gc.c                     |  7 ++-
 repo-settings.c                  |  1 +
 repository.h                     |  1 +
 t/t6500-gc.sh                    | 84 ++++++++++++++++++++++++++++++++
 5 files changed, 94 insertions(+), 2 deletions(-)

Range-diff against v1:
1:  bf243d15c1 ! 1:  35d2c97715 gc: add tests for --cruft and friends
    @@ Commit message
         Add some tests to exercise these options to gc in the gc test suite.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    +    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## t/t6500-gc.sh ##
     @@ t/t6500-gc.sh: test_expect_success 'one of gc.reflogExpire{Unreachable,}=never does not skip "e
      	grep -E "^trace: (built-in|exec|run_command): git reflog expire --" trace.out
      '
      
    ++prepare_cruft_history () {
    ++	test_commit base &&
    ++
    ++	test_commit --no-tag foo &&
    ++	test_commit --no-tag bar &&
    ++	git reset HEAD^^
    ++}
    ++
    ++assert_cruft_pack_exists () {
    ++	find .git/objects/pack -name "*.mtimes" >mtimes &&
    ++	sed -e 's/\.mtimes$/\.pack/g' mtimes >packs &&
    ++
    ++	test_file_not_empty packs &&
    ++	while read pack
    ++	do
    ++		test_path_is_file "$pack" || return 1
    ++	done <packs
    ++}
    ++
     +test_expect_success 'gc --cruft generates a cruft pack' '
    -+	git init crufts &&
     +	test_when_finished "rm -fr crufts" &&
    ++	git init crufts &&
     +	(
     +		cd crufts &&
    -+		test_commit base &&
    -+
    -+		test_commit --no-tag foo &&
    -+		test_commit --no-tag bar &&
    -+		git reset HEAD^^ &&
     +
    ++		prepare_cruft_history &&
     +		git gc --cruft &&
    -+
    -+		cruft=$(basename $(ls .git/objects/pack/pack-*.mtimes) .mtimes) &&
    -+		test_path_is_file .git/objects/pack/$cruft.pack
    ++		assert_cruft_pack_exists
     +	)
     +'
     +
     +test_expect_success 'gc.cruftPacks=true generates a cruft pack' '
    -+	git init crufts &&
     +	test_when_finished "rm -fr crufts" &&
    ++	git init crufts &&
     +	(
     +		cd crufts &&
    -+		test_commit base &&
    -+
    -+		test_commit --no-tag foo &&
    -+		test_commit --no-tag bar &&
    -+		git reset HEAD^^ &&
     +
    ++		prepare_cruft_history &&
     +		git -c gc.cruftPacks=true gc &&
    -+
    -+		cruft=$(basename $(ls .git/objects/pack/pack-*.mtimes) .mtimes) &&
    -+		test_path_is_file .git/objects/pack/$cruft.pack
    ++		assert_cruft_pack_exists
     +	)
     +'
     +
2:  5a242e2370 ! 2:  eb151752b8 config: let feature.experimental imply gc.cruftPacks=true
    @@ Commit message
         config: let feature.experimental imply gc.cruftPacks=true
     
         We are interested in exploring whether gc.cruftPacks=true should become
    -    the default value; to determine whether it is safe to do so, let's
    -    encourage more users to try it out. Users who have set
    -    feature.experimental=true have already volunteered to try new and
    -    possibly-breaking config changes, so let's try this new default with
    -    that set of users.
    +    the default value.
    +
    +    To determine whether it is safe to do so, let's encourage more users to
    +    try it out.
    +
    +    Users who have set feature.experimental=true have already volunteered to
    +    try new and possibly-breaking config changes, so let's try this new
    +    default with that set of users.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    +    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## Documentation/config/feature.txt ##
     @@ Documentation/config/feature.txt: feature.experimental::
      +
      * `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
      skipping more commits at a time, reducing the number of round trips.
    +++
     +* `gc.cruftPacks=true` reduces disk space used by unreachable objects during
    -+garbage collection.
    ++garbage collection, preventing loose object explosions.
      
      feature.manyFiles::
      	Enable config options that optimize for repos with many files in the
     
      ## builtin/gc.c ##
    -@@ builtin/gc.c: static int gc_config_is_timestamp_never(const char *var)
    - static void gc_config(void)
    - {
    - 	const char *value;
    -+	int experimental = 0;
    +@@ builtin/gc.c: static const char * const builtin_gc_usage[] = {
      
    - 	if (!git_config_get_value("gc.packrefs", &value)) {
    - 		if (value && !strcmp(value, "notbare"))
    -@@ builtin/gc.c: static void gc_config(void)
    - 	    gc_config_is_timestamp_never("gc.reflogexpireunreachable"))
    - 		prune_reflogs = 0;
    + static int pack_refs = 1;
    + static int prune_reflogs = 1;
    +-static int cruft_packs = 0;
    ++static int cruft_packs = -1;
    + static int aggressive_depth = 50;
    + static int aggressive_window = 250;
    + static int gc_auto_threshold = 6700;
    +@@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
    + 	if (prune_expire && parse_expiry_date(prune_expire, &dummy))
    + 		die(_("failed to parse prune expiry value %s"), prune_expire);
      
    -+	/* feature.experimental implies gc.cruftPacks=true */
    -+	git_config_get_bool("feature.experimental", &experimental);
    -+	if (experimental)
    -+		cruft_packs = 1;
    ++	prepare_repo_settings(the_repository);
    ++	if (cruft_packs < 0)
    ++		cruft_packs = the_repository->settings.gc_cruft_packs;
     +
    - 	git_config_get_int("gc.aggressivewindow", &aggressive_window);
    - 	git_config_get_int("gc.aggressivedepth", &aggressive_depth);
    - 	git_config_get_int("gc.auto", &gc_auto_threshold);
    + 	if (aggressive) {
    + 		strvec_push(&repack, "-f");
    + 		if (aggressive_depth > 0)
    +@@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
    + 		clean_pack_garbage();
    + 	}
    + 
    +-	prepare_repo_settings(the_repository);
    + 	if (the_repository->settings.gc_write_commit_graph == 1)
    + 		write_commit_graph_reachable(the_repository->objects->odb,
    + 					     !quiet && !daemonized ? COMMIT_GRAPH_WRITE_PROGRESS : 0,
    +
    + ## repo-settings.c ##
    +@@ repo-settings.c: void prepare_repo_settings(struct repository *r)
    + 	/* Defaults modified by feature.* */
    + 	if (experimental) {
    + 		r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
    ++		r->settings.gc_cruft_packs = 1;
    + 	}
    + 	if (manyfiles) {
    + 		r->settings.index_version = 4;
    +
    + ## repository.h ##
    +@@ repository.h: struct repo_settings {
    + 	int commit_graph_generation_version;
    + 	int commit_graph_read_changed_paths;
    + 	int gc_write_commit_graph;
    ++	int gc_cruft_packs;
    + 	int fetch_write_commit_graph;
    + 	int command_requires_full_index;
    + 	int sparse_index;
     
      ## t/t6500-gc.sh ##
    +@@ t/t6500-gc.sh: assert_cruft_pack_exists () {
    + 	done <packs
    + }
    + 
    ++refute_cruft_packs_exist () {
    ++	find .git/objects/pack -name "*.mtimes" >mtimes &&
    ++	test_must_be_empty mtimes
    ++}
    ++
    + test_expect_success 'gc --cruft generates a cruft pack' '
    + 	test_when_finished "rm -fr crufts" &&
    + 	git init crufts &&
     @@ t/t6500-gc.sh: test_expect_success 'gc.cruftPacks=true generates a cruft pack' '
      	)
      '
    @@ t/t6500-gc.sh: test_expect_success 'gc.cruftPacks=true generates a cruft pack' '
     +	test_when_finished "rm -fr crufts" &&
     +	(
     +		cd crufts &&
    -+		test_commit base &&
    -+
    -+		test_commit --no-tag foo &&
    -+		test_commit --no-tag bar &&
    -+		git reset HEAD^^ &&
     +
    ++		prepare_cruft_history &&
     +		git -c feature.experimental=true gc &&
    -+
    -+		cruft=$(basename $(ls .git/objects/pack/pack-*.mtimes) .mtimes) &&
    -+		test_path_is_file .git/objects/pack/$cruft.pack
    ++		assert_cruft_pack_exists
     +	)
     +'
     +
    @@ t/t6500-gc.sh: test_expect_success 'gc.cruftPacks=true generates a cruft pack' '
     +	test_when_finished "rm -fr crufts" &&
     +	(
     +		cd crufts &&
    -+		test_commit base &&
    -+
    -+		test_commit --no-tag foo &&
    -+		test_commit --no-tag bar &&
    -+		git reset HEAD^^ &&
     +
    ++		prepare_cruft_history &&
     +		git -c gc.cruftPacks=true -c feature.experimental=false gc &&
    -+		cruft=$(basename $(ls .git/objects/pack/pack-*.mtimes) .mtimes) &&
    -+		test_path_is_file .git/objects/pack/$cruft.pack
    ++		assert_cruft_pack_exists
    ++	)
    ++'
    ++
    ++test_expect_success 'feature.experimental=false avoids cruft packs by default' '
    ++	git init crufts &&
    ++	test_when_finished "rm -fr crufts" &&
    ++	(
    ++		cd crufts &&
    ++
    ++		prepare_cruft_history &&
    ++		git -c feature.experimental=false gc &&
    ++		refute_cruft_packs_exist
     +	)
     +'
     +
-- 
2.38.0.16.g393fd4c6db

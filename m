Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3015C433E6
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 13:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99DCA2312A
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 13:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbhAGNvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 08:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbhAGNvL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 08:51:11 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123C6C0612F4
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 05:50:31 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 15so4882288pgx.7
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 05:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TzMkZhEWUpqOquX6Gyhlc8ORFKiHWhequQvMJMyFo8E=;
        b=Kep7sexMvAqBGiCxJu6WOzwpX2he2bJ2OV8yLpCF3oJWdYEj/O3mK1vD0pl/YM1JVZ
         oTN+d96ppxmGxKWAMw9FHWW52X+sOwJafWLr8fu8dFInuljvbLFDcbNN1Ty/CI7WorMt
         ItGVhv5pBKc6qghFaAe9L5WwnvUdHqPB+4qAEUAJHDcnK8otPHKsH2u/lKc/X2MOOw/I
         I1VJNvDFF/cAQbI965MGflYt4MOtkvizxjMSWASfB+BjBm7pLZ/tQNklmwyvD5IK620R
         ABPAFF1wyFZWri44Xi/uNh6LbieMaS70Ne/hIaUglMIM39IrTWiamSg5uN/zV+pMruLb
         EVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TzMkZhEWUpqOquX6Gyhlc8ORFKiHWhequQvMJMyFo8E=;
        b=fYmEMSxrlLrqvhiPFSDdFLTmjV6kZE2iEvqPFrQNL/UrNlwE5OxcN4X4oyRBDIrxza
         EnpZZy0k6xQtLUAXtLwIcLRU9gbpsmIaxxcvi+NizLPf8ht1BfLKpqZ2fnA24sfq6crH
         Duo7Xq/8NRThe21MNsRwNFBd1OZlnFHN3zEXHiH8rB0JLBojDIIXnSepYd6XgxYY/tCP
         TcqdK+OgGguf4wnIUKczuB8vMpQNKNVZ9+CE33mkL1KAIQ/yNwecAB4Wuqclu0U13lG/
         HoZ2l6MgJ7iRqeKwowOvT9SKZagmCx4Z0mknnlLnySz1HeS2zcVwPilkIIiboEEU1XgP
         WzIQ==
X-Gm-Message-State: AOAM533jILvT6YePxvKbqWPZKhk+PX+20vAUtbaX4sXj3nAFCTLPnFvc
        BCyJUwr2RzHMh5om16G9kJ8=
X-Google-Smtp-Source: ABdhPJwVNWcqb+1w2/oBNLFqQNcK1+8nGEO9FYbyIagDZc9Mut5ZV6wRx3pxe/N0LqzfsIOQv3oNjA==
X-Received: by 2002:a62:4e43:0:b029:1a4:684c:87ea with SMTP id c64-20020a624e430000b02901a4684c87eamr9080357pfb.75.1610027430338;
        Thu, 07 Jan 2021 05:50:30 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id b7sm5842732pff.96.2021.01.07.05.50.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jan 2021 05:50:29 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 0/2] improvements for git-bundle
Date:   Thu,  7 Jan 2021 08:50:23 -0500
Message-Id: <20210107135025.2682-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <xmqqft3g6ziz.fsf@gitster.c.googlers.com>
References: <xmqqft3g6ziz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

## Introduce two improvements for git-bundle

+ Commit "bundle: lost objects when removing duplicate pendings",
  which fixes command like:

        $ git bundle create <file> 'master^!'
  
+ Commits "bundle: arguments can be read from stdin",
  which add "--stdin" option support for git-bundle, like:

        $ git bundle create <file> <input

## Changes of v3

1. Forgot to add shebang in file "t/t6020-bundle-misc.sh", which breaks
   build and test on Windows.

2. Add more testcases in t6020.

## Range diff of v2...v3

1:  ba13820340 ! 1:  9df48434f3 bundle: lost objects when removing duplicate pendings
    @@ object.c: void object_array_remove_duplicates(struct object_array *array)
     
      ## t/t6020-bundle-misc.sh (new) ##
     @@
    ++#!/bin/sh
    ++#
    ++# Copyright (c) 2021 Jiang Xin
    ++#
    ++
     +test_description='Test git-bundle'
     +
     +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    @@ t/t6020-bundle-misc.sh (new)
     +. ./test-lib.sh
     +
     +test_bundle_object_count () {
    -+	git verify-pack -v "$1" >verify.out &&
    ++	bundle=$1 &&
    ++	pack=${bundle%.bdl}.pack &&
    ++	convert_bundle_to_pack <"$bundle" >"$pack" &&
    ++	git index-pack "$pack" &&
    ++	git verify-pack -v "$pack" >verify.out &&
    ++	count=$(grep "^$OID_REGEX " verify.out | wc -l) &&
    ++	test $2 = $count && return 0
    ++	echo object count for $bundle is $count, not $2
    ++	return 1
    ++}
    ++
    ++
    ++test_thin_bundle_object_count () {
    ++	bundle=$1 &&
    ++	pack=${bundle%.bdl}.pack &&
    ++	convert_bundle_to_pack <"$bundle" |
    ++		test_must_fail git index-pack --stdin "$pack" &&
    ++	rm -f "$pack" &&
    ++	convert_bundle_to_pack <"$bundle" |
    ++		git index-pack --stdin --fix-thin "$pack" &&
    ++	git verify-pack -v "$pack" >verify.out &&
     +	count=$(grep "^$OID_REGEX " verify.out | wc -l) &&
     +	test $2 = $count && return 0
    -+	echo object count is $count, not $2
    ++	echo object count for $bundle is $count, not $2
     +	return 1
     +}
     +
    @@ t/t6020-bundle-misc.sh (new)
     +
     +#            (C)   (D, pull/1/head, topic/1)
     +#             o --- o
    -+#            /       \                              (L, tags/v1)
    -+#           /         \        o (H, topic/2)             (M, tags/v2)
    -+#          /    (F)    \      /                                 (N, tags/v3)
    ++#            /       \                              (L)
    ++#           /         \        o (H, topic/2)             (M, tag:v2)
    ++#          /    (F)    \      /                                 (N, tag:v3)
     +#         /      o --------- o (G, pull/2/head)      o --- o --- o (release)
     +#        /      /        \    \                      /       \
     +#  o --- o --- o -------- o -- o ------------------ o ------- o --- o (main)
    -+# (A)   (B)   (E)        (I)  (J)                  (K)       (O)   (P)
    ++# (A)   (B)  (E, tag:v1) (I)  (J)                  (K)       (O)   (P)
     +#
     +test_expect_success 'setup' '
     +	# commit A & B
    @@ t/t6020-bundle-misc.sh (new)
     +	test_tick &&
     +	git commit -m "Commit E" &&
     +	E=$(git rev-parse HEAD) &&
    ++	test_tick &&
    ++	git tag -m "v1" v1 HEAD &&
    ++	TAG1=$(git rev-parse refs/tags/v1) &&
     +
     +	# branch topic/2
     +	git checkout -b topic/2 &&
    @@ t/t6020-bundle-misc.sh (new)
     +	git add release.txt &&
     +	test_tick &&
     +	git commit -m "Commit L" &&
    -+	test_tick &&
    -+	git tag -m "v1" v1 HEAD &&
     +
     +	cat >release.txt <<-EOF &&
     +		Commit M
    @@ t/t6020-bundle-misc.sh (new)
     +	L=$(git rev-parse HEAD~2) &&
     +	M=$(git rev-parse HEAD~) &&
     +	N=$(git rev-parse HEAD) &&
    -+	TAG1=$(git rev-parse refs/tags/v1) &&
     +	TAG2=$(git rev-parse refs/tags/v2) &&
     +	TAG3=$(git rev-parse refs/tags/v3) &&
     +
    @@ t/t6020-bundle-misc.sh (new)
     +		EOF
     +	test_i18ncmp expect actual &&
     +
    -+	convert_bundle_to_pack <special-rev.bdl >special-rev.pack &&
    -+	git index-pack special-rev.pack &&
    -+	test_bundle_object_count special-rev.pack 3
    ++	test_bundle_object_count special-rev.bdl 3
    ++'
    ++
    ++test_expect_success 'create bundle with --max-count option' '
    ++	git bundle create max-count.bdl --max-count 1 \
    ++		main \
    ++		"^release" \
    ++		refs/tags/v1 \
    ++		refs/pull/1/head \
    ++		refs/pull/2/head &&
    ++
    ++	git bundle list-heads max-count.bdl |
    ++		make_user_friendly_and_stable_output >actual &&
    ++	cat >expect <<-EOF &&
    ++		<COMMIT-P> refs/heads/main
    ++		<TAG-1> refs/tags/v1
    ++		EOF
    ++	test_i18ncmp expect actual &&
    ++
    ++	git bundle verify max-count.bdl |
    ++		make_user_friendly_and_stable_output >actual &&
    ++	cat >expect <<-EOF &&
    ++		The bundle contains these 2 refs:
    ++		<COMMIT-P> refs/heads/main
    ++		<TAG-1> refs/tags/v1
    ++		The bundle requires this ref:
    ++		<COMMIT-O>
    ++		EOF
    ++	test_i18ncmp expect actual &&
    ++
    ++	test_bundle_object_count max-count.bdl 4
    ++'
    ++
    ++test_expect_success 'create bundle with --since option' '
    ++	git bundle create since.bdl \
    ++		--since "Thu Apr 7 15:26:13 2005 -0700" \
    ++		--all &&
    ++
    ++	git bundle list-heads since.bdl |
    ++		make_user_friendly_and_stable_output >actual &&
    ++	cat >expect <<-EOF &&
    ++		<COMMIT-P> refs/heads/main
    ++		<COMMIT-N> refs/heads/release
    ++		<TAG-2> refs/tags/v2
    ++		<TAG-3> refs/tags/v3
    ++		<COMMIT-P> HEAD
    ++		EOF
    ++	test_i18ncmp expect actual &&
    ++
    ++	git bundle verify since.bdl |
    ++		make_user_friendly_and_stable_output >actual &&
    ++	cat >expect <<-EOF &&
    ++		The bundle contains these 5 refs:
    ++		<COMMIT-P> refs/heads/main
    ++		<COMMIT-N> refs/heads/release
    ++		<TAG-2> refs/tags/v2
    ++		<TAG-3> refs/tags/v3
    ++		<COMMIT-P> HEAD
    ++		The bundle requires these 2 refs:
    ++		<COMMIT-L>
    ++		<COMMIT-K>
    ++		EOF
    ++	test_i18ncmp expect actual &&
    ++
    ++	test_thin_bundle_object_count since.bdl 16
     +'
     +
     +test_expect_success 'create bundle 1 - no prerequisites' '
    -+	# create bundle from args
     +	git bundle create 1.bdl topic/1 topic/2 &&
     +
     +	cat >expect <<-EOF &&
    @@ t/t6020-bundle-misc.sh (new)
     +		make_user_friendly_and_stable_output >actual &&
     +	test_i18ncmp expect actual &&
     +
    -+	convert_bundle_to_pack <1.bdl >1.pack &&
    -+	git index-pack 1.pack &&
    -+	test_bundle_object_count 1.pack 24
    ++	test_bundle_object_count 1.bdl 24
     +'
     +
     +test_expect_success 'create bundle 2 - has prerequisites' '
    -+	# create bundle from args
     +	git bundle create 2.bdl \
     +		--ignore-missing \
     +		^topic/deleted \
    @@ t/t6020-bundle-misc.sh (new)
     +		make_user_friendly_and_stable_output >actual &&
     +	test_i18ncmp expect actual &&
     +
    -+	convert_bundle_to_pack <2.bdl >2.pack &&
    -+	git index-pack 2.pack &&
    -+	test_bundle_object_count 2.pack 16
    ++	test_bundle_object_count 2.bdl 16
     +'
     +
     +test_expect_success 'fail to verify bundle without prerequisites' '
    @@ t/t6020-bundle-misc.sh (new)
     +'
     +
     +test_expect_success 'create bundle 3 - two refs, same object' '
    -+	# create bundle from args
     +	git bundle create --version=3 3.bdl \
     +		^release \
     +		^topic/1 \
    @@ t/t6020-bundle-misc.sh (new)
     +		make_user_friendly_and_stable_output >actual &&
     +	test_i18ncmp expect actual &&
     +
    -+	convert_bundle_to_pack <3.bdl >3.pack &&
    -+	git index-pack 3.pack &&
    -+	test_bundle_object_count 3.pack 4
    ++	test_bundle_object_count 3.bdl 4
     +'
     +
     +test_expect_success 'create bundle 4 - with tags' '
    -+	# create bundle from args
     +	git bundle create 4.bdl \
     +		^main \
     +		^release \
    @@ t/t6020-bundle-misc.sh (new)
     +		make_user_friendly_and_stable_output >actual &&
     +	test_i18ncmp expect actual &&
     +
    -+	convert_bundle_to_pack <4.bdl >4.pack &&
    -+	git index-pack 4.pack &&
    -+	test_bundle_object_count 4.pack 3
    ++	test_bundle_object_count 4.bdl 3
     +'
     +
     +test_expect_success 'clone from bundle' '
2:  a4662f44a8 ! 2:  86ad41e4d4 bundle: arguments can be read from stdin
    @@ Commit message
         `git-bundle`.  Later nothing can be read from stdin when running
         `setup_revisions()` in `create_bundle()`.
     
    -    Remove the entire `compute_and_write_prerequisites()` function, and
    -    parse the args once by `setup_revisions()`.  The first step for creating
    -    a bundle is to write prerequisites ("-" obj-id SP comment LF), but after
    -    calling `prepare_revision_walk()`, the `revs.pending` is left empty.
    -    Following steps could not work properly without data in `revs.pending`.
    -    Therefore, before calling `prepare_revision_walk()` function, make a
    -    copy `revs_copy` from `revs` for later use.  Even though `revs_copy` and
    -    `revs` share the same objects, but changes on these objects will not
    -    change the behavior of function `write_bundle_refs()` and
    -    `write_pack_data()`.
    +    The solution is to parse args once by removing the entire function
    +    `compute_and_write_prerequisites()` and then calling function
    +    `setup_revisions()`.  In order to write prerequisites for bundle, will
    +    call `prepare_revision_walk()` and `traverse_commit_list()`.  But after
    +    calling `prepare_revision_walk()`, the object array `revs.pending` is
    +    left empty, and the following steps could not work properly with the
    +    empty object array (`revs.pending`).  Therefore, make a copy of `revs`
    +    to `revs_copy` for later use right after calling `setup_revisions()`.
    +
    +    The copy of `revs_copy` is not a deep copy, it shares the same objects
    +    with `revs`. The object array of `revs` has been cleared, but objects
    +    themselves are still kept.  Flags of objects may change after calling
    +    `prepare_revision_walk()`, we can use these changed flags without
    +    calling the `git rev-list` command and parsing its output like the
    +    former implementation.
     
         Also add testcases for git bundle in t6020, which read args from stdin.
     
    @@ bundle.c: static int write_pack_data(int bundle_fd, struct rev_info *revs, struc
      /*
       * Write out bundle refs based on the tips already
       * parsed into revs.pending. As a side effect, may
    +@@ bundle.c: static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
    + 		 * constraints.
    + 		 */
    + 		if (!(e->item->flags & SHOWN) && e->item->type == OBJ_COMMIT) {
    +-			warning(_("ref '%s' is excluded by the rev-list options"),
    ++			warning(_("ref '%s' is excluded by the limiting options"),
    + 				e->name);
    + 			goto skip_write_ref;
    + 		}
     @@ bundle.c: static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
      	return ref_count;
      }
    @@ t/t5607-clone-bundle.sh: test_expect_success 'die if bundle file cannot be creat
      	grep master output
     
      ## t/t6020-bundle-misc.sh ##
    -@@ t/t6020-bundle-misc.sh: test_expect_success 'create bundle 1 - no prerequisites' '
    - 	# create bundle from args
    +@@ t/t6020-bundle-misc.sh: test_expect_success 'create bundle with --since option' '
    + '
    + 
    + test_expect_success 'create bundle 1 - no prerequisites' '
    ++	# create bundle from args
      	git bundle create 1.bdl topic/1 topic/2 &&
      
     +	# create bundle from stdin
    @@ t/t6020-bundle-misc.sh: test_expect_success 'create bundle 1 - no prerequisites'
      		make_user_friendly_and_stable_output >actual &&
      	test_i18ncmp expect actual &&
      
    +-	test_bundle_object_count 1.bdl 24
     +	git bundle verify stdin-1.bdl |
     +		make_user_friendly_and_stable_output >actual &&
     +	test_i18ncmp expect actual &&
     +
    - 	convert_bundle_to_pack <1.bdl >1.pack &&
    - 	git index-pack 1.pack &&
    --	test_bundle_object_count 1.pack 24
    -+	test_bundle_object_count 1.pack 24 &&
    -+
    -+	convert_bundle_to_pack <stdin-1.bdl >stdin-1.pack &&
    -+	git index-pack stdin-1.pack &&
    -+	test_bundle_object_count stdin-1.pack 24
    ++	test_bundle_object_count       1.bdl 24 &&
    ++	test_bundle_object_count stdin-1.bdl 24
      '
      
      test_expect_success 'create bundle 2 - has prerequisites' '
    ++	# create bundle from args
    + 	git bundle create 2.bdl \
    + 		--ignore-missing \
    + 		^topic/deleted \
     @@ t/t6020-bundle-misc.sh: test_expect_success 'create bundle 2 - has prerequisites' '
      		^topic/2 \
      		release &&
    @@ t/t6020-bundle-misc.sh: test_expect_success 'create bundle 2 - has prerequisites
      		make_user_friendly_and_stable_output >actual &&
      	test_i18ncmp expect actual &&
      
    +-	test_bundle_object_count 2.bdl 16
     +	git bundle verify stdin-2.bdl |
     +		make_user_friendly_and_stable_output >actual &&
     +	test_i18ncmp expect actual &&
     +
    - 	convert_bundle_to_pack <2.bdl >2.pack &&
    - 	git index-pack 2.pack &&
    --	test_bundle_object_count 2.pack 16
    -+	test_bundle_object_count 2.pack 16 &&
    -+
    -+	convert_bundle_to_pack <stdin-2.bdl >stdin-2.pack &&
    -+	git index-pack stdin-2.pack &&
    -+	test_bundle_object_count stdin-2.pack 16
    ++	test_bundle_object_count       2.bdl 16 &&
    ++	test_bundle_object_count stdin-2.bdl 16
      '
      
      test_expect_success 'fail to verify bundle without prerequisites' '
    @@ t/t6020-bundle-misc.sh: test_expect_success 'fail to verify bundle without prere
      	test_i18ncmp expect actual
      '
      
    + test_expect_success 'create bundle 3 - two refs, same object' '
    ++	# create bundle from args
    + 	git bundle create --version=3 3.bdl \
    + 		^release \
    + 		^topic/1 \
     @@ t/t6020-bundle-misc.sh: test_expect_success 'create bundle 3 - two refs, same object' '
      		main \
      		HEAD &&
    @@ t/t6020-bundle-misc.sh: test_expect_success 'create bundle 3 - two refs, same ob
      		make_user_friendly_and_stable_output >actual &&
      	test_i18ncmp expect actual &&
      
    +-	test_bundle_object_count 3.bdl 4
     +	git bundle verify stdin-3.bdl |
     +		make_user_friendly_and_stable_output >actual &&
     +	test_i18ncmp expect actual &&
     +
    - 	convert_bundle_to_pack <3.bdl >3.pack &&
    - 	git index-pack 3.pack &&
    --	test_bundle_object_count 3.pack 4
    -+	test_bundle_object_count 3.pack 4 &&
    -+
    -+	convert_bundle_to_pack <stdin-3.bdl >stdin-3.pack &&
    -+	git index-pack stdin-3.pack &&
    -+	test_bundle_object_count stdin-3.pack 4
    ++	test_bundle_object_count       3.bdl 4 &&
    ++	test_bundle_object_count stdin-3.bdl 4
      '
      
      test_expect_success 'create bundle 4 - with tags' '
    ++	# create bundle from args
    + 	git bundle create 4.bdl \
    + 		^main \
    + 		^release \
     @@ t/t6020-bundle-misc.sh: test_expect_success 'create bundle 4 - with tags' '
      		^topic/2 \
      		--all &&
    @@ t/t6020-bundle-misc.sh: test_expect_success 'create bundle 4 - with tags' '
      		make_user_friendly_and_stable_output >actual &&
      	test_i18ncmp expect actual &&
      
    +-	test_bundle_object_count 4.bdl 3
     +	git bundle verify stdin-4.bdl |
     +		make_user_friendly_and_stable_output >actual &&
     +	test_i18ncmp expect actual &&
     +
    - 	convert_bundle_to_pack <4.bdl >4.pack &&
    - 	git index-pack 4.pack &&
    --	test_bundle_object_count 4.pack 3
    -+	test_bundle_object_count 4.pack 3 &&
    -+
    -+	convert_bundle_to_pack <stdin-4.bdl >stdin-4.pack &&
    -+	git index-pack stdin-4.pack &&
    -+	test_bundle_object_count stdin-4.pack 3
    ++	test_bundle_object_count       4.bdl 3 &&
    ++	test_bundle_object_count stdin-4.bdl 3
      '
      
      test_expect_success 'clone from bundle' '

--

Jiang Xin (2):
  bundle: lost objects when removing duplicate pendings
  bundle: arguments can be read from stdin

 bundle.c                | 111 ++++----
 object.c                |  10 +-
 t/t5607-clone-bundle.sh |   4 +-
 t/t6020-bundle-misc.sh  | 557 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 625 insertions(+), 57 deletions(-)
 create mode 100755 t/t6020-bundle-misc.sh

-- 
2.30.0.2.g06d2f50715


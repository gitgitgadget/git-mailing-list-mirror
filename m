Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01208C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D43CB613B9
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhGJNkR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 09:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhGJNkR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 09:40:17 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20979C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:32 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f9so10817552wrq.11
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DXPg/79auuxMe5YGn/aetD0WJbKLPLezdEHJjSPI3CY=;
        b=NJ9Q2D2YLdl61W8ubQOdzXLrxRARGi/EDWYvbcwqPp+x/mGTh2ad/fXzgiUi7QRIvS
         xwtrCc8WbdciDVgogE0MfM981CpUAi7uxv5hDcgg6s3Xg7DA1oxNnqBwebUHquTDadqv
         mJ+Bgn3rDZa2BeZa1CsrV4yP1fbDQZq1GPjCpOKwBjVMwWVK3ppK3vxG4WlfQSCFOtxd
         2FqdmgINvbUATnP9bJS5R5ofdgnVv8usKPxBUb3crlVvnSxgwnBN6BHXxyBQxsqGukKy
         GCXgzWpqnGKrDn220wUWZcz7pHNR98zprynk2hVm18EMZ8hdpOraY67xMGRp9Qh1mTVl
         guSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DXPg/79auuxMe5YGn/aetD0WJbKLPLezdEHJjSPI3CY=;
        b=VIgoknbXb5G6pldAp0ONNOXGZkD/hlkcxnBSCWGurCBo8fPZVX6kbCWA4GnbtbgCuc
         uUhfWNKyP63X11WOCTDPolZBAwhT3U07Ia2gEp/rASZlNoPVYVbNELk3OOTzpFMV070p
         TXaeeeASDpukOkLZ9DIsUdsK0KwzjJHBM0WFir2dquBsefjOjxF+eqISTTtPNHdUhOR3
         9zAPFY26i/XhUOdjvvSmnxTV1FH8UPmqpkr8aD6RbtPxeimMxkV/HZEFDJyzcbeOxwUl
         ik0YieI0K/KOY4n8qa7hedMAIW0TD9hSkrbWnHQrjcdR0omZcnHDLiTahkaC6pPLvVuz
         JBJg==
X-Gm-Message-State: AOAM531/K7LvqDP4VKiETrEgeKNl/mngnGlLrrH65BZUkDgppJJi5FwK
        1GlMorlMAoLV1hZE+mss8efYv4Lf0zhqBA==
X-Google-Smtp-Source: ABdhPJwh9ClG5E9N5VsEZu255dZWXTV5KmEIhUcZbdLFJVfTB424AT6R9dzHF7Fx4CEzFTwJKPtRFw==
X-Received: by 2002:a5d:524e:: with SMTP id k14mr12298432wrc.264.1625924249962;
        Sat, 10 Jul 2021 06:37:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm17612787wmq.9.2021.07.10.06.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 06:37:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 00/21] fsck: lib-ify object-file.c & better fsck "invalid object" error reporting
Date:   Sat, 10 Jul 2021 15:37:03 +0200
Message-Id: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This improves fsck error reporting, see the examples in the commit
messages of 18/21, 20/21 and 21/21, to get there I've lib-ified more
thigs in object-file.c and the general object APIs, i.e. now we'll
return error codes instead of calling die() in these cases.

The fsck improvements are rather obscure & trivial in the grand scheme
of things, but the object API improvements make it easier to work with
in general.

A trivial re-roll of v4 to s/test_create_repo/git init/g, pointed out
by Andrei Rybak, I changed them to "git init --bare" while I was at
it. For v4 see:

https://lore.kernel.org/git/cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (21):
  fsck tests: refactor one test to use a sub-repo
  fsck tests: add test for fsck-ing an unknown type
  cat-file tests: test for missing object with -t and -s
  cat-file tests: test that --allow-unknown-type isn't on by default
  rev-list tests: test for behavior with invalid object types
  cat-file tests: add corrupt loose object test
  cat-file tests: test for current --allow-unknown-type behavior
  cache.h: move object functions to object-store.h
  object-file.c: don't set "typep" when returning non-zero
  object-file.c: make parse_loose_header_extended() public
  object-file.c: add missing braces to loose_object_info()
  object-file.c: simplify unpack_loose_short_header()
  object-file.c: split up ternary in parse_loose_header()
  object-file.c: stop dying in parse_loose_header()
  object-file.c: guard against future bugs in loose_object_info()
  object-file.c: return -1, not "status" from unpack_loose_header()
  object-file.c: return -2 on "header too long" in unpack_loose_header()
  fsck: don't hard die on invalid object types
  object-store.h: move read_loose_object() below 'struct object_info'
  fsck: report invalid types recorded in objects
  fsck: report invalid object type-path combinations

 builtin/fast-export.c  |   2 +-
 builtin/fsck.c         |  28 ++++++-
 builtin/index-pack.c   |   2 +-
 builtin/mktag.c        |   3 +-
 cache.h                |  10 ---
 object-file.c          | 178 +++++++++++++++++++++--------------------
 object-store.h         |  62 +++++++++++---
 object.c               |   4 +-
 pack-check.c           |   3 +-
 streaming.c            |  10 ++-
 t/t1006-cat-file.sh    | 169 ++++++++++++++++++++++++++++++++++++++
 t/t1450-fsck.sh        |  64 +++++++++++----
 t/t6115-rev-list-du.sh |  11 +++
 13 files changed, 407 insertions(+), 139 deletions(-)

Range-diff against v4:
 1:  2e37971c016 !  1:  a1259cdedcb fsck tests: refactor one test to use a sub-repo
    @@ t/t1450-fsck.sh: remove_object () {
     -	test_must_fail git fsck 2>out &&
     -	test_i18ngrep "$sha.*corrupt" out
     +test_expect_success 'object with hash mismatch' '
    -+	test_create_repo hash-mismatch &&
    ++	git init --bare hash-mismatch &&
     +	(
     +		cd hash-mismatch &&
     +		oid=$(echo blob | git hash-object -w --stdin) &&
     +		old=$(test_oid_to_path "$oid") &&
     +		new=$(dirname $old)/$(test_oid ff_2) &&
     +		oid="$(dirname $new)$(basename $new)" &&
    -+		mv .git/objects/$old .git/objects/$new &&
    ++		mv objects/$old objects/$new &&
     +		git update-index --add --cacheinfo 100644 $oid foo &&
     +		tree=$(git write-tree) &&
     +		cmt=$(echo bogus | git commit-tree $tree) &&
 2:  79630a99433 !  2:  634f991d7c6 fsck tests: add test for fsck-ing an unknown type
    @@ t/t1450-fsck.sh: test_expect_success 'detect corrupt index file in fsck' '
      '
      
     +test_expect_success 'fsck hard errors on an invalid object type' '
    -+	test_create_repo garbage-type &&
    ++	git init --bare garbage-type &&
     +	empty_blob=$(git -C garbage-type hash-object --stdin -w -t blob </dev/null) &&
     +	garbage_blob=$(git -C garbage-type hash-object --stdin -w -t garbage --literally </dev/null) &&
     +	cat >err.expect <<-\EOF &&
 3:  2b5366bfb9d =  3:  ce9dcc423e9 cat-file tests: test for missing object with -t and -s
 4:  ea9a5ef0920 =  4:  50a20741e86 cat-file tests: test that --allow-unknown-type isn't on by default
 5:  8eaf0e6ddda =  5:  f8d0b630d0a rev-list tests: test for behavior with invalid object types
 6:  f0e9d92414e =  6:  43335e653b8 cat-file tests: add corrupt loose object test
 7:  d797d2e8e9d =  7:  a00dfea3fb8 cat-file tests: test for current --allow-unknown-type behavior
 8:  96310a0bb59 =  8:  387d7f08e61 cache.h: move object functions to object-store.h
 9:  54fb9189408 =  9:  e9520953956 object-file.c: don't set "typep" when returning non-zero
10:  9d36fcbc44a = 10:  a8b408eefe6 object-file.c: make parse_loose_header_extended() public
11:  74c308adc19 = 11:  31eee4da0e1 object-file.c: add missing braces to loose_object_info()
12:  3f52149bfde = 12:  dae5cfabd57 object-file.c: simplify unpack_loose_short_header()
13:  ba632be1520 = 13:  0d8385d8d12 object-file.c: split up ternary in parse_loose_header()
14:  ea4f446f5b1 = 14:  d1522291aee object-file.c: stop dying in parse_loose_header()
15:  aacef784eab = 15:  13d4141a21b object-file.c: guard against future bugs in loose_object_info()
16:  050cfc7808c = 16:  912c9edf362 object-file.c: return -1, not "status" from unpack_loose_header()
17:  78e3152fd94 = 17:  7e101f97646 object-file.c: return -2 on "header too long" in unpack_loose_header()
18:  f9bb1b799ac ! 18:  3c04065b0b0 fsck: don't hard die on invalid object types
    @@ t/t1450-fsck.sh: test_expect_success 'detect corrupt index file in fsck' '
      
     -test_expect_success 'fsck hard errors on an invalid object type' '
     +test_expect_success 'fsck error and recovery on invalid object type' '
    - 	test_create_repo garbage-type &&
    + 	git init --bare garbage-type &&
      	empty_blob=$(git -C garbage-type hash-object --stdin -w -t blob </dev/null) &&
      	garbage_blob=$(git -C garbage-type hash-object --stdin -w -t garbage --literally </dev/null) &&
     -	cat >err.expect <<-\EOF &&
19:  acbea7e2a2a = 19:  ad920362594 object-store.h: move read_loose_object() below 'struct object_info'
20:  edc28de229d ! 20:  02a148af5cf fsck: report invalid types recorded in objects
    @@ t/t1450-fsck.sh: test_expect_success 'object with hash mismatch' '
      '
      
     +test_expect_success 'object with hash and type mismatch' '
    -+	test_create_repo hash-type-mismatch &&
    ++	git init --bare hash-type-mismatch &&
     +	(
     +		cd hash-type-mismatch &&
     +		oid=$(echo blob | git hash-object -w --stdin -t garbage --literally) &&
     +		old=$(test_oid_to_path "$oid") &&
     +		new=$(dirname $old)/$(test_oid ff_2) &&
     +		oid="$(dirname $new)$(basename $new)" &&
    -+		mv .git/objects/$old .git/objects/$new &&
    ++		mv objects/$old objects/$new &&
     +		git update-index --add --cacheinfo 100644 $oid foo &&
     +		tree=$(git write-tree) &&
     +		cmt=$(echo bogus | git commit-tree $tree) &&
21:  e588c05f461 = 21:  730e0a6f805 fsck: report invalid object type-path combinations
-- 
2.32.0.636.g43e71d69cff


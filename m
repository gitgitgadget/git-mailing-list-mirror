Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36795C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 194CA60E52
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343769AbhIGK7c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 06:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245383AbhIGK7b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:59:31 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566BBC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:58:25 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 192-20020a1c04c9000000b002f7a4ab0a49so1591123wme.0
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c6cCAm7XYWs5xPAlo34WbMmtPDb1KctOacx7+sbpU28=;
        b=chthPndk0QD+lx0NXBcbVYXHaOwewzKjxQD3E+c0ZLjqYXTowaLXEVkx75SbHJ6PaN
         rHgWs8r6Y7CLRo2BTBwTP5mWJHGynbuwXm3mdJuZXymS0gB/3QkRTGoQozccH3p1/AnD
         Qzd1tSgp+bPCCWh+1trxYB+8yg4Qxcu0sgsZ8qxkLzq6Re5uEIhHtD4NDV0k5hkfNy2U
         hhbit14tEcJwSr7NZHyVWs6iFDKSgt9Zpg1bL9Dygvw2LAGx+FOOzIqr0pny4rOQ/5N8
         8abJyaJM98GsYSLXDOvQU9g9htnYccnY3ZOSwNTwZ6jk99UT36ePOoJg7aMXwIP3+687
         lXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c6cCAm7XYWs5xPAlo34WbMmtPDb1KctOacx7+sbpU28=;
        b=bbSjy+32UUs1ytNhvmMFwmKuMoejPww2BECv+p6RwjPexoayXQClfBvGvb7D9lTZju
         TQy5/FSpIoPRY4O5eUJoAj7JvdeaOen1O1PgT+hrDrqSttCm/6SL4v6QwV8XJ8fDE15f
         bwhDqXu/qVQ0Vl+YMjI8IIVAjKHnh4AOoiZwKXVIMy/lILQNhd69VWiDd3v9/I+/uPIc
         CN4ljT+cBgNM6a137sI/RyomRIzLSQa9uKEUONZ314ZTwL1Lp9GZjxPdnD8hpEx+xWV0
         fhb5N0v8VrZnBGwLh7SSxeTCb2hxI9jNSqzA0SuHdAZPlxXhOgkqBWk6jNlm5xF8rJMa
         G7pA==
X-Gm-Message-State: AOAM533Ms6TkenEKfJY/76bvzvo0tZMQ06atYpjt2w+Q63PPMXet3+Lf
        jKezD7QwHEJLaoYzAyLm2xvNK/WC8ijT8g==
X-Google-Smtp-Source: ABdhPJxYJe1wDMSIpbbjLE86qKue/uOAtb1K4qAPLtTlC6eZTvoigCWWovHriIso+VAYrYdi3Mzypg==
X-Received: by 2002:a05:600c:19d1:: with SMTP id u17mr3342306wmq.21.1631012303599;
        Tue, 07 Sep 2021 03:58:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l16sm8255602wrh.44.2021.09.07.03.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:58:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 00/22] fsck: lib-ify object-file.c & better fsck "invalid object" error reporting
Date:   Tue,  7 Sep 2021 12:57:55 +0200
Message-Id: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.815.g21c7aaf6073
In-Reply-To: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This improves fsck error reporting, see the examples in the commit
messages of 19/22, 21/22 and 22/22. To get there I've lib-ified more
thigs in object-file.c and the general object APIs, i.e. now we'll
return error codes instead of calling die() in these cases.

This series has been in "needs review" state for a while. This re-roll
is mainly to bump it for the list's attention, but while I was at it I
addressed point from Jonathan Tan raised in a previous round: use an
enum instead of int for the unpack_loose_header() return value.

I think the v3 of this got a detailed review, and the v3->v4 delta
wasn't that big (although one commit in particular is a bit tricky):

    https://lore.kernel.org/git/cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com/

I.e. it's just this part being substantially different from v3:

    https://lore.kernel.org/git/patch-12.21-3f52149bfde-20210624T191755Z-avarab@gmail.com/
    https://lore.kernel.org/git/patch-13.21-ba632be1520-20210624T191755Z-avarab@gmail.com/
    https://lore.kernel.org/git/patch-14.21-ea4f446f5b1-20210624T191755Z-avarab@gmail.com/

The v5 was then a trivial change of moving away from the
test_create_repo() test helper:
https://lore.kernel.org/git/cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com/

Perhaps this whole thing just needs to be split up, e.g. the first 7
commits could be some "improve fsck tests" series, the middle part
some general small refactoring, and the real meaty work as of 14/22
its own third series...

But I've resisted that because I think while this is rather long the
first parts adding tests for missing behavior should assure reviewers
that the later changes are all properly tested.

I know the end-goal here isn't all that exciting in itself, but I've
really wanted to improve various things around fsck-ing, bad object
reporting etc., and that's been stalled on this first step for a
while.

Ævar Arnfjörð Bjarmason (22):
  fsck tests: refactor one test to use a sub-repo
  fsck tests: add test for fsck-ing an unknown type
  cat-file tests: test for missing object with -t and -s
  cat-file tests: test that --allow-unknown-type isn't on by default
  rev-list tests: test for behavior with invalid object types
  cat-file tests: add corrupt loose object test
  cat-file tests: test for current --allow-unknown-type behavior
  object-file.c: don't set "typep" when returning non-zero
  cache.h: move object functions to object-store.h
  object-file.c: make parse_loose_header_extended() public
  object-file.c: add missing braces to loose_object_info()
  object-file.c: simplify unpack_loose_short_header()
  object-file.c: split up ternary in parse_loose_header()
  object-file.c: stop dying in parse_loose_header()
  object-file.c: guard against future bugs in loose_object_info()
  object-file.c: return -1, not "status" from unpack_loose_header()
  object-file.c: return -2 on "header too long" in unpack_loose_header()
  object-file.c: use "enum" return type for unpack_loose_header()
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
 object-store.h         |  75 ++++++++++++++---
 object.c               |   4 +-
 pack-check.c           |   3 +-
 streaming.c            |  29 ++++---
 t/t1006-cat-file.sh    | 169 ++++++++++++++++++++++++++++++++++++++
 t/t1450-fsck.sh        |  64 +++++++++++----
 t/t6115-rev-list-du.sh |  11 +++
 13 files changed, 432 insertions(+), 146 deletions(-)

Range-diff against v5:
 1:  a1259cdedcb =  1:  ebe89f65354 fsck tests: refactor one test to use a sub-repo
 2:  634f991d7c6 =  2:  9072eef3be3 fsck tests: add test for fsck-ing an unknown type
 3:  ce9dcc423e9 =  3:  d442a309178 cat-file tests: test for missing object with -t and -s
 4:  50a20741e86 =  4:  0358273022f cat-file tests: test that --allow-unknown-type isn't on by default
 5:  f8d0b630d0a =  5:  82db40ebf8a rev-list tests: test for behavior with invalid object types
 6:  43335e653b8 =  6:  d1ffd21acc5 cat-file tests: add corrupt loose object test
 7:  a00dfea3fb8 =  7:  22ab12c2282 cat-file tests: test for current --allow-unknown-type behavior
 9:  e9520953956 =  8:  38e4266772d object-file.c: don't set "typep" when returning non-zero
 8:  387d7f08e61 =  9:  5b9278e7bb4 cache.h: move object functions to object-store.h
10:  a8b408eefe6 = 10:  b15ad53414b object-file.c: make parse_loose_header_extended() public
11:  31eee4da0e1 = 11:  326eb74545d object-file.c: add missing braces to loose_object_info()
12:  dae5cfabd57 = 12:  4f829e9b727 object-file.c: simplify unpack_loose_short_header()
13:  0d8385d8d12 = 13:  90489d9e6ec object-file.c: split up ternary in parse_loose_header()
14:  d1522291aee = 14:  7c9819d37c5 object-file.c: stop dying in parse_loose_header()
15:  13d4141a21b = 15:  3fb660ff944 object-file.c: guard against future bugs in loose_object_info()
16:  912c9edf362 = 16:  9e7dbfb4aa3 object-file.c: return -1, not "status" from unpack_loose_header()
17:  7e101f97646 ! 17:  f28c4f0dfb4 object-file.c: return -2 on "header too long" in unpack_loose_header()
    @@ Commit message
         MAX_HEADER_LEN limit, or other negative values for "unable to unpack
         <OID> header".
     
    -    I tried setting up an enum just for these three return values, but I
    -    think the result was less readable. Let's consider doing that if we
    -    gain even more return values. For now let's do the next best thing and
    -    enumerate our known return values, and BUG() if we encounter one we
    -    don't know about.
    -
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## object-file.c ##
 -:  ----------- > 18:  1b7173a5b5b object-file.c: use "enum" return type for unpack_loose_header()
18:  3c04065b0b0 = 19:  ad1614dbb8d fsck: don't hard die on invalid object types
19:  ad920362594 = 20:  3bf3cf2299d object-store.h: move read_loose_object() below 'struct object_info'
20:  02a148af5cf = 21:  974f650cddf fsck: report invalid types recorded in objects
21:  730e0a6f805 ! 22:  804673a17b0 fsck: report invalid object type-path combinations
    @@ object-store.h: int oid_object_info_extended(struct repository *r,
      		      void **contents,
      		      struct object_info *oi,
      		      unsigned int oi_flags);
    -@@ object-store.h: int unpack_loose_header(git_zstream *stream, unsigned char *map,
    +@@ object-store.h: enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
      int parse_loose_header(const char *hdr, struct object_info *oi);
      
      int check_object_signature(struct repository *r, const struct object_id *oid,
-- 
2.33.0.815.g21c7aaf6073


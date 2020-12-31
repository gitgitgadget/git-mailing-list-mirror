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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7ACBC433E0
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 11:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78B75223E8
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 11:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgLaL5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 06:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgLaL5S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 06:57:18 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBCDC061573
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 03:56:37 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id h22so43703944lfu.2
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 03:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yyZJ0JLZ1dZgVGRiKtkpl3RhpXFLsNyyryStISmUpcg=;
        b=fOIOFadOslQPmAJX1oDa66rAZ6uoDbvDSicwYmRg8I1YEanwFBmldh0q3yLVCqpGGp
         2oyQ9hWfpxVvnQcz2wv+0Zt4lDTSc7QULJM+0CGGVM99IfVG53SSeUQLIFjOF6IA6myn
         BlhRgiZNPak2qZaX8cwQX4U3kmlDYdMAeuHz+JwDUK8faB7ECcQjQ4U37Ub009Bp/udM
         j+5Jmlf+XUGVRg7r3T+DSwl+4GBwPjsQI+vhLXtPseWpK1JGxQ9Fb11L6h4euXdkcemz
         RvRaCPZ8Oajl3VJbfLxuYrz4cJHYbn8v42zi5SnlSFoT3pGKDpf6+icRmnk8QHOSH1mZ
         z5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yyZJ0JLZ1dZgVGRiKtkpl3RhpXFLsNyyryStISmUpcg=;
        b=YOnr5GBUT8q6l1XYlAUdExDztHSGD34SenTCDkmQMHCBI2R6zA2c1GBbkIyIVlgxdY
         8ov6RXLynVnMbTozenGTVOtiJmGbvfUdBwBrvahKXb/f0JqryAq6pUbCBMYenuORZHrR
         VGvKiPnheIDFyvBai0ZSg0NuppYGaeExDWsnWhe3fI1QzlixZj9Azw/MYSDJ9lIp/Vmr
         f+uIL/D0voloDrtKPLBON5wd0K7MPOY0+EAb3nUM8J3shJRtY0vvYjcrsNi3CdQ9pvki
         r1k4aaIEuJb3IjyN8dLpYp/vIUAVy+s3w22970p0J0gZyqNDBfPXGXf7ZznxD01CHGKn
         wiNg==
X-Gm-Message-State: AOAM530kwpjCYPiGQ7TlARAD4Zavdf+dwA3Uf95a0LTtnxkPROkTrD2n
        qEk5RFGgf1AJGeD62qw+tEsEb4fXa7I=
X-Google-Smtp-Source: ABdhPJyFnNI2Jlk9rRDjA9JIlbw1FPSRiskYoQD0TBC7YceLIt1s7TgYH6LI3ySZyr6YPgxOpHYUZQ==
X-Received: by 2002:a2e:86d4:: with SMTP id n20mr27070497ljj.486.1609415795398;
        Thu, 31 Dec 2020 03:56:35 -0800 (PST)
Received: from localhost.localdomain (host-189-203-5.junet.se. [207.189.203.5])
        by smtp.gmail.com with ESMTPSA id m11sm7505329ljp.12.2020.12.31.03.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 03:56:34 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 0/4] rename "sha1-foo" files
Date:   Thu, 31 Dec 2020 12:56:19 +0100
Message-Id: <cover.1609415114.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609282997.git.martin.agren@gmail.com>
References: <cover.1609282997.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to Derrick and brian for commenting on v1 [1] of my series for
renaming sha1-foo files and generalizing "sha", "sha1" and so on in
them. I realized I hadn't renamed the header guard in hash-lookup.h as I
renamed the file. That made me realize that I had failed to look for
"SHA-1" (capital letters). So this v2 is a bit bigger than v1, but not
by too much, I think. The range-diff is below.

[1] https://lore.kernel.org/git/cover.1609282997.git.martin.agren@gmail.com/

Martin Ågren (4):
  object-name.c: rename from sha1-name.c
  object-file.c: rename from sha1-file.c
  sha1-lookup: rename `sha1_pos()` as `hash_pos()`
  hash-lookup: rename from sha1-lookup

 t/oid-info/README                   |  2 +-
 t/t1512-rev-parse-disambiguation.sh |  2 +-
 sha1-lookup.h => hash-lookup.h      | 18 +++++++++---------
 bisect.c                            |  2 +-
 builtin/index-pack.c                |  2 +-
 builtin/name-rev.c                  |  4 ++--
 commit-graph.c                      |  8 ++++----
 commit.c                            |  4 ++--
 sha1-lookup.c => hash-lookup.c      | 22 +++++++++++-----------
 list-objects-filter.c               |  2 +-
 midx.c                              |  2 +-
 sha1-file.c => object-file.c        | 10 +++++-----
 sha1-name.c => object-name.c        | 16 ++++++++--------
 oid-array.c                         |  4 ++--
 pack-bitmap-write.c                 |  4 ++--
 packfile.c                          |  2 +-
 patch-ids.c                         |  2 +-
 rerere.c                            |  4 ++--
 Makefile                            |  6 +++---
 19 files changed, 58 insertions(+), 58 deletions(-)
 rename sha1-lookup.h => hash-lookup.h (68%)
 rename sha1-lookup.c => hash-lookup.c (84%)
 rename sha1-file.c => object-file.c (99%)
 rename sha1-name.c => object-name.c (98%)

Range-diff against v1:
1:  aac3a3c3e2 ! 1:  4d69d448a3 object-name.c: rename from sha1-name.c
    @@ Commit message
         Generalize the last remnants of "sha" and "sha1" in this file and rename
         it to reflect that we're not just able to handle SHA-1 these days.
     
    +    We need to update one test to check for an updated error string.
    +
         Signed-off-by: Martin Ågren <martin.agren@gmail.com>
     
    + ## t/t1512-rev-parse-disambiguation.sh ##
    +@@ t/t1512-rev-parse-disambiguation.sh: test_expect_success 'blob and tree' '
    + 
    + test_expect_success 'warn ambiguity when no candidate matches type hint' '
    + 	test_must_fail git rev-parse --verify 000000000^{commit} 2>actual &&
    +-	test_i18ngrep "short SHA1 000000000 is ambiguous" actual
    ++	test_i18ngrep "short object ID 000000000 is ambiguous" actual
    + '
    + 
    + test_expect_success 'disambiguate tree-ish' '
    +
      ## list-objects-filter.c ##
     @@
       * in the traversal (until we mark it SEEN).  This is a way to
    @@ object-name.c: static void unique_in_pack(struct packed_git *p,
      			break;
      		update_candidates(ds, &oid);
      	}
    +@@ object-name.c: static enum get_oid_result get_short_oid(struct repository *r,
    + 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS)) {
    + 		struct oid_array collect = OID_ARRAY_INIT;
    + 
    +-		error(_("short SHA1 %s is ambiguous"), ds.hex_pfx);
    ++		error(_("short object ID %s is ambiguous"), ds.hex_pfx);
    + 
    + 		/*
    + 		 * We may still have ambiguity if we simply saw a series of
     @@ object-name.c: static enum get_oid_result get_oid_with_context_1(struct repository *repo,
      	if (!ret)
      		return ret;
2:  4243886d8a ! 2:  7ab29b868f object-file.c: rename from sha1-file.c
    @@ sha1-file.c => object-file.c
       * creation etc.
       */
      #include "cache.h"
    +@@ object-file.c: static int alt_odb_usable(struct raw_object_store *o,
    +  * LF separated.  Its base points at a statically allocated buffer that
    +  * contains "/the/directory/corresponding/to/.git/objects/...", while
    +  * its name points just after the slash at the end of ".git/objects/"
    +- * in the example above, and has enough space to hold 40-byte hex
    +- * SHA1, an extra slash for the first level indirection, and the
    +- * terminating NUL.
    ++ * in the example above, and has enough space to hold all hex characters
    ++ * of the object ID, an extra slash for the first level indirection, and
    ++ * the terminating NUL.
    +  */
    + static void read_info_alternates(struct repository *r,
    + 				 const char *relative_base,
     
      ## Makefile ##
     @@ Makefile: LIB_OBJS += notes-cache.o
3:  8d3b123633 = 3:  91617de0ac sha1-lookup: rename `sha1_pos()` as `hash_pos()`
4:  afee010474 ! 4:  9df53353dc hash-lookup: rename from sha1-lookup
    @@ Commit message
         Signed-off-by: Martin Ågren <martin.agren@gmail.com>
     
      ## sha1-lookup.h => hash-lookup.h ##
    +@@
    +-#ifndef SHA1_LOOKUP_H
    +-#define SHA1_LOOKUP_H
    ++#ifndef HASH_LOOKUP_H
    ++#define HASH_LOOKUP_H
    + 
    + typedef const unsigned char *hash_access_fn(size_t index, void *table);
    + 
     @@ hash-lookup.h: int hash_pos(const unsigned char *hash,
      	     hash_access_fn fn);
      
-- 
2.30.0


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3E0C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 10:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ECD1613CC
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 10:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbhGIKTb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 06:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbhGIKTb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 06:19:31 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EF1C0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 03:16:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k31-20020a05600c1c9fb029021727d66d33so4431748wms.0
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 03:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L/9bQuQzeChLGiaGIja0Hvc9dvgzId9d5MVWeobPaMo=;
        b=UUPs50YK2l7mn/Hdn+oKxn7e0R0j6nBR5LZvCx6QK/GFKDkWk45ZpJtko2lII39748
         SIx3lBr5T31i/j7NApLpLSp8bSblEzCH85KXKlyRF8qvSyEsamzFamABKhwmZHmTTZ6u
         QS9TioSUu6XW1J1/36Cx1Z6Vy92dw7KbztvY2Va6Ss+m6LcDkAu0EqPT7l8PqSZ/ObBg
         /XkJTpTb2n+tLmrOTrTQrnlt3zHrPyz6c0HCNHCME+9S2p5I7jxHyGs7ZAi4UfsFiq4/
         b0msVueuFhIvS/pqWReQ0DznJaYl23QDU6KZwwKP7t6t97m0s44kPjU8o3X4c44cnrrZ
         iuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L/9bQuQzeChLGiaGIja0Hvc9dvgzId9d5MVWeobPaMo=;
        b=DZ8BU9OoqHs0wkuvHVhHCyk8o8p4rexbtOX2uePdQ5HC3RMDCvhxUVzUS1/ybwW9gt
         eeXxSFIRQ658SkwRMltcY6+faMlW1657NNCSLHHm6TRPROcqWRiQMQ/ev0ekqN2wmfaU
         wl0x4S4o4+Z7yo/X4pwndR4jvLzjdHDZ0zY0hE6UUUkBVqhSns9gTyqNdb1Idc0ekIUE
         goWGAIlGKoJRsxzyFcW+BVtISwN8zkM0as/qBmAbO6hLaNlFc4ma2ZaKcdG7PHdhuFhQ
         jQS+R37JqwvYJDEInpG+ijCLy2AolmsA4ZFSvGkl0pXCCV67JTIE3osEnmgiVamLT9Le
         fcqA==
X-Gm-Message-State: AOAM532Rzkwcj0Jun8TNiJGSAuuiEk2VlUZlGX9G/pOj9nQ6vKryWhlg
        HquXVuv44+nxdeGY5tRblWCs6vUaAAntkA==
X-Google-Smtp-Source: ABdhPJxpOKjnImnEOzr4ao2JmQfxpmd14Lqm07JsEvu/hXYzkMPEfnGDWPFLs3H0OIbhCnKgbAbJrg==
X-Received: by 2002:a05:600c:17c3:: with SMTP id y3mr37788402wmo.40.1625825805221;
        Fri, 09 Jul 2021 03:16:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f5sm4878498wrg.67.2021.07.09.03.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 03:16:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] pack-objects: missing tests & --stdin-packs segfault fix
Date:   Fri,  9 Jul 2021 12:13:46 +0200
Message-Id: <cover-0.2-00000000000-20210709T101014Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.2-00000000000-20210621T145819Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210621T145819Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When re-rolling an unrelated series[1] dealing with pack-objects.c and
revision.c I discovered that we have some test blindspots, and that
the newly added --stdin-packs option in v2.32.0 will segfault if fed
garbage data.

See
http://lore.kernel.org/git/cover-0.2-00000000000-20210621T145819Z-avarab@gmail.com
for the v1 of this series.

This hopefully addresses Taylor's comments in
https://lore.kernel.org/git/YND3h2l10PlnSNGJ@nand.local/

I didn't end up moving away from the "<in" pattern. I prefer it
because it makes manual inspection easier, and the tests above this
one used it consistently, so I left it in place.

I also ended up keeping the test_cmp for the reasons noted in the
updated 2/2 commit message. I.e. if we're commeting on this tricky
edge case let's have our tests assert that the code works that way,
and that the comment still holds.

Ævar Arnfjörð Bjarmason (2):
  pack-objects tests: cover blindspots in stdin handling
  pack-objects: fix segfault in --stdin-packs option

 builtin/pack-objects.c |  23 +++++++--
 t/t5300-pack-object.sh | 104 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+), 3 deletions(-)

Range-diff against v1:
1:  dd2efd1cfb9 = 1:  8a4d4b820e7 pack-objects tests: cover blindspots in stdin handling
2:  a9702132385 ! 2:  c7315f2b378 pack-objects: fix segfault in --stdin-packs option
    @@ Commit message
     
         Fix a segfault in the --stdin-packs option added in
         339bce27f4f (builtin/pack-objects.c: add '--stdin-packs' option,
    -    2021-02-22). The read_packs_list_from_stdin() function didn't check
    -    that the lines it was reading were valid packs, and thus when doing
    -    the QSORT() with pack_mtime_cmp() we'd have a NULL "util" field.
    +    2021-02-22).
    +
    +    The read_packs_list_from_stdin() function didn't check that the lines
    +    it was reading were valid packs, and thus when doing the QSORT() with
    +    pack_mtime_cmp() we'd have a NULL "util" field. The "util" field is
    +    used to associate the names of included/excluded packs with the
    +    packed_git structs they correspond to.
     
         The logic error was in assuming that we could iterate all packs and
         annotate the excluded and included packs we got, as opposed to
    @@ Commit message
     
         As noted in the test we'll not report the first bad line, but whatever
         line sorted first according to the string-list.c API. In this case I
    -    think that's fine.
    +    think that's fine. There was further discussion of alternate
    +    approaches in [1].
    +
    +    Even though we're being lazy let's assert the line we do expect to get
    +    in the test, since whoever changes this code in the future might miss
    +    this case, and would want to update the test and comments.
    +
    +    1. http://lore.kernel.org/git/YND3h2l10PlnSNGJ@nand.local
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/pack-objects.c ##
     @@ builtin/pack-objects.c: static void read_packs_list_from_stdin(void)
    - 			item->util = p;
      	}
      
    -+	/*
    -+	 * Arguments we got on stdin may not even be packs. Check that
    -+	 * to avoid segfaulting later on in e.g. pack_mtime_cmp().
    + 	/*
    +-	 * First handle all of the excluded packs, marking them as kept in-core
    +-	 * so that later calls to add_object_entry() discards any objects that
    +-	 * are also found in excluded packs.
    ++	 * Arguments we got on stdin may not even be packs. First
    ++	 * check that to avoid segfaulting later on in
    ++	 * e.g. pack_mtime_cmp(), excluded packs are handled below.
    ++	 *
    ++	 * Since we first parsed our STDIN and then sorted the input
    ++	 * lines the pack we error on will be whatever line happens to
    ++	 * sort first. This is lazy, it's enough that we report one
    ++	 * bad case here, we don't need to report the first/last one,
    ++	 * or all of them.
     +	 */
     +	for_each_string_list_item(item, &include_packs) {
     +		struct packed_git *p = item->util;
    @@ builtin/pack-objects.c: static void read_packs_list_from_stdin(void)
     +			die(_("could not find pack '%s'"), item->string);
     +	}
     +
    - 	/*
    - 	 * First handle all of the excluded packs, marking them as kept in-core
    - 	 * so that later calls to add_object_entry() discards any objects that
    ++	/*
    ++	 * Then, handle all of the excluded packs, marking them as
    ++	 * kept in-core so that later calls to add_object_entry()
    ++	 * discards any objects that are also found in excluded packs.
    + 	 */
    + 	for_each_string_list_item(item, &exclude_packs) {
    + 		struct packed_git *p = item->util;
     
      ## t/t5300-pack-object.sh ##
     @@ t/t5300-pack-object.sh: test_expect_success 'pack-object <stdin parsing: [|--revs] with --stdin' '
    @@ t/t5300-pack-object.sh: test_expect_success 'pack-object <stdin parsing: [|--rev
     +	$(git -C pack-object-stdin rev-parse two)
     +	EOF
     +
    -+	# We actually just report the first bad line in strcmp()
    -+	# order, it just so happens that we get the same result under
    -+	# SHA-1 and SHA-256 here. It does not really matter that we
    -+	# report the first bad item in this obscure case, so this
    -+	# oddity of the test is OK.
    ++	# That we get "two" and not "one" has to do with OID
    ++	# ordering. It happens to be the same here under SHA-1 and
    ++	# SHA-256. See commentary in pack-objects.c
     +	cat >err.expect <<-EOF &&
     +	fatal: could not find pack '"'"'$(git -C pack-object-stdin rev-parse two)'"'"'
     +	EOF
    -+	test_must_fail git -C pack-object-stdin pack-objects stdin-with-stdin-option --stdin-packs <in 2>err.actual &&
    ++	test_must_fail git \
    ++		-C pack-object-stdin \
    ++		pack-objects stdin-with-stdin-option --stdin-packs \
    ++		<in 2>err.actual &&
     +	test_cmp err.expect err.actual
     +'
     +
-- 
2.32.0.636.g43e71d69cff


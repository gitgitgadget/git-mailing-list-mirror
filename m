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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6051C07E9B
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 10:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C82A3613D6
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 10:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhGIKTh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 06:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbhGIKTd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 06:19:33 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5128DC0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 03:16:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f17so11435497wrt.6
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 03:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QGppb+d/VHu5BUNN3vzbVgb9BGZUMWwxkQxzX6seH7c=;
        b=WP/2P2TosoFGREIO3e4r5vpegvQgdnp66J8PAYKtdiSTE6JVgAYNnnFmw9VufyBol0
         enZKZg2GHrle7bsmfY+G0fGyuD3/WD3yoqlKT8YAJFkLoqfYdY7RhpJ7Uny9JlJDLbDA
         G2zFNrvbnQms0S5oDskwybmise1iZ3YPFCPn5EsSROHTFOF4YC2wI3uxDKoSqz87RgwV
         Y22Y00L6quY0qOXLknbJ2TdK0Hzkl4BJoyXSkIkBfTzElYIoEStc6kHqwZqNNGEVCs25
         vbw8lD+DTwGKkstpKjpTvsNi+71HLEZTwn4pPFARHVLVP1ISGrbUoRolqh8KudMuRrRl
         22hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QGppb+d/VHu5BUNN3vzbVgb9BGZUMWwxkQxzX6seH7c=;
        b=Ds2+R/6wiN4/T2G52Y4Ci5p4RaI9VbjgQP6Z0emg7gQrdIJtxGfST4eDJDztFBC/Rj
         /X+WjvFud6Gg2f44m96fdGQ/m3CohbM8CFARfi70NZ5i81rqSlibYVdkSi3aAQzEOm8o
         qfhiRivtpuw3VssbyDKECpPivhjLaGcHAg5zAEW53+E2qk7AGirCqXf3Z/zgtdxodXoP
         HnzU+1ITpTR7JCLfc68HoWy2YYYUkhnvnQ+JJJQGilRLcwPNwbBE2HKy0ijS3iR2GXFW
         +qmwZefA/swghEFqVt8tnIvDbURpr8lq49fMk7z5UtdVZOw5A0tkltyHmZKM6E+j9FxA
         /VIQ==
X-Gm-Message-State: AOAM533rWxhKlL61ZunzcgnjEsImBEtIWyQ/+LZyJOTiKr32jxfeaE7x
        MGgI2AW5HrcN3MTa5WS/BHkUY2Fr+Edkqw==
X-Google-Smtp-Source: ABdhPJzxGByRO+LREcd7/1YVdtsSzOtCZGcG9JCEilra+BWWYSEtZs3gQ6ZzwEfCmS4GUeb1E1Frcg==
X-Received: by 2002:a05:6000:231:: with SMTP id l17mr23756904wrz.40.1625825807690;
        Fri, 09 Jul 2021 03:16:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f5sm4878498wrg.67.2021.07.09.03.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 03:16:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] pack-objects: fix segfault in --stdin-packs option
Date:   Fri,  9 Jul 2021 12:13:48 +0200
Message-Id: <patch-2.2-c7315f2b378-20210709T101015Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.2-00000000000-20210709T101014Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210621T145819Z-avarab@gmail.com> <cover-0.2-00000000000-20210709T101014Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a segfault in the --stdin-packs option added in
339bce27f4f (builtin/pack-objects.c: add '--stdin-packs' option,
2021-02-22).

The read_packs_list_from_stdin() function didn't check that the lines
it was reading were valid packs, and thus when doing the QSORT() with
pack_mtime_cmp() we'd have a NULL "util" field. The "util" field is
used to associate the names of included/excluded packs with the
packed_git structs they correspond to.

The logic error was in assuming that we could iterate all packs and
annotate the excluded and included packs we got, as opposed to
checking the lines we got on stdin. There was a check for excluded
packs, but included packs were simply assumed to be valid.

As noted in the test we'll not report the first bad line, but whatever
line sorted first according to the string-list.c API. In this case I
think that's fine. There was further discussion of alternate
approaches in [1].

Even though we're being lazy let's assert the line we do expect to get
in the test, since whoever changes this code in the future might miss
this case, and would want to update the test and comments.

1. http://lore.kernel.org/git/YND3h2l10PlnSNGJ@nand.local

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c | 23 ++++++++++++++++++++---
 t/t5300-pack-object.sh | 19 +++++++++++++++++++
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index de00adbb9e0..df49f656b96 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3311,9 +3311,26 @@ static void read_packs_list_from_stdin(void)
 	}
 
 	/*
-	 * First handle all of the excluded packs, marking them as kept in-core
-	 * so that later calls to add_object_entry() discards any objects that
-	 * are also found in excluded packs.
+	 * Arguments we got on stdin may not even be packs. First
+	 * check that to avoid segfaulting later on in
+	 * e.g. pack_mtime_cmp(), excluded packs are handled below.
+	 *
+	 * Since we first parsed our STDIN and then sorted the input
+	 * lines the pack we error on will be whatever line happens to
+	 * sort first. This is lazy, it's enough that we report one
+	 * bad case here, we don't need to report the first/last one,
+	 * or all of them.
+	 */
+	for_each_string_list_item(item, &include_packs) {
+		struct packed_git *p = item->util;
+		if (!p)
+			die(_("could not find pack '%s'"), item->string);
+	}
+
+	/*
+	 * Then, handle all of the excluded packs, marking them as
+	 * kept in-core so that later calls to add_object_entry()
+	 * discards any objects that are also found in excluded packs.
 	 */
 	for_each_string_list_item(item, &exclude_packs) {
 		struct packed_git *p = item->util;
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 65e991e3706..e13a8842075 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -119,6 +119,25 @@ test_expect_success 'pack-object <stdin parsing: [|--revs] with --stdin' '
 	test_cmp err.expect err.actual
 '
 
+test_expect_success 'pack-object <stdin parsing: --stdin-packs handles garbage' '
+	cat >in <<-EOF &&
+	$(git -C pack-object-stdin rev-parse one)
+	$(git -C pack-object-stdin rev-parse two)
+	EOF
+
+	# That we get "two" and not "one" has to do with OID
+	# ordering. It happens to be the same here under SHA-1 and
+	# SHA-256. See commentary in pack-objects.c
+	cat >err.expect <<-EOF &&
+	fatal: could not find pack '"'"'$(git -C pack-object-stdin rev-parse two)'"'"'
+	EOF
+	test_must_fail git \
+		-C pack-object-stdin \
+		pack-objects stdin-with-stdin-option --stdin-packs \
+		<in 2>err.actual &&
+	test_cmp err.expect err.actual
+'
+
 # usage: check_deltas <stderr_from_pack_objects> <cmp_op> <nr_deltas>
 # e.g.: check_deltas stderr -gt 0
 check_deltas() {
-- 
2.32.0.636.g43e71d69cff


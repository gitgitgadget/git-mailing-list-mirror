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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC235C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 10:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88C2613D1
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 10:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhGIKTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 06:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbhGIKTc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 06:19:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2910EC0613E5
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 03:16:48 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k4so5141787wrc.8
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 03:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6E+7j7uMGkUkVH9Qm7opifl74sbuP3XQCR7dknmh8pM=;
        b=RtTAnn1E6LVNkPlARHW8qLRn0crMCd4JOrkwLsJDBys5YFKwl2k6hIUcc7ZAMqy4AP
         EoUgr1UHUDG1GdFipQr6nWeB/i0AmOKr2HL2TnEx4EH2brYoidAL8z0A1MWiH8EDYtJR
         FfHgr2NAwPS0tl73acPPeFGU348GIm+Wt4dwJQ+v0GyrNefzEG5V9T4Pgsefwiah17PK
         2D4Ff7/qIm/LvbDYhRsghvaJqPt00E40FT1rL2YPGD4XzK1KIzIfi3W0hXTBoXr1UHi4
         UnUGAnAGo93TlSHfTKUTCA7sRDtD6CBc816SDtBMNpjb6QisK6dJJ76U2lsjmraqXFZb
         gxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6E+7j7uMGkUkVH9Qm7opifl74sbuP3XQCR7dknmh8pM=;
        b=S8cvZmybH2T+Uppvwuka6Dn02WW20v1phfLKgCVUC/jJr1qz6aNQt6DyuRnhorfRDT
         By2M4NVLclhIBlbLukqymeXCxdGZZd2fXA8x2d9DOWBMUxQwVpYf2CoVttj2Vp7xd73Y
         PNtCeFB6RWCbDhMZ3fUgGCEEAUsBkQ8WFWKYOhDX7wfcrQUNoW6aAK9U8x7s1cg/sKJj
         FDSA+f1gQZ2XlqjDyTa9q8Xj2rJUSr1fc3zNCXIJ6LYZYJ/BR7ul+SEUjyyVV7APJv/+
         bL6C4Vdx5eRl4o+LJoYui0giA/BAgXGrdcp+Q9w0jycWDB32ZBwhOLROiApv/nO8JLEL
         ZPpg==
X-Gm-Message-State: AOAM533DV7M8BzUbQXgCUixkXfNRiN1ZxMrFcVcoanfw71eXu4Aieat5
        xXQ+aQKOslFqkHE9ub/WoL+AG0b8BxFnmA==
X-Google-Smtp-Source: ABdhPJwx+REPBDxGMXxcs2S5serdGtA73/fbTZ/H1+9RJOsmb4gh9TxCVwVu5kVJo3UjNcAE5ZR+CQ==
X-Received: by 2002:a5d:4492:: with SMTP id j18mr39780544wrq.151.1625825806533;
        Fri, 09 Jul 2021 03:16:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f5sm4878498wrg.67.2021.07.09.03.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 03:16:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] pack-objects tests: cover blindspots in stdin handling
Date:   Fri,  9 Jul 2021 12:13:47 +0200
Message-Id: <patch-1.2-8a4d4b820e7-20210709T101015Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.2-00000000000-20210709T101014Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210621T145819Z-avarab@gmail.com> <cover-0.2-00000000000-20210709T101014Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cover blindspots in the testing of stdin handling, including the
"!len" condition added in b5d97e6b0a0 (pack-objects: run rev-list
equivalent internally., 2006-09-04). The codepath taken with --revs
and read_object_list_from_stdin() acts differently in some of these
common cases, let's test for those.

The "--stdin --revs" test being added here stresses the combination of
--stdin-packs and the revision.c --stdin argument, some of this was
covered in a test added in 339bce27f4f (builtin/pack-objects.c: add
'--stdin-packs' option, 2021-02-22), but let's make sure that
GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true keeps erroring out about
--stdin, and it isn't picked up by the revision.c API's handling of
that option.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5300-pack-object.sh | 85 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 5c5e53f0be9..65e991e3706 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -34,6 +34,91 @@ test_expect_success 'setup' '
 	} >expect
 '
 
+test_expect_success 'setup pack-object <stdin' '
+	git init pack-object-stdin &&
+	test_commit -C pack-object-stdin one &&
+	test_commit -C pack-object-stdin two
+
+'
+
+test_expect_success 'pack-object <stdin parsing: basic [|--revs]' '
+	cat >in <<-EOF &&
+	$(git -C pack-object-stdin rev-parse one)
+	EOF
+
+	git -C pack-object-stdin pack-objects basic-stdin <in &&
+	idx=$(echo pack-object-stdin/basic-stdin-*.idx) &&
+	git show-index <"$idx" >actual &&
+	test_line_count = 1 actual &&
+
+	git -C pack-object-stdin pack-objects --revs basic-stdin-revs <in &&
+	idx=$(echo pack-object-stdin/basic-stdin-revs-*.idx) &&
+	git show-index <"$idx" >actual &&
+	test_line_count = 3 actual
+'
+
+test_expect_success 'pack-object <stdin parsing: [|--revs] bad line' '
+	cat >in <<-EOF &&
+	$(git -C pack-object-stdin rev-parse one)
+	garbage
+	$(git -C pack-object-stdin rev-parse two)
+	EOF
+
+	sed "s/^> //g" >err.expect <<-EOF &&
+	fatal: expected object ID, got garbage:
+	>  garbage
+
+	EOF
+	test_must_fail git -C pack-object-stdin pack-objects bad-line-stdin <in 2>err.actual &&
+	test_cmp err.expect err.actual &&
+
+	cat >err.expect <<-EOF &&
+	fatal: bad revision '"'"'garbage'"'"'
+	EOF
+	test_must_fail git -C pack-object-stdin pack-objects --revs bad-line-stdin-revs <in 2>err.actual &&
+	test_cmp err.expect err.actual
+'
+
+test_expect_success 'pack-object <stdin parsing: [|--revs] empty line' '
+	cat >in <<-EOF &&
+	$(git -C pack-object-stdin rev-parse one)
+
+	$(git -C pack-object-stdin rev-parse two)
+	EOF
+
+	sed -e "s/^> //g" -e "s/Z$//g" >err.expect <<-EOF &&
+	fatal: expected object ID, got garbage:
+	>  Z
+
+	EOF
+	test_must_fail git -C pack-object-stdin pack-objects empty-line-stdin <in 2>err.actual &&
+	test_cmp err.expect err.actual &&
+
+	git -C pack-object-stdin pack-objects --revs empty-line-stdin-revs <in &&
+	idx=$(echo pack-object-stdin/empty-line-stdin-revs-*.idx) &&
+	git show-index <"$idx" >actual &&
+	test_line_count = 3 actual
+'
+
+test_expect_success 'pack-object <stdin parsing: [|--revs] with --stdin' '
+	cat >in <<-EOF &&
+	$(git -C pack-object-stdin rev-parse one)
+	$(git -C pack-object-stdin rev-parse two)
+	EOF
+
+	# There is the "--stdin-packs is incompatible with --revs"
+	# test below, but we should make sure that the revision.c
+	# --stdin is not picked up
+	cat >err.expect <<-EOF &&
+	fatal: disallowed abbreviated or ambiguous option '"'"'stdin'"'"'
+	EOF
+	test_must_fail git -C pack-object-stdin pack-objects stdin-with-stdin-option --stdin <in 2>err.actual &&
+	test_cmp err.expect err.actual &&
+
+	test_must_fail git -C pack-object-stdin pack-objects --stdin --revs stdin-with-stdin-option-revs 2>err.actual <in &&
+	test_cmp err.expect err.actual
+'
+
 # usage: check_deltas <stderr_from_pack_objects> <cmp_op> <nr_deltas>
 # e.g.: check_deltas stderr -gt 0
 check_deltas() {
-- 
2.32.0.636.g43e71d69cff


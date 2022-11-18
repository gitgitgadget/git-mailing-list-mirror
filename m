Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2A7C433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241514AbiKRLrR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241686AbiKRLrI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:47:08 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D56085156
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:47:07 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id gv23so12442435ejb.3
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST5HLlFMCCR17IA9DT6M4TPm2jEcQSxejTvgA6hgMkE=;
        b=pZSuUv20L9KRKy6STXgZe2AyZ6CkcKm84Ub710nMcpsQODhWeGZCMETmTjQrlnEKKT
         sjkT2v8rfb/mkaczr96+v/O3JI10ekR12+r4hJKQTEvmDN1SLnXM0/1nSyXVZFmRuMZY
         BMAxb9E0u9d9WJWpulB6qOuwtL1rcpsTpfmpc1PSs+nIjrPE/EavZpbeaBpXUX5xnUfb
         TVLBtwOpvY4hi3k4dT3lNMRR5vJNF1IF/4202gWRei/EpEL8Su2o6pyzT/hKbUkTB+xe
         wdWSqwK2dWLHxjoDBFBi3MiuZAnpH99hP0gE0j0UW3uS+1TkXD7Zq4uNy6q3rpnB6fVG
         i7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ST5HLlFMCCR17IA9DT6M4TPm2jEcQSxejTvgA6hgMkE=;
        b=WSbdSO5Qu7ACCqPTIlwJjxuf5xn04jHo/JUQHwOWg7OpJcr35AAbnKZ2uEg4Bq9elN
         kHvChK5qSCPR1ceKzqUwjXHi4XFeEq02TZzQrt//SRZ3NE7hnY4zwPkrAjvkvGEQmdeO
         DPUpDm7UQ1ivBntERCo0vH+YLJepM0QRmsLqWitX1QLw+7eP9nehnKbKyAq3OwXTrW5V
         VV6qKOk1K/7dsC8BWLzrcnRRfnZt/D57XCgcPYcXnFt4SpSaaXvvS34qhR41EXUY8Goq
         HgP9hphqywIF8hwbl9TgQfjjJEXN5byv0ZFlDlfD8QYL8YQQwaQycogjG3gQti5sOD0Z
         QOGA==
X-Gm-Message-State: ANoB5pmngNgL/crytDV5hJpbZ6STcZ3VGxZSU5sSSDQOVJI9SSo2RyTd
        Lf2ZLsQjpPcx/QeoyE5d/9Dds9JgBjtRoA==
X-Google-Smtp-Source: AA0mqf5uxIJLX8AK8heMvQFt99Nlb5qSGAIjGIUopi6e1Ed/w+enYyX0o+kJVTxaUOs0Fx64KhKpBg==
X-Received: by 2002:a17:907:378:b0:7ad:db82:d071 with SMTP id rs24-20020a170907037800b007addb82d071mr5925594ejb.200.1668772025696;
        Fri, 18 Nov 2022 03:47:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o8-20020aa7dd48000000b004615e1bbaf4sm1705349edw.87.2022.11.18.03.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:47:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/4] tag: don't emit potentially incorrect "object is a X, not a Y"
Date:   Fri, 18 Nov 2022 12:46:59 +0100
Message-Id: <patch-4.4-1a9dcb9e05d-20221118T113442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1512.g9e0c09a155f
In-Reply-To: <cover-0.4-00000000000-20221118T113442Z-avarab@gmail.com>
References: <Y3a3qcqNG8W3ueeb@coredump.intra.peff.net> <cover-0.4-00000000000-20221118T113442Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in the preceding commit we weren't handling cases where we
see a reference to a bad "type" in a "tag", but then end up not fully
parsing the object.

In those cases let's only claim that we have a bad tag pointer, but
emit "is a %s, not a %s".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6102-rev-list-unexpected-objects.sh | 6 +++---
 tag.c                                  | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index 2e36d8bcfd9..ffc1672d7dc 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -231,7 +231,7 @@ test_expect_success 'traverse unexpected non-tag tag (tree seen to blob)' '
 '
 
 
-test_expect_failure 'traverse unexpected objects with for-each-ref' '
+test_expect_success 'traverse unexpected objects with for-each-ref' '
 	cat >expect <<-EOF &&
 	error: bad tag pointer to $tree in $tag_tag_tree
 	fatal: parse_object_buffer failed on $tag_tag_tree for refs/tags/tag_tag_tree
@@ -241,7 +241,7 @@ test_expect_failure 'traverse unexpected objects with for-each-ref' '
 '
 
 >fsck-object-isa
-test_expect_failure 'setup: unexpected objects with fsck' '
+test_expect_success 'setup: unexpected objects with fsck' '
 	test_must_fail git fsck 2>err &&
 	sed -n -e "/^error: object .* is a .*, not a .*$/ {
 		s/^error: object \([0-9a-f]*\) is a \([a-z]*\), not a [a-z]*$/\\1 \\2/;
@@ -251,7 +251,7 @@ test_expect_failure 'setup: unexpected objects with fsck' '
 
 while read oid type
 do
-	test_expect_failure "fsck knows unexpected object $oid is $type" '
+	test_expect_success "fsck knows unexpected object $oid is $type" '
 		git cat-file -t $oid >expect &&
 		echo $type >actual &&
 		test_cmp expect actual
diff --git a/tag.c b/tag.c
index 19453c2edbf..ad92cf89209 100644
--- a/tag.c
+++ b/tag.c
@@ -193,8 +193,9 @@ int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, u
 	}
 
 	if (!item->tagged || strcmp(type_name(item->tagged->type), type)) {
-		error(_("object %s is a %s, not a %s"), oid_to_hex(&oid),
-		      type_name(item->tagged->type), type);
+		if (item->tagged && item->tagged->parsed)
+			error(_("object %s is a %s, not a %s"), oid_to_hex(&oid),
+			      type_name(item->tagged->type), type);
 		return error("bad tag pointer to %s in %s",
 			     oid_to_hex(&oid),
 			     oid_to_hex(&item->object.oid));
-- 
2.38.0.1511.gcdcff1f1dc2


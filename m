Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E04BC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C1F61A81
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352923AbhJAJSs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352909AbhJAJSp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:18:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60C9C06177B
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 02:17:01 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v25so3781659wra.2
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 02:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wL6wy4yENQiqFUkjAqTNTpNOV0/LP04Rh3m6j5j9Zzw=;
        b=UqAWkzGer5Ue69MPAaoQ/sdrJ/lNziv/0em3rFbgBDsAnCHRDGeBF3S6QZ6JngKC9z
         XO0ssu+ANILhQe8Qj4vSTi2vmgYCwGGXt1sw9zvFPANU+WyKxXWAUrdH42Xu43DHZT2q
         Ta7qh8L+O/ePSy84GUB7wm10wYxWigCV3N4CdE1UWzI5YR17jb9eiGcgwtFCw94sGfb5
         NL0+mkJyoQeFJIgN/WMovPqPQRG7c0qgsa089H9Ax1VVBwYOOx4fR31rjwptlaJYKSVq
         s2n/XOXVRxCJIQO0KbmM0xlzY2eb8BYeEcBeFWTEWaY3pQH4z0BCLMXB4eUWwc/FuLi/
         li6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wL6wy4yENQiqFUkjAqTNTpNOV0/LP04Rh3m6j5j9Zzw=;
        b=GTJUPJCtNgfu4kPq1059tmUBJrk7Shf3t5QSWvZMG/UxK/uqaGAW3zSg8kGsJ2Lb9Z
         dDIgQSEdHejuXwpn2qkgSoyvGGs9sioor0S5VWTJDV919/iv0a8dk2Tbza0hUcSngC7+
         H35R9wXLqUnvpKcjYsNTZT1j+jj85tIUqCF6kDRA0A997LdNdQoSUgXxnUq05iD+L7Ub
         dYlUl339akF2g8DAl04b53QQ2OVNmPm1XLTmctihAaq4ytoMivsGe1EvGziaNVHXPEUd
         HPYOAQ6xSeLqcQv382bY8V+PPRo3dweG2B57NMW+khcaDI9diGCRZZoNjxvengeSUwUp
         Me0w==
X-Gm-Message-State: AOAM533SKJM8LdF+uxx5zmyv0R4Udi/QoDpOZIU9NfGrvcnRcd2z+tpb
        hKqq8c2bBEAfZwzBqYlZwniEBE1i7U3ziA==
X-Google-Smtp-Source: ABdhPJzr1q1X24yejUPJc40Taru/ajtlcUZjXTD5dh/Er7AsY5dvwBPsHkDiFgDWN/f4F6RCa6/VcQ==
X-Received: by 2002:a5d:6da9:: with SMTP id u9mr11034294wrs.155.1633079820141;
        Fri, 01 Oct 2021 02:17:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j4sm5301346wrt.67.2021.10.01.02.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 02:16:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 03/17] fsck tests: test current hash/type mismatch behavior
Date:   Fri,  1 Oct 2021 11:16:39 +0200
Message-Id: <patch-v10-03.17-00d661a6032-20211001T091051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1375.g5eed55aa1b5
In-Reply-To: <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
References: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com> <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If fsck we move an object around between .git/objects/?? directories
to simulate a hash mismatch "git fsck" will currently hard die() in
object-file.c. This behavior will be fixed in subsequent commits, but
let's test for it as-is for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1450-fsck.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index b73bc2a2ec3..f9cabcecd14 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -69,6 +69,30 @@ test_expect_success 'object with hash mismatch' '
 	)
 '
 
+test_expect_success 'object with hash and type mismatch' '
+	git init --bare hash-type-mismatch &&
+	(
+		cd hash-type-mismatch &&
+
+		oid=$(echo blob | git hash-object -w --stdin -t garbage --literally) &&
+		old=$(test_oid_to_path "$oid") &&
+		new=$(dirname $old)/$(test_oid ff_2) &&
+		oid="$(dirname $new)$(basename $new)" &&
+
+		mv objects/$old objects/$new &&
+		git update-index --add --cacheinfo 100644 $oid foo &&
+		tree=$(git write-tree) &&
+		cmt=$(echo bogus | git commit-tree $tree) &&
+		git update-ref refs/heads/bogus $cmt &&
+
+		cat >expect <<-\EOF &&
+		fatal: invalid object type
+		EOF
+		test_must_fail git fsck 2>actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'branch pointing to non-commit' '
 	git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
 	test_when_finished "git update-ref -d refs/heads/invalid" &&
-- 
2.33.0.1375.g5eed55aa1b5


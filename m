Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47484C48BC2
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 15:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2762361151
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 15:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhFUPGA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhFUPF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 11:05:57 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36E1C061756
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 08:03:42 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c84so10717895wme.5
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 08:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UzaEbYpDgAe2DKw3PX2eCQh16rWu6u4aMso01MeMx18=;
        b=sMgnghqhc0vN/Ggb7H73NszhMIZshDFOK2sLDoMjznb2FewOmR60W6IThrRNnu1gJg
         mOy+ipGUMgyOREv63wkpz3FlS/dWYxHc37IsRjEgq4w+tSwjLEaoCGRUa028eiNsSdGz
         18QMdIosTqp3KaA0T2hroMiuFNPiqarSWQETB8HASsnq9wVlaR7bEsZDeAjmGgzKtz7t
         I8v7WWQrxYkchq/Rt9ItnjA+PUShcpkSKndDFRVMrKfApWUYSpY6jmvEUn+DYX+x0q4r
         8bnPODevzi7A5ndcdUEAi70NWGsfAKQPsmufcTFjE9tI/nrPcNh/vu9R4sCDEtxp44NJ
         ZaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UzaEbYpDgAe2DKw3PX2eCQh16rWu6u4aMso01MeMx18=;
        b=jFkqnkkqoiB54M1ed2Zk+gg+r78kG+DFHKBpZRYYQxthokuV76pn96zeX6Wp21SFs+
         UrvP8WdJXgTVe/Xo5E/TUI+1YganZBLYBfU7tZSvN2dW96QMEq+dSR9XoMDrIIqOS8KO
         0jxPi07NlV9H1lCWC+snZEBPmsLv0PzAF1CKbSQR+6PXOuP3kpDCSr+fBG/6Lwd5PJOT
         g5iDUWHZRTv7knojSnPafaQAYlOEAZRCVX6xsnRhwHooehMTya7Ue7hZx61Al+JnSy8D
         hADEhxmOayJQkOoy5jATtZOBIGFSjo8utYVKga5M56CLVBPRttq4OrgnxMANPWGGLdU+
         QTFw==
X-Gm-Message-State: AOAM531QMG8Y8ntz41haynLDan0DPf1zsNOtnRwJaP32GQvSpcekCrVQ
        5lsn+oOgu50zwbmJKl5tu3kwWyygrMTnMw==
X-Google-Smtp-Source: ABdhPJz3EQBiH+meG+9LNzlFgsI7JneC+CVObY1Psi5/vuuL/qbyW06/cHgzWk72u2O3FZmVXTKdzg==
X-Received: by 2002:a7b:c410:: with SMTP id k16mr631092wmi.28.1624287821220;
        Mon, 21 Jun 2021 08:03:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y4sm11931939wrw.71.2021.06.21.08.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 08:03:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] pack-objects tests: cover blindspots in stdin handling
Date:   Mon, 21 Jun 2021 17:03:37 +0200
Message-Id: <patch-1.2-dd2efd1cfb9-20210621T145819Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-0.2-00000000000-20210621T145819Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210621T145819Z-avarab@gmail.com>
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
2.32.0.599.g3967b4fa4ac


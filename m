Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8755CC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70D3E61262
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbhI1CUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 22:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238618AbhI1CUq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 22:20:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF146C06176C
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:07 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id b192so2120841wmb.2
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=941xkVdEIIfKskTrUanhKcz+5TrptFvB/pvltBzo3Rc=;
        b=Kn8ueQhi6YKMpzD+Ie1ri2dn9Zweusxpsr1RGnGCcqX+DCep6AMlSwljKpXoI7VAqd
         5J8U3Byb5leIVkazEFduQs+iLemSd0EjYoqR5q6a1wczYKgF7Njzf44in/Ira7kWjbdh
         3RLGD446YP7jOpuESZj6Y18YtTPTJ8TA9H/GOYhXn421WSXaiInY4Tymo3sghwIEPpaL
         Gwj7CTQ6yZsr6ijkgZiOYdNUr83XD8PMRZ8mcXdjeUUCCCizidiIjrbwG8QUXLtbUOgA
         6GCvtXCcGowopULsYIUwcAvnKMN7mEdz89LZlISPbXStJK80FTH0p7pqul8iAeNTinvG
         EP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=941xkVdEIIfKskTrUanhKcz+5TrptFvB/pvltBzo3Rc=;
        b=y7Z4ncpQnVuHOLgU2QdvATwm5VrMmycpiD5ssLc0ShxjkFI2ZxZ6JVwn3fhLGMjLmK
         sWbt/D3SHdxoK5DdX7+h04WZsvqIuQnpKgTHKgFje8ADdunyQQzCwcCQQqpaHA+czlVk
         J9wXf9nPm3/COFgb8LxTEjiVA/J/m2uY12EwiteeGpVSjoR/sV1e78Bz5Yixhb/40Z60
         TGyFBBxXGPbp9P8V/VUFipsQhua93aTE99KAxkNsfQjeaMxivmGbZ4/Iu4iJsJZo6Pf/
         LfdfTIXMBNfWnO2J/EcVftFZuUGP2Btef7cxnz+ze3ZJsx+QRyxAksRDEEznQlTm7j/F
         3u/Q==
X-Gm-Message-State: AOAM5334TmliC9+QfRBN73AgY+PBPSeaduYuHz7/tmtKJfFIz9p6oXYK
        mm2+GlSz08DDMrr5vc/nrnUfM+B4+JuQTQ==
X-Google-Smtp-Source: ABdhPJwM8NDKCiPSRhC1i4bQGWMEAxxE42VTb8cDv05wKSEmO/um+XbWtZ08y+ugU9DELak1T2b5jA==
X-Received: by 2002:a05:600c:230b:: with SMTP id 11mr2283736wmo.102.1632795546184;
        Mon, 27 Sep 2021 19:19:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c132sm1126987wma.22.2021.09.27.19.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:19:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 08/17] cat-file tests: test for current --allow-unknown-type behavior
Date:   Tue, 28 Sep 2021 04:18:49 +0200
Message-Id: <patch-v8-08.17-215f98ad369-20210928T021616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1327.g9926af6cb02
In-Reply-To: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
References: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com> <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add more tests for the current --allow-unknown-type behavior. As noted
in [1] I don't think much of this makes sense, but let's test for it
as-is so we can see if the behavior changes in the future.

1. https://lore.kernel.org/git/87r1i4qf4h.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1006-cat-file.sh | 61 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 15774979ad3..5b16c69c286 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -402,6 +402,67 @@ do
 	done
 done
 
+test_expect_success '-e is OK with a broken object without --allow-unknown-type' '
+	git cat-file -e $bogus_short_sha1
+'
+
+test_expect_success '-e can not be combined with --allow-unknown-type' '
+	test_expect_code 128 git cat-file -e --allow-unknown-type $bogus_short_sha1
+'
+
+test_expect_success '-p cannot print a broken object even with --allow-unknown-type' '
+	test_must_fail git cat-file -p $bogus_short_sha1 &&
+	test_expect_code 128 git cat-file -p --allow-unknown-type $bogus_short_sha1
+'
+
+test_expect_success '<type> <hash> does not work with objects of broken types' '
+	cat >err.expect <<-\EOF &&
+	fatal: invalid object type "bogus"
+	EOF
+	test_must_fail git cat-file $bogus_short_type $bogus_short_sha1 2>err.actual &&
+	test_cmp err.expect err.actual
+'
+
+test_expect_success 'broken types combined with --batch and --batch-check' '
+	echo $bogus_short_sha1 >bogus-oid &&
+
+	cat >err.expect <<-\EOF &&
+	fatal: invalid object type
+	EOF
+
+	test_must_fail git cat-file --batch <bogus-oid 2>err.actual &&
+	test_cmp err.expect err.actual &&
+
+	test_must_fail git cat-file --batch-check <bogus-oid 2>err.actual &&
+	test_cmp err.expect err.actual
+'
+
+test_expect_success 'the --batch and --batch-check options do not combine with --allow-unknown-type' '
+	test_expect_code 128 git cat-file --batch --allow-unknown-type <bogus-oid &&
+	test_expect_code 128 git cat-file --batch-check --allow-unknown-type <bogus-oid
+'
+
+test_expect_success 'the --allow-unknown-type option does not consider replacement refs' '
+	cat >expect <<-EOF &&
+	$bogus_short_type
+	EOF
+	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
+	test_cmp expect actual &&
+
+	# Create it manually, as "git replace" will die on bogus
+	# types.
+	head=$(git rev-parse --verify HEAD) &&
+	test_when_finished "rm -rf .git/refs/replace" &&
+	mkdir -p .git/refs/replace &&
+	echo $head >.git/refs/replace/$bogus_short_sha1 &&
+
+	cat >expect <<-EOF &&
+	commit
+	EOF
+	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success "Type of broken object is correct" '
 	echo $bogus_short_type >expect &&
 	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
-- 
2.33.0.1327.g9926af6cb02


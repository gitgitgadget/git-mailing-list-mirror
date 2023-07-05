Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E5DC04A94
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 19:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbjGETuS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 15:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbjGETuM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 15:50:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C372D1981
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 12:50:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99313a34b2dso423464666b.1
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 12:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688586609; x=1691178609;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gOyQmT03UcfLFqZ5u2L9tJlQRdHPivGO2giZnWmPV2c=;
        b=Byo2AX5W0GceDV1xmx/efPvnlwcUZ5dphWOHa1WgQr2HVegv/avvBMuwCNi5hisPXk
         iCaIpM3htwyaZle7YpDaAAYA1wMPRa+9Q4Or6zWKG+eHup8BOAMtJCB/xFR8g+5TL0sF
         4/UKCaagg7avdHTgVrEi+/bYn+z5xVmV8JEr05UryQt9wB91PBC1wpnjcZL8RZxvjwpa
         MxDlMvPfdlZo9cN8momJstx2V+Oebc4o05ligDB4K6DXmHoltcYfxy/dqZDnrqgiF/PB
         32q42ql8U6yJtznAUQ4gEsdUSO6EHuGFSo42Ftm+2Z0O0xo+86oE5GjqJTgq3LF/bxqU
         W+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688586609; x=1691178609;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gOyQmT03UcfLFqZ5u2L9tJlQRdHPivGO2giZnWmPV2c=;
        b=K039m2SP4BSATPYTG+gmA3nfl//kERbO5oMwYvy96zJQebL8h8sTV+1W91D7EeYq+e
         fqZTXumPbsi3dNAUJVj9it36yZzlsa4U0X2JdGuOrVRMvCTKRduUxqmJfaNEHP1PXpf1
         xFuxiuZz8/ujajt6tG+R7BxrtWCXNB2JoMK5FSmZoo5QNzIHe3+u5QvWYQLhD2Sh8Ygb
         53l1gy1AuVdbLGcxvBGpMkc1ioUkjv1achDEPujvzwmQO6L/073P09F+tYDIDBO0GjDq
         0KTgWl4y3UswMqwm4wOtl798Uqd2yqytSvIHojaCezT3T/qUlehWBFbMlMLBvhk/aC+f
         FDIA==
X-Gm-Message-State: ABy/qLbr4p/9q9tNAJOLgHmYstFkBEaJLMeoWu9VJ6oV470kko1T+c4L
        +2aMflyyQrzVVIhJKsjW27VedCUy3ww=
X-Google-Smtp-Source: APBJJlGyYd3LYAhfup6isRhj0OeLSNuxSR9S0RbhYnInnGVaEBBVBKKhNXfAmB33jIhCcfpPeqhpnQ==
X-Received: by 2002:a17:906:24d:b0:973:e349:43c9 with SMTP id 13-20020a170906024d00b00973e34943c9mr13240436ejl.77.1688586609122;
        Wed, 05 Jul 2023 12:50:09 -0700 (PDT)
Received: from localhost.localdomain ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id bx1-20020a170906a1c100b00992665694f7sm10078341ejb.107.2023.07.05.12.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:50:08 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 3/4] t4054: test diff --no-index with stdin
Date:   Wed,  5 Jul 2023 20:49:29 +0100
Message-ID: <1c7db4dbe26715912672630c1a5659591931cb2d.1688586536.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.40.1.852.g0a1e0755a6
In-Reply-To: <cover.1688586536.git.phillip.wood@dunelm.org.uk>
References: <cover.1687874975.git.phillip.wood@dunelm.org.uk> <cover.1688586536.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

"git diff --no-index" supports reading from stdin with the path "-".
There is no test coverage for this so add a regression test before
changing the code in the next commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t4053-diff-no-index.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 5bfb282e98..4870443609 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -205,6 +205,25 @@ test_expect_success POSIXPERM,SYMLINKS 'diff --no-index normalizes: mode not lik
 	test_cmp expected actual
 '
 
+test_expect_success "diff --no-index treats '-' as stdin" '
+	cat >expect <<-EOF &&
+	diff --git a/- b/a/1
+	index $ZERO_OID..$(git hash-object --stdin <a/1) 100644
+	--- a/-
+	+++ b/a/1
+	@@ -1 +1 @@
+	-x
+	+1
+	EOF
+
+	test_write_lines x | test_expect_code 1 \
+		git -c core.abbrev=no diff --no-index -- - a/1 >actual &&
+	test_cmp expect actual &&
+
+	test_write_lines 1 | git diff --no-index -- a/1 - >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'diff --no-index refuses to diff stdin and a directory' '
 	test_must_fail git diff --no-index -- - a </dev/null 2>err &&
 	grep "fatal: cannot compare stdin to a directory" err
-- 
2.40.1.852.g0a1e0755a6


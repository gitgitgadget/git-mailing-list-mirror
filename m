Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D94BC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EABC76127A
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238608AbhI1CUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 22:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238592AbhI1CUm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 22:20:42 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27C5C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:03 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g16so55222739wrb.3
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P50YPnIH11C10wWjZFy8wMfbPIc/A+tG21VtHGADvtk=;
        b=Si+cozM95/UlWG8Zz2g/a1yP/jFSN8cleaIIF8whIwBc2NjgjAj0ktap6cqr1DAZWd
         5k35GCtCCcXChnKIqOAM9VxbakW4dszsfhgv7rB/gfHML4+5o8MzGm0DaZHgAijHtT9K
         w11JRrhk+r0/iW7K+1p1B+h0N+AAz37dx4SHcbpdhttIGLCrxLAs+CG1q4PMuwWNuIOb
         ZGwgZjBE3jh0o1fcse7gE67MtpHk3Oqajsh2cV9tk1strbW4oFfdR2M31kiaidOHvJaG
         x/Hx1lVkq+xeGAIEYRKK0xB2332vSqOtdsmK8bkVB+IQ3i6XkZ8yri2qD1qDA9WgWY1v
         XKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P50YPnIH11C10wWjZFy8wMfbPIc/A+tG21VtHGADvtk=;
        b=JDV/CBSC1lDug9N+f7+eEj8RMLpIzCL1zy4TmQD42Xmx3aHcS7XJ5nvY2/aAgBm5ZQ
         bI97rVcjuEn3f42tGIlPEDNC+/Ut80B0MijTMIfAiYuA0h17Jbv3Wo6G38av9qf4sG7E
         o3NF/6SCj+vTn6L+bRo7nXWR6J8Cm7jfbY0IN0pwDKYP2kjNLzak8x1CziMiA93c9/ad
         zZKZdYKu8gaWRDsiQv3NpNdsxako7M2e4zWhoFlsWIHF3cR078GMvmWfDfGNx2L49gsu
         ar/py5J0VUHWh3bRccrvP5mieRhoLjNBfhe0XJmG0kz0OrOMEux3csbAf97hKLsLTkui
         TDHA==
X-Gm-Message-State: AOAM532l7Q8Ubt2EgObnetMNEj2yJHOvxkt+emVi3TWHO59cTE7wJvZo
        BxXr+uLoDi9O7bYE310GPBPwswkI/z0+qA==
X-Google-Smtp-Source: ABdhPJyuyW8Rwnd4XTqkGrA4/mT94DRcYuRQWzzIzJulrfLYYezGuzSiBGHwJ/oEWdulfQlht6E8zQ==
X-Received: by 2002:a5d:664f:: with SMTP id f15mr2303454wrw.143.1632795542330;
        Mon, 27 Sep 2021 19:19:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c132sm1126987wma.22.2021.09.27.19.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:19:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 03/17] fsck tests: test current hash/type mismatch behavior
Date:   Tue, 28 Sep 2021 04:18:44 +0200
Message-Id: <patch-v8-03.17-93197a7bcee-20210928T021616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1327.g9926af6cb02
In-Reply-To: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
References: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com> <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
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
index f8edd15abf8..175ed304637 100755
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
2.33.0.1327.g9926af6cb02


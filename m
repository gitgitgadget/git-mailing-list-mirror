Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A25C49361
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30FCD613BF
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhFQKoV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhFQKoR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:44:17 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA271C061767
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:42:08 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso6032121wmh.4
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=36bwokKYWmY161A+2G1dJi4xe/jqNPMXHxdMDmkvcvM=;
        b=HBqQKEIQNxeAN6TlqZmutZDU1R1PAnnIyo6FOsAv6iewMsW/fYqDa3Am3ujJFRfIRu
         nOj3PYGG00urOAiYvUncKGBNdZoNUw+tggv4CpZNYwxEiuJTukT4HFIB1LEwKafSPUZ4
         Yru/8Ix4FL3GBHxQmbhjBdTpJYxuuwZSYVJIHBJu71/gQy5PYucbntyCmG8tCJAzSkpX
         QsDUnVUJp6g7PbuPaCPCzjndCH6vtmg2xnkmVLBMyhEMSGltRKbDfzqL2tXJU3pblNPo
         BeGm7ve6KaMtMtS1jpZs3mcqYNcemyOBkCj5KAaYyvo7ui+dPQ4s82oDEmRB8zLK2B+g
         y54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=36bwokKYWmY161A+2G1dJi4xe/jqNPMXHxdMDmkvcvM=;
        b=gdRLdesEnyy1h5wddQX8cjO4ITOf34AGqTG2s2X09zp+VlQqiHUN5Od1w96OlRvq1l
         wcO2J70Xihr5kAqiPK/EXxe4j2h3RMwasHl3GlddRDiYwREmbaAPvjx3EbYa5YMTPFXV
         HLRd2+ntGAn9yvJ/AyW7UzKMH25n1uEHrgKKqDtKr4/uKplPfgxmRgeA8uNIHEONCt4T
         rWgZNbLIoJuG+VoSyFAr+lS6Xbtt+qrsHmgD0EiGs8Q7fCmoWhG/9D2kEzDS+wR41/hb
         B7QjQBXO4HsZYVzyGlV4T83lYYBb9kjm5JYAIi1+pO5Xsh3FxtXZTCY6T08lC76qf4UK
         A0/A==
X-Gm-Message-State: AOAM533S7cmTMaskA2QzLIKThQBAcxlpCi0Zkg+/8QvH9YhWAutwQAv+
        pZQzbEX4jmF7KONZ7FlPeJR/bY7/NqDnvQ==
X-Google-Smtp-Source: ABdhPJzTOfQG3B+Erc1INzEjIjx0MEAc4nHIc62X4DWVzKa/3MOSVGFtGqxSLxXix6yH2SaWEuq4LA==
X-Received: by 2002:a1c:e456:: with SMTP id b83mr4301096wmh.178.1623926527322;
        Thu, 17 Jun 2021 03:42:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p10sm4784607wrr.33.2021.06.17.03.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:42:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Jeff King <peff@peff.net>, Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/6] mktag tests: test update-ref and reachable fsck
Date:   Thu, 17 Jun 2021 12:42:00 +0200
Message-Id: <patch-4.6-a1d95c81ea-20210617T104011Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.571.gdba276db2c
In-Reply-To: <cover-0.6-0000000000-20210617T104011Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com> <cover-0.6-0000000000-20210617T104011Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the mktag tests to pass the created bad tag through update-ref
and fsck.

The reason for passing it through update-ref is to guard against it
having a segfault as for-each-ref did before c6854508808 (ref-filter:
fix NULL check for parse object failure, 2021-04-01).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 78c6f64e36..67f6ecbe88 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -44,11 +44,13 @@ check_verify_failure () {
 	'
 
 	test_expect_success "setup: $subject" '
+		tag_ref=refs/tags/bad_tag &&
+
 		# Reset any leftover state from the last $subject
 		rm -rf bad-tag &&
 
 		git init --bare bad-tag &&
-		git -C bad-tag hash-object -t tag -w --stdin --literally <tag.sig
+		bad_tag=$(git -C bad-tag hash-object -t tag -w --stdin --literally <tag.sig)
 	'
 
 	test_expect_success "hash-object & fsck unreachable: $subject" '
@@ -59,6 +61,23 @@ check_verify_failure () {
 			test_must_fail git -C bad-tag fsck
 		fi
 	'
+
+	test_expect_success "update-ref & fsck reachable: $subject" '
+		# Make sure the earlier test created it for us
+		git rev-parse "$bad_tag" &&
+
+		# The update-ref of the bad content will fail, do it
+		# anyway to see if it segfaults
+		test_might_fail git -C bad-tag update-ref "$tag_ref" "$bad_tag" &&
+
+		# Manually create the broken, we cannot do it with
+		# update-ref
+		echo "$bad_tag" >"bad-tag/$tag_ref" &&
+
+		# Unlike fsck-ing unreachable content above, this
+		# will always fail.
+		test_must_fail git -C bad-tag fsck
+	'
 }
 
 test_expect_mktag_success() {
-- 
2.32.0.571.gdba276db2c


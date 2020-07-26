Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D26C433DF
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 14:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E0D12065F
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 14:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NABGNQ4j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgGZO0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 10:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgGZO0O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 10:26:14 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DE5C0619D2
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 07:26:14 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t6so7996738pgq.1
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 07:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I2x4nvf5u7YHLs/rvuQ2DKG/frGYuFxUPbbH8Ur2AHA=;
        b=NABGNQ4jISqfIf4KjeMNSJ4qb2+5n5awMayQraRWHQOLGp8Qph63X9tPrWRZikdKCX
         aK3lLJ+sXhEoxgHJqf6iMldB1Iqj4cvJ4KwwgligXHmcaRw5Z4uleGrKkYsii0rvM5aw
         H2j4IlXpQ0vtDpQ6wQfe7YUVW1XUwt1wKvkjPGbaAs4UvHFjVS1ohzu2AhghufQaGNi+
         jJqbK1R3EPu5umXbwXWZcubHRR+L4syFDSs0T1fV/sKK2ajrYM3VRapwk/nqiOujGOsS
         FJvk5hXuboIOwPBjxbkKPw4pqR2gZXYbMN7FX/6u6TdbGBwOlo2usRA1ixoy7TQBR3N3
         tW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I2x4nvf5u7YHLs/rvuQ2DKG/frGYuFxUPbbH8Ur2AHA=;
        b=i9MViKbhhyJcza0uzAlt7dV6vtRfv2kBICBYD8yEcTMH/WIVbq83A38K1WZnT0zmyU
         w7Weygq7g0tQsVzH7NR2qN7qr+Efe19nH05xb0CbgdWHUeOVJBCXjzR/ZWwEPKHYn7gs
         wbcxFuERO6k3+zPf+dLipPTtD1KHAUr0NmPe9icuc0GOfwXoZD9AdlI/KsKD7xuiVkee
         53RZXJ775M1NfA8Z07mrui28frQA4xExLtngHrOKsATq2+2MtDNt1o+94BWjCHtDvNzU
         PSHoYGskb0sdyINai+hezDPdG6Tb/LqeDG8oOdp4nsXH6mANKzoVShkVZJjRBjuVHwV5
         ixtA==
X-Gm-Message-State: AOAM530+6cygr4pNN9x5dEpx0Vc9uCW8il+3Lsso8s2g/JrpZG7xc/A9
        a7EerZQF6b62AhnqureM/e+tsZzNIaU=
X-Google-Smtp-Source: ABdhPJxVqgXRXEmB+ysTbd1UBADhgrL9BLA2jGHX7jcvzqfkFdbJ9ZFvlk1UyyjaGzhLavO8iu6zOw==
X-Received: by 2002:a63:7e55:: with SMTP id o21mr16433946pgn.263.1595773573417;
        Sun, 26 Jul 2020 07:26:13 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.48])
        by smtp.gmail.com with ESMTPSA id p11sm11278908pjb.3.2020.07.26.07.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 07:26:12 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de, peff@peff.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [PATCH 1/4] t7401: modernize style
Date:   Sun, 26 Jul 2020 19:55:50 +0530
Message-Id: <20200726142553.42545-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200726142553.42545-1-shouryashukla.oo@gmail.com>
References: <20200726142553.42545-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests in 't7401-submodule-summary.sh' were written a long time ago
and have some violations with respect to our CodingGuidelines such as
incorrect spacing in usages of the redirection operator and absence
of line feed between statements in case of the '|' (pipe) operator.
Update it to match the CodingGuidelines.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 t/t7401-submodule-summary.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 9bc841d085..4439fb7c17 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -16,12 +16,13 @@ add_file () {
 	owd=$(pwd)
 	cd "$sm"
 	for name; do
-		echo "$name" > "$name" &&
+		echo "$name" >"$name" &&
 		git add "$name" &&
 		test_tick &&
 		git commit -m "Add $name"
 	done >/dev/null
-	git rev-parse --verify HEAD | cut -c1-7
+	git rev-parse --verify HEAD |
+	cut -c1-7
 	cd "$owd"
 }
 commit_file () {
@@ -125,7 +126,8 @@ commit_file sm1 &&
 head3=$(
 	cd sm1 &&
 	git reset --hard HEAD~2 >/dev/null &&
-	git rev-parse --verify HEAD | cut -c1-7
+	git rev-parse --verify HEAD |
+	cut -c1-7
 )
 
 test_expect_success 'modified submodule(backward)' "
-- 
2.27.0


Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A749C433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 17:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 387002087C
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 17:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G38o642g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbgGaRpU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 13:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbgGaRpU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 13:45:20 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6474C061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 10:45:19 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t14so4766198wmi.3
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 10:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Mf8a3G3NSLpsBrWCpP67p7JCOtkfPOxPfvarwYNHJM=;
        b=G38o642golPGiSYQfH+0qtfnsWsUBedoEuDmwNRxmIZjfw3dJVBBML7hh3lskYmAdJ
         rVYRygSR101Wfgkbh/rC7tBToj0Mzb17Tn/v978HmBfR58BFgZ3cNm2nMeqoyCafuFav
         +KYhUSBomBWT6ft3SMXOsZWUjsrf6+5qCR5DStmfGJrQJZTgvMH8zEjRgfuLBrQiwKXS
         pexZ0CqlDw0n3BQ6gzRsT//eYY5nBgICqlf/ejWBTU+/AMs+Bf31jjoiUBKFR/CfLFvp
         /zj/B9H4CJM12fBlddXuv1cjndxYWZBZs80vp6olLPdH/UhNNwfvNzkybyMJbJ6oO45M
         nKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Mf8a3G3NSLpsBrWCpP67p7JCOtkfPOxPfvarwYNHJM=;
        b=Vb5cMEgKzgzHz4Tu2kZkT9M03yXqWui2fiwWKykMXKl4QEOmV4i3YfQTUfMJ8YtOmh
         zK7rIsDwMN6+P/NMfaQycEfARoX8CyMUcHWRCBLdUj+amKJWByUI8Oeylhvi8NfOZ8Cc
         oEguaXMyDRkNb5kO5nNcdbwPaccqHF6Bd7cG/lgmAG2qZt76D4lgdsI7k5JKb44hSwyf
         Nb6i/N8wYXJ1mW94JwNgmwdRngAVuu4/mxpH6mhqp2RKpCzIj6fJiWyLKMZATYB3b1U4
         8XPfqcRx3g/BxRnW/fbsivN7lgDNgBnMmwTmZJsoHvU1yiIRF2kkiFbvFQzkV5JPrxnC
         IqCQ==
X-Gm-Message-State: AOAM531PERB7zGwREqZ4uD4BED+IBH+2bgmKjAOHNeQTerT/0yUfBh6C
        jgPamnY/EFYXXxtd3mVlL1tYcnMg
X-Google-Smtp-Source: ABdhPJz1+W2ORFxYv206Se180uYLIcSK4wlh9y/Ie2XpfRFQbvoeB/WUMTx+Ih3Ta+b4Q3VcIk5BtA==
X-Received: by 2002:a1c:ba84:: with SMTP id k126mr2896926wmf.55.1596217518209;
        Fri, 31 Jul 2020 10:45:18 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-421-163.w2-6.abo.wanadoo.fr. [2.6.84.163])
        by smtp.googlemail.com with ESMTPSA id t133sm18767414wmf.0.2020.07.31.10.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 10:45:17 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v1] t6300: fix issues related to %(contents:size)
Date:   Fri, 31 Jul 2020 19:45:09 +0200
Message-Id: <20200731174509.9199-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <21bb2dad-5845-8cee-8f6a-1089ef7cae3b@gmail.com>
References: <21bb2dad-5845-8cee-8f6a-1089ef7cae3b@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

b6839fda68 (ref-filter: add support for %(contents:size), 2020-07-16)
added a new format for ref-filter, and added a function to generate
tests for this new feature in t6300.  Unfortunately, it tries to run
`test_expect_sucess' instead of `test_expect_success', and writes
$expect to `expected', but tries to read `expect'.  Those two issues
were probably unnoticed because the script only printed errors, but did
not crash.  This fixes these issues.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 t/t6300-for-each-ref.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index ea9bb6dade..bbec555977 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -65,8 +65,8 @@ test_atom() {
 			expect=$(printf '%s' "$3" | wc -c) ;;
 		esac
 		# Leave $expect unquoted to lose possible leading whitespaces
-		echo $expect >expected
-		test_expect_${4:-sucess} $PREREQ "basic atom: $1 contents:size" '
+		echo $expect >expect
+		test_expect_${4:-success} $PREREQ "basic atom: $1 contents:size" '
 			git for-each-ref --format="%(contents:size)" "$ref" >actual &&
 			test_cmp expect actual
 		'
-- 
2.20.1


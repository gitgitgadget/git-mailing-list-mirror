Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10CDC33CAD
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F3721569
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kcXx0I1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgAMMki (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:40:38 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37648 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728558AbgAMMkh (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:40:37 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C0D9F607FC;
        Mon, 13 Jan 2020 12:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919236;
        bh=mIwoqfHulxI3nfouEXs/ZFmD4ZJN/5zDeL9TJnaR+wU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=kcXx0I1s/E1MvZTsfUZMmjofPeDkwLnLSXi4Gr7oOzV8a3Lj0dJJ9BQyXOvYKG+bq
         gjK/mGv3QHSVhPHYsHMe/O8ow+KRodALRMncBOvbys6NW5JVZBrrdVz6HXajuRCjsE
         EIuZL9orNw/VLWTcn0kal+wPbI3ypHLC3y82Fc63/0LMco57s05VQQXmEOTTd0s63/
         jpYgwpGuEXs4Ct9Y37PB+ORWmoELDJwR/TYDlhPtJ3mFNiD6R4pHcfC5phA44mf7ML
         lfzrCpV+2460RZNbCFULV3W83lbRiUO+1fZtfkk3EDgigYiSXpOP7LFPvQa2Y3Q0At
         123CpkU1AkaAVFPO7bmnpD1o5sFPzY6jfOTDVTFOaEEG4YOTV4Q1o6aMUg5+QQJJU2
         cxzQkpWZWe32YyBWaP5hvz72jNJSRRvzlj/9SP/JLPTI1cEWtjStef7ydkrPRFL9Mk
         vkNrqP72Rg5A6NMl+sUhSFAswiBrz5HPMKdFHjxwXU1zmDgvibH
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 08/24] t3404: remove SHA1 prerequisite
Date:   Mon, 13 Jan 2020 12:38:41 +0000
Message-Id: <20200113123857.3684632-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
References: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Despite the description in the test, the test does not actually test for
an SHA-1 collision; none of the object IDs used in the test collide.  As
such, it does not need to be adjusted in any way for SHA-256, so remove
the SHA1 prerequisite.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3404-rebase-interactive.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ae6e55ce79..682c7252b8 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1249,7 +1249,7 @@ test_expect_success 'rebase -i error on commits with \ in message' '
 	test_expect_code 1 grep  "	emp" error
 '
 
-test_expect_success SHA1 'short SHA-1 setup' '
+test_expect_success 'short SHA-1 setup' '
 	test_when_finished "git checkout master" &&
 	git checkout --orphan collide &&
 	git rm -rf . &&
@@ -1261,7 +1261,7 @@ test_expect_success SHA1 'short SHA-1 setup' '
 	)
 '
 
-test_expect_success SHA1 'short SHA-1 collide' '
+test_expect_success 'short SHA-1 collide' '
 	test_when_finished "reset_rebase && git checkout master" &&
 	git checkout collide &&
 	(

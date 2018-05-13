Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 659D91F406
	for <e@80x24.org>; Sun, 13 May 2018 02:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeEMC0K (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:26:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45410 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752072AbeEMC0A (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 May 2018 22:26:00 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A8F656074A;
        Sun, 13 May 2018 02:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526178359;
        bh=f9cgKsL1ppHL+qsQs11bBofkP+FHBqNqDL3FAj1rZYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=T1UpBDTJm8pKEV9bNrFNjB9OMGS0FUTr6xEgO016sHSdNHuW/jbgUNIPyFo8PfK2j
         VMDr3QywpkW3zlopK1pNkZIxqDrFeQ/ckoQiVOojvfnLP80Kb4Mfk+K1EiwsjLRDoy
         0JmZO3nrAvX8zWNEOV6/zfz4rNKaMUzA7G+GS/omMIj70880f9d1vu6vEcEjeaIN5D
         9PVNjX5CN+fPrmxpciiLJV1gPQpCWwBAB75z21tPpP485cOZmXsapLC5g3Fj1y5CgN
         Mp3uZqKy4oQtNW/nSuOp3/ztQpGbRf8FWI8PHqL1Y5pLXjkMvT8jlYV1OXiQWVol04
         IyPFI6xvMcRMRmI9ArHtni0YFhY2hiwO+UV+LB2f53SmlefAPIJdgF52ye3mf/shXR
         1cGQ/qR0uSeWsFrNjr/6NjR7H1mtioUifDonmMCVNUbE+oKiywyzdw8ZEX8OeMrRSp
         RGR7jRwhUbb3UYVXSfNYtdr5HOmQa5w7ofgYXbPwhq0gznpf7/Z
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 27/28] t4208: abstract away SHA-1-specific constants
Date:   Sun, 13 May 2018 02:24:37 +0000
Message-Id: <20180513022438.60003-28-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180513022438.60003-1-sandals@crustytoothpaste.net>
References: <20180513022438.60003-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4208-log-magic-pathspec.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.sh
index a1705f70cf..62f335b2d9 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -45,8 +45,9 @@ test_expect_success 'git log -- :' '
 '
 
 test_expect_success 'git log HEAD -- :/' '
+	initial=$(git rev-parse --short HEAD^) &&
 	cat >expected <<-EOF &&
-	24b24cf initial
+	$initial initial
 	EOF
 	(cd sub && git log --oneline HEAD -- :/ >../actual) &&
 	test_cmp expected actual

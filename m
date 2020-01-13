Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885ABC33CAE
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54817206D7
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="cq5cl4t1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgAMMky (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:40:54 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37698 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728714AbgAMMkn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:40:43 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9966D60804;
        Mon, 13 Jan 2020 12:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919242;
        bh=8FU4zHKprYpeY3ERg5TngHjUqssaMsZOwf9nyGbqoW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=cq5cl4t1Ggv5Hu/6eMjQyDA/ksTX0vRmMqUE2eWBkS43dxg03OvfdpncPTC69UvPS
         +vlxP0YeLLBq+cA+5OF4XSz2oIu8k3qGZmPUvPCW517ONQaqST0WzmMoa7pT94LAE2
         +1du38w+E96WuFK52q7WmPIMf4lNg5k/otW/7Y1TFslPrwb1SCwzPnI77JFdaaz+h5
         /jv/Kyd81s8bOaSbYtMRcXJODh30rfYsBpoY5z4BU13SluOpy4wqrOcr/j9RukonZ/
         GtYCb3tGsIW8dzl6bmWF9TS4IlNzsZ3UwR/NTfRaPtqzp7I3vAnQY0FfzGrI158nUr
         QC0TLLU1Fe2gwBk8cN3BF7xV5tGeYexL4BDoQA0D66RUu3zBeHZuhVvHix8WVpQuk2
         Rh7pwBe8L/ILqbP2hjIwr4ilOH/nKwuj2I8O433Y1M31cLXrVQJmtUkFWf7HJKbsJ+
         eitFQ+CKTAkDyEK5q2VA2nBtFK+RP8LKVN0tUsUxF1aGJ1ROtUQ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 19/24] t5607: make hash size independent
Date:   Mon, 13 Jan 2020 12:38:52 +0000
Message-Id: <20200113123857.3684632-20-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
References: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use $OID_REGEX instead of a hard-coded regular expression.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5607-clone-bundle.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index b7a3fdf02d..9108ff6fbd 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -64,7 +64,7 @@ test_expect_success 'ridiculously long subject in boundary' '
 	test -s heads &&
 	git fetch long-subject-bundle.bdl &&
 	sed -n "/^-/{p;q;}" long-subject-bundle.bdl >boundary &&
-	grep "^-[0-9a-f]\\{40\\} " boundary
+	grep "^-$OID_REGEX " boundary
 '
 
 test_expect_success 'prerequisites with an empty commit message' '

Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45D3C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 02:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 951022070A
	for <git@archiver.kernel.org>; Thu, 21 May 2020 02:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="W7Ll/ZhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgEUCHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 22:07:51 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38570 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726840AbgEUCHv (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 May 2020 22:07:51 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4D06860427;
        Thu, 21 May 2020 02:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590026840;
        bh=McNu1yxRepNBmC/UCm+Xf+G0DkntcMkro7C2h5yNc7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=W7Ll/ZhZzKOOtKn4899d8WISqPD3The0/InxS/ui6QoXmQQMP6HO9usboRuMBTGtD
         MG664fUE4AT1rIS44W9ODvM/Z5XUWzofnBeCw9fKDk0GMo6Yen4AM+bk2rIGvVEQLh
         l6bKR4tYzG3w9R3k3nN7SG4NNHg1aRkG/USZ5v5Q2aSLUuO9uX1dXDBTMNnQwdYsX9
         5UHIb01wuZDOmyyYAQMh8W/tFZ9stbkYSD7oHDjv/p+BzEWF7S2b2b7vzDpStVRTpj
         3BDA2fVY+LUgmUzqdvfhpxetmXaj89vhlG3q52emnFHlZhVQyz6gBeqCRvQOoUPc7X
         zlNx5Sv/hUAw5uvDivtph0rr7em9G2ZTnKdNsCzkydAy4KAeD9PEudJK1ZIZNDq1Ic
         NHv2uxXFWhiyozHvgkmbRbMbmh0YEEf+j7VE1LdcnY/FCTnKHFS8i/81cTj5hUqFnl
         4wpMHmPJw7u4DeDVo+yghg8PTVdJS4vXHF/yyWm1/OJnp1TLf6j
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] Improve Fix code coverage for checkout
Date:   Thu, 21 May 2020 02:07:10 +0000
Message-Id: <20200521020712.1620993-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <ef72aedf-4264-e386-9563-050c54483c93@gmail.com>
References: <ef72aedf-4264-e386-9563-050c54483c93@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patch #1 reduces the number of options in the scenario which Stolee
mentioned above.  There's now just a NULL and a non-NULL case, and the
NULL case is now relatively straightforward and uninteresting.

Patch #2 adds a test for the particular set of options which will
trigger this case as an independent test.  I didn't think it made sense
to put this in t0021, since ultimately that set of options isn't about
conversions and it would seem out of place there, so I put it in t2060.

I'm ultimately on the fence for this case, because I think it's really a
corner case and testing this is probably not that interesting, so my
preference is for us to pick up patch 1 and drop patch 2.  However, I
added patch 2 in case we do indeed want a test for this, and I'll let
Junio and others decide on what's best.

brian m. carlson (2):
  builtin/checkout: simplify metadata initialization
  t2060: add a test for switch with --orphan and --discard-changes

 builtin/checkout.c | 4 +---
 t/t2060-switch.sh  | 8 ++++++++
 2 files changed, 9 insertions(+), 3 deletions(-)


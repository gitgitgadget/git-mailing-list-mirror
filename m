Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE6EC433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9999520B1F
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDkVmKlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgHNMWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgHNMWM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 08:22:12 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877DDC061386
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:22:11 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id s9so4715600lfs.4
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DBD5tT1QKYeTEt2trXkgCkA1cQ8K9QrkZC+S63ymft0=;
        b=mDkVmKlD+lmTTLRkeB1aUnsJWOSrNNWm7+OoHMZeMuU/dnr2CSCj3sa9DNsY/IYwzZ
         x400mCkffP5Ls0Qku/lQkUiTsijLfVft8RGJJGdvxH7Wbk2EMDzp1TrJgh4mQIGrT79x
         ctnOqVJ3D9zkxem0NAMWqJ/O3hGaI/QyRS+G+tR7kkU0bXd6nkmlB5UL4q4LFI7pQAy7
         +LuzZoD1eZdoMHFl0mr8157XxBQVEoOcA82PU00ci6DqwyMEznBPHZE9asGQZAtYaySp
         wK8iBdeqaKI18Ep1f79HB01ZAOkx0PLfEBdRStv22SSe+624WkVXO6S5vFWKK6WdxPtY
         lbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DBD5tT1QKYeTEt2trXkgCkA1cQ8K9QrkZC+S63ymft0=;
        b=Pw8wSdzkSeBzNeAcIb781Wi2/+v1HJbcTIHI/2USugkrGmbCvsgXzE7jnxAnN0+y9q
         e4IzU0nT9KLPVe+3Q5wqLqkMwukrT0wkaBhZJDKVZDrxpkuDMWiQMdeSZSz7Ss63IptA
         oJ6xRmocj6E+D5P34JXnIDLKAvQbjUWTv6fSUVGrvILlOTdODAAdvZmAlLZcng5NK/JW
         +8WCX6e9j032y2de4GCjnOTlzpJMY//Dfa+9vUl+mgaM+8bxkzI2GkUSZW84z2ioz2RC
         3InPMkiaGiPt/F7mbGj0Q4jhuMH0ugNotkuphlkQ9i5RLvgKARNgW4ud99wzSWaFgk9s
         RnPA==
X-Gm-Message-State: AOAM531ZqoAIEAkkjuzGmNKQacBABYCSA3ayTogMTH16zIAiTAIzCpWm
        T+aQBZ8IFegdHGAeHqJAD3E=
X-Google-Smtp-Source: ABdhPJx2NV40vPhnydtdVfwn191gs8KFSuleJVsSyWosPa63S/Y+60h9VQb7q1auWJj5UN661zrgDw==
X-Received: by 2002:a05:6512:312b:: with SMTP id p11mr1119157lfd.202.1597407728660;
        Fri, 14 Aug 2020 05:22:08 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id o2sm1847407lfi.50.2020.08.14.05.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 05:22:08 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] shallow.txt: document SHA-256 shallow format
Date:   Fri, 14 Aug 2020 14:21:45 +0200
Message-Id: <8e498a3b400a2c8390e78de08b83d41e354e7564.1597406877.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
In-Reply-To: <cover.1597406877.git.martin.agren@gmail.com>
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net> <cover.1597406877.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to recent commits, document that in SHA-1 repositories, we use
SHA-1 for these purposes, and in SHA-256 repositories, we use SHA-256.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/technical/shallow.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/shallow.txt b/Documentation/technical/shallow.txt
index 01dedfe9ff..f3738baa0f 100644
--- a/Documentation/technical/shallow.txt
+++ b/Documentation/technical/shallow.txt
@@ -13,7 +13,7 @@ pretend as if they are root commits (e.g. "git log" traversal
 stops after showing them; "git fsck" does not complain saying
 the commits listed on their "parent" lines do not exist).
 
-Each line contains exactly one SHA-1. When read, a commit_graft
+Each line contains exactly one object name. When read, a commit_graft
 will be constructed, which has nr_parent < 0 to make it easier
 to discern from user provided grafts.
 
-- 
2.28.0.277.g9b3c35fffd


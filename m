Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B83C54FCC
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 22:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8024B20672
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 22:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWYB+XEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgDTWnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgDTWnV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 18:43:21 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEA1C061A0C
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 15:43:21 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kb16so534683pjb.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 15:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LfP0g3nCR7b/FKw46vpJthyj2c1VIZaNX381FHxHS14=;
        b=YWYB+XEuukIbIXMvvixNYi5FqgkaeA45VvTkcnffH5nHg5d0fn1MglClBBW6NHtCa4
         uQ4kjD9dlti+W35Lc/6mJ7voyHt2fwLZDiI/PBn13uLje+bQxGwVe/MHGs17310VKqgE
         ocGKYxRDDHf8Ko/76TK+HhB0C1+qerak00+vplE2dsMgIpAMioqSWuW3Gtgiz3YfuVQw
         WLnOfJGJKpibJtDV54K3daE16pq/2Py/uiCoFCSR20hbek8zCv6QH5Jpl5OvEE2RLSV7
         cfw7rYM+qA7izSt+35AQbfkXvT5EURC8LfXM4DjLHoitIdUIkTcgXkJ/iZrBhCpwzzCh
         K+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LfP0g3nCR7b/FKw46vpJthyj2c1VIZaNX381FHxHS14=;
        b=H5Hw1K6m/jGY02+aKdqVCiQj4gCIQZCPTgWhcWdN4PNPuxsSJFfm3IqbYTUlcRfcF+
         PSuHzEBQEYoRwyLPpHjgLYvlQmjE1066V/0AC/SmpRW80FN3b0JZDUjhvJFwENb20D4m
         k2IJR/pKhoWvhr4Gr9PcuJNp7CdswB50GGjy7/PaOvhItbLKtSZWHj4NmUFm8Br9BOsV
         +rdD0QrLLuLCo8M9qGAnG6HzryyAPf9UO4c5+vW380DQeCAivsiqFSEh6CQFxVeYJeow
         7DYvJtC1AGXXOHYnBJHeLx9VtDBAmB1MuCIATxmyb0DsnxETxAy2z30WfMNd2qaRYxh5
         5ojQ==
X-Gm-Message-State: AGi0PubZD4EJw0BfNWVs9rtxWX4t+Zg6WpIzsn0QcWZB+AsdLzYkqIII
        0uQHX9TRw3iSPwCQlcKMZVqMJ6jd
X-Google-Smtp-Source: APiQypJqMoqqOjRasfhFrMZRiR0W6P7yBu4CRavLIb339zmJO2AChomLdIUwQXLfc9M7BLunBWHSxg==
X-Received: by 2002:a17:90a:65c5:: with SMTP id i5mr1970857pjs.18.1587422600350;
        Mon, 20 Apr 2020 15:43:20 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id u3sm510205pfu.137.2020.04.20.15.43.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 15:43:19 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] osxkeychain: restrict queries to requests with a valid host
Date:   Mon, 20 Apr 2020 15:43:10 -0700
Message-Id: <20200420224310.9989-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.111.gbff22aa583
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

make sure that requests to this helper to get credentials return early if
there is no host ord the host is empty.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 contrib/credential/osxkeychain/git-credential-osxkeychain.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index bcd3f575a3..2264a88c41 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -69,6 +69,12 @@ static void find_internet_password(void)
 	UInt32 len;
 	SecKeychainItemRef item;
 
+	/*
+	 * Require at valid host to fix CVE-2020-11008
+	 */
+	if (!host || !*host)
+		return;
+
 	if (SecKeychainFindInternetPassword(KEYCHAIN_ARGS, &len, &buf, &item))
 		return;
 
-- 
2.26.2.111.gbff22aa583


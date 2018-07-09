Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58B061F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 19:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933027AbeGIT0K (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 15:26:10 -0400
Received: from s019.cyon.net ([149.126.4.28]:33934 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932931AbeGIT0E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 15:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=d589QB9+yUCAbSsI5If8TT5KF8lxjv2qXfmVmCXhlLU=; b=udRuhC2iSFpEDXQJX0lGumouQQ
        ibAXohWgBwO3/JldUa2w9cH2cC8cq/QgT6w1bBxuSskmKmfMhJ5K6u0gfVRcUnaTA06IhuQcqrtJz
        6HAGC6HgmJx4ZBzGQV9W8dDpfie6mywQNuEes23UwVUZ+e+AUm0tgSoAs9YDPERu7RfebCr5rMpr9
        KjQFoal0RPUM9gZ+kA41WtFSGA4KWhqjAxcr9eb36YmFg+iixVNpTQMoXSvgIXK3hhykTh6jbbI27
        mAMnDgSumOdNZEmC27U8nI0DcbH5WFtRlXKdyC8raDsVzBsoMyUBLF2lxu8s9aj3x87AZ1CEUhPXA
        NOsEL2jQ==;
Received: from [10.20.10.232] (port=50556 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <bb@drbeat.li>)
        id 1fcbnN-00Ck5X-NE; Mon, 09 Jul 2018 21:26:03 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 86C4823504; Mon,  9 Jul 2018 21:25:59 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 6/6] utf8.c: avoid char overflow
Date:   Mon,  9 Jul 2018 21:25:37 +0200
Message-Id: <20180709192537.18564-7-dev+git@drbeat.li>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180708144342.11922-1-dev+git@drbeat.li>
References: <20180708144342.11922-1-dev+git@drbeat.li>
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In ISO C, char constants must be in the range -128..127. Change the BOM
constants to char literals to avoid overflow.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 utf8.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/utf8.c b/utf8.c
index d55e20c641..982217eec9 100644
--- a/utf8.c
+++ b/utf8.c
@@ -566,10 +566,10 @@ static int has_bom_prefix(const char *data, size_t len,
 	return data && bom && (len >= bom_len) && !memcmp(data, bom, bom_len);
 }
 
-static const char utf16_be_bom[] = {0xFE, 0xFF};
-static const char utf16_le_bom[] = {0xFF, 0xFE};
-static const char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
-static const char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
+static const char utf16_be_bom[] = {'\xFE', '\xFF'};
+static const char utf16_le_bom[] = {'\xFF', '\xFE'};
+static const char utf32_be_bom[] = {'\0', '\0', '\xFE', '\xFF'};
+static const char utf32_le_bom[] = {'\xFF', '\xFE', '\0', '\0'};
 
 int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
 {
-- 
2.18.0.203.gfac676dfb9


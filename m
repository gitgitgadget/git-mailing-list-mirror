Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8AAC33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 03:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E44214AF
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 03:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P55rRJ1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgANDYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 22:24:41 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:46524 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgANDYk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 22:24:40 -0500
Received: by mail-qt1-f173.google.com with SMTP id g1so11189271qtr.13
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 19:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rWwHrKvfGxxjuTFdRjZx6y1VBqT7A6SReiCCB7PI3w8=;
        b=P55rRJ1/u2y2SGi/zpuFO48xK2MpAP3dLpWrghvwuLyA7ARpmtktW+Cw93ihAn3b1d
         KewOuOoj7MwCTXovSm4rZvDGF0S4nK5m1lrxWQ8f3wARgXC9+boPplRquqHOrboSND83
         9qOraf5eyiiO97JtZCLZaMPRhqE9xleDMmf95qcNSYuTKjKViX6ah3LadUBaik2wPjua
         0GmH2dxsP+2aSj2nwjQPxHmsooRXiEP+noS9BJf1Ai656tu06nqGY8DE9Cr1zGKy7tbe
         MrOJXTboZkgh9MEIYmfKs0mjP25H/jhh5AwMqWjWRRoWveXOAHXVzd67xlcxylSQx7BR
         wbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rWwHrKvfGxxjuTFdRjZx6y1VBqT7A6SReiCCB7PI3w8=;
        b=DoJvfDuP+peS6gQAKzADqgAJlr830SQx9BgmJ695X/h+xj86YHv3S4bGlcrP293iWl
         agYqbuapbarDG2NIqJ4r2NlT1qHIQuFK3R6aUyTStGsF64Dy1hsjVoQk/qym9Jk/+ktd
         L1lsoSiTzjFG2MYiRb7vyVsWiSXRElf/zbhXqhvVwn+kxdCKJUdeF8DWs3FST8VMcSF2
         +oLimEGbrZpjyiOVjq1C7WWVjpgHBjWYCky/X24V0Oih2+bSEXkuLRlvmEvEpIb5CK8D
         kQJeP+SFzv2/vj0x9eedSpm2vbGbrNJGY52Z5d5ky4p91aO4LRZD9QICXfBAItQPcU47
         YjOA==
X-Gm-Message-State: APjAAAWLnrQq8E8g5Tv2/O2O3oJz0qPlGV1oBwtEzmVld2S9u6CeKFWp
        QUWXrOKy4y8tnIkOYq66KtgfTIu8
X-Google-Smtp-Source: APXvYqxVsYrj0xzxW0MgEEbjE1R6bmVWnPVdPUUuK0j1JwlA6b/DAD80Ly6d4FqmvRpqBTlolXiEkw==
X-Received: by 2002:ac8:704:: with SMTP id g4mr1812429qth.197.1578972279680;
        Mon, 13 Jan 2020 19:24:39 -0800 (PST)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id v2sm6036723qkj.29.2020.01.13.19.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 19:24:39 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: [PATCH] .mailmap: map Yi-Jyun Pan's email
Date:   Mon, 13 Jan 2020 22:23:58 -0500
Message-Id: <21b8a0d08764c31de12ef7661667eb1117d41ac4.1578972215.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.180.g49a268d3eb
In-Reply-To: <20200114024938.GA17003@generichostname>
References: <20200114024938.GA17003@generichostname>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 13185fd241 (l10n: zh_TW.po: update translation for v2.25.0 round 1,
2019-12-31), the author mistakenly used their GitHub username for
authorship information instead of their real name. However, a commit
with their real name exists prior to this: 9917eca794 (l10n: zh_TW: add
translation for v2.24.0, 2019-11-20).

Map their email to their real name so that these contributions can be
counted together.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index fbef813f24..0f20882209 100644
--- a/.mailmap
+++ b/.mailmap
@@ -288,6 +288,7 @@ William Pursell <bill.pursell@gmail.com>
 YONETANI Tomokazu <y0n3t4n1@gmail.com> <qhwt+git@les.ath.cx>
 YONETANI Tomokazu <y0n3t4n1@gmail.com> <y0netan1@dragonflybsd.org>
 YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
+Yi-Jyun Pan <pan93412@gmail.com>
 # the two anonymous contributors are different persons:
 anonymous <linux@horizon.com>
 anonymous <linux@horizon.net>
-- 
2.25.0.rc1.180.g49a268d3eb


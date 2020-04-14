Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7B9C2BA19
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 09:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28C73206D5
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 09:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnTirIB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437666AbgDNJcI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437642AbgDNJcG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 05:32:06 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451FBC0A3BD0
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 02:32:05 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id g2so4460133plo.3
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 02:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lJ8FltyKwypoT+d30kK9KAIRI2qGdyfQpWwNedrVc5E=;
        b=QnTirIB0UCUsDPMj6wEqgVUphFywDRMsrYIUHOBiLj9A8O3ZUXwIuZErwRTN6CZ4ga
         Dmg2ofNGmUw+DhY3AmZ9fM0qQffUb7icNdz99G/oSs3v+XoWINaHi34vo/c9mqQW2b1z
         2Ih7s8aapolD7Zb47sAYhDhaUJBLPbFwae8dsjwT8dgNlOeT0wZcvHyPgl7Tm5s9J7Hn
         cXOu2kIocPXomD4H7KahFx73Bq62T7TyJqbOHBqM3ZlcE7jr+5nD5MdgTLnLvjd0C1fK
         jixKXCsfcH7zfUEtN/m8AdB75KHSmfEIlBPHgxEJpTjn8B2IeAXgG1VWkJhsjSfPAT/W
         +iBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lJ8FltyKwypoT+d30kK9KAIRI2qGdyfQpWwNedrVc5E=;
        b=g8F9TH66EMzXqYTlkNXiArOVLYeEwS8+Rg4HzMFpHbKXWW2+QyE6U86sPodztKP3ge
         NjNZKtWufzNF8yBfjJSE9XP/qlcyLSYB27SLdb17gNg3wtJra3XjDxb3qPm7QpszUsUR
         I9xKeFamzIDkkaJI6NEFf00iHWAoXBVCW7N34IOLsF/WVYlH+LHPeCK3K0PhrRzLtU2Y
         Gn32K1z91SdafllV4qa9uHkyIgYas8LUEdFdEgKI1/SDEy5dXDBafvLvt6SrRBJxyKD2
         IrF25opbwr68DrI20a9MhhVvtUDJyGupPZk4h5v0NXJT3dB1IIKmXiNy/DN6jzDNNe99
         PvHA==
X-Gm-Message-State: AGi0PuZmDNxOdK+Ws463xVppB4uiruFsbGNYNMgDmeKT+PsFCD1+76wS
        B/lIh53H2+qf1mhxOuuW3UZafax4
X-Google-Smtp-Source: APiQypKF2VhbPd+3WplSJhb9//yZiy5Fkv+l0bpJH0WGBM9hA8hrI/yHumgfT1pJ5/YHUy7/Dry6Pg==
X-Received: by 2002:a17:90a:19ca:: with SMTP id 10mr5404222pjj.23.1586856724547;
        Tue, 14 Apr 2020 02:32:04 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id mu15sm11881506pjb.30.2020.04.14.02.32.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2020 02:32:04 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/2] date.c: allow fractional second part of ISO-8601
Date:   Tue, 14 Apr 2020 16:31:54 +0700
Message-Id: <45676f4a7d001dbd25bbae531cc2ae5fc53936bb.1586856398.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.485.g518673e55f
In-Reply-To: <cover.1586856398.git.congdanhqx@gmail.com>
References: <20200414000324.GA2751707@camp.crustytoothpaste.net> <cover.1586856398.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-commit(1) says ISO-8601 is one of our supported date format.
However, we only support RFC-3339 date format.

We can either:
- Update documentation from ISO-8601 to RFC-3339
- Add full support for ISO-8601

This series will try to add full support for ISO-8601.

Reported-by: Brian M. Carlson <sandals@crustytoothpaste.net>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 date.c          | 2 ++
 t/t0006-date.sh | 1 +
 2 files changed, 3 insertions(+)

diff --git a/date.c b/date.c
index b0d9a8421d..2f37397beb 100644
--- a/date.c
+++ b/date.c
@@ -556,6 +556,8 @@ static int match_multi_number(timestamp_t num, char c, const char *date,
 	case ':':
 		if (num3 < 0)
 			num3 = 0;
+		else if (*end == '.' && isdigit(end[1]))
+			strtol(end + 1, &end, 10);
 		if (num < 25 && num2 >= 0 && num2 < 60 && num3 >= 0 && num3 <= 60) {
 			tm->tm_hour = num;
 			tm->tm_min = num2;
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index d9fcc829a9..05c914a200 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -81,6 +81,7 @@ check_parse 2008-02 bad
 check_parse 2008-02-14 bad
 check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
 check_parse '2008-02-14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
+check_parse '2008-02-14 20:30:45.019-04:00' '2008-02-14 20:30:45 -0400'
 check_parse '2008-02-14 20:30:45 -0015' '2008-02-14 20:30:45 -0015'
 check_parse '2008-02-14 20:30:45 -5' '2008-02-14 20:30:45 +0000'
 check_parse '2008-02-14 20:30:45 -5:' '2008-02-14 20:30:45 +0000'
-- 
2.26.0.485.g518673e55f


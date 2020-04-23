Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA83C55192
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA03C2087E
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zb58xhzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgDWNsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728534AbgDWNsO (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Apr 2020 09:48:14 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A7FC08ED7D
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 06:48:13 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t4so2349174plq.12
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 06:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8d7VxX5uwaFIhgGErkkvwOrNu/3IXcZtziPCVBCAJ38=;
        b=Zb58xhzk4J8gxBVDd9GQ+fmQ1W2v3HEsWqlNW9pUBGqZu/5r7+jS8B5tO8OTLaNaGe
         U9FccjIPdLSuGpsrtAf5pfbZsdQgQB4udNVEWR49rpeQxjGUmH1CapB36yOQnJS7bRmH
         3IdDsJj4ogh3QXXPSrL/RC+aZDJpEzi9NJS2xcmJUCFcgd5Vy2yoTGQ8ryqeI8+wKGeQ
         7pzmDPHr5Dd4vAUHV5SLVGFQACkDLpb8HKTs6c/35AtyEcFY5E9zYK9DVeQmfAk+o5Is
         JI6oTPbTbFTlSGUEqE1Rs7nYq7SusBQvK9Kg1G2JYdP8KYFVsrIPyZ7E5/j6fox1AV8k
         4YpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8d7VxX5uwaFIhgGErkkvwOrNu/3IXcZtziPCVBCAJ38=;
        b=Ojux5sqItRcgf5uOVfsiRIBzGvzn1+yQR5K+Fzpu2RhgqUk7VHojE8oCEB4YnOaQYr
         H/Fai0qMfU9HUWmApnTSo8raid5ZfhRRfbHyfhoGNPp5aaTstcDtJbm266tijCSzuPHR
         b4ICW1HvxgKAIKmDJRPfj7yDxtF+sRI93zW5dzC6ihyyRSIimLkCEJtDDN2rqUf+sXcZ
         pVixi0ZqV0S70l6rR8gJPComHyy4zXi5YHZMlz383gev1bftv1eVvK7DoWGcja0j5gCf
         R8irECoD0zNWycinuQSP8VTkaDzAehN1hNol14CXJtRkHJsYGUFbd11anjSuU3+a+7ap
         GDRQ==
X-Gm-Message-State: AGi0Pua4QNYR8bpnooaR+pNpBQAmp52GJml5atV7jO7/mB0iOifd9Q01
        WKV2GyLsQQh7b7C8g5+S0vaL95Mp
X-Google-Smtp-Source: APiQypI97SG7ijS/2cyxlqZCzzSf3XzW8o4s+4UTpY+trdi1Oww/Ussde+fJwy5bEHK/kNg5pQJdLg==
X-Received: by 2002:a17:90a:2450:: with SMTP id h74mr729558pje.57.1587649692541;
        Thu, 23 Apr 2020 06:48:12 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id z23sm2635958pfr.136.2020.04.23.06.48.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 06:48:12 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 5/4] fmt-merge-msg.c: fix `make sparse` on next
Date:   Thu, 23 Apr 2020 20:47:57 +0700
Message-Id: <20200423134811.8634-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.384.g435bf60bd5
In-Reply-To: <cover.1587648870.git.congdanhqx@gmail.com>
References: <cover.1587648870.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Probably, un-necessary, since this is merged down to master.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 fmt-merge-msg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 08022ed2e4..72d32bd73b 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -484,7 +484,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		enum object_type type;
 		unsigned long size, len;
 		char *buf = read_object_file(oid, &type, &size);
-		struct signature_check sigc = { 0 };
+		struct signature_check sigc = { NULL };
 		struct strbuf sig = STRBUF_INIT;
 
 		if (!buf || type != OBJ_TAG)
-- 
2.26.2.384.g435bf60bd5


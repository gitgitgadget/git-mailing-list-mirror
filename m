Return-Path: <SRS0=89BL=BL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F66C433E0
	for <git@archiver.kernel.org>; Sat,  1 Aug 2020 22:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 129A2206E6
	for <git@archiver.kernel.org>; Sat,  1 Aug 2020 22:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExFoPCbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHAWGz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Aug 2020 18:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHAWGy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Aug 2020 18:06:54 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44166C06174A
        for <git@vger.kernel.org>; Sat,  1 Aug 2020 15:06:54 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id x9so35967894ljc.5
        for <git@vger.kernel.org>; Sat, 01 Aug 2020 15:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GOWO6ieaiXN3BgekwcAFZmdh/iTW7mlhT9giZgi2rDo=;
        b=ExFoPCbLYvL2X/+ppIB9vDuEbw2M+71xT5Mqu5Iv4YZ8IfrtdJOAedCS8eTBHL2Vo8
         04Uc1GvmaKRUaYWuEgMZ5rMbfGLN3OeG6R8WdWI0NsLgIHOkPzb4BU/+/Ge8TVqF56ia
         kKRP+Sz1LoBlz4KWLdyL+bbdh/P75GH4tWmKouozb3AGSlQiDICA9hcNFYQqRpOpug2I
         hL8Qw3yknaV4i4Y1PZfgBRG4nvdp96/P9X6jTB3Gh3Z19XWsUch//0FddJAYpVqip2l3
         HCpKcpb//wTeImWbs4qg+XV81DaFtIyCV27THSGjCqG8xp5DkCGYy+jo71MTegz5tRZs
         MXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GOWO6ieaiXN3BgekwcAFZmdh/iTW7mlhT9giZgi2rDo=;
        b=Ug9Upj26q8iKr/wHhQ3Jqr9DGzfH5S9MMZSHrt0PeSvbWVg0yYRfFCWQrqCW1ue5U7
         ed82lWo8LZXlgrd4Nj/Iax25Lkk1RoX9dyPlD2I7zv82hUMODiJWvYBQQRcb0gv1wso+
         LUplz9IDoslVWs0CLFV5ATX+KBbOrKsg7dDqjZyR/dmq+g1at300JejJxFeBZ3heavHe
         19q2hxBkWeo75U0CiEVmt5L2ok3+ipUmV6rBcTWNWC8Yrn/8TmsubnAqb+ybpKX9V4lO
         tufGHHDwLxmqhSxWg9i4Z5RgXjiJFMiVSHS6zpqNCL+/frci2fCrIMVVZ8Cslduw4V9M
         nuAQ==
X-Gm-Message-State: AOAM532/5f8VN1GbqYmK1oxJFJ1jVSvyFL7bKEz5MLfF7q9K9FemmhKB
        S2jPwh7odOnzo9Am9ApYTqy9ls0v
X-Google-Smtp-Source: ABdhPJxl+HcPAsTdLvamYx0yAakaTndOg9Mz1A45OXdLv3lh6IdE0Se93aoe21GCr7Q2eDtr0BjEVw==
X-Received: by 2002:a2e:9913:: with SMTP id v19mr4384756lji.292.1596319612331;
        Sat, 01 Aug 2020 15:06:52 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id n3sm2608364ljc.114.2020.08.01.15.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 15:06:51 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] t1450: fix quoting of NUL byte when corrupting pack
Date:   Sun,  2 Aug 2020 00:06:11 +0200
Message-Id: <20200801220611.10453-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.81.ge8ab941b67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use

  printf '\0'

to generate a NUL byte which we then `dd` into the packfile to ensure
that we modify the first byte of the first object, thereby
(probabilistically) invalidating the checksum. Except the single quotes
we're using are interpreted to match with the ones we enclose the whole
test in. So we actually execute

  printf \0

and end up injecting the ASCII code for "0", 0x30, instead.

The comment right above this `printf` invocation says that "at least one
of [the type bits] is not zero, so setting the first byte to 0 is
sufficient". Substituting "0x30" for "0" in that comment won't do: we'd
need to reason about which bits go where and just what the packfile
looks like that we're modifying in this test.

Let's avoid all of that by actually executing

  printf "\0"

to generate a NUL byte, as intended.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 If my reading is correct, when we substitute 0x30, the type will be 3
 (blob) and the size will be zero. So there might actually exist
 formally valid packfiles where this byte that we're modifying is
 already zero. What matters in the end is whether we might be using such
 a packfile in this exact test and from what I can tell, no, we won't be
 doing that.

 t/t1450-fsck.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 344a2aad82..af2a2c4682 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -714,7 +714,7 @@ test_expect_success 'fsck fails on corrupt packfile' '
 	# at least one of which is not zero, so setting the first byte to 0 is
 	# sufficient.)
 	chmod a+w .git/objects/pack/pack-$pack.pack &&
-	printf '\0' | dd of=.git/objects/pack/pack-$pack.pack bs=1 conv=notrunc seek=12 &&
+	printf "\0" | dd of=.git/objects/pack/pack-$pack.pack bs=1 conv=notrunc seek=12 &&
 
 	test_when_finished "rm -f .git/objects/pack/pack-$pack.*" &&
 	remove_object $hsh &&
-- 
2.28.0.81.ge8ab941b67


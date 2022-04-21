Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628ABC433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 13:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384665AbiDUN37 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 09:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384716AbiDUN3z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 09:29:55 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C9E37A91
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 06:26:57 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id bo5so5014878pfb.4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 06:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TZResOIvkem8YOSvCxatHOlmDV/IlI4Rjbas/BTW3z0=;
        b=BwVlDzRqVNH/4qMZ5UZkQOGPAwubkUueVs4oXU+BhEwYNpd0hsNvK3Y+crNtAKiZpC
         hKcCSPWAgmnjR6XODocs1GF8dDF3uG98A5kTFT/VlFKc5/v3PIngSVr4HcjE/UQ6BzOh
         TXo0tEH2KBsv0SefXqP6Y8VGcTUcqgF1nqFne2WJoSY28Mm4yhi7CyxqQ2Waj+iVB6Cq
         fBsmgJqB7IKysjvzH94A2rfyRq+bu25FB1q1jvzmW+lSkygjjRnmM2Ic+TkuOD4D2Im1
         +LFiUBHm8ZbE9imPEm3G21JLzN//fJtWXkbKnww/lvIOeO/2p7m0wEY0n63CsN0kKlrD
         rzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZResOIvkem8YOSvCxatHOlmDV/IlI4Rjbas/BTW3z0=;
        b=3FQWOYbZXfFze5ywjiCyR1FdBjLBrb5w0mDhZhyhEId9UMh1fBqxT+8ROQlSfN993x
         kbxS9uxxvf5iJsy/LSmdA8VuD++WVLuIjy2vDRkityjTTOFaP/DjeUc1WvaVo0bqORae
         JcSMyVj6YCSbf2v/Gvab7yKjexjIfBV5o3CFX8MdxVMzdaA9wqaTHAWIzhNcrHwIGNGB
         JTS0xnan4m3202RsawF52NPK6te83cfOWN0CNJBYQGVqOjy9U33a+s26reQSkHksasrq
         Q+gSCMknRG6184JEo+pFNX/3lRHYD9hU4Mm9UxJxkutxcFb2jC8cU94GiRl0L4rQEnNC
         UoEg==
X-Gm-Message-State: AOAM532NxBUwS66AuZxNJ2dzNTRRnopdW+43xELM3DWX9wZr/u1hrswy
        zQK+HU5l3o+1O8ojdh2xHNI=
X-Google-Smtp-Source: ABdhPJwzWmqAG9VetGaAz9zlbpFfzMX2fe1mvT1sKWJPMMYmNz8jg0cH/qpzwDCUELYt3IY0dsF+/w==
X-Received: by 2002:aa7:83c2:0:b0:505:723f:6ace with SMTP id j2-20020aa783c2000000b00505723f6acemr28954005pfn.86.1650547616716;
        Thu, 21 Apr 2022 06:26:56 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.42])
        by smtp.gmail.com with ESMTPSA id bd42-20020a056a0027aa00b0050a6e0ccc54sm15463647pfb.186.2022.04.21.06.26.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Apr 2022 06:26:56 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com, gitster@pobox.com
Subject: [PATCH v2 3/5] pack-bitmap.c: make warnings more detailed when opening bitmap
Date:   Thu, 21 Apr 2022 21:26:38 +0800
Message-Id: <5a8f5afccf6e2b451c76306e04ca9ef300c92fdd.1650547400.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.583.g30faa5f068
In-Reply-To: <cover.1650547400.git.dyroneteng@gmail.com>
References: <cover.1650547400.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When calling the "open_midx_bitmap_1()" or "open_pack_bitmap_1()", there
will be a warning if a normal bitmap or MIDX bitmap already has been
opened, then let's make the warning information more detailed. For
example, it makes the error clearer in case of an accidental
regression where we start looking for single-pack bitmaps after
successfully opening a multi-pack one.

At the same time, we made the previous and new warning texts support
translation.

Discussion in community:

  1. https://public-inbox.org/git/YkPGq0mDL4NG6D1o@nand.local/#t
  2. https://public-inbox.org/git/220330.868rsrpohm.gmgdl@evledraar.gmail.com/

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c           | 6 ++++--
 t/t5310-pack-bitmaps.sh | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index f13a6bfe3a..1b268f655e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -330,7 +330,8 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 		struct strbuf buf = STRBUF_INIT;
 		get_midx_filename(&buf, midx->object_dir);
 		/* ignore extra bitmap file; we can only handle one */
-		warning("ignoring extra bitmap file: %s", buf.buf);
+		warning(_("a normal or midx bitmap already has been opened"));
+		warning(_("ignoring extra bitmap file: %s"), buf.buf);
 		close(fd);
 		strbuf_release(&buf);
 		return -1;
@@ -387,7 +388,8 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 
 	if (bitmap_git->pack || bitmap_git->midx) {
 		/* ignore extra bitmap file; we can only handle one */
-		warning("ignoring extra bitmap file: %s", packfile->pack_name);
+		warning(_("a normal or midx bitmap already has been opened "));
+		warning(_("ignoring extra bitmap file: %s"), packfile->pack_name);
 		close(fd);
 		return -1;
 	}
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index f775fc1ce6..eb63b71852 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -421,6 +421,7 @@ test_expect_success 'complains about multiple pack bitmaps' '
 		test_line_count = 2 bitmaps &&
 
 		git rev-list --use-bitmap-index HEAD 2>err &&
+		grep "a bitmap has been opened" err &&
 		grep "ignoring extra bitmap file" err
 	)
 '
-- 
2.35.1.583.g30faa5f068


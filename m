Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0CBC1550C
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 047CB65240
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhCHPHy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhCHPHb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:31 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6DAC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:31 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id l12so11813271wry.2
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gsch7+D5XioVjRaPI/HDT9iSBwQKY5WoWjqpMCIafvw=;
        b=LOCgLeHUtxildwKM260p2Qbl6wGCRilA7FP3DhAICl+qowPAKkiVd0Xh8tAvOOx1Fn
         LQfgW2gAE9M/Ya7V6DjoHgoMhdo3RgnJTzS8NxY4JRXaB8ElWRAM7htbwSwq+Bo8vbJH
         3S1FbKUwdVBpa7kyTcqg0BjHHtzoQ/RXLanowKhJQHV2hyCm3/RyFo47tE8QLd2vp+WQ
         /vDK0fts9cijsxYFGY+df+kb5c1PBbNP1Q5K47+SipMc8sTuWFxnwa9mSYyUEKDOpZAa
         GyVG3ZVwD6Xffsxqw+6pq7UavvdfTY40CAHsOC9R1mck2+DTRg4eAaRIClXpNN2pM5vu
         R/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gsch7+D5XioVjRaPI/HDT9iSBwQKY5WoWjqpMCIafvw=;
        b=ovxPW7K9YD0dNnbd6ssVbNz+LqwDvZAjehw+kbwG7FU7l/ZFvVCeVzDUv/3KcHcSNM
         vjX+NRaddLc6hE5w3od36kl8V6ud5qQWl0fYx8mMft8rTrirqT2sMcVJ4ag219iPniTN
         01DxYcjfid5gh+3zn1sy/w034opVvekLu15OJ2g8gXu6piYKr0PKZAAad0jPvuBCBaB3
         p0voKzC15w3TnsfE3eldQ7j5BZ6Fc78tbCcZkltqOo9DRKNxsPUYKAvDekOYTmbxcY8w
         5PG+v/ANNi1gGsHvbTMvUb2HM7ngfjBVpMcpX/rC1l81LPDTJrcX/AaDbQbQueAOHUvz
         jl4Q==
X-Gm-Message-State: AOAM532JRnjuqp+ksYZsuxW6aw2PJQw0BVausN3+TZF3dwuF2OM6nfo4
        WTD1oJRkP/0vAlYB6gsQ7E24VWBtOzdQXQ==
X-Google-Smtp-Source: ABdhPJygLQqKfk4ar8Wh3zx5qkK3F3Mj/0r7N58v49y40chmkHJh+ZikWWADjMM0ZhxSoz8l8YoC1w==
X-Received: by 2002:adf:ee92:: with SMTP id b18mr22164711wro.275.1615216049802;
        Mon, 08 Mar 2021 07:07:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 24/30] tree-walk.h API: document and format tree_entry_extract()
Date:   Mon,  8 Mar 2021 16:06:44 +0100
Message-Id: <20210308150650.18626-25-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document and format the argument list of the tree_entry_extract()
function in preparation for adding a sister function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 tree-walk.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tree-walk.h b/tree-walk.h
index 1bfa839b275..61fdcb166d2 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -40,11 +40,17 @@ struct tree_desc {
 
 /**
  * Decode the entry currently being visited (the one pointed to by
- * `tree_desc's` `entry` member) and return the sha1 of the entry. The
- * `pathp` and `modep` arguments are set to the entry's pathname and mode
- * respectively.
+ * `tree_desc's` `entry` member) and return the OID of the entry.
+
+ * There are variants of this function depending on what fields in the
+ * "struct name_entry" you'd like. You always need to pointer to an
+ * appropriate variable to fill in (NULL won't do!):
+ *
+ * tree_entry_extract_mode(): const char *path, unsigned int mode
  */
-static inline const struct object_id *tree_entry_extract(struct tree_desc *desc, const char **pathp, unsigned short *modep)
+static inline const struct object_id *tree_entry_extract(struct tree_desc *desc,
+							 const char **pathp,
+							 unsigned short *modep)
 {
 	*pathp = desc->entry.path;
 	*modep = desc->entry.mode;
-- 
2.31.0.rc0.126.g04f22c5b82


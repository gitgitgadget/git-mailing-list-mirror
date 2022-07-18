Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D13CCA47F
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 13:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiGRN3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 09:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbiGRN3n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 09:29:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CA962FB
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 06:29:42 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v16so1225514wrr.6
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 06:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=++pjL6Wqrgp5T8LlIQOVb+SeF+nGGYMuS4FNlnr5Gbs=;
        b=lxVY9gG3/jiWamwFPCVgHtJdt9+a57tayo/igU7lXe4tztbW5yDJEFXz4T/efyl5FE
         cdCWw3tYSX7/JexHP3LyJK0inCsqd4TICk7VWQgQ39W7vCCyI15F1E8Q2RQxqc4pbwWq
         rIEheWUEjMb0LjJ8QvFs3WQmnPeNoxKcwvKM4IadVmpigvUSpK1r8nUf48B4P/nUJa/0
         XR3mwaF1OLCDkdZLbmVPri+3i/k0i3Ibp7seFTtP/IMcqzlLgtQ7Ztg+991mjeuspXet
         gQ0S2f8uMNPnR+kRRFXEoWgjBilGJTcu3dcz5e5/g9ZGRwWxYM7ormuJCBLKroKVXMXo
         om6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=++pjL6Wqrgp5T8LlIQOVb+SeF+nGGYMuS4FNlnr5Gbs=;
        b=po/mMC13VOPIIasj3Vju4/Q02e227J4U2KYQIS28DN8bse5wTPlE3E2aos6kj2OctB
         3H4OsH/bsYDh+tO1+qIgoQCdr2vlIJbHOn0uLE3J26p6K+z48HWUzFJy5suqM28Qbdry
         bMUQzAiFEkiF4iqsnQ2N0Mio03PBwYn/SnyKqR+Keg72lfDAxXSr2XcldarJ7zfgEcPJ
         gE0d+61kxUnKII2OZPGktUqJwDsFZrUDjnEfTbRp0326MdjH9ptswxbeanyNQLB/zTKx
         aVqyGGtHpyDLD9EavJ/iXkNenN3ctfdH2nEC7QxgjZkQ74I9FXOEGTXdLqHsF89baAE3
         /5Wg==
X-Gm-Message-State: AJIora8Mwbr/3NStoVYqkrXtoNKQ+Db+yxLj30uhMUX4F+hP4cp1hDXq
        wqS8EVEkIyLNM6D5t8El2/QZcbb0Tj8esA==
X-Google-Smtp-Source: AGRyM1vIjAEcO80YGYMAeNxxn8gkcyjFRfYe7bn/zcSBlQg7YBLpCrqe841lajhvSSY/IEeQt14MMQ==
X-Received: by 2002:a05:6000:1883:b0:205:c0cb:33c6 with SMTP id a3-20020a056000188300b00205c0cb33c6mr23736363wri.39.1658150980769;
        Mon, 18 Jul 2022 06:29:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p4-20020a1c5444000000b003a30572072esm14277296wmi.6.2022.07.18.06.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 06:29:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/8] help.c: BUG() out if "help --guides" can't remove "git" prefixes
Date:   Mon, 18 Jul 2022 15:29:27 +0200
Message-Id: <patch-v4-1.8-4428f0a6fb1-20220718T132911Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1032.gb00b5447790
In-Reply-To: <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
References: <cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com> <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust code added in 929d9192828 (git docs: split "User-facing file
formats" off from "Guides", 2021-06-04) to be more strict about the
prefix trimming of the "guides" category.

There are no guides in the command-list.txt that don't start with
"git", and we're unlikely to ever add any, if we do we can remove this
BUG() invocation, but in the meantime this makes the intent more
clear.

While we're at it remove a stray newline that had been added after the
"return name;" statement.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 help.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 41c41c2aa11..24ac50f62fe 100644
--- a/help.c
+++ b/help.c
@@ -47,10 +47,14 @@ static const char *drop_prefix(const char *name, uint32_t category)
 
 	if (skip_prefix(name, "git-", &new_name))
 		return new_name;
-	if (category == CAT_guide && skip_prefix(name, "git", &new_name))
+	switch (category)
+	{
+	case CAT_guide:
+		if (!skip_prefix(name, "git", &new_name))
+			BUG("category #%d but no 'git' prefix?", category);
 		return new_name;
+	}
 	return name;
-
 }
 
 static void extract_cmds(struct cmdname_help **p_cmds, uint32_t mask)
-- 
2.37.1.1032.gb00b5447790


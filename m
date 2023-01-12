Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA6AC54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 15:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjALP1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 10:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjALP0O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 10:26:14 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EBF3DBDD
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 07:19:19 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id tz12so45579890ejc.9
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 07:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfSgPDChzhHBhmijf3/7kpdqA3N1N+gaTlurk7EXF0I=;
        b=XthLXwWxMUsNUcQDXgE/Lm6Bw5iFPK9fBfnG7t0RDqsnUGQTgPc9ZPH1rQe3OYLefI
         Sk+rJ/bqBTOTSD+u5u2KYXsZcKUBn4zIfEm6VM2UqLgBBq/kpw9N5+HBgvbbKH8MT7T0
         52AP6mlJDgjwRwvU4dBRlr73TVV35cL9QvoU6/DkPK1xD0FpJONzlGAN8aWb5Z0+7Eup
         bZExP5gqRVw4i+6Q7n/pu9UCCPuVuNaKun+QdaAZxGaQeHAxczPGAXwvNQQwIDhaUfGk
         Rov8H0TkEV90FvqL2zmTJNh8bjxqDQpWatzIi1qBSE4B5kGFyOZLui6hs6AJddBaZnMP
         s8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfSgPDChzhHBhmijf3/7kpdqA3N1N+gaTlurk7EXF0I=;
        b=uISBRLTJVLNVDaD/rtQxWhPtYZqYpamufsdjf6bt1UZ1IUvqFAgDT0Rj+1WOhzTyQP
         TV6iJYEIN3LafkeRkHoJxgmdibgOuh4bJqeQFFj9dbfTpn06WznZd4+VDCsGk3Gbg8hg
         WI/k+X7wiaPGOd3fuJtaTniiFowbSPsHVL2dVdLoct+/+wNiEdGhgcKbRbb5D33+qhMk
         iyTxCECDSHar2/HZ+zgHp8UDDsLmPGoTvaSRJSdLijnVVbG5P0+XVsGWwKN0M0iCSlBQ
         1tGsjofIYQvaDH2WKBqgzTp/P2PWvPaFS6/otRQmffNpTkWfD5APwoODn3C8ltEWlswl
         mLEQ==
X-Gm-Message-State: AFqh2kr9ROvtXAdhJj+YFDR5msKbcSjMfGnm186CF2PEDAV80esmRxl+
        g3jpz3Q1jrSUXnCb7WffgTIlMHE7KcF8pA==
X-Google-Smtp-Source: AMrXdXuLuPlSnxWfzutGCHQ1YIdFMQ2a9EQ3CSOpsPaobfqPTEEPOSKBreuhDtbOe2Swgxu5oTbMxA==
X-Received: by 2002:a17:907:3445:b0:7ad:c5b7:1c79 with SMTP id ac5-20020a170907344500b007adc5b71c79mr54695009ejc.45.1673536757433;
        Thu, 12 Jan 2023 07:19:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id kr12-20020a1709079a0c00b0084d44553af9sm5493291ejc.215.2023.01.12.07.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:19:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/6] bisect--helper: simplify exit code computation
Date:   Thu, 12 Jan 2023 16:19:09 +0100
Message-Id: <patch-v2-1.6-32c45bbf851-20230112T151651Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1215.g1ba3f685d4f
In-Reply-To: <cover-v2-0.6-00000000000-20230112T151651Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20230112T151651Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We _already_ have a function to determine whether a given `enum
bisect_error` value is non-zero but still _actually_ indicates success.

Let's use it instead of duplicating the logic.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bisect.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index cc9483e8515..09505fc4dce 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -1440,12 +1440,5 @@ int cmd_bisect(int argc, const char **argv, const char *prefix)
 		res = fn(argc, argv, prefix);
 	}
 
-	/*
-	 * Handle early success
-	 * From check_merge_bases > check_good_are_ancestors_of_bad > bisect_next_all
-	 */
-	if ((res == BISECT_INTERNAL_SUCCESS_MERGE_BASE) || (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND))
-		res = BISECT_OK;
-
-	return -res;
+	return is_bisect_success(res) ? 0 : -res;
 }
-- 
2.39.0.1215.g1ba3f685d4f


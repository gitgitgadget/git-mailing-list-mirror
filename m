Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD71C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiI3SLe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiI3SKx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:10:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBA56365
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:34 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bq9so8019426wrb.4
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/1cLEdod4ALnz3T/ieUxFhhVPaKLXSa2PAfyxh9Bo6Y=;
        b=ENYaPjlU1MnXO9Cj/RkitL813DyFfsOefEHU9t03i/1+yDatc0wBKRrcyH8i24cruQ
         Vj5d7Noz6R5jxtA/sWm2w5IdBwqauyTTJODYAHr3AhN73i17VoJCLk1NHPz/aykJKYtc
         fMn7SjHFUlD02ue5svhJVuLMGi3zc7EO04F8Z5aG3mY+hKqtPupRj0k5VcLQFifyTA32
         m267TJPLijNFiA9RgAbSL9Sm9xOzNCW4oLN/ZXVDX4mzzJRLDN3ww5MoN2Ps3wo5ByR8
         juXbJcMuj3IzNfZHQuaaP/4CmTbePz2k3+THH+d+ELFnULAn1rU0qrDHsQeLThdwvzEF
         04Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/1cLEdod4ALnz3T/ieUxFhhVPaKLXSa2PAfyxh9Bo6Y=;
        b=pwHwba7G34EM3heLu5n95vPCPmx4REA11657gc9Vl+RFtlzGQBWoM8hgUP5JHDMA+Z
         8HX4lBNTNz0HpP84u1uteTkNJ2m1kPGSJzqkCxYhQh+k7gJTpedyiTh9IC2SQaSMypIf
         zA3IKSQf7ZOZ0FrkruEJnfLdSy2Y+nYRdhi1Kkkdz97f3bQmnJ39rqgd33/cq2T9OoOO
         ERX2FVZBuygpJLTPvzn9mLIggCAlOq8jGsDfQEvbZz7le2HYmicaeaaqFJad1JHl8YiZ
         aZXzUQuyD0ZNmTcJ5Rqq5bM0mjssm5ePJQwIsHUdTAKG19oGRU49qFFVMHY19MnMJ96K
         2IwA==
X-Gm-Message-State: ACrzQf1m3z+OF/uFa3jL5x7gIQ/f0S4rb3ZIhwm3cc5K18G63wEu5XzK
        MC7FvJPcnu4BxmZhFjLhoAYZR0bONKqKBQ==
X-Google-Smtp-Source: AMsMyM7gQiRC58kkNhIdaXcmOgWDvBs+hE6BoQeF1WXylBeWgX4bOil9JdN+FWwN2LTdY4ViR8/Chg==
X-Received: by 2002:a05:6000:168f:b0:22e:4c3:de09 with SMTP id y15-20020a056000168f00b0022e04c3de09mr1566336wrd.40.1664561372514;
        Fri, 30 Sep 2022 11:09:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:09:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 24/36] doc txt & -h consistency: make "bundle" consistent
Date:   Fri, 30 Sep 2022 20:07:47 +0200
Message-Id: <patch-v3-24.36-7f93da79fee-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the -h output to match that of the *.txt output, the differences
were fairly small. In the case of "[<options>]" we only have a few of
them, so let's exhaustively list them as in the *.txt.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bundle.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 1b08700bf9e..544c78a5f3a 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -12,13 +12,14 @@
  */
 
 #define BUILTIN_BUNDLE_CREATE_USAGE \
-	N_("git bundle create [<options>] <file> <git-rev-list args>")
+	N_("git bundle create [-q | --quiet | --progress | --all-progress] [--all-progress-implied]\n" \
+	   "                  [--version=<version>] <file> <git-rev-list-args>")
 #define BUILTIN_BUNDLE_VERIFY_USAGE \
-	N_("git bundle verify [<options>] <file>")
+	N_("git bundle verify [-q | --quiet] <file>")
 #define BUILTIN_BUNDLE_LIST_HEADS_USAGE \
 	N_("git bundle list-heads <file> [<refname>...]")
 #define BUILTIN_BUNDLE_UNBUNDLE_USAGE \
-	N_("git bundle unbundle <file> [<refname>...]")
+	N_("git bundle unbundle [--progress] <file> [<refname>...]")
 
 static char const * const builtin_bundle_usage[] = {
 	BUILTIN_BUNDLE_CREATE_USAGE,
-- 
2.38.0.rc2.935.g6b421ae1592


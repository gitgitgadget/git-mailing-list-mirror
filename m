Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20DCC433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiJDNZS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiJDNYq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:24:46 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5651543DE
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:19 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n12so1721904wrp.10
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1cLEdod4ALnz3T/ieUxFhhVPaKLXSa2PAfyxh9Bo6Y=;
        b=iPsZaMmkmSFvasBb0UetYV7gYbPqTxVSU8zTUeNCgI0qMxPRH0kDYOsrHqGn4RluK6
         CvgD3oCn9JKwfnvY6yyQWNT89yGJWFfK7veHgmsG1z8VYdZGVbWs6sYO70G8lB6ZlvgM
         KIxfglW99NT7JgdonvSwTf0XjHkRebZI9RdRzVVdpI+EOjUKN9jgtSzh1lmGBlpY1B2K
         ckdg2gh4HEJFz7e13Sm9IRskEk2wSBr5Vt04wFADyBQfH2O6eV8aw/eX1ZyX4wqjXtYC
         +ipX6puja7wnZTd7iaEgXWf7/Vw33fyx6O0FYRsNbvCh1MZPAEX53lHwCXIX/pB7QToa
         cSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1cLEdod4ALnz3T/ieUxFhhVPaKLXSa2PAfyxh9Bo6Y=;
        b=z4arlN9N/GLGgJZCAefcbv2aSs7HhA2pIv/FWOQxLP9sFtoT8zo9Z0W+YrFdZ8rxAa
         8XWM0BPqMB50G/GbnudYifpm7eC7RKum31o/H7ExDiPEM6cfiOQiNwYEJKfAPcBavBHJ
         GFpQGVDj/Gdm9M0LPscbUL9QfaO+twh5Cf3YPvVRjJRWE3Zd4feYQz2OPDAbNn5ADQoM
         phuCFTi7kOlQWNjSQtSbGX9EMy/K/c1aSpGbsvWHm3gtI+W5/8zqouRqlafKtceXNou2
         Ti8ODrl+d0UT+9w4VOjocbJShRBnFzgfQ1ZaZJtr71pR54GWIdQPitwYOamxR+5flKHc
         lBTg==
X-Gm-Message-State: ACrzQf0GcTOqnXLNo4RxTsRGaY0k6ylEmMASWObevOf7bovhNJvFZ1LD
        lmJCqcAtNtVj11NJsx6FeKVCA+89MmvnbA==
X-Google-Smtp-Source: AMsMyM6ZJ2/r2zgHRXyyNFrnI9sYpmIaO9f4KuqSLcWsCHZO5+/b8OMv0z/hW8iB6h+CuBeKvHySIQ==
X-Received: by 2002:adf:fe0f:0:b0:22e:482b:b63a with SMTP id n15-20020adffe0f000000b0022e482bb63amr3723545wrr.586.1664889859006;
        Tue, 04 Oct 2022 06:24:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:24:18 -0700 (PDT)
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
Subject: [PATCH v4 22/34] doc txt & -h consistency: make "bundle" consistent
Date:   Tue,  4 Oct 2022 15:23:36 +0200
Message-Id: <patch-v4-22.34-c3d227c17c6-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
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


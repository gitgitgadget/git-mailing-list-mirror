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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E6EC433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 095BE61409
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbhEJPOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 11:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbhEJPNn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 11:13:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16176C0515E7
        for <git@vger.kernel.org>; Mon, 10 May 2021 07:32:18 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id b19-20020a05600c06d3b029014258a636e8so9026153wmn.2
        for <git@vger.kernel.org>; Mon, 10 May 2021 07:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Hy0oDJzQswu4oVG5bx2G1fOrpIjehgpvLuJpvFbH+0=;
        b=SVLzN/dMY2RuJkcKBKO5YYPImEE0kXiCAus2XLuyOhi4jDE3FdT+c68NjQ+vL+Viz/
         YfMmxeHZFuzfs1QRgik9cfzmWWRJdp94JQ3jMXGUHyFTfiEBdnCQMQUkOxQy6cG0AuHo
         b/iHsIt3ffucPgQcvzzoX4TmRgyS8BXM+WnwLnHS5PXAjgLJIwnyNAbyMVCiWu2fodfW
         Yifre8Ca7yjne+fF3Toq8ikY1rpskfusoLF6IjbTUHp29WK7y+NHmGYb21FSI3sJRnY+
         ElKRRYVESVz3HkkGmfJZyHV3ErZT0l+W4TBo16f40uSDG44y9AK9WgpuU7GHPCceety/
         Scmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Hy0oDJzQswu4oVG5bx2G1fOrpIjehgpvLuJpvFbH+0=;
        b=Uwhkq+hB7LbPyPafuMFA71PC34aPkBcp9Lv931scT4XY6EI+Ntybh9dcOhcyx+9DUj
         bDFkzCyaIGZ75LHWFOVo/YLfKDWfGlJ8Z4fnsSIxKXluTYPn/3anTXaXMkQDyHUzDxTj
         GIe7SKBw+fjJmpXMUExqVCVOv6tJSdL0o1o1/9dAMpbfj4gIkK3lWBjiZQVvSqHK7UCU
         Bykwgj4XA9dY1ewIr4euHzxvshnJAmqyqU1LyBVJc1z6ecd8GExPao+WJ3n6a66MtXRy
         76AQOhDF06ybCb8ynUWEUGxRERih2qObCCuJCKQJxp0nC2PRUxxs6QZhkv2Our/BDBpL
         ebkw==
X-Gm-Message-State: AOAM533uUMRt81at68oFEkAw4hH+zGeWTWTWShfj/yXSiFEvwpXZEwZa
        3pfdKjv/1r+7p3TLUscHrDLnj1D8UvAfVQ==
X-Google-Smtp-Source: ABdhPJyK+4Y2snwplU02TQrn4+oSBRVxNFKYYyZJlxm9+B44B5BKtIPTrSGdp+9VYH9M7/tzUUe5jQ==
X-Received: by 2002:a1c:2285:: with SMTP id i127mr26258538wmi.27.1620657136620;
        Mon, 10 May 2021 07:32:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q10sm22421839wre.92.2021.05.10.07.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 07:32:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 03/11] test-lib-functions: reword "test_commit --append" docs
Date:   Mon, 10 May 2021 16:19:02 +0200
Message-Id: <patch-03.11-c2a0140fcd9-20210510T141055Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g924d365b763
In-Reply-To: <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com> <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reword the documentation for "test_commit --append" added in my
3373518cc8 (test-lib functions: add an --append option to test_commit,
2021-01-12).

A follow-up commit will make the "echo" part of this configurable, and
in any case saying "echo >>" rather than ">>" was redundant.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index b823c140271..1f787ff0726 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -172,8 +172,7 @@ debug () {
 #   --notick
 #	Do not call test_tick before making a commit
 #   --append
-#	Use "echo >>" instead of "echo >" when writing "<contents>" to
-#	"<file>"
+#	Use ">>" instead of ">" when writing "<contents>" to "<file>"
 #   --signoff
 #	Invoke "git commit" with --signoff
 #   --author <author>
-- 
2.31.1.838.g924d365b763


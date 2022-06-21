Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC0EC433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 22:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354653AbiFUWer (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354499AbiFUWef (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 18:34:35 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B53B12D01
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:34:34 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id s1so20838263wra.9
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LiK60wxSbl1QKAxSNxR7J6zIrMfZjT4ZMq16GMAW/Xc=;
        b=MOldqQKwMgZ1ccffcCxlcXF15FZ5Nhd6yURdrowN64DN+tHD7PXEY7QMxCoOTQIkcO
         GupGS1CK6c9GS/CkLkGoRF8MOVZ4fQasTaLcEkgm8W0UTfnox0pHalXuWIg/EfVq8Pmx
         MpjsIq5PBQPAFV1zvB/RoS7t1PNoXOikLrIi3AvQdwqbH3wIJY9qZ3CRsarUC0nyr6C2
         eCTYKEWdI6B/5PA1d0e0AcxjPTrAjgOoYjVmg5hKjuItuAb+k5RD24EBx2aKCTi4Gbb5
         yZvERmhh+YijPXdb95P1seouLTwARoJjD1D7FSIWPw8FdH4737Bjoho4Aw8g/0EGfZ2v
         /L2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LiK60wxSbl1QKAxSNxR7J6zIrMfZjT4ZMq16GMAW/Xc=;
        b=sz0h+se/zOrNiyhImEq5z85wy+1XDTGL9HA7C9tSSnCdtUGIs2QoRelh0cV/e8m9WE
         hVOnF+ri04Mlf2GlLjdWwOzJAYa1HgYFcSWAFiViW9JegmTlfKPpmBHM3CfuEVMn2kWF
         3+NAK+gqZHSMluQkbuwSbs7YLwO82OIDxxdziEZkVmAsilk9XmSy+RgnGdyeo74IGabG
         dUcf0q1tijOG1QQVp2EsNd7j9SRtH7cIFIkybynHpF2crgyJYZUeFmGV42WvHKA+mGZh
         cdXBhMn4w9kcDTo8kjqhUBpGmkDuRWByBFEx3BzT9iZOZSbkUn8703j81rgwalOh+LhT
         DK3A==
X-Gm-Message-State: AJIora9jcYkeAkxRyiA3eVkHGb1E2hdNJOExkH13u90WuUKC7rAn8n8T
        1yY/k8TxMWHMA0SFrRGcR+9KhzyjNrhWbA==
X-Google-Smtp-Source: AGRyM1vNVe7G8eJ9RXJHyjxDMu7T8tIyy7BRzbD2Sqw6MHWA3TceZS3oe8EDPijM8ED0kXVJcF1D3g==
X-Received: by 2002:a5d:43cd:0:b0:21b:8e53:befe with SMTP id v13-20020a5d43cd000000b0021b8e53befemr197724wrr.255.1655850872419;
        Tue, 21 Jun 2022 15:34:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020a7bcd85000000b0039c7c4a542csm19000299wmj.47.2022.06.21.15.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 15:34:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        rsbecker@nexbridge.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/10] fetch tests: remove lazy variable setup
Date:   Wed, 22 Jun 2022 00:34:19 +0200
Message-Id: <patch-07.10-267a6a6ab8f-20220621T222854Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
References: <xmqqa6a5g0m3.fsf@gitster.g> <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the lazy test setup added in e1790f9245f (fetch tests: fetch
<url> <spec> as well as fetch [<remote>], 2018-02-09) to make it clear
that these variables aren't changing across runs.

We can also do away with the shell invocations here, but let's do that
in a subsequent commit, for now this shows that it's safe to do this
more than once.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index c56a00f1a17..7cfef0082c0 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -846,14 +846,9 @@ test_configured_prune_type () {
 	shift 6 &&
 	local cmdline="$@" &&
 
-	if test -z "$cmdline_setup"
-	then
-		test_expect_success 'setup cmdline_setup variable for subsequent test' '
-			remote_url="file://$(git -C one config remote.origin.url)" &&
-			remote_fetch="$(git -C one config remote.origin.fetch)" &&
-			cmdline_setup="\"$remote_url\" \"$remote_fetch\""
-		'
-	fi &&
+	remote_url="file://$(git -C one config remote.origin.url)" &&
+	remote_fetch="$(git -C one config remote.origin.fetch)" &&
+	cmdline_setup="\"$remote_url\" \"$remote_fetch\"" &&
 
 	if test "$mode" = 'link'
 	then
-- 
2.36.1.1239.gfba91521d90


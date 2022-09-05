Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9417BECAAA1
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbiIEI1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237639AbiIEI12 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:27:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D2613D58
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:11 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n17so10294483wrm.4
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Er4f1Ze+b6mphYSSZKyKkvy1dw6tjf09IJBrCgMYvmQ=;
        b=FS+OijmjIjFrbCJ5wVFt7M3obSxPokyE8WcDZlW0KLqmuDw48mGMfMzKmkyq1b1uT7
         tC76EcrGbhFQ/H2/yS0lfazo+ylteAim7urWIxpXSMSw281+/8eCQEFXhbUlM5V75+If
         EdyAPKm4A38nZUom0x9V4ZXWRSBfAYfVdwXKzcN/0Brqpbs3MHSo8jQdXwom8f+ep4eE
         UCauhSjnkXzPONo0y7WJehDPV6HRv88IxKsZuNIKv1LA9aArKkhZ9g+ycUY1Gu9Ef7ds
         lfFTVdJAuBvqwTdd5M3k2xIgkuuqo1PKa2qme8PgONiSa0TCi9TQxf+Rnl4Z9D1DO5sh
         /m/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Er4f1Ze+b6mphYSSZKyKkvy1dw6tjf09IJBrCgMYvmQ=;
        b=OnmhbuB8gJStWYz6AiyMyu32e33KlLu/ysoYmihyCXFyoTjbJdgEwJnLDTdrE7CTu6
         vSHooaEmOgN8piS6hhZgsALDU3+rDl6RoTHE4JHRBtgz318h/dn+FXcd91l6QS/sgTxv
         qV4B5H+EnsT3h4ju2f3WMM4Z/EgHN5aLX6L7qAV3s5uB17KdystJM2D+EzKDL77+wvIl
         9YPDNi89GhyKjqBryRuIiBO2CHTb0CictzJZZUB+bWvXK4VHf9FUVXRAN4QJ/K5nZ0EC
         f5WT3LdNAiq7eZC1TyRYw3aMe8vw5kZ7WYLPQk3r7CB1KmpwYWPM3wLhDph/tBTYOXFs
         m34w==
X-Gm-Message-State: ACgBeo1ZVdzRQKZjghusfoq85m9JfxZmEMLRVb9/4ERHa+SN+pwyMna2
        lQlyUDaN+KylrStFzYdRFX+Y+xL4tFqIXw==
X-Google-Smtp-Source: AA6agR6m71XTd3ri5O1EnJA8vaWz+zJ4MsOC5BuRh/09AatAe9aDwbOg0GogA8F6NOkrkYeQ55pVvA==
X-Received: by 2002:a05:6000:1f03:b0:228:6c98:b01 with SMTP id bv3-20020a0560001f0300b002286c980b01mr2999643wrb.250.1662366429390;
        Mon, 05 Sep 2022 01:27:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:27:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 18/34] doc txt & -h consistency: add or fix optional "--" syntax
Date:   Mon,  5 Sep 2022 10:26:29 +0200
Message-Id: <patch-18.34-df312ad3ceb-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the "[--]" for those cases where the *.txt and -h were
inconsistent, or where we incorrectly stated in one but not the other
that the "--" was mandatory.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/for-each-repo.c | 2 +-
 builtin/rev-list.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index c6379b783c8..d45d873f579 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -6,7 +6,7 @@
 #include "string-list.h"
 
 static const char * const for_each_repo_usage[] = {
-	N_("git for-each-repo --config=<config> <arguments>"),
+	N_("git for-each-repo --config=<config> [--] <arguments>"),
 	NULL
 };
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ada68a4af5e..3cc8aad52ed 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -20,7 +20,7 @@
 #include "packfile.h"
 
 static const char rev_list_usage[] =
-"git rev-list [<options>] <commit>... [-- <path>...]\n"
+"git rev-list [<options>] <commit>... [[--] <path>...]\n"
 "\n"
 "  limiting output:\n"
 "    --max-count=<n>\n"
-- 
2.37.3.1425.g73df845bcb2


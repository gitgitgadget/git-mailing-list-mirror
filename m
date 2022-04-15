Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A08C433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 23:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349631AbiDOXQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 19:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiDOXQf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 19:16:35 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047F749F94
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 16:14:06 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id e4so9557821oif.2
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 16:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pFxIeoWwbd+Fs4R1qRBFNeUvioFKwrtKg2wk7K6KnIM=;
        b=EGkyjyHQPtxK5DJJv+P/o257PJpRoDMUMnw/gzT6sHFqmLCc2ieKy/C430CKUCHUHq
         m9/HvqUBpnKfd4WoXCBtXKVaHelLviaqzGZ8JqNr2djDK5VlII2lj0dI3251AqDvfawc
         qyRdfFD30u8JlKNygzh+zwNbcvS+Pfx4jNf0CusgJcoCNYEbJ5eBcRcvg8jjV4DXbNmT
         MShRh+Os4zU++wMwJroV8jbKxi28VEa/kXhjwqjl2aeGGvPize2V3LUIaFlZXq2wxEsu
         vYBv4n877lOHf3PfDjC23x1iD19biqVwYS2iotnADziD7hYRi5u64B4nmi5oPoFrH2+7
         XJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pFxIeoWwbd+Fs4R1qRBFNeUvioFKwrtKg2wk7K6KnIM=;
        b=W6DqX2KCkV8B/hMIkPxn6w1+tF875Kaj4XPMkLwb++bsP6SiSJrTigyh7T6fqwKtMb
         YXMxNsB4El6YJp2tHAvL7G7okDGdaJY3jciMSqvPS8KcBp1O5rLVihGEJIfHELL6j4Gi
         skzR/iw/fXrKgs1WawQZlUTuwKnSBlSAC+Q8HlMIVF6N53gSgf7+UxbF6xfWLHWlBu/4
         OQcJPEUo0Zfzn3el+nPUednb+ggvjgeGbG8LBjED88PJLU+zW5NNHiHHYr4iJdhi58zh
         lu6tdKNd0A3oMAjoMnmow0ua/mmQ3QmyV0ZkugS/xOpZdFZnnO/2gUZvVYMyvWXfd6gS
         JkGA==
X-Gm-Message-State: AOAM532ukC2/MuRQYzc9IzM3X3ICWTIF1JUatAIqrXselPUH0+oE0/4s
        jKMNE2agoFGPQUlAphR4v1ekW8D+DuM=
X-Google-Smtp-Source: ABdhPJyQPbnFinNjYY6oh+uWLRTJABCzuP16AnAT3M9WALsplUul5PyD75yBKtbVax1XGN6VNx2nsw==
X-Received: by 2002:a05:6808:2207:b0:322:5be5:8ee1 with SMTP id bd7-20020a056808220700b003225be58ee1mr262328oib.43.1650064445270;
        Fri, 15 Apr 2022 16:14:05 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id l14-20020a4ac60e000000b0032993003287sm1584720ooq.38.2022.04.15.16.14.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Apr 2022 16:14:05 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood@talktalk.net, avarab@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 1/2] config.mak.dev: workaround gcc 12 bug affecting "pedantic" CI job
Date:   Fri, 15 Apr 2022 16:13:41 -0700
Message-Id: <20220415231342.35980-2-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.283.gbef64175c85
In-Reply-To: <20220415231342.35980-1-carenas@gmail.com>
References: <20220415123922.30926-1-carenas@gmail.com>
 <20220415231342.35980-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally noticed by Peff[1], but yet to be corrected[2] and planned to
be released with Fedora 36 (scheduled for Apr 19).

  dir.c: In function ‘git_url_basename’:
  dir.c:3085:13: error: ‘memchr’ specified bound [9223372036854775808, 0] exceeds maximum object size 9223372036854775807 [-Werror=stringop-overread]
   3085 |         if (memchr(start, '/', end - start) == NULL
        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fedora is used as part of the CI, and therefore that release will trigger
failures, unless the version of the image used is locked to an older
release, as an alternative.

Restricting the flag to the affected source file, as well as implementing
an independent facility to track these workarounds was specifically punted
to minimize the risk of introducing problems so close to a release.

This change should be reverted once the underlying gcc bug is solved and
which should be visible by NOT triggering a warning, otherwise.

[1] https://lore.kernel.org/git/YZQhLh2BU5Hquhpo@coredump.intra.peff.net/
[2] https://bugzilla.redhat.com/show_bug.cgi?id=2075786

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 config.mak.dev | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/config.mak.dev b/config.mak.dev
index 3deb076d5e3..335efd46203 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -65,4 +65,9 @@ DEVELOPER_CFLAGS += -Wno-uninitialized
 endif
 endif
 
+# https://bugzilla.redhat.com/show_bug.cgi?id=2075786
+ifneq ($(filter gcc12,$(COMPILER_FEATURES)),)
+DEVELOPER_CFLAGS += -Wno-error=stringop-overread
+endif
+
 GIT_TEST_PERL_FATAL_WARNINGS = YesPlease
-- 
2.36.0.rc2.283.gbef64175c85


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DE7C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 09:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiBXJdy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiBXJds (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 04:33:48 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFABB2325D3
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:16 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r10so985416wrp.3
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pCWrrgK17DsaGcJ8gg/ciBSvl0A6OnjRWjLjrVzlnj0=;
        b=QcaejJAC8A5jigUNhLFG0vbYIaTEaIcn+rFAmIy18VNX92VTDDCN/u62FDa5Ap0pa3
         i+mQsIY6JvgUx0J4M+3HKkni0YgZSiXcVb+pQkxDHkpSF3L1iVY/jjzwUrIwhKn2r3hJ
         b5OZ4+/Z4wIFRqYcFwPMAGf/CjpePVhJKv7GWG/w8jwjXsiV3npXFH47GrEB7jQIGTs3
         J+swyvV6uuHYrNzflVwLA5p50GJCl+tuZapG0Kxm57zbrKlRTWhb9UdsOkG5pUCisr1q
         6rNReGsBSJCkLv6KDSZfmUeebocFE6uGjQdliZCcppw7BgRBLoUi8seos48PwA2v5TKp
         jJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pCWrrgK17DsaGcJ8gg/ciBSvl0A6OnjRWjLjrVzlnj0=;
        b=mGXy00HQAXl2jSZGUlVIzkcZvHk/gTzSradKrkg0FaK+3eZmTsxQOZVKJ61CQ9rCvk
         khg87i/+YGxClDS7o2pFxYvTaGx/vQ+jOsHy3bocEq/CR1Fnkl8Tmfe1A4c7ekoesxl9
         wdA97k0m4KuW57UAooKu3AjG4bXf/SmPUbHfRO275VR8oLPVWbIcGW+hQXxJmmdq5cz6
         SjM/zmiiXMUZXZ9nwfgEFzCctA88n984jI5jmQzoNrh+FlfKZZHteBLFVCQRtvrGcKez
         HfrMhgoqKquZ/Ud5p7fzo9igTT7/xtCOz1mJF8YrpIXHbgPzWvQQTBvfisMpvUBirZ8d
         tsQg==
X-Gm-Message-State: AOAM531M+IJZn/iQpdYP5hpWbfw9b6nSotlguGGTmDUQnUy3e7kDyE1+
        NsjJ4WnOIss++JhHs/Cij3b1+etWrDV+xw==
X-Google-Smtp-Source: ABdhPJwAaHepUhH0YWmBksd0FhJw2Uajz1eZcxfIooo+K2xga5WBDHZnUgJ6OwRIqE3LwtEdhkrpGw==
X-Received: by 2002:a05:6000:1813:b0:1e7:6ac7:d6be with SMTP id m19-20020a056000181300b001e76ac7d6bemr1523437wrh.54.1645695195193;
        Thu, 24 Feb 2022 01:33:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q13sm2109742wrd.78.2022.02.24.01.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:33:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/12] trace2: use designated initializers for "struct tr2_dst"
Date:   Thu, 24 Feb 2022 10:33:00 +0100
Message-Id: <patch-05.12-2caa1661da4-20220224T092805Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1157.g524e2d5a0db
In-Reply-To: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the "static struct tr2_dst" assignments in trace2/* to use
designated initializers. I don't think it improves readability to
include the explicit 0-ing out of the
fd/initialized/need_close/too_many_files members, so let's have those
be initialized implicitly by the compiler.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 trace2/tr2_tgt_event.c  | 4 +++-
 trace2/tr2_tgt_normal.c | 4 +++-
 trace2/tr2_tgt_perf.c   | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index b5c63622d1e..c5c8cfbbaa0 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -10,7 +10,9 @@
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 
-static struct tr2_dst tr2dst_event = { TR2_SYSENV_EVENT, 0, 0, 0, 0 };
+static struct tr2_dst tr2dst_event = {
+	.sysenv_var = TR2_SYSENV_EVENT,
+};
 
 /*
  * The version number of the JSON data generated by the EVENT target in this
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index c7992650018..c42fbade7f0 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -9,7 +9,9 @@
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 
-static struct tr2_dst tr2dst_normal = { TR2_SYSENV_NORMAL, 0, 0, 0, 0 };
+static struct tr2_dst tr2dst_normal = {
+	.sysenv_var = TR2_SYSENV_NORMAL,
+};
 
 /*
  * Use the TR2_SYSENV_NORMAL_BRIEF setting to omit the "<time> <file>:<line>"
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index a2a0195e0f4..a1eff8bea31 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -11,7 +11,9 @@
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 
-static struct tr2_dst tr2dst_perf = { TR2_SYSENV_PERF, 0, 0, 0, 0 };
+static struct tr2_dst tr2dst_perf = {
+	.sysenv_var = TR2_SYSENV_PERF,
+};
 
 /*
  * Use TR2_SYSENV_PERF_BRIEF to omit the "<time> <file>:<line>"
-- 
2.35.1.1157.g524e2d5a0db


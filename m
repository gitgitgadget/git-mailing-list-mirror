Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6487EC433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 22:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiJTWoA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 18:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiJTWnw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 18:43:52 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5DD22C808
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:43:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so812690wmq.4
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYuUe9z0D067dYxdQDjo00k2NZJKUY1U6mQBoApI5Js=;
        b=HiH+KpVVWvbOi98385/WwFtvXvw7089U5pU5yFItn7dEe/e1hLcx3xmwJvBmo+u945
         x5lJOFcPgZrlKB7lZRbju7eS5jbU3KPxngENaIzwU/doZ4TOtESsvmw5KRqrICoj4C+R
         Qtx/uSVa2myEnyY+A+ZkvRq9U4MdB1kiBaiTIUnw5pVLUWYOiFRO4wOZf+6FjOyyvJUr
         1SfGf23JkKYRcMoexezOUenXKGX/XDnYql3zbWI9ni1/MBxcT6PQCBv4pSliMweSrqvr
         tYdd/MWB2LQhDvQgriqoioXt3a21mmJe3Hqwkj1Q/+qoj+fwlktAl+NhM/H/o93tqml9
         IP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYuUe9z0D067dYxdQDjo00k2NZJKUY1U6mQBoApI5Js=;
        b=GBusDQt9ab2tgFUp9GUZePtupXQS7ch8r/EzcqqSPla7GiEk2cWQwNCC5Spk3g4Ig6
         ueJh6Z/xcTD9DT9gXKVUldlOxOhY2n51ZD4a5AyLL7d7mVYAnIPXxo03qZWiCv1Lf6jX
         D5zXmyarqN3cprCDyPgCTr5XiNJY4JHpgbuYlaO8mSvaHHKa4/2WZuWJ3C2DEzb1xGNj
         pDHku0r4j/ML/aqwTq17sn3moh5w6KGkHwXoBMIWBlGsHNM7NLo3cdrtKW15ckpLdSYg
         8cV4AePpZLhqIqpMUyWt86S2g7+iXZKS+p5S8wmJIm+IB6ci9N0q9hdobaMnLqhLC3+d
         vSCw==
X-Gm-Message-State: ACrzQf1nljHbXWOYeZ/fMRYWVy3EjoTTTlwDjq6K/6r/WxcFkdNoBoCH
        kvktrogHOibdQcQsnQNLEiaaQE5NXrMWig==
X-Google-Smtp-Source: AMsMyM5o/qcmxi3bWn4MiPyDhJg/nSNFQq0dem1WfIzAeeD7F7gnGYxgEQxGxIHlKnwPseTPm0zDTQ==
X-Received: by 2002:a05:600c:4f07:b0:3c7:13ca:8afc with SMTP id l7-20020a05600c4f0700b003c713ca8afcmr2148685wmq.199.1666305818539;
        Thu, 20 Oct 2022 15:43:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4141000000b002238ea5750csm21102746wrq.72.2022.10.20.15.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 15:43:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 9/9] Makefile: discuss SHAttered in *_SHA{1,256} discussion
Date:   Fri, 21 Oct 2022 00:43:10 +0200
Message-Id: <patch-v3-9.9-c1f27255d3e-20221020T223946Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1178.g509f5fa8ce0
In-Reply-To: <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com>
References: <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's mention the SHAttered attack and more generally why we use the
sha1collisiondetection backend by default, and note that for SHA-256
the user should feel free to pick any of the supported backends as far
as hashing security is concerned.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Makefile b/Makefile
index 0ca8a9eb318..36d6bffd1f1 100644
--- a/Makefile
+++ b/Makefile
@@ -481,6 +481,16 @@ include shared.mak
 #
 # === SHA-1 backend ===
 #
+# ==== Security ====
+#
+# Due to the SHAttered (https://shattered.io) attack vector on SHA-1
+# it's strongly recommended to use the sha1collisiondetection
+# counter-cryptanalysis library for SHA-1 hashing (DC_SHA1).
+#
+# If you know that you can trust the repository contents, or where
+# potential SHA-1 attacks are otherwise mitigated the backends listed
+# in "Other SHA-1 implementations" are faster than DC_SHA1.
+#
 # ==== Default SHA-1 backend ====
 #
 # If no *_SHA1 backend is picked we'll fall fall back on using the
@@ -526,6 +536,11 @@ include shared.mak
 #
 # === SHA-256 backend ===
 #
+# ==== Security ====
+#
+# Unlike SHA-1 the SHA-256 algorithm does not suffer from any known
+# vulnerabilities, so any implementation will do.
+#
 # ==== Default SHA-256 backend ====
 #
 # If no *_SHA256 backend is picked we'll fall fall back on using the
-- 
2.38.0.1178.g509f5fa8ce0


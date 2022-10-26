Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493D9C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbiJZO5h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbiJZO5P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:57:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421DB915EA
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:57:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v1so26775443wrt.11
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLGBnao98U2XU+whEDXV4L3xqjUvQE7lEuTJMFWwHFw=;
        b=DwTJzDvepG7zTJhwN9uKoU1+PKM0uEa544wQTxHleuJvf+JSt+GQefP2vQ0apRKrHF
         Cq2brP2OeikGBKzEafjU4VgLLv5lSTVN3u1D45I3nVUXgdr+hgr1ddXMVFSeA8ucqjXa
         kyajds6lfUStGPlhi0LvbNzjVRelj+jyUCUAe4uh1Ba/3VqLTG9/3LAtFdrxlfVSXmj5
         +i1D//jIe3p/CUrzf+zz+TdyL4aVuPKs3zkyUcXQROmGDBC+KskrdPbbIYMMQgNbQ7Bh
         bp+7lnxCI8DMunJKdcozOncTw9xJ62/1fiKpBDARfB+wTa8mmzl207bkGGM5fx8EHQTM
         JluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLGBnao98U2XU+whEDXV4L3xqjUvQE7lEuTJMFWwHFw=;
        b=rINV29tj+jcKCqNSW1bnzuyvxWvKV0XzaA9+kjAMRp3NQPMqvVGwKAdQrA1UrHnuhb
         iiMQz8dg7pF6uoGViqn6oxOnrREiYOmgdhkY9A4dEUD1KEFRvpVO84Eex/TAfq8steQu
         LxFxcqiwlaSFQqr04VMxnKmq8kg6QT0sTYcaLPiRItZh9HWF3aSIzqOs3LqaEumz6PWk
         1JQPnrTbCCI7xdbdGnK7jjXWvoQG6d0WvJCqwl6NO4YofdlPQDFx4oGBQWb2mDWXXDfh
         uJqTdlrSvfuGODrMew4keuh1kWO6C1FJRegAE3VLz0otfmjWL2lpiNJ1GzQ0Pbix/Hab
         oPRQ==
X-Gm-Message-State: ACrzQf3kmwjVsLTictIimVaPB+azlIPK76iwZEwHrlfF5v/p31DfRFd3
        BCxfS45OeS0BK3rSMRrbt4hSXdXXjxWG7g==
X-Google-Smtp-Source: AMsMyM6nyxLspiEsV6v3lmTDWi3ngwbLcHHS9v3DBaTU8WRAYu4zcmhDcQt27KoIOJ76uwhUfCqPew==
X-Received: by 2002:a5d:5270:0:b0:236:60c6:6e80 with SMTP id l16-20020a5d5270000000b0023660c66e80mr14752279wrc.140.1666796221387;
        Wed, 26 Oct 2022 07:57:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i25-20020a1c5419000000b003c7084d072csm2180351wmb.28.2022.10.26.07.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:57:00 -0700 (PDT)
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
Subject: [PATCH v4 9/9] Makefile: discuss SHAttered in *_SHA{1,256} discussion
Date:   Wed, 26 Oct 2022 16:56:47 +0200
Message-Id: <patch-v4-9.9-9045ff9c4ed-20221026T145255Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com>
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
index a0ca6456b85..805e88ed5fd 100644
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
 # If no *_SHA1 backend is picked we'll fall back on using the default.
@@ -525,6 +535,11 @@ include shared.mak
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
2.38.0.1251.g3eefdfb5e7a


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA07C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 22:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJTWnw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 18:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJTWnj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 18:43:39 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE6022C80A
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:43:37 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 186-20020a1c02c3000000b003c6c154d528so3732098wmc.4
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ykuxgk8prIsidGt50Cx1O88XbTejOw9uctR0IvRxdlw=;
        b=DFj32XrTQRJhN5ZA2rwQ/2uCRK4n7aki0nNrAMd144wd9W+bw+wwuS+D4nGPzAhVmX
         3SrBlpvjbqfePJoSDBaqC/HXQzIpe3b9aHX3wzB5kDZqooIM5HCcl65UmWl36mT1A1LJ
         GACbmBbzchCo22h14FbMJfWB3kP5UMiT5crCm4O/f4tlB+suLJ6Dti1lhvYGnJi5KrXi
         NbBeJSDP7RQW/fb6OFXge9NG2Oqd9pA1FNrd8raHFxuKncJrF4HTuqO7AIcdlghd2oTg
         E/2VjZLAgqWMWRm003hT60BDlFhtwqkgI5SbiXtqeze6Bpgz7tWoS+BqaQKhrR6+sOvd
         yFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ykuxgk8prIsidGt50Cx1O88XbTejOw9uctR0IvRxdlw=;
        b=1wLPSVLKArKgcTSR6WfqIBFsUaXNpw6f4nMHF+lah4Gm12kiSdv4wpytajG8LSe91+
         /g1AxQcJLiHXkyA2wVDNAd2LWzEs8A1K3yMWEwBcuEvOr5GsLwHwiQHnX6YggaTRlA5+
         8C/3k0Ek7bwE7DZe3h/tsQzJH3h/hKAwjHR5MCaTpC6k8fLOFnRgKah64gJ6m3ZOzxi2
         7jJ8AT8WIGNWrJe0n0l5UCsu5RFPw6LcC25M1mqrgszc3/rov4/Jm6VyC7F+4PvIK4Wo
         yvrUmmXGl1OPgsmn9LnAjlDZxcHCTnr3mfUszrNnEj/FlJsZ05Yl2kwfumT1CPA39Nrc
         q5BA==
X-Gm-Message-State: ACrzQf0zCWkHcAawqWHEf7nDg/B3Bw/8L08lJ2EBWd3h40LUZWd+fEX6
        CJ5PHxCpAGods+HE6QPbPL/Rtk6C+Wxk7g==
X-Google-Smtp-Source: AMsMyM7rLzB06A5u/+tf20ZZ/aXL0X3tAJFRhWAh315npve07VXyYKrZxZHW49Et15XZFPaNLrwOXA==
X-Received: by 2002:a05:600c:3c8e:b0:3b4:d224:addf with SMTP id bg14-20020a05600c3c8e00b003b4d224addfmr31862567wmb.132.1666305815052;
        Thu, 20 Oct 2022 15:43:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4141000000b002238ea5750csm21102746wrq.72.2022.10.20.15.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 15:43:34 -0700 (PDT)
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
Subject: [PATCH v3 6/9] Makefile: document default SHA-256 backend
Date:   Fri, 21 Oct 2022 00:43:07 +0200
Message-Id: <patch-v3-6.9-73685592aba-20221020T223946Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1178.g509f5fa8ce0
In-Reply-To: <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com>
References: <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 27dc04c5450 (sha256: add an SHA-256 implementation using
libgcrypt, 2018-11-14) we've claimed to support a BLK_SHA256 flag, but
there's no such SHA-256 backend.

Instead we fall back on adding "sha256/block/sha256.o" to "LIB_OBJS"
and adding "-DSHA256_BLK" to BASIC_CFLAGS.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 61358f16acc..0bc8eaa4cf9 100644
--- a/Makefile
+++ b/Makefile
@@ -513,7 +513,15 @@ include shared.mak
 #
 # === SHA-256 backend ===
 #
-# Define BLK_SHA256 to use the built-in SHA-256 routines.
+# ==== Default SHA-256 backend ====
+#
+# If no *_SHA256 backend is picked we'll fall fall back on using the
+# default.
+#
+# The default SHA-256 backend is shipped with Git. No flag is required
+# to enable it. To select it don't define any other *_SHA256 flag.
+#
+# ==== Other SHA-256 implementations ====
 #
 # Define NETTLE_SHA256 to use the SHA-256 routines in libnettle.
 #
-- 
2.38.0.1178.g509f5fa8ce0


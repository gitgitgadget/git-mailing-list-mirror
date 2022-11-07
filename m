Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2F1C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 21:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbiKGVYB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbiKGVXa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 16:23:30 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2361E63F3
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 13:23:29 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v17so19644233edc.8
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 13:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4A5U71pUqFrLPNtPdNvyjbt9IUVm6mWuZej8FN1CNA=;
        b=YCxNYUbs84TIQMP6S82WiehkIumNiCKJ4Ido1W6MIZwhKLIPz9OXJxM/Onkh/i+Y0k
         HRhwGJAyvIeWKY9HTwVlDPf2/oQTYzjB4fuha9VYaAvGkQN8P2nWas2NaB/hf/OUAsmw
         FyA0lAqp6DbcI5VpFD58LO2RmSCz4XOapCfZDbsGQ6KWFbC4MjywnVNbcSUAtRT4SzcD
         FFz2jNqmav/BPiONYN2tqeyxOU3y6x6iIex3hjZeqZ8UXI+anheroOCazWXGx11qxXLI
         zZTRYV+cZmBeLjtajn/twapY50vcpaFSMiLNYGNfpit5gCRnB4v00Kbz9aYp/S+T7jjL
         V8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4A5U71pUqFrLPNtPdNvyjbt9IUVm6mWuZej8FN1CNA=;
        b=IjRDoXzZte+wNIpBBFUYilkC38oI7IATACEU0Sy8WSEzXiIKoDOlYXN6UgCYo0ljRg
         65ru670Ha3eFr0TIR7u22hTqY+Tg/ZlipCH7yQC934W4Dg01h5APwhvnCRocDSSs1qfK
         Cg3jrO4cQ3RY8upC0vEEd1jfXP5N3NhUIFhek5el+kWlN+bijL7w9sM7IudyPwZXui4O
         lDY9NDLlNRZjvp9aGZgVa2vBzoL2XRXK/WwuAtjQcByCnr67abDjW9q0QMMl9vNZMdnI
         nilxiBONddXcowIlEDZDU3GMVFeQhXq3HMo92VdnGQ2D44e308YF0DaxJ4ci9S/Nb84a
         EwPw==
X-Gm-Message-State: ACrzQf2Gv2f+sdNatDsSQAlHv0bPQTf6hDVO2WqnmBuoX2wdmcmZm5X1
        aaBcjzxnMBBDxgd5VvYV6x8jVs/zT6+3bQ==
X-Google-Smtp-Source: AMsMyM7PdlmG9Ayj03uFFgzjrR32kQWtJEDyBWSyYCCxcipAbcsDInVsBIQQa3pqdmNaM+yJL5odtw==
X-Received: by 2002:a05:6402:c07:b0:461:87ab:78aa with SMTP id co7-20020a0564020c0700b0046187ab78aamr53115063edb.258.1667856207176;
        Mon, 07 Nov 2022 13:23:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id gg3-20020a170906e28300b0077d6f628e14sm3834418ejb.83.2022.11.07.13.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:23:26 -0800 (PST)
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
Subject: [PATCH v5 10/10] Makefile: discuss SHAttered in *_SHA{1,256} discussion
Date:   Mon,  7 Nov 2022 22:23:12 +0100
Message-Id: <patch-v5-10.10-55d3751faea-20221107T211736Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1464.gea6794aacbc
In-Reply-To: <cover-v5-00.10-00000000000-20221107T211736Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20221107T211736Z-avarab@gmail.com>
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
 Makefile | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Makefile b/Makefile
index 7d0fa7adb61..91596bac4c0 100644
--- a/Makefile
+++ b/Makefile
@@ -481,6 +481,17 @@ include shared.mak
 #
 # === SHA-1 backend ===
 #
+# ==== Security ====
+#
+# Due to the SHAttered (https://shattered.io) attack vector on SHA-1
+# it's strongly recommended to use the sha1collisiondetection
+# counter-cryptanalysis library for SHA-1 hashing.
+#
+# If you know that you can trust the repository contents, or where
+# potential SHA-1 attacks are otherwise mitigated the other backends
+# listed in "SHA-1 implementations" are faster than
+# sha1collisiondetection.
+#
 # ==== Default SHA-1 backend ====
 #
 # If no *_SHA1 backend is picked, the first supported one listed in
@@ -525,6 +536,11 @@ include shared.mak
 #
 # === SHA-256 backend ===
 #
+# ==== Security ====
+#
+# Unlike SHA-1 the SHA-256 algorithm does not suffer from any known
+# vulnerabilities, so any implementation will do.
+#
 # ==== SHA-256 implementations ====
 #
 # Define OPENSSL_SHA256 to use the SHA-256 routines in OpenSSL.
-- 
2.38.0.1464.gea6794aacbc


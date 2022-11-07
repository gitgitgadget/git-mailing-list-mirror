Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02FFC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 21:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbiKGVXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbiKGVXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 16:23:25 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C29A328
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 13:23:22 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id k2so33664825ejr.2
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 13:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5a/Cm8NPIa6TCUJjHvRBqNMWeJxwu4ydupoqzVQx00c=;
        b=lmB541yWYqmPjaNYvDExTA0F5PQVTQIjO3sEmy8w+nyvo6DESFfm2fzDI4i6cNdI+I
         6cn8QLc0CFHfI87vr9I/pjDZS90wE2svbbzY+FDH58wfTJW21JtFnbxE0Xbag/5JgYeR
         1RMxY4XbgpNo2Cg0oPXQNxk5wLWSmT8BYM0iIqp7TE9+p5HQhiK6HriIv4YSHFCVACbN
         1lW6xmoYH9xQUjVP8Cwrk8TfUneo7yYA5mdKQkm79MZp8TKCjbUKyC4Woc441JA/cuEG
         18TOZqSjnLy7N50+v1NQUKUSS3ATERi9uFC2m3Dv5dkzOKkhNYapPuOGUeE4S7KLpKRh
         Crdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5a/Cm8NPIa6TCUJjHvRBqNMWeJxwu4ydupoqzVQx00c=;
        b=Nb5fVi7ihSBf/K7ssaM78/nN5QtH4uQHlHgf7TN6Pu/kv4sgzCAGqItltgpovtyFI8
         trDQiF3K71mHhjFOZpnrtohJ32pUNwEYAjd+1SxQo3ew3wkoXTtySOI8ubwWNSqN0Wb1
         A9zEVr6BxHhv0p2GmDiJYw42XbntJz44etwvO8IIue8MJV9h8ReFNUzwBhzIfvvblqTG
         kAXqTMgxfeAFRCpvCwuOdAEYSWqi2PuyniJSZlvVEqXh1aGQf9HS1h2sy2pXY02rdZNx
         4XBu4Zp/MGqpYEzddX/SoREHa1kV84D0m33CMmLZ+CpF9AKM/UIQTGmP3ykKMSh6qj38
         +rLQ==
X-Gm-Message-State: ACrzQf0T8IOZnkqM3ZsOG6AR8QX99hJeLKAaIzurthbfj8YDVi9EfUH9
        B/3jXWagFE7PBCiDYic8/v9xxgP8AIKiyg==
X-Google-Smtp-Source: AMsMyM76FAT1Ip3is8OLWnrJa8AuVStiRHtFcda32jsw5LRxI05sqnNlzfX/uCC5HSG6hIWCtSuxDw==
X-Received: by 2002:a17:906:ad81:b0:7ad:d411:30af with SMTP id la1-20020a170906ad8100b007add41130afmr836397ejb.636.1667856200830;
        Mon, 07 Nov 2022 13:23:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id gg3-20020a170906e28300b0077d6f628e14sm3834418ejb.83.2022.11.07.13.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:23:20 -0800 (PST)
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
Subject: [PATCH v5 05/10] Makefile: rephrase the discussion of *_SHA1 knobs
Date:   Mon,  7 Nov 2022 22:23:07 +0100
Message-Id: <patch-v5-05.10-5f1da5d7dc4-20221107T211736Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1464.gea6794aacbc
In-Reply-To: <cover-v5-00.10-00000000000-20221107T211736Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20221107T211736Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding commit the discussion of the *_SHA1 knobs was left
as-is to benefit from a smaller diff, but since we're changing these
let's use the same phrasing we use for most other knobs. E.g. "define
X", not "define X environment variable", and get rid of the "when
running make to link with" entirely.

Furthermore the discussion of DC_SHA1* options is now under a "Options
for the sha1collisiondetection implementation" heading, so we don't
need to clarify that these options go along with DC_SHA1=Y, so let's
rephrase them accordingly.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 19235624684..251368b315d 100644
--- a/Makefile
+++ b/Makefile
@@ -492,20 +492,20 @@ include shared.mak
 # Define DC_SHA1 to enable the collision-detecting sha1
 # algorithm. This is slower, but may detect attempted collision attacks.
 #
-# Define BLK_SHA1 environment variable to make use of the bundled
-# optimized C SHA1 routine.
+# Define BLK_SHA1 to make use of optimized C SHA-1 routines bundled
+# with git (in the block-sha1/ directory).
 #
-# Define OPENSSL_SHA1 environment variable when running make to link
-# with the SHA1 routine from openssl library.
+# Define OPENSSL_SHA1 to link to the SHA-1 routines from the OpenSSL
+# library.
 #
 # ==== Options for the sha1collisiondetection library ====
 #
-# Define DC_SHA1_EXTERNAL in addition to DC_SHA1 if you want to build / link
+# Define DC_SHA1_EXTERNAL if you want to build / link
 # git with the external SHA1 collision-detect library.
 # Without this option, i.e. the default behavior is to build git with its
 # own built-in code (or submodule).
 #
-# Define DC_SHA1_SUBMODULE in addition to DC_SHA1 to use the
+# Define DC_SHA1_SUBMODULE to use the
 # sha1collisiondetection shipped as a submodule instead of the
 # non-submodule copy in sha1dc/. This is an experimental option used
 # by the git project to migrate to using sha1collisiondetection as a
-- 
2.38.0.1464.gea6794aacbc


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC10C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 21:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbiKGVXq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiKGVXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 16:23:25 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFA3DE5
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 13:23:23 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z18so19621279edb.9
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 13:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1Yp8FmSYqhG9hXrwvjt1gFwr87ipouyHNQtQe9NlYY=;
        b=YgcC2gsVEPeUNfJYYQ7pNZpqPIOYlbTPT5IqG1scJ0PFR1zlZEJYBvswplgvaU9uNC
         WRE9isu0LVSiGHA8szbUMNhUVX/BK6jmfzMjuMvf8Gte9XJB4lEltsmJHLq36KxPi6QI
         G6CCN6v+78SiStCvhcqVNjUZR1COCS+VUoOQqJ831lCvC7ZjTV+KR3DORLKhdklod3Wx
         UiPHuJlS/fIK1ayO7VTj3Flrtte1K/d9O476h6D21ZrCc0aoNlYftVrfNQlbe4NfNk2l
         0JRPI7w7GuRNiPNffy2yBuWFJQVWjqs2nLBxJs6pyW7VZm0wNz894G3c4ldiGG0g5FB6
         hQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1Yp8FmSYqhG9hXrwvjt1gFwr87ipouyHNQtQe9NlYY=;
        b=ElFM7Z+u36b1p4hsQK0VEMQ1ufhghYsjf0rZNoowrJ2pc1gXdbgp1AkJYh6Ozfq0E1
         klXjyhc+FVFMao55pYSwE2aok8rtyolS5m8smPA0C80ZuiamEygtNOGXV+DXLzGr0OLv
         p5fh3pxHsxyfps6i4F5Tv6T8gKT7H4aC5jygOwhlYp4jpl+QqI3SVQ8FT3Z+RJfPS3VP
         MQoYGSUSmllYKukxjv7k3uXsenxaoosNyCBv8kgDSCxDIASx82L5buRhxDmGdonE2TZ4
         t1DPs6K3ZOkoGgnLCcF5hxDod3EnZ/cDmBsgZNXMIPz2l0TVXrljCu1iq9Bbtm3rxS6Z
         cS6w==
X-Gm-Message-State: ACrzQf0h5CSWQ7KbWtPuoU12QLqZGS1sQNZkuDYwWBijg6In71LUmtZq
        qotmJyYkiNQVjT486LXpqR6BDhHCltu9RA==
X-Google-Smtp-Source: AMsMyM7e8B9/tP+3vi7akdvySWNcU66n0ez25ezUpVyi1nCx3v4PHZC95hp5s80o2x6lkRYlx+GpqQ==
X-Received: by 2002:a05:6402:448c:b0:457:52eb:b57e with SMTP id er12-20020a056402448c00b0045752ebb57emr52876836edb.178.1667856201945;
        Mon, 07 Nov 2022 13:23:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id gg3-20020a170906e28300b0077d6f628e14sm3834418ejb.83.2022.11.07.13.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:23:21 -0800 (PST)
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
Subject: [PATCH v5 06/10] Makefile: document default SHA-256 backend
Date:   Mon,  7 Nov 2022 22:23:08 +0100
Message-Id: <patch-v5-06.10-2cadbddcc04-20221107T211736Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1464.gea6794aacbc
In-Reply-To: <cover-v5-00.10-00000000000-20221107T211736Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20221107T211736Z-avarab@gmail.com>
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
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 251368b315d..646fbe5b7dd 100644
--- a/Makefile
+++ b/Makefile
@@ -515,14 +515,15 @@ include shared.mak
 #
 # ==== SHA-256 implementations ====
 #
-# Define BLK_SHA256 to use the built-in SHA-256 routines.
-#
 # Define NETTLE_SHA256 to use the SHA-256 routines in libnettle.
 #
 # Define GCRYPT_SHA256 to use the SHA-256 routines in libgcrypt.
 #
 # Define OPENSSL_SHA256 to use the SHA-256 routines in OpenSSL.
 #
+# If don't enable any of the *_SHA256 settings in this section, Git
+# will default to its built-in sha256 implementation.
+#
 # == DEVELOPER defines ==
 #
 # Define DEVELOPER to enable more compiler warnings. Compiler version
-- 
2.38.0.1464.gea6794aacbc


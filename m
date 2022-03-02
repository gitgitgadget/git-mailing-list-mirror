Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35512C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 12:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241962AbiCBMum (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241950AbiCBMu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 07:50:29 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA73F8E1BA
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 04:49:45 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r10so2644366wrp.3
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 04:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Atmiv5SgKlFjDK1Gd0Py/M+3tX9JNziNNvvx662pO9g=;
        b=IiC8tM48HsUWVvUH0W1NfwN+AGGH1r6jbqHFKBEZybLh3CxO4gmXQxZVKrceJnZv1x
         dLnRzn8UX/YQU96BNgP1Esfgedk0jT2nGQjv1a7kQMklDy0s7DmBl9diu6O3UgFsccJ0
         js/s6AEQclFpX5Ftt0HrqBI150K59pm5bMlu2g1EXAmInvfEYj7Hw+HU1ndD3TW8WE6t
         qw4QKaOM1eKDUgDRqEgD5p9rYzZ6fSMObYwbvnDiRVv5fBxcVhla23oeDhwSKvAxb72Q
         QYYOAH42ITuTVqwspvYSA6bl0boSkvzxT7YixgVu48k29Fgtzo+PLWw6EjuzHh/wmdEF
         5GBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Atmiv5SgKlFjDK1Gd0Py/M+3tX9JNziNNvvx662pO9g=;
        b=OoLKrvaqTVvMDs7Gibuwu4dn9neNBsa5XQAyi2CHGGNJfbCd6LCwQJ+4HeG5iz5zxM
         m9iu+MaMdMtUEKxckVXRUCKqCgcEGpPT2MixXzqqzJ+uKVqa1tJlKpv6UFDzTgx0XtgE
         QTE89cNT4CulikPsE1HRshatqmxm21XlEOxL3ce8At/OCYb0Ttgzp7Jmaf3xhQ/mGrpp
         RN8GH8lxvKyefwN2F3aVSafZSh5Nc1++MF8iDOwJlulX74hqgirGJ56eKa+sJ8FfABzj
         EntWYr9+q0YyY17D51c4xCK1R0EswYbujBxguHTM01RoXUxIBf5wqTldmuwwzj3kdySi
         Idpg==
X-Gm-Message-State: AOAM5324rf/1Jnc0Qtv2L6lI2bIE5xQ+AFxL4EM01sZVuB8gSzswktHH
        jIB9aZZOJLCzyquono4xmVT1Wa9Nv5r/6Q==
X-Google-Smtp-Source: ABdhPJzFF5H8GsbF8MclS5XaIad1j+qLtpki0y7E2rRSNKGXayHnSP5UP79y8TrOC4N2b8+1d7c+6Q==
X-Received: by 2002:a5d:61cb:0:b0:1f0:2598:88ff with SMTP id q11-20020a5d61cb000000b001f0259888ffmr2851192wrv.444.1646225384256;
        Wed, 02 Mar 2022 04:49:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p30-20020a1c545e000000b003811f9102c0sm8210107wmi.32.2022.03.02.04.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 04:49:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 6/9] Makefile: move $(comma), $(empty) and $(space) to shared.mak
Date:   Wed,  2 Mar 2022 13:49:14 +0100
Message-Id: <patch-v4-6.9-741fdfd48e2-20220302T124320Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move these variables over to the shared.mak, we'll make use of them in
a subsequent commit.

Note that there's reason for these to be "simply expanded variables",
i.e. to use ":=" assignments instead of lazily expanded "="
assignments. We could use "=", but let's leave this as-is for now for
ease of review.

See 425ca6710b2 (Makefile: allow combining UBSan with other
sanitizers, 2017-07-15) for the commit that introduced these.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile   | 4 ----
 shared.mak | 8 ++++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index ce362720947..1e7a1277ce9 100644
--- a/Makefile
+++ b/Makefile
@@ -1289,10 +1289,6 @@ endif
 ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 
-comma := ,
-empty :=
-space := $(empty) $(empty)
-
 ifdef SANITIZE
 SANITIZERS := $(foreach flag,$(subst $(comma),$(space),$(SANITIZE)),$(flag))
 BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
diff --git a/shared.mak b/shared.mak
index 1dda948df09..934bf428936 100644
--- a/shared.mak
+++ b/shared.mak
@@ -23,3 +23,11 @@
 #
 #    info make --index-search=.DELETE_ON_ERROR
 .DELETE_ON_ERROR:
+
+### Global variables
+
+## comma, empty, space: handy variables as these tokens are either
+## special or can be hard to spot among other Makefile syntax.
+comma := ,
+empty :=
+space := $(empty) $(empty)
-- 
2.35.1.1228.g56895c6ee86


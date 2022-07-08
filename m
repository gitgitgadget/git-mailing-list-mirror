Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E0DC433EF
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 14:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237785AbiGHOUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 10:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237853AbiGHOUh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 10:20:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C509C222A6
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 07:20:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h17so17614757wrx.0
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 07:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5AXBuIp9hCX3KlqE+IoTeTfJOZru5FkD8YdGG01v1qg=;
        b=hErKp3dUJpTNiIhimsNO53zEUbs2G+iuY4GW0mEMqDeev1hjW+ZMWLsZ6tWYZffuzo
         jm9g22m3bUm/92nZ7lM4yis0S6F9ixj4eI9CTGEQZzBAt5IStNSwmBxGT6QzsbDPv36c
         BD2I4RzQlGnntanxSlJK/TCXG1dQtQsbwW4oaIdQDJe7lPs/ogCOxGggDN5HjrHUri2Y
         O4u1+/bwJ85iVwuIHiML7sAPEcVQnMnFzleJ95k+jZdQELGesY32vElv5B1WvWLVPFLb
         B8Qf745sOoMACIdTBeuMm2T//ar5bEiGitprLEVIak2dUzSSZajEh0rlz4psr3vrsWhk
         5JRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5AXBuIp9hCX3KlqE+IoTeTfJOZru5FkD8YdGG01v1qg=;
        b=GQbIeU3mOaEDHH3UmZIHGCBGDCpdt1QvmBqHb4EzQFR/CK6K0IHg6Yw26iCJfweSRb
         qGyXaQjfbfGf3ZswwAnS3x2qTQHO9zfQfjVXOavAwBykC5GkVlrwZeO8yUcn5VAyCdzW
         3+6LDfNsWVtrMrTQOKb/nr7eOP/dB9qs5PmnX68MznCxDy7vjcshGHA8p74lTl20se1/
         jFWshtekzL+taPik+DCdtwl24PfPwFo3/cHQ6iIsNdp8KHOdGblKs7oDlcE+G39LLQF2
         wV6FZFk484H5WIgMkKH3lvA1E2Av2pTTHYCNQxM3ONEDvMT2/tQvrrBBg9ZM7avWEnmF
         gBqA==
X-Gm-Message-State: AJIora8nuXgdVs5FxYOCTvIhF0xz4OWXUgJoeo+TyFcx/fkgLVsbMp5g
        gkMZs5UgLMFXeV0If/K26rZelYXuc5c5hw==
X-Google-Smtp-Source: AGRyM1tbrWDkeRHeSprUxJc5bhNjAh8JctmhWyqRxz2viDeqKTOzVsOFmB6lUj4rgovEQBuLot3x/g==
X-Received: by 2002:a5d:47c1:0:b0:21b:c5c0:b9dc with SMTP id o1-20020a5d47c1000000b0021bc5c0b9dcmr3576930wrc.189.1657290035053;
        Fri, 08 Jul 2022 07:20:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q5-20020adff945000000b0021b9585276dsm40393924wrr.101.2022.07.08.07.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 07:20:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/7] git-shared-util.h: add G*() versions of *ALLOC_*()
Date:   Fri,  8 Jul 2022 16:20:15 +0200
Message-Id: <patch-3.7-d7c14a1cad8-20220708T140354Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.913.g189dca38629
In-Reply-To: <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com> <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add "gently" versions of ALLOC_ARRAY(), CALLOC_ARRAY() etc. using the
naming convention G*() as a shorthand for "GENTLY_*()".

Nothing uses these functions yet, but as we'll see in subsequent
commit(s) we're able to convert things that need e.g. non-fatal
"ALLOC_GROW" behavior over to this.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-shared-util.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/git-shared-util.h b/git-shared-util.h
index 7b4479a0f72..718a8e00732 100644
--- a/git-shared-util.h
+++ b/git-shared-util.h
@@ -8,8 +8,11 @@
 #define FREE_AND_NULL(p) do { free(p); (p) = NULL; } while (0)
 
 #define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
+#define GALLOC_ARRAY(x, alloc) (x) = malloc(st_mult(sizeof(*(x)), (alloc)))
 #define CALLOC_ARRAY(x, alloc) (x) = xcalloc((alloc), sizeof(*(x)))
+#define GCALLOC_ARRAY(x, alloc) (x) = calloc((alloc), sizeof(*(x)))
 #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), st_mult(sizeof(*(x)), (alloc)))
+#define GREALLOC_ARRAY(x, alloc) (x) = realloc((x), st_mult(sizeof(*(x)), (alloc)))
 
 #define COPY_ARRAY(dst, src, n) copy_array((dst), (src), (n), sizeof(*(dst)) + \
 	BUILD_ASSERT_OR_ZERO(sizeof(*(dst)) == sizeof(*(src))))
@@ -71,17 +74,25 @@ static inline void move_array(void *dst, const void *src, size_t n, size_t size)
  * added niceties.
  *
  * DO NOT USE any expression with side-effect for 'x', 'nr', or 'alloc'.
+ *
+ * GALLOC_GROW() behaves like ALLOC_GROW(), except that in malloc()
+ * failure we'll return NULL rather than dying.
  */
-#define ALLOC_GROW(x, nr, alloc) \
+#define ALLOC_GROW_1(x, nr, alloc, gently) \
 	do { \
 		if ((nr) > alloc) { \
 			if (alloc_nr(alloc) < (nr)) \
 				alloc = (nr); \
 			else \
 				alloc = alloc_nr(alloc); \
-			REALLOC_ARRAY(x, alloc); \
+			if (gently) \
+				GREALLOC_ARRAY(x, alloc); \
+			else \
+				REALLOC_ARRAY(x, alloc); \
 		} \
 	} while (0)
+#define ALLOC_GROW(x, nr, alloc) ALLOC_GROW_1(x, nr, alloc, 0)
+#define GALLOC_GROW(x, nr, alloc) ALLOC_GROW_1(x, nr, alloc, 1)
 
 /*
  * Similar to ALLOC_GROW but handles updating of the nr value and
-- 
2.37.0.913.g189dca38629


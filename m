Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F22C433E0
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 21:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5603220B80
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 21:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="vS+c3Fq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgFZVyW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgFZVyW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 17:54:22 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0160C03E97A
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 14:54:21 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z2so8644700qts.5
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 14:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v/jFcjF6xEvU2cyiAocyHqy5sxWYrIi80R//ahBK4To=;
        b=vS+c3Fq6U8vG9e57mRk3PEXyWAvhPhbWToLTgnx4QcZtIZM6o+isGg0346D8D8VapD
         EOik4fxe9VKY7cUrMOnjTm5DyYWCCYO+eIr8t5pK/epfS3hNvmsSyJUXVkR/wVRbIiFS
         1WO6tUFP0q8jKNPKf5KjD2jvehmPTa1+uCNNwzFnoQHMEKyU8Ka+r/etpoBx/Wb88ODQ
         TCgEh14RewpVfJXT9ACuS5lFBy2uv0vQojO5QMB9Z1veAPTPSx2K8zgJTyOuGuiCMMFt
         zLmOREXcorfeXfNoQp5ekIp516mT1rRma1EGIDUNbTnI6svpMvx1Pi2O0gPzsyCY75aL
         SZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v/jFcjF6xEvU2cyiAocyHqy5sxWYrIi80R//ahBK4To=;
        b=hg7Ni9NaKf39oSEU802qUFZex9R9gSnJ8Sjy5uejr9dAvtkM27EwW0mfxJ2KItTOu3
         SpVxcXdh0S8APUD4o2yPVrbrpSg9ejNAj5l5+8uodOUp3vX/56wvrdeYUUl8N6Pu1Vm6
         iXRYRj8Y1dN+kMELO094bXPbBoQaAHMtcmSnt0wPgnqK8xSerSADu/g4rHuis9SY4fO6
         4IxppdZE2aWk4ZMGrYXybtqxMv3wsZzlW4Tv7odqa7Ohjg8TbuVZKg6OrnjZQIZm76aG
         ESlRQb6l1oGLlljXYsCpPHT56FI19zGtk03LFvfp3GyWIQfNChNY7Kczhe/8Jh80fhZB
         wUZQ==
X-Gm-Message-State: AOAM533OAKZt8wHoe7kG6gnCbMUxhn+AybcITwQqXeU3aICGiWQmCzVC
        vIhnMEhQr/brotDF2qisftMTRcOCTlo=
X-Google-Smtp-Source: ABdhPJw0/EitL8kCRDyAXplLC5o9u1pvqAD5R6y0TgBf/XSsDWPhXad50lHV4jiGujPOOUXOx4eQHQ==
X-Received: by 2002:ac8:3129:: with SMTP id g38mr4901037qtb.92.1593208460792;
        Fri, 26 Jun 2020 14:54:20 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::2])
        by smtp.gmail.com with ESMTPSA id c27sm9473475qka.23.2020.06.26.14.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:54:20 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, j6t@kdbg.org,
        jonathantanmy@google.com, peff@peff.net,
        Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        Fredrik Kuivinen <frekui@gmail.com>
Subject: [PATCH v2 2/2] hex: make hash_to_hex_algop() and friends thread-safe
Date:   Fri, 26 Jun 2020 18:54:03 -0300
Message-Id: <b47445fa1cef6d4523dd0ca336f7ee22bce89466.1593208411.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593208411.git.matheus.bernardino@usp.br>
References: <cover.1593208411.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hash_to_hex_algop() returns a static buffer, relieving callers from the
responsibility of freeing memory after use. But the current
implementation uses the same static data for all threads and, thus, is
not thread-safe. We could avoid using this function and its wrappers
in threaded code, but they are sometimes too deep in the call stack to
be noticed or even avoided.

grep.c:grep_source_load_oid(), for example, uses the thread-unsafe
oid_to_hex() (on errors) despite being called in threaded code. And
oid_to_hex() -- which calls hash_to_hex_algop() -- is used in many other
places, as well:

$ git grep 'oid_to_hex(' | wc -l
818

Although hash_to_hex_algop() and its wrappers don't seem to be causing
problems out there for now (at least not reported), making them
thread-safe makes the codebase more robust against race conditions. We
can easily do that by replicating the static buffer in each thread's
local storage.

Original-patch-by: Fredrik Kuivinen <frekui@gmail.com>
Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 hex.c | 46 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/hex.c b/hex.c
index da51e64929..4f2f163d5e 100644
--- a/hex.c
+++ b/hex.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "thread-utils.h"
 
 const signed char hexval_table[256] = {
 	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 00-07 */
@@ -136,12 +137,49 @@ char *oid_to_hex_r(char *buffer, const struct object_id *oid)
 	return hash_to_hex_algop_r(buffer, oid->hash, the_hash_algo);
 }
 
+struct hexbuf_array {
+	int idx;
+	char bufs[4][GIT_MAX_HEXSZ + 1];
+};
+
+#ifdef HAVE_THREADS
+static pthread_key_t hexbuf_array_key;
+static pthread_once_t hexbuf_array_once = PTHREAD_ONCE_INIT;
+
+static void init_hexbuf_array_key(void)
+{
+	if (pthread_key_create(&hexbuf_array_key, free))
+		die(_("failed to initialize threads' key for hash to hex conversion"));
+}
+
+#else
+static struct hexbuf_array default_hexbuf_array;
+#endif
+
 char *hash_to_hex_algop(const unsigned char *hash, const struct git_hash_algo *algop)
 {
-	static int bufno;
-	static char hexbuffer[4][GIT_MAX_HEXSZ + 1];
-	bufno = (bufno + 1) % ARRAY_SIZE(hexbuffer);
-	return hash_to_hex_algop_r(hexbuffer[bufno], hash, algop);
+	struct hexbuf_array *ha;
+
+#ifdef HAVE_THREADS
+	void *value;
+
+	if (pthread_once(&hexbuf_array_once, init_hexbuf_array_key))
+		die(_("failed to initialize threads' key for hash to hex conversion"));
+
+	value = pthread_getspecific(hexbuf_array_key);
+	if (value) {
+		ha = (struct hexbuf_array *) value;
+	} else {
+		ha = xmalloc(sizeof(*ha));
+		if (pthread_setspecific(hexbuf_array_key, (void *)ha))
+			die(_("failed to set thread buffer for hash to hex conversion"));
+	}
+#else
+	ha = &default_hexbuf_array;
+#endif
+
+	ha->idx = (ha->idx + 1) % ARRAY_SIZE(ha->bufs);
+	return hash_to_hex_algop_r(ha->bufs[ha->idx], hash, algop);
 }
 
 char *hash_to_hex(const unsigned char *hash)
-- 
2.26.2


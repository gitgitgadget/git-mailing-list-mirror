Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6166DC07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 09:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47E4E61108
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 09:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhGGJIb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 05:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhGGJIb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 05:08:31 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC92C061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 02:05:50 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id f17so2166674wrt.6
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 02:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aYH/OFBJsgNbsfS4KkU4evrVvh2O+gSLgercKSkU898=;
        b=GEouUeyZUcJN9D2pgqGH7CiVrkWLude4yKrgnxRFiXnKX+tnKsf0tljYV6ox2qZQIE
         I+nTKYBNQEaHlSDrJ0kLpcZ4pseUXPnHh59VR31J5ed76k4lJMd80+AZT9WytNZD48v4
         5sSx3GAwRThPYl90HGhtC7gfbW+CHukGFGX37CBsYFNViRqWOermeUEcIbaxxu6RbVET
         6MmCIXfqb9gRR0KrloPLfNJ89KfOBiFcSHOwCe+8WPO2FkpUbSw0E5003d20pEBy15vt
         iAPheko2jPKUqZlC4LEsOK1jCrSPN9twfvqpeNNsD3a2g9FnXJBWxM6uPp7kAaueGPYU
         gm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aYH/OFBJsgNbsfS4KkU4evrVvh2O+gSLgercKSkU898=;
        b=dF4z/F665L8mZxG+hm7fMoOwSbh/rrnTiq7SZS4QtxOEAYCOioK8MnH/mVG1sSphHc
         d/b13G9CW/Etz/SPdYl85ANHs7fas1vZNpGV4jZAb46hY9nvR0PXfvwMk1mQDrlaI7ij
         YhN5O7/7Re17sUfOJQTWqtxF4+Lil2zgZuDzRQe37lhFinN1ZUz0fKAJg2/G7o9f94ny
         YxiaU6vT2VX3sOTuzCToUWal5+8i0bombLO0NDD4qN860QhICe/oBFRLiuDrtLA/GTrv
         OOCRFmR4q1eNMVyGDMAdKeFc/coGuo1jOI/gQfEFl9yx2e6XS2bRJPsXtvMKjlbAbcQu
         9sdg==
X-Gm-Message-State: AOAM53081G6gOsZZeA5/pwF339qmJVze/KVUCoiPeufR7waPeB/2ZZE4
        eQsk6xYbAAPEybRi6al9BKljQIyusmHFgg==
X-Google-Smtp-Source: ABdhPJw1w5cO3qC9c2NqBWjyipBVIMwokDaWSw3AzN7qJ0G+K5Yx2plFLIt4AHq4Nke7iCyS0D0CKw==
X-Received: by 2002:a5d:6982:: with SMTP id g2mr6113263wru.119.1625648749293;
        Wed, 07 Jul 2021 02:05:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p9sm19184207wrx.59.2021.07.07.02.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 02:05:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] imap-send.c: use less verbose strbuf_fread() idiom
Date:   Wed,  7 Jul 2021 11:05:24 +0200
Message-Id: <patch-1.1-ee64a64449f-20210707T090458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When looking for things that hardcoded a non-zero "hint" parameter to
strbuf_fread() I discovered that since f2561fda364 (Add git-imap-send,
derived from isync 1.0.1., 2006-03-10) we've been passing a hardcoded
4096 in imap-send.c to read stdin.

Since we're not doing anything unusual here let's use a less verbose
pattern used in a lot of other places (the hint of "0" will default to
8192). We don't need to take a FILE * here either, so we can use "0"
instead of "stdin". While we're at it improve the error message if we
can't read the input to use error_errno().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 imap-send.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index bb085d66d10..9d06ef7cd25 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1266,18 +1266,6 @@ static void wrap_in_html(struct strbuf *msg)
 	*msg = buf;
 }
 
-#define CHUNKSIZE 0x1000
-
-static int read_message(FILE *f, struct strbuf *all_msgs)
-{
-	do {
-		if (strbuf_fread(all_msgs, CHUNKSIZE, f) <= 0)
-			break;
-	} while (!feof(f));
-
-	return ferror(f) ? -1 : 0;
-}
-
 static int count_messages(struct strbuf *all_msgs)
 {
 	int count = 0;
@@ -1582,8 +1570,8 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	/* read the messages */
-	if (read_message(stdin, &all_msgs)) {
-		fprintf(stderr, "error reading input\n");
+	if (strbuf_read(&all_msgs, 0, 0) < 0) {
+		error_errno(_("could not read from stdin"));
 		return 1;
 	}
 
-- 
2.32.0.636.g43e71d69cff


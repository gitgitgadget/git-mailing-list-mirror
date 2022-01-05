Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BDEC433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 13:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbiAENXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 08:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240320AbiAENXW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 08:23:22 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F6BC061792
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 05:23:21 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id l10so1631262wrh.7
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 05:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jNZZoe5UZRe9m+QE6yUfST+cSynTgcsr1CwoqLSHFFU=;
        b=Ke1K1zPV1NipRRIuNUgd0dHIBIetfBci7jDPvzI8IbNxO50pa+QB+MSd8ZJ5WUL1Xr
         Kf89C2blED4J0Z0ZPZ+804XjQMlROk7lY4Xwkg8epssxruqMe/os4FFmEpRvwUFO3vIR
         gtnMrBQCRHnGE0vAWxfP7/YU4sG1ucN+I6n797wQ9/7OrAMtmI3CK0VGLAgVk9QyfxcR
         c2T3R3SRTrw0zv6tQctumoJQ1ag7T1gj3sMe2je4rM+W6QiTJn835un6YC6voY+sqSBJ
         K8pkq/WzNpjmz6vEl6DpQDE4eB8I5dsAC1iP7dbSEO7FnmFIgW4TEIS5UasjzPDHehlx
         Yu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jNZZoe5UZRe9m+QE6yUfST+cSynTgcsr1CwoqLSHFFU=;
        b=hknPFHti3VLn8Ou9u1VCIAlVV7XfNB2QqAmMQm0FpHlTv/4zeHX+UFRs/aFkBGZ8hu
         NUOy39QzId6oV53ej1TJijCy0gfkcSoHC8hEEUwWQ8sexBSmJHY5NXUCfVPrSnxv1p7l
         iC4pIoJ6P50MrPGJSogPz7siaUmlc7EnR/yJNK7vEuHuGQlxraG7Z7AVqAh/Vvm/olqF
         ll+bEib1tkHNL5Uq7W3xQI1MnVjC3SRszOUNqqhtpstolbGVlw3LcSS6v5DTqkEvj3XG
         NXey7MyxUDXvky2jv5+HE688yq1iv1SVxH7LHp0jIeRV7fYMmytBMvgegkogZm0PHfHR
         o1PA==
X-Gm-Message-State: AOAM5323w8SyXtx/fIiqMo1FOfurHXFoobW6QqxR6bMBuPCqkyb8ITL3
        7mTgSYsRc9/hZp8HOIlLWw9pg8ZhQgW4Ug==
X-Google-Smtp-Source: ABdhPJy1qdGla58N/wd/qCEU652Goa3b8G4rydtSIIjE28juM56Vxvgh6veBF2uSVmnMHEK3DoucIw==
X-Received: by 2002:a05:6000:188c:: with SMTP id a12mr49377889wri.45.1641389000006;
        Wed, 05 Jan 2022 05:23:20 -0800 (PST)
Received: from Jessicas-MacBook-Pro.local (global-5-141.nat-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id l13sm45960853wrs.73.2022.01.05.05.23.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jan 2022 05:23:19 -0800 (PST)
Received: by Jessicas-MacBook-Pro.local (Postfix, from userid 501)
        id 2A977B2013A5; Wed,  5 Jan 2022 13:23:18 +0000 (GMT)
From:   Jessica Clarke <jrtc27@jrtc27.com>
To:     git@vger.kernel.org
Cc:     Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH] apply: Avoid ambiguous pointer provenance for CHERI/Arm's Morello
Date:   Wed,  5 Jan 2022 13:23:10 +0000
Message-Id: <20220105132310.6600-1-jrtc27@jrtc27.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On CHERI, and thus Arm's Morello prototype, pointers are implemented as
hardware capabilities which, as well as having a normal integer address,
have additional bounds, permissions and other metadata in a second word.
In order to preserve this metadata, uintptr_t is also implemented as a
capability, not a plain integer, which causes problems for binary
operators, as the metadata preserved in the output can only come from
one of the inputs. In most cases this is clear, as normally at least one
operand is provably a plain integer, but if both operands are uintptr_t
and have no indication they're just plain integers then it is ambiguous,
and the current implementation will arbitrarily, but deterministically,
pick the left-hand side, due to empirical evidence that it is more
likely to be correct.

In this instance, both operands are of type uintptr_t, with one being a
function argument and one being cast from a pointer, so both could be
valid pointers. Moreover, the left-hand side is not the actual pointer.
This means that, currently, the code when run on a CHERI architecture
will preserve the metadata from the integer, i.e. an invalid capability
that will trap on deference, and not the pointer.

This can be addressed by changing the type of the function argument in
order to more clearly convey intent, both to the compiler so it knows to
generate the right code but also to the developer so it's clear that the
argument is not in fact a pointer but just a plain integer (in this case
being either APPLY_SYMLINK_GOES_AWAY or APPLY_SYMLINK_IN_RESULT).

Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
---
 apply.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index fed195250b..7c7d56cacb 100644
--- a/apply.c
+++ b/apply.c
@@ -3814,7 +3814,7 @@ static int check_to_create(struct apply_state *state,
 
 static uintptr_t register_symlink_changes(struct apply_state *state,
 					  const char *path,
-					  uintptr_t what)
+					  size_t what)
 {
 	struct string_list_item *ent;
 
@@ -3823,7 +3823,7 @@ static uintptr_t register_symlink_changes(struct apply_state *state,
 		ent = string_list_insert(&state->symlink_changes, path);
 		ent->util = (void *)0;
 	}
-	ent->util = (void *)(what | ((uintptr_t)ent->util));
+	ent->util = (void *)((uintptr_t)what | ((uintptr_t)ent->util));
 	return (uintptr_t)ent->util;
 }
 
-- 
2.33.1


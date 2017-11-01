Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5C7E202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 20:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755218AbdKAUp3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 16:45:29 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:51582 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755173AbdKAUp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 16:45:28 -0400
Received: by mail-wr0-f193.google.com with SMTP id j15so3053889wre.8
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 13:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Vyv0L+khzpd1rgquTfv1PNmnK9OI6abrAUccVLtjvQ=;
        b=YOXVQzXif+TW+MsjHk8o5SrRN9LrfPz4ti7RWFrKdkoOelPdMA12YfaPDJ8Df/Fw5x
         dh4fSkKYWQjFaFo06eT/lKxYWXjNBj1KkHFdUVm8Xu/QsWwdciLQjyYK1uFLsJSPNn+2
         ji+4pkpHYUYeBzgp0Yr38T7jBKsddHvN6BUtCA9+CKd/I3wYjJU+QYf8JYPFF31hS5fw
         XCQPWIVjAGuqMG5Rcs/ReY+gBo5EU1bIZQwX9tC805Ll+LoQZFX457UL415TpnI47KAr
         VSQQQxt4GxMMo3RwXTJJrfE1t+88wxwLkqQPZoMFl76RdGsIXoZrleuQrPtabniDzAR5
         haCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Vyv0L+khzpd1rgquTfv1PNmnK9OI6abrAUccVLtjvQ=;
        b=XIAY4q6D69vaY1wq8nJTnCtfTMO2GPKRy36bUEC2QTZ0u3TI3YBynf5VHKYKgS0xuu
         NWbEGw8dFTIHADsu5B4vje/1DtmmpRFmp8x2XVxYVpU3BGlgIT9eQvmgqJuyQMDUv1c9
         6Tad5LqtYcORu/wFrWWfIX+8X8zVdwQuau1Cxes8TiGYBKPPrvaR9Zu7q9PXeUNJm10H
         vVtel1qLv6TwtI+hOgmIm7SvLDzvkLSFXMFFWmYf2GxCa3aIZCytqmus8+5WSQ4W08VB
         ZZqPnfCNdZOuTqHwdQ04BiXLD+LLDZyW5YVGSIy+ZQvn9f04JB5QaSxF6GtB82QbduFc
         LXnw==
X-Gm-Message-State: AMCzsaX3r6SK3+SjJ6O6yNN8LfgKhy9+acy1SGm/NjqziAWcpUbKT3dL
        pVhUn3Wq3F4zcb2Zh7BIthcx2mFgYbk=
X-Google-Smtp-Source: ABhQp+T/CKPAQ1DxkIDw7Nqsgw+soLZmEDszG9XUucjbGmfpoJAZZjKMLW1Z6SLsYAyA+sbO5qC5pg==
X-Received: by 10.223.152.16 with SMTP id v16mr798771wrb.108.1509569127167;
        Wed, 01 Nov 2017 13:45:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id x82sm1248582wmg.7.2017.11.01.13.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Nov 2017 13:45:26 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2] grep: take the read-lock when adding a submodule
Date:   Wed,  1 Nov 2017 21:45:06 +0100
Message-Id: <20171101204506.5481-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.415.gac1375d7e
In-Reply-To: <CAN0heSpxJDxmSXu=P0stq+CsKVqjsvOnjDpOoMT9GdWxeZU2Pw@mail.gmail.com>
References: <CAN0heSpxJDxmSXu=P0stq+CsKVqjsvOnjDpOoMT9GdWxeZU2Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With --recurse-submodules, we add each submodule that we encounter to
the list of alternate object databases. With threading, our changes to
the list are not protected against races. Indeed, ThreadSanitizer
reports a race when we call `add_to_alternates_memory()` around the same
time that another thread is reading in the list through
`read_sha1_file()`.

Take the grep read-lock while adding the submodule. The lock is used to
serialize uses of non-thread-safe parts of Git's API, including
`read_sha1_file()`.

Helped-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
Many thanks to Brandon for showing how this should have been done.

 builtin/grep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index 2d65f27d0..5a6cfe6b4 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -431,7 +431,9 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 	 * store is no longer global and instead is a member of the repository
 	 * object.
 	 */
+	grep_read_lock();
 	add_to_alternates_memory(submodule.objectdir);
+	grep_read_unlock();
 
 	if (oid) {
 		struct object *object;
-- 
2.15.0.415.gac1375d7e


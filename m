Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F8E12036B
	for <e@80x24.org>; Tue,  3 Oct 2017 19:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbdJCT4g (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 15:56:36 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34964 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbdJCT4d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 15:56:33 -0400
Received: by mail-wr0-f193.google.com with SMTP id y44so1552971wry.2
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 12:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8I6ACtWJ6+MUxPHL2ZuM3GABT09XyVWqIFoj5hWWk+E=;
        b=pVyXgETM01q4E6XGD7ttt05s/rTqb8/fiH/3NY9ynrHtOwnNDLCc6HVW6h0+0pIebt
         1i1upN787iC+UaNkBgr0mGAy5FRxskRPL1qHcljz4b20DD2oIiqhEn3Nfj/hTlF6pDel
         MumnB5EYW50QUQXzSANM7Sh3YVtL6zvR+9b9eEYL9BwEnuXM8L/mNfku1+/K3MaHfzmO
         +IXJRXV+HhicSz5bGKCwvlZREKye/0UwCVhHqURnErZqwRpDt7a6b+XnQmtXMzwwEmoP
         IbhwzXr8MOGqxZ4h/JI5heREw5oBPkdMEiudD57NEjkJYMVcrxlE/zUPOjo0WYlK/BY5
         FDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8I6ACtWJ6+MUxPHL2ZuM3GABT09XyVWqIFoj5hWWk+E=;
        b=V6bomiNeMSgRadIJekJkUjqB819Pakk1nUxzyjbK01Q0B6TbQ8NtB9+CnxN+2Gsb57
         Ma6c1GZ0nBgbi2LmdQ7kXJmjBMT+2PqVNlFu1BngubmefKEHC3M0vLqom5eTuRIjKfhn
         VWTJWjig1INcOD8QMdyAnoT+hDI8dBWecELOk7wtYuTN0blyyetrVCzz03TSRVS/7vc+
         P2qX26xijJU+p8LGfk8hEpyJgNRHST5UtlKs9wDv1gcz0ofAs+z1s2T3BAFiWOCYllzo
         8gOrL6nYn8FKTtq7erU6VToGtnVqmA7vfdqm4zgHIBVXtHLRZNZxpYqczL+hovDfV6VV
         GzKA==
X-Gm-Message-State: AMCzsaUpZd385giOxGwPOk7h4LULY8pNCk0mammoQnV8DBG5aPOusXO/
        tJ08Xb/4VO+E8+wdBqKLlVmViRjR
X-Google-Smtp-Source: AOwi7QAGS3avDtfe48DwcyVUItpeftEwSZ0pMgL1gqe5Z61TYZ8a6E2SxRynFNIj0I6UsqW+LPLrtQ==
X-Received: by 10.223.171.73 with SMTP id r9mr3859455wrc.118.1507060592331;
        Tue, 03 Oct 2017 12:56:32 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id d18sm7777286wra.89.2017.10.03.12.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Oct 2017 12:56:31 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.ath.cx>,
        Jeff King <peff@peff.net>
Subject: [PATCH 2/3] http-push: fix construction of hex value from path
Date:   Tue,  3 Oct 2017 20:57:12 +0100
Message-Id: <20171003195713.13395-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89
In-Reply-To: <20171003195713.13395-1-t.gummerer@gmail.com>
References: <20171003195713.13395-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The get_oid_hex_from_objpath takes care of creating a oid from a
pathname.  It does this by memcpy'ing the first two bytes of the path to
the "hex" string, then skipping the '/', and then copying the rest of the
path to the "hex" string.  Currently it fails to increase the pointer to
the hex string, so the second memcpy invocation just mashes over what
was copied in the first one, and leaves the last two bytes in the string
uninitialized.

This breaks valgrind in t5540, although the test passes without
valgrind:

==5490== Use of uninitialised value of size 8
==5490==    at 0x13C6B5: hexval (cache.h:1238)
==5490==    by 0x13C6DB: hex2chr (cache.h:1247)
==5490==    by 0x13C734: get_sha1_hex (hex.c:42)
==5490==    by 0x13C78E: get_oid_hex (hex.c:53)
==5490==    by 0x118BDA: get_oid_hex_from_objpath (http-push.c:1023)
==5490==    by 0x118C92: process_ls_object (http-push.c:1038)
==5490==    by 0x118E5B: handle_remote_ls_ctx (http-push.c:1077)
==5490==    by 0x118227: xml_end_tag (http-push.c:815)
==5490==    by 0x50C1448: ??? (in /usr/lib/libexpat.so.1.6.6)
==5490==    by 0x50C221B: ??? (in /usr/lib/libexpat.so.1.6.6)
==5490==    by 0x50BFBF2: ??? (in /usr/lib/libexpat.so.1.6.6)
==5490==    by 0x50C0B24: ??? (in /usr/lib/libexpat.so.1.6.6)
==5490==  Uninitialised value was created by a stack allocation
==5490==    at 0x118B63: get_oid_hex_from_objpath (http-push.c:1012)
==5490==

Fix this by correctly incrementing the pointer to the "hex" variable, so
the first two bytes are left untouched by the memcpy call, and the last
two bytes are correctly initialized.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 http-push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http-push.c b/http-push.c
index e4c9b065ce..e9a01ec4da 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1018,7 +1018,7 @@ static int get_oid_hex_from_objpath(const char *path, struct object_id *oid)
 	memcpy(hex, path, 2);
 	path += 2;
 	path++; /* skip '/' */
-	memcpy(hex, path, GIT_SHA1_HEXSZ - 2);
+	memcpy(hex + 2, path, GIT_SHA1_HEXSZ - 2);
 
 	return get_oid_hex(hex, oid);
 }
-- 
2.14.1.480.gb18f417b89


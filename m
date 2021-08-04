Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA41AC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 06:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C15608FC
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 06:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbhHDGpU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 02:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbhHDGpT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 02:45:19 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B835C0613D5
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 23:45:06 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id t66so1918567qkb.0
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 23:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h3XbD4yimsVw6k+THUA5rerNVJZcN3WBQSzP/Z5dTCk=;
        b=ednHzfas8vwk8JHrjzU+wJdxd6angpbyRJJsq1/idfhGlBqms9uGOw5Q+Q8Wv4XT9i
         OmFxhFV9FvmJvQB73EVyhSPxAG6mTeVpLCHDe1tTUhz7byAOLDCQ6tpTC3XA+woAbbvp
         QBmnHnLLq0I7pgAdawaXoqV/vx/k3XXfAgNTcVcbgg9N1OhHWcKGfdekzi0GwlfWYELe
         O34X6nOF1Zn0dXjhwMfdjBRYJVhlWwyKzz++jp2RXitIBFRZRhLq8Fsqa33iRQ8EQUvk
         6VOD3bwB+s+y+E/6NzZPL//mOwSXWd478M/C4XYjpkcoXVjc5beeYt7jLgJZPlj1nico
         KyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h3XbD4yimsVw6k+THUA5rerNVJZcN3WBQSzP/Z5dTCk=;
        b=KdQTy3n7io5H+c+dPYtl14nGZ4L2gOPu9iiCfdEn0UahGtKtl7qm+G7zALrFs7oQ6U
         UsZcrBq45BwsmHUbML/nnNsQq0lwGtvaVqNVMuaC4tsK5ezeVoQzsZoBWTneo8IFrEct
         kv+r+CCReWtSOSoRhyiLdVbzGSHpVhcKj2za1r6LQVcUAyOa5JlT0VY3Dfi+3gIm64o2
         /50a0vU8ZZKS0XcFIz9QZy0hOg0Qypzjwu9bBBugbMATslJMreuEbIVzO23mFV0TltuJ
         auNB/14cG0g0tiN5+ahO3sQvBJ/ZK2YtXo0TczXSYsveLJPVlTPjWy3x84oUKRsgSOWx
         H+cQ==
X-Gm-Message-State: AOAM530Ex5RlLjoYh+ASEAT66IyhRJYDIqm9JbuAQi6AsGzPI3tLVgGo
        gSI3V8ujPNdNQXcutFghSdwhBifmdHw=
X-Google-Smtp-Source: ABdhPJzXMkVxvI5YzQYCHJfRZ0RSlTPhN1KoXxGj5d905gp5WOi3T+rQDFXI1Ksp0Sr31TYpcZc1iA==
X-Received: by 2002:a05:620a:12d8:: with SMTP id e24mr23773967qkl.354.1628059505630;
        Tue, 03 Aug 2021 23:45:05 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id m6sm760318qki.47.2021.08.03.23.45.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Aug 2021 23:45:05 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 4/3] fixup! reftable: add dump utility
Date:   Tue,  3 Aug 2021 23:44:34 -0700
Message-Id: <20210804064434.42236-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.443.g98cc19b6c0
In-Reply-To: <20210802190054.58282-1-carenas@gmail.com>
References: <20210802190054.58282-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

avoid _XOPEN_SOURCE in alpine by making sure git-compat-util.h is included
first (through hash.h) as recommended and therefore avoid:

  In file included from ./hash.h:4,
                   from reftable/dump.c:19:
  ./git-compat-util.h:147: warning: "_XOPEN_SOURCE" redefined
    147 | #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
        |
  In file included from /usr/include/unistd.h:8,
                   from reftable/reftable-writer.h:15,
                   from reftable/dump.c:14:
  /usr/include/features.h:16: note: this is the location of the previous definition
     16 | #define _XOPEN_SOURCE 700
        |

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
This allows for the alpine CI job to build, but will still fail with the
reported segfault in the subcommand for `git reflog`.

It is important to note that it only happens in "seen" though, as the same
code merged to master pass that test (even if it might fail somewhere else)

 reftable/dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/dump.c b/reftable/dump.c
index 668cfa8996..eb7b2b4161 100644
--- a/reftable/dump.c
+++ b/reftable/dump.c
@@ -6,6 +6,7 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
 
+#include "hash.h"
 #include "reftable-blocksource.h"
 #include "reftable-error.h"
 #include "reftable-merged.h"
@@ -16,7 +17,6 @@ license that can be found in the LICENSE file or at
 #include "reftable-reader.h"
 #include "reftable-stack.h"
 #include "reftable-generic.h"
-#include "hash.h"
 
 #include <stddef.h>
 #include <stdio.h>
-- 
2.33.0.rc0.443.g98cc19b6c0


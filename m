Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC90C433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 09:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446046AbiDVJ4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 05:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446258AbiDVJ4X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 05:56:23 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E6A53E1D
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:53:27 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v12so3470690wrv.10
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1EzsCpAjWZwhLkrV00aw0GMWluLOtwJO4WHCO47vYDw=;
        b=PmXd3TKqE9UyXaB+1G/fPen08N2m5dYt14geUOzWAYdGzIFqYOr0EkukMXvuj3326w
         3NgtU6QWBcon4dhpj0S/1Bp0RBlLeiPKjQAO8+/86vsSui1F0KEH4QJ67BEons6wwd8J
         A9x5DyrUsqvdFSlc5KwMQClWV3A8qXBBo1c0oOfzgC+1sdgAZ38qnv8j1hgSc+pr+Q2m
         9KiZQLBemlVxVMp7S3pIom5pNbq3/iagiwHAmQCpC7nfa2w//xULDjDqxpClpp49SCsU
         omgWduHgxXZjCD8n8ndUcdzYkhuK2l2bYzkmF30sCMK/tUAEndxJoo3eR9Dnf6v0K8dR
         SYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1EzsCpAjWZwhLkrV00aw0GMWluLOtwJO4WHCO47vYDw=;
        b=jFJeDIPwgDV9t6NA254eg9bORZkJ7ACjlj5h8WKUGUic/l8pRtYuKbyodFBDxuwEfH
         Z7KaRBZx8LoX2bKNahJvkgfGfbEpHWsPx/BzevOpAAB4vgzz+nUfW/Ll7vZMqsAr/7n6
         8fTJgHAFZSE6cW6aMOfMI1QtgIXQcLV068F/KBP1gZyIhGQMAz1TUgyB4Vnm4HJ9Mj/Z
         UVKPDzZwon504dJ7ZkCjkxfDEUV3TtDmD+hZ7iFat8mjkquJrMjJO2t4j+rRPZdbgoi/
         5Tt/G+iEtWZG8GJFtNjSEvdz+SQmX2HNEok02xXY5YLGtAZXmEg+EVSi/q/E10SumS/Y
         xjHQ==
X-Gm-Message-State: AOAM531zoznhdZa7ataiyGujw94i1BZXSzE+qMJxC27BLZSn5f/Q2yb0
        413v33+dNAOiAPzxJYL2sI453WiUQGr06Q==
X-Google-Smtp-Source: ABdhPJxAMcKgPm3wOYeFX+ZUcgfUgW6QIpLCy76XSLmnZKEL3pQlluMonUlpsxtNRyfb4SRGqbTpcg==
X-Received: by 2002:adf:e4c1:0:b0:20a:aa0f:ea77 with SMTP id v1-20020adfe4c1000000b0020aaa0fea77mr3033642wrm.447.1650621205270;
        Fri, 22 Apr 2022 02:53:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i6-20020adfa506000000b0020ac34ec647sm1365561wrb.110.2022.04.22.02.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 02:53:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Carlo Arenas <carenas@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] Makefile: rephrase the discussion of *_SHA1 knobs
Date:   Fri, 22 Apr 2022 11:53:14 +0200
Message-Id: <patch-3.5-d559e5212bc-20220422T094624Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g56a83971f3f
In-Reply-To: <cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com>
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 12bb9edd70a..d317c6aba06 100644
--- a/Makefile
+++ b/Makefile
@@ -506,14 +506,14 @@ include shared.mak
 # To use them you must define NO_DC_SHA1 and one of the *_SHA1
 # variables below:
 #
-# Define BLK_SHA1 environment variable to make use of the bundled
-# optimized C SHA1 routine.
+# Define BLK_SHA1 to make use of optimized C SHA-1 routines bundled
+# with git (in the block-sha1/ directory).
 #
-# Define OPENSSL_SHA1 environment variable when running make to link
-# with the SHA1 routine from openssl library.
+# Define OPENSSL_SHA1 to link to the the SHA-1 routines from
+# the OpenSSL library.
 #
-# Define PPC_SHA1 environment variable when running make to make use of
-# a bundled SHA1 routine optimized for PowerPC.
+# Define PPC_SHA1 to make use of optimized (in assembly)
+# PowerPC SHA-1 routines.
 #
 # Define APPLE_SHA1 to use Apple's CommonCrypto SHA-1 routines on
 # Darwin/Mac OS X.
-- 
2.36.0.879.g56a83971f3f


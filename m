Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65838C3A5A9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42C93206B9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVGcc38P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgEEBjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 21:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726516AbgEEBjq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 21:39:46 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABD6C061A0F
        for <git@vger.kernel.org>; Mon,  4 May 2020 18:39:45 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l12so287176pgr.10
        for <git@vger.kernel.org>; Mon, 04 May 2020 18:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F50CeH/2zQj0c7Y0mkrkl8Tq74PEjdpt5RTCDCHlRqk=;
        b=XVGcc38PVg0pBVk5+Rq9rgK5O0Ay6dW35biPa9pX3x5Xx9kyV+w4ul4D41Obbkmzwd
         is4XPWaA0d8lb47hrN28fZHMbaVNPgcM+eefQOkWtRaS/abiBn+gEpcse+n9uQ0pVNS9
         kwv2m9gCN58wItNlUWN5T5QDschkFMFSVdMvVfiklN+nb5NAxwSx1PuUxQ7m6mOa+HLM
         BoAuKDpztBsCqskRDeqkff2pqdza1+V/tAFFmxjZ1yTGWyru/VjFVlCN6JqLumKDvM96
         HOdwhibcS1A8GWTLv3CJpoQiW4F0Jb0XGHYv1lBV13S5bAXPEd+/OEM7vipgVmF1xRq1
         RSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F50CeH/2zQj0c7Y0mkrkl8Tq74PEjdpt5RTCDCHlRqk=;
        b=dN9g3lqB29qNSbfSxdbE5jpm3xkNhJcWyDjYccRnaykTZAqymbWdg5TsNDrSIQj+BR
         PetG9iR5WGpA5gE/tLu43gxAQ2eXpOg5cOzHZZee8v3+9lJAZcLiIDp4fXleQZm0BUfk
         Vjz473ht+hUblDhNgRFOW8PkzCBThup3u83eXaWi3gpuQx3hIMkOmz3v+UV85J+/E72k
         8WD33LWKIZVfaSFe+YB5FZGwJ3rTfaqxdWJY2Zr7sbtgEUEYYcy2VEH4ToPYETyPtQTv
         07TZ1vTojFDM3f34dxUne3tpnswGB/XEB4NRNnCMOQUUv0f0Aier4y+YkMyE5BureSBP
         Ht3w==
X-Gm-Message-State: AGi0PuZ1afqvOgAbmBqQvjpqwzS8QvLXJJdUtDLUceym3XAYY/mDgzDq
        IeqEKB+TvrfEEuGl/j0zLd0q6Zje
X-Google-Smtp-Source: APiQypIskhh55ZSiMiljhKDYy56A10Il84zNAMBjYXnfTfyHtEzlUrwcJcOcwbP51gXViKkefWmpPQ==
X-Received: by 2002:a63:4a54:: with SMTP id j20mr953039pgl.430.1588642784639;
        Mon, 04 May 2020 18:39:44 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id e196sm352027pfh.43.2020.05.04.18.39.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 18:39:44 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 3/4] credential: update gitcredentials documentation
Date:   Mon,  4 May 2020 18:39:07 -0700
Message-Id: <20200505013908.4596-4-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.686.gfaf46a9ccd
In-Reply-To: <20200505013908.4596-1-carenas@gmail.com>
References: <20200503063423.83152-1-carenas@gmail.com>
 <20200505013908.4596-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clarify the expected effect of all attributes and how the helpers
are expected to handle them and the context where they operate.

While at it, space the descriptions for clarity, and add a paragraph
mentioning the early termination in the list processing of helpers,
to complement the one about the special "quit" attribute.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Documentation/gitcredentials.txt | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 1814d2d23c..72faadae9e 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -262,16 +262,26 @@ For a `get` operation, the helper should produce a list of attributes on
 stdout in the same format (see linkgit:git-credential[1] for common
 attributes). A helper is free to produce a subset, or even no values at
 all if it has nothing useful to provide. Any provided attributes will
-overwrite those already known about by Git.  If a helper outputs a
-`quit` attribute with a value of `true` or `1`, no further helpers will
-be consulted, nor will the user be prompted (if no credential has been
-provided, the operation will then fail).
+overwrite those already known about by Git's credential subsystem.
+
+While it is possible to override all attributes, well behaving helpers
+should refrain to do so for any attributes other than username and
+password.
+
+If a helper outputs a `quit` attribute with a value of `true` or `1`,
+no further helpers will be consulted, nor will the user be prompted
+(if no credential has been provided, the operation will then fail).
+
+Similarly, no more helpers will be consulted once both username and
+password had been provided.
 
 For a `store` or `erase` operation, the helper's output is ignored.
-If it fails to perform the requested operation, it may complain to
-stderr to inform the user. If it does not support the requested
-operation (e.g., a read-only store), it should silently ignore the
-request.
+
+If a helper fails to perform the requested operation or needs to notify
+the user of a potential issue, it may write to stderr.
+
+If it does not support the requested operation (e.g., a read-only store),
+it should silently ignore the request.
 
 If a helper receives any other operation, it should silently ignore the
 request. This leaves room for future operations to be added (older
-- 
2.26.2.686.gfaf46a9ccd


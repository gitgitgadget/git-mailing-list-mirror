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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21758C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 08:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0571F6100A
	for <git@archiver.kernel.org>; Tue, 18 May 2021 08:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347596AbhERIvy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 04:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241701AbhERIvy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 04:51:54 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041E3C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 01:50:36 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f22so5581760pgb.9
        for <git@vger.kernel.org>; Tue, 18 May 2021 01:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HLN8x2sYEq58e79H18CFbq63Z3MvuYsEEfr62QtvASU=;
        b=s+UmBwHmF12uyyyNJbfq1KpQtpanTIFAdT7CfOmM/xA90mQNPuFGeQFgNCLrEAjLb1
         Prp/ifAXz/f1gFjcWD6I2rPyHNyPUeDmmCFEHuKCoK1n1dhv6qpXMwGl/rMMzGsN2s6a
         194oaFZUxF2mzY6HL+preOo9YiBUkwV1HcNXDQYEICj4sgjRUH0xUEYot4ltBlEUM2Hd
         MDAhCUbsMUOFWMO0YFPVd+IOwYADS4o2TMeNuxEt+jUVAY+jw82lrPcGHmos3wytAGvM
         TWCVpHdQvjXVM5QW9L+9cvfvF+kYtPgmMGmN9FxegHROE/6If4IvCS9kId0T05atyoJc
         lbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HLN8x2sYEq58e79H18CFbq63Z3MvuYsEEfr62QtvASU=;
        b=JWv3BsRm5VCla/WprXau4F0vgBoqnUHV2XKBDMqECR9sGd0B80gCimWceDNCkdTN7O
         rnmP7mONlILh0krrLy2JPvbxtPUbBDfuya8TgOK0f4BmLWgTT88RshWjtYiPQaBLawOE
         d2x1weFLz6PWuFWyzc9sy/xm1vP6tKgcjdAIZfxBLlHT2NDmYH7r6gIkeiOI57Ub8jH+
         P4paRGeioGQzukvaxKWzVQcI6s0AghfxmJs8abh0TZHY7jVfoUFnE6j8I92Gh2Sy1XC0
         ew0DinAUHBVh4cF6OCbIxr4DbWjFbPn0ksWMb7fp3do4uP7h8nIGPf1aONsoM+Y8a/KU
         5fFw==
X-Gm-Message-State: AOAM533tBbKsn3XsoavRM0BieWeiqDg92xlKpxdf8MQYk9z1NPlNvTiX
        FwvhOSSRHo/ewLaEaPQ+5fjNUA8L9jg9Ldkuo/w=
X-Google-Smtp-Source: ABdhPJyx8kryfySbo0c7jwN/44bBvhGIDcB+EdKOI8FH7wmzdlphw080u87+1QWctwZmSKQ/tnu8QA==
X-Received: by 2002:a63:8449:: with SMTP id k70mr4071038pgd.392.1621327835371;
        Tue, 18 May 2021 01:50:35 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.147])
        by smtp.gmail.com with ESMTPSA id t1sm12231076pjo.33.2021.05.18.01.50.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 May 2021 01:50:35 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, avarab@gmail.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v2 2/3] packfile-uris.txt: excluding commit object
Date:   Tue, 18 May 2021 16:49:52 +0800
Message-Id: <4abab98a76966a34a166fc758b2e9b7cca38c156.1621327467.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.442.g7e39198978.dirty
In-Reply-To: <cover.1621327467.git.dyroneteng@gmail.com>
References: <cover.1621327467.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Modified the content related to the configuration of packfile-uris, that
is, the modification of the configuration format and the support for
excluding commit objects, and cut some descriptions about future work.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/technical/packfile-uri.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/technical/packfile-uri.txt b/Documentation/technical/packfile-uri.txt
index f7eabc6c76..6ed850930f 100644
--- a/Documentation/technical/packfile-uri.txt
+++ b/Documentation/technical/packfile-uri.txt
@@ -35,13 +35,16 @@ include some sort of non-trivial implementation in the Minimum Viable Product,
 at least so that we can test the client.
 
 This is the implementation: a feature, marked experimental, that allows the
-server to be configured by one or more `uploadpack.blobPackfileUri=<sha1>
-<uri>` entries. Whenever the list of objects to be sent is assembled, all such
-blobs are excluded, replaced with URIs. As noted in "Future work" below, the
-server can evolve in the future to support excluding other objects (or other
-implementations of servers could be made that support excluding other objects)
-without needing a protocol change, so clients should not expect that packfiles
-downloaded in this way only contain single blobs.
+server to be configured by one or more entries with the format:
+
+    uploadpack.excludeobject=<object-hash> <recursively> <pack-hash> <uri>
+
+Value <object-hash> is the key of entry, and the object type can be a blob
+or commit. Value <recursively> works for commit object, if <recursively>
+is configured as '1', then the commit and all the referenced objects by
+the commit will be recursively excluded. Otherwise, only the commit itself
+will be excluded. Whenever the list of objects to be sent is assembled, all
+such objects are excluded, replaced with URIs.
 
 Client design
 -------------
@@ -65,9 +68,6 @@ The protocol design allows some evolution of the server and client without any
 need for protocol changes, so only a small-scoped design is included here to
 form the MVP. For example, the following can be done:
 
- * On the server, more sophisticated means of excluding objects (e.g. by
-   specifying a commit to represent that commit and all objects that it
-   references).
  * On the client, resumption of clone. If a clone is interrupted, information
    could be recorded in the repository's config and a "clone-resume" command
    can resume the clone in progress. (Resumption of subsequent fetches is more
-- 
2.31.1.442.g7e39198978.dirty


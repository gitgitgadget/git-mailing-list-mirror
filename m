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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AE3C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 07:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E03E60551
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 07:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbhHKHq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 03:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbhHKHq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 03:46:56 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D09C0617A1
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 00:46:32 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id e15so1552675plh.8
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 00:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tyjQE5ZkZOoT5nxbT2V1cBXqI/rygkowbDWXbdnaXaY=;
        b=Q52kyuZ8tNlYcb565Kpy2bitxlDNflYh7vZOpFW6yZDWJnYeUzEC8JRLsl7s+38qWi
         2Hjxd6qms0vvjn2GZ+ZlVQpP3J/bTymhlECsUNYhw944yxz53Ycf5xWqIEsGy1Zf7qS3
         mpXCwaXGEYd6amrZPL/ZBWSK8L739Nc3dR3gpyqpfubArLQRrZdaR3jSbkVLo1KSIvUA
         TUNZ1iFdiUhya6wc8V7TNZ4++47xu15P7XosSc5tmGYdyOVwhWwiOKYni1uNkZARW6t7
         kSRY0px2segkYctIiFl2hXnBKL/mtF9F6Go1wS6CrHI52tjWAhDzhgfzA1hgZwCOKAxo
         zxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tyjQE5ZkZOoT5nxbT2V1cBXqI/rygkowbDWXbdnaXaY=;
        b=KBhr5DttrJYU7486N/vWoW8g25rLNgkDxvop+njsAFBzZaSj3Y/YtUgxzhH+/lBKVa
         ZmyP6/PHHCZxmMFYLQAM4xXKDBjxEOE3FKl6oi0GP7u+X2yWK6Ey8kD3H8olKw3fQPRf
         6c/WRucy02VlebrVMjG43y5Qa18I93fv5H+jn5tp52q/dXcwI0/8y70o9DNS5b4mlzAI
         6zRRKcS8/cyKqfWkpKhzQnliGjBIlBEMu9vSpEwitmhTN7XSKBDAQIPTSdTttQvKzNlY
         c209Dcb09EvAlte730KkA0qlrS+C/FSYVlWTOPPAW8hXQBHMPHIphxwK/elHwl86WRTh
         urjQ==
X-Gm-Message-State: AOAM531ELRv/PYc0GR+mAiTcaxXYIWENVdkUROVdQdr2wck+4gegvNRn
        EN4LpFRhFbmWG9GWCIKBOv8=
X-Google-Smtp-Source: ABdhPJxUrqLtgXDmqH2wbgGE4e27moTRTa+8uJy0S6oILyMLNt2IzbKCOKPkxQqgQYkgIJ76vlQsQg==
X-Received: by 2002:a63:1352:: with SMTP id 18mr161244pgt.348.1628667992221;
        Wed, 11 Aug 2021 00:46:32 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id u13sm26179672pfi.51.2021.08.11.00.46.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Aug 2021 00:46:31 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: [PATCH v4 5/7] packfile-uri.txt: support for excluding commits and trees
Date:   Wed, 11 Aug 2021 15:45:52 +0800
Message-Id: <8e5bf4010cb0d7e8b4f6c7285fe1f5365af955e8.1628666093.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.449.gb2aa5456a8.dirty
In-Reply-To: <cover.1628666093.git.dyroneteng@gmail.com>
References: <cover.1628666093.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/technical/packfile-uri.txt | 32 ++++++++++++++++--------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/Documentation/technical/packfile-uri.txt b/Documentation/technical/packfile-uri.txt
index f7eabc6c76..c3e4873956 100644
--- a/Documentation/technical/packfile-uri.txt
+++ b/Documentation/technical/packfile-uri.txt
@@ -35,13 +35,26 @@ include some sort of non-trivial implementation in the Minimum Viable Product,
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
+    uploadpack.excludeobject=<object-hash> <pack-hash> <uri>
+
+Value <object-hash> is the key of entry, and the object type can be a blob,
+tree, or commit. The exclusion of tree and commit is recursive by default,
+which means that when a tree or commit object is excluded, the object itself
+and all reachable objects of the object will be excluded recursively. Whenever
+the list of objects to be sent is assembled, all such objects are excluded,
+replaced with URIs.
+
+Configuration compatibility
+-------------
+
+The old configuration of packfile-uri:
+
+	`uploadpack.blobPackfileUri=<object-hash> <pack-hash> <uri>`
+
+For the old configuration is compatible with the new one, but it only
+supports the exclusion of blob objects.
 
 Client design
 -------------
@@ -65,9 +78,6 @@ The protocol design allows some evolution of the server and client without any
 need for protocol changes, so only a small-scoped design is included here to
 form the MVP. For example, the following can be done:
 
- * On the server, more sophisticated means of excluding objects (e.g. by
-   specifying a commit to represent that commit and all objects that it
-   references).
  * On the client, resumption of clone. If a clone is interrupted, information
    could be recorded in the repository's config and a "clone-resume" command
    can resume the clone in progress. (Resumption of subsequent fetches is more
@@ -78,4 +88,4 @@ There are some possible features that will require a change in protocol:
 
  * Additional HTTP headers (e.g. authentication)
  * Byte range support
- * Different file formats referenced by URIs (e.g. raw object)
+ * Different file formats referenced by URIs (e.g. raw object)
\ No newline at end of file
-- 
2.31.1.449.gb2aa5456a8.dirty


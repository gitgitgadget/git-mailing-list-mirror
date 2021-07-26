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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3F9C432BE
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 09:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6438F60F47
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 09:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhGZJGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 05:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbhGZJGf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 05:06:35 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93291C0613C1
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 02:47:03 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id i1so10876024plr.9
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 02:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/UgFloIrt1eMb29e6ki2KR9Z5dyw8aJUcZ+fvNU1uM=;
        b=hjTor6yRfEEArzVqF5Fcw12azTnCb1ZnnGXAsGCUcRLC1BsZNlzZlqEQlvSO79W4Nk
         fQJf1el00J7MF+Ar7wTKtTdj1pi1vPOWkP1O0I3XGUHzjZIJgCeMxcz5QwhbjxrNsVbp
         PpZP/KJEQIsBOM7IJ3E++p1PkJb/phZbTYPkpj8k0rSaL+EkSj4l+DWE9oDx3lhYKcxf
         WdzU9X0PXIirxESVCp+UzGH6Sq3FTe6oKuO18vdBoVM2G0kvf4DGwvRT2whD4xd7Xciq
         NczNpR4sw6FbobEBKigWBN4ZXCTxRL1+dE+zmzCK52pA9PanoiFbDwfgnG3VaBd6jum6
         oUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/UgFloIrt1eMb29e6ki2KR9Z5dyw8aJUcZ+fvNU1uM=;
        b=psTW5GfU8hJ6TRxAB2jqPUWyavPXAICHJgK2hdJNFQFvzbbc7AfN6zAM9dJ+98o4gN
         U1t8njE3z+UPiOS2HkBvFaTHAX23KeQ1XS4djK0543dPo7G7ddPIG3b6Ln3nf2cYJHPR
         o+3lDWb+mOJD9sMvp4crfesERL2zmoLv4Cqe5HAifWR8RZ8HRWESWFJrVESxBuHZ9gss
         AMvsEg41/ITGdlLWDTW3PisfNJXScbW4+YZPj7+sQoeXDmvmb3fHYafXddjOEyR35ngt
         Xg+UlQuGpuLoz4d1MKeltbxa1mOO7bvPpCazLVYUU2dvZdOWXZ1rCFfHogjkn9wvZp4U
         gv2Q==
X-Gm-Message-State: AOAM5324I8zhofcldMNpfTb3528+r535kNaWdpyBntfMxmT98H8RXNyW
        1WIUslxFQ3FmisdS1p+2AKz6i1ptT+fVXVV5eFs=
X-Google-Smtp-Source: ABdhPJxsbZQTxDQy46lxLirYvM0KJkuxaVja15xe+XxbNIZyfVUmhEyDjBZV++KIRwaACKvBV3IzCQ==
X-Received: by 2002:a63:4b0a:: with SMTP id y10mr14552476pga.437.1627292823047;
        Mon, 26 Jul 2021 02:47:03 -0700 (PDT)
Received: from localhost.localdomain ([115.227.76.17])
        by smtp.gmail.com with ESMTPSA id g13sm42522319pfo.112.2021.07.26.02.47.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jul 2021 02:47:02 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, avarab@gmail.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v3 3/3] packfile-uri.txt: support for excluding commit objects
Date:   Mon, 26 Jul 2021 17:46:14 +0800
Message-Id: <01ab2cbb34e6eb5f9b421d34ac368ea4e266fcd1.1627292425.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.443.g55c63af4c9.dirty
In-Reply-To: <cover.1627292424.git.dyroneteng@gmail.com>
References: <cover.1627292424.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/technical/packfile-uri.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/technical/packfile-uri.txt b/Documentation/technical/packfile-uri.txt
index f7eabc6c76..2532db0e99 100644
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
+or commit. Whenever the list of objects to be sent is assembled, all such
+objects are excluded, replaced with URIs. At the same time, for the old
+configuration `uploadpack.blobPackfileUri=<sha1> <pack-hash> <uri>` is
+still compatible for now, but this configuration only supports the
+exclusion of blob objects.
 
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
2.31.1.443.g55c63af4c9.dirty


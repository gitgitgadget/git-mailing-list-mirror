Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD63AC433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA4D86137C
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbhJSLmZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 07:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbhJSLmL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 07:42:11 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0F1C061745
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:42 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ez7-20020a17090ae14700b001a132a1679bso1839808pjb.0
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8EofLOsIBlOIuEE/Mkpq365W7kqYJ2FXkqaC3BwMhBs=;
        b=Unixh4M9FSaTudRonCtakcvaNepAby2Wf+i1DFR0Dmb4w5HFdWZSsTCmfqTsaccRri
         QXQKgnAXXimVlargxQXM5zmMqJ1l6ODNCDC5ZOSFHt5867ECg5bni+X1tPTd1XDXCovy
         ZAbY9Hm+oOFlt0eQ0ytDurlffzrBgpiMKyWMZ3DDaPNXQqsgbgQSrAU9yUhYSe7xg3XT
         zWM7sBemlsYQ14R5xGTsrCsz+Oc1iEgwf0XK+pllt4XVVZaWKehyp6tXoLCXhsAqc5g7
         U/Et4GYgBzsBwa0RuEDEHU5D3x7ozHLW3TtzTYCgSIRd0jE8RAyZhAzxmpI+24YDKC24
         Qfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8EofLOsIBlOIuEE/Mkpq365W7kqYJ2FXkqaC3BwMhBs=;
        b=7N4VQmmcjW2EiqdTnBUsC5zGnpG9RKdH4Dy3xRGYN+DRgHUF85whWe+dZV3mCzihNJ
         Fgz75YtJAH5FiYfw/2amMyCnsHd0XkPks2XIJ+nMWkOVc9jQj8mOZSNU7BTWcginSpgY
         Rvt+GtJr+yCH3H3mfLnAd4ip9ClGrHMHkwA3I1NmtYWSLVJBD5vy5xWks9iR5ws+odTh
         eTyFJoWW0NKUBhZM2g/3kFklBtMqswJUSzCh1X10qZEhJDWhQobWlq9GdIz8mZZd95N8
         ljQXYF2iTvqXjuZ/galWqALs6GezNcqblSaz0ArMhZIt8GT7GW7hGea8O1GyswkqRAD1
         cLQg==
X-Gm-Message-State: AOAM531mpgBq96dsoWtwwAv98dBXuJxJhcsaN2WbZUevNAIIpsle3w+f
        4yTlBuArq1l6YvNNuSRvWghj0V7Bg0I=
X-Google-Smtp-Source: ABdhPJz9j8a3GpIYzdvZA7TjjCvjALAgKkON3E2a7h708lX9+zDqL2UxqnR9DsZ4Nb0eQzJrGOJB9A==
X-Received: by 2002:a17:90b:3ec3:: with SMTP id rm3mr6019038pjb.186.1634643582085;
        Tue, 19 Oct 2021 04:39:42 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.96])
        by smtp.gmail.com with ESMTPSA id l207sm16430861pfd.199.2021.10.19.04.39.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Oct 2021 04:39:41 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, jonathantanmy@google.com,
        bagasdotme@gmail.com, adlternative@gmail.com, stolee@gmail.com,
        Teng Long <tenglong@alibaba-inc.com>
Subject: [PATCH v6 12/12] packfile-uri.txt: support multiple object types
Date:   Tue, 19 Oct 2021 19:38:36 +0800
Message-Id: <79fc2c23cf053cb525d818b6b47e24c49b57f672.1634634814.git.tenglong@alibaba-inc.com>
X-Mailer: git-send-email 2.31.1.453.g945ddc3a74.dirty
In-Reply-To: <cover.1634634814.git.tenglong@alibaba-inc.com>
References: <cover.1634634814.git.tenglong@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Teng Long <tenglong@alibaba-inc.com>
---
 Documentation/technical/packfile-uri.txt | 74 ++++++++++++++++++++----
 1 file changed, 63 insertions(+), 11 deletions(-)

diff --git a/Documentation/technical/packfile-uri.txt b/Documentation/technical/packfile-uri.txt
index f7eabc6c76..0e6d7c8dda 100644
--- a/Documentation/technical/packfile-uri.txt
+++ b/Documentation/technical/packfile-uri.txt
@@ -34,14 +34,69 @@ having it advertise `packfile-uris`, tolerating the client sending
 include some sort of non-trivial implementation in the Minimum Viable Product,
 at least so that we can test the client.
 
-This is the implementation: a feature, marked experimental, that allows the
-server to be configured by one or more `uploadpack.blobPackfileUri=<sha1>
-<uri>` entries. Whenever the list of objects to be sent is assembled, all such
-blobs are excluded, replaced with URIs. As noted in "Future work" below, the
-server can evolve in the future to support excluding other objects (or other
-implementations of servers could be made that support excluding other objects)
-without needing a protocol change, so clients should not expect that packfiles
-downloaded in this way only contain single blobs.
+This is the implementation: a feature, marked experimental, that allows
+the server to be configured by one or more entries with the format:
+
+    uploadpack.excludeobject=<object-hash> <level> <pack-hash> <uri>
+
+Value `<object-hash>` is the key of entry, and the object type can be
+blob, tree, commit, or tag. Value of entry has three parts,
+`<pack-hash>` is used to identify the packfile which contains the given
+`<object-hash>` object, and `<uri>` is the URI to download the packfile by
+client. For example, When a blob is configured with `uploadpack.excludeobject`
+that means whenever the blob to be send is assembled, the object will
+be excluded.
+
+In addition to excluding a single object like blob, sometimes it's
+hoped to exclude not only the object itself, but also all the related
+objects with it, like all the objects a tree contains or the ancestors
+that a commit can reach. In these cases, the `<level>` is designed to
+distinguish the scope of exclusion, it supports three levels:
+
+- Level 0: Excluding a single object itself, without any objects that
+  have a relationship with it. 
+
+- Level 1: Excluding object itself, and objects it contains.
+
+- Level 2: Excluding object itself, the objects it contains, and the
+  ancestors it can reach.
+
+If `<level>` is configured as 0, only the object itself will be
+excluded, no matter what the object type is. It is a common scenario
+for large size blobs, but it does much not sense for other object types
+(e.g. download a singe commit without downloading the blobs and tree
+in it).
+
+If `<level>` is configured as 1, not only the single object but also all
+the objects in it will be excluded. This applies to scenarios where
+it's wanted to exclude a specified non-blob object that includes some
+lage size objects.
+
+- If <object-hash> is a blob, the result is the same as level 0, because blob
+contains nothing just itself.
+
+- If <object-hash> is a tree, the tree itself, and all blobs and trees
+  in it will be excluded.
+
+- If <object-hash> is a commit, the commit itself, the referenced
+  root-tree, and all blobs and trees in the root-tree will be excluded.
+
+- If <object-hash> is a tag, the tag itself, the dereferenced commit
+  and all trees and blobs contained in its root-tree will be excluded.
+
+If `<level>` is configured as 2, not only the objects in the scope of
+level 1 , but also the reachable ancestors will be excluded if
+`<object-hash>` is commit or tag.
+
+Configuration compatibility
+---------------------------
+
+The old configuration of packfile-uri:
+
+    uploadpack.blobPackfileUri=<object-hash> <pack-hash> <uri>
+
+For the old configuration is compatible with the new one, but it only
+supports the exclusion of blob objects.
 
 Client design
 -------------
@@ -65,9 +120,6 @@ The protocol design allows some evolution of the server and client without any
 need for protocol changes, so only a small-scoped design is included here to
 form the MVP. For example, the following can be done:
 
- * On the server, more sophisticated means of excluding objects (e.g. by
-   specifying a commit to represent that commit and all objects that it
-   references).
  * On the client, resumption of clone. If a clone is interrupted, information
    could be recorded in the repository's config and a "clone-resume" command
    can resume the clone in progress. (Resumption of subsequent fetches is more
-- 
2.31.1.453.g945ddc3a74.dirty


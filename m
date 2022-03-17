Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AFEC433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 17:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbiCQR3C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 13:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236875AbiCQR2z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 13:28:55 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489D7114FC8
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 10:27:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r10so8350463wrp.3
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 10:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KnDikl4f3xmoxcwNshih5s01PDwF1eY9QjEysJCgAn0=;
        b=NZ5qvJYq8jYw42XMX3ZFsL9HoGkeOIwyvYQyLnaDPg4QIcf6MNGLwdIfEVnhv3aW5L
         cSZY14BCQxxb4YTUopJ60v6/p1FaMFz2Wtq24J1Xl/C/uKvz96EiwP5K5q6W+oKkXtF0
         Y/EB9i/I49WMhAFGgU1LuczjKsSFHQSZNlAjzckAuOU1yGL8BwjNOvCRTqGKo1rUcbmT
         NBiVrMduZQC/64RXjav8/SiurRZJfzJFOGpeoXf2eD+C5ut/sZZySmwEFFNUX8H72dxQ
         ZS5k4yMSYWY2m7ecrsstlawYS9NVK8HEklEpbI3AE6cK1ooh/W92G9PdtCmRlkvGDsAt
         rpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KnDikl4f3xmoxcwNshih5s01PDwF1eY9QjEysJCgAn0=;
        b=ZVLPN0r9LaLeFgPYpA7lfu84LuCwfAOQa1u1ZLk8I4H7YImLZQv4a5DBpnuomBLZkX
         yhBAG8OzPW4NJnE5GKaQfCTD/7yDN+R8RNV6Y9VG7Gd/J2jgHpfM58aO2I6X5gzLSgjJ
         GxV3JmlAuQnqJEfYxn7n7yQmdipWOxk85J9W/Fv99u+wYUiPwMRsvqsDAETGTElFfxWU
         woMUVk1TD+BylQ05asVSICxJUEhIdmFl1NH6d8vKbq6Lb8z4KQhGqAM+Ah1nbEs6/x1T
         GgQtD6pCw14FDFp+C2ycFQJVnGh2NV0OTty/H8D3WMW3lTS6J6pHml0L2+Xc68p0TMXf
         zLHA==
X-Gm-Message-State: AOAM533dQLPfwP0pOzWE7jeulj7I58LEiA9XNXcytsuuR0WyqDj/8Mbd
        FftdAYwvJQBPXHEevdxrjFmT5/AEL4Kmug==
X-Google-Smtp-Source: ABdhPJw01yMA36SpTDZzN+FWX4UazoVS/Wxeu+Ppa6aM/jOkPcbUHAjW9kB4+iy9CGj9eaC2zC7qKw==
X-Received: by 2002:adf:f946:0:b0:1f0:62c3:ea2e with SMTP id q6-20020adff946000000b001f062c3ea2emr4788173wrr.348.1647538056546;
        Thu, 17 Mar 2022 10:27:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d6652000000b001e669ebd528sm4690693wrw.91.2022.03.17.10.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:27:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] misc *.c: use designated initializers for struct assignments
Date:   Thu, 17 Mar 2022 18:27:17 +0100
Message-Id: <patch-3.5-11bfe9fabb4-20220317T171618Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-0.5-00000000000-20220317T171618Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220317T171618Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a few miscellaneous non-designated initializer assignments to
use designated initializers.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 attr.c        | 2 +-
 notes-merge.c | 1 +
 object-file.c | 9 +++++----
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/attr.c b/attr.c
index 79adaa50ea1..9ad12578cce 100644
--- a/attr.c
+++ b/attr.c
@@ -80,7 +80,7 @@ static int attr_hash_entry_cmp(const void *unused_cmp_data,
  * Access to this dictionary must be surrounded with a mutex.
  */
 static struct attr_hashmap g_attr_hashmap = {
-	HASHMAP_INIT(attr_hash_entry_cmp, NULL)
+	.map = HASHMAP_INIT(attr_hash_entry_cmp, NULL),
 };
 
 /*
diff --git a/notes-merge.c b/notes-merge.c
index 878b6c571b9..b4cc594a790 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -113,6 +113,7 @@ static struct notes_merge_pair *find_notes_merge_pair_pos(
 }
 
 static struct object_id uninitialized = {
+	.hash =
 	"\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff" \
 	"\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"
 };
diff --git a/object-file.c b/object-file.c
index bdc5cbdd386..f0a75b3ff1e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -274,10 +274,11 @@ static struct cached_object {
 static int cached_object_nr, cached_object_alloc;
 
 static struct cached_object empty_tree = {
-	{ EMPTY_TREE_SHA1_BIN_LITERAL },
-	OBJ_TREE,
-	"",
-	0
+	.oid = {
+		.hash = EMPTY_TREE_SHA1_BIN_LITERAL,
+	},
+	.type = OBJ_TREE,
+	.buf = "",
 };
 
 static struct cached_object *find_cached_object(const struct object_id *oid)
-- 
2.35.1.1384.g7d2906948a1


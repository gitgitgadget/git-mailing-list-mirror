Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1804C433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 05:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF186611C9
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 05:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhKKFW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 00:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhKKFWY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 00:22:24 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FA6C061766
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 21:19:35 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso6327956wml.1
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 21:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eDmkCFLND5JZ9s0IHdS2xFCW6jrSR3PYvQEoD+cGsNc=;
        b=BGw/uf8sueeN7hLsky4mNFBJvBQC5hcea62+vcAGFAZ7hbNUnCtLs+ZKCp01n6tqr+
         wOKOBwI5BMsC/fUDMS3mT4Kr3tsz3CNeJAMO4MoGCQYntOJK8zXLpnW3r0VJ4eSw59E+
         Pv2H3wZaJsq2qwBXdBVzkncTeB7JlgwX1H/W6VjpYYcTV+YmkYC99z0Zd1oV5bcjw8Y0
         sw3X4kaulSb3RMn9uHIXW4fNAg3G5JNYRkCHEZqxtAKezlAO0joDEILOLFj4csxLKQz+
         ZVYBTRpRQzNbF5aYtGQOSwdoelxiOIKr4fJ6ncEVK5rl1GR/DD0+p4KeuCCw3bkU4nAJ
         HvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eDmkCFLND5JZ9s0IHdS2xFCW6jrSR3PYvQEoD+cGsNc=;
        b=zps2P1BQEvd7qL4w9z8uNEFy/SYCMIQyUnSJGEeB56ver0KFJVAKDRKUMKq8QRFW5O
         +Bjo5AsSclhVBfi5w8N8odDJ9xqoISxOo3B98KMADIA3YnV7R8jhg6CWZ/Vrl1nNsM9D
         whRU3gHqeETtUj3uWZxOkEbnf5f0mEMC0xjOyQOBqbdOgZzzOyEeAKPOT2hezn9SCyeL
         GSAXkocEQwkAG1sdeHu0/1CNZ13Un7MmIyl+LbZ0s3EAie1/bHGH40JsWE2hjoB2+VZQ
         ZfRYPPsnaJyuFeT+TH7tGhpyYewU+QQw1nWvr63n2InYp2XMnf5oDqBusIzBe6csCaL+
         8mCA==
X-Gm-Message-State: AOAM531BhoJ/j/JN4EA5xmxqqLbt0aKGwMbYXpDVBaJFdRwSVxWrXVWW
        boYC67xr4+9DNpNut1aca9prwR5neGKvbUHW
X-Google-Smtp-Source: ABdhPJzf3Ii+5SlDe4yDhIDsN0+imxQt5dYGx7+YTVWYYxaudefGWFxLM2WWAW8DyBGoQCgoBe3IOw==
X-Received: by 2002:a1c:f405:: with SMTP id z5mr5460046wma.72.1636607973815;
        Wed, 10 Nov 2021 21:19:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o2sm1845391wrg.1.2021.11.10.21.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 21:19:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] object-file: free(*contents) only in read_loose_object() caller
Date:   Thu, 11 Nov 2021 06:18:56 +0100
Message-Id: <patch-2.2-e2a5468e2e0-20211111T051800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-0.2-00000000000-20211111T051800Z-avarab@gmail.com>
References: <20211111030532.75910-1-hanxin.hx@alibaba-inc.com> <cover-0.2-00000000000-20211111T051800Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding commit a free() of uninitialized memory regression in
96e41f58fe1 (fsck: report invalid object type-path combinations,
2021-10-01) was fixed, but we'd still have an issue with leaking
memory from fsck_loose(). Let's fix that issue too.

That issue was introduced in my 31deb28f5e0 (fsck: don't hard die on
invalid object types, 2021-10-01). It can be reproduced under
SANITIZE=leak with the test I added in 093fffdfbec (fsck tests: add
test for fsck-ing an unknown type, 2021-10-01):

    ./t1450-fsck.sh --run=84 -vixd

In some sense it's not a problem, we lost the same amount of memory in
terms of things malloc'd and not free'd. It just moved from the "still
reachable" to "definitely lost" column in valgrind(1) nomenclature[1],
since we'd have die()'d before.

But now that we don't hard die() anymore in the library let's properly
free() it. Doing so makes this code much easier to follow, since we'll
now have one function owning the freeing of the "contents" variable,
not two.

For context on that memory management pattern the read_loose_object()
function was added in f6371f92104 (sha1_file: add read_loose_object()
function, 2017-01-13) and subsequently used in c68b489e564 (fsck:
parse loose object paths directly, 2017-01-13). The pattern of it
being the task of both sides to free() the memory has been there in
this form since its inception.

1. https://valgrind.org/docs/manual/mc-manual.html#mc-manual.leaks

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fsck.c | 3 ++-
 object-file.c  | 7 ++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d87c28a1cc4..27b9e78094d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -605,7 +605,7 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 	struct object *obj;
 	enum object_type type = OBJ_NONE;
 	unsigned long size;
-	void *contents;
+	void *contents = NULL;
 	int eaten;
 	struct object_info oi = OBJECT_INFO_INIT;
 	struct object_id real_oid = *null_oid();
@@ -630,6 +630,7 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 			    path);
 	if (err < 0) {
 		errors_found |= ERROR_OBJECT;
+		free(contents);
 		return 0; /* keep checking other objects */
 	}
 
diff --git a/object-file.c b/object-file.c
index ac476653a06..c3d866a287e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2528,8 +2528,6 @@ int read_loose_object(const char *path,
 	char hdr[MAX_HEADER_LEN];
 	unsigned long *size = oi->sizep;
 
-	*contents = NULL;
-
 	map = map_loose_object_1(the_repository, path, NULL, &mapsize);
 	if (!map) {
 		error_errno(_("unable to mmap %s"), path);
@@ -2559,10 +2557,9 @@ int read_loose_object(const char *path,
 			goto out;
 		}
 		if (check_object_signature(the_repository, expected_oid,
-					   *contents, *size, oi->type_name->buf, real_oid)) {
-			free(*contents);
+					   *contents, *size,
+					   oi->type_name->buf, real_oid))
 			goto out;
-		}
 	}
 
 	ret = 0; /* everything checks out */
-- 
2.34.0.rc2.795.g926201d1cc8


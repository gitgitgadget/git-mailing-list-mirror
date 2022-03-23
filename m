Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EA9C433FE
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 14:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244730AbiCWOUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 10:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244699AbiCWOUW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 10:20:22 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D64F7CDC4
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 07:18:52 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so1028183wme.0
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 07:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jzcblGX8ZxIKXRkxRRlf46XrZ6d0iUVgHKsq+qVMr6o=;
        b=OJCkvNRFb4em2Muj+YD0IJMlXl36M1PU6FdpUYqSyBXrU8h8pgKifqAN+YJQ9avG+r
         ulBEz52EcyOTWBaTAVMkUtV2A4jAGpNIXARXeiR7fCAd+lcIMK/cC8DiRLictJE+/clA
         sUjXb5Oo+Xut7m4lrIXT85hASqSgMrqvJ2yG3JAlF4ChNVdI49krghGVKgFtNGOX8vhH
         RA78Jf3Ds13pm4v4CP4WeTurAa/t4N/RevU+yBy3mwLqJxd/1bcQJNGwn3Gl6/oEsbXC
         V+I7e9eqqvdjfkSnb83GJjNTnbPuKYU5yNsfwrEIttmH4mmsAybNRvPf7nlx3BKssCak
         JxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jzcblGX8ZxIKXRkxRRlf46XrZ6d0iUVgHKsq+qVMr6o=;
        b=5Btma1XWVjN/aamQ+XTh8s8xBd6Tl9KykB5P0CT4lyJ6n61Yh3RB+gpCai9mJdsAit
         SmkWva+xn5dzPqo2G3nxMHt+kVxr/9YDJXaKasCUJm5zR4ms0g8IBu0o0IQx7PND5Vm6
         ekuISlPN19JD94jlNVQjjgYuj2z+hFUD6KwOGLUeCMtVFxyD4vdm/sqpxKpZlR+ykGGb
         R7ZLNdZNHdghBeu0v7eEz3filHkOQsYIZbzlm79pJ219sCOqIxCm6geg03aPn1/r56nN
         /3P72v1cSZn8IHkytPkUpbPSFu+aVeCPie5Vt8M4qZ0k3WE6mTM4i5ZuJAxtKyeyM1uI
         n1Dg==
X-Gm-Message-State: AOAM532T8N88E+Xy23ARNTJxCis1Z5Gl5G56bgtCrdZtQJlPqnQlxR5i
        XVjYsk8/KUrxSXBsZSrSj8tsLCLqesrdgQ==
X-Google-Smtp-Source: ABdhPJyUN64F5FIGkdeuYsU4agUO6AvYkmmr+ZW9SD5vBqEsbJSX7M2Z7bgt1QP6nWEzUbhhwOMoxw==
X-Received: by 2002:a05:600c:35cc:b0:38c:73e8:7dd5 with SMTP id r12-20020a05600c35cc00b0038c73e87dd5mr9684391wmq.196.1648045130493;
        Wed, 23 Mar 2022 07:18:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b0038986a18ec8sm30592wmq.46.2022.03.23.07.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:18:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 7/7] fsync docs: add new fsyncMethod.batch.quarantine, elaborate on old
Date:   Wed, 23 Mar 2022 15:18:31 +0100
Message-Id: <RFC-patch-v2-7.7-a5951366c6e-20220323T140753Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1428.g1c1a0152d61
In-Reply-To: <RFC-cover-v2-0.7-00000000000-20220323T140753Z-avarab@gmail.com>
References: <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com> <RFC-cover-v2-0.7-00000000000-20220323T140753Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new fsyncMethod.batch.quarantine setting which defaults to
"false". Preceding (RFC, and not meant to flip-flop like that
eventually) commits ripped out the "tmp-objdir" part of the
core.fsyncMethod=batch.

This documentation proposes to keep that as the default for the
reasons discussed in it, while allowing users to set
"fsyncMethod.batch.quarantine=true".

Furthermore update the discussion of "core.fsyncObjectFiles" with
information about what it *really* does, why you probably shouldn't
use it, and how to safely emulate most of what it gave users in the
past in terms of performance benefit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/core.txt | 80 +++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index f598925b597..365a12dc7ae 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -607,21 +607,85 @@ stored on NTFS or ReFS filesystems.
 +
 The `batch` is currently only applies to loose-object files and will
 kick in when using the linkgit:git-unpack-objects[1] and
-linkgit:update-index[1] commands. Note that the "last" file to be
+linkgit:git-update-index[1] commands. Note that the "last" file to be
 synced may be the last object, as in the case of
 linkgit:git-unpack-objects[1], or relevant "index" (or in the future,
 "ref") update, as in the case of linkgit:git-update-index[1]. I.e. the
 batch syncing of the loose objects may be deferred until a subsequent
 fsync() to a file that makes them "active".
 
+fsyncMethod.batch.quarantine::
+	A boolean which if set to `true` will cause "batched" writes
+	to objects to be "quarantined" if
+	`core.fsyncMethod=batch`. This is `false` by default.
++
+The primary object of these fsync() settings is to protect against
+repository corruption of things which are reachable, i.e. "reachable",
+via references, the index etc. Not merely objects that were present in
+the object store.
++
+Historically setting `core.fsyncObjectFiles=false` assumed that on a
+filesystem with where an fsync() would flush all preceding outstanding
+I/O that we might end up with a corrupt loose object, but that was OK
+as long as no reference referred to it. We'd eventually the corrupt
+object with linkgit:git-gc[1], and linkgit:git-fsck[1] would only
+report it as a minor annoyance
++
+Setting `fsyncMethod.batch.quarantine=true` takes the view that
+something like a corrupt *unreferenced* loose object in the object
+store is something we'd like to avoid, at the cost of reduced
+performance when using `core.fsyncMethod=batch`.
++
+Currently this uses the same mechanism described in the "QUARANTINE
+ENVIRONMENT" in the linkgit:git-receive-pack[1] documentation, but
+that's subject to change. The performance loss is because we need to
+"stage" the objects in that quarantine environment, fsync() it, and
+once that's done rename() or link() it in-place into the main object
+store, possibly with an fsync() of the index or ref at the end
++
+With `fsyncMethod.batch.quarantine=false` we'll "stage" things in the
+main object store, and then do one fsync() at the very end, either on
+the last object we write, or file (index or ref) that'll make it
+"reachable".
++
+The bad thing about setting this to `true` is lost performance, as
+well as not being able to access the objects as they're written (which
+e.g. consumers of linkgit:git-update-index[1]'s `--verbose` mode might
+want to do).
++
+The good thing is that you should be guaranteed not to get e.g. short
+or otherwise corrupt loose objects if you pull your power cord, in
+practice various git commands deal quite badly with discovering such a
+stray corrupt object (including perhaps assuming it's valid based on
+its existence, or hard dying on an error rather than replacing
+it). Repairing such "unreachable corruption" can require manual
+intervention.
+
 core.fsyncObjectFiles::
-	This boolean will enable 'fsync()' when writing object files.
-	This setting is deprecated. Use core.fsync instead.
-+
-This setting affects data added to the Git repository in loose-object
-form. When set to true, Git will issue an fsync or similar system call
-to flush caches so that loose-objects remain consistent in the face
-of a unclean system shutdown.
+	This boolean will enable 'fsync()' when writing loose object
+	files.
++
+This setting is the historical fsync configuration setting. It's now
+*deprecated*, you should use `core.fsync` instead, perhaps in
+combination with `core.fsyncMethod=batch`.
++
+The `core.fsyncObjectFiles` was initially added based on integrity
+assumptions that early (pre-ext-4) versions of Linux's "ext"
+filesystems provided.
++
+I.e. that a write of file A without an `fsync()` followed by a write
+of file `B` with `fsync()` would implicitly guarantee that `A' would
+be `fsync()`'d by calling `fsync()` on `B`. This asssumption is *not*
+backed up by any standard (e.g. POSIX), but worked in practice on some
+Linux setups.
++
+Nowadays you should almost certainly want to use
+`core.fsync=loose-object` instead in combination with
+`core.fsyncMethod=bulk`, and possibly with
+`fsyncMethod.batch.quarantine=true`, see above. On modern OS's (Linux,
+OSX, Windows) that gives you most of the performance benefit of
+`core.fsyncObjectFiles=false` with all of the safety of the old
+`core.fsyncObjectFiles=true`.
 
 core.preloadIndex::
 	Enable parallel index preload for operations like 'git diff'
-- 
2.35.1.1428.g1c1a0152d61


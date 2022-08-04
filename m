Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE5CC19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 16:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbiHDQ3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 12:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbiHDQ3T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 12:29:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7984167CBB
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 09:29:04 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z12so293460wrs.9
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 09:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=tEicZq8/Amgu9PAiY24y7otqGgy2m+FchdZbVepeos4=;
        b=RoP1F8bFCZGZ4bqtWQRIQPwit35n16/5d0G/4H9fM+QAL2Yu+S+DERxtBFQJkKu/4Q
         jvdKjOOlhiF6/wFlocDh5Cv0nKALG5bPW23WpLrzS1wM/JPdzQV7jBhuuriTfDA6IVRZ
         B+vNk06MVMgw6g8+t05yXR1/DZRD6x8rpkT0TVAL4XXl2Iko4IvXjaj6VfAQl34ZNO8j
         42W8R2pzOdiEd7z/lQoLMqiDrl6OChLIhdWLSAnjnOBNATsqoZ2nMFWlsTV2JcEjKPvn
         /H0xegiMy01j7ZWMXuOd27DT2/S9Oe2hsQf9zTuKz354sI4N0fNLOThtRaZM6M1ZuvT8
         4FhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=tEicZq8/Amgu9PAiY24y7otqGgy2m+FchdZbVepeos4=;
        b=knCDBa5/KeZn0QuBJypoHiEqViktw7NOOaOohzDFZHwAEVf4SrhsI1OROnNouQEyUU
         9j0YBmU0uNGagx8BPTQ73peQ62VMP2maXT1qoGjE/eMh5OlKjdqKYAVDr9jx1CDKLY4o
         bOGklprMtv/UXskN7Epagy2QR550KnGpqT4JTM3YDaTfv6JQ/qhaOo6oIq864XUno/jt
         k6dMXXVRYDHVLo0x+l71lBlqAysQ+5qsrR8f/bXkOHdz2cwkFgEIHfQx96Fb6xp28A8h
         Gn8pjbg6xFFR65nPgUQZpNzIQX/vwMJExiFt9kqJC5cawKIW4nkqN9KLcE1OLC+buBUy
         27Rg==
X-Gm-Message-State: ACgBeo3mGvBuAtHGPS+jY4XvEZqYwOKP8oL/rnqLWIQ2or+Aua0RP42O
        nPEqRKqz2d0+oqNMWcTsrYxlBPJt51NVjA==
X-Google-Smtp-Source: AA6agR7XMl0YqEY33IBGwFP0eTES8ZGTqQ1GRWg51Nzf/7TqDHF+vfbBx9hhZcah4AjN7wvNzWDWzA==
X-Received: by 2002:a5d:6c6b:0:b0:1ea:77ea:dde8 with SMTP id r11-20020a5d6c6b000000b001ea77eadde8mr1966147wrz.690.1659630543560;
        Thu, 04 Aug 2022 09:29:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n66-20020a1ca445000000b003a513ee7830sm1868063wme.27.2022.08.04.09.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 09:29:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 11/12] docs: move cruft pack docs to gitformat-pack
Date:   Thu,  4 Aug 2022 18:28:40 +0200
Message-Id: <patch-v8-11.12-b9dde9788d4-20220804T162138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.g61622908797
In-Reply-To: <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
References: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com> <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Integrate the cruft packs documentation initially added in
3d89a8c1180 (Documentation/technical: add cruft-packs.txt, 2022-05-20)
to the newly created "gitformat-pack" documentation.

Like the "bitmap-format" added before it in
0d4455a3ab0 (documentation: add documentation for the bitmap format,
2013-11-14) the "cruft-packs" were documented in their own file.

As the diff move detection will show there is no change to
"Documentation/technical/cruft-packs.txt" here except to move it, and
to "indent" the existing sections by adding an extra "=" to them.

We could similarly convert the "bitmap-format.txt", but let's leave it
for now due to a conflict with the in-flight ac/bitmap-lookup-table
series.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile                  |   1 -
 Documentation/gitformat-pack.txt        | 126 ++++++++++++++++++++++++
 Documentation/technical/cruft-packs.txt | 123 -----------------------
 3 files changed, 126 insertions(+), 124 deletions(-)
 delete mode 100644 Documentation/technical/cruft-packs.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d4a4a8c8b7d..41a070ab593 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -105,7 +105,6 @@ TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
 TECH_DOCS += ToolsForGit
 TECH_DOCS += technical/bitmap-format
-TECH_DOCS += technical/cruft-packs
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
 TECH_DOCS += technical/long-running-process-protocol
diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat-pack.txt
index 546c99f8871..e06af02f211 100644
--- a/Documentation/gitformat-pack.txt
+++ b/Documentation/gitformat-pack.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 $GIT_DIR/objects/pack/pack-*.{pack,idx}
 $GIT_DIR/objects/pack/pack-*.rev
+$GIT_DIR/objects/pack/pack-*.mtimes
 $GIT_DIR/objects/pack/multi-pack-index
 
 DESCRIPTION
@@ -507,6 +508,131 @@ packs arranged in MIDX order (with the preferred pack coming first).
 The MIDX's reverse index is stored in the optional 'RIDX' chunk within
 the MIDX itself.
 
+== cruft packs
+
+The cruft packs feature offer an alternative to Git's traditional mechanism of
+removing unreachable objects. This document provides an overview of Git's
+pruning mechanism, and how a cruft pack can be used instead to accomplish the
+same.
+
+=== Background
+
+To remove unreachable objects from your repository, Git offers `git repack -Ad`
+(see linkgit:git-repack[1]). Quoting from the documentation:
+
+----
+[...] unreachable objects in a previous pack become loose, unpacked objects,
+instead of being left in the old pack. [...] loose unreachable objects will be
+pruned according to normal expiry rules with the next 'git gc' invocation.
+----
+
+Unreachable objects aren't removed immediately, since doing so could race with
+an incoming push which may reference an object which is about to be deleted.
+Instead, those unreachable objects are stored as loose objects and stay that way
+until they are older than the expiration window, at which point they are removed
+by linkgit:git-prune[1].
+
+Git must store these unreachable objects loose in order to keep track of their
+per-object mtimes. If these unreachable objects were written into one big pack,
+then either freshening that pack (because an object contained within it was
+re-written) or creating a new pack of unreachable objects would cause the pack's
+mtime to get updated, and the objects within it would never leave the expiration
+window. Instead, objects are stored loose in order to keep track of the
+individual object mtimes and avoid a situation where all cruft objects are
+freshened at once.
+
+This can lead to undesirable situations when a repository contains many
+unreachable objects which have not yet left the grace period. Having large
+directories in the shards of `.git/objects` can lead to decreased performance in
+the repository. But given enough unreachable objects, this can lead to inode
+starvation and degrade the performance of the whole system. Since we
+can never pack those objects, these repositories often take up a large amount of
+disk space, since we can only zlib compress them, but not store them in delta
+chains.
+
+=== Cruft packs
+
+A cruft pack eliminates the need for storing unreachable objects in a loose
+state by including the per-object mtimes in a separate file alongside a single
+pack containing all loose objects.
+
+A cruft pack is written by `git repack --cruft` when generating a new pack.
+linkgit:git-pack-objects[1]'s `--cruft` option. Note that `git repack --cruft`
+is a classic all-into-one repack, meaning that everything in the resulting pack is
+reachable, and everything else is unreachable. Once written, the `--cruft`
+option instructs `git repack` to generate another pack containing only objects
+not packed in the previous step (which equates to packing all unreachable
+objects together). This progresses as follows:
+
+  1. Enumerate every object, marking any object which is (a) not contained in a
+     kept-pack, and (b) whose mtime is within the grace period as a traversal
+     tip.
+
+  2. Perform a reachability traversal based on the tips gathered in the previous
+     step, adding every object along the way to the pack.
+
+  3. Write the pack out, along with a `.mtimes` file that records the per-object
+     timestamps.
+
+This mode is invoked internally by linkgit:git-repack[1] when instructed to
+write a cruft pack. Crucially, the set of in-core kept packs is exactly the set
+of packs which will not be deleted by the repack; in other words, they contain
+all of the repository's reachable objects.
+
+When a repository already has a cruft pack, `git repack --cruft` typically only
+adds objects to it. An exception to this is when `git repack` is given the
+`--cruft-expiration` option, which allows the generated cruft pack to omit
+expired objects instead of waiting for linkgit:git-gc[1] to expire those objects
+later on.
+
+It is linkgit:git-gc[1] that is typically responsible for removing expired
+unreachable objects.
+
+=== Caution for mixed-version environments
+
+Repositories that have cruft packs in them will continue to work with any older
+version of Git. Note, however, that previous versions of Git which do not
+understand the `.mtimes` file will use the cruft pack's mtime as the mtime for
+all of the objects in it. In other words, do not expect older (pre-cruft pack)
+versions of Git to interpret or even read the contents of the `.mtimes` file.
+
+Note that having mixed versions of Git GC-ing the same repository can lead to
+unreachable objects never being completely pruned. This can happen under the
+following circumstances:
+
+  - An older version of Git running GC explodes the contents of an existing
+    cruft pack loose, using the cruft pack's mtime.
+  - A newer version running GC collects those loose objects into a cruft pack,
+    where the .mtime file reflects the loose object's actual mtimes, but the
+    cruft pack mtime is "now".
+
+Repeating this process will lead to unreachable objects not getting pruned as a
+result of repeatedly resetting the objects' mtimes to the present time.
+
+If you are GC-ing repositories in a mixed version environment, consider omitting
+the `--cruft` option when using linkgit:git-repack[1] and linkgit:git-gc[1], and
+leaving the `gc.cruftPacks` configuration unset until all writers understand
+cruft packs.
+
+=== Alternatives
+
+Notable alternatives to this design include:
+
+  - The location of the per-object mtime data, and
+  - Storing unreachable objects in multiple cruft packs.
+
+On the location of mtime data, a new auxiliary file tied to the pack was chosen
+to avoid complicating the `.idx` format. If the `.idx` format were ever to gain
+support for optional chunks of data, it may make sense to consolidate the
+`.mtimes` format into the `.idx` itself.
+
+Storing unreachable objects among multiple cruft packs (e.g., creating a new
+cruft pack during each repacking operation including only unreachable objects
+which aren't already stored in an earlier cruft pack) is significantly more
+complicated to construct, and so aren't pursued here. The obvious drawback to
+the current implementation is that the entire cruft pack must be re-written from
+scratch.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/technical/cruft-packs.txt b/Documentation/technical/cruft-packs.txt
deleted file mode 100644
index d81f3a8982f..00000000000
--- a/Documentation/technical/cruft-packs.txt
+++ /dev/null
@@ -1,123 +0,0 @@
-= Cruft packs
-
-The cruft packs feature offer an alternative to Git's traditional mechanism of
-removing unreachable objects. This document provides an overview of Git's
-pruning mechanism, and how a cruft pack can be used instead to accomplish the
-same.
-
-== Background
-
-To remove unreachable objects from your repository, Git offers `git repack -Ad`
-(see linkgit:git-repack[1]). Quoting from the documentation:
-
-[quote]
-[...] unreachable objects in a previous pack become loose, unpacked objects,
-instead of being left in the old pack. [...] loose unreachable objects will be
-pruned according to normal expiry rules with the next 'git gc' invocation.
-
-Unreachable objects aren't removed immediately, since doing so could race with
-an incoming push which may reference an object which is about to be deleted.
-Instead, those unreachable objects are stored as loose objects and stay that way
-until they are older than the expiration window, at which point they are removed
-by linkgit:git-prune[1].
-
-Git must store these unreachable objects loose in order to keep track of their
-per-object mtimes. If these unreachable objects were written into one big pack,
-then either freshening that pack (because an object contained within it was
-re-written) or creating a new pack of unreachable objects would cause the pack's
-mtime to get updated, and the objects within it would never leave the expiration
-window. Instead, objects are stored loose in order to keep track of the
-individual object mtimes and avoid a situation where all cruft objects are
-freshened at once.
-
-This can lead to undesirable situations when a repository contains many
-unreachable objects which have not yet left the grace period. Having large
-directories in the shards of `.git/objects` can lead to decreased performance in
-the repository. But given enough unreachable objects, this can lead to inode
-starvation and degrade the performance of the whole system. Since we
-can never pack those objects, these repositories often take up a large amount of
-disk space, since we can only zlib compress them, but not store them in delta
-chains.
-
-== Cruft packs
-
-A cruft pack eliminates the need for storing unreachable objects in a loose
-state by including the per-object mtimes in a separate file alongside a single
-pack containing all loose objects.
-
-A cruft pack is written by `git repack --cruft` when generating a new pack.
-linkgit:git-pack-objects[1]'s `--cruft` option. Note that `git repack --cruft`
-is a classic all-into-one repack, meaning that everything in the resulting pack is
-reachable, and everything else is unreachable. Once written, the `--cruft`
-option instructs `git repack` to generate another pack containing only objects
-not packed in the previous step (which equates to packing all unreachable
-objects together). This progresses as follows:
-
-  1. Enumerate every object, marking any object which is (a) not contained in a
-     kept-pack, and (b) whose mtime is within the grace period as a traversal
-     tip.
-
-  2. Perform a reachability traversal based on the tips gathered in the previous
-     step, adding every object along the way to the pack.
-
-  3. Write the pack out, along with a `.mtimes` file that records the per-object
-     timestamps.
-
-This mode is invoked internally by linkgit:git-repack[1] when instructed to
-write a cruft pack. Crucially, the set of in-core kept packs is exactly the set
-of packs which will not be deleted by the repack; in other words, they contain
-all of the repository's reachable objects.
-
-When a repository already has a cruft pack, `git repack --cruft` typically only
-adds objects to it. An exception to this is when `git repack` is given the
-`--cruft-expiration` option, which allows the generated cruft pack to omit
-expired objects instead of waiting for linkgit:git-gc[1] to expire those objects
-later on.
-
-It is linkgit:git-gc[1] that is typically responsible for removing expired
-unreachable objects.
-
-== Caution for mixed-version environments
-
-Repositories that have cruft packs in them will continue to work with any older
-version of Git. Note, however, that previous versions of Git which do not
-understand the `.mtimes` file will use the cruft pack's mtime as the mtime for
-all of the objects in it. In other words, do not expect older (pre-cruft pack)
-versions of Git to interpret or even read the contents of the `.mtimes` file.
-
-Note that having mixed versions of Git GC-ing the same repository can lead to
-unreachable objects never being completely pruned. This can happen under the
-following circumstances:
-
-  - An older version of Git running GC explodes the contents of an existing
-    cruft pack loose, using the cruft pack's mtime.
-  - A newer version running GC collects those loose objects into a cruft pack,
-    where the .mtime file reflects the loose object's actual mtimes, but the
-    cruft pack mtime is "now".
-
-Repeating this process will lead to unreachable objects not getting pruned as a
-result of repeatedly resetting the objects' mtimes to the present time.
-
-If you are GC-ing repositories in a mixed version environment, consider omitting
-the `--cruft` option when using linkgit:git-repack[1] and linkgit:git-gc[1], and
-leaving the `gc.cruftPacks` configuration unset until all writers understand
-cruft packs.
-
-== Alternatives
-
-Notable alternatives to this design include:
-
-  - The location of the per-object mtime data, and
-  - Storing unreachable objects in multiple cruft packs.
-
-On the location of mtime data, a new auxiliary file tied to the pack was chosen
-to avoid complicating the `.idx` format. If the `.idx` format were ever to gain
-support for optional chunks of data, it may make sense to consolidate the
-`.mtimes` format into the `.idx` itself.
-
-Storing unreachable objects among multiple cruft packs (e.g., creating a new
-cruft pack during each repacking operation including only unreachable objects
-which aren't already stored in an earlier cruft pack) is significantly more
-complicated to construct, and so aren't pursued here. The obvious drawback to
-the current implementation is that the entire cruft pack must be re-written from
-scratch.
-- 
2.37.1.1233.g61622908797


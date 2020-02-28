Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F4EC3F2D2
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 15:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508D12469D
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 15:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIR+Go4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgB1Poa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:44:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51448 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgB1Poa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 10:44:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id t23so3679320wmi.1
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 07:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O8UBfw6SyRQ3Ro7o/MFUUKMbq6/7GEWuRgKkdbZrRYA=;
        b=ZIR+Go4LIC2gmaZ52mVX7Z3hhHYVH4USu4i1vVUwMkS7iuSLieiFoRuHFzocF19tMS
         bwnd3irGEBjQaJrk52rjXK/wToxIzBoL33rzQmBcwj5q79yyHqyTFQlh93fPx9Yn3Nqw
         psbO0cY/GxBJuxKw6xarLNSefVPTWZjBGiIdaloRpRqJxbQNMcCHk02tcMem5o58srJ4
         Y34aab49/dyilx+H/SgCQpDudPlq6mrdalXW+rcuu4cqf9Phkc4Zg78whlRaZr9H+oil
         uFzhjUtXqMVYYRP+RSiBPVslYpZN5S7LJ+gx1EIUqtpw9uTpx+UyHBc/Y4ayQGRzRKPG
         kBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O8UBfw6SyRQ3Ro7o/MFUUKMbq6/7GEWuRgKkdbZrRYA=;
        b=GeQ24TJp0p5+zO6jHz7ciDUmHBmAdSLr8eX3uX3dkDPCjbsy4jNSDP87/kvZi+aKmT
         SvKG6/vi07hStJVueMa5e7AxZ8l3AzXBVep5wm+R9ByG9eSq287skBhRQKAoCSKck6a1
         bm+NPJYOAqV91RjLsQoqACE49+gTuRwUfcwn/qBLEqu4/+4lsOKl2/0waxQobgcWMEbi
         wbMYbWIWWfjYunSjHHLrBfb/UvlidKsf1IfetId3BHYVkCaW0vzjIza4wIAli8LQB6Iv
         90htO+xcpnYw2tU8qxf44xfFsSQj/huJUcDkcUxoRULwHueHgwetLxrYVW4EVnVhaHrc
         Gxrw==
X-Gm-Message-State: APjAAAX0N+XxrDAa6vIyC8e4DsxwdipIx22GW5cDsb9Kz8bjp0QuxpFo
        yMi1fbPA/W/CkKj4mtIUvT8E1Af1LTI=
X-Google-Smtp-Source: APXvYqzTeKAo+EC812awu4cIo5UucwrzE/9590tGzJ7zASt5WWOIh1Qn/C4OJjziGP6BXiyi9mHBrw==
X-Received: by 2002:a7b:ce92:: with SMTP id q18mr5416772wmj.70.1582904667429;
        Fri, 28 Feb 2020 07:44:27 -0800 (PST)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id z6sm12815549wrw.36.2020.02.28.07.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:44:26 -0800 (PST)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH 1/2] doc: update the documentation of pack-objects and repack
Date:   Fri, 28 Feb 2020 16:43:56 +0100
Message-Id: <20200228154357.1710521-2-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200228154357.1710521-1-damien.olivier.robert+git@gmail.com>
References: <20200228154357.1710521-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For pack-objects:

  - add a documentation for --reflog, --indexed-objects and
  --write-bitmap-index.

  - clarify --keep-unreachable. Indeed the current description is out of
  date:

      Objects unreachable from the refs in packs named with
      --unpacked= option are added to the resulting pack, in
      addition to the reachable objects that are not in packs marked
      with *.keep files. This implies `--revs`.

  For example --unpacked= option is now a boolean, and objects in .keep
  packs are packed except if --honor-pack-keep is given.
  What --keep-unreachable currently does is simply to add all packed
  objects to the object list. In particular this includes unreachable
  objects (both unreachable from the passed revs or even from all revs).

  - rework the grammar for --pack-loose-unreachable

  - --unpack-unreachable can also accept a time

For repack:

- Unify the notation to `git pack-objects` and not `git-pack-objects`.

- Specify all options that are passed to `git pack-objects`

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 Documentation/git-pack-objects.txt | 27 +++++++++----
 Documentation/git-repack.txt       | 61 +++++++++++++++++++-----------
 2 files changed, 58 insertions(+), 30 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index fecdf2600c..7f4923ddea 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -80,6 +80,14 @@ base-name::
 	as if all refs under `refs/` are specified to be
 	included.
 
+--reflog::
+	This implies `--revs`.
+	Include objects referred by reflog entries.
+
+--indexed-objects::
+	This implies `--revs`.
+	Include objects referred to by the index
+
 --include-tag::
 	Include unasked-for annotated tags if the object they
 	reference was included in the resulting packfile.  This
@@ -123,6 +131,11 @@ depth is 4095.
 	The default is unlimited, unless the config variable
 	`pack.packSizeLimit` is set.
 
+--write-bitmap-index::
+	Write a reachability bitmap index as part of the pack. This
+	only makes sense when used with `--all` and the pack is not
+	outputted to stdout.
+
 --honor-pack-keep::
 	This flag causes an object already in a local pack that
 	has a .keep file to be ignored, even if it would have
@@ -286,17 +299,17 @@ Unexpected missing object will raise an error.
 	promisor remote [with .promisor].)  This is used with partial clone.
 
 --keep-unreachable::
-	Objects unreachable from the refs in packs named with
-	--unpacked= option are added to the resulting pack, in
-	addition to the reachable objects that are not in packs marked
-	with *.keep files. This implies `--revs`.
+	Unreachable packed objects are added to the resulting pack.
+	This implies `--revs`.
 
 --pack-loose-unreachable::
-	Pack unreachable loose objects (and their loose counterparts
-	removed). This implies `--revs`.
+	Pack unreachable loose objects (and remove their loose counterparts).
+	This implies `--revs`.
 
---unpack-unreachable::
+--unpack-unreachable=<when>::
 	Keep unreachable objects in loose form. This implies `--revs`.
+	If `<when>` is specified, do not bother loosening any objects older
+	than `<when>`.
 
 --delta-islands::
 	Restrict delta matches based on "islands". See DELTA ISLANDS
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 92f146d27d..267edce2d6 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -68,11 +68,11 @@ to the new separate pack will be written.
 	linkgit:git-pack-objects[1].
 
 -f::
-	Pass the `--no-reuse-delta` option to `git-pack-objects`, see
+	Pass the `--no-reuse-delta` option to `git pack-objects`, see
 	linkgit:git-pack-objects[1].
 
 -F::
-	Pass the `--no-reuse-object` option to `git-pack-objects`, see
+	Pass the `--no-reuse-object` option to `git pack-objects`, see
 	linkgit:git-pack-objects[1].
 
 -q::
@@ -88,13 +88,14 @@ to the new separate pack will be written.
 
 --window=<n>::
 --depth=<n>::
-	These two options affect how the objects contained in the pack are
-	stored using delta compression. The objects are first internally
-	sorted by type, size and optionally names and compared against the
-	other objects within `--window` to see if using delta compression saves
-	space. `--depth` limits the maximum delta depth; making it too deep
-	affects the performance on the unpacker side, because delta data needs
-	to be applied that many times to get to the necessary object.
+	These two options are passed to `git pack-objects` and affect how
+	the objects contained in the pack are stored using delta
+	compression. The objects are first internally sorted by type, size
+	and optionally names and compared against the other objects within
+	`--window` to see if using delta compression saves space. `--depth`
+	limits the maximum delta depth; making it too deep affects the
+	performance on the unpacker side, because delta data needs to be
+	applied that many times to get to the necessary object.
 +
 The default value for --window is 10 and --depth is 50. The maximum
 depth is 4095.
@@ -103,13 +104,13 @@ depth is 4095.
 	This option is passed through to `git pack-objects`.
 
 --window-memory=<n>::
-	This option provides an additional limit on top of `--window`;
-	the window size will dynamically scale down so as to not take
-	up more than '<n>' bytes in memory.  This is useful in
-	repositories with a mix of large and small objects to not run
-	out of memory with a large window, but still be able to take
-	advantage of the large window for the smaller objects.  The
-	size can be suffixed with "k", "m", or "g".
+	This option is passed to `git pack-objects` and provides an
+	additional limit on top of `--window`; the window size will
+	dynamically scale down so as to not take up more than '<n>' bytes
+	in memory.  This is useful in repositories with a mix of large and
+	small objects to not run out of memory with a large window, but
+	still be able to take advantage of the large window for the smaller
+	objects.  The size can be suffixed with "k", "m", or "g".
 	`--window-memory=0` makes memory usage unlimited.  The default
 	is taken from the `pack.windowMemory` configuration variable.
 	Note that the actual memory usage will be the limit multiplied
@@ -122,6 +123,7 @@ depth is 4095.
 	prevents the creation of a bitmap index.
 	The default is unlimited, unless the config variable
 	`pack.packSizeLimit` is set.
+	This option is passed to `git pack-objects`.
 
 -b::
 --write-bitmap-index::
@@ -129,7 +131,8 @@ depth is 4095.
 	only makes sense when used with `-a` or `-A`, as the bitmaps
 	must be able to refer to all reachable objects. This option
 	overrides the setting of `repack.writeBitmaps`.  This option
-	has no effect if multiple packfiles are created.
+	has no effect if multiple packfiles are created, and is passed to
+	`git pack-objects`.
 
 --pack-kept-objects::
 	Include objects in `.keep` files when repacking.  Note that we
@@ -145,26 +148,38 @@ depth is 4095.
 	of having `.keep` file on the pack. `<pack-name>` is the
 	pack file name without leading directory (e.g. `pack-123.pack`).
 	The option could be specified multiple times to keep multiple
-	packs.
+	packs, and is passed to `git pack-objects`.
 
 --unpack-unreachable=<when>::
+	When used with `-ad`, this option is passed to `git pack-objects`.
 	When loosening unreachable objects, do not bother loosening any
 	objects older than `<when>`. This can be used to optimize out
 	the write of any objects that would be immediately pruned by
 	a follow-up `git prune`.
+	The `-A` option is synonymous with `-a --unpack-unreachable`.
 
 -k::
 --keep-unreachable::
-	When used with `-ad`, any unreachable objects from existing
-	packs will be appended to the end of the packfile instead of
-	being removed. In addition, any unreachable loose objects will
-	be packed (and their loose counterparts removed).
+	When used with `-ad`, '--keep-unreachable' and
+	'--pack-loose-unreachable' are passed to `git pack-objects`.
+	Any unreachable objects from existing packs will be appended to the
+	end of the packfile instead of being removed. In addition, any
+	unreachable loose objects will be packed (and their loose
+	counterparts removed).
 
 -i::
 --delta-islands::
-	Pass the `--delta-islands` option to `git-pack-objects`, see
+	Pass the `--delta-islands` option to `git pack-objects`, see
 	linkgit:git-pack-objects[1].
 
+Default options
+---------------
+
+The command passes the following options to `git pack-objects`:
+`--keep-true-parents`, `--no-empty`, `--all`, `--reflog`, `--indexed-objects`.
+It also add `--exclude-promisor-objects` if there exists a promisor remote,
+and `--honor-pack-keep` except if `--pack-kept-objects` is passed.
+
 Configuration
 -------------
 
-- 
Patched on top of v2.25.1-377-g2d2118b814 (git version 2.25.1)


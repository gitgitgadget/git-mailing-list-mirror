Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA069C1975A
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 17:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DFC206F1
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 17:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqZRD/af"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgCLRKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:10:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40481 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgCLRKS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 13:10:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id f3so1484966wrw.7
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 10:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3NpfDHsdhoObKi+/al7YQvsCxWT7qiKlscxNhGD/I4A=;
        b=CqZRD/af0eZrgizUyAW95UBywfO/bb/LFLUtKWD1Qg4j3MCh4kaWDidWZF8y/CdnMz
         4stIxNyi3fm8sR4lHl99VoEaMDQ3JBcyRgs+qTKOkdkSSuPk02gwzNo1uxgmIn/8aSCh
         HLjjt6nExtBVVp8gFphcT7gqVVsdQHfgi2tb6iZav3waKWEJIG9vqV9Y7qm7VyTRNZmc
         NaDH2IATQj+vKganDd4eRq4B0m2htIEM9fZ42Gj6NosyeZ+mO+/o4g1idoZvBeJq0B7t
         x0ZVqTMFa5xNpARVefsLDOwCglRj8zyvUQKekljGph0BFByliHeADiWEuMKMVu7qkVKR
         cMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3NpfDHsdhoObKi+/al7YQvsCxWT7qiKlscxNhGD/I4A=;
        b=XnCBpo4eiwaCh/idt120qQPYuiX0jRWDdY6UO25+uD5Mf+cV6JxPSZjpEI8C/EMXhp
         jVP33oah19QKjbdNkT2Zli0MXZRaCYO4iNIPHz3epPO5nOjMEAca7RTv8cx6c4pBNSXG
         om0HJZ9n0rKZRHa5/iD/7cgbLrazqu65HSdCiBVrrTpTEbEiRqo4lHecatQBgV7PbkOG
         uGVyaeh02F/HTO7i2kEU3Om7tkHXmdjU1MWADT/WIWpi+hYg26XhqWYcg1vyBjf49/Xl
         ychkrwhumb2ocf9h9DSxUmzwlDsYP46ofJ4kIZDT83qBnZMNMKh9r8FE4q3fdMx8cPeX
         1+eQ==
X-Gm-Message-State: ANhLgQ3tBORYmnA+qowam2oQiI7UxVdRKSFJXHn9ZnllzGBxLElJf/pS
        IpkQat5m1baX7f0JGfyT0KY=
X-Google-Smtp-Source: ADFU+vuXu9WWjQ2z4y2Vl8DDv4FeXlkTzvO4NhgRc75yf99Y9OOnGx+tlQxC2R0Fkg1xXXYR9RdXmw==
X-Received: by 2002:adf:a50b:: with SMTP id i11mr12935515wrb.60.1584033015173;
        Thu, 12 Mar 2020 10:10:15 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id r12sm21593430wrx.26.2020.03.12.10.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:10:14 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v2 2/3] doc: update the documentation of pack-objects and repack
Date:   Thu, 12 Mar 2020 18:09:30 +0100
Message-Id: <20200312170931.2392490-3-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200312170931.2392490-1-damien.olivier.robert+git@gmail.com>
References: <20200228154357.1710521-2-damien.olivier.robert+git@gmail.com>
 <20200312170931.2392490-1-damien.olivier.robert+git@gmail.com>
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
 Documentation/git-pack-objects.txt | 27 +++++++++++----
 Documentation/git-repack.txt       | 53 +++++++++++++++++-------------
 2 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index fecdf2600c..cb4db37a03 100644
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
+	Include objects referred to by the index.
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
+	written to the standard output.
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
index 92f146d27d..0962562c17 100644
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
@@ -145,24 +148,28 @@ depth is 4095.
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
 
 Configuration
-- 
Patched on top of v2.26.0-rc1-6-ga56d361f66 (git version 2.25.1)


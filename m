Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62F1C4320E
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A12E460F9E
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241259AbhHaUwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241257AbhHaUww (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:52:52 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6239CC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:51:57 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id s16so674988ilo.9
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HzCKDLjGKEnx9sMzqhiF5WyixhOqv2ShfpkUJ5lh0/k=;
        b=xwjhvY+26UykS46tanmllkFPUvcc/n++UO0Rsm+3ZXFwISX2r7dSKwqWQ3FrdyBY0w
         QEpFUKZIliiOr3Dy5eEwb2N84XzrkoVPM2wQtVtVsCU8ZaHy+BBUgw4MqNUyEdpDV7PP
         UHSdRFepQ9KEhKAX2aGxYbynzCLSSIUiwrxH3tWEzDUB0cK5odKujOOe0l3GPwQrqh9p
         H/JSq7ZZ4YtnZb1B/xUrvhitjkv7gPHVsi8ALXlJoEu+CpMbOz3dG11+hM+Cg9xq/E8R
         Ix739InUsqCDS7nBPQv+ZeEvCCvax+oVIda7s1hbNFaV15PbVK9ht2yFrVxNHdjmoz0h
         r7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HzCKDLjGKEnx9sMzqhiF5WyixhOqv2ShfpkUJ5lh0/k=;
        b=RP8Mpn7KuJeptp2L+BrXUD3/6lacaNIT6jhE2W5wI4ZdSSXMftPL4L5oWwH452MAO4
         8W7SnV9hYVl5XAFnKy+4zn4iiMue/KqaCJ792yQQG+Ii3qICbK4cS6TKR8q/tR87CdnS
         wYsA4fxcOFwKYpFIXnsM3oNhE6fdnx+mfhm3MzT7OY0AAf8ysVLOnq6BTFGN3bQlCFlG
         CjKeDjYdpzNL71uKnmIeqcdEN1fqso43T7gUHyfHkxcU53fvcAqnxJCuoH0nDxfiR0oY
         xEHnSCMfKPRFRhppXICq2iauk0+FQj/3jNjgE0Ftgs+CwrSTy4qeMt/Pde2TKTavooe5
         Ix4Q==
X-Gm-Message-State: AOAM533sl3Nr+WdMC+zQi3m9PH7a36xYasMwFlooiueZUfuJu3aklJOv
        YbhJ8jIREe1uwZrYm7tv2cWg5QMV8JzVzUrp
X-Google-Smtp-Source: ABdhPJxIxI8fN6oHO8vhM+MnqfRUn8QFShCMhSxzkut6mCfwbi5W+VR47rBSjeiRTLNLBQqUBgD57Q==
X-Received: by 2002:a05:6e02:1a4f:: with SMTP id u15mr21665781ilv.251.1630443116639;
        Tue, 31 Aug 2021 13:51:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s7sm9667459ioc.42.2021.08.31.13.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:51:56 -0700 (PDT)
Date:   Tue, 31 Aug 2021 16:51:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v5 06/27] midx: fix `*.rev` cleanups with `--object-dir`
Message-ID: <0aacaa928395bdc041cc366a25047442ff7a33f1.1630443072.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630443072.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If using --object-dir to point into an object directory which belongs to
a different repository than the one in the current working directory,
such as:

  git init repo
  git -C repo ... # add some objects
  cd alternate
  git multi-pack-index --object-dir ../repo/.git/objects write

the binary will segfault trying to access the object-dir via the repo it
found, but that's not fully initialized. Worse, if we later call
clear_midx_files_ext(), we will use `the_repository` and remove files
out of the wrong object directory.

Fix this by using the given object_dir (or the object directory of
`the_repository` if `--object-dir` wasn't given) to properly to clean up
the *.rev files, avoiding the crash.

Original-patch-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c                      | 10 +++++-----
 t/t5319-multi-pack-index.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/midx.c b/midx.c
index 321c6fdd2f..902e1a7a7d 100644
--- a/midx.c
+++ b/midx.c
@@ -882,7 +882,7 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
 	strbuf_release(&buf);
 }
 
-static void clear_midx_files_ext(struct repository *r, const char *ext,
+static void clear_midx_files_ext(const char *object_dir, const char *ext,
 				 unsigned char *keep_hash);
 
 static int midx_checksum_valid(struct multi_pack_index *m)
@@ -1086,7 +1086,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 	if (flags & MIDX_WRITE_REV_INDEX)
 		write_midx_reverse_index(midx_name, midx_hash, &ctx);
-	clear_midx_files_ext(the_repository, ".rev", midx_hash);
+	clear_midx_files_ext(object_dir, ".rev", midx_hash);
 
 	commit_lock_file(&lk);
 
@@ -1135,7 +1135,7 @@ static void clear_midx_file_ext(const char *full_path, size_t full_path_len,
 		die_errno(_("failed to remove %s"), full_path);
 }
 
-static void clear_midx_files_ext(struct repository *r, const char *ext,
+static void clear_midx_files_ext(const char *object_dir, const char *ext,
 				 unsigned char *keep_hash)
 {
 	struct clear_midx_data data;
@@ -1146,7 +1146,7 @@ static void clear_midx_files_ext(struct repository *r, const char *ext,
 				    hash_to_hex(keep_hash), ext);
 	data.ext = ext;
 
-	for_each_file_in_pack_dir(r->objects->odb->path,
+	for_each_file_in_pack_dir(object_dir,
 				  clear_midx_file_ext,
 				  &data);
 
@@ -1165,7 +1165,7 @@ void clear_midx_file(struct repository *r)
 	if (remove_path(midx))
 		die(_("failed to clear multi-pack-index at %s"), midx);
 
-	clear_midx_files_ext(r, ".rev", NULL);
+	clear_midx_files_ext(r->objects->odb->path, ".rev", NULL);
 
 	free(midx);
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 9034e94c0a..e953cdd6d1 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -201,6 +201,34 @@ test_expect_success 'write midx with twelve packs' '
 
 compare_results_with_midx "twelve packs"
 
+test_expect_success 'multi-pack-index *.rev cleanup with --object-dir' '
+	git init repo &&
+	git clone -s repo alternate &&
+
+	test_when_finished "rm -rf repo alternate" &&
+
+	(
+		cd repo &&
+		test_commit base &&
+		git repack -d
+	) &&
+
+	ours="alternate/.git/objects/pack/multi-pack-index-123.rev" &&
+	theirs="repo/.git/objects/pack/multi-pack-index-abc.rev" &&
+	touch "$ours" "$theirs" &&
+
+	(
+		cd alternate &&
+		git multi-pack-index --object-dir ../repo/.git/objects write
+	) &&
+
+	# writing a midx in "repo" should not remove the .rev file in the
+	# alternate
+	test_path_is_file repo/.git/objects/pack/multi-pack-index &&
+	test_path_is_file $ours &&
+	test_path_is_missing $theirs
+'
+
 test_expect_success 'warn on improper hash version' '
 	git init --object-format=sha1 sha1 &&
 	(
-- 
2.33.0.96.g73915697e6


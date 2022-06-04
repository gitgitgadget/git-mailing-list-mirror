Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03A8C43334
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 10:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbiFDKKq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 06:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbiFDKKg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 06:10:36 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204651838C
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 03:10:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k19so13248764wrd.8
        for <git@vger.kernel.org>; Sat, 04 Jun 2022 03:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rnSZHSEn9DekNIuMNUmXumKsM9iDEucEQD1MymCA2b0=;
        b=V54g7/aTzJx83tELzhKkYQSnQRXNALRuMhhCv9t7Q07EfxffX9hJLe8AycZV7T1POG
         qXVHy/dk2yuT+fW5kTq4WWYCWiaQ8w263SnN0p/gs0fRVNquJilWcpQjj5LQHsTH7PtY
         SgRDihDTRRdzm2522+k4GPf7cJrLL4zDefm2o8IOPiFqxLy1MMynkCGWnCBZ5376XEQ8
         xJLfsmIrngA1bskwM4Ji6TO7rpgawlKqMtVhedw7lF24htsFR3qlpensXa728lW8kVA/
         l/1f2zOAvWjMdXGh22tY+WKQhq3NEV53N5vRDb5WxRxqGvnznAVtrStf7HJtis/dG56s
         KF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rnSZHSEn9DekNIuMNUmXumKsM9iDEucEQD1MymCA2b0=;
        b=miMhRJnBJ67hP4m22zpk/5ORsmfyAO5ZC9s0toS9MF6zGPBiJjESA4gxcHdil8KAb4
         53kToAkyViEWJz7Ms/oqMyCfl4FXJ7yplpe4glHvvG2Bdp/5IYSM5r4lib780/RVir2F
         skIAJGctVj9zzvnZWFQ8IpxT9ZaxLrthVvcj4KfcWrIPbGB6mFpoDJxiqKcVZELZbLA2
         HFzHU9VH9+vEKHawcB3YNygcM28EucuWXosBh7K1JFHrcvcppEXpaHT24ZIOk8tUSTv3
         cv2anToi2Gv48wsIWz6CK6mSyc7XgCkDztIcbK/BaEDwgmGUlU4GR/wnaLXhlPbMLNoT
         KFpg==
X-Gm-Message-State: AOAM530UH3TdqTgSZGhq6kkufxGYAdX6Gv1UEQXtk9p1JjcgO9SZkDfH
        vEmcl4RENcOYlayBMrc80xe1uUpk0dI8aQ==
X-Google-Smtp-Source: ABdhPJxuh0SZu1zoNM5A4nMYWnoM+LaePFgk0SEmUy8t3iXNec176UtWO6G3iiWBoonZ8cah/83nZA==
X-Received: by 2002:a5d:47cc:0:b0:20f:e246:d7d with SMTP id o12-20020a5d47cc000000b0020fe2460d7dmr12834691wrc.2.1654337433312;
        Sat, 04 Jun 2022 03:10:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i12-20020a05600c354c00b0039765a7add4sm15069631wmq.29.2022.06.04.03.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 03:10:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v13 0/7] unpack-objects: support streaming blobs to disk
Date:   Sat,  4 Jun 2022 12:10:21 +0200
Message-Id: <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1124.g52838f02905
In-Reply-To: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
References: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes "unpack-objects" capable of streaming large objects
to disk.

As 7/7 shows streaming e.g. a 100MB blob now uses ~5MB of memory
instead of ~105MB. This streaming method is slower if you've got
memory to handle the blobs in-core, but if you don't it allows you to
unpack objects at all, as you might otherwise OOM.

This series by Han Xin was originally waiting on some in-flight
patches that landed in 430883a70c7 (Merge branch
'ab/object-file-api-updates', 2022-03-16), and until yesterday with
83937e95928 (Merge branch 'ns/batch-fsync', 2022-06-03) had a textual
and semantic conflict with "master".

Changes since v12:

 * Since v12 Han Xin submitted 1/1 here as
   https://lore.kernel.org/git/cover.1653015534.git.chiyutianyi@gmail.com/;
   I think this is better off reviewed as a whole, and hopefully will
   be picked up as such.

 * Dropped the previous 7/8, which was a refactoring to make 8/8
   slightly smaller. Per dicsussion with René it's better to leave it
   out.

 * The rest (especially 2/8) is due to rebasing on ns/batch-fsync.

Han Xin (4):
  unpack-objects: low memory footprint for get_data() in dry_run mode
  object-file.c: refactor write_loose_object() to several steps
  object-file.c: add "stream_loose_object()" to handle large object
  unpack-objects: use stream_loose_object() to unpack large objects

Ævar Arnfjörð Bjarmason (3):
  object-file.c: do fsync() and close() before post-write die()
  object-file.c: factor out deflate part of write_loose_object()
  core doc: modernize core.bigFileThreshold documentation

 Documentation/config/core.txt   |  33 +++--
 builtin/unpack-objects.c        | 103 ++++++++++++--
 object-file.c                   | 237 +++++++++++++++++++++++++++-----
 object-store.h                  |   8 ++
 t/t5351-unpack-large-objects.sh |  61 ++++++++
 5 files changed, 387 insertions(+), 55 deletions(-)
 create mode 100755 t/t5351-unpack-large-objects.sh

Range-diff against v12:
1:  e95f6a1cfb6 = 1:  12873fc9915 unpack-objects: low memory footprint for get_data() in dry_run mode
2:  54060eb8c6b ! 2:  b3568f0c5c0 object-file.c: do fsync() and close() before post-write die()
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## object-file.c ##
    -@@ object-file.c: void hash_object_file(const struct git_hash_algo *algo, const void *buf,
    - 	hash_object_file_literally(algo, buf, len, type_name(type), oid);
    - }
    - 
    --/* Finalize a file on disk, and close it. */
    -+/*
    -+ * We already did a write_buffer() to the "fd", let's fsync()
    -+ * and close().
    -+ *
    -+ * Finalize a file on disk, and close it. We might still die() on a
    -+ * subsequent sanity check, but let's not add to that confusion by not
    -+ * flushing any outstanding writes to disk first.
    -+ */
    - static void close_loose_object(int fd)
    - {
    - 	if (the_repository->objects->odb->will_destroy)
     @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *hdr,
      		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
      		    ret);
      	the_hash_algo->final_oid_fn(&parano_oid, &c);
    -+	close_loose_object(fd);
    ++	close_loose_object(fd, tmp_file.buf);
     +
      	if (!oideq(oid, &parano_oid))
      		die(_("confused by unstable object source data for %s"),
      		    oid_to_hex(oid));
      
    --	close_loose_object(fd);
    +-	close_loose_object(fd, tmp_file.buf);
     -
      	if (mtime) {
      		struct utimbuf utb;
3:  3dcaa5d6589 ! 3:  9dc0f56878a object-file.c: refactor write_loose_object() to several steps
    @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *
     -		    ret);
     -	the_hash_algo->final_oid_fn(&parano_oid, &c);
     +		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid), ret);
    - 	close_loose_object(fd);
    + 	close_loose_object(fd, tmp_file.buf);
      
      	if (!oideq(oid, &parano_oid))
4:  03f4e91ac89 = 4:  a0434835fe7 object-file.c: factor out deflate part of write_loose_object()
5:  3d64cf1cf33 ! 5:  0b07b29836b object-file.c: add "stream_loose_object()" to handle large object
    @@ object-file.c: static int freshen_packed_object(const struct object_id *oid)
     +	ret = end_loose_object_common(&c, &stream, oid);
     +	if (ret != Z_OK)
     +		die(_("deflateEnd on stream object failed (%d)"), ret);
    -+	close_loose_object(fd);
    ++	close_loose_object(fd, tmp_file.buf);
     +
     +	if (freshen_packed_object(oid) || freshen_loose_object(oid)) {
     +		unlink_or_warn(tmp_file.buf);
6:  33ffcbbc1f0 = 6:  5ed79c58b18 core doc: modernize core.bigFileThreshold documentation
7:  11f7aa026b4 < -:  ----------- unpack-objects: refactor away unpack_non_delta_entry()
8:  34ee6a28a54 ! 7:  5bc8fa9bc8d unpack-objects: use stream_loose_object() to unpack large objects
    @@ Documentation/config/core.txt: usage, at the slight expense of increased disk us
      	Specifies the pathname to the file that contains patterns to
     
      ## builtin/unpack-objects.c ##
    -@@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type type,
    - 	}
    +@@ builtin/unpack-objects.c: static void unpack_non_delta_entry(enum object_type type, unsigned long size,
    + 		write_object(nr, type, buf, size);
      }
      
     +struct input_zstream_data {
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
      				void *delta_data, unsigned long delta_size)
      {
     @@ builtin/unpack-objects.c: static void unpack_one(unsigned nr)
    + 	}
      
      	switch (type) {
    - 	case OBJ_BLOB:
    ++	case OBJ_BLOB:
     +		if (!dry_run && size > big_file_threshold) {
     +			stream_blob(size, nr);
     +			return;
    @@ builtin/unpack-objects.c: static void unpack_one(unsigned nr)
     +		/* fallthrough */
      	case OBJ_COMMIT:
      	case OBJ_TREE:
    +-	case OBJ_BLOB:
      	case OBJ_TAG:
    + 		unpack_non_delta_entry(type, size, nr);
    + 		return;
     
      ## t/t5351-unpack-large-objects.sh ##
     @@ t/t5351-unpack-large-objects.sh: test_description='git unpack-objects with large objects'
-- 
2.36.1.1124.g52838f02905


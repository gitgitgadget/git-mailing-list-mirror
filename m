Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83992C433FE
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 13:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiC2N6H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 09:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237600AbiC2N6E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 09:58:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FC72220E0
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 06:56:20 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id pv16so35380841ejb.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 06:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XBWqm3tEiOrz0t4ZF3BAPkDRFzdsik2fazVmTYgyq/8=;
        b=pKWDNSJddbfGDdKO2QdqY2Dmp2dIqT4d7Sx8h883yxIHDqkFRImLlrioLUle47yr/a
         rGZHnBZVmtGQn+t+sDEoH8VFkqDcaAK4fy3rZXs2QmUXUnIayLStz7HfY3KSbpMZK7kJ
         JxFv6MZ/gLH7XkzJcC4aUBbu1aoNG+v7sSayIx0+YeZGrVqz9TzbAxP18abH03TLAWFh
         KhtR8qagATnLmO7djkOzBO9H5Y/iYeO3VdohtpH1YrQo/2794Vz4UFbGYXqlmpXJrm/3
         Qayb7nnCx5f9K5jODUTTOrJGSMgexDbJcey3rLsFOyNMb89Totih8skqCP3WdXRbidDP
         y7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XBWqm3tEiOrz0t4ZF3BAPkDRFzdsik2fazVmTYgyq/8=;
        b=PRcXDYI19/0W2Hz2mcatWfpa0xeYgXuSPe8Xxfvnr+PU8Cd7i1XW37J7eh3xBPrJ/p
         XyHfYmNO13U8Z96eUcrZHmHzt66rA+sR7nooYlYnSEf2P21VDpd8VlD7kvowuBt7Jf9L
         8Q5zisJlGJZLUJsCLxYUXAUA8P0T5fmsBoG1004PvT4OwcgmXipZRXmfRH4jU4ge6doB
         R3fXyJDfjf3s6tjDylP5JlZVemB2TsCVk8KZxc7CtwhrURExj+O7lsxtyMRgHxkJO627
         T92sEU/1vpmuule7F2V3580lSWn2b0Vnckq7OGHfWFLRcllYxp1IP73tquNOaT+LopiL
         V5bg==
X-Gm-Message-State: AOAM531tBHD5JxJ2iW7mujoHLttejCoNVCjtzftchquc/fZZoYWuMkT/
        VnyUtbURhSFWXyia6ehmwN7oIVYSbPpZoQ==
X-Google-Smtp-Source: ABdhPJx19EQIa9woo9mUomTTRBp2t+xDQj2b9zVrE8G2PTwSR+2Z1mcoKHY3EDChCYOFOfDgQTs6Dw==
X-Received: by 2002:a17:907:7e96:b0:6da:f7ee:4a25 with SMTP id qb22-20020a1709077e9600b006daf7ee4a25mr34086525ejc.436.1648562178600;
        Tue, 29 Mar 2022 06:56:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ds5-20020a170907724500b006df8f39dadesm7006601ejc.218.2022.03.29.06.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 06:56:18 -0700 (PDT)
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
Subject: [PATCH v12 0/8] unpack-objects: support streaming blobs to disk
Date:   Tue, 29 Mar 2022 15:56:05 +0200
Message-Id: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1548.g36973b18e52
In-Reply-To: <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com>
References: <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series by Han Xin was waiting on some in-flight patches that
landed in 430883a70c7 (Merge branch 'ab/object-file-api-updates',
2022-03-16).

This series teaches "git unpack-objects" to stream objects larger than
core.bigFileThreshold to disk. As 8/8 shows streaming e.g. a 100MB
blob now uses ~5MB of memory instead of ~105MB. This streaming method
is slower if you've got memory to handle the blobs in-core, but if you
don't it allows you to unpack objects at all, as you might otherwise
OOM.

Changes since v10[1]:

 * René rightly spotted that the end_loose_object_common() function
   was feeding NULL to a format. That's now fixed, and parts of that
   function were pulled out into the two callers to make the trade-off
   of factoring that logic out worth it.

 * This topic conflicts with ns/batch-fsync in "seen" (see below). I
   moved an inline comment on close_loose_object() around to make the
   conflict easier (and it's better placed with the function anyway,
   as we'll get two callers of it).

Conflict this is the --remerge-diff with "seen" after resolving the
conflict. Botht textual and semantic (there's a new caller in this
topic) conflicts are caught by the compiler:

	diff --git a/object-file.c b/object-file.c
	remerge CONFLICT (content): Merge conflict in object-file.c
	index 9c640f1f39d..6068f8ec6c4 100644
	--- a/object-file.c
	+++ b/object-file.c
	@@ -1887,7 +1887,6 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
	 	hash_object_file_literally(algo, buf, len, type_name(type), oid);
	 }

	-<<<<<<< 34ee6a28a54 (unpack-objects: use stream_loose_object() to unpack large objects)
	 /*
	  * We already did a write_buffer() to the "fd", let's fsync()
	  * and close().
	@@ -1896,11 +1895,7 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
	  * subsequent sanity check, but let's not add to that confusion by not
	  * flushing any outstanding writes to disk first.
	  */
	-static void close_loose_object(int fd)
	-=======
	-/* Finalize a file on disk, and close it. */
	 static void close_loose_object(int fd, const char *filename)
	->>>>>>> b1423c89b5a (Merge branch 'ab/reftable-aix-xlc-12' into seen)
	 {
	 	if (the_repository->objects->odb->will_destroy)
	 		goto out;
	@@ -2093,17 +2088,12 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
	 	ret = end_loose_object_common(&c, &stream, &parano_oid);
	 	if (ret != Z_OK)
	 		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid), ret);
	-	close_loose_object(fd);
	+	close_loose_object(fd, tmp_file.buf);

	 	if (!oideq(oid, &parano_oid))
	 		die(_("confused by unstable object source data for %s"),
	 		    oid_to_hex(oid));

	-<<<<<<< 34ee6a28a54 (unpack-objects: use stream_loose_object() to unpack large objects)
	-=======
	-	close_loose_object(fd, tmp_file.buf);
	-
	->>>>>>> b1423c89b5a (Merge branch 'ab/reftable-aix-xlc-12' into seen)
	 	if (mtime) {
	 		struct utimbuf utb;
	 		utb.actime = mtime;
	@@ -2206,7 +2196,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
	 	ret = end_loose_object_common(&c, &stream, oid);
	 	if (ret != Z_OK)
	 		die(_("deflateEnd on stream object failed (%d)"), ret);
	-	close_loose_object(fd);
	+	close_loose_object(fd, tmp_file.buf);

	 	if (freshen_packed_object(oid) || freshen_loose_object(oid)) {
	 		unlink_or_warn(tmp_file.buf);

1. https://lore.kernel.org/git/cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com/

Han Xin (4):
  unpack-objects: low memory footprint for get_data() in dry_run mode
  object-file.c: refactor write_loose_object() to several steps
  object-file.c: add "stream_loose_object()" to handle large object
  unpack-objects: use stream_loose_object() to unpack large objects

Ævar Arnfjörð Bjarmason (4):
  object-file.c: do fsync() and close() before post-write die()
  object-file.c: factor out deflate part of write_loose_object()
  core doc: modernize core.bigFileThreshold documentation
  unpack-objects: refactor away unpack_non_delta_entry()

 Documentation/config/core.txt   |  33 +++--
 builtin/unpack-objects.c        | 109 +++++++++++---
 object-file.c                   | 246 +++++++++++++++++++++++++++-----
 object-store.h                  |   8 ++
 t/t5351-unpack-large-objects.sh |  61 ++++++++
 5 files changed, 396 insertions(+), 61 deletions(-)
 create mode 100755 t/t5351-unpack-large-objects.sh

Range-diff against v11:
1:  2103d5bfd96 = 1:  e95f6a1cfb6 unpack-objects: low memory footprint for get_data() in dry_run mode
2:  6acd8759772 ! 2:  54060eb8c6b object-file.c: do fsync() and close() before post-write die()
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## object-file.c ##
    +@@ object-file.c: void hash_object_file(const struct git_hash_algo *algo, const void *buf,
    + 	hash_object_file_literally(algo, buf, len, type_name(type), oid);
    + }
    + 
    +-/* Finalize a file on disk, and close it. */
    ++/*
    ++ * We already did a write_buffer() to the "fd", let's fsync()
    ++ * and close().
    ++ *
    ++ * Finalize a file on disk, and close it. We might still die() on a
    ++ * subsequent sanity check, but let's not add to that confusion by not
    ++ * flushing any outstanding writes to disk first.
    ++ */
    + static void close_loose_object(int fd)
    + {
    + 	if (the_repository->objects->odb->will_destroy)
     @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *hdr,
      		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
      		    ret);
      	the_hash_algo->final_oid_fn(&parano_oid, &c);
    -+
    -+	/*
    -+	 * We already did a write_buffer() to the "fd", let's fsync()
    -+	 * and close().
    -+	 *
    -+	 * We might still die() on a subsequent sanity check, but
    -+	 * let's not add to that confusion by not flushing any
    -+	 * outstanding writes to disk first.
    -+	 */
     +	close_loose_object(fd);
     +
      	if (!oideq(oid, &parano_oid))
3:  f7b02c307fc ! 3:  3dcaa5d6589 object-file.c: refactor write_loose_object() to several steps
    @@ object-file.c: static int create_tmpfile(struct strbuf *tmp, const char *filenam
     + * Common steps for loose object writers to end writing loose objects:
     + *
     + * - End the compression of zlib stream.
    -+ * - Get the calculated oid to "parano_oid".
    ++ * - Get the calculated oid to "oid".
     + * - fsync() and close() the "fd"
     + */
    -+static void end_loose_object_common(int fd, int ret, git_hash_ctx *c,
    -+				    git_zstream *stream,
    -+				    struct object_id *parano_oid,
    -+				    const struct object_id *expected_oid,
    -+				    const char *die_msg1_fmt,
    -+				    const char *die_msg2_fmt)
    ++static int end_loose_object_common(git_hash_ctx *c, git_zstream *stream,
    ++				   struct object_id *oid)
     +{
    -+	if (ret != Z_STREAM_END)
    -+		die(_(die_msg1_fmt), ret, expected_oid);
    ++	int ret;
    ++
     +	ret = git_deflate_end_gently(stream);
     +	if (ret != Z_OK)
    -+		die(_(die_msg2_fmt), ret, expected_oid);
    -+	the_hash_algo->final_oid_fn(parano_oid, c);
    ++		return ret;
    ++	the_hash_algo->final_oid_fn(oid, c);
     +
    -+	/*
    -+	 * We already did a write_buffer() to the "fd", let's fsync()
    -+	 * and close().
    -+	 *
    -+	 * We might still die() on a subsequent sanity check, but
    -+	 * let's not add to that confusion by not flushing any
    -+	 * outstanding writes to disk first.
    -+	 */
    -+	close_loose_object(fd);
    ++	return Z_OK;
     +}
     +
      static int write_loose_object(const struct object_id *oid, char *hdr,
    @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *
      	/* Then the data itself.. */
      	stream.next_in = (void *)buf;
     @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *hdr,
    - 		stream.avail_out = sizeof(compressed);
    - 	} while (ret == Z_OK);
    - 
    --	if (ret != Z_STREAM_END)
    --		die(_("unable to deflate new object %s (%d)"), oid_to_hex(oid),
    --		    ret);
    + 	if (ret != Z_STREAM_END)
    + 		die(_("unable to deflate new object %s (%d)"), oid_to_hex(oid),
    + 		    ret);
     -	ret = git_deflate_end_gently(&stream);
    --	if (ret != Z_OK)
    ++	ret = end_loose_object_common(&c, &stream, &parano_oid);
    + 	if (ret != Z_OK)
     -		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
     -		    ret);
     -	the_hash_algo->final_oid_fn(&parano_oid, &c);
    --
    --	/*
    --	 * We already did a write_buffer() to the "fd", let's fsync()
    --	 * and close().
    --	 *
    --	 * We might still die() on a subsequent sanity check, but
    --	 * let's not add to that confusion by not flushing any
    --	 * outstanding writes to disk first.
    --	 */
    --	close_loose_object(fd);
    -+	end_loose_object_common(fd, ret, &c, &stream, &parano_oid, oid,
    -+				N_("unable to deflate new object %s (%d)"),
    -+				N_("deflateEnd on object %s failed (%d)"));
    ++		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid), ret);
    + 	close_loose_object(fd);
      
      	if (!oideq(oid, &parano_oid))
    - 		die(_("confused by unstable object source data for %s"),
4:  20d97cc2605 ! 4:  03f4e91ac89 object-file.c: factor out deflate part of write_loose_object()
    @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *
     +						compressed, sizeof(compressed));
      	} while (ret == Z_OK);
      
    - 	end_loose_object_common(fd, ret, &c, &stream, &parano_oid, oid,
    + 	if (ret != Z_STREAM_END)
5:  db40f4160c4 ! 5:  3d64cf1cf33 object-file.c: add "stream_loose_object()" to handle large object
    @@ object-file.c: static int freshen_packed_object(const struct object_id *oid)
     +	 *  - End the compression of zlib stream.
     +	 *  - Get the calculated oid.
     +	 */
    -+	end_loose_object_common(fd, ret, &c, &stream, oid, NULL,
    -+				N_("unable to stream deflate new object (%d)"),
    -+				N_("deflateEnd on stream object failed (%d)"));
    ++	if (ret != Z_STREAM_END)
    ++		die(_("unable to stream deflate new object (%d)"), ret);
    ++	ret = end_loose_object_common(&c, &stream, oid);
    ++	if (ret != Z_OK)
    ++		die(_("deflateEnd on stream object failed (%d)"), ret);
    ++	close_loose_object(fd);
     +
     +	if (freshen_packed_object(oid) || freshen_loose_object(oid)) {
     +		unlink_or_warn(tmp_file.buf);
6:  d8ae2eadb98 = 6:  33ffcbbc1f0 core doc: modernize core.bigFileThreshold documentation
7:  2b403e7cd9c = 7:  11f7aa026b4 unpack-objects: refactor away unpack_non_delta_entry()
8:  5eded902496 = 8:  34ee6a28a54 unpack-objects: use stream_loose_object() to unpack large objects
-- 
2.35.1.1548.g36973b18e52


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D84C433FE
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 11:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiATLWt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 06:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiATLWo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 06:22:44 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA891C06175C
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 03:22:26 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id l7so2090181pls.6
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 03:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SL2mAPi7zFkRapaaLFpFIfv/H5k/Rg/AzMozApSPT8k=;
        b=WzjzWWFRWnDYsIJzFDru24SqO7EcfGuuCDGU9DNf5FNHYTa8m5W9hcGu5c1rysE8hh
         xAIO52f6EjUYWr9/ZhBK+gExX6LGZW8EjalXvrRbvD90FeuP6TVOsNZQNqWDgTN2sM21
         blK7nmAOu/WlBDIRMfJB3ce7tTiW0B2NIFHeIYstj0ZYrzpuyg3Eg8Q6tXmD20DlPgBj
         Zu2J25UR6eqINMTD8bZ54UtELnAcrngHxybs3DIHrTqAnwI5W0KP/Bk8KpkTDowIZQnx
         V9fi/aJGhne/GJXgHYVm+GisnG9CjPPHBRk+J6Y+kblLZxv4BxUiM1a+NpPBFa/R1v2H
         ba3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SL2mAPi7zFkRapaaLFpFIfv/H5k/Rg/AzMozApSPT8k=;
        b=utaXo2k78vgwkIAye4kk7XM+pDVIdoXNdPkJAXDSdTG0SvX9rgYiGLaKMmgnDxyjZU
         QUQ4ShZ3FXqCCPHRP2hKF3MQFguGT2+FDSlkc76HtJfJogVr+qQVyHWXLuWEuJAGujgr
         OT0cP19KYEReS6EjjYFzHPK15RuVZIfcO63yauwK3l8bb+STR9MlwA+YkB9+TOaA4In1
         VVJNu29cWOPvrG9+BXUAt9F2GZ8wk5utx1AiuT8sLWyYj4Jf4ps/aIW0cH46zg5WyfWb
         ufN/6bSGjx8bdDYTldjVsM5e9gf437M0cn0jNtGv4L46jLp4GpuUJs/+RpMm1b0bmDCS
         x2mg==
X-Gm-Message-State: AOAM533GTzstXpWpEN7j59cS+12eF1cWHJ/IqggUV40vyGqqD0w/f4Qa
        R+f73oIf4Nw0ffDt/s/l2+o=
X-Google-Smtp-Source: ABdhPJy4tavOIh4VpVO8A/ulLq4Qs+E6JNx7ct5aGO2TlIN+8zQusvY9fjqAAOOzRoluDeOAaKyjaw==
X-Received: by 2002:a17:90a:7604:: with SMTP id s4mr10199778pjk.69.1642677745996;
        Thu, 20 Jan 2022 03:22:25 -0800 (PST)
Received: from localhost.localdomain ([58.100.34.57])
        by smtp.gmail.com with ESMTPSA id x18sm2998989pfh.192.2022.01.20.03.22.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jan 2022 03:22:25 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jiang Xin <worldhello.net@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v9 0/5] unpack large blobs in stream
Date:   Thu, 20 Jan 2022 19:21:09 +0800
Message-Id: <20220120112114.47618-1-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.1.52.gc288e771b4.agit.6.5.6
In-Reply-To: <20220108085419.79682-1-chiyutianyi@gmail.com>
References: <20220108085419.79682-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

Changes since v8:
* Rename "assert_no_loose ()" into "test_no_loose ()" in
  "t5329-unpack-large-objects.sh". Remove "assert_no_pack ()" and use
  "test_dir_is_empty" instead.

* Revert changes to "create_tmpfile()" and error handling is now in
  "start_loose_object_common()".

* Remove "finalize_object_file_with_mtime()" which seems to be an overkill
  for "write_loose_object()" now. 

* Remove the commit "object-file.c: remove the slash for directory_size()",
  it can be in a separate patch if necessary.

Han Xin (4):
  unpack-objects: low memory footprint for get_data() in dry_run mode
  object-file.c: refactor write_loose_object() to several steps
  object-file.c: add "stream_loose_object()" to handle large object
  unpack-objects: unpack_non_delta_entry() read data in a stream

Ævar Arnfjörð Bjarmason (1):
  object-file API: add a format_object_header() function

 builtin/index-pack.c            |   3 +-
 builtin/unpack-objects.c        | 110 ++++++++++++++--
 bulk-checkin.c                  |   4 +-
 cache.h                         |  21 +++
 http-push.c                     |   2 +-
 object-file.c                   | 220 +++++++++++++++++++++++++++-----
 object-store.h                  |   9 ++
 t/t5328-unpack-large-objects.sh |  65 ++++++++++
 8 files changed, 384 insertions(+), 50 deletions(-)
 create mode 100755 t/t5328-unpack-large-objects.sh

Range-diff against v8:
1:  bd34da5816 ! 1:  6a6c11ba93 unpack-objects: low memory footprint for get_data() in dry_run mode
    @@ builtin/unpack-objects.c: static void unpack_delta_entry(enum object_type type,
      		hi = nr;
      		while (lo < hi) {
     
    - ## t/t5329-unpack-large-objects.sh (new) ##
    + ## t/t5328-unpack-large-objects.sh (new) ##
     @@
     +#!/bin/sh
     +#
    -+# Copyright (c) 2021 Han Xin
    ++# Copyright (c) 2022 Han Xin
     +#
     +
     +test_description='git unpack-objects with large objects'
    @@ t/t5329-unpack-large-objects.sh (new)
     +	git init --bare dest.git
     +}
     +
    -+assert_no_loose () {
    ++test_no_loose () {
     +	glob=dest.git/objects/?? &&
     +	echo "$glob" >expect &&
     +	eval "echo $glob" >actual &&
     +	test_cmp expect actual
     +}
     +
    -+assert_no_pack () {
    -+	rmdir dest.git/objects/pack
    -+}
    -+
     +test_expect_success "create large objects (1.5 MB) and PACK" '
     +	test-tool genrandom foo 1500000 >big-blob &&
     +	test_commit --append foo big-blob &&
    @@ t/t5329-unpack-large-objects.sh (new)
     +test_expect_success 'unpack-objects works with memory limitation in dry-run mode' '
     +	prepare_dest &&
     +	git -C dest.git unpack-objects -n <test-$PACK.pack &&
    -+	assert_no_loose &&
    -+	assert_no_pack
    ++	test_no_loose &&
    ++	test_dir_is_empty dest.git/objects/pack
     +'
     +
     +test_done
2:  f9a4365a7d ! 2:  bab9e0402f object-file.c: refactor write_loose_object() to several steps
    @@ Commit message
         Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
     
      ## object-file.c ##
    -@@ object-file.c: static void write_object_file_prepare(const struct git_hash_algo *algo,
    - 	algo->final_oid_fn(oid, &c);
    - }
    - 
    -+/*
    -+ * Move the just written object with proper mtime into its final resting place.
    -+ */
    -+static int finalize_object_file_with_mtime(const char *tmpfile,
    -+					   const char *filename,
    -+					   time_t mtime,
    -+					   unsigned flags)
    -+{
    -+	struct utimbuf utb;
    -+
    -+	if (mtime) {
    -+		utb.actime = mtime;
    -+		utb.modtime = mtime;
    -+		if (utime(tmpfile, &utb) < 0 && !(flags & HASH_SILENT))
    -+			warning_errno(_("failed utime() on %s"), tmpfile);
    -+	}
    -+	return finalize_object_file(tmpfile, filename);
    -+}
    -+
    - /*
    -  * Move the just written object into its final resting place.
    -  */
    -@@ object-file.c: static inline int directory_size(const char *filename)
    -  * We want to avoid cross-directory filename renames, because those
    -  * can have problems on various filesystems (FAT, NFS, Coda).
    -  */
    --static int create_tmpfile(struct strbuf *tmp, const char *filename)
    -+static int create_tmpfile(struct strbuf *tmp, const char *filename,
    -+			  unsigned flags)
    - {
    - 	int fd, dirlen = directory_size(filename);
    - 
    -@@ object-file.c: static int create_tmpfile(struct strbuf *tmp, const char *filename)
    - 	strbuf_add(tmp, filename, dirlen);
    - 	strbuf_addstr(tmp, "tmp_obj_XXXXXX");
    - 	fd = git_mkstemp_mode(tmp->buf, 0444);
    --	if (fd < 0 && dirlen && errno == ENOENT) {
    -+	do {
    -+		if (fd >= 0 || !dirlen || errno != ENOENT)
    -+			break;
    - 		/*
    - 		 * Make sure the directory exists; note that the contents
    - 		 * of the buffer are undefined after mkstemp returns an
     @@ object-file.c: static int create_tmpfile(struct strbuf *tmp, const char *filename)
    - 		strbuf_reset(tmp);
    - 		strbuf_add(tmp, filename, dirlen - 1);
    - 		if (mkdir(tmp->buf, 0777) && errno != EEXIST)
    --			return -1;
    -+			break;
    - 		if (adjust_shared_perm(tmp->buf))
    --			return -1;
    -+			break;
    - 
    - 		/* Try again */
    - 		strbuf_addstr(tmp, "/tmp_obj_XXXXXX");
    - 		fd = git_mkstemp_mode(tmp->buf, 0444);
    -+	} while (0);
    -+
    -+	if (fd < 0 && !(flags & HASH_SILENT)) {
    -+		if (errno == EACCES)
    -+			return error(_("insufficient permission for adding an "
    -+				       "object to repository database %s"),
    -+				     get_object_directory());
    -+		else
    -+			return error_errno(_("unable to create temporary file"));
    - 	}
    -+
      	return fd;
      }
      
    @@ object-file.c: static int create_tmpfile(struct strbuf *tmp, const char *filenam
     +				     git_zstream *stream,
     +				     unsigned char *buf, size_t buflen,
     +				     git_hash_ctx *c,
    -+				     enum object_type type, size_t len,
     +				     char *hdr, int hdrlen)
     +{
     +	int fd;
     +
    -+	fd = create_tmpfile(tmp_file, filename, flags);
    -+	if (fd < 0)
    -+		return -1;
    ++	fd = create_tmpfile(tmp_file, filename);
    ++	if (fd < 0) {
    ++		if (flags & HASH_SILENT)
    ++			return -1;
    ++		else if (errno == EACCES)
    ++			return error(_("insufficient permission for adding "
    ++				       "an object to repository database %s"),
    ++				     get_object_directory());
    ++		else
    ++			return error_errno(
    ++				_("unable to create temporary file"));
    ++	}
     +
     +	/*  Setup zlib stream for compression */
     +	git_deflate_init(stream, zlib_compression_level);
    @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *
     +	 */
     +	fd = start_loose_object_common(&tmp_file, filename.buf, flags,
     +				       &stream, compressed, sizeof(compressed),
    -+				       &c, OBJ_NONE, 0, hdr, hdrlen);
    ++				       &c, hdr, hdrlen);
     +	if (fd < 0)
     +		return -1;
      
    @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *
      	if (!oideq(oid, &parano_oid))
      		die(_("confused by unstable object source data for %s"),
      		    oid_to_hex(oid));
    - 
    - 	close_loose_object(fd);
    - 
    --	if (mtime) {
    --		struct utimbuf utb;
    --		utb.actime = mtime;
    --		utb.modtime = mtime;
    --		if (utime(tmp_file.buf, &utb) < 0 &&
    --		    !(flags & HASH_SILENT))
    --			warning_errno(_("failed utime() on %s"), tmp_file.buf);
    --	}
    --
    --	return finalize_object_file(tmp_file.buf, filename.buf);
    -+	return finalize_object_file_with_mtime(tmp_file.buf, filename.buf,
    -+					       mtime, flags);
    - }
    - 
    - static int freshen_loose_object(const struct object_id *oid)
3:  18dd21122d < -:  ---------- object-file.c: remove the slash for directory_size()
4:  964715451b ! 3:  dd13614985 object-file.c: add "stream_loose_object()" to handle large object
    @@ object-file.c: static int freshen_packed_object(const struct object_id *oid)
     +	 */
     +	fd = start_loose_object_common(&tmp_file, filename.buf, 0,
     +				       &stream, compressed, sizeof(compressed),
    -+				       &c, OBJ_BLOB, len, hdr, hdrlen);
    ++				       &c, hdr, hdrlen);
     +	if (fd < 0) {
     +		err = -1;
     +		goto cleanup;
5:  3f620466fe ! 4:  cd84e27b08 unpack-objects: unpack_non_delta_entry() read data in a stream
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
      		write_object(nr, type, buf, size);
      }
     
    - ## t/t5329-unpack-large-objects.sh ##
    -@@ t/t5329-unpack-large-objects.sh: test_description='git unpack-objects with large objects'
    + ## t/t5328-unpack-large-objects.sh ##
    +@@ t/t5328-unpack-large-objects.sh: test_description='git unpack-objects with large objects'
      
      prepare_dest () {
      	test_when_finished "rm -rf dest.git" &&
    @@ t/t5329-unpack-large-objects.sh: test_description='git unpack-objects with large
     +	fi
      }
      
    - assert_no_loose () {
    -@@ t/t5329-unpack-large-objects.sh: test_expect_success 'set memory limitation to 1MB' '
    + test_no_loose () {
    +@@ t/t5328-unpack-large-objects.sh: test_expect_success 'set memory limitation to 1MB' '
      '
      
      test_expect_success 'unpack-objects failed under memory limitation' '
    @@ t/t5329-unpack-large-objects.sh: test_expect_success 'set memory limitation to 1
     -	prepare_dest &&
     +	prepare_dest 2m &&
      	git -C dest.git unpack-objects -n <test-$PACK.pack &&
    - 	assert_no_loose &&
    - 	assert_no_pack
    + 	test_no_loose &&
    + 	test_dir_is_empty dest.git/objects/pack
      '
      
     +test_expect_success 'unpack big object in stream' '
     +	prepare_dest 1m &&
     +	git -C dest.git unpack-objects <test-$PACK.pack &&
    -+	assert_no_pack
    ++	test_dir_is_empty dest.git/objects/pack
     +'
     +
     +test_expect_success 'do not unpack existing large objects' '
     +	prepare_dest 1m &&
     +	git -C dest.git index-pack --stdin <test-$PACK.pack &&
     +	git -C dest.git unpack-objects <test-$PACK.pack &&
    -+	assert_no_loose
    ++	test_no_loose
     +'
     +
      test_done
6:  8073a3888d = 5:  59f0ad95c7 object-file API: add a format_object_header() function
-- 
2.34.1.52.gc288e771b4.agit.6.5.6


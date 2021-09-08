Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCECC433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07CC6610F8
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbhIHAjl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 20:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhIHAjj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 20:39:39 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE28C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 17:38:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q26so569758wrc.7
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 17:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q1pwQ1K2zKJIAVLFuEs6AAwHdHTrXYwBjqLKU8auoTU=;
        b=abbhszblH/eXl9ideLMgQDbYN22/F/AEQiXAZN3QU6a07Lg4Yes5CZSmQYHCTx3G2J
         DhadjSSVVgyX45MaBdYcyortRnX/Ccw8FqEmZZrwr3eskuWHfXuNSzfY4EYXPC6vILs1
         tJtsx6HfEW+qcVTr0RElwCL0Q2G9QLJKx8ZaZHW0iuMr+KInTfC52LLHDVgd3OHYFiZz
         YXbpHpRJ0t3ybRYGDTpr6ZavBNWMnMfW++Bfn7FpM/BcZPRjwgMSS00XEAw2xKcxNhnO
         L6CFvY88xsxwXVA+QUhKjRGsjR64hSMp2drLg035TlXPCaSnBprI5RuY9GpSsFqKbSdr
         +PqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q1pwQ1K2zKJIAVLFuEs6AAwHdHTrXYwBjqLKU8auoTU=;
        b=Y/cn51mpiqT1G3QeMiwIP7E44iL056tA6mzVpViXIuF3M0SAUkxLYIC0swT4Xv3I/I
         DaIhijPMOYzeWm6i6McWN73sAh10douvGZ1cDmG217MG7abiJv4nc20618BJU+RgND0D
         mUHN+ZGTvatSKtemPp2aDUbUhPEubcycL0RkJsXr562DfTqhPd0pf9xxJ7NuIM30wxB9
         uIXqNypelXtx71dINwBZrCr5Zpo7MA9fqR6met3fQxvm/RsfMg06ANZe5m+zIHqRGWq6
         Awmi8nWiahcvZNj0absBE20fhcLDf4fkFNJ+QJRANfis1D4ACPqbNYo5w3S9i0gySrm5
         2xHA==
X-Gm-Message-State: AOAM532QP4Ejq5IgisSWABFdGcZdEuZWu3hSQe/qrkTVtF/XePTKweaX
        DF6Q7/6oJih1gCUib04zoaIVTO+/WIWOEw==
X-Google-Smtp-Source: ABdhPJxM8vdmJ2jrpw46cLw3hPQv+AIY6vAJeSFfAvJGcc6Icj6w8FOM2ybLlti5sw0SZMbQRNgqaQ==
X-Received: by 2002:a5d:6dd0:: with SMTP id d16mr911482wrz.177.1631061510496;
        Tue, 07 Sep 2021 17:38:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm548962wmf.4.2021.09.07.17.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 17:38:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/4] rename *.idx file into place last (also after *.bitmap)
Date:   Wed,  8 Sep 2021 02:38:24 +0200
Message-Id: <cover-v2-0.4-0000000000-20210908T003631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.819.gea1b153a43c
In-Reply-To: <cover.1630461918.git.me@ttaylorr.com>
References: <cover.1630461918.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I came up with this on top of Taylor's series which fixes the order in
which we write files associated with pack files[1]. His series fixes a
race where we write *.idx before *.rev, but left the issue of writing
*.bitmap after *.idx, this series fixes that. Now we'll really write
the *.idx last.

This v2 attempts to fix the comments Taylor had on v1, in particular I
think the borderline readability improvements in v1 are now pretty
unambiguously more readable in 2/4 of this series. I also converted
the bulk-checkin.c caller, split up the wrapping change in pack.h into
its own commit etc.

1. https://lore.kernel.org/git/cover.1630461918.git.me@ttaylorr.com/ [1]

Ævar Arnfjörð Bjarmason (4):
  pack.h: line-wrap the definition of finish_tmp_packfile()
  pack-write: refactor renaming in finish_tmp_packfile()
  pack-write: split up finish_tmp_packfile() function
  pack-write: rename *.idx file into place last (really!)

 builtin/pack-objects.c | 16 +++++++++---
 bulk-checkin.c         | 16 ++++++++++++
 pack-write.c           | 59 +++++++++++++++++++++---------------------
 pack.h                 | 10 ++++++-
 4 files changed, 67 insertions(+), 34 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  29f5787651 pack.h: line-wrap the definition of finish_tmp_packfile()
1:  0e6ef07ce0 ! 2:  7b39f4599b pack-write: use more idiomatic strbuf usage for packname construction
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    pack-write: use more idiomatic strbuf usage for packname construction
    +    pack-write: refactor renaming in finish_tmp_packfile()
     
    -    Change code added in 5889271114a (finish_tmp_packfile():use strbuf for
    -    pathname construction, 2014-03-03) to do strbuf_reset() instead of
    -    noting the length of the base template, and doing a strbuf_setlen() to
    -    reset it, also change the spacing in the finish_tmp_packfile() so that
    -    each setup of the template, rename, and strbuf_reset() is grouped
    -    together.
    +    Refactor the renaming in finish_tmp_packfile() so that it takes a
    +    "const struct strbuf *" instead of a non-const, and refactor the
    +    repetitive renaming pattern in finish_tmp_packfile() to use a new
    +    static rename_tmp_packfile() helper function.
     
    -    Since the prototype of the previous "name_buffer" now has a "const"
    -    use this chance to wrap the overly long definition of the
    -    finish_tmp_packfile() function.
    +    The previous strbuf_reset() idiom originated with
    +    5889271114a (finish_tmp_packfile():use strbuf for pathname
    +    construction, 2014-03-03), which in turn was a minimal adjustment of
    +    pre-strbuf code added in 0e990530ae (finish_tmp_packfile(): a helper
    +    function, 2011-10-28).
     
    -    This doesn't really matter for now, but as we'll see makes the
    -    subsequent change much easier, as we won't need to juggle the basename
    -    template v.s. its current contents anymore when writing bitmaps.
    +    Since the memory allocation is not a bottleneck here we can afford a
    +    bit more readability at the cost of re-allocating this new "struct
    +    strbuf sb".
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/pack-objects.c ##
     @@ builtin/pack-objects.c: static void write_pack_file(void)
    - 
    - 		if (!pack_to_stdout) {
    - 			struct stat st;
    --			struct strbuf tmpname = STRBUF_INIT;
    -+			struct strbuf tmp_basename = STRBUF_INIT;
    - 
    - 			/*
    - 			 * Packs are runtime accessed in their mtime
    -@@ builtin/pack-objects.c: static void write_pack_file(void)
    - 					warning_errno(_("failed utime() on %s"), pack_tmp_name);
    - 			}
    - 
    --			strbuf_addf(&tmpname, "%s-", base_name);
    -+			strbuf_addf(&tmp_basename, "%s-", base_name);
    - 
    - 			if (write_bitmap_index) {
    - 				bitmap_writer_set_checksum(hash);
    -@@ builtin/pack-objects.c: static void write_pack_file(void)
    - 					&to_pack, written_list, nr_written);
    - 			}
    - 
    --			finish_tmp_packfile(&tmpname, pack_tmp_name,
    -+			finish_tmp_packfile(&tmp_basename, pack_tmp_name,
    - 					    written_list, nr_written,
      					    &pack_idx_opts, hash);
      
      			if (write_bitmap_index) {
     -				strbuf_addf(&tmpname, "%s.bitmap", hash_to_hex(hash));
     +				struct strbuf sb = STRBUF_INIT;
     +
    -+				strbuf_addf(&sb, "%s%s.bitmap",
    -+					    tmp_basename.buf,
    ++				strbuf_addf(&sb, "%s%s.bitmap", tmpname.buf,
     +					    hash_to_hex(hash));
      
      				stop_progress(&progress_state);
    @@ builtin/pack-objects.c: static void write_pack_file(void)
     +				strbuf_release(&sb);
      			}
      
    --			strbuf_release(&tmpname);
    -+			strbuf_release(&tmp_basename);
    - 			free(pack_tmp_name);
    - 			puts(hash_to_hex(hash));
    - 		}
    + 			strbuf_release(&tmpname);
     
      ## pack-write.c ##
     @@ pack-write.c: struct hashfile *create_tmp_packfile(char **pack_tmp_name)
    @@ pack-write.c: struct hashfile *create_tmp_packfile(char **pack_tmp_name)
      }
      
     -void finish_tmp_packfile(struct strbuf *name_buffer,
    -+void finish_tmp_packfile(const struct strbuf *tmp_basename,
    ++static void rename_tmp_packfile(const char *source,
    ++				 const struct strbuf *basename,
    ++				 const unsigned char hash[],
    ++				 const char *ext)
    ++{
    ++	struct strbuf sb = STRBUF_INIT;
    ++
    ++	strbuf_addf(&sb, "%s%s.%s", basename->buf, hash_to_hex(hash), ext);
    ++	if (rename(source, sb.buf))
    ++		die_errno("unable to rename temporary '*.%s' file to '%s'",
    ++			  ext, sb.buf);
    ++	strbuf_release(&sb);
    ++}
    ++
    ++void finish_tmp_packfile(const struct strbuf *basename,
      			 const char *pack_tmp_name,
      			 struct pack_idx_entry **written_list,
      			 uint32_t nr_written,
    - 			 struct pack_idx_option *pack_idx_opts,
    +@@ pack-write.c: void finish_tmp_packfile(struct strbuf *name_buffer,
      			 unsigned char hash[])
      {
    -+	struct strbuf sb = STRBUF_INIT;
      	const char *idx_tmp_name, *rev_tmp_name = NULL;
     -	int basename_len = name_buffer->len;
      
    @@ pack-write.c: void finish_tmp_packfile(struct strbuf *name_buffer,
     -	strbuf_addf(name_buffer, "%s.pack", hash_to_hex(hash));
     -
     -	if (rename(pack_tmp_name, name_buffer->buf))
    -+	strbuf_addf(&sb, "%s%s.pack", tmp_basename->buf, hash_to_hex(hash));
    -+	if (rename(pack_tmp_name, sb.buf))
    - 		die_errno("unable to rename temporary pack file");
    +-		die_errno("unable to rename temporary pack file");
     -
     -	strbuf_setlen(name_buffer, basename_len);
    -+	strbuf_reset(&sb);
    - 
    - 	if (rev_tmp_name) {
    +-
    +-	if (rev_tmp_name) {
     -		strbuf_addf(name_buffer, "%s.rev", hash_to_hex(hash));
     -		if (rename(rev_tmp_name, name_buffer->buf))
    -+		strbuf_addf(&sb, "%s%s.rev", tmp_basename->buf,
    -+			    hash_to_hex(hash));
    -+		if (rename(rev_tmp_name, sb.buf))
    - 			die_errno("unable to rename temporary reverse-index file");
    +-			die_errno("unable to rename temporary reverse-index file");
     -
     -		strbuf_setlen(name_buffer, basename_len);
    -+		strbuf_reset(&sb);
    - 	}
    - 
    +-	}
    +-
     -	strbuf_addf(name_buffer, "%s.idx", hash_to_hex(hash));
     -	if (rename(idx_tmp_name, name_buffer->buf))
    -+	strbuf_addf(&sb, "%s%s.idx", tmp_basename->buf, hash_to_hex(hash));
    -+	if (rename(idx_tmp_name, sb.buf))
    - 		die_errno("unable to rename temporary index file");
    +-		die_errno("unable to rename temporary index file");
     -
     -	strbuf_setlen(name_buffer, basename_len);
    -+	strbuf_reset(&sb);
    ++	rename_tmp_packfile(pack_tmp_name, basename, hash, "pack");
    ++	if (rev_tmp_name)
    ++		rename_tmp_packfile(rev_tmp_name, basename, hash, "rev");
    ++	rename_tmp_packfile(idx_tmp_name, basename, hash, "idx");
      
      	free((void *)idx_tmp_name);
      }
    @@ pack.h: int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
      int read_pack_header(int fd, struct pack_header *);
      
      struct hashfile *create_tmp_packfile(char **pack_tmp_name);
    --void finish_tmp_packfile(struct strbuf *name_buffer, const char *pack_tmp_name, struct pack_idx_entry **written_list, uint32_t nr_written, struct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
    -+void finish_tmp_packfile(const struct strbuf *name_buffer,
    -+			 const char *pack_tmp_name,
    -+			 struct pack_idx_entry **written_list,
    -+			 uint32_t nr_written,
    -+			 struct pack_idx_option *pack_idx_opts,
    -+			 unsigned char sha1[]);
    - 
    - #endif
    +-void finish_tmp_packfile(struct strbuf *name_buffer,
    ++void finish_tmp_packfile(const struct strbuf *basename,
    + 			 const char *pack_tmp_name,
    + 			 struct pack_idx_entry **written_list,
    + 			 uint32_t nr_written,
2:  42f83774fe ! 3:  1205f9d0c2 pack-write: split up finish_tmp_packfile() function
    @@ Commit message
         pack-write: split up finish_tmp_packfile() function
     
         Split up the finish_tmp_packfile() function and use the split-up
    -    version in pack-objects.c. This change should not change any
    -    functionality, but sets up code flow for a bug fix where we'll be able
    -    to move the *.idx in-place after the *.bitmap is written.
    +    version in pack-objects.c in preparation for moving the step of
    +    renaming the *.idx file later as part of a function change.
    +
    +    Since the only other caller of finish_tmp_packfile() was in
    +    bulk-checkin.c, and it won't be needing a change to its *.idx
    +    renaming, provide a thin wrapper for the old function as a static
    +    function in that file. If other callers end up needing the simpler
    +    version it could be moved back to "pack-write.c" and "pack.h".
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/pack-objects.c
     @@ builtin/pack-objects.c: static void write_pack_file(void)
      		if (!pack_to_stdout) {
      			struct stat st;
    - 			struct strbuf tmp_basename = STRBUF_INIT;
    + 			struct strbuf tmpname = STRBUF_INIT;
     +			char *idx_tmp_name = NULL;
      
      			/*
    @@ builtin/pack-objects.c: static void write_pack_file(void)
      					&to_pack, written_list, nr_written);
      			}
      
    --			finish_tmp_packfile(&tmp_basename, pack_tmp_name,
    --					    written_list, nr_written,
    +-			finish_tmp_packfile(&tmpname, pack_tmp_name,
    ++			stage_tmp_packfiles(&tmpname, pack_tmp_name,
    + 					    written_list, nr_written,
     -					    &pack_idx_opts, hash);
    -+			stage_tmp_packfile(&tmp_basename, pack_tmp_name,
    -+					   written_list, nr_written,
    -+					   &pack_idx_opts, hash, &idx_tmp_name);
    -+			rename_tmp_packfile_idx(&tmp_basename, hash, &idx_tmp_name);
    ++					    &pack_idx_opts, hash, &idx_tmp_name);
    ++			rename_tmp_packfile_idx(&tmpname, hash, &idx_tmp_name);
      
      			if (write_bitmap_index) {
      				struct strbuf sb = STRBUF_INIT;
    @@ builtin/pack-objects.c: static void write_pack_file(void)
      			}
      
     +			free(idx_tmp_name);
    - 			strbuf_release(&tmp_basename);
    + 			strbuf_release(&tmpname);
      			free(pack_tmp_name);
      			puts(hash_to_hex(hash));
     
    - ## pack-write.c ##
    -@@ pack-write.c: void finish_tmp_packfile(const struct strbuf *tmp_basename,
    - 			 uint32_t nr_written,
    - 			 struct pack_idx_option *pack_idx_opts,
    - 			 unsigned char hash[])
    + ## bulk-checkin.c ##
    +@@ bulk-checkin.c: static struct bulk_checkin_state {
    + 	uint32_t nr_written;
    + } state;
    + 
    ++static void finish_tmp_packfile(const struct strbuf *basename,
    ++				const char *pack_tmp_name,
    ++				struct pack_idx_entry **written_list,
    ++				uint32_t nr_written,
    ++				struct pack_idx_option *pack_idx_opts,
    ++				unsigned char hash[])
     +{
     +	char *idx_tmp_name = NULL;
     +
    -+	stage_tmp_packfile(tmp_basename, pack_tmp_name, written_list,
    -+			   nr_written, pack_idx_opts, hash, &idx_tmp_name);
    -+	rename_tmp_packfile_idx(tmp_basename, hash, &idx_tmp_name);
    ++	stage_tmp_packfiles(basename, pack_tmp_name, written_list, nr_written,
    ++			    pack_idx_opts, hash, &idx_tmp_name);
    ++	rename_tmp_packfile_idx(basename, hash, &idx_tmp_name);
     +
     +	free(idx_tmp_name);
     +}
     +
    -+void stage_tmp_packfile(const struct strbuf *tmp_basename,
    -+			const char *pack_tmp_name,
    -+			struct pack_idx_entry **written_list,
    -+			uint32_t nr_written,
    -+			struct pack_idx_option *pack_idx_opts,
    -+			unsigned char hash[],
    -+			char **idx_tmp_name)
    + static void finish_bulk_checkin(struct bulk_checkin_state *state)
    + {
    + 	struct object_id oid;
    +
    + ## pack-write.c ##
    +@@ pack-write.c: static void rename_tmp_packfile(const char *source,
    + 	strbuf_release(&sb);
    + }
    + 
    +-void finish_tmp_packfile(const struct strbuf *basename,
    ++void rename_tmp_packfile_idx(const struct strbuf *basename,
    ++			      unsigned char hash[], char **idx_tmp_name)
    ++{
    ++	rename_tmp_packfile(*idx_tmp_name, basename, hash, "idx");
    ++}
    ++
    ++void stage_tmp_packfiles(const struct strbuf *basename,
    + 			 const char *pack_tmp_name,
    + 			 struct pack_idx_entry **written_list,
    + 			 uint32_t nr_written,
    + 			 struct pack_idx_option *pack_idx_opts,
    +-			 unsigned char hash[])
    ++			 unsigned char hash[],
    ++			 char **idx_tmp_name)
      {
    - 	struct strbuf sb = STRBUF_INIT;
     -	const char *idx_tmp_name, *rev_tmp_name = NULL;
     +	const char *rev_tmp_name = NULL;
      
    @@ pack-write.c: void finish_tmp_packfile(const struct strbuf *tmp_basename,
      		die_errno("unable to make temporary index file readable");
      
      	rev_tmp_name = write_rev_file(NULL, written_list, nr_written, hash,
    -@@ pack-write.c: void finish_tmp_packfile(const struct strbuf *tmp_basename,
    - 		strbuf_reset(&sb);
    - 	}
    - 
    -+	strbuf_release(&sb);
    -+}
    -+
    -+void rename_tmp_packfile_idx(const struct strbuf *tmp_basename,
    -+			     unsigned char hash[], char **idx_tmp_name)
    -+{
    -+	struct strbuf sb = STRBUF_INIT;
    -+
    - 	strbuf_addf(&sb, "%s%s.idx", tmp_basename->buf, hash_to_hex(hash));
    --	if (rename(idx_tmp_name, sb.buf))
    -+	if (rename(*idx_tmp_name, sb.buf))
    - 		die_errno("unable to rename temporary index file");
    --	strbuf_reset(&sb);
    +@@ pack-write.c: void finish_tmp_packfile(const struct strbuf *basename,
    + 	rename_tmp_packfile(pack_tmp_name, basename, hash, "pack");
    + 	if (rev_tmp_name)
    + 		rename_tmp_packfile(rev_tmp_name, basename, hash, "rev");
    +-	rename_tmp_packfile(idx_tmp_name, basename, hash, "idx");
     -
     -	free((void *)idx_tmp_name);
    -+	strbuf_release(&sb);
      }
      
      void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought)
    @@ pack.h: int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
      int read_pack_header(int fd, struct pack_header *);
      
      struct hashfile *create_tmp_packfile(char **pack_tmp_name);
    -+void stage_tmp_packfile(const struct strbuf *tmp_basename,
    -+			const char *pack_tmp_name,
    -+			struct pack_idx_entry **written_list,
    -+			uint32_t nr_written,
    -+			struct pack_idx_option *pack_idx_opts,
    -+			unsigned char hash[],
    -+			char **idx_tmp_name);
    -+void rename_tmp_packfile_idx(const struct strbuf *tmp_basename,
    -+			     unsigned char hash[], char **idx_tmp_name);
    - void finish_tmp_packfile(const struct strbuf *name_buffer,
    +-void finish_tmp_packfile(const struct strbuf *basename,
    ++void stage_tmp_packfiles(const struct strbuf *basename,
      			 const char *pack_tmp_name,
      			 struct pack_idx_entry **written_list,
    + 			 uint32_t nr_written,
    + 			 struct pack_idx_option *pack_idx_opts,
    +-			 unsigned char sha1[]);
    ++			 unsigned char hash[],
    ++			 char **idx_tmp_name);
    ++void rename_tmp_packfile_idx(const struct strbuf *tmp_basename,
    ++			     unsigned char hash[], char **idx_tmp_name);
    + 
    + #endif
3:  78976fcb7b ! 4:  70f4a9767d pack-write: rename *.idx file into place last (really!)
    @@ Commit message
         those files are written out, nothing in that commit contradicts what's
         being done here.
     
    -    While we're at it let's add cross-commentary to both builtin/repack.c
    -    and builtin/pack-objects.c to point out the two places where we write
    -    out these sets of files in sequence.
    +    Note that the referenced earlier commit[1] is overly optimistic about
    +    "clos[ing the] race", i.e. yes we'll now write the files in the right
    +    order, but we might still race due to our sloppy use of fsync(). See
    +    the thread at [2] for a rabbit hole of various discussions about
    +    filesystem races in the face of doing and not doing fsync() (and if
    +    doing fsync(), not doing it properly).
     
         1. https://lore.kernel.org/git/a6a4d2154e83d41c10986c5f455279ab249a910c.1630461918.git.me@ttaylorr.com/
    +    2. https://lore.kernel.org/git/8735qgkvv1.fsf@evledraar.gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/pack-objects.c ##
     @@ builtin/pack-objects.c: static void write_pack_file(void)
    - 			stage_tmp_packfile(&tmp_basename, pack_tmp_name,
    - 					   written_list, nr_written,
    - 					   &pack_idx_opts, hash, &idx_tmp_name);
    --			rename_tmp_packfile_idx(&tmp_basename, hash, &idx_tmp_name);
    + 			stage_tmp_packfiles(&tmpname, pack_tmp_name,
    + 					    written_list, nr_written,
    + 					    &pack_idx_opts, hash, &idx_tmp_name);
    +-			rename_tmp_packfile_idx(&tmpname, hash, &idx_tmp_name);
      
      			if (write_bitmap_index) {
      				struct strbuf sb = STRBUF_INIT;
    @@ builtin/pack-objects.c: static void write_pack_file(void)
      				strbuf_release(&sb);
      			}
      
    -+			/*
    -+			 * We must write the *.idx last, so that anything that expects
    -+			 * an accompanying *.rev, *.bitmap etc. can count on it being
    -+			 * present.
    -+			 *
    -+			 * See also corresponding logic in the "exts"
    -+			 * struct in builtin/repack.c
    -+			 */
    -+			rename_tmp_packfile_idx(&tmp_basename, hash, &idx_tmp_name);
    ++			rename_tmp_packfile_idx(&tmpname, hash, &idx_tmp_name);
     +
      			free(idx_tmp_name);
    - 			strbuf_release(&tmp_basename);
    + 			strbuf_release(&tmpname);
      			free(pack_tmp_name);
    -
    - ## builtin/repack.c ##
    -@@ builtin/repack.c: static struct {
    - 	{".rev", 1},
    - 	{".bitmap", 1},
    - 	{".promisor", 1},
    -+	/*
    -+	 * We must write the *.idx last, so that anything that expects
    -+	 * an accompanying *.rev, *.bitmap etc. can count on it being
    -+	 * present.
    -+	 *
    -+	 * See also corresponding logic in write_pack_file() in
    -+	 * builtin/pack-objects.c
    -+	 */
    - 	{".idx"},
    - };
    - 
-- 
2.33.0.819.gea1b153a43c


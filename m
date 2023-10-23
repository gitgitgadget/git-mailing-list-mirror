Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB5215EA3
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 22:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="W/UeC+/g"
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3F510C
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:44:55 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a7db1f864bso37442187b3.3
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698101094; x=1698705894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OnEMXQmQufi9slIkaGej/Dz5eCa9WVzzqEvZxnfCcPk=;
        b=W/UeC+/gwtuHGA27pEU00FdMESqP4djS8mh4GV+ni7cWKCc/2xWSH1pUGzQW/9EWf4
         wo+8Ibi6TQRoFKn9peciNna0nz1Q9j+S3pn5K2enU7Ql1AHxXWm1MQ09Gl4bkVswWCfi
         RwEZbox8zGbQWtmhqfOXVV0IY6JqnfsBAdOf5qIt3mTJNi9EhVI3XTqP0YZhI/cS1bcp
         mDdtUkaRh8NFj3tuzLDHxrnKeMxb20vhLSCUCH2+2U31LpMcOE/UW+toTf+/XXyBCP6f
         8WuJIWilwwifCJENsUqdK+92ZKosE8tvBDT12a4HORzrlZUwJtsLUDlTpLv677DyCBAE
         kLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698101094; x=1698705894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnEMXQmQufi9slIkaGej/Dz5eCa9WVzzqEvZxnfCcPk=;
        b=kd7sNPV/dt8ldRvS+RlZ4R2jQhP+dHx+EAGdgAlUgfLFbQmY8JeamGT9R9XnhISOfL
         G+e5V3+a5HTEtP5a3pZ8/aKc84SgR9WfQdUAmMq7LkVh83DanlRwOcvq7i6zr6he0C1j
         2QzpV5NCctailM6jeg2qKVlq81+GIQNtOdE3GDxwROPtqjzFSf7j8uCZMImapkmB4Zh+
         Ml3IQx1EG/b6Rd7FXmGr8iPHJ1WirNWVAuXQ3AYjKg5JApWZFkuAaVi8+vhMuXcAWlLl
         IicXdn57QWLyP71wWr9Vc8rGHsyWKllWdOZhRMSibrI7J+p1xNLQDPX8pnEExYiVNiIK
         qiHA==
X-Gm-Message-State: AOJu0YwK1K7BpXvJ0twfj8CgX/Bjzg/7Ps3X+MtttYUQ4i4yeROXvDfE
	0yHCIGvw+zlYju+o42c2qEcC4QStIduUrJgH4kWrfQ==
X-Google-Smtp-Source: AGHT+IFUvKXDRIg4DPVwFrHdxiAvsiEvyVD2efzDlKxsC3GSOiclDz2BQ1VbTfihRWyn3glRcZFqPg==
X-Received: by 2002:a81:9189:0:b0:5a7:ba53:6544 with SMTP id i131-20020a819189000000b005a7ba536544mr12925806ywg.12.1698101094503;
        Mon, 23 Oct 2023 15:44:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m205-20020a8171d6000000b0059af121d0b8sm3548614ywc.52.2023.10.23.15.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 15:44:54 -0700 (PDT)
Date: Mon, 23 Oct 2023 18:44:49 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 0/5] merge-ort: implement support for packing objects
 together
Message-ID: <cover.1698101088.git.me@ttaylorr.com>
References: <cover.1697736516.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697736516.git.me@ttaylorr.com>

(Rebased onto the current tip of 'master', which is ceadf0f3cf (The
twentieth batch, 2023-10-20)).

This series implements support for a new merge-tree option,
`--write-pack`, which causes any newly-written objects to be packed
together instead of being stored individually as loose.

This is a minor follow-up that could be taken instead of v4 (though the
changes between these two most recent rounds are stylistic and a matter
of subjective opinion).

This moves us the bulk_checkin_source structure introduced in response
to Junio's suggestion during the last round further in the OOP
direction. Instead of switching on the enum type of the source, have
function pointers for read() and seek() respectively.

The functionality at the end is the same, but this avoids some of the
namespacing issues that Peff pointed out while looking at v4. But I
think that this approach ended up being less heavy-weight than I had
originally imagined, so I think that this version is a worthwhile
improvement over v4.

Beyond that, the changes since last time can be viewed in the range-diff
below. Thanks in advance for any review!

[1]: https://lore.kernel.org/git/xmqq34y7plj4.fsf@gitster.g/

Taylor Blau (5):
  bulk-checkin: extract abstract `bulk_checkin_source`
  bulk-checkin: generify `stream_blob_to_pack()` for arbitrary types
  bulk-checkin: introduce `index_blob_bulk_checkin_incore()`
  bulk-checkin: introduce `index_tree_bulk_checkin_incore()`
  builtin/merge-tree.c: implement support for `--write-pack`

 Documentation/git-merge-tree.txt |   4 +
 builtin/merge-tree.c             |   5 +
 bulk-checkin.c                   | 197 +++++++++++++++++++++++++++----
 bulk-checkin.h                   |   8 ++
 merge-ort.c                      |  42 +++++--
 merge-recursive.h                |   1 +
 t/t4301-merge-tree-write-tree.sh |  93 +++++++++++++++
 7 files changed, 316 insertions(+), 34 deletions(-)

Range-diff against v4:
1:  97bb6e9f59 ! 1:  696aa027e4 bulk-checkin: extract abstract `bulk_checkin_source`
    @@ bulk-checkin.c: static int already_written(struct bulk_checkin_packfile *state,
      }
      
     +struct bulk_checkin_source {
    -+	enum { SOURCE_FILE } type;
    ++	off_t (*read)(struct bulk_checkin_source *, void *, size_t);
    ++	off_t (*seek)(struct bulk_checkin_source *, off_t);
     +
    -+	/* SOURCE_FILE fields */
    -+	int fd;
    ++	union {
    ++		struct {
    ++			int fd;
    ++		} from_fd;
    ++	} data;
     +
    -+	/* common fields */
     +	size_t size;
     +	const char *path;
     +};
     +
    -+static off_t bulk_checkin_source_seek_to(struct bulk_checkin_source *source,
    -+					 off_t offset)
    ++static off_t bulk_checkin_source_read_from_fd(struct bulk_checkin_source *source,
    ++					      void *buf, size_t nr)
     +{
    -+	switch (source->type) {
    -+	case SOURCE_FILE:
    -+		return lseek(source->fd, offset, SEEK_SET);
    -+	default:
    -+		BUG("unknown bulk-checkin source: %d", source->type);
    -+	}
    ++	return read_in_full(source->data.from_fd.fd, buf, nr);
     +}
     +
    -+static ssize_t bulk_checkin_source_read(struct bulk_checkin_source *source,
    -+					void *buf, size_t nr)
    ++static off_t bulk_checkin_source_seek_from_fd(struct bulk_checkin_source *source,
    ++					      off_t offset)
     +{
    -+	switch (source->type) {
    -+	case SOURCE_FILE:
    -+		return read_in_full(source->fd, buf, nr);
    -+	default:
    -+		BUG("unknown bulk-checkin source: %d", source->type);
    -+	}
    ++	return lseek(source->data.from_fd.fd, offset, SEEK_SET);
    ++}
    ++
    ++static void init_bulk_checkin_source_from_fd(struct bulk_checkin_source *source,
    ++					     int fd, size_t size,
    ++					     const char *path)
    ++{
    ++	memset(source, 0, sizeof(struct bulk_checkin_source));
    ++
    ++	source->read = bulk_checkin_source_read_from_fd;
    ++	source->seek = bulk_checkin_source_seek_from_fd;
    ++
    ++	source->data.from_fd.fd = fd;
    ++
    ++	source->size = size;
    ++	source->path = path;
     +}
     +
      /*
    @@ bulk-checkin.c: static int stream_blob_to_pack(struct bulk_checkin_packfile *sta
     -			ssize_t read_result = read_in_full(fd, ibuf, rsize);
     +			ssize_t read_result;
     +
    -+			read_result = bulk_checkin_source_read(source, ibuf,
    -+							       rsize);
    ++			read_result = source->read(source, ibuf, rsize);
      			if (read_result < 0)
     -				die_errno("failed to read from '%s'", path);
     +				die_errno("failed to read from '%s'",
    @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checkin_packfile *st
      	unsigned header_len;
      	struct hashfile_checkpoint checkpoint = {0};
      	struct pack_idx_entry *idx = NULL;
    -+	struct bulk_checkin_source source = {
    -+		.type = SOURCE_FILE,
    -+		.fd = fd,
    -+		.size = size,
    -+		.path = path,
    -+	};
    ++	struct bulk_checkin_source source;
    ++
    ++	init_bulk_checkin_source_from_fd(&source, fd, size, path);
      
      	seekback = lseek(fd, 0, SEEK_CUR);
      	if (seekback == (off_t) -1)
    @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checkin_packfile *st
      		state->offset = checkpoint.offset;
      		flush_bulk_checkin_packfile(state);
     -		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
    -+		if (bulk_checkin_source_seek_to(&source, seekback) == (off_t)-1)
    ++		if (source.seek(&source, seekback) == (off_t)-1)
      			return error("cannot seek back");
      	}
      	the_hash_algo->final_oid_fn(result_oid, &ctx);
2:  9d633df339 < -:  ---------- bulk-checkin: generify `stream_blob_to_pack()` for arbitrary types
3:  d5bbd7810e ! 2:  596bd028a7 bulk-checkin: refactor deflate routine to accept a `bulk_checkin_source`
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    bulk-checkin: refactor deflate routine to accept a `bulk_checkin_source`
    +    bulk-checkin: generify `stream_blob_to_pack()` for arbitrary types
     
    -    Prepare for a future change where we will want to use a routine very
    -    similar to the existing `deflate_blob_to_pack()` but over arbitrary
    -    sources (i.e. either open file-descriptors, or a location in memory).
    +    The existing `stream_blob_to_pack()` function is named based on the fact
    +    that it knows only how to stream blobs into a bulk-checkin pack.
     
    -    Extract out a common "deflate_obj_to_pack()" routine that acts on a
    -    bulk_checkin_source, instead of a (int, size_t) pair. Then rewrite
    -    `deflate_blob_to_pack()` in terms of it.
    +    But there is no longer anything in this function which prevents us from
    +    writing objects of arbitrary types to the bulk-checkin pack. Prepare to
    +    write OBJ_TREEs by removing this assumption, adding an `enum
    +    object_type` parameter to this function's argument list, and renaming it
    +    to `stream_obj_to_pack()` accordingly.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## bulk-checkin.c ##
    +@@ bulk-checkin.c: static void init_bulk_checkin_source_from_fd(struct bulk_checkin_source *source,
    +  * status before calling us just in case we ask it to call us again
    +  * with a new pack.
    +  */
    +-static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
    +-			       git_hash_ctx *ctx, off_t *already_hashed_to,
    +-			       struct bulk_checkin_source *source,
    +-			       unsigned flags)
    ++static int stream_obj_to_pack(struct bulk_checkin_packfile *state,
    ++			      git_hash_ctx *ctx, off_t *already_hashed_to,
    ++			      struct bulk_checkin_source *source,
    ++			      enum object_type type, unsigned flags)
    + {
    + 	git_zstream s;
    + 	unsigned char ibuf[16384];
    +@@ bulk-checkin.c: static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
    + 
    + 	git_deflate_init(&s, pack_compression_level);
    + 
    +-	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), OBJ_BLOB,
    +-					      size);
    ++	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), type, size);
    + 	s.next_out = obuf + hdrlen;
    + 	s.avail_out = sizeof(obuf) - hdrlen;
    + 
     @@ bulk-checkin.c: static void prepare_to_stream(struct bulk_checkin_packfile *state,
      		die_errno("unable to write pack header");
      }
    @@ bulk-checkin.c: static void prepare_to_stream(struct bulk_checkin_packfile *stat
      	unsigned header_len;
      	struct hashfile_checkpoint checkpoint = {0};
      	struct pack_idx_entry *idx = NULL;
    --	struct bulk_checkin_source source = {
    --		.type = SOURCE_FILE,
    --		.fd = fd,
    --		.size = size,
    --		.path = path,
    --	};
    +-	struct bulk_checkin_source source;
      
    +-	init_bulk_checkin_source_from_fd(&source, fd, size, path);
    +-
     -	seekback = lseek(fd, 0, SEEK_CUR);
     -	if (seekback == (off_t) -1)
     -		return error("cannot find the current offset");
    @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checkin_packfile *st
      		prepare_to_stream(state, flags);
      		if (idx) {
     @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
    + 			idx->offset = state->offset;
      			crc32_begin(state->f);
      		}
    - 		if (!stream_obj_to_pack(state, &ctx, &already_hashed_to,
    --					&source, OBJ_BLOB, flags))
    +-		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
    +-					 &source, flags))
    ++		if (!stream_obj_to_pack(state, &ctx, &already_hashed_to,
     +					source, type, flags))
      			break;
      		/*
    @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checkin_packfile *st
      		hashfile_truncate(state->f, &checkpoint);
      		state->offset = checkpoint.offset;
      		flush_bulk_checkin_packfile(state);
    --		if (bulk_checkin_source_seek_to(&source, seekback) == (off_t)-1)
    -+		if (bulk_checkin_source_seek_to(source, seekback) == (off_t)-1)
    +-		if (source.seek(&source, seekback) == (off_t)-1)
    ++		if (source->seek(source, seekback) == (off_t)-1)
      			return error("cannot seek back");
      	}
      	the_hash_algo->final_oid_fn(result_oid, &ctx);
    @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checkin_packfile *st
     +				int fd, size_t size,
     +				const char *path, unsigned flags)
     +{
    -+	struct bulk_checkin_source source = {
    -+		.type = SOURCE_FILE,
    -+		.fd = fd,
    -+		.size = size,
    -+		.path = path,
    -+	};
    -+	off_t seekback = lseek(fd, 0, SEEK_CUR);
    ++	struct bulk_checkin_source source;
    ++	off_t seekback;
    ++
    ++	init_bulk_checkin_source_from_fd(&source, fd, size, path);
    ++
    ++	seekback = lseek(fd, 0, SEEK_CUR);
     +	if (seekback == (off_t) -1)
     +		return error("cannot find the current offset");
     +
4:  e427fe6ad3 < -:  ---------- bulk-checkin: implement `SOURCE_INCORE` mode for `bulk_checkin_source`
5:  48095afe80 ! 3:  d8cf8e4395 bulk-checkin: introduce `index_blob_bulk_checkin_incore()`
    @@ Metadata
      ## Commit message ##
         bulk-checkin: introduce `index_blob_bulk_checkin_incore()`
     
    -    Now that we have factored out many of the common routines necessary to
    -    index a new object into a pack created by the bulk-checkin machinery, we
    -    can introduce a variant of `index_blob_bulk_checkin()` that acts on
    -    blobs whose contents we can fit in memory.
    +    Introduce `index_blob_bulk_checkin_incore()` which allows streaming
    +    arbitrary blob contents from memory into the bulk-checkin pack.
    +
    +    In order to support streaming from a location in memory, we must
    +    implement a new kind of bulk_checkin_source that does just that. These
    +    implementation in spread out across:
    +
    +      - init_bulk_checkin_source_incore()
    +      - bulk_checkin_source_read_incore()
    +      - bulk_checkin_source_seek_incore()
    +
    +    Note that, unlike file descriptors, which manage their own offset
    +    internally, we have to keep track of how many bytes we've read out of
    +    the buffer, and make sure we don't read past the end of the buffer.
     
         This will be useful in a couple of more commits in order to provide the
         `merge-tree` builtin with a mechanism to create a new pack containing
    @@ Commit message
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## bulk-checkin.c ##
    +@@ bulk-checkin.c: struct bulk_checkin_source {
    + 		struct {
    + 			int fd;
    + 		} from_fd;
    ++		struct {
    ++			const void *buf;
    ++			size_t nr_read;
    ++		} incore;
    + 	} data;
    + 
    + 	size_t size;
    +@@ bulk-checkin.c: static off_t bulk_checkin_source_seek_from_fd(struct bulk_checkin_source *source
    + 	return lseek(source->data.from_fd.fd, offset, SEEK_SET);
    + }
    + 
    ++static off_t bulk_checkin_source_read_incore(struct bulk_checkin_source *source,
    ++					     void *buf, size_t nr)
    ++{
    ++	const unsigned char *src = source->data.incore.buf;
    ++
    ++	if (source->data.incore.nr_read > source->size)
    ++		BUG("read beyond bulk-checkin source buffer end "
    ++		    "(%"PRIuMAX" > %"PRIuMAX")",
    ++		    (uintmax_t)source->data.incore.nr_read,
    ++		    (uintmax_t)source->size);
    ++
    ++	if (nr > source->size - source->data.incore.nr_read)
    ++		nr = source->size - source->data.incore.nr_read;
    ++
    ++	src += source->data.incore.nr_read;
    ++
    ++	memcpy(buf, src, nr);
    ++	source->data.incore.nr_read += nr;
    ++	return nr;
    ++}
    ++
    ++static off_t bulk_checkin_source_seek_incore(struct bulk_checkin_source *source,
    ++					     off_t offset)
    ++{
    ++	if (!(0 <= offset && offset < source->size))
    ++		return (off_t)-1;
    ++	source->data.incore.nr_read = offset;
    ++	return source->data.incore.nr_read;
    ++}
    ++
    + static void init_bulk_checkin_source_from_fd(struct bulk_checkin_source *source,
    + 					     int fd, size_t size,
    + 					     const char *path)
    +@@ bulk-checkin.c: static void init_bulk_checkin_source_from_fd(struct bulk_checkin_source *source,
    + 	source->path = path;
    + }
    + 
    ++static void init_bulk_checkin_source_incore(struct bulk_checkin_source *source,
    ++					    const void *buf, size_t size,
    ++					    const char *path)
    ++{
    ++	memset(source, 0, sizeof(struct bulk_checkin_source));
    ++
    ++	source->read = bulk_checkin_source_read_incore;
    ++	source->seek = bulk_checkin_source_seek_incore;
    ++
    ++	source->data.incore.buf = buf;
    ++	source->data.incore.nr_read = 0;
    ++
    ++	source->size = size;
    ++	source->path = path;
    ++}
    ++
    + /*
    +  * Read the contents from 'source' for 'size' bytes, streaming it to the
    +  * packfile in state while updating the hash in ctx. Signal a failure
     @@ bulk-checkin.c: static int deflate_obj_to_pack(struct bulk_checkin_packfile *state,
      	return 0;
      }
    @@ bulk-checkin.c: static int deflate_obj_to_pack(struct bulk_checkin_packfile *sta
     +				       const char *path, enum object_type type,
     +				       unsigned flags)
     +{
    -+	struct bulk_checkin_source source = {
    -+		.type = SOURCE_INCORE,
    -+		.buf = buf,
    -+		.size = size,
    -+		.read = 0,
    -+		.path = path,
    -+	};
    ++	struct bulk_checkin_source source;
    ++
    ++	init_bulk_checkin_source_incore(&source, buf, size, path);
     +
     +	return deflate_obj_to_pack(state, result_oid, &source, type, 0, flags);
     +}
6:  60568f9281 = 4:  2670192802 bulk-checkin: introduce `index_tree_bulk_checkin_incore()`
7:  b9be9df122 ! 5:  3595db76a5 builtin/merge-tree.c: implement support for `--write-pack`
    @@ Documentation/git-merge-tree.txt: OPTIONS
     
      ## builtin/merge-tree.c ##
     @@
    - #include "quote.h"
      #include "tree.h"
      #include "config.h"
    + #include "strvec.h"
     +#include "bulk-checkin.h"
      
      static int line_termination = '\n';
      
     @@ builtin/merge-tree.c: struct merge_tree_options {
    - 	int show_messages;
      	int name_only;
      	int use_stdin;
    + 	struct merge_options merge_options;
     +	int write_pack;
      };
      
      static int real_merge(struct merge_tree_options *o,
     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
    - 	init_merge_options(&opt, the_repository);
    + 				 _("not something we can merge"));
      
      	opt.show_rename_progress = 0;
     +	opt.write_pack = o->write_pack;
    @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
      	opt.branch1 = branch1;
      	opt.branch2 = branch2;
     @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
    - 			   &merge_base,
    - 			   N_("commit"),
      			   N_("specify a merge-base for the merge")),
    + 		OPT_STRVEC('X', "strategy-option", &xopts, N_("option=value"),
    + 			N_("option for selected merge strategy")),
     +		OPT_BOOL(0, "write-pack", &o.write_pack,
     +			 N_("write new objects to a pack instead of as loose")),
      		OPT_END()

base-commit: ceadf0f3cf51550166a387ec8508bb55e7883057
-- 
2.42.0.425.g963d08ddb3.dirty

Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542E5C4363D
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 01:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0CC22145D
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 01:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sjdyyxHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgJHBld (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 21:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgJHBlc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 21:41:32 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A848CC061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 18:41:32 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id n125so2768206qke.19
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 18:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=T1Lk/tesAXuUp2W5ZTOw7HjbzwAK4w7/P9BV2xTuLB4=;
        b=sjdyyxHMe+M+kCQMy9sUOuB4Yzc81Jo2wbF5bVW5FD9iOpf29OPlb3BSDeD8kXcech
         IPGf/GHfSfVTEIkwpMUaSWJXvUYdckcVJFtW896YZQ1iYBO0WOLrXgTaZBBsnp1wr/4i
         pCTZnZj9cNrIxe31GNL4v0tPp/b1eJUl2+B17nV/QvIBm8jJCYKRA23naN7ITlAEVyBV
         y5PV4lFz/7iMWyusO5P8cMvNhFk2flpNXL/59KId01o79du/Z/s6rkjkVvmRIP+A17tF
         5ecuseP1R5dJap2i96NPJ08MKz10tIBW2j/gjx9vldoCXrr5BxJ+/A4TEMByKnFmSvGN
         4lTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T1Lk/tesAXuUp2W5ZTOw7HjbzwAK4w7/P9BV2xTuLB4=;
        b=tIS6Z2FgGYMD8tKDW4vrvpjkKKKOq1s9e6tVv2mXKiX9M5h5H0VS1qhbQOcE6/NVYt
         CgOicTIiyw6RhnkYRwtgMhQe/zgLek+buSmymhkuzu05Qza3d068Z1mlaieotYuCrjDT
         4+g+dZbEfy87Wwf4HgAbHscsrZNbDtrXHfmEuX9bbn7veznKpnqokwPncwz+EL+OSEuD
         0uPW/0wVQ0C9Bs6/mZqhXraOU5VOaBtD3v5T3nstk91Lan0wbiTxST1TRNxP2KYVb18f
         Ae0m3YIHC8nsgv8bkR7gT+RvM9ZR/7+KXp7KWJD/eGqzA2Bh/mK/sl1yTqT3mVUWXkRh
         fe5A==
X-Gm-Message-State: AOAM531hbGc/8nhrf9/5DRCEK+KeAx3qojLAn3u0tmZzD31nZGJ4N1FG
        AAUo7ncwepEyFCnOONAR+X4zbrvjfwH0dkZQYrLP
X-Google-Smtp-Source: ABdhPJznaUnWoWVqZHo3zr6DeHqAsPzT4k1udA1AO6MOW04AxsfpSjeGRO/0QjZPozl8tZ6oiH04+l/XlaiuMcrjpjrv
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:4150:: with SMTP id
 z16mr211309qvp.50.1602121291695; Wed, 07 Oct 2020 18:41:31 -0700 (PDT)
Date:   Wed,  7 Oct 2020 18:41:24 -0700
In-Reply-To: <5d1b946ab5473504e9599d90c0feda407a179a05.1601568663.git.gitgitgadget@gmail.com>
Message-Id: <20201008014124.1410535-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <5d1b946ab5473504e9599d90c0feda407a179a05.1601568663.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: Re: [PATCH v2 02/13] reftable: define the public API
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hanwen@google.com, peff@peff.net,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My initial impression is that this public API is much larger than I
would expect from reading the reftable spec. Let me look at it in
detail...

> +/****************************************************************
> + Basic data types
> +
> + Reftables store the state of each ref in struct reftable_ref_record, and they
> + store a sequence of reflog updates in struct reftable_log_record.
> + ****************************************************************/
> +
> +/* reftable_ref_record holds a ref database entry target_value */
> +struct reftable_ref_record {
> +	char *refname; /* Name of the ref, malloced. */
> +	uint64_t update_index; /* Logical timestamp at which this value is
> +				  written */
> +	uint8_t *value; /* SHA1, or NULL. malloced. */
> +	uint8_t *target_value; /* peeled annotated tag, or NULL. malloced. */
> +	char *target; /* symref, or NULL. malloced. */
> +};

A typical user would just want to do refname->hash, refname->log, or possibly
hash->refname lookups, so a ref record would be meant for low-level
users. I can't think of a typical use case, but even if such existed, I
wouldn't expect this API - in particular, the refname is not written as
such on disk (it is composed from a prefix and a suffix, if I remember
correctly), so I would expect a function that one can call to write the
refname, but not for it to appear in a data structure.

> +/* returns whether 'ref' represents a deletion */
> +int reftable_ref_record_is_deletion(const struct reftable_ref_record *ref);

This looks unorthogonal - looking at the spec, the "value type" can
represent a deletion, one object name (value of the ref), two object
names (value of the ref + peeled target), or symbolic reference. If
we're willing to allocate memory for a ref record, I think we can afford
the extra 4 bytes (maybe 8) and use a tagged union instead.

> +/* prints a reftable_ref_record onto stdout */
> +void reftable_ref_record_print(struct reftable_ref_record *ref,
> +			       uint32_t hash_id);

Not sure if this belongs here.

> +/* frees and nulls all pointer values. */
> +void reftable_ref_record_clear(struct reftable_ref_record *ref);

Usually we call this "release" in Git.

> +/* returns whether two reftable_ref_records are the same */
> +int reftable_ref_record_equal(struct reftable_ref_record *a,
> +			      struct reftable_ref_record *b, int hash_size);

Not sure what this will be used for.

> +/* reftable_log_record holds a reflog entry */
> +struct reftable_log_record {
> +	char *refname;
> +	uint64_t update_index; /* logical timestamp of a transactional update.
> +				*/
> +	uint8_t *new_hash;
> +	uint8_t *old_hash;
> +	char *name;
> +	char *email;
> +	uint64_t time;
> +	int16_t tz_offset;
> +	char *message;
> +};

Mostly same comments as above.

[snip]

> +/****************************************************************
> + Error handling
> +
> + Error are signaled with negative integer return values. 0 means success.
> + ****************************************************************/

I didn't look at this section deeply, but this looks OK at first glance.

> +/****************************************************************
> + Writing
> +
> + Writing single reftables
> + ****************************************************************/

OK - writing a single reftable makes sense.

> +/* reftable_write_options sets options for writing a single reftable. */
> +struct reftable_write_options {
> +	/* boolean: do not pad out blocks to block size. */
> +	int unpadded;
> +
> +	/* the blocksize. Should be less than 2^24. */
> +	uint32_t block_size;
> +
> +	/* boolean: do not generate a SHA1 => ref index. */
> +	int skip_index_objects;
> +
> +	/* how often to write complete keys in each block. */
> +	int restart_interval;
> +
> +	/* 4-byte identifier ("sha1", "s256") of the hash.
> +	 * Defaults to SHA1 if unset
> +	 */
> +	uint32_t hash_id;
> +
> +	/* boolean: do not check ref names for validity or dir/file conflicts.
> +	 */
> +	int skip_name_check;
> +
> +	/* boolean: copy log messages exactly. If unset, check that the message
> +	 *   is a single line, and add '\n' if missing.
> +	 */
> +	int exact_log_message;
> +};

I'm not sure we need so many options, but nothing jumps out to me
off-hand. Some minor things - "hash_id" should probably be an enum and
the booleans should be "unsigned variable_name : 1".

[snip statistics]

Statistics look useful.

> +/* reftable_new_writer creates a new writer */
> +struct reftable_writer *
> +reftable_new_writer(int (*writer_func)(void *, const void *, size_t),
> +		    void *writer_arg, struct reftable_write_options *opts);
> +
> +/* write to a file descriptor. fdp should be an int* pointing to the fd. */
> +int reftable_fd_write(void *fdp, const void *data, size_t size);

Not sure if we'll need to write to things other than an fd, but if we
do, this makes sense.

> +/* Set the range of update indices for the records we will add.  When
> +   writing a table into a stack, the min should be at least
> +   reftable_stack_next_update_index(), or REFTABLE_API_ERROR is returned.
> +
> +   For transactional updates, typically min==max. When converting an existing
> +   ref database into a single reftable, this would be a range of update-index
> +   timestamps.
> + */
> +void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
> +				uint64_t max);

This seems to be here because we want to write the file in a single
pass, and the update index maximum and minimum appear in the header. If
we were allowed to seek while writing, could the update index maximum
and minimum be deduced instead? That might be a compelling reason to
only support FDs, and require that the FDs be seekable.

> +/* adds a reftable_ref_record. Must be called in ascending
> +   order. The update_index must be within the limits set by
> +   reftable_writer_set_limits(), or REFTABLE_API_ERROR is returned.
> +
> +   It is an error to write a ref record after a log record.
> + */
> +int reftable_writer_add_ref(struct reftable_writer *w,
> +			    struct reftable_ref_record *ref);
> +
> +/* Convenience function to add multiple refs. Will sort the refs by
> +   name before adding. */
> +int reftable_writer_add_refs(struct reftable_writer *w,
> +			     struct reftable_ref_record *refs, int n);

Since refs is an array of objects and not an array of pointers, these
two functions could be combined - the first is the same as calling the
second with n=1.

Also, ascending order of what?

The user will also need to know where to get the update index from - I
presume that this will be the maximum update index of any record with
the given refname + 1.

[snip similar functions for log]

> +/* reftable_writer_close finalizes the reftable. The writer is retained so
> + * statistics can be inspected. */
> +int reftable_writer_close(struct reftable_writer *w);
> +
> +/* writer_stats returns the statistics on the reftable being written.
> +
> +   This struct becomes invalid when the writer is freed.
> + */
> +const struct reftable_stats *writer_stats(struct reftable_writer *w);
> +
> +/* reftable_writer_free deallocates memory for the writer */
> +void reftable_writer_free(struct reftable_writer *w);

OK.

> +/****************************************************************
> + * ITERATING
> + ****************************************************************/

[snip]

> +/* reads the next reftable_ref_record. Returns < 0 for error, 0 for OK and > 0:
> +   end of iteration.
> +*/
> +int reftable_iterator_next_ref(struct reftable_iterator *it,
> +			       struct reftable_ref_record *ref);
> +
> +/* reads the next reftable_log_record. Returns < 0 for error, 0 for OK and > 0:
> +   end of iteration.
> +*/
> +int reftable_iterator_next_log(struct reftable_iterator *it,
> +			       struct reftable_log_record *log);

From my recollection, in Git, we typically use foreach functions with a
callback that is invoked once for each result. I think that's preferable
to this approach.

> +/****************************************************************
> + Reading single tables
> +
> + The follow routines are for reading single files. For an application-level
> + interface, skip ahead to struct reftable_merged_table and struct
> + reftable_stack.
> + ****************************************************************/

I think that this whole section could be skipped - if we really wanted
to read a single table, we could just use the merged-table interface
with one table.

[snip]

> +/****************************************************************
> + Merged tables
> +
> + A ref database kept in a sequence of table files. The merged_table presents a
> + unified view to reading (seeking, iterating) a sequence of immutable tables.
> + ****************************************************************/
> +
> +/* A merged table is implements seeking/iterating over a stack of tables. */
> +struct reftable_merged_table;
> +
> +/* A generic reftable; see below. */
> +struct reftable_table;

Why would we need to see an individual reftable? Could we just represent
a merged table as a virtual concatenation of blocks (as if all the
blocks were in the same file)?

> +/* reftable_new_merged_table creates a new merged table. It takes ownership of
> +   the stack array.
> +*/
> +int reftable_new_merged_table(struct reftable_merged_table **dest,
> +			      struct reftable_table *stack, int n,
> +			      uint32_t hash_id);

I presume this would be used for things like compacting a few reftables
together? In which case, I would expect this function to just take a
list of filenames.

> +/* returns an iterator positioned just before 'name' */
> +int reftable_merged_table_seek_ref(struct reftable_merged_table *mt,
> +				   struct reftable_iterator *it,
> +				   const char *name);
> +
> +/* returns an iterator for log entry, at given update_index */
> +int reftable_merged_table_seek_log_at(struct reftable_merged_table *mt,
> +				      struct reftable_iterator *it,
> +				      const char *name, uint64_t update_index);
> +
> +/* like reftable_merged_table_seek_log_at but look for the newest entry. */
> +int reftable_merged_table_seek_log(struct reftable_merged_table *mt,
> +				   struct reftable_iterator *it,
> +				   const char *name);

Why do iterators need to be precisely positioned if this merged table is
immutable?

> +/* returns the max update_index covered by this merged table. */
> +uint64_t
> +reftable_merged_table_max_update_index(struct reftable_merged_table *mt);
> +
> +/* returns the min update_index covered by this merged table. */
> +uint64_t
> +reftable_merged_table_min_update_index(struct reftable_merged_table *mt);
> +
> +/* releases memory for the merged_table */
> +void reftable_merged_table_free(struct reftable_merged_table *m);
> +
> +/* return the hash ID of the merged table. */
> +uint32_t reftable_merged_table_hash_id(struct reftable_merged_table *m);

OK - makes sense.

> +/****************************************************************
> + Generic tables
> +
> + A unified API for reading tables, either merged tables, or single readers.
> + ****************************************************************/

Again, we could just use the merged table API.

[snip]

> +/* convenience function to read a single ref. Returns < 0 for error, 0
> +   for success, and 1 if ref not found. */
> +int reftable_table_read_ref(struct reftable_table *tab, const char *name,
> +			    struct reftable_ref_record *ref);

I presume this returns the most up-to-date record in the (possibly
merged) table? So we can just read the hash off the record to know what
this ref points to.

> +/****************************************************************
> + Mutable ref database
> +
> + The stack presents an interface to a mutable sequence of reftables.
> + ****************************************************************/

So I would expect ref mutations to be done by opening the existing
reftables as a merged table, open a reftable writer, write all the
changes that need to be written, and update the tables.list file...

> +/* a stack is a stack of reftables, which can be mutated by pushing a table to
> + * the top of the stack */
> +struct reftable_stack;
> +
> +/* open a new reftable stack. The tables along with the table list will be
> +   stored in 'dir'. Typically, this should be .git/reftables.
> +*/
> +int reftable_new_stack(struct reftable_stack **dest, const char *dir,
> +		       struct reftable_write_options config);
> +
> +/* returns the update_index at which a next table should be written. */
> +uint64_t reftable_stack_next_update_index(struct reftable_stack *st);

...so I don't see why we need a stack.

> +/* holds a transaction to add tables at the top of a stack. */
> +struct reftable_addition;
> +
> +/*
> +  returns a new transaction to add reftables to the given stack. As a side
> +  effect, the ref database is locked.
> +*/
> +int reftable_stack_new_addition(struct reftable_addition **dest,
> +				struct reftable_stack *st);
> +
> +/* Adds a reftable to transaction. */
> +int reftable_addition_add(struct reftable_addition *add,
> +			  int (*write_table)(struct reftable_writer *wr,
> +					     void *arg),
> +			  void *arg);
> +
> +/* Commits the transaction, releasing the lock. */
> +int reftable_addition_commit(struct reftable_addition *add);
> +
> +/* Release all non-committed data from the transaction, and deallocate the
> +   transaction. Releases the lock if held. */
> +void reftable_addition_destroy(struct reftable_addition *add);

We do need a transaction to write the new tables.list and then
atomically update the repository with it, but I don't think we need one
just to add a reftable to the stack.

[snip rest of stack functions]

> +/* Policy for expiring reflog entries. */
> +struct reftable_log_expiry_config {
> +	/* Drop entries older than this timestamp */
> +	uint64_t time;
> +
> +	/* Drop older entries */
> +	uint64_t min_update_index;
> +};
> +
> +/* compacts all reftables into a giant table. Expire reflog entries if config is
> + * non-NULL */
> +int reftable_stack_compact_all(struct reftable_stack *st,
> +			       struct reftable_log_expiry_config *config);

Ah, the stack is used for compacting as well. I don't think compacting
belongs here though - it should be its own thing that can make use of
the merged-table reader and the single-table writer.

[snip]

> +/* convenience function to read a single ref. Returns < 0 for error, 0
> +   for success, and 1 if ref not found. */
> +int reftable_stack_read_ref(struct reftable_stack *st, const char *refname,
> +			    struct reftable_ref_record *ref);
> +
> +/* convenience function to read a single log. Returns < 0 for error, 0
> +   for success, and 1 if ref not found. */
> +int reftable_stack_read_log(struct reftable_stack *st, const char *refname,
> +			    struct reftable_log_record *log);

Other things that belong to the merged table reader instead of the
stack.

Some things that I think are missing:

 - foreach all latest record of all refs (in any order) (I see some
   functions above that can set the position of the iterator, but I
   don't think that the iterator skips over irrelevant refs? So we can't
   use it for iterating over all refs if we don't care about the history
   of refs)
 - foreach all log entries of one ref (or all refs)

In summary, I would have expected a mechanism to read multiple (possibly
one) reftable and perform queries on it, a mechanism to write a single
reftable, and some functions to update tables.list.

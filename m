Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2720BC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 23:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05D6761159
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 23:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhIUXml (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 19:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhIUXmk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 19:42:40 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25727C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 16:41:11 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id u27so2675566edi.9
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 16:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Gk/6q0lbr5BuuYmqeosyJGExlaevL4y//81bqTr8Io8=;
        b=k2toitayXH+35Nz+2tXQ6uPX7VMUAOvRoX00LgLDISVlX9MGKci5Oqc0K+S5a+D29M
         SrIAq+c9Lr/UUZTE/+CoiHIa/Jw8iAitLlD/iTlhzNGu6/+LE8oZCz7LTfUr3w4OnMl2
         G3b/dYXpR0PWjr/BiZxXN3zb0+PDfwztL7PlyOh4Y3Gy8PSLg7yHZrdNjF/C1Qr5xhwi
         6LNYcP9S/EZLwmsfGOVJKrppo6c727TS5boV+sCj1w70dccUqU46myTx7RWUFwxMK/0v
         FCHZ6JfZiaoTETnqhI1KA02kc1WUcwGxqml/woQurXYpDEu0vrOxmSi6zCZnYrW/wlPW
         GXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Gk/6q0lbr5BuuYmqeosyJGExlaevL4y//81bqTr8Io8=;
        b=5s2OjSR4L0YUAbcqxN6f4jSYIZFYRly2c88YNSzL4mVmBcn+lSCLh4uItE0+utKI3e
         Jp6WwmrphTJwA+pAybCiOHH4yBdgEjCSnGSxqFqYXVhZfu7bSI5wvMRiTqbv+b0cJFhF
         9eSFbZ09lXkGBU8av13XE2M5t3qJ4gjX8B3WCEbcdn/s/XgdheF2iRmkP3iO4bye5mBJ
         DDLvX2PzLHBWwbK1tYoWyKziIUT71Lc1gHNl3r4ms4b6l7GvwWqA5VUyslSeEuxNDyEN
         YEHhuxYiyuQwrNsdt1N4z2BGW+3DkNdutU42K1Np/j0D3WNv7B2dNHIZDMsjVwy3KX8d
         PGSw==
X-Gm-Message-State: AOAM532N8d5Q/wSkNjwJiK7nxAZ+5KsoieELQ9e8nCk8KY7L1pdp09mB
        7iBbz7EUMNWlfBC7nFucAm3RikwCSblaFw==
X-Google-Smtp-Source: ABdhPJz7XpeUbiGdL8F98eF5E5TJ5zeV4My/aQ/tLYQvgmxzQhYb+s6tEmsIQt3AgdL0EkWwoD2VMQ==
X-Received: by 2002:a50:d6d8:: with SMTP id l24mr39086783edj.297.1632267669237;
        Tue, 21 Sep 2021 16:41:09 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bw25sm168740ejb.20.2021.09.21.16.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 16:41:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH v4 2/6] core.fsyncobjectfiles: batched disk flushes
Date:   Wed, 22 Sep 2021 01:16:24 +0200
References: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
 <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
 <12cad737635663ed596e52f89f0f4f22f58bfe38.1632176111.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <12cad737635663ed596e52f89f0f4f22f58bfe38.1632176111.git.gitgitgadget@gmail.com>
Message-ID: <87mto58pkc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 20 2021, Neeraj Singh via GitGitGadget wrote:

> When the new mode is enabled we do the following for new objects:
>
> 1. Create a tmp_obj_XXXX file and write the object data to it.
> 2. Issue a pagecache writeback request and wait for it to complete.
> 3. Record the tmp name and the final name in the bulk-checkin state for
>    later rename.
>
> At the end of the entire transaction we:
> 1. Issue a fsync against the lock file to flush the hardware writeback
>    cache, which should by now have processed the tmp file writes.
> 2. Rename all of the temp files to their final names.
> 3. When updating the index and/or refs, we assume that Git will issue
>    another fsync internal to that operation.

Perhaps note too that:

4. For loose objects, refs etc. we may or may not create directories,
   and most certainly will be updating metadata on the immediate
   directory containing the file, but none of that's fsync()'d.

> On a filesystem with a singular journal that is updated during name
> operations (e.g. create, link, rename, etc), such as NTFS and HFS+, we
> would expect the fsync to trigger a journal writeout so that this
> sequence is enough to ensure that the user's data is durable by the time
> the git command returns.
>
> This change also updates the macOS code to trigger a real hardware flush
> via fnctl(fd, F_FULLFSYNC) when fsync_or_die is called. Previously, on
> macOS there was no guarantee of durability since a simple fsync(2) call
> does not flush any hardware caches.

There's no discussion of whether this is or isn't known to also work
some Linux FS's, and for these OS's where this does work is this only
for the object files themselves, or does metadata also "ride along"?

> _Performance numbers_:
>
> Linux - Hyper-V VM running Kernel 5.11 (Ubuntu 20.04) on a fast SSD.
> Mac - macOS 11.5.1 running on a Mac mini on a 1TB Apple SSD.
> Windows - Same host as Linux, a preview version of Windows 11.
> 	  This number is from a patch later in the series.
>
> Adding 500 files to the repo with 'git add' Times reported in seconds.
>
> core.fsyncObjectFiles | Linux | Mac   | Windows
> ----------------------|-------|-------|--------
>                 false | 0.06  |  0.35 | 0.61
>                 true  | 1.88  | 11.18 | 2.47
>                 batch | 0.15  |  0.41 | 1.53

Per my https://lore.kernel.org/git/87mtp5cwpn.fsf@evledraar.gmail.com
and 6/6 in this series we've got perf tests for add/stash, but it would
be really interesting to see how this is impacted by
transfer.unpackLimit in cases where we may be writing packs or loose
objects.

> [...]
>  core.fsyncObjectFiles::
> -	This boolean will enable 'fsync()' when writing object files.
> -+
> -This is a total waste of time and effort on a filesystem that orders
> -data writes properly, but can be useful for filesystems that do not use
> -journalling (traditional UNIX filesystems) or that only journal metadata
> -and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").
> +	A value indicating the level of effort Git will expend in
> +	trying to make objects added to the repo durable in the event
> +	of an unclean system shutdown. This setting currently only
> +	controls the object store, so updates to any refs or the
> +	index may not be equally durable.

All these mentions of "object" should really clarify that it's "loose
objects", i.e. we always fsync pack files. 

> +* `false` allows data to remain in file system caches according to
> +  operating system policy, whence it may be lost if the system loses power
> +  or crashes.

As noted in point #4 of
https://lore.kernel.org/git/87mtp5cwpn.fsf@evledraar.gmail.com/ while
this direction is overall an improvement over the previously flippant
docs, they at least alluded to the context that the assumption behind
"false" is that you don't really care about loose objects, you care
about loose objects *and* the ref update or whatever.

As I think (this is from memory) we've covered already this may have
been all based on some old ext3 assumption, but it's probably worth
summarizing that here, i.e. if you've got an FS with global ordered
operations you can probably skip this, but probably not etc.

> +* `true` triggers a data integrity flush for each object added to the
> +  object store. This is the safest setting that is likely to ensure durability
> +  across all operating systems and file systems that honor the 'fsync' system
> +  call. However, this setting comes with a significant performance cost on
> +  common hardware.

This is really overpromising things by omitting the fact that eve if
we're getting this feature you've hacked up right, we're still not
fsyncing dir entries etc (also noted above).

So something that describes the narrow scope here, along with "loose
objects" etc....

> +* `batch` enables an experimental mode that uses interfaces available in some
> +  operating systems to write object data with a minimal set of FLUSH CACHE
> +  (or equivalent) commands sent to the storage controller. If the operating
> +  system interfaces are not available, this mode behaves the same as `true`.
> +  This mode is expected to be safe on macOS for repos stored on HFS+ or APFS
> +  filesystems and on Windows for repos stored on NTFS or ReFS.

Again, even if it's called "core.fsyncObjectFiles" if we're going to say
"safe" we really need to say safe in what sense. Having written and
fsync()'d the file is helping nobody if the metadata never arrives....

> +static void do_sync_and_rename(struct string_list *fsync_state, struct lock_file *lock_file)
> +{
> +	if (fsync_state->nr) {

I think less indentation here would be nice:

    if (!fsync_state->nr)
        return;
    /* rest of unindented body */

Or better yet do this check in unplug_bulk_checkin(), then here:

    fsync_or_die();
    for_each_string_list_item() { ...}
    string_list_clear(....);


> +		struct string_list_item *rename;
> +
> +		/*
> +		 * Issue a full hardware flush against the lock file to ensure
> +		 * that all objects are durable before any renames occur.
> +		 * The code in fsync_and_close_loose_object_bulk_checkin has
> +		 * already ensured that writeout has occurred, but it has not
> +		 * flushed any writeback cache in the storage hardware.
> +		 */
> +		fsync_or_die(get_lock_file_fd(lock_file), get_lock_file_path(lock_file));
> +
> +		for_each_string_list_item(rename, fsync_state) {
> +			const char *src = rename->string;
> +			const char *dst = rename->util;
> +
> +			if (finalize_object_file(src, dst))
> +				die_errno(_("could not rename '%s' to '%s'"), src, dst);
> +		}
> +
> +		string_list_clear(fsync_state, 1);
> +	}
> +}
> +
>  static int already_written(struct bulk_checkin_state *state, struct object_id *oid)
>  {
>  	int i;
> @@ -256,6 +286,53 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
>  	return 0;
>  }
>  
> +static void add_rename_bulk_checkin(struct string_list *fsync_state,
> +				    const char *src, const char *dst)
> +{
> +	string_list_insert(fsync_state, src)->util = xstrdup(dst);
> +}

Just has one caller, why not just inline the string_list_insert()
call...

> +int fsync_and_close_loose_object_bulk_checkin(int fd, const char *tmpfile,
> +					      const char *filename, time_t mtime)
> +{
> +	int do_finalize = 1;
> +	int ret = 0;
> +
> +	if (fsync_object_files != FSYNC_OBJECT_FILES_OFF) {

Let's do postive enum comparisons, and with switch() statements, so the
compiler helps us to see if we've covered them all.

> +		/*
> +		 * If we have a plugged bulk checkin, we issue a call that
> +		 * cleans the filesystem page cache but avoids a hardware flush
> +		 * command. Later on we will issue a single hardware flush
> +		 * before renaming files as part of do_sync_and_rename.
> +		 */
> +		if (bulk_checkin_plugged &&
> +		    fsync_object_files == FSYNC_OBJECT_FILES_BATCH &&
> +		    git_fsync(fd, FSYNC_WRITEOUT_ONLY) >= 0) {
> +			add_rename_bulk_checkin(&bulk_fsync_state, tmpfile, filename);
> +			do_finalize = 0;
> +
> +		} else {
> +			fsync_or_die(fd, "loose object file");
> +		}
> +	}

So nothing ever explicitly checks FSYNC_OBJECT_FILES_ON...?

> -extern int fsync_object_files;
> +enum FSYNC_OBJECT_FILES_MODE {
> +    FSYNC_OBJECT_FILES_OFF,
> +    FSYNC_OBJECT_FILES_ON,
> +    FSYNC_OBJECT_FILES_BATCH
> +};

Style: We don't use ALL_CAPS for type names in this codebase, just the
enum labels themselves....

> +extern enum FSYNC_OBJECT_FILES_MODE fsync_object_files;

...to the point where I had to rub my eyes to see what was going on here
... :)


> -		fsync_object_files = git_config_bool(var, value);
> +		if (value && !strcmp(value, "batch"))
> +			fsync_object_files = FSYNC_OBJECT_FILES_BATCH;
> +		else if (git_config_bool(var, value))
> +			fsync_object_files = FSYNC_OBJECT_FILES_ON;
> +		else
> +			fsync_object_files = FSYNC_OBJECT_FILES_OFF;

Since the point of this setting is safety, let's explicitly check
true/false here, use git_config_maybe_bool(), and perhaps issue a
warning on unknown values, but maybe that would get too verbose...

If we have a future "supersafe" mode, it'll get mapped to "false" on
older versions of git, probably not a good idea...

>  		return 0;
>  	}
>  
> diff --git a/config.mak.uname b/config.mak.uname
> index 76516aaa9a5..e6d482fbcc6 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -53,6 +53,7 @@ ifeq ($(uname_S),Linux)
>  	HAVE_CLOCK_MONOTONIC = YesPlease
>  	# -lrt is needed for clock_gettime on glibc <= 2.16
>  	NEEDS_LIBRT = YesPlease
> +	HAVE_SYNC_FILE_RANGE = YesPlease
>  	HAVE_GETDELIM = YesPlease
>  	SANE_TEXT_GREP=-a
>  	FREAD_READS_DIRECTORIES = UnfortunatelyYes
> diff --git a/configure.ac b/configure.ac
> index 031e8d3fee8..c711037d625 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1090,6 +1090,14 @@ AC_COMPILE_IFELSE([CLOCK_MONOTONIC_SRC],
>  	[AC_MSG_RESULT([no])
>  	HAVE_CLOCK_MONOTONIC=])
>  GIT_CONF_SUBST([HAVE_CLOCK_MONOTONIC])
> +
> +#
> +# Define HAVE_SYNC_FILE_RANGE=YesPlease if sync_file_range is available.
> +GIT_CHECK_FUNC(sync_file_range,
> +	[HAVE_SYNC_FILE_RANGE=YesPlease],
> +	[HAVE_SYNC_FILE_RANGE])
> +GIT_CONF_SUBST([HAVE_SYNC_FILE_RANGE])
> +
>  #
>  # Define NO_SETITIMER if you don't have setitimer.
>  GIT_CHECK_FUNC(setitimer,
> diff --git a/environment.c b/environment.c
> index d6b22ede7ea..3e23eafff80 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -43,7 +43,7 @@ const char *git_hooks_path;
>  int zlib_compression_level = Z_BEST_SPEED;
>  int core_compression_level;
>  int pack_compression_level = Z_DEFAULT_COMPRESSION;
> -int fsync_object_files;
> +enum FSYNC_OBJECT_FILES_MODE fsync_object_files;
>  size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
>  size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
>  size_t delta_base_cache_limit = 96 * 1024 * 1024;
> diff --git a/git-compat-util.h b/git-compat-util.h
> index b46605300ab..d14e2436276 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1210,6 +1210,13 @@ __attribute__((format (printf, 1, 2))) NORETURN
>  void BUG(const char *fmt, ...);
>  #endif
>  
> +enum fsync_action {
> +    FSYNC_WRITEOUT_ONLY,
> +    FSYNC_HARDWARE_FLUSH
> +};
> +
> +int git_fsync(int fd, enum fsync_action action);
> +
>  /*
>   * Preserves errno, prints a message, but gives no warning for ENOENT.
>   * Returns 0 on success, which includes trying to unlink an object that does
> diff --git a/object-file.c b/object-file.c
> index a8be8994814..ea14c3a3483 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1859,15 +1859,6 @@ int hash_object_file(const struct git_hash_algo *algo, const void *buf,
>  	return 0;
>  }
>  
> -/* Finalize a file on disk, and close it. */
> -static void close_loose_object(int fd)
> -{
> -	if (fsync_object_files)
> -		fsync_or_die(fd, "loose object file");
> -	if (close(fd) != 0)
> -		die_errno(_("error when closing loose object file"));
> -}
> -
>  /* Size of directory component, including the ending '/' */
>  static inline int directory_size(const char *filename)
>  {
> @@ -1973,17 +1964,8 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
>  		die(_("confused by unstable object source data for %s"),
>  		    oid_to_hex(oid));
>  
> -	close_loose_object(fd);
> -
> -	if (mtime) {
> -		struct utimbuf utb;
> -		utb.actime = mtime;
> -		utb.modtime = mtime;
> -		if (utime(tmp_file.buf, &utb) < 0)
> -			warning_errno(_("failed utime() on %s"), tmp_file.buf);
> -	}
> -
> -	return finalize_object_file(tmp_file.buf, filename.buf);
> +	return fsync_and_close_loose_object_bulk_checkin(fd, tmp_file.buf,
> +							 filename.buf, mtime);
>  }
>  
>  static int freshen_loose_object(const struct object_id *oid)
> diff --git a/wrapper.c b/wrapper.c
> index 7c6586af321..bb4f9f043ce 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -540,6 +540,50 @@ int xmkstemp_mode(char *filename_template, int mode)
>  	return fd;
>  }
>  
> +int git_fsync(int fd, enum fsync_action action)
> +{
> +	switch (action) {
> +	case FSYNC_WRITEOUT_ONLY:
> +
> +#ifdef __APPLE__
> +		/*
> +		 * on macOS, fsync just causes filesystem cache writeback but does not
> +		 * flush hardware caches.
> +		 */
> +		return fsync(fd);
> +#endif
> +
> +#ifdef HAVE_SYNC_FILE_RANGE
> +		/*
> +		 * On linux 2.6.17 and above, sync_file_range is the way to issue
> +		 * a writeback without a hardware flush. An offset of 0 and size of 0
> +		 * indicates writeout of the entire file and the wait flags ensure that all
> +		 * dirty data is written to the disk (potentially in a disk-side cache)
> +		 * before we continue.
> +		 */
> +
> +		return sync_file_range(fd, 0, 0, SYNC_FILE_RANGE_WAIT_BEFORE |
> +						 SYNC_FILE_RANGE_WRITE |
> +						 SYNC_FILE_RANGE_WAIT_AFTER);
> +#endif
> +
> +		errno = ENOSYS;
> +		return -1;
> +
> +	case FSYNC_HARDWARE_FLUSH:
> +
> +#ifdef __APPLE__
> +		return fcntl(fd, F_FULLFSYNC);
> +#else
> +		return fsync(fd);
> +#endif
> +
> +	default:
> +		BUG("unexpected git_fsync(%d) call", action);
> +	}
> +
> +}
> +
>  static int warn_if_unremovable(const char *op, const char *file, int rc)
>  {
>  	int err;
> diff --git a/write-or-die.c b/write-or-die.c
> index d33e68f6abb..8f53953d4ab 100644
> --- a/write-or-die.c
> +++ b/write-or-die.c
> @@ -57,7 +57,7 @@ void fprintf_or_die(FILE *f, const char *fmt, ...)
>  
>  void fsync_or_die(int fd, const char *msg)
>  {
> -	while (fsync(fd) < 0) {
> +	while (git_fsync(fd, FSYNC_HARDWARE_FLUSH) < 0) {
>  		if (errno != EINTR)
>  			die_errno("fsync error on '%s'", msg);
>  	}


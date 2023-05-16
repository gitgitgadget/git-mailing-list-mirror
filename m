Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221A1C77B7A
	for <git@archiver.kernel.org>; Tue, 16 May 2023 22:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjEPWIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 18:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEPWIt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 18:08:49 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CAE2696
        for <git@vger.kernel.org>; Tue, 16 May 2023 15:08:47 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF40E19E325;
        Tue, 16 May 2023 18:08:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uUIEweAryJ7oPLcjxzHuAONTPEj75rThEiiAW0
        Wy/qE=; b=Tq1DBMKTj0OLTF9jzn5M+OZpwpO68wA+1YVfFtdxFHm0AsQMZig+mX
        jsxQpQPf0K+JveF6yW5HzN2XmFhZV1TGpvwwT++aypn7+LT3MXDUyQCahNzh7+3n
        B1CRmujC5CSiRpvCM72ROXPd4bUX985hYIy6q/mlFEaEODnRulx8M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAEFC19E324;
        Tue, 16 May 2023 18:08:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1AD0B19E323;
        Tue, 16 May 2023 18:08:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/6] wrapper.h: move declarations for wrapper.c
 functions from git-compat-util.h
References: <20230516170932.1358685-1-calvinwan@google.com>
        <20230516170932.1358685-3-calvinwan@google.com>
Date:   Tue, 16 May 2023 15:08:40 -0700
In-Reply-To: <20230516170932.1358685-3-calvinwan@google.com> (Calvin Wan's
        message of "Tue, 16 May 2023 17:09:27 +0000")
Message-ID: <xmqq353wszdj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37E0B946-F436-11ED-8876-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Since the functions in wrapper.c are widely used across the codebase,
> include it by default in git-compat-util.h. A future patch will remove
> now unnecessary inclusions of wrapper.h from other files.

The description taken alone implies the move in the other direction
(i.e. taking decls from wrapper.h and moving them to
git-compat-util.h), but that the patch actually does makes sense.
Slim compat-util.h by moving decls for wrapper functions that are
defined in wrapper.c to wrapper.h, but to avoid impacting the users
right away, include wrapper.h in the compat-util.h that these users
expect to find these decls in.

> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>  git-compat-util.h | 113 +---------------------------------------------
>  wrapper.h         | 111 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 112 insertions(+), 112 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 51af0a53aa..9898fe9374 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -626,8 +626,7 @@ static inline int git_has_dir_sep(const char *path)
>  #include "compat/bswap.h"
>  
>  #include "wildmatch.h"
> -
> -struct strbuf;
> +#include "wrapper.h"
>  
>  /* General helper functions */
>  NORETURN void usage(const char *err);
> @@ -1047,36 +1046,6 @@ static inline int cast_size_t_to_int(size_t a)
>  # define xalloca(size)      (xmalloc(size))
>  # define xalloca_free(p)    (free(p))
>  #endif
> -char *xstrdup(const char *str);
> -void *xmalloc(size_t size);
> -void *xmallocz(size_t size);
> -void *xmallocz_gently(size_t size);
> -void *xmemdupz(const void *data, size_t len);
> -char *xstrndup(const char *str, size_t len);
> -void *xrealloc(void *ptr, size_t size);
> -void *xcalloc(size_t nmemb, size_t size);
> -void xsetenv(const char *name, const char *value, int overwrite);
> -void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
> -const char *mmap_os_err(void);
> -void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_t offset);
> -int xopen(const char *path, int flags, ...);
> -ssize_t xread(int fd, void *buf, size_t len);
> -ssize_t xwrite(int fd, const void *buf, size_t len);
> -ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
> -int xdup(int fd);
> -FILE *xfopen(const char *path, const char *mode);
> -FILE *xfdopen(int fd, const char *mode);
> -int xmkstemp(char *temp_filename);
> -int xmkstemp_mode(char *temp_filename, int mode);
> -char *xgetcwd(void);
> -FILE *fopen_for_writing(const char *path);
> -FILE *fopen_or_warn(const char *path, const char *mode);
> -
> -/*
> - * Like strncmp, but only return zero if s is NUL-terminated and exactly len
> - * characters long.  If it is not, consider it greater than t.
> - */
> -int xstrncmpz(const char *s, const char *t, size_t len);
>  
>  /*
>   * FREE_AND_NULL(ptr) is like free(ptr) followed by ptr = NULL. Note
> @@ -1178,15 +1147,10 @@ static inline size_t xsize_t(off_t len)
>  	return (size_t) len;
>  }
>  
> -__attribute__((format (printf, 3, 4)))
> -int xsnprintf(char *dst, size_t max, const char *fmt, ...);
> -
>  #ifndef HOST_NAME_MAX
>  #define HOST_NAME_MAX 256
>  #endif
>  
> -int xgethostname(char *buf, size_t len);
> -
>  /* in ctype.c, for kwset users */
>  extern const unsigned char tolower_trans_tbl[256];
>  
> @@ -1427,72 +1391,6 @@ void bug_fl(const char *file, int line, const char *fmt, ...);
>  #endif
>  #endif
>  
> -enum fsync_action {
> -	FSYNC_WRITEOUT_ONLY,
> -	FSYNC_HARDWARE_FLUSH
> -};
> -
> -/*
> - * Issues an fsync against the specified file according to the specified mode.
> - *
> - * FSYNC_WRITEOUT_ONLY attempts to use interfaces available on some operating
> - * systems to flush the OS cache without issuing a flush command to the storage
> - * controller. If those interfaces are unavailable, the function fails with
> - * ENOSYS.
> - *
> - * FSYNC_HARDWARE_FLUSH does an OS writeout and hardware flush to ensure that
> - * changes are durable. It is not expected to fail.
> - */
> -int git_fsync(int fd, enum fsync_action action);
> -
> -/*
> - * Writes out trace statistics for fsync using the trace2 API.
> - */
> -void trace_git_fsync_stats(void);
> -
> -/*
> - * Preserves errno, prints a message, but gives no warning for ENOENT.
> - * Returns 0 on success, which includes trying to unlink an object that does
> - * not exist.
> - */
> -int unlink_or_warn(const char *path);
> - /*
> -  * Tries to unlink file.  Returns 0 if unlink succeeded
> -  * or the file already didn't exist.  Returns -1 and
> -  * appends a message to err suitable for
> -  * 'error("%s", err->buf)' on error.
> -  */
> -int unlink_or_msg(const char *file, struct strbuf *err);
> -/*
> - * Preserves errno, prints a message, but gives no warning for ENOENT.
> - * Returns 0 on success, which includes trying to remove a directory that does
> - * not exist.
> - */
> -int rmdir_or_warn(const char *path);
> -/*
> - * Calls the correct function out of {unlink,rmdir}_or_warn based on
> - * the supplied file mode.
> - */
> -int remove_or_warn(unsigned int mode, const char *path);
> -
> -/*
> - * Call access(2), but warn for any error except "missing file"
> - * (ENOENT or ENOTDIR).
> - */
> -#define ACCESS_EACCES_OK (1U << 0)
> -int access_or_warn(const char *path, int mode, unsigned flag);
> -int access_or_die(const char *path, int mode, unsigned flag);
> -
> -/* Warn on an inaccessible file if errno indicates this is an error */
> -int warn_on_fopen_errors(const char *path);
> -
> -/*
> - * Open with O_NOFOLLOW, or equivalent. Note that the fallback equivalent
> - * may be racy. Do not use this as protection against an attacker who can
> - * simultaneously create paths.
> - */
> -int open_nofollow(const char *path, int flags);
> -
>  #ifndef SHELL_PATH
>  # define SHELL_PATH "/bin/sh"
>  #endif
> @@ -1632,13 +1530,4 @@ static inline void *container_of_or_null_offset(void *ptr, size_t offset)
>  	((uintptr_t)&(ptr)->member - (uintptr_t)(ptr))
>  #endif /* !__GNUC__ */
>  
> -void sleep_millisec(int millisec);
> -
> -/*
> - * Generate len bytes from the system cryptographically secure PRNG.
> - * Returns 0 on success and -1 on error, setting errno.  The inability to
> - * satisfy the full request is an error.
> - */
> -int csprng_bytes(void *buf, size_t len);
> -
>  #endif
> diff --git a/wrapper.h b/wrapper.h
> index f0c7d0616d..c85b1328d1 100644
> --- a/wrapper.h
> +++ b/wrapper.h
> @@ -1,6 +1,42 @@
>  #ifndef WRAPPER_H
>  #define WRAPPER_H
>  
> +char *xstrdup(const char *str);
> +void *xmalloc(size_t size);
> +void *xmallocz(size_t size);
> +void *xmallocz_gently(size_t size);
> +void *xmemdupz(const void *data, size_t len);
> +char *xstrndup(const char *str, size_t len);
> +void *xrealloc(void *ptr, size_t size);
> +void *xcalloc(size_t nmemb, size_t size);
> +void xsetenv(const char *name, const char *value, int overwrite);
> +void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
> +const char *mmap_os_err(void);
> +void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_t offset);
> +int xopen(const char *path, int flags, ...);
> +ssize_t xread(int fd, void *buf, size_t len);
> +ssize_t xwrite(int fd, const void *buf, size_t len);
> +ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
> +int xdup(int fd);
> +FILE *xfopen(const char *path, const char *mode);
> +FILE *xfdopen(int fd, const char *mode);
> +int xmkstemp(char *temp_filename);
> +int xmkstemp_mode(char *temp_filename, int mode);
> +char *xgetcwd(void);
> +FILE *fopen_for_writing(const char *path);
> +FILE *fopen_or_warn(const char *path, const char *mode);
> +
> +/*
> + * Like strncmp, but only return zero if s is NUL-terminated and exactly len
> + * characters long.  If it is not, consider it greater than t.
> + */
> +int xstrncmpz(const char *s, const char *t, size_t len);
> +
> +__attribute__((format (printf, 3, 4)))
> +int xsnprintf(char *dst, size_t max, const char *fmt, ...);
> +
> +int xgethostname(char *buf, size_t len);
> +
>  /* set default permissions by passing mode arguments to open(2) */
>  int git_mkstemps_mode(char *pattern, int suffix_len, int mode);
>  int git_mkstemp_mode(char *pattern, int mode);
> @@ -33,4 +69,79 @@ void write_file(const char *path, const char *fmt, ...);
>  /* Return 1 if the file is empty or does not exists, 0 otherwise. */
>  int is_empty_or_missing_file(const char *filename);
>  
> +enum fsync_action {
> +	FSYNC_WRITEOUT_ONLY,
> +	FSYNC_HARDWARE_FLUSH
> +};
> +
> +/*
> + * Issues an fsync against the specified file according to the specified mode.
> + *
> + * FSYNC_WRITEOUT_ONLY attempts to use interfaces available on some operating
> + * systems to flush the OS cache without issuing a flush command to the storage
> + * controller. If those interfaces are unavailable, the function fails with
> + * ENOSYS.
> + *
> + * FSYNC_HARDWARE_FLUSH does an OS writeout and hardware flush to ensure that
> + * changes are durable. It is not expected to fail.
> + */
> +int git_fsync(int fd, enum fsync_action action);
> +
> +/*
> + * Writes out trace statistics for fsync using the trace2 API.
> + */
> +void trace_git_fsync_stats(void);
> +
> +/*
> + * Preserves errno, prints a message, but gives no warning for ENOENT.
> + * Returns 0 on success, which includes trying to unlink an object that does
> + * not exist.
> + */
> +int unlink_or_warn(const char *path);
> + /*
> +  * Tries to unlink file.  Returns 0 if unlink succeeded
> +  * or the file already didn't exist.  Returns -1 and
> +  * appends a message to err suitable for
> +  * 'error("%s", err->buf)' on error.
> +  */
> +int unlink_or_msg(const char *file, struct strbuf *err);
> +/*
> + * Preserves errno, prints a message, but gives no warning for ENOENT.
> + * Returns 0 on success, which includes trying to remove a directory that does
> + * not exist.
> + */
> +int rmdir_or_warn(const char *path);
> +/*
> + * Calls the correct function out of {unlink,rmdir}_or_warn based on
> + * the supplied file mode.
> + */
> +int remove_or_warn(unsigned int mode, const char *path);
> +
> +/*
> + * Call access(2), but warn for any error except "missing file"
> + * (ENOENT or ENOTDIR).
> + */
> +#define ACCESS_EACCES_OK (1U << 0)
> +int access_or_warn(const char *path, int mode, unsigned flag);
> +int access_or_die(const char *path, int mode, unsigned flag);
> +
> +/* Warn on an inaccessible file if errno indicates this is an error */
> +int warn_on_fopen_errors(const char *path);
> +
> +/*
> + * Open with O_NOFOLLOW, or equivalent. Note that the fallback equivalent
> + * may be racy. Do not use this as protection against an attacker who can
> + * simultaneously create paths.
> + */
> +int open_nofollow(const char *path, int flags);
> +
> +void sleep_millisec(int millisec);
> +
> +/*
> + * Generate len bytes from the system cryptographically secure PRNG.
> + * Returns 0 on success and -1 on error, setting errno.  The inability to
> + * satisfy the full request is an error.
> + */
> +int csprng_bytes(void *buf, size_t len);
> +
>  #endif /* WRAPPER_H */

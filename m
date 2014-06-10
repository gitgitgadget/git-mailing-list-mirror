From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v14 06/40] refs.c: add an err argument to repack_without_refs
Date: Tue, 10 Jun 2014 14:46:07 -0700
Message-ID: <CAL=YDWm7m8kagvnePKeosAg+ABH3oXFuunw+i8-3Fa-KPsRbzQ@mail.gmail.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
	<1402093758-3162-7-git-send-email-sahlberg@google.com>
	<20140610201006.GA5915@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 23:46:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuTrz-0001OH-OS
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 23:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521AbaFJVqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 17:46:10 -0400
Received: from mail-ve0-f180.google.com ([209.85.128.180]:36957 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136AbaFJVqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 17:46:09 -0400
Received: by mail-ve0-f180.google.com with SMTP id jw12so6161128veb.39
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 14:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=h+9z3yHNEm45KNLgLj69BT1UpGOgsNAFa61rDVv7KEk=;
        b=ZyY7LZnD2Ue8mEbTPTcageAO7HaJmKoidzkdwBLntlymkzxfsFu3rXEPNSWyg1UuZG
         7R5zqUC/OMJG7MqS46c/2xZoLfXIR5yxm8/dLP9ya50jWj1+yw04V9klaXbLW/3YXbcO
         pto5No1P+V7xXE4gtlM07JPlrRIGofhHz4IhsozI//nMXAsMNtxzZ24VAGE5dnYyhTNn
         BAOBBcFI5TS+DuxhU7CLfzgcyxEOZ0qXrghRDoJIT20lR7nMSITSOonz0JhwF96okFCB
         cf4Wc4F6mrkrfz46xBLgWEw8pAmcG3W9buuDvsgnt1s94U4wn8COu8Y883MlkQGI1/Lg
         OS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=h+9z3yHNEm45KNLgLj69BT1UpGOgsNAFa61rDVv7KEk=;
        b=fwfQh2Q8LZNoiZZxISTNwG8k8qc0btQy8Mn6P6kQJlOVcs3ats5m8DF9y2C9uttEgm
         H499zWlp360P/xu+nPVWJvC+dvkDMeOygPWgQ2X2knEuHaD922VLPggomUmQAJx8yGQj
         n1SnLlVmtglPyidC1hH5g72oqpa56uETxFAR/hL1mDkX5wM4qlH68eRXwyflkkFJA4E6
         K6cggexsJrJB2kAvlSCNrsW5af89DtrJrQoJrj/TJ6ALmZee6ysM+mxFCg+GUvQ5qwax
         1GbTKNEHvi7L6gvGXz/sitzQo4+3uBOa8qB4or+q8T4dLBrjii4YrPk1zuKvmgL82NgG
         4G5A==
X-Gm-Message-State: ALoCoQkoThBXZBiO9Zsur8SVZKxrXQfDvPD8+BeLGIawHof4fBW2rL2/o82W7GuLazz3SRZK8au0
X-Received: by 10.52.14.9 with SMTP id l9mr29007648vdc.41.1402436767772; Tue,
 10 Jun 2014 14:46:07 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Tue, 10 Jun 2014 14:46:07 -0700 (PDT)
In-Reply-To: <20140610201006.GA5915@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251262>

Thanks.

On Tue, Jun 10, 2014 at 1:10 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Update repack_without_refs to take an err argument and update it if there
>> is a failure. Pass the err variable from ref_transaction_commit to this
>> function so that callers can print a meaningful error message if _commit
>> fails due to a problem in repack_without_refs.
>>
>> Add a new function unable_to_lock_message that takes a strbuf argument and
>> fills in the reason for the failure.
>>
>> In commit_packed_refs, make sure that we propagate any errno that
>> commit_lock_file might have set back to our caller.
>>
>> Make sure both commit_packed_refs and lock_file has errno set to a meaningful
>> value on error. Update a whole bunch of other places to keep errno from
>> beeing clobbered.
>
> This patch is doing several (all nice) things.  Are they connected?
> Would splitting some of them out into separate patches make sense or
> would it be too much fuss to be worth the trouble?
>
> [...]
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -559,6 +559,8 @@ struct lock_file {
>>  #define LOCK_DIE_ON_ERROR 1
>>  #define LOCK_NODEREF 2
>>  extern int unable_to_lock_error(const char *path, int err);
>> +extern void unable_to_lock_message(const char *path, int err,
>> +                                struct strbuf *buf);
>
> Introducing a new unable_to_lock_message helper, which has nicer
> semantics than unable_to_lock_error and cleans up lockfile.c a little.
>

Done.

> [...]
>> --- a/lockfile.c
>> +++ b/lockfile.c
>> @@ -121,7 +121,7 @@ static char *resolve_symlink(char *p, size_t s)
>>       return p;
>>  }
>>
>> -
>> +/* Make sure errno contains a meaningful value on error */
>>  static int lock_file(struct lock_file *lk, const char *path, int flags)
>
> Making errno when returning from lock_file() meaningful, which should
> fix
>
>  * an existing almost-bug in lock_ref_sha1_basic where it assumes
>    errno==ENOENT is meaningful and could waste some work on retries
>
>  * an existing bug in repack_without_refs where it prints
>    strerror(errno) and picks advice based on errno, despite errno
>    potentially being zero and potentially having been clobbered by
>    that point
>
> To make sure we don't lose these fixes, it would be helpful to also
> mention that errno is set in the API documentation for the relevant
> functions:
>
>  * hold_lock_file_for_update (declared in cache.h)
>  * lock_packed_refs (declared in refs.h)

Done.

>
> [...]
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1333,8 +1333,10 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
>
> Making errno when returning from resolve_ref_unsafe() meaningful,
> which should fix
>
>  * a bug in lock_ref_sha1_basic, where it assumes EISDIR
>    means it failed due to a directory being in the way
>
> To make sure we don't lose this fix, it would be helpful to change
> Michael's understated comment (why wasn't it marked with NEEDSWORK,
> btw?)
>
>          * errno is sometimes set on errors, but not always.
>
> to describe the new guarantee.

Done.

>
> [...]
>> @@ -1908,14 +1918,17 @@ static struct ref_lock *verify_lock(struct ref_lock *lock,
>
> Making errno when returning from verify_lock() meaningful, which
> should almost but not completely fix
>
>  * a bug in "git fetch"'s s_update_ref, which trusts the result of an
>    errno == ENOTDIR check to detect D/F conflicts
>
> To make sure we don't lose this fix, it would be helpful to also
> mention that errno is set in the API documentation for the relevant
> functions:
>
>  * lock_any_ref_for_update (declared in refs.h), after handling the
>    check_refname_format case
>  * lock_ref_sha1_basic
>
> ENOTDIR makes sense as a sign that a file was in the way of a
> directory we wanted to create.  Should "git fetch" also look for
> ENOTEMPTY or EEXIST to catch cases where a directory was in the way
> of a file to be created?
>

Done.

>> @@ -1928,13 +1941,15 @@ static int remove_empty_directories(const char *file)
>
> Making errno when returning from remove_empty_directories() more
> obviously meaningful, which should provide some peace of mind for
> people auditing lock_ref_sha1_basic.
>

Done.

> [...]
>> @@ -2203,11 +2218,16 @@ int lock_packed_refs(int flags)
> [...]
>>  int commit_packed_refs(void)
>
> Making errno when returning from commit_packed_refs() meaningful,
> which should fix
>
>  * a bug in "git clone" where it prints strerror(errno) based on
>    errno, despite errno possibly being zero and potentially having
>    been clobbered by that point
>  * the same kind of bug in "git pack-refs"
>
> and prepares for repack_without_refs() to get a meaningful
> error message when commit_packed_refs() fails without falling into
> the same bug.
>
> To make sure we don't lose this fix, it would be helpful to also
> mention that errno is set in the API documentation for
> commit_packed_refs in refs.h.
>

Done.

> [...]
>> @@ -2427,12 +2450,12 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
>>       return 0;
>>  }
>>
>> -static int repack_without_refs(const char **refnames, int n)
>> +static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
>
> Adding an 'err' argument to repack_without_refs and writing to it on
> error.
>

Done.

> [...]
>> @@ -2723,9 +2755,12 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
>
> Making errno when returning from log_ref_setup() meaningful,
> presumably as preparation for making errno from log_ref_write()
> and write_ref_sha1() meaningful.
>
> To make sure we don't break it by mistake, it would be helpful to also
> mention that errno is set in the API documentation for log_ref_setup
> in refs.h (or to make that function static --- why is it public?).
>

Done.

> [...]
>> @@ -2784,8 +2826,19 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
>
> Making errno from log_ref_write() meaningful.
>
> [...]
>> @@ -2800,8 +2853,10 @@ int write_ref_sha1(struct ref_lock *lock,
>
> Making errno from write_ref_sha1() meaningful, which should fix
>
>  * a bug in "git checkout -b" where it prints strerror(errno)
>    despite errno possibly being zero or clobbered
>
>  * a bug in "git fetch"'s s_update_ref, which trusts the result of an
>    errno == ENOTDIR check to detect D/F conflicts
>
> To make sure we don't lose these fixes, it would be helpful to also
> mention that errno is set in the API documentation for write_ref_sha1
> in refs.h.

Done.

>
> So this could potentially be multiple patches:
>
>  1. Set errno in lock_packed_refs, fixing a bug in repack_without_refs
>  2. Set errno in resolve_ref_unsafe, fixing a longstanding TODO
>  3. Set errno in lock_any_ref_for_update, tightening half of the D/F check
>  4. Set errno in commit_packed_refs, fixing a bug in clone, packed-refs
>  5. Set errno in log_ref_setup, log_ref_write, and write_ref_sha1,
>     fixing a bug in 'checkout -b' and the other half of the D/F check
>  6. Introduce unable_to_lock_message helper
>  7. Add an 'err' argument to repack_without_refs and write to it.

I split it up into a bunch of patches.


>
> diff --git i/cache.h w/cache.h
> index 8b12aa8..0b844c3 100644
> --- i/cache.h
> +++ w/cache.h
> @@ -562,8 +562,10 @@ extern int unable_to_lock_error(const char *path, int err);
>  extern void unable_to_lock_message(const char *path, int err,
>                                    struct strbuf *buf);
>  extern NORETURN void unable_to_lock_index_die(const char *path, int err);
> +/* Sets errno on error. */
>  extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
>  extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
> +/* Sets errno on error. */
>  extern int commit_lock_file(struct lock_file *);
>  extern void update_index_if_able(struct index_state *, struct lock_file *);
>
> @@ -785,6 +787,11 @@ enum sharedrepo {
>         PERM_EVERYBODY      = 0664
>  };
>  int git_config_perm(const char *var, const char *value);
> +
> +/*
> + * Widens permissions on 'path' to respect core.sharedrepository.
> + * Sets errno on error.
> + */
>  int adjust_shared_perm(const char *path);
>
>  /*
> @@ -979,7 +986,7 @@ extern int read_ref(const char *refname, unsigned char *sha1);
>   * NULL.  If more than MAXDEPTH recursive symbolic lookups are needed,
>   * give up and return NULL.
>   *
> - * errno is sometimes set on errors, but not always.
> + * On error, sets errno to indicate what went wrong.
>   */
>  extern const char *resolve_ref_unsafe(const char *ref, unsigned char *sha1, int reading, int *flag);
>  extern char *resolve_refdup(const char *ref, unsigned char *sha1, int reading, int *flag);
> diff --git i/dir.c w/dir.c
> index eb6f581..daab7b0 100644
> --- i/dir.c
> +++ w/dir.c
> @@ -1527,7 +1527,8 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
>  {
>         DIR *dir;
>         struct dirent *e;
> -       int ret = 0, original_len = path->len, len, kept_down = 0;
> +       int ret = 0, save_errno = 0;
> +       int original_len = path->len, len, kept_down = 0;
>         int only_empty = (flag & REMOVE_DIR_EMPTY_ONLY);
>         int keep_toplevel = (flag & REMOVE_DIR_KEEP_TOPLEVEL);
>         unsigned char submodule_head[20];
> @@ -1582,20 +1583,23 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
>                 }
>
>                 /* path too long, stat fails, or non-directory still exists */
> +               save_errno = errno;
>                 ret = -1;
>                 break;
>         }
>         closedir(dir);
>
>         strbuf_setlen(path, original_len);
> -       if (!ret && !keep_toplevel && !kept_down)
> -               ret = (!rmdir(path->buf) || errno == ENOENT) ? 0 : -1;
> -       else if (kept_up)
> +       if (!ret && !keep_toplevel && !kept_down) {
> +               if (rmdir(path->buf) && errno != ENOENT)
> +                       return -1;
> +       } else if (kept_up)
>                 /*
>                  * report the uplevel that it is not an error that we
>                  * did not rmdir() our directory.
>                  */
>                 *kept_up = !ret;
> +       errno = save_errno;
>         return ret;
>  }
>
> diff --git i/dir.h w/dir.h
> index 55e5345..c44afbb 100644
> --- i/dir.h
> +++ w/dir.h
> @@ -185,6 +185,7 @@ extern int is_empty_dir(const char *dir);
>
>  extern void setup_standard_excludes(struct dir_struct *dir);
>
> +/* sets errno on error */
>  #define REMOVE_DIR_EMPTY_ONLY 01
>  #define REMOVE_DIR_KEEP_NESTED_GIT 02
>  #define REMOVE_DIR_KEEP_TOPLEVEL 04
> diff --git i/refs.c w/refs.c
> index 7ec1f32..53d8bc7 100644
> --- i/refs.c
> +++ w/refs.c
> @@ -1295,6 +1295,8 @@ static struct ref_entry *get_packed_ref(const char *refname)
>  /*
>   * A loose ref file doesn't exist; check for a packed ref.  The
>   * options are forwarded from resolve_safe_unsafe().
> + *
> + * Sets errno on error.
>   */
>  static const char *handle_missing_loose_ref(const char *refname,
>                                             unsigned char *sha1,
> @@ -1316,6 +1318,7 @@ static const char *handle_missing_loose_ref(const char *refname,
>         }
>         /* The reference is not a packed reference, either. */
>         if (reading) {
> +               errno = ENOENT;
>                 return NULL;
>         } else {
>                 hashclr(sha1);
> @@ -1413,7 +1416,7 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
>                         int save_errno = errno;
>                         close(fd);
>                         errno = save_errno;
> -                       return NULL;
> +                       return NULL;
>                 }
>                 close(fd);
>                 while (len && isspace(buffer[len-1]))
> @@ -1949,9 +1952,9 @@ static int remove_empty_directories(const char *file)
>         result = remove_dir_recursively(&path, REMOVE_DIR_EMPTY_ONLY);
>         save_errno = errno;
>
> -       errno = save_errno;
>         strbuf_release(&path);
>
> +       errno = save_errno;
>         return result;
>  }
>
> @@ -2039,6 +2042,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
>         return logs_found;
>  }
>
> +/* Sets errno on error. */
>  static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>                                             const unsigned char *old_sha1,
>                                             int flags, int *type_p)
> @@ -2152,8 +2156,10 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
>                                          const unsigned char *old_sha1,
>                                          int flags, int *type_p)
>  {
> -       if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
> +       if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
> +               errno = EINVAL;
>                 return NULL;
> +       }
>         return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
>  }
>
> @@ -2218,10 +2224,6 @@ int lock_packed_refs(int flags)
>         return 0;
>  }
>
> -/*
> - * Commit the packed refs changes.
> - * On error we must make sure that errno contains a meaningful value.
> - */
>  int commit_packed_refs(void)
>  {
>         struct packed_ref_cache *packed_ref_cache =
> @@ -2776,7 +2778,7 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
>                                       logfile);
>                                 errno = save_errno;
>                                 return -1;
> -                       }
> +                       }
>                         logfd = open(logfile, oflags, 0666);
>                 }
>
> @@ -2794,6 +2796,7 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
>         return 0;
>  }
>
> +/* Sets errno on error. */
>  static int log_ref_write(const char *refname, const unsigned char *old_sha1,
>                          const unsigned char *new_sha1, const char *msg)
>  {
> @@ -2824,7 +2827,9 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
>                       committer);
>         if (msglen)
>                 len += copy_msg(logrec + len - 1, msg) - 1;
> -       written = len <= maxlen ? write_in_full(logfd, logrec, len) : -1;
> +       if (len > maxlen)
> +               die("BUG: log_ref_write buffer not large enough?");
> +       written = write_in_full(logfd, logrec, len);
>         free(logrec);
>         if (written != len) {
>                 int save_errno = errno;
> @@ -2867,7 +2872,7 @@ int write_ref_sha1(struct ref_lock *lock,
>                         lock->ref_name, sha1_to_hex(sha1));
>                 unlock_ref(lock);
>                 errno = EINVAL;
> -                       return -1;
> +               return -1;
>         }
>         if (o->type != OBJ_COMMIT && is_branch(lock->ref_name)) {
>                 error("Trying to write non-commit object %s to branch %s",
> @@ -2889,7 +2894,9 @@ int write_ref_sha1(struct ref_lock *lock,
>         if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
>             (strcmp(lock->ref_name, lock->orig_ref_name) &&
>              log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
> +               int save_errno = errno;
>                 unlock_ref(lock);
> +               errno = save_errno;
>                 return -1;
>         }
>         if (strcmp(lock->orig_ref_name, "HEAD") != 0) {
> @@ -2914,8 +2921,10 @@ int write_ref_sha1(struct ref_lock *lock,
>                         log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
>         }
>         if (commit_ref(lock)) {
> +               int save_errno = errno;
>                 error("Couldn't set %s", lock->ref_name);
>                 unlock_ref(lock);
> +               errno = save_errno;
>                 return -1;
>         }
>         unlock_ref(lock);
> diff --git i/refs.h w/refs.h
> index 94d4cd4..c734944 100644
> --- i/refs.h
> +++ w/refs.h
> @@ -81,6 +81,7 @@ extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refn
>  /*
>   * Lock the packed-refs file for writing.  Flags is passed to
>   * hold_lock_file_for_update().  Return 0 on success.
> + * On error, sets errno to indicate what went wrong.
>   */
>  extern int lock_packed_refs(int flags);
>
> @@ -96,6 +97,7 @@ extern void add_packed_ref(const char *refname, const unsigned char *sha1);
>   * Write the current version of the packed refs cache from memory to
>   * disk.  The packed-refs file must already be locked for writing (see
>   * lock_packed_refs()).  Return zero on success.
> + * On error, sets errno to indicate what went wrong.
>   */
>  extern int commit_packed_refs(void);
>
> @@ -135,7 +137,10 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
>  /** Locks a "refs/" ref returning the lock on success and NULL on failure. **/
>  extern struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1);
>
> -/** Locks any ref (for 'HEAD' type refs). */
> +/**
> + * Locks any ref (for 'HEAD' type refs).
> + * On error, returns NULL and sets errno to describe the error.
> + */
>  #define REF_NODEREF    0x01
>  extern struct ref_lock *lock_any_ref_for_update(const char *refname,
>                                                 const unsigned char *old_sha1,
> @@ -144,16 +149,25 @@ extern struct ref_lock *lock_any_ref_for_update(const char *refname,
>  /** Close the file descriptor owned by a lock and return the status */
>  extern int close_ref(struct ref_lock *lock);
>
> -/** Close and commit the ref locked by the lock */
> +/**
> + * Close and commit the ref locked by the lock.
> + * Sets errno on error.
> + */
>  extern int commit_ref(struct ref_lock *lock);
>
>  /** Release any lock taken but not written. **/
>  extern void unlock_ref(struct ref_lock *lock);
>
> -/** Writes sha1 into the ref specified by the lock. **/
> +/**
> + * Writes sha1 into the ref specified by the lock.
> + * Sets errno on error.
> + */
>  extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
>
> -/** Setup reflog before using. **/
> +/**
> + * Setup reflog before using.
> + * Sets errno on error.
> + */
>  int log_ref_setup(const char *refname, char *logfile, int bufsize);
>
>  /** Reads log for the value of ref during at_time. **/

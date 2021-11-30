Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB94C433FE
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344177AbhK3Va6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344117AbhK3Vav (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:30:51 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C23CC061746
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:27:31 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id e3so92568454edu.4
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O6dss0cQuwXYMjhj0GQkzI2P/M9wtTkQBgT9BeQTzy4=;
        b=RnUghb+wG+/SftYHuuwQPyhUNzP0299nLMlNKDV9N+wWZ+fly9JEzOSM600xg4BjdO
         +mT2Ds9GHAhetI+uY/CO+DSTGj36CqWbsxGImkR0igZAoQwa0gLWZbRWl2i2xeyKA3VQ
         9mPr6kBi+ruaZKMvn45AoeogGDpF3aFQYnYPQ5xceXiij/I20i4bz1+VyyaCWaYxXqjl
         mum68OJn8zHmUnXTF7Q6PxpEJvMKaDvZLlXmiTWRPsxNMfKWdklPnnIAR0k2l1wl9gtB
         DGajGZYO3NvC+2Kp/5SrMVl5X8J4dnOWM7UUoRzIchKFd11UrJ8gxWcpYpklW86gqMFe
         0N4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O6dss0cQuwXYMjhj0GQkzI2P/M9wtTkQBgT9BeQTzy4=;
        b=hbH3/DVr5rwz9DFMYqGGF5vJYS8fQuis4PmYwbrItwS8Zu+OYpz9DhwYKl6XTPNPJC
         ZQjHy4RXrFmN3RJ+gtx9B+J04DoHDKPIO9dZNqRt5X0nFZO6Ag5bJ05xDEmCYtseMRjq
         WtRT2vVoxRnU//JVrWPzwSWUKSqElBGZdFT3mripFd2DCrqp3iN0O5DcF7Kh6IrOL5GU
         WIHh8lCP7+KtlR9jzcL6gsvhrjOaFkwfJPIjgOIA/8mdKX/1sFBE104kCJsalcyGDjqi
         hCk+h/We4EMuoj80qXK0wUb9M7qoPttJlMA5ftIqwQ+pPnVR9ItsmB8NzolRGdf8O9Vf
         AqrQ==
X-Gm-Message-State: AOAM532FJ/m2m88Y9BX3PQ9ZXKlD/rmVTmlE9MVoWml8Lp5RQ3mmyugE
        HlOgQXY6IQKcMHY63iuCHHQRfza03u9JiSiohiA=
X-Google-Smtp-Source: ABdhPJzWxiB7UPhBQq3F6ONuNxetvAccJS5zQrR1Gh74V7Ti8O/QyOnhiWKj9j1RW09xwrlbq/Kjo0WMnPyJhcDTk6E=
X-Received: by 2002:a17:906:31c2:: with SMTP id f2mr1910471ejf.341.1638307649403;
 Tue, 30 Nov 2021 13:27:29 -0800 (PST)
MIME-Version: 1.0
References: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
 <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com> <6b27afa60e05c6c0b7752f1bcf6629c446ede520.1637020263.git.gitgitgadget@gmail.com>
In-Reply-To: <6b27afa60e05c6c0b7752f1bcf6629c446ede520.1637020263.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 30 Nov 2021 13:27:18 -0800
Message-ID: <CABPp-BH6m4q_EoX77bqLcpCN1HRfJ_XayeCV2O0sRybX53rPrw@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] tmp-objdir: new API for creating temporary
 writable databases
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 15, 2021 at 3:51 PM Neeraj Singh via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Neeraj Singh <neerajsi@microsoft.com>
>
> The tmp_objdir API provides the ability to create temporary object
> directories, but was designed with the goal of having subprocesses
> access these object stores, followed by the main process migrating
> objects from it to the main object store or just deleting it.  The
> subprocesses would view it as their primary datastore and write to it.
>
> Here we add the tmp_objdir_replace_primary_odb function that replaces
> the current process's writable "main" object directory with the
> specified one. The previous main object directory is restored in either
> tmp_objdir_migrate or tmp_objdir_destroy.
>
> For the --remerge-diff usecase, add a new `will_destroy` flag in `struct
> object_database` to mark ephemeral object databases that do not require
> fsync durability.
>
> Add 'git prune' support for removing temporary object databases, and
> make sure that they have a name starting with tmp_ and containing an
> operation-specific name.
>
> Based-on-patch-by: Elijah Newren <newren@gmail.com>
>
> Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/prune.c        | 23 +++++++++++++++---
>  builtin/receive-pack.c |  2 +-
>  environment.c          |  5 ++++
>  object-file.c          | 44 +++++++++++++++++++++++++++++++--
>  object-store.h         | 19 +++++++++++++++
>  object.c               |  2 +-
>  tmp-objdir.c           | 55 +++++++++++++++++++++++++++++++++++++++---
>  tmp-objdir.h           | 29 +++++++++++++++++++---
>  8 files changed, 165 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/prune.c b/builtin/prune.c
> index 485c9a3c56f..a76e6a5f0e8 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -18,6 +18,7 @@ static int show_only;
>  static int verbose;
>  static timestamp_t expire;
>  static int show_progress = -1;
> +static struct strbuf remove_dir_buf = STRBUF_INIT;
>
>  static int prune_tmp_file(const char *fullpath)
>  {
> @@ -26,10 +27,20 @@ static int prune_tmp_file(const char *fullpath)
>                 return error("Could not stat '%s'", fullpath);
>         if (st.st_mtime > expire)
>                 return 0;
> -       if (show_only || verbose)
> -               printf("Removing stale temporary file %s\n", fullpath);
> -       if (!show_only)
> -               unlink_or_warn(fullpath);
> +       if (S_ISDIR(st.st_mode)) {
> +               if (show_only || verbose)
> +                       printf("Removing stale temporary directory %s\n", fullpath);
> +               if (!show_only) {
> +                       strbuf_reset(&remove_dir_buf);
> +                       strbuf_addstr(&remove_dir_buf, fullpath);
> +                       remove_dir_recursively(&remove_dir_buf, 0);

Why not just define remove_dir_buf here rather than as a global?  It'd
not only make the code more readable by keeping everything localized,
it would have prevented the forgotten strbuf_reset() bug from the
earlier round of this patch.

Sure, that'd be an extra memory allocation/free for each directory you
hit, which should be negligible compared to the cost of
remove_dir_recursively()...and I'm not sure this is performance
critical anyway (I don't see why we'd expect more than O(1) cruft
temporary directories).

> +               }
> +       } else {
> +               if (show_only || verbose)
> +                       printf("Removing stale temporary file %s\n", fullpath);
> +               if (!show_only)
> +                       unlink_or_warn(fullpath);
> +       }
>         return 0;
>  }
>
> @@ -97,6 +108,9 @@ static int prune_cruft(const char *basename, const char *path, void *data)
>
>  static int prune_subdir(unsigned int nr, const char *path, void *data)
>  {
> +       if (verbose)

Shouldn't this be
    if (show_only || verbose)
?

> +               printf("Removing directory %s\n", path);
> +
>         if (!show_only)
>                 rmdir(path);
>         return 0;
> @@ -184,5 +198,6 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
>                 prune_shallow(show_only ? PRUNE_SHOW_ONLY : 0);
>         }
>
> +       strbuf_release(&remove_dir_buf);
>         return 0;
>  }
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 49b846d9605..8815e24cde5 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -2213,7 +2213,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
>                 strvec_push(&child.args, alt_shallow_file);
>         }
>
> -       tmp_objdir = tmp_objdir_create();
> +       tmp_objdir = tmp_objdir_create("incoming");
>         if (!tmp_objdir) {
>                 if (err_fd > 0)
>                         close(err_fd);
> diff --git a/environment.c b/environment.c
> index 9da7f3c1a19..342400fcaad 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -17,6 +17,7 @@
>  #include "commit.h"
>  #include "strvec.h"
>  #include "object-store.h"
> +#include "tmp-objdir.h"
>  #include "chdir-notify.h"
>  #include "shallow.h"
>
> @@ -331,10 +332,14 @@ static void update_relative_gitdir(const char *name,
>                                    void *data)
>  {
>         char *path = reparent_relative_path(old_cwd, new_cwd, get_git_dir());
> +       struct tmp_objdir *tmp_objdir = tmp_objdir_unapply_primary_odb();
>         trace_printf_key(&trace_setup_key,
>                          "setup: move $GIT_DIR to '%s'",
>                          path);
> +
>         set_git_dir_1(path);
> +       if (tmp_objdir)
> +               tmp_objdir_reapply_primary_odb(tmp_objdir, old_cwd, new_cwd);
>         free(path);
>  }
>
> diff --git a/object-file.c b/object-file.c
> index c3d866a287e..0b6a61aeaff 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -683,6 +683,43 @@ void add_to_alternates_memory(const char *reference)
>                              '\n', NULL, 0);
>  }
>
> +struct object_directory *set_temporary_primary_odb(const char *dir, int will_destroy)
> +{
> +       struct object_directory *new_odb;
> +
> +       /*
> +        * Make sure alternates are initialized, or else our entry may be
> +        * overwritten when they are.
> +        */
> +       prepare_alt_odb(the_repository);
> +
> +       /*
> +        * Make a new primary odb and link the old primary ODB in as an
> +        * alternate
> +        */
> +       new_odb = xcalloc(1, sizeof(*new_odb));
> +       new_odb->path = xstrdup(dir);
> +       new_odb->will_destroy = will_destroy;
> +       new_odb->next = the_repository->objects->odb;
> +       the_repository->objects->odb = new_odb;
> +       return new_odb->next;
> +}
> +
> +void restore_primary_odb(struct object_directory *restore_odb, const char *old_path)
> +{
> +       struct object_directory *cur_odb = the_repository->objects->odb;
> +
> +       if (strcmp(old_path, cur_odb->path))
> +               BUG("expected %s as primary object store; found %s",
> +                   old_path, cur_odb->path);
> +
> +       if (cur_odb->next != restore_odb)
> +               BUG("we expect the old primary object store to be the first alternate");
> +
> +       the_repository->objects->odb = restore_odb;
> +       free_object_directory(cur_odb);
> +}
> +
>  /*
>   * Compute the exact path an alternate is at and returns it. In case of
>   * error NULL is returned and the human readable error is added to `err`
> @@ -1809,8 +1846,11 @@ int hash_object_file(const struct git_hash_algo *algo, const void *buf,
>  /* Finalize a file on disk, and close it. */
>  static void close_loose_object(int fd)
>  {
> -       if (fsync_object_files)
> -               fsync_or_die(fd, "loose object file");
> +       if (!the_repository->objects->odb->will_destroy) {
> +               if (fsync_object_files)
> +                       fsync_or_die(fd, "loose object file");
> +       }
> +
>         if (close(fd) != 0)
>                 die_errno(_("error when closing loose object file"));
>  }
> diff --git a/object-store.h b/object-store.h
> index 952efb6a4be..cb173e69392 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -27,6 +27,11 @@ struct object_directory {
>         uint32_t loose_objects_subdir_seen[8]; /* 256 bits */
>         struct oidtree *loose_objects_cache;
>
> +       /*
> +        * This object store is ephemeral, so there is no need to fsync.
> +        */
> +       int will_destroy;
> +
>         /*
>          * Path to the alternative object store. If this is a relative path,
>          * it is relative to the current working directory.
> @@ -58,6 +63,17 @@ void add_to_alternates_file(const char *dir);
>   */
>  void add_to_alternates_memory(const char *dir);
>
> +/*
> + * Replace the current writable object directory with the specified temporary
> + * object directory; returns the former primary object directory.
> + */
> +struct object_directory *set_temporary_primary_odb(const char *dir, int will_destroy);
> +
> +/*
> + * Restore a previous ODB replaced by set_temporary_main_odb.
> + */
> +void restore_primary_odb(struct object_directory *restore_odb, const char *old_path);
> +
>  /*
>   * Populate and return the loose object cache array corresponding to the
>   * given object ID.
> @@ -68,6 +84,9 @@ struct oidtree *odb_loose_cache(struct object_directory *odb,
>  /* Empty the loose object cache for the specified object directory. */
>  void odb_clear_loose_cache(struct object_directory *odb);
>
> +/* Clear and free the specified object directory */
> +void free_object_directory(struct object_directory *odb);
> +
>  struct packed_git {
>         struct hashmap_entry packmap_ent;
>         struct packed_git *next;
> diff --git a/object.c b/object.c
> index 23a24e678a8..048f96a260e 100644
> --- a/object.c
> +++ b/object.c
> @@ -513,7 +513,7 @@ struct raw_object_store *raw_object_store_new(void)
>         return o;
>  }
>
> -static void free_object_directory(struct object_directory *odb)
> +void free_object_directory(struct object_directory *odb)
>  {
>         free(odb->path);
>         odb_clear_loose_cache(odb);
> diff --git a/tmp-objdir.c b/tmp-objdir.c
> index b8d880e3626..3d38eeab66b 100644
> --- a/tmp-objdir.c
> +++ b/tmp-objdir.c
> @@ -1,5 +1,6 @@
>  #include "cache.h"
>  #include "tmp-objdir.h"
> +#include "chdir-notify.h"
>  #include "dir.h"
>  #include "sigchain.h"
>  #include "string-list.h"
> @@ -11,6 +12,8 @@
>  struct tmp_objdir {
>         struct strbuf path;
>         struct strvec env;
> +       struct object_directory *prev_odb;
> +       int will_destroy;
>  };
>
>  /*
> @@ -38,6 +41,9 @@ static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signal)
>         if (t == the_tmp_objdir)
>                 the_tmp_objdir = NULL;
>
> +       if (!on_signal && t->prev_odb)
> +               restore_primary_odb(t->prev_odb, t->path.buf);
> +
>         /*
>          * This may use malloc via strbuf_grow(), but we should
>          * have pre-grown t->path sufficiently so that this
> @@ -52,6 +58,7 @@ static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signal)
>          */
>         if (!on_signal)
>                 tmp_objdir_free(t);
> +
>         return err;
>  }
>
> @@ -121,7 +128,7 @@ static int setup_tmp_objdir(const char *root)
>         return ret;
>  }
>
> -struct tmp_objdir *tmp_objdir_create(void)
> +struct tmp_objdir *tmp_objdir_create(const char *prefix)
>  {
>         static int installed_handlers;
>         struct tmp_objdir *t;
> @@ -129,11 +136,16 @@ struct tmp_objdir *tmp_objdir_create(void)
>         if (the_tmp_objdir)
>                 BUG("only one tmp_objdir can be used at a time");
>
> -       t = xmalloc(sizeof(*t));
> +       t = xcalloc(1, sizeof(*t));
>         strbuf_init(&t->path, 0);
>         strvec_init(&t->env);
>
> -       strbuf_addf(&t->path, "%s/incoming-XXXXXX", get_object_directory());
> +       /*
> +        * Use a string starting with tmp_ so that the builtin/prune.c code
> +        * can recognize any stale objdirs left behind by a crash and delete
> +        * them.
> +        */
> +       strbuf_addf(&t->path, "%s/tmp_objdir-%s-XXXXXX", get_object_directory(), prefix);
>
>         /*
>          * Grow the strbuf beyond any filename we expect to be placed in it.
> @@ -269,6 +281,13 @@ int tmp_objdir_migrate(struct tmp_objdir *t)
>         if (!t)
>                 return 0;
>
> +       if (t->prev_odb) {
> +               if (the_repository->objects->odb->will_destroy)
> +                       BUG("migrating an ODB that was marked for destruction");
> +               restore_primary_odb(t->prev_odb, t->path.buf);
> +               t->prev_odb = NULL;
> +       }
> +
>         strbuf_addbuf(&src, &t->path);
>         strbuf_addstr(&dst, get_object_directory());
>
> @@ -292,3 +311,33 @@ void tmp_objdir_add_as_alternate(const struct tmp_objdir *t)
>  {
>         add_to_alternates_memory(t->path.buf);
>  }
> +
> +void tmp_objdir_replace_primary_odb(struct tmp_objdir *t, int will_destroy)
> +{
> +       if (t->prev_odb)
> +               BUG("the primary object database is already replaced");
> +       t->prev_odb = set_temporary_primary_odb(t->path.buf, will_destroy);
> +       t->will_destroy = will_destroy;
> +}
> +
> +struct tmp_objdir *tmp_objdir_unapply_primary_odb(void)
> +{
> +       if (!the_tmp_objdir || !the_tmp_objdir->prev_odb)
> +               return NULL;
> +
> +       restore_primary_odb(the_tmp_objdir->prev_odb, the_tmp_objdir->path.buf);
> +       the_tmp_objdir->prev_odb = NULL;
> +       return the_tmp_objdir;
> +}
> +
> +void tmp_objdir_reapply_primary_odb(struct tmp_objdir *t, const char *old_cwd,
> +               const char *new_cwd)
> +{
> +       char *path;
> +
> +       path = reparent_relative_path(old_cwd, new_cwd, t->path.buf);
> +       strbuf_reset(&t->path);
> +       strbuf_addstr(&t->path, path);
> +       free(path);
> +       tmp_objdir_replace_primary_odb(t, t->will_destroy);
> +}
> diff --git a/tmp-objdir.h b/tmp-objdir.h
> index b1e45b4c75d..a3145051f25 100644
> --- a/tmp-objdir.h
> +++ b/tmp-objdir.h
> @@ -10,7 +10,7 @@
>   *
>   * Example:
>   *
> - *     struct tmp_objdir *t = tmp_objdir_create();
> + *     struct tmp_objdir *t = tmp_objdir_create("incoming");
>   *     if (!run_command_v_opt_cd_env(cmd, 0, NULL, tmp_objdir_env(t)) &&
>   *         !tmp_objdir_migrate(t))
>   *             printf("success!\n");
> @@ -22,9 +22,10 @@
>  struct tmp_objdir;
>
>  /*
> - * Create a new temporary object directory; returns NULL on failure.
> + * Create a new temporary object directory with the specified prefix;
> + * returns NULL on failure.
>   */
> -struct tmp_objdir *tmp_objdir_create(void);
> +struct tmp_objdir *tmp_objdir_create(const char *prefix);
>
>  /*
>   * Return a list of environment strings, suitable for use with
> @@ -51,4 +52,26 @@ int tmp_objdir_destroy(struct tmp_objdir *);
>   */
>  void tmp_objdir_add_as_alternate(const struct tmp_objdir *);
>
> +/*
> + * Replaces the main object store in the current process with the temporary
> + * object directory and makes the former main object store an alternate.
> + * If will_destroy is nonzero, the object directory may not be migrated.
> + */
> +void tmp_objdir_replace_primary_odb(struct tmp_objdir *, int will_destroy);
> +
> +/*
> + * If the primary object database was replaced by a temporary object directory,
> + * restore it to its original value while keeping the directory contents around.
> + * Returns NULL if the primary object database was not replaced.
> + */
> +struct tmp_objdir *tmp_objdir_unapply_primary_odb(void);
> +
> +/*
> + * Reapplies the former primary temporary object database, after protentially
> + * changing its relative path.
> + */
> +void tmp_objdir_reapply_primary_odb(struct tmp_objdir *, const char *old_cwd,
> +               const char *new_cwd);
> +
> +
>  #endif /* TMP_OBJDIR_H */
> --
> gitgitgadget

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D167C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 13:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E3176140B
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 13:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbhGANIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 09:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbhGANIt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 09:08:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FFCC061756
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 06:06:18 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id c17so10215281ejk.13
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 06:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=2w7Gmili/HAU6480X/aGf8mwgqMOMWeMH5ry4AMnmGw=;
        b=sOC+1xhp1HaB0+ugC2Yy2XtcV1g1GaDukecmYMUmihuifDycVi/FNqZ1ERLgx8RM56
         7vK4EievXzn1WH61ZCH3BY3DbDiVwvKJViLBY1KIDMo/WW2xMM2Gm4qWANocYXyLujxG
         spIlV+m40b5/7t812+e8fi/Jnf1ufiPAN28eyNxdDM1ZjOsT/bMR/qpgyMTOlT+x31ZA
         RhqmvLzaDGrPIbxBwTHOsc+dp/0dpu9QrvlbhdE7y9OR5IUYiZJHaYyk19j0hNb2lu2X
         rbS+qyeBdPStAdDC6G07hMFsZYRlFjZBVdyQq3+toorAgE002ofMZEL/+lTz/JKTrhM+
         v2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=2w7Gmili/HAU6480X/aGf8mwgqMOMWeMH5ry4AMnmGw=;
        b=GzbDvrR0WZw6WBZzwTpbjmuPfUiu9jpXdwXzPC6d+a5AVJlpZYR5rOPp34YgyZAjlc
         kaPGRK50NuA5PndVT6kqPImQ5GuhtNzL5/M7d224rVVjT8KDOVXLW6JvozAroucCnJf3
         hcOsBTiJlCfjxFnf8w4K4fHUnNFCiOfUm+g+5wliV0Wb4ZWfh0jk4/otI4SneW/IhrHH
         v/J2x4xsF2NslUiwU6Z35bAva+vecYgmhfo5vOFH/ic4M3EZ0PoaYC+l+YNuirtzbsx3
         lrzMvKYeNgsAGeuZYGow78SjDQBf7Kop/d1w18dyjuU/eeJC724lco6Hx+jHoL25Y0Ow
         tAOw==
X-Gm-Message-State: AOAM533u5Zrx1SC5LsF0yDIC/x19LY1cGA7UPRzGziaoWA3AyZvcZ7t+
        0Eos2W78e0k38mLufhU34wlQrpe1yBddfQ==
X-Google-Smtp-Source: ABdhPJzfRdCMb3LCKztq6TJM4+Y+YIFUEdK+9I1nYQhH5t4qLFpDhoYSY2YOTbaHkYw4GZrQK/TZvA==
X-Received: by 2002:a17:906:7ad2:: with SMTP id k18mr25457131ejo.249.1625144776651;
        Thu, 01 Jul 2021 06:06:16 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id x16sm2693322edq.62.2021.07.01.06.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 06:06:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 8/8] refs: explicitly propagate errno from
 refs_read_raw_ref
Date:   Thu, 01 Jul 2021 14:26:11 +0200
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
 <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
 <2a9ebe43deac3da9baf241ff1e494f8210c27981.1623329869.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <2a9ebe43deac3da9baf241ff1e494f8210c27981.1623329869.git.gitgitgadget@gmail.com>
Message-ID: <8735sydvzs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 10 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> The function refs_resolve_ref_unsafe_with_errno should produce an errno output.
> Rather than taking the value from the errno (which might contain garbage
> beforehand), explicitly propagate the failure_errno coming out of
> refs_read_raw_ref().
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  refs.c | 38 ++++++++++++++------------------------
>  1 file changed, 14 insertions(+), 24 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 191cbf5a330f..92c4796078bb 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1686,11 +1686,11 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
>  					   type, failure_errno);
>  }
>  
> -/* This function needs to return a meaningful errno on failure */
> -static const char *
> -refs_resolve_ref_unsafe_implicit_errno(struct ref_store *refs,
> -				       const char *refname, int resolve_flags,
> -				       struct object_id *oid, int *flags)
> +const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
> +					       const char *refname,
> +					       int resolve_flags,
> +					       struct object_id *oid,
> +					       int *flags, int *failure_errno)
>  {

At this point I'm lost. We just introduced this function two commits
ago, and now it's gone again. I guess the "we should update the comment"
from an earlier reply of mine is addressed in some way here...

>  	static struct strbuf sb_refname = STRBUF_INIT;
>  	struct object_id unused_oid;
> @@ -1703,11 +1703,12 @@ refs_resolve_ref_unsafe_implicit_errno(struct ref_store *refs,

As an aside I really wish our hunk title detection would spot the rename
& use the new name...

>  		flags = &unused_flags;
>  
>  	*flags = 0;
> +	*failure_errno = 0;
>  
>  	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
>  		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
>  		    !refname_is_safe(refname)) {
> -			errno = EINVAL;
> +			*failure_errno = EINVAL;
>  			return NULL;
>  		}
>  
> @@ -1730,6 +1731,8 @@ refs_resolve_ref_unsafe_implicit_errno(struct ref_store *refs,
>  				      &read_flags, &read_failure)) {
>  			*flags |= read_flags;
>  
> +			*failure_errno = read_failure;
> +
>  			/* In reading mode, refs must eventually resolve */
>  			if (resolve_flags & RESOLVE_REF_READING)
>  				return NULL;
> @@ -1767,7 +1770,7 @@ refs_resolve_ref_unsafe_implicit_errno(struct ref_store *refs,
>  		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
>  			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
>  			    !refname_is_safe(refname)) {
> -				errno = EINVAL;
> +				*failure_errno = EINVAL;
>  				return NULL;
>  			}
>  
> @@ -1775,7 +1778,7 @@ refs_resolve_ref_unsafe_implicit_errno(struct ref_store *refs,
>  		}
>  	}
>  
> -	errno = ELOOP;
> +	*failure_errno = ELOOP;
>  	return NULL;
>  }
>  
> @@ -1783,22 +1786,9 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
>  				    int resolve_flags, struct object_id *oid,
>  				    int *flags)
>  {
> -	const char *result = refs_resolve_ref_unsafe_implicit_errno(
> -		refs, refname, resolve_flags, oid, flags);
> -	errno = 0;
> -	return result;
> -}
> -
> -const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
> -					       const char *refname,
> -					       int resolve_flags,
> -					       struct object_id *oid,
> -					       int *flags, int *failure_errno)
> -{
> -	const char *result = refs_resolve_ref_unsafe_implicit_errno(
> -		refs, refname, resolve_flags, oid, flags);
> -	*failure_errno = errno;
> -	return result;
> +	int ignore;
> +	return refs_resolve_ref_unsafe_with_errno(refs, refname, resolve_flags,
> +						  oid, flags, &ignore);
>  }

Okey, so here we have something like the "caller should explicitly
ignore it" I suggested in <878s2qdy8y.fsf@evledraar.gmail.com>. We no
longer set "errno" at all for the benefit of the callers of that
function, but instead explicitly throw it away, our
refs_resolve_ref_unsafe_with_errno() no longer sets errno.

But this end-state seems to have resulted in introducing new bugs. A
bunch of functions are thin wrappers for
refs_resolve_ref_unsafe(). Previously they could inspect errno on a -1
return, now they can't.

I didn't look at them all, but just the second one I looked at,
refs_read_ref_full() has a verify_lock() caller which calls it, and that
function then expects a meaningful errno that it in turn ferries up with
"can't verify ref". It in turn is called by lock_ref_oid_basic(), it
ferries up that strbuf with the error, which'll now have a meaningless
strerror(0) in it.

So it seems to me that the refactoring being done here is halfway done,
and results in a buggy end-state. The below diff is my attempt to fix
that up for just one caller, things thath call resolve_gitlink_ref()
(it's literally the third caller out of N, so I'm not picking and
choosing).

In that case I believe that we don't actually have a regression because
of your changes, but I think the changes below are the logical end-state
of what you're starting here. I.e. we have a low-level function that may
encounter an errno, and then callers removed from that via:

    index_path() -> resolve_gitlink_ref() -> refs_resolve_ref_unsafe()

Where the common case for index_path() is to report the error we got,
but it doesn't call die_errno() or error_errno() now, but really should,
per the below diff (which you can consider to have by SOB if you want to
pick it up).

That passes all tests, except one where we actually fail because of what
I'd argue is a better error message. i.e this in t3700-add.sh:
	
	+ diff -u expect actual
	--- expect      2021-07-01 13:01:23.267001881 +0000
	+++ actual      2021-07-01 13:01:23.267001881 +0000
	@@ -1,2 +1,2 @@
	-error: 'empty/' does not have a commit checked out
	+error: 'empty/' does not have a commit checked out: No such file or directory
	 fatal: adding files failed

In one sense I don't think you need to do this excercise of going all
the way to the top of callers like index_path() that don't get an errno
now, but in another sense I think you really do.

By explicitly clearing "errno" as your end-state does and declaring that
callers of refs_resolve_ref_unsafe() must be as happy to ignore "errno"
as your own callers are, you're potentially introducing subtle bugs
unless we go all the way to the top of the callstack and check if
anything above us cares about errno, which we'll need due to do due to
its global nature.

I think I'd really only be confident that we've got them all if your
chance was amended to something where we add such "int *maybe_errno"
parameters to all upstream callers that may relay the <0 return value we
got.

diff --git a/builtin/update-index.c b/builtin/update-index.c
index f1f16f2de52..54fcbc5be10 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -272,6 +272,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 {
 	int option;
 	struct cache_entry *ce;
+	int ignore_errno;
 
 	/* Was the old index entry already up-to-date? */
 	if (old && !ce_stage(old) && !ce_match_stat(old, st, 0))
@@ -285,7 +286,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 	ce->ce_mode = ce_mode_from_stat(old, st->st_mode);
 
 	if (index_path(&the_index, &ce->oid, path, st,
-		       info_only ? 0 : HASH_WRITE_OBJECT)) {
+		       info_only ? 0 : HASH_WRITE_OBJECT, &ignore_errno)) {
 		discard_cache_entry(ce);
 		return -1;
 	}
@@ -325,14 +326,15 @@ static int process_directory(const char *path, int len, struct stat *st)
 {
 	struct object_id oid;
 	int pos = cache_name_pos(path, len);
+	int their_errno = 0;
 
 	/* Exact match: file or existing gitlink */
 	if (pos >= 0) {
 		const struct cache_entry *ce = active_cache[pos];
 		if (S_ISGITLINK(ce->ce_mode)) {
-
 			/* Do nothing to the index if there is no HEAD! */
-			if (resolve_gitlink_ref(path, "HEAD", &oid) < 0)
+			int ignore_errno;
+			if (resolve_gitlink_ref(path, "HEAD", &oid, &ignore_errno) < 0)
 				return 0;
 
 			return add_one_path(ce, path, len, st);
@@ -358,11 +360,16 @@ static int process_directory(const char *path, int len, struct stat *st)
 	}
 
 	/* No match - should we add it as a gitlink? */
-	if (!resolve_gitlink_ref(path, "HEAD", &oid))
+	if (resolve_gitlink_ref(path, "HEAD", &oid, &their_errno) >= 0)
 		return add_one_path(NULL, path, len, st);
 
 	/* Error out. */
-	return error("%s: is a directory - add files inside instead", path);
+	if (their_errno) {
+		errno = their_errno;
+		return error_errno("%s: is a directory - add files inside instead", path);
+	} else {
+		return error("%s: is a directory - add files inside instead", path);
+	}
 }
 
 static int process_path(const char *path, struct stat *st, int stat_errno)
diff --git a/cache.h b/cache.h
index ba04ff8bd36..62e5ac335b8 100644
--- a/cache.h
+++ b/cache.h
@@ -879,7 +879,9 @@ int ie_modified(struct index_state *, const struct cache_entry *, struct stat *,
 #define HASH_FORMAT_CHECK 2
 #define HASH_RENORMALIZE  4
 int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
-int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
+int index_path(struct index_state *istate, struct object_id *oid,
+	       const char *path, struct stat *st, unsigned flags,
+	       int *maybe_errno);
 
 /*
  * Record to sd the data from st that we use to check whether a file
diff --git a/combine-diff.c b/combine-diff.c
index 7d925ce9ce4..7ac9bc6e943 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1059,7 +1059,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			elem->mode = canon_mode(st.st_mode);
 		} else if (S_ISDIR(st.st_mode)) {
 			struct object_id oid;
-			if (resolve_gitlink_ref(elem->path, "HEAD", &oid) < 0)
+			int ignore_errno;
+			if (resolve_gitlink_ref(elem->path, "HEAD", &oid, &ignore_errno) < 0)
 				result = grab_blob(opt->repo, &elem->oid,
 						   elem->mode, &result_size,
 						   NULL, NULL);
diff --git a/diff-lib.c b/diff-lib.c
index c2ac9250fe9..4ae27851cb9 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -40,6 +40,7 @@ static int check_removed(const struct index_state *istate, const struct cache_en
 		return 1;
 	if (S_ISDIR(st->st_mode)) {
 		struct object_id sub;
+		int ignore_errno;
 
 		/*
 		 * If ce is already a gitlink, we can have a plain
@@ -53,7 +54,7 @@ static int check_removed(const struct index_state *istate, const struct cache_en
 		 * a directory --- the blob was removed!
 		 */
 		if (!S_ISGITLINK(ce->ce_mode) &&
-		    resolve_gitlink_ref(ce->name, "HEAD", &sub))
+		    resolve_gitlink_ref(ce->name, "HEAD", &sub, &ignore_errno))
 			return 1;
 	}
 	return 0;
diff --git a/diff.c b/diff.c
index 52c791574b7..972ad0e57de 100644
--- a/diff.c
+++ b/diff.c
@@ -4426,6 +4426,7 @@ static void diff_fill_oid_info(struct diff_filespec *one, struct index_state *is
 {
 	if (DIFF_FILE_VALID(one)) {
 		if (!one->oid_valid) {
+			int maybe_errno = 0;
 			struct stat st;
 			if (one->is_stdin) {
 				oidclr(&one->oid);
@@ -4433,8 +4434,14 @@ static void diff_fill_oid_info(struct diff_filespec *one, struct index_state *is
 			}
 			if (lstat(one->path, &st) < 0)
 				die_errno("stat '%s'", one->path);
-			if (index_path(istate, &one->oid, one->path, &st, 0))
-				die("cannot hash %s", one->path);
+			if (index_path(istate, &one->oid, one->path, &st, 0, &maybe_errno)) {
+				if (maybe_errno) {
+					errno = maybe_errno;
+ 					die_errno("cannot hash %s", one->path);
+				} else {
+ 					die("cannot hash %s", one->path);
+				}
+			}
 		}
 	}
 	else
diff --git a/dir.c b/dir.c
index ebe5ec046e0..95eb4ada718 100644
--- a/dir.c
+++ b/dir.c
@@ -2967,9 +2967,10 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 	int only_empty = (flag & REMOVE_DIR_EMPTY_ONLY);
 	int keep_toplevel = (flag & REMOVE_DIR_KEEP_TOPLEVEL);
 	struct object_id submodule_head;
+	int ignore_errno;
 
 	if ((flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
-	    !resolve_gitlink_ref(path->buf, "HEAD", &submodule_head)) {
+	    resolve_gitlink_ref(path->buf, "HEAD", &submodule_head, &ignore_errno) < 0) {
 		/* Do not descend and nuke a nested git work tree. */
 		if (kept_up)
 			*kept_up = 1;
diff --git a/notes-merge.c b/notes-merge.c
index 46c1f7c7f11..f7e0091bd72 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -698,6 +698,7 @@ int notes_merge_commit(struct notes_merge_options *o,
 	while ((e = readdir_skip_dot_and_dotdot(dir)) != NULL) {
 		struct stat st;
 		struct object_id obj_oid, blob_oid;
+		int maybe_errno = 0;
 
 		if (get_oid_hex(e->d_name, &obj_oid)) {
 			if (o->verbosity >= 3)
@@ -710,8 +711,14 @@ int notes_merge_commit(struct notes_merge_options *o,
 		/* write file as blob, and add to partial_tree */
 		if (stat(path.buf, &st))
 			die_errno("Failed to stat '%s'", path.buf);
-		if (index_path(o->repo->index, &blob_oid, path.buf, &st, HASH_WRITE_OBJECT))
-			die("Failed to write blob object from '%s'", path.buf);
+		if (index_path(o->repo->index, &blob_oid, path.buf, &st, HASH_WRITE_OBJECT, &maybe_errno)) {
+			if (maybe_errno) {
+				errno = maybe_errno;
+				die_errno("Failed to write blob object from '%s'", path.buf);
+			} else {
+				die("Failed to write blob object from '%s'", path.buf);
+			}
+		}
 		if (add_note(partial_tree, &obj_oid, &blob_oid, NULL))
 			die("Failed to add resolved note '%s' to notes tree",
 			    path.buf);
diff --git a/object-file.c b/object-file.c
index f233b440b22..0030854dcdf 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2260,7 +2260,8 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 }
 
 int index_path(struct index_state *istate, struct object_id *oid,
-	       const char *path, struct stat *st, unsigned flags)
+	       const char *path, struct stat *st, unsigned flags,
+	       int *maybe_errno)
 {
 	int fd;
 	struct strbuf sb = STRBUF_INIT;
@@ -2286,7 +2287,7 @@ int index_path(struct index_state *istate, struct object_id *oid,
 		strbuf_release(&sb);
 		break;
 	case S_IFDIR:
-		return resolve_gitlink_ref(path, "HEAD", oid);
+		return resolve_gitlink_ref(path, "HEAD", oid, maybe_errno);
 	default:
 		return error(_("%s: unsupported file type"), path);
 	}
diff --git a/read-cache.c b/read-cache.c
index 77961a38854..a40a326587f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -256,6 +256,7 @@ static int ce_compare_link(const struct cache_entry *ce, size_t expected_size)
 static int ce_compare_gitlink(const struct cache_entry *ce)
 {
 	struct object_id oid;
+	int ignore_errno;
 
 	/*
 	 * We don't actually require that the .git directory
@@ -265,7 +266,7 @@ static int ce_compare_gitlink(const struct cache_entry *ce)
 	 *
 	 * If so, we consider it always to match.
 	 */
-	if (resolve_gitlink_ref(ce->name, "HEAD", &oid) < 0)
+	if (resolve_gitlink_ref(ce->name, "HEAD", &oid, &ignore_errno) < 0)
 		return 0;
 	return !oideq(&oid, &ce->oid);
 }
@@ -748,8 +749,13 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 
 	namelen = strlen(path);
 	if (S_ISDIR(st_mode)) {
-		if (resolve_gitlink_ref(path, "HEAD", &oid) < 0)
-			return error(_("'%s' does not have a commit checked out"), path);
+		int their_errno = 0;
+		if (resolve_gitlink_ref(path, "HEAD", &oid, &their_errno) < 0) {
+			if (their_errno)
+				return error_errno(_("'%s' does not have a commit checked out"), path);
+			else
+				return error(_("'%s' does not have a commit checked out"), path);
+		}
 		while (namelen && path[namelen-1] == '/')
 			namelen--;
 	}
@@ -799,9 +805,16 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		}
 	}
 	if (!intent_only) {
-		if (index_path(istate, &ce->oid, path, st, hash_flags)) {
+		int maybe_errno = 0;
+		if (index_path(istate, &ce->oid, path, st, hash_flags,
+			       &maybe_errno)) {
 			discard_cache_entry(ce);
-			return error(_("unable to index file '%s'"), path);
+			if (maybe_errno) {
+				errno = maybe_errno;
+				return error_errno(_("unable to index file '%s'"), path);
+			} else {
+				return error(_("unable to index file '%s'"), path);
+			}
 		}
 	} else
 		set_object_name_for_intent_to_add_entry(ce);
diff --git a/refs.c b/refs.c
index 92c4796078b..082b6b3d133 100644
--- a/refs.c
+++ b/refs.c
@@ -1807,7 +1807,7 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 }
 
 int resolve_gitlink_ref(const char *submodule, const char *refname,
-			struct object_id *oid)
+			struct object_id *oid, int *maybe_errno)
 {
 	struct ref_store *refs;
 	int flags;
@@ -1817,7 +1817,8 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
 	if (!refs)
 		return -1;
 
-	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags) ||
+	if (!refs_resolve_ref_unsafe_with_errno(refs, refname, 0, oid, &flags,
+		    maybe_errno) ||
 	    is_null_oid(oid))
 		return -1;
 	return 0;
diff --git a/refs.h b/refs.h
index 48970dfc7e0..b0505b35698 100644
--- a/refs.h
+++ b/refs.h
@@ -133,10 +133,16 @@ int peel_iterated_oid(const struct object_id *base, struct object_id *peeled);
  * Resolve refname in the nested "gitlink" repository in the specified
  * submodule (which must be non-NULL). If the resolution is
  * successful, return 0 and set oid to the name of the object;
- * otherwise, return a non-zero value.
+ * otherwise, return negative value.
+ *
+ * If we encounter an error we may have an errno to report from
+ * refs_resolve_ref_unsafe_with_errno(), or we might have hit another
+ * error. Set your `maybe_errno` to 0 beforehand, and check it after
+ * an error where we return a negative value to see if you should
+ * report the errno as well.
  */
 int resolve_gitlink_ref(const char *submodule, const char *refname,
-			struct object_id *oid);
+			struct object_id *oid, int *maybe_errno);
 
 /*
  * Return true iff abbrev_name is a possible abbreviation for
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 01c9bd0dbf0..9ed58c40de6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -870,6 +870,7 @@ static int verify_lock(struct ref_store *ref_store, struct ref_lock *lock,
 			       &lock->old_oid, NULL)) {
 		if (old_oid) {
 			int save_errno = errno;
+			BUG("got here");
 			strbuf_addf(err, "can't verify ref '%s'", lock->ref_name);
 			errno = save_errno;
 			return -1;
diff --git a/unpack-trees.c b/unpack-trees.c
index f88a69f8e71..dd90787c56c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1986,7 +1986,9 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 
 	if (S_ISGITLINK(ce->ce_mode)) {
 		struct object_id oid;
-		int sub_head = resolve_gitlink_ref(ce->name, "HEAD", &oid);
+		int ignore_errno;
+		int sub_head = resolve_gitlink_ref(ce->name, "HEAD", &oid,
+						   &ignore_errno);
 		/*
 		 * If we are not going to update the submodule, then
 		 * we don't care.

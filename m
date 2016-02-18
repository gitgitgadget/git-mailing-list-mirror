From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 25/27] refs: add LMDB refs storage backend
Date: Thu, 18 Feb 2016 15:50:23 +0700
Message-ID: <20160218085023.GA30049@lanh>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
 <1455772670-21142-26-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 09:50:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWKHn-0002be-Rw
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 09:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425260AbcBRIuC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 03:50:02 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35252 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965386AbcBRIuA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 03:50:00 -0500
Received: by mail-pf0-f176.google.com with SMTP id c10so28529059pfc.2
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 00:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LfTySRaH7YbU2iy+wJ/6/slieYW2UHIBzG4Nqq1eWr8=;
        b=SnPv+Ffw9JGLqCFZzj0xgGkaJLEkzZoY6/9wBazV9XvFopjjRuvXmAHJkavjaXeWw+
         GTje14P+Pr9y3eARaXXawZBw+2UqGg64ab0R4HN3ZbaPNCnh8F51O1bOKWV5ErT7A0Zq
         qpuVgytYRvVFmcdHQzvQ/c1uRyxgRM33zba2Ev5YDitX4OYKnDXuTO+SixnDL7JycPOg
         QVRFHXq/hfofAeaI64Lqt9bjkkWFE3vs2QR3g1ladwJOKS+gioclRcQMsJjaaX88cpII
         gMb8UBGZhznhFIpl/3pr7ZfSS1v5HxgEBHbo0uNop+iFuXYJPfsd8h+da+VFxpQSeCdp
         bWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=LfTySRaH7YbU2iy+wJ/6/slieYW2UHIBzG4Nqq1eWr8=;
        b=JofWwsVphclqwDSWA7qkJJGiA6Crj5Pbv4y3jPLcaubDBfJ1c7lX+4GFjagoqnPNK2
         cbxDeugLyHILxnq6dpmGOgrKxzsYdJv7v0HOe4gS0eLThLaSRFEenk2Bjfof9l7nVAUU
         YDwCuAIh87XR1ZqGP29Khmwm8F9NnFJxDYo5x1JaFfpZu+6oV6N6HGKjJGrpSkDlg0Ux
         KtwPhf+Bg5/ZviogzUsqeoVPr5Hnxnv7K6f3uKlEy0U5opGvCB58kZqFZCL2po8ZSzu5
         ATDRR/N06Rl8YZ6S5UBLckroHpFz5g7iROEwKezxKsuuKTrZfx9H10LGd/vAI/T1Ww2j
         rE1w==
X-Gm-Message-State: AG10YOQxttcRfRu9LTcJeZFXkEoq+G008mJ7kUWiKN+s/sStpFb6Qsoh9gol915dos5dVQ==
X-Received: by 10.98.70.211 with SMTP id o80mr8283533pfi.124.1455785399614;
        Thu, 18 Feb 2016 00:49:59 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id 76sm8305481pft.44.2016.02.18.00.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Feb 2016 00:49:57 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 18 Feb 2016 15:50:23 +0700
Content-Disposition: inline
In-Reply-To: <1455772670-21142-26-git-send-email-dturner@twopensource.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286603>

Caveat: I did not study how to use lmdb. I just guessed what it does
based on function names. I don't know much about refs handling either
(especially since the transaction thing is introduced)

> diff --git a/Documentation/technical/refs-lmdb-backend.txt b/Documentation/technical/refs-lmdb-backend.txt
> new file mode 100644
> index 0000000..eb81465
> --- /dev/null
> +++ b/Documentation/technical/refs-lmdb-backend.txt
> +Reflog values are in the same format as the original files-based
> +reflog, including the trailing LF. The date in the reflog value
> +matches the date in the timestamp field.

..except that SHA-1s are stored in raw values instead of hex strings.

> diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
> index 00ad379..fca5ecd 100644
> --- a/Documentation/technical/repository-version.txt
> +++ b/Documentation/technical/repository-version.txt
> @@ -86,3 +86,8 @@ for testing format-1 compatibility.
>  When the config key `extensions.preciousObjects` is set to `true`,
>  objects in the repository MUST NOT be deleted (e.g., by `git-prune` or
>  `git repack -d`).
> +
> +`refStorage`
> +~~~~~~~~~~~~
> +This extension allows the use of alternate ref storage backends.  The
> +only defined value is `lmdb`.

refStorage accepts empty string and `files` as well, should probably
be worth mentioning.

> diff --git a/refs/lmdb-backend.c b/refs/lmdb-backend.c
> +#include "../cache.h"
> +#include <lmdb.h>
> +#include "../object.h"
> +#include "../refs.h"
> +#include "refs-internal.h"
> +#include "../tag.h"
> +#include "../lockfile.h"

I'm quite sure we don't need "../". We have plenty of source files in
subdirs and many of them (haven't checked all) just go with
#include "cache.h".

> +struct lmdb_transaction transaction;

static?

> +
> +static int in_write_transaction(void)
> +{
> +	return transaction.txn && !(transaction.flags & MDB_RDONLY);
> +}
> +
> +static void init_env(MDB_env **env, const char *path)
> +{
> +	int ret;
> +	if (*env)
> +		return;
> +
> +	assert(path);
> +
> +	ret = mdb_env_create(env);
> +	if (ret)
> +		die("BUG: mdb_env_create failed: %s", mdb_strerror(ret));
> +	ret = mdb_env_set_maxreaders(*env, 1000);
> +	if (ret)
> +		die("BUG: mdb_env_set_maxreaders failed: %s", mdb_strerror(ret));
> +	ret = mdb_env_set_mapsize(*env, (1<<30));
> +	if (ret)
> +		die("BUG: mdb_set_mapsize failed: %s", mdb_strerror(ret));
> +	ret = mdb_env_open(*env, path, 0 , 0664);

This permission makes me wonder if we need adjust_shared_perm() here
and some other places.

> +	if (ret)
> +		die("BUG: mdb_env_open (%s) failed: %s", path,
> +		    mdb_strerror(ret));
> +}
> +
> +static int lmdb_init_db(int shared, struct strbuf *err)
> +{
> +	/*
> +	 * To create a db, all we need to do is make a directory for
> +	 * it to live in; lmdb will do the rest.
> +	 */
> +
> +	if (!db_path)
> +		db_path = xstrdup(real_path(git_path("refs.lmdb")));
> +
> +	if (mkdir(db_path, 0775) && errno != EEXIST) {
> +		strbuf_addf(err, "%s", strerror(errno));

maybe strbuf_addstr, unless want to add something more, "mkdir failed"?

> +static int read_per_worktree_ref(const char *submodule, const char *refname,
> +				 struct MDB_val *val, int *needs_free)

>From what I read, I suspect these _per_worktree functions will be
identical for the next backend. Should we just hand over the job for
files backend? For all entry points that may deal with per-worktree
refs, e.g. lmdb_resolve_ref_unsafe, can we check ref_type() first
thing, if it's per-worktree we call refs_be_files.resolve_ref_unsafe()
instead?  It could even be done at frontend level,
e.g. refs.c:resolve_ref_unsafe().

Though I may be talking rubbish here because I don't know how whether
it has anything to do with transactions.

> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	struct strbuf path = STRBUF_INIT;
> +	struct stat st;
> +	int ret = -1;
> +
> +	submodule_path(&path, submodule, refname);
> +
> +#ifndef NO_SYMLINK_HEAD

It started with the compiler warns about unused "st" when this macro
is defined. Which makes me wonder, should we do something like this to
make sure this code compiles unconditionally?

+#ifndef NO_SYMLINK_HEAD
+       int no_symlink_head = 0;
+#else
+       int no_symlink_head = 1;
+#endif
...
+       if (!no_symlink_head) {
...


> +int lmdb_transaction_begin_flags(struct strbuf *err, unsigned int flags)

static?

> +#define MAXDEPTH 5
> +
> +static const char *parse_ref_data(struct lmdb_transaction *transaction,
> +				  const char *refname, const char *ref_data,
> +				  unsigned char *sha1, int resolve_flags,
> +				  int *flags, int bad_name)
> +{
> +	int depth = MAXDEPTH;
> +	const char *buf;
> +	static struct strbuf refname_buffer = STRBUF_INIT;
> +	static struct strbuf refdata_buffer = STRBUF_INIT;
> +	MDB_val key, val;
> +	int needs_free = 0;
> +
> +	for (;;) {
> +		if (--depth < 0)
> +			return NULL;
> +
> +		if (!starts_with(ref_data, "ref:")) {
> +			if (get_sha1_hex(ref_data, sha1) ||
> +			    (ref_data[40] != '\0' && !isspace(ref_data[40]))) {
> +				if (flags)
> +					*flags |= REF_ISBROKEN;
> +				errno = EINVAL;
> +				return NULL;
> +			}
> +
> +			if (bad_name) {
> +				hashclr(sha1);
> +				if (flags)
> +					*flags |= REF_ISBROKEN;
> +			} else if (is_null_sha1(sha1)) {
> +				if (flags)
> +					*flags |= REF_ISBROKEN;
> +			}
> +			return refname;
> +		}
> +		if (flags)
> +			*flags |= REF_ISSYMREF;
> +		buf = ref_data + 4;
> +		while (isspace(*buf))
> +			buf++;
> +		strbuf_reset(&refname_buffer);
> +		strbuf_addstr(&refname_buffer, buf);
> +		refname = refname_buffer.buf;
> +		if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
> +			hashclr(sha1);
> +			return refname;
> +		}
> +		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
> +			if (flags)
> +				*flags |= REF_ISBROKEN;
> +
> +			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
> +			    !refname_is_safe(buf)) {
> +				errno = EINVAL;
> +				return NULL;
> +			}
> +			bad_name = 1;
> +		}

This code looks a lot like near the end of resolve_ref_1(). Maybe we
could share the code in refs/backend-common.c or something and call
here instead?

> +static const char *resolve_ref_unsafe_txn(struct lmdb_transaction *transaction,
> +					  const char *refname,
> +					  int resolve_flags,
> +					  unsigned char *sha1,
> +					  int *flags)
> +{
...
> +	if (flags)
> +		*flags = 0;
> +
> +	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
> +		if (flags)
> +			*flags |= REF_BAD_NAME;
> +
> +		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
> +		    !refname_is_safe(refname)) {
> +			errno = EINVAL;
> +			return NULL;
> +		}
> +		/*
> +		 * dwim_ref() uses REF_ISBROKEN to distinguish between
> +		 * missing refs and refs that were present but invalid,
> +		 * to complain about the latter to stderr.
> +		 *
> +		 * We don't know whether the ref exists, so don't set
> +		 * REF_ISBROKEN yet.
> +		 */
> +		bad_name = 1;
> +	}

This code too.

> +static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *cb_data)
> +{
> +	unsigned char osha1[20], nsha1[20];
> +	char *email_end, *message;
> +	unsigned long timestamp;
> +	int tz;
> +
> +	/* old (raw sha) new (raw sha) name <email> SP time TAB msg LF */

Hmm.. since you're going with raw sha-1, this is clearly not a text
string anymore, any reason to still keep LF at the end?

> +static int lmdb_delete_reflog(const char *refname)
> +{
> +	MDB_val key, val;
> +	char *log_path;
> +	int len;
> +	MDB_cursor *cursor;
> +	int ret = 0;
> +	int mdb_ret;
> +	struct strbuf err = STRBUF_INIT;
> +	int in_transaction;
> +
> +	if (ref_type(refname) != REF_TYPE_NORMAL)
> +		return refs_be_files.delete_reflog(refname);

Yay.. delegating work to files backend. I still think doing this in
refs.c:delete_reflog() may be a good idea.

> +int lmdb_reflog_expire(const char *refname, const unsigned char *sha1,

static?

> +static int lmdb_create_symref(const char *ref_target,
> +			      const char *refs_heads_master,
> +			      const char *logmsg)
> +{
> +
...
> +	mdb_put_or_die(&transaction, &key, &val, 0);
> +
> +	/* TODO: Don't create ref d/f conflicts */

I'm not sure I get this comment. D/F conflicts are no longer a thing
for lmdb backend, right?

> +MDB_env *submodule_txn_begin(struct lmdb_transaction *transaction)

static?

> +{
> +	int ret;
> +	MDB_env *submodule_env = NULL;
> +	struct strbuf path = STRBUF_INIT;
> +
> +	strbuf_git_path_submodule(&path, transaction->submodule, "refs.lmdb");
> +
> +	if (!is_directory(path.buf))
> +		goto done;
> +
> +	mkdir(path.buf, 0775);

A few other places where mkdir() is called, we may need to
adjust_shared_perm().

> diff --git a/setup.c b/setup.c
> index 1a62277..00625ab 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -279,7 +279,7 @@ int ref_storage_backend_config(const char *var, const char *value, void *ptr)
>   *
>   *  - either an objects/ directory _or_ the proper
>   *    GIT_OBJECT_DIRECTORY environment variable
> - *  - a refs/ directory
> + *  - a refs.lmdb/ directory or a refs/ directory
>   *  - either a HEAD symlink or a HEAD file that is formatted as
>   *    a proper "ref:", or a regular file HEAD that has a properly
>   *    formatted sha1 object name.
> @@ -313,8 +313,13 @@ int is_git_directory(const char *suspect)
>  
>  	strbuf_setlen(&path, len);
>  	strbuf_addstr(&path, "/refs");
> -	if (access(path.buf, X_OK))
> -		goto done;
> +
> +	if (access(path.buf, X_OK)) {
> +		strbuf_setlen(&path, len);
> +		strbuf_addstr(&path, "/refs.lmdb");
> +		if (access(path.buf, X_OK))
> +			goto done;
> +	}
>

I think it's ok leaving this function unmodified, which means "refs"
directory will always be there and "refs.lmdb" does not matter. If
somehow "refs" is deleted, old binaries get confused anyway so we
can't delete it.

> @@ -1089,8 +1089,11 @@ static int refs_from_alternate_cb(struct alternate_object_database *e,
>  		goto out;
>  	/* Is this a git repository with refs? */
>  	memcpy(other + len - 8, "/refs", 6);
> -	if (!is_directory(other))
> -		goto out;
> +	if (!is_directory(other)) {
> +		memcpy(other + len - 8, "/refs.lmdb", 11);
> +		if (!is_directory(other))
> +			goto out;
> +	}

and probably the same here. I have no idea what this code does though,
but if it's about detecting git directory, it should call
is_git_directory() instead.

>  	other[len - 8] = '\0';
>  	remote = remote_get(other);
>  	transport = transport_get(remote, other);
--
Duy
